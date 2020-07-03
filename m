Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D769AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAA3120870
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t2+CoUJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgGCRmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgGCRmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:42:31 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ABDC08C5DD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 10:42:31 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f139so34881422wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qi+0OF4ODQNxSO8LjvEMR71lEcthMzByu7Tr2x6qWes=;
        b=t2+CoUJs3bBmjlIR70pAcQdTHlv4TviWf+b2aA4YJe6LJeTqVDlg5vwidfJj6CBS8l
         Oc6IOSVUnLsIh6PdyDYr1ELmexj4PMuORbBHyUQXFoDAv+Vzrd6snchLVIi4QGuPfEX0
         BLF1y/cS/favJLDEvlezs/jNoBZZ5s8RLXv8/gw1CxmGrSNEcCwMgeToiRTBhTKO4CNl
         Y4iFnlx9iyVMXYokxxNrocJzJc6KUdzpfLuDPbFZwAVzokRZuNHosggTHDuvXhsNU3xA
         TLRE3LraSkdan5rLoZS5IwUxltwAQn+sPS79B9N5JzVM5fVjV0AGKQn0qyYczDTgXPb0
         NW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qi+0OF4ODQNxSO8LjvEMR71lEcthMzByu7Tr2x6qWes=;
        b=E20j/E48HRi6dG1v2gxE9zaYDbYxqrCopQvTO2zaIrmfyB/a91XwB/r9FxiFFXzTzk
         pyYlddtXp5TBkxGUe7iwU+i+YYXKJ35MVauUx3tKycgxbexA3o4KC6QwB1oMhf5YZky8
         4kUyuE4LUQ8u8PMzk/uwCZ3YWH3yLlSJobPDgws3h55tceCnPGMrIp5xgUi0EYJFLnZW
         AOU8PzHblsBGHjOQmyVM49dWms2sW1uWCBkRTKVTlZ9+LkTOkU9p8C93smmiGq034h4v
         WFJPf9F9JJKiNuURNrrp8+FepfN9vv7QuS+FD4cAJ4u0NXwN9aMeIFpntJtLkx/nby23
         J1kw==
X-Gm-Message-State: AOAM532dVNTkCqil9g+t8g4iExzt1ct6zuWAtcyOAjnxokd9CvuQQra2
        mZElQA5+boinv5fQG2gTvE7Skw==
X-Google-Smtp-Source: ABdhPJxZeKq2kXp5maw2pou0t9HUknsokrf7o+MtWg1zXkBtDIjsv4yrGgRAE9d2iNVgqYk35P99+Q==
X-Received: by 2002:a05:600c:2154:: with SMTP id v20mr40912679wml.185.1593798150305;
        Fri, 03 Jul 2020 10:42:30 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x11sm13625799wmc.26.2020.07.03.10.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:42:29 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Peter Chen <Peter.Chen@nxp.com>
Subject: [PATCH 10/30] usb: chipidea: debug: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Fri,  3 Jul 2020 18:41:28 +0100
Message-Id: <20200703174148.2749969-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703174148.2749969-1-lee.jones@linaro.org>
References: <20200703174148.2749969-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document any of the demoted functions here.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/chipidea/debug.c:25: warning: Function parameter or member 's' not described in 'ci_device_show'
 drivers/usb/chipidea/debug.c:25: warning: Function parameter or member 'data' not described in 'ci_device_show'
 drivers/usb/chipidea/debug.c:54: warning: Function parameter or member 's' not described in 'ci_port_test_show'
 drivers/usb/chipidea/debug.c:54: warning: Function parameter or member 'data' not described in 'ci_port_test_show'
 drivers/usb/chipidea/debug.c:75: warning: Function parameter or member 'file' not described in 'ci_port_test_write'
 drivers/usb/chipidea/debug.c:75: warning: Function parameter or member 'ubuf' not described in 'ci_port_test_write'
 drivers/usb/chipidea/debug.c:75: warning: Function parameter or member 'count' not described in 'ci_port_test_write'
 drivers/usb/chipidea/debug.c:75: warning: Function parameter or member 'ppos' not described in 'ci_port_test_write'
 drivers/usb/chipidea/debug.c:122: warning: Function parameter or member 's' not described in 'ci_qheads_show'
 drivers/usb/chipidea/debug.c:122: warning: Function parameter or member 'data' not described in 'ci_qheads_show'
 drivers/usb/chipidea/debug.c:154: warning: Function parameter or member 's' not described in 'ci_requests_show'
 drivers/usb/chipidea/debug.c:154: warning: Function parameter or member 'data' not described in 'ci_requests_show'

Cc: Peter Chen <Peter.Chen@nxp.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/chipidea/debug.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/chipidea/debug.c b/drivers/usb/chipidea/debug.c
index e0376ee646adf..da5d18cf68406 100644
--- a/drivers/usb/chipidea/debug.c
+++ b/drivers/usb/chipidea/debug.c
@@ -18,7 +18,7 @@
 #include "bits.h"
 #include "otg.h"
 
-/**
+/*
  * ci_device_show: prints information about device capabilities and status
  */
 static int ci_device_show(struct seq_file *s, void *data)
@@ -47,7 +47,7 @@ static int ci_device_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(ci_device);
 
-/**
+/*
  * ci_port_test_show: reads port test mode
  */
 static int ci_port_test_show(struct seq_file *s, void *data)
@@ -67,7 +67,7 @@ static int ci_port_test_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-/**
+/*
  * ci_port_test_write: writes port test mode
  */
 static ssize_t ci_port_test_write(struct file *file, const char __user *ubuf,
@@ -115,7 +115,7 @@ static const struct file_operations ci_port_test_fops = {
 	.release	= single_release,
 };
 
-/**
+/*
  * ci_qheads_show: DMA contents of all queue heads
  */
 static int ci_qheads_show(struct seq_file *s, void *data)
@@ -147,7 +147,7 @@ static int ci_qheads_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(ci_qheads);
 
-/**
+/*
  * ci_requests_show: DMA contents of all requests currently queued (all endpts)
  */
 static int ci_requests_show(struct seq_file *s, void *data)
-- 
2.25.1

