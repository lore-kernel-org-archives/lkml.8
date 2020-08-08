Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB1BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 01:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62AD72177B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 01:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NodTcolu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgHHBVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 21:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgHHBVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 21:21:54 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798A5C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 18:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=kj/TToLcJ4MZ4DSCFCc73HaSywbCEpwgumzWbAteKWw=; b=NodTcoluF+cVQR1Dznu5pYqr9Z
        m4eh1cbcGYn+ysAvsKmVqOI2N4Z+RccveAQLTgMt08eGLqqYokoC07HaJG4LuRSdS/tdqzQdgmT5Y
        z/vOvKXZbeqAHBLOPpycsd7oAfoqAtcRb8VyiloA3LYXIUH1FNzW36b64h/7VivE1xQNnyCbJ1z3f
        2dBHV+VZuD8E1sCsYJhiedUCfHIEefOwj8TI8GSGYZDEmQw3pb9qsYHu7G3iQy27HjMpgmj7tiNxy
        NYxUFQXFP0T/y4RAKpfVXwmhMJrJbqBi3QVDYOG5oCxhW00KmoOnZ1e7CArztVm4qpHiJKQxD5bUT
        RNp5r0Bg==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k4DYU-0001Eu-8S; Sat, 08 Aug 2020 01:21:50 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: codecs: delete repeated words in comments
Date:   Fri,  7 Aug 2020 18:21:43 -0700
Message-Id: <20200808012143.10777-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated words {start, it, the} in comments.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/codecs/nau8825.c |    2 +-
 sound/soc/codecs/tas5086.c |    2 +-
 sound/soc/codecs/wm9713.c  |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20200807.orig/sound/soc/codecs/nau8825.c
+++ linux-next-20200807/sound/soc/codecs/nau8825.c
@@ -251,7 +251,7 @@ static const unsigned short logtable[256
  *
  * Acquires the semaphore without jiffies. Try to acquire the semaphore
  * atomically. Returns 0 if the semaphore has been acquired successfully
- * or 1 if it it cannot be acquired.
+ * or 1 if it cannot be acquired.
  */
 static int nau8825_sema_acquire(struct nau8825 *nau8825, long timeout)
 {
--- linux-next-20200807.orig/sound/soc/codecs/tas5086.c
+++ linux-next-20200807/sound/soc/codecs/tas5086.c
@@ -487,7 +487,7 @@ static int tas5086_init(struct device *d
 	/*
 	 * If any of the channels is configured to start in Mid-Z mode,
 	 * configure 'part 1' of the PWM starts to use Mid-Z, and tell
-	 * all configured mid-z channels to start start under 'part 1'.
+	 * all configured mid-z channels to start under 'part 1'.
 	 */
 	if (priv->pwm_start_mid_z)
 		regmap_write(priv->regmap, TAS5086_PWM_START,
--- linux-next-20200807.orig/sound/soc/codecs/wm9713.c
+++ linux-next-20200807/sound/soc/codecs/wm9713.c
@@ -755,7 +755,7 @@ static void pll_factors(struct snd_soc_c
 	u64 Kpart;
 	unsigned int K, Ndiv, Nmod, target;
 
-	/* The the PLL output is always 98.304MHz. */
+	/* The PLL output is always 98.304MHz. */
 	target = 98304000;
 
 	/* If the input frequency is over 14.4MHz then scale it down. */
