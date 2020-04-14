Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DCDC352BE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 301A520656
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=qtec.com header.i=@qtec.com header.b="A5fmNoTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505469AbgDNUDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2505426AbgDNUCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:02:19 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E8BC03C1A8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:02:19 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 131so748213lfh.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MRB0ksvQ4dG29cTOUC/flJPc0kMN71llsVsfBnEBR7I=;
        b=A5fmNoTbHCX/JTsNQXS4inav3bJdDNDFSfh/2RdqtNlPCsrUh2mQPKLn8XxYoMgikf
         9IUzWVOry7lbRk9V4qAVh4wnBFwJGs+26zMD2FigmBGS/+u6Phrfn5w2+T5AgStl0PJx
         qYHFaPInYa3JEF16Nnehtm5qWCOKjO9BCNTJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MRB0ksvQ4dG29cTOUC/flJPc0kMN71llsVsfBnEBR7I=;
        b=uV22eAix72epJrGMA7CHHhUJb9U0m1H/AudFnerMPqM7RUT83+4OkMO2yVXOscmcin
         E/2TqdAdrTDKefA7DHRgcCnc7b9zPepJ45ttJiMvKn82DabBxomoTNi63bHNF6QkJ0NO
         R/aZ2LrLddggkLmvcjjxWgIwojY1aoXzZL3uZHGlRZGewUkjuZbu5OTktTqbT8AXxqPb
         4qgsd2JC5wplhxX1Cui2NEoh6SwZdGVo4D94+VYP1cWR+tj3aCyzPfsq5fPOhHW2hFpd
         Th8BwnS/E8cj8OSHnU1rQD0dBQC1028oyEr0Fa7b+vETr0W1+Hus9dKEO9u54BiQPutO
         nEjA==
X-Gm-Message-State: AGi0PubqjQR1SSrD+jG6CvhTos1G06jere/V8Ci3luYCurX9pXrIF52P
        fTbx8xmdVzS6jd4ZBHmydneb0g==
X-Google-Smtp-Source: APiQypJuHbpOy7oy8YGes+7tejCweE9iUD5goZkzU5ynPG1AQcmzXM2sskWakxg+yfgM6m3/9tvpmg==
X-Received: by 2002:a19:c14e:: with SMTP id r75mr878761lff.62.1586894537392;
        Tue, 14 Apr 2020 13:02:17 -0700 (PDT)
Received: from localhost.localdomain (62-243-86-95-cable.dk.customer.tdc.net. [62.243.86.95])
        by smtp.gmail.com with ESMTPSA id v4sm3525254ljj.104.2020.04.14.13.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:02:16 -0700 (PDT)
From:   Daniel Gomez <daniel@qtec.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Daniel Gomez <daniel@qtec.com>
Subject: [RFC PATCH 1/3] media: v4l2-subdev.h: Add min and max enum
Date:   Tue, 14 Apr 2020 22:01:49 +0200
Message-Id: <20200414200151.80089-2-daniel@qtec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414200151.80089-1-daniel@qtec.com>
References: <20200414200151.80089-1-daniel@qtec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add min and max structures to the v4l2-subdev callback in order to allow
the subdev to return a range of valid frame intervals.

This would operate similar to the struct v4l2_subdev_frame_size_enum and
its max and min values for the width and the height. In this case, the
possibility to return a frame interval range is added to the v4l2-subdev level
whenever the v4l2 device operates in step-wise or continuous mode.

Signed-off-by: Daniel Gomez <daniel@qtec.com>
---
 include/uapi/linux/v4l2-subdev.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/v4l2-subdev.h b/include/uapi/linux/v4l2-subdev.h
index 03970ce30741..ee15393c58cd 100644
--- a/include/uapi/linux/v4l2-subdev.h
+++ b/include/uapi/linux/v4l2-subdev.h
@@ -117,6 +117,8 @@ struct v4l2_subdev_frame_interval {
  * @code: format code (MEDIA_BUS_FMT_ definitions)
  * @width: frame width in pixels
  * @height: frame height in pixels
+ * @min_interval: min frame interval in seconds
+ * @max_interval: max frame interval in seconds
  * @interval: frame interval in seconds
  * @which: format type (from enum v4l2_subdev_format_whence)
  */
@@ -126,9 +128,11 @@ struct v4l2_subdev_frame_interval_enum {
 	__u32 code;
 	__u32 width;
 	__u32 height;
+	struct v4l2_fract min_interval;
+	struct v4l2_fract max_interval;
 	struct v4l2_fract interval;
 	__u32 which;
-	__u32 reserved[8];
+	__u32 reserved[4];
 };
 
 /**
-- 
2.25.1

