Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4728BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C83F2177B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m7JUSxo2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbgHDAFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgHDAFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 20:05:33 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9462C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 17:05:33 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id d4so1010282pjx.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 17:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y16Y9VzNG9qM+J0oXaRKcTXEkcxRSQyUjMcg0sQqDX0=;
        b=m7JUSxo2z9T38XvDBBSMBw1xudjbDt7oA4PQIt4hL6CSScE3oqLtdvilgE1ZxTrkxw
         47CMo04qMxEQHssTIVp688HGv2GZX5XgmSD6ZB+R6CAEqc7TduZ8x9ijI5otvWJ24avG
         4G/H/VJFnoAQ9grSOdfJ49KklJyLN0NzKZgrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y16Y9VzNG9qM+J0oXaRKcTXEkcxRSQyUjMcg0sQqDX0=;
        b=hMLuMKlEc2EzL0UWSnxPQvhYpcUdS9QJ3WRtoFhAAC6IatIJKJF+Znj2+1VfNUBEI3
         wEz2e6+yVs2xXppP50UEGilVU+s3oCL/qMrVNjh5RSjFKWrslJr4qnXn7RoeWAPtOzxB
         XPMp7V34l2ZBUY/VHUcmL20jVPP45Hn4c95Xphwps0XFwcxzBD2xinGCc+kv0l6dEzZD
         pem46eopIhkbrnUOlOZvMeDxDZgmjlOey5O4HtIP22m4XE5hQgDDyJ8iYlSE/MLXUJVw
         R1U+tf10JVNwh5Ftt547NnC14T3IwWOs8//RVnHFoe3lGVxvlU6MQKuGgd921p//KtnT
         HTtQ==
X-Gm-Message-State: AOAM5319I9L7Pvh9hVAtItN+xQ2prbrjjq7COeRjBt05RCXCerYroIUR
        iZub8i9S5bBZvXOlSJ6iYiGqGg==
X-Google-Smtp-Source: ABdhPJxx5w0TAv0orspB1pOK9CJb492TY2RPzdXrRojGdVXlfSbiBzq9AcCqxuS4HsoSMxslIgTPxw==
X-Received: by 2002:a17:90a:4e89:: with SMTP id o9mr1813122pjh.178.1596499533330;
        Mon, 03 Aug 2020 17:05:33 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id e28sm12332756pfl.124.2020.08.03.17.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 17:05:32 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Shuming Fan <shumingf@realtek.com>
Subject: [PATCH 1/3] ASoC: rt5682: Use dev_dbg() in rt5682_clk_check()
Date:   Mon,  3 Aug 2020 17:05:29 -0700
Message-Id: <20200804000531.920688-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200804000531.920688-1-swboyd@chromium.org>
References: <20200804000531.920688-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I see a spew of "sysclk/dai not set correctly" whenever I cat
/sys/kernel/debug/clk/clk_summary on my device. This is because the
master pointer isn't set yet in this driver. A user isn't going to be
able to do much if this check is failing so this error message isn't
really an error, it's more of a kernel debug message. Lower the priority
to dev_dbg() so that it isn't so noisy.

Cc: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: Shuming Fan <shumingf@realtek.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 sound/soc/codecs/rt5682.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index fab066a75ce0..ed9475f24aec 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -2482,7 +2482,7 @@ static int rt5682_set_bias_level(struct snd_soc_component *component,
 static bool rt5682_clk_check(struct rt5682_priv *rt5682)
 {
 	if (!rt5682->master[RT5682_AIF1]) {
-		dev_err(rt5682->component->dev, "sysclk/dai not set correctly\n");
+		dev_dbg(rt5682->component->dev, "sysclk/dai not set correctly\n");
 		return false;
 	}
 	return true;
-- 
Sent by a computer, using git, on the internet

