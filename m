Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E585C28E83
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8BF820767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598978282;
	bh=uZ2cKxuigQGTZJA16yFuIuvZhEK5XCUeHR7VZ6noavE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FiogmfaUKZRjLPJZHLq3fwexI0ii/KANR+kdYEG1dHo2iIQegg4JGzQLLqkvr7gl5
	 IBNaTyAXZ2DQAAwbN98Jc+WOrIJIGLNcN8mNBq3pE8gfnJyNtSkFGj3uyrBqGqZPE/
	 sl6YYyN8nmF5lXuSYgZT2MFfElFF6GWRrOIIDSo4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbgIAP26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730067AbgIAPZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:25:50 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A11920684;
        Tue,  1 Sep 2020 15:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973950;
        bh=uZ2cKxuigQGTZJA16yFuIuvZhEK5XCUeHR7VZ6noavE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TWC5B2m+x8qM45Us3g8Gxfwv+v1wWBcxoK5cbtqPPBBOI0ApMseWUQhQzMkvZ9Bjk
         kigDJI+qYt83Y+XqddfFBuvOFxibglDlvoIgN9teqpDPqYOM8/okmjjkivk+p6tfQj
         DXioZubVPuALfccOn0/XDupnCePmS4KvAp4wQvbA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brice Goglin <brice.goglin@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Cyril Roelandt <tipecaml@gmail.com>
Subject: [PATCH 4.19 112/125] USB: Ignore UAS for JMicron JMS567 ATA/ATAPI Bridge
Date:   Tue,  1 Sep 2020 17:11:07 +0200
Message-Id: <20200901150940.103878011@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150934.576210879@linuxfoundation.org>
References: <20200901150934.576210879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cyril Roelandt <tipecaml@gmail.com>

commit 9aa37788e7ebb3f489fb4b71ce07adadd444264a upstream.

This device does not support UAS properly and a similar entry already
exists in drivers/usb/storage/unusual_uas.h. Without this patch,
storage_probe() defers the handling of this device to UAS, which cannot
handle it either.

Tested-by: Brice Goglin <brice.goglin@gmail.com>
Fixes: bc3bdb12bbb3 ("usb-storage: Disable UAS on JMicron SATA enclosure")
Acked-by: Alan Stern <stern@rowland.harvard.edu>
CC: <stable@vger.kernel.org>
Signed-off-by: Cyril Roelandt <tipecaml@gmail.com>
Link: https://lore.kernel.org/r/20200825212231.46309-1-tipecaml@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/storage/unusual_devs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -2328,7 +2328,7 @@ UNUSUAL_DEV(  0x357d, 0x7788, 0x0114, 0x
 		"JMicron",
 		"USB to ATA/ATAPI Bridge",
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
-		US_FL_BROKEN_FUA ),
+		US_FL_BROKEN_FUA | US_FL_IGNORE_UAS ),
 
 /* Reported by Andrey Rahmatullin <wrar@altlinux.org> */
 UNUSUAL_DEV(  0x4102, 0x1020, 0x0100,  0x0100,


