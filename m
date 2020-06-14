Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E92EC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 03:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2DAE2084D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 03:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="LGu4gU9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgFNDh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 23:37:57 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:54714 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgFNDh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 23:37:57 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 49l0Xh2pkyz9vYTw
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 03:37:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DAiKyY9yeOut for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 22:37:56 -0500 (CDT)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 49l0Xh180zz9vYTj
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 22:37:56 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 49l0Xh180zz9vYTj
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 49l0Xh180zz9vYTj
Received: by mail-il1-f198.google.com with SMTP id o12so9539588ilf.6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 20:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=IEXT8U99mfgcaOdzCXO1tyuVnx/v3mvO9nIAZY0Vi9A=;
        b=LGu4gU9jBSN6jiOgLF41ABPSsY/SbnVsxr7z9IYaoaFRSa+PwgUohjJtEcBpz0YquI
         vlvAhzT7q3EJefDVovTfAvEKoSA3LEHZjME9tIv1zzQuyrUAitpTSu2JMzm2RmaCxsrb
         uMimGbJPmVjbDStWXv9le/WaB6MzdbE31YruEjQiOP20nslrOHn3fgHA26itdNxlRmh0
         rRvuuE0Jb3zV974QSZ3Nwfc1tFvOWwPyi8UAeqnVFm5bM7paFHLpFxlgEejUZL0dNfzl
         jw4MehN+jaPcLd1otPtLJ2j8VccfnoNzkWPuld3mku/oqw8aetUMdTEiZLjWlh+4hiis
         1V3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IEXT8U99mfgcaOdzCXO1tyuVnx/v3mvO9nIAZY0Vi9A=;
        b=OBpy9Tx9lgUfljzByYQaOpDESz4Sevghy2fBq80e/67g1hqmdW3v2Iq3rc9G9OmYQe
         jnMigFBEJ6LXnj5UY08AuwXK2dmV+JG27LmH90ntGaKzA9q+rRVRJUzmyGJetpsiQs0e
         VMeQuWPXyboUvlk0LyyxnAGbcP0FzGuu3RFvlCpUdT6dzyKU5kRoGUIkG+XkG6CJqAWi
         P2+3RquifMpwg5ffADn5LiVnLpa+mmjVtFaJ2RcJvjxrD1/8ZXjue52xNmyskNBhnq4a
         Hlt+yY0NaRAh6ICdnsPmGnFdp0KfXuxzCd8mwpVmJww9jP76sBWb2VAju+7J7mo+Eb7i
         BdDQ==
X-Gm-Message-State: AOAM533xIhvnDNEoEowXwMLifa35xEgpUIjU2Lrzej2O4Djtc0DYguR7
        5UsXBRvGFWjMuyN4mE+4D7c5d1zXZzViQviVy5exIPeyubmpoW/QApls95fprkEzLCAa5oU102i
        fskn3arBhbXowzQvnpII6NUqMd4WF
X-Received: by 2002:a92:c103:: with SMTP id p3mr21158766ile.166.1592105875714;
        Sat, 13 Jun 2020 20:37:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6w5D3XCbepCNS+UhKMisNZolwPKq5uHZS4sl0d2Z5/SkMwZE8Awl6R55bbPrcEZdeRAKnUA==
X-Received: by 2002:a92:c103:: with SMTP id p3mr21158757ile.166.1592105875467;
        Sat, 13 Jun 2020 20:37:55 -0700 (PDT)
Received: from qiushi.cs.umn.edu ([2607:ea00:101:3c74:4874:45:bcb4:df60])
        by smtp.gmail.com with ESMTPSA id y13sm5607734iob.51.2020.06.13.20.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 20:37:54 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: img: Fix a reference count leak in img_i2s_in_set_fmt
Date:   Sat, 13 Jun 2020 22:37:48 -0500
Message-Id: <20200614033749.2975-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

pm_runtime_get_sync() increments the runtime PM usage counter even
when it returns an error code, causing incorrect ref count if
pm_runtime_put_noidle() is not called in error handling paths.
Thus call pm_runtime_put_noidle() if pm_runtime_get_sync() fails.

Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 sound/soc/img/img-i2s-in.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/img/img-i2s-in.c b/sound/soc/img/img-i2s-in.c
index e30b66b94bf6..0843235d73c9 100644
--- a/sound/soc/img/img-i2s-in.c
+++ b/sound/soc/img/img-i2s-in.c
@@ -343,8 +343,10 @@ static int img_i2s_in_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	chan_control_mask = IMG_I2S_IN_CH_CTL_CLK_TRANS_MASK;
 
 	ret = pm_runtime_get_sync(i2s->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(i2s->dev);
 		return ret;
+	}
 
 	for (i = 0; i < i2s->active_channels; i++)
 		img_i2s_in_ch_disable(i2s, i);
-- 
2.17.1

