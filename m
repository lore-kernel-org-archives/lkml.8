Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C276CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A25A72082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="AiwPFodV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403926AbgFXNoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388933AbgFXNoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:44:19 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F35DC0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 06:44:18 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ev7so685450pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 06:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ancI0DiJuBHXSKZ5+IbcX7oH9DUg3u3wUo5JHY1jQ8Q=;
        b=AiwPFodV68n/l193jLQzyI/XsSDoyctwtNrxbM044mIAiYaN5Idf0LopBbgDmBJOWI
         vyPtT4rt6HqxUOfcLkWv7b9bhuisuKUBW0H4p7pf3TZD25jphe82BK+t4tO8RNJOYgVT
         p98cHUOskWXZgheETIpQhnsmKD2kXOzjCqBeqxd9K+S2HLuBK64T3p14jt4u/Kqi82tf
         znMczjrtcAK/I3GgVAGf60PXbH7yNBelT+nSArxyf4vCigxINdql6cSHLJ71sROr9PBU
         cIjkfi6HrmgGUBGPwE6Qdjy+drNXtTy+f5oF0edHZ0yn0d8iV9wsMjzFyHwFLbF/qFyd
         rGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ancI0DiJuBHXSKZ5+IbcX7oH9DUg3u3wUo5JHY1jQ8Q=;
        b=IVLBg2J4Tyf0Zm8/lOoOjfQqJaGxTwzHo6taCAYZFsAsV4ZyIeNfyGaBjXdVLRZfUK
         j5DcI2jbLDwkAlwQ+Cnsy+CYOKyrFJ9UIALN9f0/FKbZ8V3EDi4twCMLqEr5l1Zm+k1f
         oV8zRg0o36YktCnnwtn4X3JkJlRshiKpUELdRBnn1PcSnvuFc1eSDoH0RytiRa88XFua
         vz3R9P0Y5LEhLzWrQSoGSgxwFnLhwhxLzZxEZCURPOyxGsoMaSbHT9K2o7QLb3Om9QRo
         FJlW6AkdisT7a9NBdNGyOZy/45gNaoS7PWULVTbPYMGoOoO31j9wVQAzbsIyish4CYWV
         6gJw==
X-Gm-Message-State: AOAM532Nq1/fB/2YtodnC87lu8oQZ42WOj59JYVwxSZ5tcsU/wwMCqaY
        F7Csd8+MTBN+ybcZv55WhHQcm/MIPmg=
X-Google-Smtp-Source: ABdhPJzmpOkmB4Il61sJRvl2YVfP7vvsx93Vsc8mJPGSsphZLsMi5RmLLCUGlqRFnjcS58AL6MbcBg==
X-Received: by 2002:a17:90a:e384:: with SMTP id b4mr26147917pjz.134.1593006257856;
        Wed, 24 Jun 2020 06:44:17 -0700 (PDT)
Received: from kaaira-HP-Pavilion-Notebook ([2401:4900:4174:4b69:7433:bb27:35ac:b181])
        by smtp.gmail.com with ESMTPSA id i184sm19478065pfc.73.2020.06.24.06.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 06:44:17 -0700 (PDT)
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
To:     Helen Koike <helen.koike@collabora.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        hverkuil@xs4all.nl
Cc:     Kaaira Gupta <kgupta@es.iitr.ac.in>
Subject: [PATCH v5 1/3] media: tpg: change char argument to const char
Date:   Wed, 24 Jun 2020 19:13:52 +0530
Message-Id: <20200624134354.7023-2-kgupta@es.iitr.ac.in>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624134354.7023-1-kgupta@es.iitr.ac.in>
References: <20200624134354.7023-1-kgupta@es.iitr.ac.in>
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

