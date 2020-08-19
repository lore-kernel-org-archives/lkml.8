Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17433C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECAF020658
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="AeQ4ZBAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgHSSFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgHSSFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:05:39 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8718C061383
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:05:38 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x25so12086806pff.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YTkbrQzh2/khdYZMeZxW8p1FtiayiX3Fupc8PvOvKFA=;
        b=AeQ4ZBAl/WGtJJIJ8F3iWM5NJqInykQjQe7mhJV277zDb7kDY387oqAMz9lvq6dHIM
         9nm84PZsvzzY/Me5/wF1OYk8Il+rK1psPBwr9VXPnx6opJadazZcPk5EE1W3QIOfURBE
         yyvw9pNlGbbhVpaYA+59TBhq3A4mVSeU/sC8vLbVGFm2sAQLx2wbmqmyy5i0q3KrNWLu
         sWDOQ23uT7Sj3P2MfCq9awUv7wrkgX0nBz2sWUdD1+gfN2zqk5dt8jkb9nml0N35z7yQ
         Gme1o2RtWyXpxcSLvd9rniZqIwbnHEnYvb4aU7MAFrfu8k6QcecWGsTAOMYB1h5PnA7g
         eqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YTkbrQzh2/khdYZMeZxW8p1FtiayiX3Fupc8PvOvKFA=;
        b=g3kvXu+Ym2T6rasuFibKywZhvxgvmg8cpPHeSplyafCbTOpV0+D0cGY90lzazYLKcG
         OPEsvvtCCGuUICGQGet6ZyfKDyG+SGYrBhJUdx2MJoDmOK9+u/lhhQUoBgGcqPle1qq0
         Oh70MhW4AHEEt2E/LlsABgyk2+MIDL5tuPl1cD7DvtKg6dP4I14Sb3IQT25PGzEZUv92
         t0olEg+d+ttL7eHKPQEOvp/0K2Z7bUyx9QB20I68y0h2tI6Ua2MNxOt7eTCGj9dMVEKw
         sDUIEwh3AsAdxB867vWhVaouwTZCmP8cMAH9AoJbkL2bc3ObHkx7EA6+DQAr4GxuBFbv
         rerQ==
X-Gm-Message-State: AOAM5326Oidp2sNLI6TKsHAc0eHeEbWm8gzQ10feuz2Xf32vh86yhJDm
        eG2RjCXhHCMa/Q2c2uIhJRlVbQ==
X-Google-Smtp-Source: ABdhPJz9FXVzBzbnxBPsiEp8FT3qSpFmvjrYy9qe91IbaGS1Dl5M07GnsQY0EV+otS5XqCXDSveb4g==
X-Received: by 2002:aa7:9e45:: with SMTP id z5mr20645528pfq.166.1597860338426;
        Wed, 19 Aug 2020 11:05:38 -0700 (PDT)
Received: from kaaira-HP-Pavilion-Notebook ([103.113.213.179])
        by smtp.gmail.com with ESMTPSA id y19sm28254632pfn.77.2020.08.19.11.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 11:05:38 -0700 (PDT)
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
To:     Helen Koike <helen.koike@collabora.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Kaaira Gupta <kgupta@es.iitr.ac.in>
Subject: [PATCH v3 8/9] media: vimc: Join pipeline if one already exists
Date:   Wed, 19 Aug 2020 23:34:41 +0530
Message-Id: <20200819180442.11630-9-kgupta@es.iitr.ac.in>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200819180442.11630-1-kgupta@es.iitr.ac.in>
References: <20200819180442.11630-1-kgupta@es.iitr.ac.in>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start another capture, if one is already running, by checking for
existing pipe. If it exists already, don't fail to start second capture,
instead join it to the already running pipeline.
Use the same stream struct used by already running capture.

Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>
---
 drivers/media/test-drivers/vimc/vimc-capture.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/media/test-drivers/vimc/vimc-capture.c b/drivers/media/test-drivers/vimc/vimc-capture.c
index 73e5bdd17c57..4d20eda9335e 100644
--- a/drivers/media/test-drivers/vimc/vimc-capture.c
+++ b/drivers/media/test-drivers/vimc/vimc-capture.c
@@ -247,9 +247,15 @@ static int vimc_cap_start_streaming(struct vb2_queue *vq, unsigned int count)
 	atomic_inc(&vcap->ved.use_count);
 	vcap->sequence = 0;
 
-	stream = kzalloc(sizeof(*stream), GFP_ATOMIC);
-	kref_init(&stream->refcount);
-	pipe = &stream->pipe;
+	if (vcap->ved.ent->pipe) {
+		pipe = vcap->ved.ent->pipe;
+		stream = container_of(pipe, struct vimc_stream, pipe);
+		kref_get(&stream->refcount);
+	} else {
+		stream = kzalloc(sizeof(*stream), GFP_ATOMIC);
+		kref_init(&stream->refcount);
+		pipe = &stream->pipe;
+	}
 
 	/* Start the media pipeline */
 	ret = media_pipeline_start(entity, pipe);
-- 
2.17.1

