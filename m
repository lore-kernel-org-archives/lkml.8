Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E991DC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 14:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD34C205ED
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 14:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBedh0QA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgCOOFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 10:05:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36481 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbgCOOFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 10:05:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id z4so2260241pgu.3;
        Sun, 15 Mar 2020 07:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q1NO2efRkLGYPR76ekDfvuJ7owLWS/S6CfB6+tacJQU=;
        b=HBedh0QAPcIc7fw5Iw2GNTyXkGKPVHOBDQwbSC7+zA9heVlZgbYbc/f+2Sk5vSMGrS
         /RaiYpSkZwIuuJyh5GRj69/oBYKTX0qL1iYtbyiJRwoPBLckp4Q7hnXxzswfJY5aymc8
         EnL6aeP0pJUyxIiaJzN0eRZCtlpjAG4SZ6ojK7cOo12TQwi/6nME/Dq6JyhbkLp0iOgE
         Eet8eIxz2QDTN5yaMpVY6zNVgD1e6k62711ySSYGY93aGNH1uI2rbo5B4XnULUBWnTAx
         T00VbrkglZvwUfmiqkenkTESbE8BZ/bVgc+0jsWhPUJCVOP+eKS+jISuKt6V1SFvhUrd
         5sIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q1NO2efRkLGYPR76ekDfvuJ7owLWS/S6CfB6+tacJQU=;
        b=sDntlm5TMmA4gmdMmYW+JfvVod1xmtUP/Ptbe1hrPZDHMBh49bl5yCEaD8h4O0ndyW
         m6zWJFLOewHGhUxguok5lMPmZX7Mbkm0NjtZdz+hJzKHNsJkahxPgxDPARMuf0UiMuYG
         W+KAou/naNWsLK84Z0TBdPYqR+uUwLZpF79gbkZAPBeZLokF4X0XujsdUbsl8unqaZes
         rIFjKCiLJIf6N5hwNzqrxrSnyR9qumhbMCfSjs5FWqVOO+SGrKB7GCigO2UeUd2clyty
         PUUTN9BS+tYLhrdVRQrQktTHsDMNdWgqdJYiti17h6QRkGYhhwaUzvomrRPey8G42JFp
         58iQ==
X-Gm-Message-State: ANhLgQ0Rwjpu4XsbelB6ioY08NHWCZkTKM1a8T4mfCFeHyuJxnKawW+a
        XtWDNz8ZINLWAcgR3Nslfvg=
X-Google-Smtp-Source: ADFU+vsNCiesR2BiYbL3uuH7kaZKiP1cuGcKFX/WXLpk6Nm5bh67qFEu3VkjlwBItXW+hN007oRHIQ==
X-Received: by 2002:aa7:8195:: with SMTP id g21mr22760286pfi.153.1584281149207;
        Sun, 15 Mar 2020 07:05:49 -0700 (PDT)
Received: from localhost (216.24.188.11.16clouds.com. [216.24.188.11])
        by smtp.gmail.com with ESMTPSA id t66sm4528341pjb.45.2020.03.15.07.05.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Mar 2020 07:05:48 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, hminas@synopsys.com,
        mathias.nyman@intel.com, bgolaszewski@baylibre.com, arnd@arndb.de,
        jeffrey.t.kirsher@intel.com, hdegoede@redhat.com,
        treding@nvidia.com, tglx@linutronix.de, tomas.winkler@intel.com,
        suzuki.poulose@arm.com, sergei.shtylyov@cogentembedded.com,
        geert@linux-m68k.org, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v3 3/5] usb: host: hisilicon: convert to devm_platform_get_and_ioremap_resource
Date:   Sun, 15 Mar 2020 22:05:23 +0800
Message-Id: <20200315140525.21780-4-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200315140525.21780-1-zhengdejin5@gmail.com>
References: <20200315140525.21780-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_get_and_ioremap_resource() to simplify code, which
contains platform_get_resource() and devm_ioremap_resource(), it also
get the resource for use by the following code.

Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
v2 -> v3:
	- call the rename function devm_platform_get_and_ioremap_resource()

v1 -> v2:
	- add this patch for add some real users of this function. 
 
 drivers/usb/host/xhci-histb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-histb.c b/drivers/usb/host/xhci-histb.c
index 3c4abb5a1c3f..5546e7e013a8 100644
--- a/drivers/usb/host/xhci-histb.c
+++ b/drivers/usb/host/xhci-histb.c
@@ -219,8 +219,7 @@ static int xhci_histb_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	histb->ctrl = devm_ioremap_resource(&pdev->dev, res);
+	histb->ctrl = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(histb->ctrl))
 		return PTR_ERR(histb->ctrl);
 
-- 
2.25.0

