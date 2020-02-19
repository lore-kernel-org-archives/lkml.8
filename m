Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FE9C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1DC24654
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QlJeS/Ww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgBSLu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 06:50:59 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55721 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgBSLu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 06:50:58 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so288799wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 03:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=13koyGRfSI36B094w+YJ/HafK6KqgQmhuR18/pfh9NY=;
        b=QlJeS/WwAZ1oyQx8kTcmP7FFIOZmvhu6bpQ73FDD+kRCkIqNiJoQWbCB1lILOHaNdX
         ccRBFDlCOD4z6eUkgQPmhe4ShjrQSjlX1OaoICSfj2gEuySpV1cyuxEPx9SVXpmJoCu6
         K7b5s7pQAW9gEQTl5I6OH9RDtlv8q0M6Iw7AM+H0PsYr1yCvVUIkcGWEw+l6BaiAp99A
         w8JaRcOjStRwOSkvHv/CYTuoO5fNxKGLAi3MKbZv7+ZzH/amgBY14OdfFcKtX3qKttH8
         Bb62rS9cUFOStgbqNjeuQKnZ0M2mbQhcVwUVm4jpomvXs+RakwNcdWz3+vq7yu/keYvQ
         cj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=13koyGRfSI36B094w+YJ/HafK6KqgQmhuR18/pfh9NY=;
        b=fm4ceu6nxRmCCVE2aegZfImonW4CQ4kuRub7yrnVmKpe+U4NBLtAIkQ9yeqi5AZ+/N
         IoUZNfGjdI7lESOwfc5udFD2ZvmqurAC6TwlxT9BuH5P5Rrjl0TN2mdnX/+OntfFPrW5
         NKBM8tnVgh8XBYyMmCKexaBMnASLOw+JaeEgNycWQmZFJVBEGnADxSj9msQuhB/PLRqi
         8sEJMMA7WG3wJry7SMaoQUQ7Yd+3KGqfd3I9l9KTnuWfdglNyuksKy0mh8+m7lcRp41a
         8EXzztPtnKHcWSHqHVjhzsQrvbvcU7J5rAvln7ksxjUru26DgO680nc6/hPXVmx38ZXy
         hmTg==
X-Gm-Message-State: APjAAAVnp6tN1J0IxSpiPGBkAKkchxbKc8ds8ALuWAmKy5BwmHdapOgw
        2FETL2WmKMsr4y0v3+q4FPOHFA==
X-Google-Smtp-Source: APXvYqzQI4jfpHJN/5WPr1SSQOvLgeK/S64Itpix079YcW1KNtXmMgZuqHhXGf/bMC11dLJcOMSu6w==
X-Received: by 2002:a1c:5f06:: with SMTP id t6mr9808280wmb.32.1582113056786;
        Wed, 19 Feb 2020 03:50:56 -0800 (PST)
Received: from localhost.localdomain (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id b10sm2628851wrw.61.2020.02.19.03.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 03:50:56 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH] ASoC: dpcm: remove confusing trace in dpcm_get_be()
Date:   Wed, 19 Feb 2020 12:50:48 +0100
Message-Id: <20200219115048.934678-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that dpcm_get_be() is used in dpcm_end_walk_at_be(), it is not a error
if this function does not find a BE for the provided widget. Remove the
related dev_err() trace which is confusing since things might be working
as expected.

When called from dpcm_add_paths(), it is an error if dpcm_get_be() fails to
find a BE for the provided widget. The necessary error trace is already
done in this case.

Fixes: 027a48387183 ("ASoC: soc-pcm: use dpcm_get_be() at dpcm_end_walk_at_be()")
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/soc-pcm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 63f67eb7c077..aff27c8599ef 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1270,9 +1270,7 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 		}
 	}
 
-	/* dai link name and stream name set correctly ? */
-	dev_err(card->dev, "ASoC: can't get %s BE for %s\n",
-		stream ? "capture" : "playback", widget->name);
+	/* Widget provided is not a BE */
 	return NULL;
 }
 
-- 
2.24.1

