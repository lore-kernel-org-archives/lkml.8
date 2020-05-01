Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E416BC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA5D82173E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588339622;
	bh=JyKPbUi+7fIQGEbYVTLY+DWyPmwJghq8tvGOTZssA5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pKpvkTKPoTvVISVZwl24pcANAsiunaGBd63tmCiXVrkJblUDLEEmytmAKIRWlJcY9
	 35mq8kuJYo/FhaQxSE0/i7pNZ5e6FoIHH0uXto8DJyrFJKPQ6l3qHGx7D+wXEASVeB
	 XJzZJdb8MAtZ6338x+/Ldns6Dgi0MUHhvZ8TEqpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgEAN1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:27:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729363AbgEAN04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:26:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BC8E24958;
        Fri,  1 May 2020 13:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339615;
        bh=JyKPbUi+7fIQGEbYVTLY+DWyPmwJghq8tvGOTZssA5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c7PkdTamkMVJ84t/YR8QiMAKPVbht6MeK8SEHyUP4y/Q0xNbLhfxULJjM26k6pz+C
         MHQReCFtBheWHzk5QCzJCcG9R5x2iqM0fU6ZeXvEc0PwPEe+ygjmUlIg49lw1zEF8l
         GdqtMtVbo74whETwAkB85RlkWBR9cbnHd9E4bsRg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>, Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 4.4 48/70] staging: comedi: Fix comedi_device refcnt leak in comedi_open
Date:   Fri,  1 May 2020 15:21:36 +0200
Message-Id: <20200501131528.111031752@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131513.302599262@linuxfoundation.org>
References: <20200501131513.302599262@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>

commit 332e0e17ad49e084b7db670ef43b5eb59abd9e34 upstream.

comedi_open() invokes comedi_dev_get_from_minor(), which returns a
reference of the COMEDI device to "dev" with increased refcount.

When comedi_open() returns, "dev" becomes invalid, so the refcount
should be decreased to keep refcount balanced.

The reference counting issue happens in one exception handling path of
comedi_open(). When "cfp" allocation is failed, the refcnt increased by
comedi_dev_get_from_minor() is not decreased, causing a refcnt leak.

Fix this issue by calling comedi_dev_put() on this error path when "cfp"
allocation is failed.

Fixes: 20f083c07565 ("staging: comedi: prepare support for per-file read and write subdevices")
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/1587361459-83622-1-git-send-email-xiyuyang19@fudan.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/comedi/comedi_fops.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -2592,8 +2592,10 @@ static int comedi_open(struct inode *ino
 	}
 
 	cfp = kzalloc(sizeof(*cfp), GFP_KERNEL);
-	if (!cfp)
+	if (!cfp) {
+		comedi_dev_put(dev);
 		return -ENOMEM;
+	}
 
 	cfp->dev = dev;
 


