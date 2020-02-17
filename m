Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B731C35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53890206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="UkgOQurQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zqhn7Xc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgBQGoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:44:25 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:40587 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727125AbgBQGnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:43:01 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3211C551A;
        Mon, 17 Feb 2020 01:43:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 17 Feb 2020 01:43:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=uh4qnY4/Cy+hK
        AUlOu+DvXZh4OqjGi9JOSBOe2IEtnE=; b=UkgOQurQZncmWBpLjsINz8Mhz1IBo
        bY4MAHu260QmNFWo9p4KTknmv7z+xJN9NpeO3rbd9cJEandPqCbuRLgC3o4Mbqsb
        uyPMf2I7NToheCJc5wazBTqOYGKSwQEtFbOUATMFxt08tSzdKfZYGaGlCsfdDlpl
        S7ZgJDu1nRX83MPO5AWjweX8QxLmJe/6TfWWt16YJwCLGxXuKNEYIs2v4x9+RxNy
        SSclgn4eSnmIwZZ0zGvWqK05eaXFABtMMX5rN5OR9wZB48rRihzgSCGC3ie0q4Z1
        5gT9RqLYY3Fy7cE5ojB9fuDub2vCEdFmDtQlSbXsHwrbke7CVet13eCuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=uh4qnY4/Cy+hKAUlOu+DvXZh4OqjGi9JOSBOe2IEtnE=; b=Zqhn7Xc4
        SEFikS3VmfFlQyNXHAVrT+Sr0hFxCezzVSf91NWHkp0pQyc/VknURct01LgWH3Vl
        PEgwOpa5GjaNV0kMQ93HGgsqkVgSj2wGNavSqbXVPoOAt6/Z8q42AVSc39yOgoL2
        0jDA9MgSfRn392jPgQLpa7SUgPOF9o5VO+ExyPALRJYy4ZMrOuw+wTWyWhKNmE0B
        Sz2mLqL/Mcj9U/uOmWrJXyGhmEpl4eTV5yafUdlCNAyIEpIVt6Ixib7IA8JwTswm
        4xeEp7frZSpUIZ6w3KvVE6UqVs+4c/bU8Kew8fkVSJQm0g0iJfpFvV/IW5aSihqc
        78eLQikYWh+4+A==
X-ME-Sender: <xms:9TVKXqyeY95jqdjNFE_iCpNeA-BBOAVDAmOpVnwCU6-x_zsEsiNGMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpeejnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:9TVKXkoB_PLbOWtW9o0FEDDDkTKl9rYwdwjyk6fGC9vXFuY2P9TYqg>
    <xmx:9TVKXoXBGLbm95HyavDSgNzTQSu1wrXCXxZa4YN8ErfbJJR0MJYPNA>
    <xmx:9TVKXjp6X0MynIYCcxmab8NQOdTQ4Nv8dFwZ7RkY8o50xZLyXUAv3g>
    <xmx:9TVKXsRkyfUIHLq8msy5m5N3AHqPui6TfY4S183UyjwEml7nkCKz-g>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 70F03328005A;
        Mon, 17 Feb 2020 01:43:00 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        =?UTF-8?q?Myl=C3=A8ne=20Josserand?= 
        <mylene.josserand@free-electrons.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [RFC PATCH 16/34] ASoC: sun8i-codec: Fix field bit number indentation
Date:   Mon, 17 Feb 2020 00:42:32 -0600
Message-Id: <20200217064250.15516-17-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217064250.15516-1-samuel@sholland.org>
References: <20200217064250.15516-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several fields have inconsistent indentation, presumably because it
"looked correct" in the patch due to the additional character at the
beginning of the line.

Fixes: 36c684936fae ("ASoC: Add sun8i digital audio codec")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 0063fa301fab..559dec719956 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -68,15 +68,15 @@
 #define SUN8I_ADC_DIG_CTRL_ADOUT_DTS			2
 #define SUN8I_ADC_DIG_CTRL_ADOUT_DLY			1
 #define SUN8I_DAC_DIG_CTRL				0x120
-#define SUN8I_DAC_DIG_CTRL_ENDA			15
+#define SUN8I_DAC_DIG_CTRL_ENDA				15
 #define SUN8I_DAC_MXR_SRC				0x130
-#define SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF1DA0L	15
-#define SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF1DA1L	14
-#define SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF2DACL	13
+#define SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF1DA0L		15
+#define SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF1DA1L		14
+#define SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF2DACL		13
 #define SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_ADCL		12
-#define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF1DA0R	11
-#define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF1DA1R	10
-#define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF2DACR	9
+#define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF1DA0R		11
+#define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF1DA1R		10
+#define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF2DACR		9
 #define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_ADCR		8
 
 #define SUN8I_SYS_SR_CTRL_AIF1_FS_MASK		GENMASK(15, 12)
-- 
2.24.1

