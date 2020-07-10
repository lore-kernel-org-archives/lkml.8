Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE59C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15F0720725
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joF8Y/Gi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgGJJ0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgGJJ0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:26:11 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC7DC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:26:11 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z13so5202760wrw.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DFfhRB3CIFp7+b9HYaYFBTlz+H/vZeZ2FswijDgFipc=;
        b=joF8Y/GicfhYL8oSuhK490OvHX+3VzCXNwByiLydKiRvzQ8Pijr8y0OoMbaJTBEp3a
         OeghOfb0fzHI7I25C71ky1GTo0Qq35xHC/zPnFG6Ume0tbrLHYKSK0EnN94LwAE7etGO
         9yZDXbSEvsTKUR1zln21Cor9Hguv1x6U16GdCFHEo4Y9ysCgcUCzjAfgNBYXAVyWsAZh
         VIzC79lrQexvzhm4rX1ZUjP5IJZTib8l+JkG1K7+s5VXTF4XRhpJqtkLmpo0AqRvnkoB
         QRUaSL+eehYEgCPUGf/uy/FA+8CiSabpi8QNvW0lle6Ft1YnAsvbDZ4963UOVg/zky25
         46MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DFfhRB3CIFp7+b9HYaYFBTlz+H/vZeZ2FswijDgFipc=;
        b=tlDaR9ntl+uzqyLeHgWGDNulizRlm4BrN3RvMUDelMSCIeaSg3KtxB7D/NVoWufhYK
         vobToRQFiriIHFeLWckoyEGMrxrs8UCAxuYzaXPwnRxCRerJV1KkG/ju4g//rTZv7j9K
         OA5ZBOEgfArqL2JSgf+T5ZEXn5GpJxIRCJrO6niLj0V2WylkxBGohtA4xd1WpICjRvMQ
         Dc6yEk2zmSDzrGB2H3SKixt7X4EvG05uHLayKi/auVuw5VHWZcn9BEN46DF+VHg7Glmn
         pRwd76Ltl/loORNkM8UeiBFmUzmE/F4n0lF5drrAF+A/sPc3ub2/5CHuD/UdT2s7BrfY
         oz1w==
X-Gm-Message-State: AOAM532ddSjcRI7ngl1Rc/iOyx83b+kJZ+fves2x7ZbRt6/fLkkZPDBE
        scrQwT72t0j7PuKTBD0XgIs=
X-Google-Smtp-Source: ABdhPJyfpqa0BGTWzUtWGqgYjvoSu1DHtTUy+/NrLOOAX+svDx5rdF8+T0WttUQmSLlHXPQJgXOMfQ==
X-Received: by 2002:a5d:44c7:: with SMTP id z7mr72022276wrr.226.1594373169731;
        Fri, 10 Jul 2020 02:26:09 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id h23sm8179559wmb.3.2020.07.10.02.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:26:08 -0700 (PDT)
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
Subject: [PATCH v4 14/14] [DO NOT MERGE] arm64: dts: allwinner: force GPU regulator to be always
Date:   Fri, 10 Jul 2020 11:25:48 +0200
Message-Id: <20200710092548.316054-15-peron.clem@gmail.com>
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

