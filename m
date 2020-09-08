Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F71C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C7AF21D43
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3m7oZW4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbgIHIVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729967AbgIHIU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:20:59 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B223C061573;
        Tue,  8 Sep 2020 01:20:58 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id l63so15068755edl.9;
        Tue, 08 Sep 2020 01:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TfJihMsMhRJ/+S5wdJVUFID0QqKRghvIoFnr9LgeHsI=;
        b=q3m7oZW45fffzPqJmgfA9l81+hLXs6Lbw5ThJJ/lwl7N4Js5b0kL7tHKaKZcYldxh8
         poGRL9GAZwEoI7kzriXsF6H1dTijCreMpUftiDECooMIkAC+THREmKVEuli9jm6pa01x
         6m51OfsGV/Nk11D6ur+z0mo3UJpV3+JD4eFmw7F3Zlsj4nDsFRTgnkTTkHKuBYMOiZDr
         TT87/4SWcFk+CpIKyKHCPrMoydfSW9iliTdwArtRqzVa3OsMuIqlB7ennQoXL9YOJ/6E
         C6h5fLA97jEAK/JiDddiw8JDvyOB95LEl/JLplAjW8/kWWX8tV7E4Tfu3fUUqH5NofTS
         E9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TfJihMsMhRJ/+S5wdJVUFID0QqKRghvIoFnr9LgeHsI=;
        b=khghjaWuyhsVV8tsaQSoG9kYEvcJsDfPXXFYyrsxfeR3U04KLRjSUZT9Bo+3He2Mun
         u97xPXBglG2SQUqZ/kNQUuSk85Q4CLqV6BOyVqQA7IGjXbD/6M3fAZv+cXdCSTmYtbu4
         J3yJsl07axwcC703n6puB9wNU38M+OMIJX2AJjExfSRoEw4Z8FB1F/BqKQZDxMbMigSc
         p6A6I13gn0PSaN9JBCA4UUb/wZFBWF+UIImqT41fQrGwL4RuKKHwHEpKjdr8Ck8asep2
         nN8KSj25CGgTX1isJ+svEe6wipkwhsdxfA5lBtk5VN0WwIgNoLIpUIdack+uqKylDZqa
         IHgA==
X-Gm-Message-State: AOAM530pvLmxr5D4x8LAVsbuYWmOLiC4/v5GkjkNCsuKO5lfvf9fxMhC
        yKuFhs6gNb8iGTIMoAlDnmo=
X-Google-Smtp-Source: ABdhPJyHgy9EZgTDSot0DQpBYTdm6PENWHy7FxF+KT3GvFHw9Y6Q3lrC6p1eskmu9Kz7LCUJUGIqPQ==
X-Received: by 2002:a50:8062:: with SMTP id 89mr25090547eda.241.1599553257078;
        Tue, 08 Sep 2020 01:20:57 -0700 (PDT)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id g24sm13172326edy.51.2020.09.08.01.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 01:20:56 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc:     parthiban@linumiz.com, Saravanan Sekar <sravanhome@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v6 3/3] MAINTAINERS: Add entries for Actions Semi Owl SIRQ controller
Date:   Tue,  8 Sep 2020 11:20:50 +0300
Message-Id: <fa752e22bfcd0fb490b7b423b62a5c4be5bdd0dd.1599552438.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599552438.git.cristian.ciocaltea@gmail.com>
References: <cover.1599552438.git.cristian.ciocaltea@gmail.com>
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
index 9544eec4eff2..04c75815fac6 100644
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

