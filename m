Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622F2C7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354A621582
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="nQN89O1n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NWebf0hC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgBQGm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:42:59 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:38951 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726823AbgBQGmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:42:55 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 58674539F;
        Mon, 17 Feb 2020 01:42:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 17 Feb 2020 01:42:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=if7xr+Sp8ss0f
        9YqwMqw18AX7QTuXK6q1CEVj33p/34=; b=nQN89O1nFLZtQYlqH89I0Kmx5EBrM
        JMjAqr2aBnz9Jw97GauexifTLIRYSYN5hIxTERMKL/QnzrjwN5aKGUtkEqk6vYOi
        OQFo+90INsKRq+6zr0XagjGvUqLrKOQ+ZYJNLFYuw5h6Ru23GFvWhXGMQohg7HFO
        mHUpYtDKm1vwTBT7biF9+Ip7G7q0S47GxfFFRkl8ruwXjvGxDqORdboD5d+P7L7v
        DdyWxwzb0ML3LLFNeU8py2b+wJQiTNxDFhaPQlr/AlgqAuucOWVW95cdkX42zqop
        XKe2THxeuGSxNzUgTDwkJQynH0mG5K1Seqtyi+t/0J+Rm68wEtBQloIbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=if7xr+Sp8ss0f9YqwMqw18AX7QTuXK6q1CEVj33p/34=; b=NWebf0hC
        YRw2t54WE710Iix4f2kX216aODyK7MaXe40G22nwq4NM1S8E83ycvMWxTFOngoJy
        96tGCTRiGTZsHFpu6iAcP6MXTy/Am8MqItLB46CyXmq8KI1YHtFZ8OVwIupjheOA
        RT4VNK1gopc22IkSlHqBZcHKl0EQNEMZcrfnvQBkYdPSxuFQv9UpDPtzrxIJk7vm
        fPiBrvRoofsLEAsnwMHHVqHdz3MiWBpm93ykAsX+BVrF2T5hMr6QnyeTgw3y4oes
        SSKUAVa6PetTsGFM81A/MZloxu0pHtl/jivQVWKA2eYdFJaPJwrP5oWHd+LbzCRs
        d/tC/IzkTI1oHg==
X-ME-Sender: <xms:7jVKXgk9WbQi4qoVVqHJXTPVoZa2Gp-2PbCu8zF1DluYo33TYXt7AQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:7jVKXrwoToJ4ItX6p0QNZsgmwgbQpmAgW0R4SKpsT07CB7_EaExfyQ>
    <xmx:7jVKXhtdweaRWVC5t2ZNqexYIqTV1RF1163UNVD99zGVBrkrcMFUYQ>
    <xmx:7jVKXn-Wrmj-oeXIaSZVXpPjBdgerAzMoQR6JKLSiGDScpYpTQ_iMQ>
    <xmx:7jVKXnNN2Lg85QfQl7EnCuE65MmvuxwZ1WWkfHTJXLne0esz1VcxpA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 935FC328005E;
        Mon, 17 Feb 2020 01:42:53 -0500 (EST)
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
Subject: [RFC PATCH 05/34] ASoC: sun8i-codec: Remove incorrect SND_SOC_DAIFMT_DSP_B
Date:   Mon, 17 Feb 2020 00:42:21 -0600
Message-Id: <20200217064250.15516-6-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217064250.15516-1-samuel@sholland.org>
References: <20200217064250.15516-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DSP_A and DSP_B are not interchangeable. The timing used by the codec in
DSP mode is consistent with DSP_A. This is verified with an EG25-G modem
connected to AIF2, as well as by comparing with the BSP driver.

Remove the DSP_B option, as it is not supported by the hardware.

Cc: stable@kernel.org
Fixes: 36c684936fae ("ASoC: Add sun8i digital audio codec")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 33ffbc2be47c..32b7410540c6 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -236,7 +236,6 @@ static int sun8i_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		value = 0x2;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
-	case SND_SOC_DAIFMT_DSP_B:
 		value = 0x3;
 		break;
 	default:
-- 
2.24.1

