Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F30C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 13:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E5120739
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 13:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="PhvEqgFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgGENxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 09:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgGENxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 09:53:32 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CFEC061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 06:53:32 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z3so6604795pfn.12
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 06:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o5iFRkrCIo6DiUdwVs+/iA+6+88UWJnG9yA214oBxik=;
        b=PhvEqgFljQfscqFDtcVnFBkOhTeGHmnaj6rhcekXRv4uTcRtks0jMOdQt+crhW+xAw
         AEqga/SbkPMj5MrZl21FdeV3LVRB0weZA+GItv+SbpEfKB6DIVGJ72yiBI1+Y4zbcrtu
         TZq5JOcDQTXt2cHqCurFCr4GHKRp1hPwRBtzNll2Nv9/ZElOV8E/4/GzjdQUzfszUK/D
         0qf/Ibl3w0ftg8DGpI9sXxKeYH/0/r8KBPgdgearrBrXVzkn+1e7hfrpPCqT3QYodIwj
         s2raIrbn1rmrfQLiADew1yLqZtU8mpgoMweza0ZRvQVbVtR+6WurspJITfOu810ZV3ux
         s9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o5iFRkrCIo6DiUdwVs+/iA+6+88UWJnG9yA214oBxik=;
        b=APCCk9wn02EY42HhfuU0rAXqay/9cL3egQ/jbjH0t9LFPeW/RxQlOW/hHlZv4iPd5I
         NGdq1bjS1NJcVtnyZhR33x8Ovw06gy5Ti0ao4WZUkPUrJfU6yq2H3jGPxu7255uEGQht
         bTEzBejaAYeYldNHrKwdDRAbXt2TwtMEqDHhyQ/cFcHreq18EpcTTe8sVP5tiQ2mDw+B
         e/ZyCeipzMb4B/SYEi4YDlfIc/rW9axohr1QnTJ3KP+JIgEn76FH1Uar1ZsEJwdz86Ft
         ntLbR69qdVPjrCT8WeO5+4XdSBVK7WwdDmp+M6bEa9Jt9pVPzVjA5bsKMu8VpMrWc0Vk
         cCOA==
X-Gm-Message-State: AOAM530vYKVSR7gUQG2D/5mOD0pCKdyDQAjzZVLojTvMieRJLII44M9m
        cO7R/R6zpNZVmTb6aurhKPRa8Q==
X-Google-Smtp-Source: ABdhPJw73AQ5XU0rvuolk+skiGszUyUoXZUHhNLIK+h7b/m67SIOgzn5obks5BtfTK2oRB6qWsWUeA==
X-Received: by 2002:a62:e119:: with SMTP id q25mr23131573pfh.300.1593957211499;
        Sun, 05 Jul 2020 06:53:31 -0700 (PDT)
Received: from kaaira-HP-Pavilion-Notebook ([103.113.213.178])
        by smtp.gmail.com with ESMTPSA id c188sm16661793pfc.143.2020.07.05.06.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 06:53:31 -0700 (PDT)
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
To:     Helen Koike <helen.koike@collabora.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Kaaira Gupta <kgupta@es.iitr.ac.in>
Subject: [PATCH v10 1/3] media: tpg: change char argument to const char
Date:   Sun,  5 Jul 2020 19:23:04 +0530
Message-Id: <20200705135307.27564-2-kgupta@es.iitr.ac.in>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200705135307.27564-1-kgupta@es.iitr.ac.in>
References: <20200705135307.27564-1-kgupta@es.iitr.ac.in>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the argument of type char * to const char * for function
tpg_gen_text().

This function should take in a const char * as opposed to char * as it
does not make changes to the text. This issue was found while passing
the order of colors of tpg generated test image (which is a const char
*) to this function.

Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>
Reviewed-by: Helen Koike <helen.koike@collabora.com>
Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c | 10 +++++-----
 include/media/tpg/v4l2-tpg.h                  |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c b/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
index 50f1e0b28b25..dde22a4cbd6c 100644
--- a/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
+++ b/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
@@ -1927,34 +1927,34 @@ typedef struct { u16 __; u8 _; } __packed x24;
 
 static noinline void tpg_print_str_2(const struct tpg_data *tpg, u8 *basep[TPG_MAX_PLANES][2],
 			unsigned p, unsigned first, unsigned div, unsigned step,
-			int y, int x, char *text, unsigned len)
+			int y, int x, const char *text, unsigned len)
 {
 	PRINTSTR(u8);
 }
 
 static noinline void tpg_print_str_4(const struct tpg_data *tpg, u8 *basep[TPG_MAX_PLANES][2],
 			unsigned p, unsigned first, unsigned div, unsigned step,
-			int y, int x, char *text, unsigned len)
+			int y, int x, const char *text, unsigned len)
 {
 	PRINTSTR(u16);
 }
 
 static noinline void tpg_print_str_6(const struct tpg_data *tpg, u8 *basep[TPG_MAX_PLANES][2],
 			unsigned p, unsigned first, unsigned div, unsigned step,
-			int y, int x, char *text, unsigned len)
+			int y, int x, const char *text, unsigned len)
 {
 	PRINTSTR(x24);
 }
 
 static noinline void tpg_print_str_8(const struct tpg_data *tpg, u8 *basep[TPG_MAX_PLANES][2],
 			unsigned p, unsigned first, unsigned div, unsigned step,
-			int y, int x, char *text, unsigned len)
+			int y, int x, const char *text, unsigned len)
 {
 	PRINTSTR(u32);
 }
 
 void tpg_gen_text(const struct tpg_data *tpg, u8 *basep[TPG_MAX_PLANES][2],
-		  int y, int x, char *text)
+		  int y, int x, const char *text)
 {
 	unsigned step = V4L2_FIELD_HAS_T_OR_B(tpg->field) ? 2 : 1;
 	unsigned div = step;
diff --git a/include/media/tpg/v4l2-tpg.h b/include/media/tpg/v4l2-tpg.h
index eb191e85d363..9749ed409856 100644
--- a/include/media/tpg/v4l2-tpg.h
+++ b/include/media/tpg/v4l2-tpg.h
@@ -241,7 +241,7 @@ void tpg_log_status(struct tpg_data *tpg);
 
 void tpg_set_font(const u8 *f);
 void tpg_gen_text(const struct tpg_data *tpg,
-		u8 *basep[TPG_MAX_PLANES][2], int y, int x, char *text);
+		u8 *basep[TPG_MAX_PLANES][2], int y, int x, const char *text);
 void tpg_calc_text_basep(struct tpg_data *tpg,
 		u8 *basep[TPG_MAX_PLANES][2], unsigned p, u8 *vbuf);
 unsigned tpg_g_interleaved_plane(const struct tpg_data *tpg, unsigned buf_line);
-- 
2.17.1

