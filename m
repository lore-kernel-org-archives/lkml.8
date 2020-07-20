Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A52C433F1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6921B22CBE
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261032;
	bh=0uBp3CBx2tPoVfNeFPDXbBHpAy3+P7VnEG9csYFESws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A3hdPhJ9o6WiK8AcciTWoSul0DNgseCduh0SBtMbYbQ0YsVtRmz+gCJ/8sosLH4Lc
	 RGSY2ZIZbN2FVEBi5lqC+Z/c7Xb+KtBfTuJtX9sdJX5yN39VwjoADabL/lbwN4f9lI
	 CCgafhkX7nmZQvKpP75+dpDdRTQMHQaDXtVKK/z0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732769AbgGTQDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:03:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731398AbgGTQDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:03:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B341C20684;
        Mon, 20 Jul 2020 16:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261021;
        bh=0uBp3CBx2tPoVfNeFPDXbBHpAy3+P7VnEG9csYFESws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ejJszzHaoXFv7F/LqHfGrBN+Z+AgA2228YQGJqVmT48OKxnnXNc1SyprbQkYPPDg4
         nFrJtjY1cXxGJfTl3rBGZZTlu7um3X8nUy1fYmZgRxt0OZc5bFiMgscvjpeMBnieua
         4vEc5oEnTJUU13tQAPkesma9fXcTu/t83HqJZ0qU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Esben Haabendal <esben@geanix.com>
Subject: [PATCH 5.4 181/215] uio_pdrv_genirq: fix use without device tree and no interrupt
Date:   Mon, 20 Jul 2020 17:37:43 +0200
Message-Id: <20200720152828.785319431@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152820.122442056@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
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
@@ -154,7 +154,7 @@ static int uio_pdrv_genirq_probe(struct
 	if (!uioinfo->irq) {
 		ret = platform_get_irq_optional(pdev, 0);
 		uioinfo->irq = ret;
-		if (ret == -ENXIO && pdev->dev.of_node)
+		if (ret == -ENXIO)
 			uioinfo->irq = UIO_IRQ_NONE;
 		else if (ret < 0) {
 			dev_err(&pdev->dev, "failed to get IRQ\n");


