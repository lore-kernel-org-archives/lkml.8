Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B3CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 877AF20725
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1bK2s+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgGJJ0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgGJJ0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:26:08 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305F7C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:26:08 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id a6so8057744wmm.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vGrB4C2EapNRMSvNvzwinnqh7atFRSmJOU/XyLZhEhE=;
        b=O1bK2s+zy853RT/ldbRQeQA6LdWuBhgSywFH2AM+GjDWIiL9877PrIij4rkSKT+nIS
         TtvHoE9PJw/P6Od0Y2hYvgOMFfsf2im2F/hugBuMcV6/r+D8wQ99PN2euw6FJyf3eThP
         nW73K55Q18h7nP3S3TrBJEUdMivbz+G9BRZpRBo3o5JckFoDwE72nNB8tmXWVHkAXqDq
         la4tKeE+XCIXvMVA39vB+V3u9XFJoJz+DBpehzv2UT0xd6pEaILDDDvI0iIBfahkmtSS
         iNq1SxNPQB343OMffoHxNUZpx8IpcXPohLPY2TJovuxSop4UtCcVQYJlDDVhlykiLoOo
         h3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vGrB4C2EapNRMSvNvzwinnqh7atFRSmJOU/XyLZhEhE=;
        b=TZafnzm8aQ1D8E5THR/XghSxghz9HW11bXQqSUeiemIdxaDRCi2MYPXIF7Ogg626sb
         3igPKGJaXaYJj74ytvhS6lpiPf6HS5n2RQOv3vzdGyGcpMe3bF4epRhc+/qJh35jl/tW
         XCOel+osEoCaSjIa+OhXB3gvF+R79DpvXdPpu7YnYXU4yJFhnwAukZMmpLTbFqQpFFQU
         PGyPDAe8kZ1AuWo+jLRX7kgUDiVxPh3o8jRFU0R08/plC1oT2XWtHMuyGEs4VbCanUWD
         8PISDCfDEdvlCPXQhX8xF43hQ0CYfiDHUxCoFER7CoKywFUg0BYtji8i70NpIt5hf8pa
         p2Nw==
X-Gm-Message-State: AOAM5306E275hlLhY6n7LECPXDrFV6uXIHb8VQHDAdIxhVnq3Rjqgt0d
        mjVy4zgIa7HlW28D0lMwrTMpK/EyZAA=
X-Google-Smtp-Source: ABdhPJzggwLJmzAeo25TWwoScYbm5Sywfa4ImakZ7GZScH3ClsljY2PBANXZhZNdablTFl1UBIiFXQ==
X-Received: by 2002:a1c:23d0:: with SMTP id j199mr4521494wmj.12.1594373165681;
        Fri, 10 Jul 2020 02:26:05 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id h23sm8179559wmb.3.2020.07.10.02.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:26:04 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 11/14] arm64: defconfig: Enable devfreq cooling device
Date:   Fri, 10 Jul 2020 11:25:45 +0200
Message-Id: <20200710092548.316054-12-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710092548.316054-1-peron.clem@gmail.com>
References: <20200710092548.316054-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devfreq cooling device framework is used in Panfrost
to throttle GPU in order to regulate its temperature.

Enable this driver for ARM64 SoC.

Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 89538d9e39e5..8a295bcb4dd3 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -504,6 +504,7 @@ CONFIG_SENSORS_INA2XX=m
 CONFIG_SENSORS_INA3221=m
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
+CONFIG_DEVFREQ_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
 CONFIG_QORIQ_THERMAL=m
 CONFIG_SUN8I_THERMAL=y
-- 
2.25.1

