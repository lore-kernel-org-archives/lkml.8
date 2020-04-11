Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1CDC2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1A4206A1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607766;
	bh=kfOk+9dx47qbYaUDVrI+6uLc01OV3jr9KE0vpysdgaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jed7yjOZUavZzWJzi7u9Ck2Hf0ZuB7aaiU7vfp+ZZVWrsA4/wI04Blcb7cZMBQ4CI
	 uSyKvs0CxpOC963YvrYnhkzF33V5G22WHM+/E+UEjabmxqNwcDXs8Z6xvTOCZ7FW47
	 yewle6UfeIY8drcP+3PJPsnk+/0M3iRzfqiVgoGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgDKMUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:20:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728543AbgDKMUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:20:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E07D20644;
        Sat, 11 Apr 2020 12:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607643;
        bh=kfOk+9dx47qbYaUDVrI+6uLc01OV3jr9KE0vpysdgaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZN+/VMLPmnMGgBeVeRvcXabXB+XGW/Z3YFk9HRSinLckhpKjsrAh3qRuWAupI0d+M
         bJ9i7JyCGjQdVExS3wsoLdsBpOL9uN84miMO7qMfXQSzojvB9mcTsUjzALAARWf8AC
         Rw9A9ljgDH6axRlVog1Y9A6sxSyP3YKBBFqIiCvM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thinh Nguyen <thinhn@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 5.6 18/38] usb: dwc3: gadget: Wrap around when skip TRBs
Date:   Sat, 11 Apr 2020 14:09:55 +0200
Message-Id: <20200411115501.133149219@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115459.324496182@linuxfoundation.org>
References: <20200411115459.324496182@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

commit 2dedea035ae82c5af0595637a6eda4655532b21e upstream.

When skipping TRBs, we need to account for wrapping around the ring
buffer and not modifying some invalid TRBs. Without this fix, dwc3 won't
be able to check for available TRBs.

Cc: stable <stable@vger.kernel.org>
Fixes: 7746a8dfb3f9 ("usb: dwc3: gadget: extract dwc3_gadget_ep_skip_trbs()")
Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/gadget.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1521,7 +1521,7 @@ static void dwc3_gadget_ep_skip_trbs(str
 	for (i = 0; i < req->num_trbs; i++) {
 		struct dwc3_trb *trb;
 
-		trb = req->trb + i;
+		trb = &dep->trb_pool[dep->trb_dequeue];
 		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
 		dwc3_ep_inc_deq(dep);
 	}


