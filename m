Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DC6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D211E2098B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592331932;
	bh=L6sqfSgBmHN66ThR9qZuIm62kdJIyo1PoHR5cx2mp0Y=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=zB4P4B7rFc90n//F/HpfFzSk7lSYoswJEmqQdwz1xq542QykOCOrYVQuz8kbF4Y/N
	 th/kjkflOJMT3Hdl82rQcz2D2DvIgqMiPSWjB+RxDzyVpvMPunOVjQcILz5rjFoErI
	 c/iWLvWpYm86RVyqY6qaPI7BqeIi+l3/O/kIfYLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730604AbgFPSZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:25:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbgFPSZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:25:31 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8716E208D5;
        Tue, 16 Jun 2020 18:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592331931;
        bh=L6sqfSgBmHN66ThR9qZuIm62kdJIyo1PoHR5cx2mp0Y=;
        h=Date:From:To:Cc:Subject:From;
        b=eI5ha4zAruoT/Y0qoOY1+oRtaQhwhz101rJzQqnQRbw/6vp2GT74yCrUyjlXt64L2
         AHe49xwkrQwD8R8B94fluOqsraWpgSaAa3YOxPoyD10ndvZggNtpvxWWJuEN1aJeuk
         pjFtVwwAxRjQyzyP0ASgHq3pcpADDSp79MzgVKaI=
Date:   Tue, 16 Jun 2020 13:30:50 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH][next] rapidio/rio_mport_cdev: Use array_size() helper in
 copy_{from,to}_user()
Message-ID: <20200616183050.GA31840@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use array_size() helper instead of the open-coded version in
copy_{from,to}_user(). These sorts of multiplication factors
need to be wrapped in array_size().

This issue was found with the help of Coccinelle and, audited
and fixed manually.

Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/rapidio/devices/rio_mport_cdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 451608e960a1..6943459f8ac2 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -981,7 +981,7 @@ static int rio_mport_transfer_ioctl(struct file *filp, void __user *arg)
 
 	if (unlikely(copy_from_user(transfer,
 				    (void __user *)(uintptr_t)transaction.block,
-				    transaction.count * sizeof(*transfer)))) {
+				    array_size(sizeof(*transfer), transaction.count)))) {
 		ret = -EFAULT;
 		goto out_free;
 	}
@@ -994,7 +994,7 @@ static int rio_mport_transfer_ioctl(struct file *filp, void __user *arg)
 
 	if (unlikely(copy_to_user((void __user *)(uintptr_t)transaction.block,
 				  transfer,
-				  transaction.count * sizeof(*transfer))))
+				  array_size(sizeof(*transfer), transaction.count))))
 		ret = -EFAULT;
 
 out_free:
-- 
2.27.0

