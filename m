Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1432C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F042064C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579218241;
	bh=s74q2vs0Pm/TZ/Gqkd/YCzfn1ZB1h0PHMDmLnjAnEsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dXB0vrcAdb1AEGAjeEQIk/qo4zAVbzNA2O9SI1XjHCLFJQMHkGCSfdAPHgpr5aeEE
	 T0OQ/estc3LbUur3fjsYKZDKgwHBDaUbZc7wY5Jm+8jzL6csiTNYSlIyFgQlG0mOEl
	 vT654nGQ7V0qavZlb3u7GJDAOafHsO0EveGLUSR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388241AbgAPXn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:43:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:53694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387656AbgAPXYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:24:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D58B82075B;
        Thu, 16 Jan 2020 23:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217074;
        bh=s74q2vs0Pm/TZ/Gqkd/YCzfn1ZB1h0PHMDmLnjAnEsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qep5xNjtq2oUruJqVZxqUrTy/Ebs1uL0c2x1rI3uJwitnvCya67/1pb0SEr0wIaoJ
         LO20obMR3uZRdNR/xqT8kkqI/BWcnYIZipwIWpHoj46ffgkhmNFoBRHMt4K3ZUjGYw
         XPWravIG1Ec6GvISIFqwhTeIcln+zDhykxZs9x2Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Stephen Boyd <swboyd@chromium.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 5.4 121/203] pinctrl: sh-pfc: Do not use platform_get_irq() to count interrupts
Date:   Fri, 17 Jan 2020 00:17:18 +0100
Message-Id: <20200116231755.888490098@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit ad7fe1a1a35994a201497443b5140bf54b074cca upstream.

As platform_get_irq() now prints an error when the interrupt does not
exist, counting interrupts by looping until failure causes the printing
of scary messages like:

    sh-pfc e6060000.pin-controller: IRQ index 0 not found

Fix this by using the platform_irq_count() helper instead.

Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to platform_get_irq*()")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/20191016142601.28255-1-geert+renesas@glider.be
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/sh-pfc/core.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -29,12 +29,12 @@
 static int sh_pfc_map_resources(struct sh_pfc *pfc,
 				struct platform_device *pdev)
 {
-	unsigned int num_windows, num_irqs;
 	struct sh_pfc_window *windows;
 	unsigned int *irqs = NULL;
+	unsigned int num_windows;
 	struct resource *res;
 	unsigned int i;
-	int irq;
+	int num_irqs;
 
 	/* Count the MEM and IRQ resources. */
 	for (num_windows = 0;; num_windows++) {
@@ -42,17 +42,13 @@ static int sh_pfc_map_resources(struct s
 		if (!res)
 			break;
 	}
-	for (num_irqs = 0;; num_irqs++) {
-		irq = platform_get_irq(pdev, num_irqs);
-		if (irq == -EPROBE_DEFER)
-			return irq;
-		if (irq < 0)
-			break;
-	}
-
 	if (num_windows == 0)
 		return -EINVAL;
 
+	num_irqs = platform_irq_count(pdev);
+	if (num_irqs < 0)
+		return num_irqs;
+
 	/* Allocate memory windows and IRQs arrays. */
 	windows = devm_kcalloc(pfc->dev, num_windows, sizeof(*windows),
 			       GFP_KERNEL);


