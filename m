Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F11FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 05:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 385542075F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 05:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="PDcyP29S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388579AbgEYFuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 01:50:22 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:40232 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgEYFuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 01:50:21 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 49VmQh1t0Xz9vYxd
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 05:50:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gIU_ZhEbVUYS for <linux-kernel@vger.kernel.org>;
        Mon, 25 May 2020 00:50:20 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 49VmQh09vmz9vYxC
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 00:50:19 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 49VmQh09vmz9vYxC
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 49VmQh09vmz9vYxC
Received: by mail-io1-f70.google.com with SMTP id c2so11887653iod.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 22:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=s1PLoI3BYnuHW+tq6e8bnQsz6IJssVuc+GfzJdDnocQ=;
        b=PDcyP29SwoLIDjCEu+mQYBkoFYGGgzPZqrs0xOcUyTc0uNZsmZ8liDO7rYSRtiGNHZ
         1u0obWXk+9dzxlf/GlFAw3ly1LOyXgKp9To8H4YTtY59jDRleQCgctgXLprzEy1WVg8O
         vP6ts+rLk+7ThZmGZh/zsA7LaErqS7f29sPxrDfNbsF9GScdndErVKJLfNFLTAj6vRbA
         3HTV4ix1yYAMIbFXDIt2fCWhJu1vw50EYy7+vwXLb+w7hMUMZ/ikj2ZXJULnJJlYXnbN
         t2eo7kM6yNyCVoarwIUYFV7JppZf4vEC0/dLG7fuyRVFv5CGeh5UHAbFO1bfXLPDvQf7
         2TAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s1PLoI3BYnuHW+tq6e8bnQsz6IJssVuc+GfzJdDnocQ=;
        b=Rd2rK1Q7QYdXPavTcrVbmcJi+JNiDynQjSfPlLGM9RtXSoADsvzvi/OjqAd3GA4C1u
         azbKHeZTdDo18YbrVW8HnLidb/BQrvMWQs7DLKDoGujCwOZfjcXKsIitgeDO60GugJQS
         4y7QJcCtznhwSxmZJRF5Kb+lokfgGIKWtPghEfNIAsKiQ7lMgFukCOPPebE3Ffl8OzW8
         M6DTE0cVgknirKn1Bpsvdgdy7r0cxsDmso7hRrw4haAl2MueTqv7ZISwzFG3fToPhOEO
         f+knIdw151ZSLFEqLSuYvXNxKre+lIc133WKmDstNiu/0muqhXw/ihukbjZ1ZwWAqyXi
         s30g==
X-Gm-Message-State: AOAM530DjDcCqJvhmJ09Uiz80fYFUd6hldUgUZ7NraAVSXbSmHUSgscQ
        s9WvvSCYl1EvN85QeEeNXoiy18j4FkcN/ciWUHywbZbQfn8CEtv8apHP/8qjMwoLY7ZF0v79AvN
        8QDYv7/G1udDlDRCr+UwgbAXJqd87
X-Received: by 2002:a92:7ec3:: with SMTP id q64mr23015538ill.193.1590385819295;
        Sun, 24 May 2020 22:50:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGlSxzGUEmcJBt32sUvhEZspFL//Slv8pG8zcK9wheEsFQye9nHBg9maWxYiXMpKUkbuVOPA==
X-Received: by 2002:a92:7ec3:: with SMTP id q64mr23015524ill.193.1590385818875;
        Sun, 24 May 2020 22:50:18 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id p7sm7129330iob.7.2020.05.24.22.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 22:50:18 -0700 (PDT)
From:   wu000273@umn.edu
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        p.zabel@pengutronix.de, tglx@linutronix.de,
        lsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kjlu@umn.edu, wu000273@umn.edu
Subject: [PATCH] treewide: fix incomplete error-handling in img_i2s_in_probe.
Date:   Mon, 25 May 2020 00:50:11 -0500
Message-Id: <20200525055011.31925-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

Function "pm_runtime_get_sync()" is not handled by "pm_runtime_put()"
if "PTR_ERR(rst) == -EPROBE_DEFER". Fix this issue by adding
"pm_runtime_put()" into this error path.

Fixes: f65bb92ca12e ("ASoC: img-i2s-in: Add runtime PM")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 sound/soc/img/img-i2s-in.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/img/img-i2s-in.c b/sound/soc/img/img-i2s-in.c
index a495d1050d49..e30b66b94bf6 100644
--- a/sound/soc/img/img-i2s-in.c
+++ b/sound/soc/img/img-i2s-in.c
@@ -482,6 +482,7 @@ static int img_i2s_in_probe(struct platform_device *pdev)
 	if (IS_ERR(rst)) {
 		if (PTR_ERR(rst) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
+			pm_runtime_put(&pdev->dev);
 			goto err_suspend;
 		}
 
-- 
2.17.1

