Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CF1C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 20:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A573C2078A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 20:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="bOdSaBZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgFMUod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 16:44:33 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:49688 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgFMUob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 16:44:31 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 49kqMf3fmwz9vC9Y
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 20:44:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FaYlEguA0zTJ for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 15:44:30 -0500 (CDT)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 49kqMf219lz9vC9d
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 15:44:30 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 49kqMf219lz9vC9d
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 49kqMf219lz9vC9d
Received: by mail-il1-f197.google.com with SMTP id t69so5676982ilk.13
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 13:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=b+iEIISmV4Ee/AXAA3HOB7wr+a6MNiCQ3dfMd9OfhgA=;
        b=bOdSaBZJyTwhn3YzlHvp7XflMqAXEC1LpqwMml0xxBo5lSuHSEclQyM/T+uTA3IZzc
         HEO/kBe9rFXMiKJRk3a8ITNQhwu+BCUnLYS+hBSKoK8Ku25nLty0vAuqscqrUK76nYvV
         TuYLPgp7WsAg5VrDyySlBlUZzgOt8QDJLcJJ0xqXFrTUQzlLDWOt80HDhJRJaJ1BOeH6
         AhJl+Hl4QQQV2/JQZWVLX2BVdaba0VD3zbvqjFDl1Xkdwc0JL713elOt7Gvu3nrdWcCQ
         bReuBufMwdFIEVOhMswp6HS4S/OL/jnNj5MuyrwVJ9/g1IzBA/sxtlaCU+At7lFPgC4T
         PGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b+iEIISmV4Ee/AXAA3HOB7wr+a6MNiCQ3dfMd9OfhgA=;
        b=qGN4czZSTvEfdQrV0VY/O0Ee/ywxYDh6lJWFz2E6K3Xv4qkw1YcR1oqsS4h86FF0Nl
         NnzhxLElKzG52s7EblwXc6M8EF77LnebyazhnKE0LdDo9TGjmLaJpAIwDcBqfAqCz3ec
         S1f1rjeBoolLY1FHYlK4HaF0N5EtLVTrB2Np+AeRJ30SGKQN2uFhbCU1nQBfMR5ml8dC
         qsWN/Cqww22+NK6GwJdLinSgv/lSweYHNASZhSW6KzwHe7QgO/PYY1vWwACh4uwY3uxG
         k1sOvaoI8zdjIML6rKvhhaYo7DHV1YKrQX+kBLKbNZeH654n9cbIWgD3UjYYK05c1wd8
         T19A==
X-Gm-Message-State: AOAM533n9dmJ7klXwI3E2qhnMFVGGOmnV53SPD40WyG6CtVq1eMHfLxj
        t0D23nKhMyYg8YlJ5Ee657R/UyBS6DWRirZFYceZ4h5vsY3wff9bMAZUUqaIKFys+Eluco/vZh1
        Rm+Zcuxh567bnOxiILNsNEYlbDXOd
X-Received: by 2002:a05:6602:491:: with SMTP id y17mr20185654iov.72.1592081069821;
        Sat, 13 Jun 2020 13:44:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuUH0JGzr6A1aKGQO/t0YzwjO1OxoyYGiXTl5u65tMnE63FPrdxzR6es2yGQb9rtR6FHN2PQ==
X-Received: by 2002:a05:6602:491:: with SMTP id y17mr20185631iov.72.1592081069282;
        Sat, 13 Jun 2020 13:44:29 -0700 (PDT)
Received: from qiushi.cs.umn.edu ([2607:ea00:101:3c74:4874:45:bcb4:df60])
        by smtp.gmail.com with ESMTPSA id t14sm5083251ilp.73.2020.06.13.13.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 13:44:28 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Edward Cragg <edward.cragg@codethink.co.uk>,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: tegra: Fix reference count leaks.
Date:   Sat, 13 Jun 2020 15:44:19 -0500
Message-Id: <20200613204422.24484-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

Calling pm_runtime_get_sync increments the counter even in case of
failure, causing incorrect ref count if pm_runtime_put is not called in
error handling paths. Call pm_runtime_put if pm_runtime_get_sync fails.

Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 sound/soc/tegra/tegra30_ahub.c | 4 +++-
 sound/soc/tegra/tegra30_i2s.c  | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/tegra/tegra30_ahub.c b/sound/soc/tegra/tegra30_ahub.c
index 635eacbd28d4..156e3b9d613c 100644
--- a/sound/soc/tegra/tegra30_ahub.c
+++ b/sound/soc/tegra/tegra30_ahub.c
@@ -643,8 +643,10 @@ static int tegra30_ahub_resume(struct device *dev)
 	int ret;
 
 	ret = pm_runtime_get_sync(dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put(dev);
 		return ret;
+	}
 	ret = regcache_sync(ahub->regmap_ahub);
 	ret |= regcache_sync(ahub->regmap_apbif);
 	pm_runtime_put(dev);
diff --git a/sound/soc/tegra/tegra30_i2s.c b/sound/soc/tegra/tegra30_i2s.c
index d59882ec48f1..db5a8587bfa4 100644
--- a/sound/soc/tegra/tegra30_i2s.c
+++ b/sound/soc/tegra/tegra30_i2s.c
@@ -567,8 +567,10 @@ static int tegra30_i2s_resume(struct device *dev)
 	int ret;
 
 	ret = pm_runtime_get_sync(dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put(dev);
 		return ret;
+	}
 	ret = regcache_sync(i2s->regmap);
 	pm_runtime_put(dev);
 
-- 
2.17.1

