Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1338C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7D862076E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YZaf1RAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgHDAFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgHDAFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 20:05:33 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514D5C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 17:05:33 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k13so14060746plk.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 17:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NP1mgUkCmlEZxcd7waSmwn0TKmHAK/DFyxCzxl17dtI=;
        b=YZaf1RAu7uAS0CnsRF0GsZAGSJPQlK4R+8/5vwzXjt3h9My+wgCZZSipHeMi/z/cey
         ItYGsRbndsWiE0k8aqjqGnSglsRd8b98so9+IV3KOiuJF0BS+FDFLQRjru0QTFqL//ry
         n4Q8js9xnrNgOZYBiyHsVrEHV3felhZs/hTf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NP1mgUkCmlEZxcd7waSmwn0TKmHAK/DFyxCzxl17dtI=;
        b=VfN6KuOcm+g687bt3kkYxmY/fuUIn9ZZVKisGvGQA7pqCRVaoJQl/2epfqePM0lBYZ
         6VHnk+TMLPnLcXYodt5YESJdhEb9vORYmGiXtjcFiQQSWJ5WImQbt0Qeko0HgjSaZxKF
         sXBwVmrKNBqnGK/TWOWxKUH/+AKCsIlrYE4yCiE8P9pfJ+/qziTUgOiV8dbdUXs3rRDA
         7Us9x+5fpPfIQ+OAroS4ul1atOL9+veLSuWU+Akohl3N8R3ob6f1Oh5wceK7eVMbSNlJ
         MOOmRwGNLDpUlGMRyTW114gTCmovuGYsO8otJpoB1DiBAWpW7iB+dXnKm0gGnmm5JfAL
         aqrQ==
X-Gm-Message-State: AOAM5325q2OW7kIrLvDtkKFzv6LRWxZbWQhaGNk125XUmdeWj9XEqKKA
        /UW3snvZ0VBd2KZkxYuPMVNQaw==
X-Google-Smtp-Source: ABdhPJxWUF1KaauDaSDNI7jTshdinvkTVNWLw257sbIlPVblmq9Q5WtQduokmKxsaXs2OtizM5yjWQ==
X-Received: by 2002:a17:90a:3226:: with SMTP id k35mr1610311pjb.114.1596499532554;
        Mon, 03 Aug 2020 17:05:32 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id e28sm12332756pfl.124.2020.08.03.17.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 17:05:31 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Shuming Fan <shumingf@realtek.com>
Subject: [PATCH 0/3] ASoC: rt5682: Use clk APIs better
Date:   Mon,  3 Aug 2020 17:05:28 -0700
Message-Id: <20200804000531.920688-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series drops a printk message down to dev_dbg() because it
was noisy and then migrates this driver to use clk_hw based APIs instead
of clk based APIs because this device is a clk provider, not a clk
consumer. I've only lightly tested the last two patches but I don't have
all combinations of clks for this device.

Cc: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: Shuming Fan <shumingf@realtek.com>

Stephen Boyd (3):
  ASoC: rt5682: Use dev_dbg() in rt5682_clk_check()
  ASoC: rt5682: Drop usage of __clk_get_name()
  ASoC: rt5682: Use clk_hw based APIs for registration

 sound/soc/codecs/rt5682.c | 73 ++++++++++++---------------------------
 sound/soc/codecs/rt5682.h |  2 --
 2 files changed, 23 insertions(+), 52 deletions(-)

Based on the last patch to this driver in linux-next.

base-commit: 6301adf942a31bed65e026a554e5bd55d9e731e1
-- 
Sent by a computer, using git, on the internet

