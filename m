Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93CDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 933CD2080C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="Pn92yGRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgFZNHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgFZNHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:07:16 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330A3C08C5DB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:07:16 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x8so3366945plm.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ancI0DiJuBHXSKZ5+IbcX7oH9DUg3u3wUo5JHY1jQ8Q=;
        b=Pn92yGRD/fxcPJIDYHH4rJLJdcosXAk1QbwpVThtFtWZA4uRvJigz+72Ve5FH6LZSB
         2+cGYSK6eQ3URdV5czn6UhOHA+HB5RmBSmX/sdQulJQL8BXiZTVGHfREsUXbr1RnMthP
         3fv840ufMK+0//ndQNbGhRnt74b9omCVgn8IVF8YDSqAzmhCYmzLYXq2+Rc6EDrJTPBZ
         WA6q9JiVY7Jj8VFlzWSCitwbYenH0JTtxIIa2R7oZKIjyExzryBP1D3sZzfIQt8kUpOY
         YhFv28eExbP3BQkfFFGn3a8bVojqOjJXZ/07B9dRqsSuqy7+JUXAHH+4l2i93vdWCPC2
         6eWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ancI0DiJuBHXSKZ5+IbcX7oH9DUg3u3wUo5JHY1jQ8Q=;
        b=fn6ReV9T9YKxhe6uxZUajFz8GPLAalLPzd++0T26GNmzlJbpS83Np4sXfqccac0cND
         9kmyJqU/G7n8Dv/4lH04pKWhv+TJcoCdX5GAFm1t36/FTJm7WuNBarPw4ZdGEEzJCSWp
         A7rK+Ad1OzAh+r18kwPIRmRRciKFgZxGOZWhs8q8CiQI1Ys6AbwHnTEO2Ay7cISq9eXA
         5qpZLwVgzWBETupUM8BtCALrYZDt9PPnzzPz/YMpFVXsdoaatVezQuXRITifZz2Ehl6t
         x8SPy+LrgWYo7L+ugGwnXr84sUUQMhMog9p2sy38AWxdRHua/cbRButtTiI3e8LpoLY/
         dLoQ==
X-Gm-Message-State: AOAM532bIjX6PJCFdYHoGFv+nNbTK0NTViX8F1PX93Ik4+AbPRa+WtVw
        LWVj+BEWPAMm6D2KX6e4Q81tXw==
X-Google-Smtp-Source: ABdhPJyxpU3cjLnT+Va5zw0B6S0cJHZYQEkRKkqEvucXTfYhswBUroZYJV5gADP8AEnWiDTJ80+U9A==
X-Received: by 2002:a17:90a:8b09:: with SMTP id y9mr3403487pjn.90.1593176835483;
        Fri, 26 Jun 2020 06:07:15 -0700 (PDT)
Received: from kaaira-HP-Pavilion-Notebook ([103.113.213.178])
        by smtp.gmail.com with ESMTPSA id p5sm27715127pfg.162.2020.06.26.06.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 06:07:15 -0700 (PDT)
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
To:     Helen Koike <helen.koike@collabora.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        hverkuil@xs4all.nl
Cc:     Kaaira Gupta <kgupta@es.iitr.ac.in>
Subject: [PATCH v7 1/3] media: tpg: change char argument to const char
Date:   Fri, 26 Jun 2020 18:36:58 +0530
Message-Id: <20200626130700.2453-2-kgupta@es.iitr.ac.in>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200626130700.2453-1-kgupta@es.iitr.ac.in>
References: <20200626130700.2453-1-kgupta@es.iitr.ac.in>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the argument of type char * to const char * for function
tpg_gen_text().

Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>
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

