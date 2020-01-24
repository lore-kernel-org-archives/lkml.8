Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A155BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFC120718
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859794;
	bh=Wyt7kKObs3IeoCChhvP5yUkQWJnhvUrcliU7CHUkkbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k7aNaADlpBYxO751UWwrv80zkHoleeeGnE75Ej8uwAm34fqZgFYusVTPlIFVJxr+i
	 LnKWC89/TF/IV6qSGnQB6MGuF2mJtk5Fr6SdjQ8axNJtKczej/JDAdV4r1Nq5mum5J
	 H+OYXGEH22/z+tdYrw0NSqRt+Q1I7hKVsMBU+0J8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388551AbgAXJ4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:56:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:60256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731098AbgAXJ4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:56:32 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6DD120718;
        Fri, 24 Jan 2020 09:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859791;
        bh=Wyt7kKObs3IeoCChhvP5yUkQWJnhvUrcliU7CHUkkbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qu45g/qzuvXUw5iA5UOXSv04OXU4s6Rs17Ph2yfXpt6c/jlaeH8jjz4LzhtGtPb9V
         x/YGUa8tM171RF553bFdfj2LpmIDFUcqUiQNe3AVc0l5nrA6maaae6p2Tcgz7BueDM
         jeRFCbgnj+tFbz+e84OUnapVI8g6XmHMj8p5L5ik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 183/343] ASoC: fix valid stream condition
Date:   Fri, 24 Jan 2020 10:30:01 +0100
Message-Id: <20200124092944.102585804@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit 6a7c59c6d9f3b280e81d7a04bbe4e55e90152dce ]

A stream may specify a rate range using 'rate_min' and 'rate_max', so a
stream may be valid and not specify any rates. However, as stream cannot
be valid and not have any channel. Let's use this condition instead to
determine if a stream is valid or not.

Fixes: cde79035c6cf ("ASoC: Handle multiple codecs with split playback / capture")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 24047375c2fbb..70e1a60a2e980 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -48,8 +48,8 @@ static bool snd_soc_dai_stream_valid(struct snd_soc_dai *dai, int stream)
 	else
 		codec_stream = &dai->driver->capture;
 
-	/* If the codec specifies any rate at all, it supports the stream. */
-	return codec_stream->rates;
+	/* If the codec specifies any channels at all, it supports the stream */
+	return codec_stream->channels_min;
 }
 
 /**
-- 
2.20.1



