Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B33DC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 23:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BC38208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 23:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LUFgVPrt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgH1XUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 19:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgH1XUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 19:20:51 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC4EC061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 16:20:51 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id h2so370343plr.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 16:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vekX/Mq23RWwnDgk+6LdcBexEyHMvoMGcRuZ1SgDRMk=;
        b=LUFgVPrt2Xx4hKMx9nbPEckkaLhVk6gHlJYu31JIplGtbqqbxXGUs9Ik6zkfNEzONc
         Fepsz9ipT6OZQsO5sUpYT1lTke6Xc3PnJAMODWEsolbqaXJvBZ7hg8bsyHYf9Vsqqf1m
         qIT2L2wYuYRca4ABfr2Odlioxk5YGEVymiJNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vekX/Mq23RWwnDgk+6LdcBexEyHMvoMGcRuZ1SgDRMk=;
        b=eRZ3e5uNToQj+m9x67DTwHVfRW6dPQfoQAZeFmJSyk820KhZMNlGv/Q9DHYN+K2VQV
         xLqrx5Li7Gid2soduv+t6Z6/2peTR4bxTRo3YQwtUSSfUwM5enrPt653OfeZC+KqGVNa
         ndOOGRZmXITvyD9RRbwrFzJgVIA7GvFibCOEl/4UnTUq/MRkQWkVPR1g6AN4dyxgl1Rq
         DeWatHBWDgvONcMUZBZ0wR84jPY7B9ry/SgrYr9XOKx0xyp6nXIln43FaMWPPo4FM5GS
         7eutCsRHQgojrgjQkI1Lc+L9inZDQKJN5wjpa/opZN80IPMu7OibWd74pBylcpcRepWl
         LREA==
X-Gm-Message-State: AOAM5325qDMHBwl0XpJWjDmIrTF1RG76IX4SdEWnhpbRfmKjFowxuv7H
        tNYDOoEUFWSQD+QNm03NbaJgz5KxrvBvTA==
X-Google-Smtp-Source: ABdhPJw5KEwmKeKe8mZkKXkaEnaqU+EpMdmR9lHHNGzs1BSmbnljanSuhsnw5f0EIMVjUuqQ+S6WOA==
X-Received: by 2002:a17:902:c24b:: with SMTP id 11mr922349plg.64.1598656851274;
        Fri, 28 Aug 2020 16:20:51 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id h10sm517971pgn.32.2020.08.28.16.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 16:20:50 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     cychiang@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: rt5682: Prefer async probe
Date:   Fri, 28 Aug 2020 16:20:27 -0700
Message-Id: <20200828162005.1.I4f67f494c4f759b0e5c7f487e040dfdcf16e0876@changeid>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The probe of rt5682 is pretty slow.  A quick measurement shows that it
takes ~650 ms on at least one board.  There's no reason to block all
other drivers waiting for this probe to finish.  Set the flag to allow
other drivers to probe while we're probing.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
NOTE: I haven't done any analysis of the driver to see _why_ it's so
slow, only that I have measured it to be slow.  Someone could
certainly take the time to profile / optimize it, but in any case it
still won't hurt to be async.

This is a very safe flag to turn on since:

1. It's not like our probe order was defined by anything anyway.  When
we probe is at the whim of when our i2c controller probes and that can
be any time.

2. If some other driver needs us then they have to handle the fact
that we might not have probed yet anyway.

3. There may be other drivers probing at the same time as us anyway
because _they_ used async probe.

While I won't say that it's impossible to tickle a bug by turning on
async probe, I would assert that in almost all cases the bug was
already there and needed to be fixed anyway.

 sound/soc/codecs/rt5682-i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5682-i2c.c b/sound/soc/codecs/rt5682-i2c.c
index 85aba311bdc8..6b4e0eb30c89 100644
--- a/sound/soc/codecs/rt5682-i2c.c
+++ b/sound/soc/codecs/rt5682-i2c.c
@@ -294,6 +294,7 @@ static struct i2c_driver rt5682_i2c_driver = {
 		.name = "rt5682",
 		.of_match_table = rt5682_of_match,
 		.acpi_match_table = rt5682_acpi_match,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = rt5682_i2c_probe,
 	.shutdown = rt5682_i2c_shutdown,
-- 
2.28.0.402.g5ffc5be6b7-goog

