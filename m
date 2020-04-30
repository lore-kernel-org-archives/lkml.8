Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB44C28CBC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5F742063A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588255909;
	bh=nsssbZy682qJB1nLB7JZpO040fXKDc94Bx3ipos/8Ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OvjaefW8AUTV3jh/kFafspzgu9x3nssstnPqxoA8TnSS2eYZg1/OJv6Ocx7wvc4Cy
	 77f8bQJAcB6dXwgkq4P6KVk1VlngGyIo8amfNvzyQsXS0zBkajyaPwARnd2S76Ro5Q
	 VEkSEGAxWq+K5x2dP/ffz2jA9Vsv/ElUpWrf27HI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbgD3OLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:11:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbgD3NvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:51:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13A57208DB;
        Thu, 30 Apr 2020 13:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588254678;
        bh=nsssbZy682qJB1nLB7JZpO040fXKDc94Bx3ipos/8Ik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CmISad+wyL6ocs1NjbGu0GWHl4IDqdVLG1YXzsFtNqiCCLARSfus+Cialyb4RPOT/
         ccH/hYgkf2VvQTMxrD98+IaNHhV8dQr8WiAbdiQl9ccycVbqceAkqWIEpI9Lp+OqGU
         hoxLu5A9B6+X3mIZTb+Rg3MeKwdCWSI+5oSSlBYk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matthias Blankertz <matthias.blankertz@cetitec.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.6 30/79] ASoC: rsnd: Fix HDMI channel mapping for multi-SSI mode
Date:   Thu, 30 Apr 2020 09:49:54 -0400
Message-Id: <20200430135043.19851-30-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135043.19851-1-sashal@kernel.org>
References: <20200430135043.19851-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

