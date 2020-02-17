Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C54C7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5145120836
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="tbhCd4u+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="asX4wjx5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgBQGnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:43:42 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:44401 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727438AbgBQGnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:43:10 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id B1839573D;
        Mon, 17 Feb 2020 01:43:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 17 Feb 2020 01:43:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=seFLvOMN4xtaq
        jI7cnOZI6mcjOMTPL5KXvxpWz5IwoM=; b=tbhCd4u+6ZsuxNB0zWc4MpFN+7dVc
        43slQtjWPM3cpPmih08zO1JwqKKm6WgZD2Y68c51+acDsN+MdGHwocHJ8R0+0sAE
        vKf89qeyU7VBimht+Gu/b4HlpifPU3W76D2nW7pxKjbNHBvskLNag6rvv6fQRDDC
        Pn917NivLfGgk2cF/uQmIRY6yNqvGqud1ANWPZc+3bQhzfcisRPg/Ih6Y0Ns87+Z
        NbbO/64Fg3XfKpevxbM8n8N3O6vdAw0czL8QP72Cxl/II0XHFlsvz8UtnVwFCfQ3
        4P75zpMrljqcu6liXSWvvWWsQByanbp3WIa3M17ccH/ct/8K8DsAjwkRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=seFLvOMN4xtaqjI7cnOZI6mcjOMTPL5KXvxpWz5IwoM=; b=asX4wjx5
        Eo3BGAJIhEg+C9gPl5nZoKLuGR+Q3n7v/q4N1u1W2iJbZs0iIjoLYhpbMKqFiusf
        Qz+ZnSNrxl3wUsYf81aU6nwuWHAZ1XomKNnZ5L0E/R4z3RexLXA3Eg8RTbE38+aH
        UG1gpLRa22dlGH5kBabv3QHH+lF3JfJHtY1NktJXuzPenB9JQiE8ZFyuxC9zHe3b
        Tmcx45fz6Sxcfo3G8/uH5b6wMd9+ppfRcoMOcnTvc7Plz5FqZNuAKFzyjfj8t+38
        VTJ/92f/7vuxUCiZDyli8y8lNr1bFDqMH48oMbBldRHOcrG6Eqij5zvWkmuEC5ec
        ARZbUiN7wkak8A==
X-ME-Sender: <xms:_TVKXtZ6A3uSdJ8rGpPty7KJhPJm3o8GLtb29iqRVB3Cfc1z2T-F6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedvjeenucfrrghr
    rghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:_TVKXsAJ10lZPBOE5MBG-89rZM_Bjz005ojcq4oZYYxk8el5TON_sg>
    <xmx:_TVKXgKuGjbXTIgQwaYoCx47k8ucEE8jCTlrQD8hA9AZmmYOSvA3Sw>
    <xmx:_TVKXjrIS45fFW5fOelE3EORkIpFP9Ycsnbh6xzX6FMT7LZRF8Piuw>
    <xmx:_TVKXomaBJL06wORSJGLp73Djzk9VGvRtGWn3gnb9Oqd9VonWmerKA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id F20493280062;
        Mon, 17 Feb 2020 01:43:08 -0500 (EST)
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
Subject: [RFC PATCH 30/34] ASoC: dt-bindings: Bump sound-dai-cells on sun8i-codec
Date:   Mon, 17 Feb 2020 00:42:46 -0600
Message-Id: <20200217064250.15516-31-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217064250.15516-1-samuel@sholland.org>
References: <20200217064250.15516-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic ASoC OF code supports a sound-dai-cells value of 0 or 1 with
no impact to the driver. Bump sound-dai-cells to 1 to allow using the
secondary DAIs in the codec.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
index 7c66409f13ea..97d4bf0d9a73 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
@@ -12,7 +12,7 @@ maintainers:
 
 properties:
   "#sound-dai-cells":
-    const: 0
+    const: 1
 
   compatible:
     enum:
-- 
2.24.1

