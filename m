Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8546C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A43D22054F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942665;
	bh=Kl08CSxK9cTZLizw5W56/tm53VbSYubwztTv1wcNJCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q4FXRPuazDUsS8hkEUNfNOTKgCvoRXgV7pC8j7/l/v2y8PtAJoQ6nQFusFuSvzAwf
	 ybAaE6qxt8fqA8dIjnlgZ0JkX31s/s2wRw696zl6szjLAsCdfrU3vqMSkIrGzmM2Rx
	 LA2h5u+qpD7J8R+seqrD2YgC647yRTAc9Cvj8w5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbgEHM5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:57:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730040AbgEHMzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:55:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F03C2496C;
        Fri,  8 May 2020 12:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942522;
        bh=Kl08CSxK9cTZLizw5W56/tm53VbSYubwztTv1wcNJCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HLD6R1J7ECLpAHJ0a6igpYs8zqeD0WmEPmh1+KOLPpbm9D7iiUo02+XXih1m9/2Lr
         /Xc4ae2aaKDOIzT0Riuskw4MdZltMntg4Mg+jSPIWMtGbEDeAcy4pVN0Eg2DDveLVd
         AX3ZkWsWnRS0NUvoEEY5Oz3w9kvqRgalJ4c+c+jU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Matthias Blankertz <matthias.blankertz@cetitec.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 29/49] ASoC: rsnd: Fix "status check failed" spam for multi-SSI
Date:   Fri,  8 May 2020 14:35:46 +0200
Message-Id: <20200508123047.128233809@linuxfoundation.org>
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



