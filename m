Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D6BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 01:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CBA02177B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 01:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ujLFssNj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgHHBWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 21:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgHHBWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 21:22:04 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F07C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 18:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=BqIe6wVBUZ+EVoJme1CUcrA3q6AE77m2FxI7AFPRogI=; b=ujLFssNjue/D+gp3CS494AV7lo
        IhIj/Eq/H3VQxz9TJzCP9dOy8qZ6LE/ni81MQUKpSl3NWJBud13E/fPLdfFWYXimoF0NJUifaweMW
        PRHBrRcPEl5cXgNo/Q+EkmACP2Gqzce0ukHW0WMGVKgt5tN8SyCgQ7k2zJINodMHI3GllRHjKDa+x
        TuFM3EEcllOHKZYMXp3wvlzd0U9hWKyiPjN+zr+/PsAOxcSbyyVebnKPQETkvD+1vXz1DLnm7pdT+
        lf1+QsjWRdGz56+6Wqz2z8brF4Gqtm8nWtTRdrz0MvECb4u16zwQ0X4gZlyX/ewfzkLvs5P9PVkC9
        Sw5xtOuQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k4DYf-0001GM-3m; Sat, 08 Aug 2020 01:22:01 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: SOF: delete repeated words in comments
Date:   Fri,  7 Aug 2020 18:21:56 -0700
Message-Id: <20200808012156.10827-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated words {that, the} in comments.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/sof/intel/cnl.c |    2 +-
 sound/soc/sof/sof-audio.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200807.orig/sound/soc/sof/intel/cnl.c
+++ linux-next-20200807/sound/soc/sof/intel/cnl.c
@@ -202,7 +202,7 @@ static int cnl_ipc_send_msg(struct snd_s
 	 * IPCs are sent at a high-rate. mod_delayed_work()
 	 * modifies the timer if the work is pending.
 	 * Also, a new delayed work should not be queued after the
-	 * the CTX_SAVE IPC, which is sent before the DSP enters D3.
+	 * CTX_SAVE IPC, which is sent before the DSP enters D3.
 	 */
 	if (hdr->cmd != (SOF_IPC_GLB_PM_MSG | SOF_IPC_PM_CTX_SAVE))
 		mod_delayed_work(system_wq, &hdev->d0i3_work,
--- linux-next-20200807.orig/sound/soc/sof/sof-audio.c
+++ linux-next-20200807/sound/soc/sof/sof-audio.c
@@ -29,7 +29,7 @@ bool snd_sof_dsp_only_d0i3_compatible_st
 				continue;
 
 			/*
-			 * substream->runtime being not NULL indicates that
+			 * substream->runtime being not NULL indicates
 			 * that the stream is open. No need to check the
 			 * stream state.
 			 */
