Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0946DC2BA15
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB179206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gECGj7gc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404443AbgDCSCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:02:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41353 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728382AbgDCSCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:02:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9so9579734wrc.8;
        Fri, 03 Apr 2020 11:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LK/63VpRTinhiS72eGFe8hpGS9Ib9592eNpC47zP9eg=;
        b=gECGj7gco55CQi8eVKo1AAsMyzI0Y0o7rmDW5QCJXbr5LCVDnHUz/qtiOz9HHljK9T
         u9pdBmKtyx175zDh0dSSJuFkNmrR/NQ0gMX1nMxBD7a+bRWQ/Yjlxsa+7k4njHtxJDFs
         VxVe3xlwewOPBdJ6Q3mAV6CzGsrFDwVVuleFj7uruyY4cigK+mToq1Ef9rmOSJpMKORu
         vno9S9n95Ue7BiIwgIRV5fS9wBKJp6kWKwNyvNQ9bBDuL1erUi+VSboMHYBpquB1LgcU
         6XiHGEBC+V/siyW7Q/sXeeWBDxsoTgNbi6suhqpuri0rcQS16rFrSfmVmAn/7aT+I5o+
         AZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LK/63VpRTinhiS72eGFe8hpGS9Ib9592eNpC47zP9eg=;
        b=sKN1LnEqpheRaaCfJDOuElh3r6fxl3pONR88EyaSbNOeEcJ4MC3c+TMnAMerqAyq0a
         wNsOoSldS7fv1IS2xFY7wmJKM4vf9aiSUizcguhX6CPcVPoYDvpILQSHckgzNvtvKiM5
         n6+/vYEl68ouL3o84sYWCC6LZ2X74OvsSJPY7sxJc2BO+w8cErl4bmdY/38SWx5VPMCT
         3BEKbNKORHQpoiPniindGv74G+TBCBk2dNprtVQ5gq5kVV8zbLucb/9EWXFbhoKXjzQM
         7Bhq1Ec4F46iXyUzXkuFWi0wv6ztysXw4LK4owmFYaBY0k5wgpPZ+Nw9OhCALZsBvR3K
         mXiQ==
X-Gm-Message-State: AGi0PuYSlmO7+/uyMOyCspjNhFTB+0dSBjkHZozxP5U3r65zViHGQpqY
        P5VV1w25UMjyUeRRn3EjQvg=
X-Google-Smtp-Source: APiQypKVCRnue8W4nhBRXSD3dBoOHLKYUZYejfQvBtxGqmi0wdjXQIZrIC9WjOlCYfbVLWup7ZCNgA==
X-Received: by 2002:adf:f68b:: with SMTP id v11mr9853798wrp.270.1585936930550;
        Fri, 03 Apr 2020 11:02:10 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id j11sm13005492wrt.14.2020.04.03.11.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 11:02:09 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] ARM: dts: rockchip: remove identical #include from rk3288.dtsi
Date:   Fri,  3 Apr 2020 20:01:56 +0200
Message-Id: <20200403180159.13387-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 2 identical '#include' for 'rk3288-power.h',
so remove one of them.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index e72368a7a..f102fec69 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -7,7 +7,6 @@
 #include <dt-bindings/clock/rk3288-cru.h>
 #include <dt-bindings/power/rk3288-power.h>
 #include <dt-bindings/thermal/thermal.h>
-#include <dt-bindings/power/rk3288-power.h>
 #include <dt-bindings/soc/rockchip,boot-mode.h>
 
 / {
-- 
2.11.0

