Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5815C54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6E8206F6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STJZraM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgCYK5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 06:57:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41811 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgCYK5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 06:57:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9so2393341wrc.8;
        Wed, 25 Mar 2020 03:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LK/63VpRTinhiS72eGFe8hpGS9Ib9592eNpC47zP9eg=;
        b=STJZraM7KnNG5j/4mxy5/JwGK6u9Ls8g+U8aHGuB8OiwBRazBmk0EmDZVLasIpVg0l
         LorsN9AwIU5jU31QyO9MIuxJJW+sLYNIXrfLt4pYBdOE8Pu9Oj734hNYJNCkwEUnLk5l
         myQiEIBn9uX3gVw6J0TL7xoI12fBLhYqtTKXViXTBiOQsiDYTS65LvrfphITeNZzZI86
         nOxz0frKnPvmmxaYRS8Ntfuz6rcaJ1Ay0bjXlkUIVMiNa21MYbucmpJA2Q0GYyiCbs4T
         6XRBiv6s6z5p7ID+Zv2krl/rKyFjIbPLOqvQCItXfyFap7VfMmxa1WY1RjJS/qNiRnL5
         udXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LK/63VpRTinhiS72eGFe8hpGS9Ib9592eNpC47zP9eg=;
        b=M2Rp+wA+mk0uSKMweb3uQXdd39nyRDMed0eULj5Ed59ViY60dNQDU/bxHkj2SZw6bQ
         SPcg865lhoFaTUfJcUf3lnb2axV3Hgv91skOn4lTw2IXME5swZgltbsxdGnuXaJzdWNT
         IMNuOcvIJt9EsNFDngDuD/NzJ3n421ufg4p0BEYq/3N/0nidI7Va3avJzXOtrqLtcJf2
         pDStKzkY8hEMVIxLo2/avynhYVHwNNpXkG928yUfAWruOreqXCAcW+OJidMsXnOZ/dgs
         axyXQFl9jwlslasYXSmXJcLrzNyOMlqPWYkE35NwiOtq6mp3pxsXohuXucZgPVh729rP
         cg3w==
X-Gm-Message-State: ANhLgQ3UJjDSEprsqacfdeLtUbM8oC1vz5/91w9Lp4f5i/Avd2l0KjDL
        /y/4WLdh2913Rt8DkTwAVH4=
X-Google-Smtp-Source: ADFU+vsNgfBpz3csz9luqYb8b7ZDiuvrOxIb4oqdh2Jlq7yApLxnA+XyWS3p4B5eABuEpP56HxycWA==
X-Received: by 2002:a5d:468c:: with SMTP id u12mr2983370wrq.394.1585133860900;
        Wed, 25 Mar 2020 03:57:40 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id o9sm33867584wrw.20.2020.03.25.03.57.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 03:57:40 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: rockchip: remove identical #include from rk3288.dtsi
Date:   Wed, 25 Mar 2020 11:57:34 +0100
Message-Id: <20200325105734.5868-1-jbx6244@gmail.com>
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

