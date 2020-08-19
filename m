Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CA8C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1596120786
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="pPiEj6mZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgHSSGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgHSSF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:05:29 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52186C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:05:29 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id r4so11203455pls.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PTx1KB4WomfJKMJISUl/NMNKsl0lboyI/6kyDO0ot0Q=;
        b=pPiEj6mZwpCKBOJjNus5Xgep/xDdXOmefZBNFxUJ0UkuxtFwSb7XiteXDD/RpgGXAr
         BtDEJWc5AdhX/vXUpOw+12FcNkAKUvzhMlI48wXzWp+WW1UEwmc9o7pM9AWh8dqIBS0w
         ZrK9bc1pxSOM9KL9OIjHF3orwkNxAaEqG+FnrPfu69Hma4U5VTk1wguOemxqhTIiqm2L
         upiwLu3nHLFx9jLs31fQ+jKAQiueaxsZBtGMBq/Hjheed++gxnRnuKJWk3AKIZMJ0xQj
         HNSwbGV4VXv9Yj5CY34Hh2c+Q62B8EZ/RaVBZDw4guBlx/HrhlmobCF3ZfZ7eOVK8UKy
         t1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PTx1KB4WomfJKMJISUl/NMNKsl0lboyI/6kyDO0ot0Q=;
        b=JJQmuH+DH2QVFVkLC5MNbB+5hxLgdpFI4jxFWeCzYQ4YZ1x7bQBCXEtdzkjqk/zEOq
         j+W4y65nQaMdFg3iwls7jMARWH8DZFsLLCO4bcKrGOQzhAA6coShtWwXxeeL3qofT50r
         rOd0WRCgr/iq82QuhhoIGfcE6JifuNcc1uYKlxrnwoV28jU3w/bMIkm10QOFzw8WFWBp
         zyDFjnDzPuI8ihk+DzLzwGyD4BvHoLOJSrMtEZ3xCJJpmf0Cl+d2yquHwLLPHKFXUuFX
         ltU7/+IR7C0Np7WT76X/iwipL/xcZ2JKc1IZ/YRiKTOMUNOObRSu8RZ8f20f9LOQKFzy
         3CAg==
X-Gm-Message-State: AOAM5334p5vbxW6wGCTwvhyo+I7Fn7Fm853vrtBbivHqXDQqQY5+juXA
        Q1jexRuPF1/S8R3g7rHT/waxCA==
X-Google-Smtp-Source: ABdhPJyRHC2LN2rK2JG0ifUjrDVg3XtN1jTRkT7emzbh3uHC7nJPSWrn2om7LswmteBjqkTFI3drSA==
X-Received: by 2002:a17:90b:23c9:: with SMTP id md9mr5114923pjb.173.1597860328786;
        Wed, 19 Aug 2020 11:05:28 -0700 (PDT)
Received: from kaaira-HP-Pavilion-Notebook ([103.113.213.179])
        by smtp.gmail.com with ESMTPSA id u191sm24353638pgu.56.2020.08.19.11.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 11:05:28 -0700 (PDT)
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
To:     Helen Koike <helen.koike@collabora.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Kaaira Gupta <kgupta@es.iitr.ac.in>
Subject: [PATCH v3 6/9] media: vimc: Serialize vimc_streamer_s_stream()
Date:   Wed, 19 Aug 2020 23:34:39 +0530
Message-Id: <20200819180442.11630-7-kgupta@es.iitr.ac.in>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200819180442.11630-1-kgupta@es.iitr.ac.in>
References: <20200819180442.11630-1-kgupta@es.iitr.ac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Söderlund <niklas.soderlund@ragnatech.se>

Prepare for multiple video streams from the same sensor by serializing
vimc_streamer_s_stream(). Multiple streams will allow for multiple
concurrent calls to this function that could involve the same
subdevices.

If that happens the internal state of the involved subdevices could go
out of sync as they are being started and stopped at the same time,
prevent this by serializing starting and stopping of the vimc streamer.

[Kaaira: only rebased the patch on current HEAD of media-tree]

Signed-off-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>
Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>
---
 .../media/test-drivers/vimc/vimc-streamer.c    | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/media/test-drivers/vimc/vimc-streamer.c b/drivers/media/test-drivers/vimc/vimc-streamer.c
index 6b5ea1537952..f5c9e2f3bbcb 100644
--- a/drivers/media/test-drivers/vimc/vimc-streamer.c
+++ b/drivers/media/test-drivers/vimc/vimc-streamer.c
@@ -269,22 +269,27 @@ int vimc_streamer_s_stream(struct vimc_stream *stream,
 			   struct vimc_ent_device *ved,
 			   int enable)
 {
+	static DEFINE_MUTEX(vimc_streamer_lock);
 	int ret;
 
 	if (!stream || !ved)
 		return -EINVAL;
 
+	ret = mutex_lock_interruptible(&vimc_streamer_lock);
+	if (ret)
+		return ret;
+
 	if (enable) {
 		if (stream->kthread)
 			return 0;
 
 		ret = vimc_streamer_stream_start(ved);
 		if (ret)
-			return ret;
+			goto out;
 
 		ret = vimc_streamer_pipeline_init(stream, ved);
 		if (ret)
-			return ret;
+			goto out;
 
 		stream->kthread = kthread_run(vimc_streamer_thread, stream,
 					      "vimc-streamer thread");
@@ -294,17 +299,16 @@ int vimc_streamer_s_stream(struct vimc_stream *stream,
 			dev_err(ved->dev, "kthread_run failed with %d\n", ret);
 			vimc_streamer_stream_terminate(ved);
 			vimc_streamer_pipeline_terminate(stream);
-			stream->kthread = NULL;
-			return ret;
 		}
 
 	} else {
 		if (!stream->kthread)
-			return 0;
+			goto out;
 
 		vimc_streamer_stream_terminate(ved);
 		vimc_streamer_pipeline_terminate(stream);
 	}
-
-	return 0;
+out:
+	mutex_unlock(&vimc_streamer_lock);
+	return ret;
 }
-- 
2.17.1

