Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A672C2D0A6
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A90120684
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEfs4xSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbgICUjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729418AbgICUbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:31:14 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF073C061249;
        Thu,  3 Sep 2020 13:31:04 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z4so4590122wrr.4;
        Thu, 03 Sep 2020 13:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7kdiKWYhgrXc/dLuy4QmJOJzV5nCR1FMn7KxcL86B2g=;
        b=BEfs4xSHwizz77U6lZSX3/6eX7M1nJLZidrzep+rfN5H0CTn46/t6zj/VgByNR5PVq
         NqvQCsx6atSOtJDMg+oEghtNF/7K4Al6FoAntExLKy3rkLHNunpNVRWQutA29C6lhA74
         mW3aeEbg+BzC1eUyR6eAUMkbaWBqx9k1rCnaGBCu+i+x08o7rF8awZ3Xk6BbhUuOQnA8
         xSdq+8MxZSHZV5P3dY0baUdTucgnGBh1gC1q0T2UdJsCnCBV7fKjwj9ju6je6To/zL4q
         ZEUWDsTUgpad2o+tvBjkqJR30pPm+UFhFcNxKxCA83M/U8tkEOxFetw5Y6zxcGK95V8/
         s4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7kdiKWYhgrXc/dLuy4QmJOJzV5nCR1FMn7KxcL86B2g=;
        b=B6Q4S8xz19VyJ/r6fjU532i5GOLjZF/H+b0FNjMlev4qSnmrRA1yCL5lERPp3IMY77
         cA9PFaIR7cfXIAjDovJw4HPOCLBN8mgwI5NlHDDIsEO5pPJmmqR9u02KyU4viONXK7N3
         burEz3Kjzb6sHZT/RtYuOHR3fOeKNJByD6JGjT+aBgpprrsOzI3EMFy5dzBj3Gf5WmgQ
         vV55q3tIjdbgDTS86lUeAHLDlUgJZhn3MfbxMl1FmErri18QyH6KrTYmCo1sG0GV8WaN
         wiyaqAzxyGb0/11IvAxutKdHETRu7I7InvgkPjka5Q/Rbe53uV3pky/mbu9oFpU/kfba
         CoLg==
X-Gm-Message-State: AOAM531uK5GFcsOW3NcpkSog51CBTt903GkwOvLKGFBWm4xm2dbA5BlO
        x98/ZuxTOvlXkB/fMynqj+4=
X-Google-Smtp-Source: ABdhPJyHugEjh1cQ8tGklBO7HKq6sQdT5S677ENDwIMCGD+BQJiogorF4mbzeAz92BSVsCqAUPChIw==
X-Received: by 2002:a5d:69cd:: with SMTP id s13mr4084522wrw.379.1599165063464;
        Thu, 03 Sep 2020 13:31:03 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id q186sm6818274wma.45.2020.09.03.13.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 13:31:02 -0700 (PDT)
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
        Ondrej Jirman <megous@megous.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 17/20] arm64: dts: allwinner: Enable HDMI audio on Orange Pi PC 2
Date:   Thu,  3 Sep 2020 22:30:31 +0200
Message-Id: <20200903203034.1057334-18-peron.clem@gmail.com>
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

From: Ondrej Jirman <megous@megous.com>

The board has HDMI output, enable audio on it.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
index 7d7aad18f078..e6ed8774a17f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
@@ -144,6 +144,14 @@ hdmi_out_con: endpoint {
 	};
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
+&i2s2 {
+	status = "okay";
+};
+
 &ir {
 	pinctrl-names = "default";
 	pinctrl-0 = <&r_ir_rx_pin>;
-- 
2.25.1

