Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E026C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A9F32070A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595263663;
	bh=eIg5zlpARQ0ncoOVYVLpaBxwWN3Nt8ngvgaUr4OFHAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xUPquoiEE6lKHh2/5no9vKNRC+RzBZ0cKe6LUJg3RXXwnqBCmj4RNdQ60EOg37CKm
	 wIBNCSFNoWM1FkxfgmsGT3EuS6na391Wa0UPacK0Xm3qVeeN8Zdo0gnzPdH24L0JNJ
	 W5IOBlRx1pxCZck6MLsMNWOXJIBh/zoJ5i015zF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389124AbgGTQrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:47:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729444AbgGTPjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:39:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 613CD22CAF;
        Mon, 20 Jul 2020 15:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259558;
        bh=eIg5zlpARQ0ncoOVYVLpaBxwWN3Nt8ngvgaUr4OFHAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=raAgnlNkWFtjhsjKJLSAfjAPtZ2AVdd3JvuutBALKmM6DbB0osoroItbX9IrxKB5g
         rmIjWFpS+ZHP6OGe/ybuXoO9rHWpwe31rgW2c4ha7YxxzLsAmOzkQKaSqu8xivR7uc
         lMtIVsM93sc9y2z8h+iurPtH7OFni9cjy6K8W2DA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Esben Haabendal <esben@geanix.com>
Subject: [PATCH 4.4 53/58] uio_pdrv_genirq: fix use without device tree and no interrupt
Date:   Mon, 20 Jul 2020 17:37:09 +0200
Message-Id: <20200720152749.917907260@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152747.127988571@linuxfoundation.org>
References: <20200720152747.127988571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Esben Haabendal <esben@geanix.com>

commit bf12fdf0ab728ca8e5933aac46dd972c0dd0421e upstream.

While e3a3c3a20555 ("UIO: fix uio_pdrv_genirq with device tree but no
interrupt") added support for using uio_pdrv_genirq for devices without
interrupt for device tree platforms, the removal of uio_pdrv in
26dac3c49d56 ("uio: Remove uio_pdrv and use uio_pdrv_genirq instead")
broke the support for non device tree platforms.

This change fixes this, so that uio_pdrv_genirq can be used without
interrupt on all platforms.

This still leaves the support that uio_pdrv had for custom interrupt
handler lacking, as uio_pdrv_genirq does not handle it (yet).

Fixes: 26dac3c49d56 ("uio: Remove uio_pdrv and use uio_pdrv_genirq instead")
Signed-off-by: Esben Haabendal <esben@geanix.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200701145659.3978-3-esben@geanix.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/uio/uio_pdrv_genirq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/uio/uio_pdrv_genirq.c
+++ b/drivers/uio/uio_pdrv_genirq.c
@@ -148,7 +148,7 @@ static int uio_pdrv_genirq_probe(struct
 	if (!uioinfo->irq) {
 		ret = platform_get_irq(pdev, 0);
 		uioinfo->irq = ret;
-		if (ret == -ENXIO && pdev->dev.of_node)
+		if (ret == -ENXIO)
 			uioinfo->irq = UIO_IRQ_NONE;
 		else if (ret < 0) {
 			dev_err(&pdev->dev, "failed to get IRQ\n");


