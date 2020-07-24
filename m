Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A5FC433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B874720737
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="j64VirAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgGXMCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgGXMCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 08:02:37 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5DCC0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 05:02:36 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x9so4336058plr.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 05:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6aW+OAbXsp3FlPblfOXdNolvlbzdTC0MkCKKEXc8Ieo=;
        b=j64VirAVnfq9D8gtEAgxq6H8YErCJSqcg/A3pTwm7JCYI1LmLeKkuVNSpCTl+0l0rJ
         JMHlSzc+ErXAIGNo0oRshO3h+BJA3QNI6YrRZfEkamVXHWQoQ2Fi3W4rhjTNxm4DC1G4
         UXROwf2VNkw2L4OncqKi21oEzrNTkCn3wNssPxW+7mbKrxjQgBr5W3Zof68SL1hTsN8y
         tBsWFLtdgGacbfg6s3W3AXFO2WlaI7S+4gGijgey+w+ZU6U7D4CY8lRo5jEWazoaqOPg
         Z/9VLDAW1OG3jjzRFW2/EY5SiTw6QCHBgYGggjIWZf9ow6yP97qFMc9T7jJLJHaGhhyW
         F71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6aW+OAbXsp3FlPblfOXdNolvlbzdTC0MkCKKEXc8Ieo=;
        b=HUshOMTb3vc/2AwpdVWZbz+0YzSzXVBJJd7pPIYUkuShG26oBRh+hqsF8GutVzSxN7
         s7svZ5s6P0jNUVju9TSP2GLxUz/YrzjN4Vrqps1few1odkj6Wj34oTt7lEPS2aD/v+Ti
         0ki3jcROnqpnpYVbLU5GXSB09XMh4i2BcGySht2FzJ0duyLL/a0E2g1u1D44NNhFUkFD
         E2pki4B7deKflvJ40OOPPBqxIIjvGdzWHhJ/GPY4iRMNms5tycTDn3cimpuCzjjgbS0f
         vyT/7RGzlTQ1W1rIP/h2h748LOaR1++Zh5U0VqlBhlTH/9ni+qjiYgz2DZBaQsqFgEVX
         og+w==
X-Gm-Message-State: AOAM530bXkLBidQa1P/8gTKhK8f+owueKclBndLFxDQuDDDihBO5JzoU
        Lnwa9RZHlmxNrH58d2gZ7pz+lA==
X-Google-Smtp-Source: ABdhPJxiuz/K72vLYQtQ8sa8fff4jyWc+jbdFZOdXUoEWtTxg4EKvH1E1ViQFYVSWL5uFHbg81p+6A==
X-Received: by 2002:a17:90a:26ac:: with SMTP id m41mr4880104pje.169.1595592156165;
        Fri, 24 Jul 2020 05:02:36 -0700 (PDT)
Received: from kaaira-HP-Pavilion-Notebook ([103.113.213.178])
        by smtp.gmail.com with ESMTPSA id w9sm5622318pfq.178.2020.07.24.05.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 05:02:35 -0700 (PDT)
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
To:     Helen Koike <helen.koike@collabora.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc:     Kaaira Gupta <kgupta@es.iitr.ac.in>
Subject: [PATCH v2 2/3] media: vimc: Serialize vimc_streamer_s_stream()
Date:   Fri, 24 Jul 2020 17:32:12 +0530
Message-Id: <20200724120213.17119-3-kgupta@es.iitr.ac.in>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724120213.17119-1-kgupta@es.iitr.ac.in>
References: <20200724120213.17119-1-kgupta@es.iitr.ac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for multiple video streams from the same sensor by serializing
vimc_streamer_s_stream(). Multiple streams will allow for multiple
concurrent calls to this function that could involve the same
subdevices.

If that happens the internal state of the involved subdevices could go
out of sync as they are being started and stopped at the same time,
prevent this by serializing starting and stopping of the vimc streamer.

[Kaaira: rebased the patch on current HEAD of media-tree
(8f2a4a9d5ff5202d0b3e3a144ebb9b67aabadd29)]

Signed-off-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>
Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>
---
 .../media/test-drivers/vimc/vimc-streamer.c   | 23 ++++++++++++-------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/media/test-drivers/vimc/vimc-streamer.c b/drivers/media/test-drivers/vimc/vimc-streamer.c
index 451a32c0d034..5cd2f86a146a 100644
--- a/drivers/media/test-drivers/vimc/vimc-streamer.c
+++ b/drivers/media/test-drivers/vimc/vimc-streamer.c
@@ -192,18 +192,23 @@ int vimc_streamer_s_stream(struct vimc_stream *stream,
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
-			return 0;
+			goto out;
 
 		ret = vimc_streamer_pipeline_init(stream, ved);
 		if (ret)
-			return ret;
+			goto out;
 
 		stream->kthread = kthread_run(vimc_streamer_thread, stream,
 					      "vimc-streamer thread");
@@ -211,14 +216,12 @@ int vimc_streamer_s_stream(struct vimc_stream *stream,
 		if (IS_ERR(stream->kthread)) {
 			ret = PTR_ERR(stream->kthread);
 			dev_err(ved->dev, "kthread_run failed with %d\n", ret);
-			vimc_streamer_pipeline_terminate(stream);
-			stream->kthread = NULL;
-			return ret;
+			goto out;
 		}
 
 	} else {
 		if (!stream->kthread)
-			return 0;
+			goto out;
 
 		ret = kthread_stop(stream->kthread);
 		/*
@@ -227,13 +230,17 @@ int vimc_streamer_s_stream(struct vimc_stream *stream,
 		 * a chance to run. Ignore errors to stop the stream in the
 		 * pipeline.
 		 */
-		if (ret)
+		if (ret) {
 			dev_dbg(ved->dev, "kthread_stop returned '%d'\n", ret);
+			goto out;
+		}
 
 		stream->kthread = NULL;
 
 		vimc_streamer_pipeline_terminate(stream);
 	}
+out:
+	mutex_unlock(&vimc_streamer_lock);
 
-	return 0;
+	return ret;
 }
-- 
2.17.1

