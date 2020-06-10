Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB9DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E97842072F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DvnUv3KU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgFJKIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 06:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgFJKId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:08:33 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD312C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 03:08:32 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l11so1597717wru.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 03:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4WcGKmG4Em8CGRb1sOMBrhLYqKdA8bExoZ3wWUVyJW4=;
        b=DvnUv3KU4S8Lh5Uv8DrTXTyD2Uj2tPoCzCpgSJuoIIi5t8AAL6UWyXNqU6dvIfmiVP
         5ewlP1kMqc2IQyDUCGfTmoSGbTIdCHvOdbzKVlaYO+cBe3jKihid/K3MxumsSXd3PJgn
         pfaAQ/6v6vV79Nsm2WX4v4XsXm/5tP1gl9vALFZ5Yw2wMuaBbiQ+7jjIqAfG3PVowqGo
         PE3Rq4djozkWLBSSO/0hFnCh3edPks5UY4kHeeM/T5ejDkYUWJTV2Sip3DdDB+PNegNO
         Y0iPXY/M/Gt++1lOp4EebQ/1EdyqmlpnLB2QQre5lYnaD7Ig5AxPa+mtI9E13T+fuwEF
         EUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4WcGKmG4Em8CGRb1sOMBrhLYqKdA8bExoZ3wWUVyJW4=;
        b=EUksgUwnTdcWDRl2J7OcS05Hsy6YaokiakJIktmyPE5+uxZ/5LldgrBZhMzpaiOycI
         JeB4AfzE7XJSdTGv2g/9rQ+fUH5SZyKH01qMs1DlWqs641mvU87KBoObyAc7m0qvM3Gh
         YaBfARnW2vBxatNSi+zOK5ZUH9orYJOHbOFi4TvnXxDlDSOQsfNP09Tu9/og8D9DvVl3
         xSqFfeIPaFUvE5HLYtKd3Xb8f52Mzrqipmaf2wYg9y2VjSdovax6knGKClgCz87Z7SiZ
         R8I0s4ncB+fbWHan59NTHMvCXqJrlng29b+bJbYTop3ItrzDCqBK7E3QsieOCiGEZqm7
         oIrw==
X-Gm-Message-State: AOAM5330chKpnRY5uafLqMlsEGClD6aosoNS+uWC8q1FSzYM+uURmBH+
        IqeO6c6+Qv/51AAouvhoOjHmlg==
X-Google-Smtp-Source: ABdhPJw09wktHVTyjsGCacuk2gE1D/IgwGZO8zvrddmzIg9nGy2ATklylYksTfUUgBkSifQjEwm+hw==
X-Received: by 2002:adf:e40c:: with SMTP id g12mr2808457wrm.121.1591783709471;
        Wed, 10 Jun 2020 03:08:29 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id b14sm2755955wmb.20.2020.06.10.03.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 03:08:28 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH] ALSA: compress: Fix gapless playback state machine
Date:   Wed, 10 Jun 2020 11:07:29 +0100
Message-Id: <20200610100729.362-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For gapless playback call to snd_compr_drain_notify() after
partial drain should put the state to SNDRV_PCM_STATE_RUNNING
rather than SNDRV_PCM_STATE_SETUP as the driver is ready to
process the buffers for new track.

With existing code, if we are playing 3 tracks in gapless, after
partial drain finished on previous track 1 the state is set to
SNDRV_PCM_STATE_SETUP which is then moved to SNDRV_PCM_STATE_PREPARED
after data write. With this state calls to snd_compr_next_track() and
few other calls will fail as they expect the state to be in
SNDRV_PCM_STATE_RUNNING.

Here is the sequence of events and state transitions:

1. set_params (Track 1), state =  SNDRV_PCM_STATE_SETUP
2. set_metadata (Track 1), no state change, state = SNDRV_PCM_STATE_SETUP
3. fill and trigger start (Track 1), state = SNDRV_PCM_STATE_RUNNING
4. set_next_track (Track 2), state = SNDRV_PCM_STATE_RUNNING
5. partial_drain (Track 1), state = SNDRV_PCM_STATE_SETUP
6  snd_compr_drain_notify (Track 1), state = SNDRV_PCM_STATE_SETUP
7. fill data (Track 2), state = SNDRV_PCM_STATE_PREPARED
8. set_metadata (Track 3), no state change, state = SNDRV_PCM_STATE_PREPARED
9. set_next_track (Track 3), !! FAILURE as state != SNDRV_PCM_STATE_RUNNING

Fixes: f44f2a5417b2 ("ALSA: compress: fix drain calls blocking other compress functions (v6)")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---

I wonder who did gapless work on upstream so far?

 include/sound/compress_driver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
index 6ce8effa0b12..eabac33864c2 100644
--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -182,7 +182,7 @@ static inline void snd_compr_drain_notify(struct snd_compr_stream *stream)
 	if (snd_BUG_ON(!stream))
 		return;
 
-	stream->runtime->state = SNDRV_PCM_STATE_SETUP;
+	stream->runtime->state = SNDRV_PCM_STATE_RUNNING;
 
 	wake_up(&stream->runtime->sleep);
 }
-- 
2.21.0

