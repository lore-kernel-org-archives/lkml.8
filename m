Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7482C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 11:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 813822080C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 11:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="dL74L/zZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgFZLgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 07:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgFZLgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 07:36:40 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE36C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 04:36:40 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d12so4196673ply.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 04:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ancI0DiJuBHXSKZ5+IbcX7oH9DUg3u3wUo5JHY1jQ8Q=;
        b=dL74L/zZ9BCZoo+PCRLQB08bPtBOvxGg1hZA+U17dmRj+ppEOwCdggfQeRcWIt+vRk
         W/AT3zpaRrzMiI6lyQssdG8lydU7xNOgjgUL/Nx9zCIYHYdGEKIoijiEZyRAWsobMfAJ
         IYSdQ1wHfgZ1a2pIZ78ZxAMdt/9TYUccBYcXrNiztpvZ/sc1OCErUGrSS0HDONzyTwDQ
         NjkuJlmWlLOe6O86M4P7ZOot9BLLbp+saJcfhoV5OCsstFA3gGvnq+jgnMku5mkQ6/a1
         ERMUJAK/pTnx5MvrtGFcZW2dLfGZ7kAUHLQmVwKWhT2MvZ75aO3dARUB38tExu5hO02M
         kzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ancI0DiJuBHXSKZ5+IbcX7oH9DUg3u3wUo5JHY1jQ8Q=;
        b=hqfhI9gDoxXpI90s/qC4im7luxp00b7DxVPMbKIIYY/NbQZUy0LL7Hp8zK7mEErIY5
         5C0IweSYXgJJ5M/iWlo6R5x6gUAMdeX/uDRCDvBj3IBMI05yVzhZpBOHyRGNl0K1eN1E
         mp8/fQ6RW4duUtY4zz0tTRLVgmmTvkiU2gPNBLnE+ni5xr6hiW9yLbTjumzXN4JpCH3t
         NFcMB2tftujLhK5LagjVOpYWTxCE0A5+NGROTwXJS8DlTxTk9+ISxmz42DB2qEdbDTAJ
         g04ozAQxcDlorHGldo2UL+/k4UHsh4pwvMwZ2Ti66tFc/AwTvEjVG30kY4YbdR91771e
         jyUA==
X-Gm-Message-State: AOAM533k8Dic2iXXpQvE1jS1eGv5s9Ibl6kooCR0EyRpTcRm928CKxut
        lBPajhPl9j/rIxtyiUMIVQ3+iw==
X-Google-Smtp-Source: ABdhPJy6ErsJT16VPFHKOiaPUEdP1mlwdhrj7eydFCYmEdwSrIFEUXAYcV5RrNW1YACyp6kdQVjgTQ==
X-Received: by 2002:a17:902:9303:: with SMTP id bc3mr2389843plb.56.1593171400185;
        Fri, 26 Jun 2020 04:36:40 -0700 (PDT)
Received: from kaaira-HP-Pavilion-Notebook ([103.113.213.178])
        by smtp.gmail.com with ESMTPSA id i26sm25994768pfo.0.2020.06.26.04.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 04:36:39 -0700 (PDT)
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
To:     Helen Koike <helen.koike@collabora.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        hverkuil@xs4all.nl
Cc:     Kaaira Gupta <kgupta@es.iitr.ac.in>
Subject: [PATCH v6 1/3] media: tpg: change char argument to const char
Date:   Fri, 26 Jun 2020 17:06:16 +0530
Message-Id: <20200626113618.15280-2-kgupta@es.iitr.ac.in>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200626113618.15280-1-kgupta@es.iitr.ac.in>
References: <20200626113618.15280-1-kgupta@es.iitr.ac.in>
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

