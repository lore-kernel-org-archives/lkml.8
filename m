Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87523C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 572CC20870
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mV0As66A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgGDK0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 06:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgGDKZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 06:25:59 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0054EC061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 03:25:58 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q5so35294494wru.6
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 03:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DFfhRB3CIFp7+b9HYaYFBTlz+H/vZeZ2FswijDgFipc=;
        b=mV0As66Am/M4p3bN+Mk7zZSGHK6Mju2VuzevBcWkz9Cou17jszv2pO2QbbzwNeOaJa
         Sj4ucKGda4iIFmVg66SENMIA4Nbfixy5oLosZhwOeitQbZDVoybvi26g58zCQYS5gXw2
         6dh3fItZTnjBK77c3iOLP61WoofeBUGqhcLdc/t7wx0skGuS2mxJIrY8kISVZm+L8o7C
         tGXSW/9ImyPQA+VxUKhnX0qKuyF/34WBMRYTRWe/sL6Xcdmf6fHgqnVCFZGLHk9XT/GU
         j5SfM/3tQsnIZ8PCqFOonlFh9u7dzJE9s+kyx4J0AxD4V15h+WK2V66gSig+S8+NfmIk
         x4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DFfhRB3CIFp7+b9HYaYFBTlz+H/vZeZ2FswijDgFipc=;
        b=MG71uSjm07OZ0+ZabgvpIzbif80Yi8kE6EWFTbu5fu/gRT/KSJIaeQZSHR6Ec2j2An
         nwLDj8kxpPvsw/nVGWzwnYErM2afani7mbO9e59bxpxRmNwTqZCx1TJnQnta8J8VlMpn
         b4XaZgimrzmWrFn0cxAKaO8ZLsFdf10+NaNC7UgRd8dc6ehyGtCClajDCLvD7/czFawx
         BDu/4bSAM6HwDQYm5hWc0R4jHRQaEsyJ8AqdF8qsZew7YQ6Y22IhgrSTrRo+arh4NTKM
         r3zeVnGqiWjri8OxKpsRW6ROnnYrNJvil4UjF1y+R8H+ufyrB3RMwiNNwhVFQpLi613m
         xWqA==
X-Gm-Message-State: AOAM533+Cay3HfSMHvCNPKC1uNrxJxNR3H51sL6jp217QJnbo+Ryalbq
        d8wNodTyy3/3xoqGoUk+5dY=
X-Google-Smtp-Source: ABdhPJyBqdyjxO1QJ2Wkyp5nBh0YukoTPRY6UODWodbPokllpS3WEnTqIyCf9+af/s+NraJgatVQIw==
X-Received: by 2002:a5d:420b:: with SMTP id n11mr40233460wrq.91.1593858357628;
        Sat, 04 Jul 2020 03:25:57 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id g14sm16421428wrm.93.2020.07.04.03.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 03:25:56 -0700 (PDT)
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
Subject: [PATCH v2 14/14] [DO NOT MERGE] arm64: dts: allwinner: force GPU regulator to be always
Date:   Sat,  4 Jul 2020 12:25:35 +0200
Message-Id: <20200704102535.189647-15-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200704102535.189647-1-peron.clem@gmail.com>
References: <20200704102535.189647-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 3f7ceeb1a767..14257f7476b8 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -245,6 +245,7 @@ reg_dcdca: dcdca {
 			};
 
 			reg_dcdcc: dcdcc {
+				regulator-always-on;
 				regulator-enable-ramp-delay = <32000>;
 				regulator-min-microvolt = <810000>;
 				regulator-max-microvolt = <1080000>;
-- 
2.25.1

