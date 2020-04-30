Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB57C47254
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C46A32063A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588255558;
	bh=Kl08CSxK9cTZLizw5W56/tm53VbSYubwztTv1wcNJCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rTpPTBjBvn2A6SsVbmFR2U7ft53SK852bF2YFeKNmgphZa2Kf80Yjj/XLPWaAyuP5
	 ZyGaxPG+da+9JKAkrNbFisMVm2wq8XH5pv1rmHSqfvgM6yROaPBWdmZVHyObaiLzdU
	 ELPbuHXBctuCUmqYoc9+EWZ30jGdhjOdGP3u1dGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgD3OF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:05:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728551AbgD3Nw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:52:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F0E424954;
        Thu, 30 Apr 2020 13:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588254776;
        bh=Kl08CSxK9cTZLizw5W56/tm53VbSYubwztTv1wcNJCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PQDe6tM8lUqR44W+S5zy0jgkYyk0DfAnSReYsYOqvJEEUbw/2CQdDWSnNRLgpPsu5
         gRxPIK1ytRK7eex7ZImuy/vfqBIft3d67bLhXg6d/XKL0BRmeXFWn7GbwcXOF1Uhgi
         qF++SeqsuSNoBiuUURVz3p0loQKX9GgXqIIdYZ5c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matthias Blankertz <matthias.blankertz@cetitec.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.4 33/57] ASoC: rsnd: Fix "status check failed" spam for multi-SSI
Date:   Thu, 30 Apr 2020 09:51:54 -0400
Message-Id: <20200430135218.20372-33-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135218.20372-1-sashal@kernel.org>
References: <20200430135218.20372-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Blankertz <matthias.blankertz@cetitec.com>

[ Upstream commit 54cb6221688660670a2e430892d7f4e6370263b8 ]

Fix the rsnd_ssi_stop function to skip disabling the individual SSIs of
a multi-SSI setup, as the actual stop is performed by rsnd_ssiu_stop_gen2
- the same logic as in rsnd_ssi_start. The attempt to disable these SSIs
was harmless, but caused a "status check failed" message to be printed
for every SSI in the multi-SSI setup.
The disabling of interrupts is still performed, as they are enabled for
all SSIs in rsnd_ssi_init, but care is taken to not accidentally set the
EN bit for an SSI where it was not set by rsnd_ssi_start.

Signed-off-by: Matthias Blankertz <matthias.blankertz@cetitec.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/20200417153017.1744454-3-matthias.blankertz@cetitec.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 9900a4f6f4e53..4a7d3413917fc 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -594,10 +594,16 @@ static int rsnd_ssi_stop(struct rsnd_mod *mod,
 	 * Capture:  It might not receave data. Do nothing
 	 */
 	if (rsnd_io_is_play(io)) {
-		rsnd_mod_write(mod, SSICR, cr | EN);
+		rsnd_mod_write(mod, SSICR, cr | ssi->cr_en);
 		rsnd_ssi_status_check(mod, DIRQ);
 	}
 
+	/* In multi-SSI mode, stop is performed by setting ssi0129 in
+	 * SSI_CONTROL to 0 (in rsnd_ssio_stop_gen2). Do nothing here.
+	 */
+	if (rsnd_ssi_multi_slaves_runtime(io))
+		return 0;
+
 	/*
 	 * disable SSI,
 	 * and, wait idle state
-- 
2.20.1

