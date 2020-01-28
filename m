Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802B7C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F0621739
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221194;
	bh=+i9riZwgAlitsQK1UdlrrNHwVbuIjA51i/mTjN7k/Aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yrLmKpbwosmnut9aZtwqww20hy9eO/bb2rZg/049Lj6LzNmoM7uR3/cJz986x7hdN
	 SXClRr1RM6jZKMEexVgUqds3XL2cWN/GHfSRR79M5FAfw1nQXX7xZBrIS3qkoqkqoT
	 5rEVVzYBtY4W7A2ubFY4B76G31rAHKJpTmt7kIyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbgA1OTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:19:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:44336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730525AbgA1OTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:19:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 113542071E;
        Tue, 28 Jan 2020 14:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221188;
        bh=+i9riZwgAlitsQK1UdlrrNHwVbuIjA51i/mTjN7k/Aw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HJRkTd98yUjv5f9cWl8N+Zy87omhsXw9N7FtUI2NTIIYEqZaOVFaw1ENXluMCpRLU
         Y4wDUhmnyqS1Gjv905d7hpG24QJVnQyDG6fCol1RLYBkS+fNSu7/z8wLtq3beWNG8k
         woIkmZlKaasT1PwV+HQ/dIFxIHe3SG/zjZUHN1lQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 125/271] ASoC: fix valid stream condition
Date:   Tue, 28 Jan 2020 15:04:34 +0100
Message-Id: <20200128135901.900320837@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
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
index d69559e458725..635b22fa1101a 100644
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



