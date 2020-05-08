Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32644C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F33BE24958
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942530;
	bh=nsssbZy682qJB1nLB7JZpO040fXKDc94Bx3ipos/8Ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lmIGNPt50XmjQL5F7cRPGZVE4DyaMd04h+yFnzWV1EsMgFia79kVY8AAlu0SICnJe
	 kfPRa9ioQLTRTc2PYG+9mYzp8ISlXGXdBV8KqMzdmgGCGclVXmLRzibFMMweyNXdQr
	 xZ85RTcZqFoQBUbLaQ/2DR9yvvhCTefFRnzSGUYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbgEHMz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:55:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730320AbgEHMzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:55:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A677A24963;
        Fri,  8 May 2020 12:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942520;
        bh=nsssbZy682qJB1nLB7JZpO040fXKDc94Bx3ipos/8Ik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lGxQWn0yM1d1snw46SF2yx3gNJuoC8JfhANYsgHpq+7FKskY5wR3Z3QU+C9caEL29
         cz2l/lPKFzekL3ZpYvvOi/55f2+599S/J6/Nu7OhwUdcd/9PUS96sDvzgQiiDmf8j2
         AukuYEVx30cc4GtpCQcXXL10KGsk+2C2utxqfG5Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Matthias Blankertz <matthias.blankertz@cetitec.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 20/49] ASoC: rsnd: Fix HDMI channel mapping for multi-SSI mode
Date:   Fri,  8 May 2020 14:35:37 +0200
Message-Id: <20200508123045.833953087@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123042.775047422@linuxfoundation.org>
References: <20200508123042.775047422@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Blankertz <matthias.blankertz@cetitec.com>

[ Upstream commit b94e164759b82d0c1c80d4b1c8f12c9bee83f11d ]

The HDMI?_SEL register maps up to four stereo SSI data lanes onto the
sdata[0..3] inputs of the HDMI output block. The upper half of the
register contains four blocks of 4 bits, with the most significant
controlling the sdata3 line and the least significant the sdata0 line.

The shift calculation has an off-by-one error, causing the parent SSI to
be mapped to sdata3, the first multi-SSI child to sdata0 and so forth.
As the parent SSI transmits the stereo L/R channels, and the HDMI core
expects it on the sdata0 line, this causes no audio to be output when
playing stereo audio on a multichannel capable HDMI out, and
multichannel audio has permutated channels.

Fix the shift calculation to map the parent SSI to sdata0, the first
child to sdata1 etc.

Signed-off-by: Matthias Blankertz <matthias.blankertz@cetitec.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/20200415141017.384017-3-matthias.blankertz@cetitec.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sh/rcar/ssiu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index f35d882118874..9c7c3e7539c93 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -221,7 +221,7 @@ static int rsnd_ssiu_init_gen2(struct rsnd_mod *mod,
 			i;
 
 		for_each_rsnd_mod_array(i, pos, io, rsnd_ssi_array) {
-			shift	= (i * 4) + 16;
+			shift	= (i * 4) + 20;
 			val	= (val & ~(0xF << shift)) |
 				rsnd_mod_id(pos) << shift;
 		}
-- 
2.20.1



