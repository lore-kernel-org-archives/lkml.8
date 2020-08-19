Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B48C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAC14208C7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbHDR1Id"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgHSQiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 12:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgHSQiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 12:38:06 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A94C061343;
        Wed, 19 Aug 2020 09:38:05 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id o18so27054896eje.7;
        Wed, 19 Aug 2020 09:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/sBNZIVGdpsExbmAK17EOc2jU9uNs2C63Dzg+2DnKUU=;
        b=sbHDR1IdgBeNMBrndxtD9Ie/gtQUjryy8WHCMHoxKNQxJsbYZogATWd+OZro6tAvdp
         dKsmF7bLRFiDuVYQFsEfd4aJc2SPHo0owBPv0fgnX5Dadjh/o5L4Q/Ec5YmZHrrxO8eg
         HdTy+/E/GkrtaEY4lvgsiafCFX6+XKp8u7+lMZ9jo4VHkbPpLCiO086zatUMuePr0oCz
         IVCyCKKlZCj8zWgj6k/QZsv+vIMN4N2hLenG9fcB5e+MJsr1H2m+Tpp/4js7lk7hO4Zr
         Bzgepemm5gUOvrLEqCD505CesgWZPidpQPegvdNCGS9LTdxBdGIr5uZoI0zqzzt6n9TP
         ZV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/sBNZIVGdpsExbmAK17EOc2jU9uNs2C63Dzg+2DnKUU=;
        b=uIaP6hyHZYKV/ozthW8KIkJuPSxaIVelkQ/MiyQGB/Qd6t25E9DmRwAkPnT4+nmpnY
         QHzOeODTsePtFeBXSGA+D8kIu+RNHE/nnNCv4xJUFDV7naKpwVhgRGA3T6LqmOoFXVf2
         Xv75S3Ze1cFHXYsYS0b3pyG0Gfuhu0g0EJZibfXn5pZqSTLuuvEKJVgrOWEHptUmW9jk
         e0O8iL8O/vaMw7cg3+77VG09R2098CD9FudyXSrFH47oIRvLorN9v1YwVrVlUBkk21eI
         RHhqJ4wocyJHsOoTXUiiUu8qQoFTxfM3GLLpIomEYmo0rU4x6AtjT0Ug06Jacs5mSnut
         IJHA==
X-Gm-Message-State: AOAM5318PTJOWpq8SjMc5lI9PWK08CJ96rzaCw6GOQrkE/CfX6cwHBI2
        kCABq9swowXvS+q4P9zTFFA=
X-Google-Smtp-Source: ABdhPJyBtVvuvLAXE6EtK5Nhs/MtSRGBJwgKXZ19qO8rP/n8tMgh1zkLyHgA/IAvcbATnEhcPIrj/g==
X-Received: by 2002:a17:906:3911:: with SMTP id f17mr27148550eje.56.1597855084560;
        Wed, 19 Aug 2020 09:38:04 -0700 (PDT)
Received: from localhost.localdomain ([188.24.144.238])
        by smtp.gmail.com with ESMTPSA id m13sm18310774edi.89.2020.08.19.09.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 09:38:04 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v5 3/3] MAINTAINERS: Add entries for Actions Semi Owl SIRQ controller
Date:   Wed, 19 Aug 2020 19:37:58 +0300
Message-Id: <b37f8a78daa3d6fdadd081ef536e415814d38880.1597852360.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597852360.git.cristian.ciocaltea@gmail.com>
References: <cover.1597852360.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entries for Actions Semi Owl SIRQ controller binding and driver.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index db97d048a92e..e28d8ad47d03 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1525,6 +1525,7 @@ F:	Documentation/devicetree/bindings/arm/actions.yaml
 F:	Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
 F:	Documentation/devicetree/bindings/dma/owl-dma.txt
 F:	Documentation/devicetree/bindings/i2c/i2c-owl.txt
+F:	Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
 F:	Documentation/devicetree/bindings/mmc/owl-mmc.yaml
 F:	Documentation/devicetree/bindings/pinctrl/actions,*
 F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
@@ -1536,6 +1537,7 @@ F:	drivers/clk/actions/
 F:	drivers/clocksource/timer-owl*
 F:	drivers/dma/owl-dma.c
 F:	drivers/i2c/busses/i2c-owl.c
+F:	drivers/irqchip/irq-owl-sirq.c
 F:	drivers/mmc/host/owl-mmc.c
 F:	drivers/pinctrl/actions/*
 F:	drivers/soc/actions/
-- 
2.28.0

