Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FBBC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4069920873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n/gHlBJq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbgCISva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 14:51:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42413 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbgCISv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:51:26 -0400
Received: by mail-pl1-f195.google.com with SMTP id t3so2098210plz.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 11:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KlRXdnxj2Ny2y1SE3JlpQNEkyXKUGq38gqBn9QXInvI=;
        b=n/gHlBJqW+XXY/SauS2FEzFd+YOJE/NOQ9qA9YuexD16c6s/bT2qX7CBZaahLEfCP6
         hMkH3Z+CaU7WJL87znswp53rgJuUJyiJM7C2oZTeIM7Zya49z4vcS2fG4vR/2w5IIItc
         soHjU4a0bumE/+uVBcuAbC07De4cXkbtikDyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KlRXdnxj2Ny2y1SE3JlpQNEkyXKUGq38gqBn9QXInvI=;
        b=SeYafT5f8o/whdXEF4y7/JJdx/17WNOcPvF8FAvIHkGDFfZZJk76CqkjWXP7dNpmq7
         b+mxk2/WxX5AmawLnAxqzaVn5Lx3i3z7fJ0yXfpTGPAAeZHVDgwnAgFuABoAnwOmLCP5
         UdWIXriCIbP+bxu0z4wM8j33PV8MW5Py74ihckXHWlRuhSCTDJWwTwalQXFMTNN6CE1P
         OFlueYLUJYAopTOLphyqLsz+A9+J//vYMamDUjGPufAEUa/e8kBrrZbHJ2LPCDARVjNr
         U2U/wJ1ofm6RM9Ggv/BAL7P42diK9MfF9kRjGOXFeuqTV7mwRhO9/fAGT02xcBre2v7q
         Qy1w==
X-Gm-Message-State: ANhLgQ2915phdpS6V8BjyUPo+y4ptCP8YLdTxNi2pyauU/ITVEtfVKgT
        Gtvd+AU750qnd/DPwhgAf47BYw==
X-Google-Smtp-Source: ADFU+vsVGrRceJW/ujmAZpF6YeR9HYUMhFCBSm78ZivX9FVTSj2vlAA+5vyP+j4yQEhXkjJD/I/nFg==
X-Received: by 2002:a17:90a:8d86:: with SMTP id d6mr89910pjo.119.1583779884729;
        Mon, 09 Mar 2020 11:51:24 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id u23sm45168990pfm.29.2020.03.09.11.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 11:51:24 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>
Subject: [PATCH] soc: qcom: socinfo: Use seq_putc() if possible
Date:   Mon,  9 Mar 2020 11:51:23 -0700
Message-Id: <20200309185123.65265-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a single character that we're printing out. Use seq_putc() for
that to simplify the code.

Cc: Vaishali Thakkar <vaishali.thakkar@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/socinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 7864b75ce569..ebb49aee179b 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -277,7 +277,7 @@ static int show_image_##type(struct seq_file *seq, void *p)		  \
 {								  \
 	struct smem_image_version *image_version = seq->private;  \
 	seq_puts(seq, image_version->type);			  \
-	seq_puts(seq, "\n");					  \
+	seq_putc(seq, '\n');					  \
 	return 0;						  \
 }								  \
 static int open_image_##type(struct inode *inode, struct file *file)	  \

base-commit: 2c523b344dfa65a3738e7039832044aa133c75fb
-- 
Sent by a computer, using git, on the internet

