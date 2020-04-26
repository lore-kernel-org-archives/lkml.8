Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31001C55194
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 16:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10D252078E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 16:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="G5828/aF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tNRnK53V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgDZQTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 12:19:47 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:45163 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726146AbgDZQTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 12:19:47 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D631D5C0108;
        Sun, 26 Apr 2020 12:19:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 26 Apr 2020 12:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=08cZaxzjUx3KWTJnjYaSKDI0WL
        CA0zQwamq6nPQn4BA=; b=G5828/aF5IPOjVpUeSAGbVkj4QRJ+CtHAvLIfPzpjg
        lAcySDrltHxO0N5lb8l5+KfRbuR6yNSgkzk08vEWO837mfX3VTdAz9VNvQq6B1Aw
        93ny0TcXtt6uCF5qNiOcHtWjlgtbKg8o7sTAWTGVUoAzChIMbnEBBuIagd/d2xXa
        VCtRgMl+VYtFpLTj827TQMKA3N87R4wkZMTIXeBgdcwN4wxC4quPDyyb+J6BglSG
        zLG/vUBBK1vI+yXKcsI2SoDi6Heo+TJDSVhstvlqkRhwI5QUGl9QYYx7U/0k1kFR
        aDNoQyDibvY2/uedftS8MD7sRMM+B3jzWkQpjGPdsdJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=08cZaxzjUx3KWTJnj
        YaSKDI0WLCA0zQwamq6nPQn4BA=; b=tNRnK53VNLGw1CRlP9uKY7OXsv4PXryXp
        YieyKzdUsb6lNWglKdmtV/ZDOAeFq5TfQEJ6oyNFj9ulW/kXLxUKeMS6fcFrgxX1
        LhRc3GV/Waam5R6CF2H5DFSzvezsKeqgxOMhmxgn4NN6sW6/+hmt0UWCKg3xSZfw
        S0w1GAkNfFNlMNRT7nRQfvqg0dwRTs6j0NyMqnEEWDo/70rAiXxbwHk3Me4sduvB
        iB+V94FaPfRK12ruN1twyFH80PjKTSslwON0HoiihB5pIGQEwzblRLx8MV9duWeD
        /grhp2vcyQEBrn0KyHKOmzteCaDG46DyTpGyQZB45zVDVfUdX8ecg==
X-ME-Sender: <xms:obSlXvjnBYbqsqY9ls8Hy7CgGy4hUMo9R1flmMw4C6PY6OzNkn7NSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrheejgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkphepje
    dtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:obSlXtSw5sIBQEpiw6MCyCVcEwm9RUMU6ThAQuPdT9AaBGIToDPp2w>
    <xmx:obSlXnjGT50zvjz0lQLb5mWwYAIYZu_Y7qhkRF4UN_VXdDblDe7Kcg>
    <xmx:obSlXidiWACOzH8ALbl9iQj3LWrOm5VIXja5xhqtM2GcJZttF9zCkg>
    <xmx:obSlXmu3bo8bFGj6rfG5qVHSTMis9A5myyopj7ljTKrREGOfwkemYg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0EF183280060;
        Sun, 26 Apr 2020 12:19:45 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH] arm64: dts: allwinner: a64: pinetab: Fix cpvdd supply name
Date:   Sun, 26 Apr 2020 11:23:53 -0500
Message-Id: <20200426162353.52465-1-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An older version of the analog codec binding referenced the headphone
amplifier binding as "hpvcc". However, by the time it was merged in
commit 21dd30200e3d ("ASoC: dt-bindings: sun50i-codec-analog: Add
headphone amp regulator supply"), the regulator reference was renamed to
"cpvdd". This board's device tree still uses the old name, which fails
to work at runtime, and which causes a warning from `make dtbs_check`.
Resolve both by fixing the name.

Fixes: 674ef1d0a7b2 ("arm64: dts: allwinner: a64: add support for PineTab")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
index 316e8a443913..dc4ab6b434f9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
@@ -98,7 +98,7 @@ &codec {
 };
 
 &codec_analog {
-	hpvcc-supply = <&reg_eldo1>;
+	cpvdd-supply = <&reg_eldo1>;
 	status = "okay";
 };
 
-- 
2.24.1

