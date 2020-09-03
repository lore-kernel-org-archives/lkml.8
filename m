Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188C5C2D0E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF8782151B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzyYq+Ka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbgICUix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729458AbgICUb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:31:28 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928CCC0611E9;
        Thu,  3 Sep 2020 13:31:08 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u18so4111682wmc.3;
        Thu, 03 Sep 2020 13:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5IYak11rFzawAh9fCR1gi4F4Oa4pOW/pvtZIichIlV0=;
        b=pzyYq+KaGPIgvObH/Te0U/33+5xx6ZAbGyUsLa4mRSRnyCwSM5AgxcMgDzPU24Zx9y
         /Gw2/qKtPZ/e7vTKokOQp3ZwJktnHuv8qXYTxUiYITgYXx08sH98htb1pfcUDvpHzdE2
         /LMyPtBHF+mEvb5guDq/66ZQKnSfkDQoQmc+WBEQFUhVjqPjZVlzz+qwPwV9V/OieUeU
         p3G8wDB61e8aeG7pz796+n2EhYn129DBPnSFvFfVZZcndskHBZtq8OsJtUKAmcLQ8lW4
         uyuLG1XRVSva3V3cS/MD07LkvHwzLM93EPdK3M++fjzk53+nw3d2jZskQd36mWx1xw4w
         VQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5IYak11rFzawAh9fCR1gi4F4Oa4pOW/pvtZIichIlV0=;
        b=ZopD8rGeMnIV/RYLIyJeJiFGjKbOMeTXn9d5llBwBVnF5UPXmEhyIyxTRjTiTHTH1T
         LqtwQeBeM+LIEfGMsT79wZqXdK2UE0dxT//gs4EsOtKqL/DBNT2lRf1TxzoWJw7LoDSH
         qtSrTqrMoTUGD43C2kRwCsUU07kml2DOdt8dMcBKRpRwWS9o72CwU+oqsjqckn2EZjzM
         JIfdskQHlHXrazIjAnGutl8OxzC/2fjOZ8RlLUt2Qm+KguoDXq67MzcvQ3+aRSR1ZVoW
         mrTpHtcXQuEk2pEYVfVZsmq5iUI0JBWmNzHdB0VTQcjSau2hsyMsPceNdk9/uADAlAOZ
         rcww==
X-Gm-Message-State: AOAM533TaszCkeBh3FNcfAQdGmquPizU590xk5xbnfLUs+JTACCyenGw
        2wFR29PsZpQ/+nmPPVIudqM=
X-Google-Smtp-Source: ABdhPJxmuEEdH4QpFHEEFgjUw40D/E8UZi7btVLBAArqpLdAt3NR8lscjeIE7Qodwx7RuSbye8eVFA==
X-Received: by 2002:a05:600c:414e:: with SMTP id h14mr4116090wmm.2.1599165067180;
        Thu, 03 Sep 2020 13:31:07 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id q186sm6818274wma.45.2020.09.03.13.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 13:31:06 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 20/20] arm64: defconfig: Enable Allwinner i2s driver
Date:   Thu,  3 Sep 2020 22:30:34 +0200
Message-Id: <20200903203034.1057334-21-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903203034.1057334-1-peron.clem@gmail.com>
References: <20200903203034.1057334-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Allwinner I2S driver for arm64 defconfig.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5828b42f5243..4eaac49dccbb 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -691,6 +691,7 @@ CONFIG_SND_SOC_ROCKCHIP_RT5645=m
 CONFIG_SND_SOC_RK3399_GRU_SOUND=m
 CONFIG_SND_SOC_SAMSUNG=y
 CONFIG_SND_SOC_RCAR=m
+CONFIG_SND_SUN4I_I2S=m
 CONFIG_SND_SUN4I_SPDIF=m
 CONFIG_SND_SOC_AK4613=m
 CONFIG_SND_SOC_ES7134=m
-- 
2.25.1

