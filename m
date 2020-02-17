Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA4BC35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A3720726
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="LyTBo9EV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ibp5dbHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgBQGmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:42:53 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:47765 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726646AbgBQGmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:42:53 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4465D51E1;
        Mon, 17 Feb 2020 01:42:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 17 Feb 2020 01:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=3TgpiGgfAgMky
        brRUL0sQxqQ1Qaqse1cW0ceZimbAz8=; b=LyTBo9EVjaipjDP7W23emvsnAzphe
        JyJnkl1NpW+A+UQOrD4v0di34HCfKRDZa7kjayI42wIvXVU8Dq0Fp+l5rPkG5Fip
        Wd0PKLc2stD4nGH5oXIFdJBr0CmKWkxJviP2kpfBJfEkYwSU60fSXyf2Koz71DUL
        AxcVAmBQa8sTWma60omxPCJpTXgVoJJL5m01BG5oYQwO47pBXezqhv2iel/b+eio
        XVslk/WyScKQQ1maRB1FOpds4rfnE+cTx9LaKDNN/FvRmBD+duXNNj+9/pB7ZhFa
        +kzQxDZMnKwxnmvHWCWdLKSCs8LFj32nkgTFM5pPXrppR6PHKoSsWsJTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=3TgpiGgfAgMkybrRUL0sQxqQ1Qaqse1cW0ceZimbAz8=; b=ibp5dbHN
        5DIkFMpXjufvPjjal4F561FbeRUwEetcYDcsu3TzMYxH/VRz6z5WK+1fPmtb2TE8
        Bbd7jDpegZF2wAr3Xk8DF0bMSvB9t15KW3Jv8bhUgGqYzCJcpPlngrxKrxM3XocQ
        PP9nzSzC8yN6511F5B+pMGy8+sOFRGiR4YvKs9EcOEGGW1dFzhh66VFjWOUpjl/S
        jwE1q8VF08gfC70P62zVtAVXLvsWD0SpE5nk5t6blZAClwW0fDehVs9zHI6pdLa/
        1usGqW7KTJKhmYbtz03b7OLVxGk59DTxwMLgQAaAL9TKXYgmsIscqVekoMJPpHBt
        OU2ZlFkgoily8w==
X-ME-Sender: <xms:6zVKXs3qwOrtHNMhOpIwWSEkrHY6CMseWGiJ0cHXZwap-FmmQavcmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:6zVKXrGhXJpg_eKzHzyKv_QkB2GSIDwm40hOpYpVVP8sSIkOoxfNaQ>
    <xmx:6zVKXj8VA32Zs0Qu2kCGeUvgABTnXoYUNmWnyH5o3Kgax4iIGfMgmA>
    <xmx:6zVKXnkcXdJswB4nrvZOmMxA7RlK7cW54SU3dUT18OFYLd4PAEUtqg>
    <xmx:7DVKXiWXmEgtBBg2DxJ-YN1Az_s7Lb-UMaEL6PujRDbBh98uEb_Ucw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 137EF3280062;
        Mon, 17 Feb 2020 01:42:51 -0500 (EST)
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
        Samuel Holland <samuel@sholland.org>, stable@kernel.org
Subject: [RFC PATCH 01/34] ASoC: dt-bindings: Add a separate compatible for the A64 codec
Date:   Mon, 17 Feb 2020 00:42:17 -0600
Message-Id: <20200217064250.15516-2-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217064250.15516-1-samuel@sholland.org>
References: <20200217064250.15516-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The digital codec in the A64 is largely compatible with the one in the
A33, with two changes:
 - It is missing some muxing options for AIF1/2/3 (not currently
   supported by the driver)
 - It does not have the LRCK inversion issue that A33 has

To fix the Left/Right channel inversion on the A64 caused by the A33
LRCK fix, we need to introduce a new compatible for the codec in the
A64.

Cc: stable@kernel.org
Fixes: ec4a95409d5c ("arm64: dts: allwinner: a64: add nodes necessary for analog sound support")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml  | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
index 55d28268d2f4..7c66409f13ea 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
@@ -15,7 +15,9 @@ properties:
     const: 0
 
   compatible:
-    const: allwinner,sun8i-a33-codec
+    enum:
+      - allwinner,sun8i-a33-codec
+      - allwinner,sun50i-a64-codec
 
   reg:
     maxItems: 1
-- 
2.24.1

