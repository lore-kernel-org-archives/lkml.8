Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11892C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0EA6206D6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942876;
	bh=dUI/gqqz5X+jR1udD0N8RtQtkFl5ejhA8YncUXES4cY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FxLZi8v1r8o6QMv5yOWO/mLNXsAgtJED2sgwsgusGrh5ZG29CYOE4W0ItoHEnZOL3
	 uQ9LJ42VJOc0r4OeOzZPTvFEz1XMXUY3YmIFOToV7c8EWX/BJQrXCgvnLKS3krzVcw
	 Pl9tpQn9lJ5oy9S0Yp9Te65tU0HklYj+Sr2vwCUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbgEHNBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:01:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728299AbgEHMv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:51:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67AF8218AC;
        Fri,  8 May 2020 12:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942317;
        bh=dUI/gqqz5X+jR1udD0N8RtQtkFl5ejhA8YncUXES4cY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BZultaZtqRlq6r2RMCNx5I4HWN+eXy9BDblEn0FTH1PEbMnaRis17RDUD0rRvYrQl
         0N7LOmaiAXSAaZ8LJIJMy6X4zuBpgCJicsfoaYvxlBnJWXEArDLMbIfNnLPAE0cgcC
         6R4O7wyYVaQnDpFe3MmHkZ4rZO2aQdt8R4w+dLeA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Matthias Blankertz <matthias.blankertz@cetitec.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 07/32] ASoC: rsnd: Fix parent SSI start/stop in multi-SSI mode
Date:   Fri,  8 May 2020 14:35:20 +0200
Message-Id: <20200508123035.756624976@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123034.886699170@linuxfoundation.org>
References: <20200508123034.886699170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Blankertz <matthias.blankertz@cetitec.com>

[ Upstream commit a09fb3f28a60ba3e928a1fa94b0456780800299d ]

The parent SSI of a multi-SSI setup must be fully setup, started and
stopped since it is also part of the playback/capture setup. So only
skip the SSI (as per commit 203cdf51f288 ("ASoC: rsnd: SSI parent cares
SWSP bit") and commit 597b046f0d99 ("ASoC: rsnd: control SSICR::EN
correctly")) if the SSI is parent outside of a multi-SSI setup.

Signed-off-by: Matthias Blankertz <matthias.blankertz@cetitec.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/20200415141017.384017-2-matthias.blankertz@cetitec.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 33dc8d6ad35b2..3fe88f7743824 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -375,7 +375,7 @@ static void rsnd_ssi_config_init(struct rsnd_mod *mod,
 	 * We shouldn't exchange SWSP after running.
 	 * This means, parent needs to care it.
 	 */
-	if (rsnd_ssi_is_parent(mod, io))
+	if (rsnd_ssi_is_parent(mod, io) && !rsnd_ssi_multi_slaves(io))
 		goto init_end;
 
 	if (rsnd_io_is_play(io))
@@ -531,7 +531,7 @@ static int rsnd_ssi_start(struct rsnd_mod *mod,
 	 * EN is for data output.
 	 * SSI parent EN is not needed.
 	 */
-	if (rsnd_ssi_is_parent(mod, io))
+	if (rsnd_ssi_is_parent(mod, io) && !rsnd_ssi_multi_slaves(io))
 		return 0;
 
 	ssi->cr_en = EN;
@@ -554,7 +554,7 @@ static int rsnd_ssi_stop(struct rsnd_mod *mod,
 	if (!rsnd_ssi_is_run_mods(mod, io))
 		return 0;
 
-	if (rsnd_ssi_is_parent(mod, io))
+	if (rsnd_ssi_is_parent(mod, io) && !rsnd_ssi_multi_slaves(io))
 		return 0;
 
 	cr  =	ssi->cr_own	|
@@ -592,7 +592,7 @@ static int rsnd_ssi_irq(struct rsnd_mod *mod,
 	if (rsnd_is_gen1(priv))
 		return 0;
 
-	if (rsnd_ssi_is_parent(mod, io))
+	if (rsnd_ssi_is_parent(mod, io) && !rsnd_ssi_multi_slaves(io))
 		return 0;
 
 	if (!rsnd_ssi_is_run_mods(mod, io))
-- 
2.20.1



