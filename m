Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B74C2BA1B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 10:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D34720709
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 10:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sb7QFNjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgDEKtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 06:49:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46790 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgDEKtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 06:49:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id j17so13789551wru.13;
        Sun, 05 Apr 2020 03:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6DTFnfqknLyGp+3XkRw9j6lN2nC/vQBz5akOO6Jq+9E=;
        b=Sb7QFNjpZ2rGEzoq7wM1Lk7paYhyv/XK6nQhniUjUBfKVh8F8l91TDW/4eWFbNQ6PV
         NpuTaGGYXEGE2k3mj9HciNVITNjj2oYfdZcDBlBj/OOMw/H3SbyCU9mv/7puMqzrzwcl
         JkOTbuaeR+IA+D/fftEk4fyAZL8V5HhnbYniBu9IWOy2xzV98zxIKcHGULO4LiQDrpiV
         7Mi+k0RVaKbj9/IPs6hiNlIQIlmn6Tb8Uqf3XmpPSQ6+7Xih5ZXo3GQfKo/5XnAVckQY
         sUCsbn0YGbwohDRM6gxJk2zFR6SrprwnI3qH2FnMeqoouOtv5OQ1yIpv9yMmcgi2jE0q
         vE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6DTFnfqknLyGp+3XkRw9j6lN2nC/vQBz5akOO6Jq+9E=;
        b=BgUsdcg1AR9MTymokF0H8mTs73r1KWG22otnd5C+h91KVINdvvY5qd+cGEvpB97ENO
         guQtaDETN42e8K4GvhJ8tv4+cSjomBMyNwr4rH4YG2AhOva5RxPc4nGKYfdu1B2LFYcc
         qQOwB90ZUYgnOTBeA46bjzHBF/GA+m7MRmNwlK0BgYh5sWb9vQYDQuDOhejbn6uZ5ASf
         3zRDIzwKTae5SbQ9cynIaMhOH1dsLCqife0nIZOhVuoyEpcFx5eLNB+eT2w56NNNl2ns
         ZnupnlLLQr7jmmUVs9aPE9pHjSvRE0G0B9vQejieqXEKfzCnk4LYYEfoN0S0Vaidn2/L
         laLw==
X-Gm-Message-State: AGi0PuaG+kwirPC77IXkHqtD6Jdff6/ua48jwxFXWeyayeWZl87Y3mLj
        uTYHMJc6r6vdHeCfu26QHivk3qMEQHw=
X-Google-Smtp-Source: APiQypJEtqRB3M2locEeqSVQI8fHNbdDjKNYCq95ty62mPo5Q1EK5s5Pqdcn4VqhjNdpRnyQf+pwdA==
X-Received: by 2002:a5d:4bc1:: with SMTP id l1mr19797345wrt.103.1586083762850;
        Sun, 05 Apr 2020 03:49:22 -0700 (PDT)
Received: from localhost.localdomain (91-167-199-67.subs.proxad.net. [91.167.199.67])
        by smtp.gmail.com with ESMTPSA id u13sm21606411wru.88.2020.04.05.03.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 03:49:22 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 6/7] arm64: configs: Enable sun50i cpufreq nvmem
Date:   Sun,  5 Apr 2020 12:49:12 +0200
Message-Id: <20200405104913.22806-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200405104913.22806-1-peron.clem@gmail.com>
References: <20200405104913.22806-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 needs this driver to be able to get
the correct speed_bin required for DVFS.

Enable this option in arm64 defconfig.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4db223dbc549..28b25fc0347c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -83,6 +83,7 @@ CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
 CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
 CONFIG_CPUFREQ_DT=y
 CONFIG_ACPI_CPPC_CPUFREQ=m
+CONFIG_ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM=y
 CONFIG_ARM_ARMADA_37XX_CPUFREQ=y
 CONFIG_ARM_SCPI_CPUFREQ=y
 CONFIG_ARM_IMX_CPUFREQ_DT=m
-- 
2.20.1

