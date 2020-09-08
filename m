Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DEBC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF078206E7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="AvXioZY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730594AbgIHQBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730940AbgIHPyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:54:44 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4752CC061244
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 06:11:34 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id k25so10836066qtu.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 06:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lTBu5eojvtH3Cg+6qbTtorcKtib9FdmKFYP+6u1ZlTM=;
        b=AvXioZY1lrRFV29Rd2bQ+oc4u+i4TYWLNkpUwEfCglPKplw2Peh96WxLh8HLEfOPwl
         3eKVoXUefH+2pse10GxAwhD8vKo1iM5YDgnqKsOJnVJ511Hs6Ka4cd6ckiexxEbOmz7+
         EJVN/uvWsKXCp3mcPPOQFFQFc/aIYAj8sV/0u/XW9oCCRuJ02rcWOuLm4KCY/UorBWxV
         ii+HldpZFmE1g9k5anDMfc/Xn5Rfb30DchkgRbcEHLcj+JJllzamtml4CtPTYV07O0W4
         sDSCvDlJXmQtA8HEbcn9CkRhgVPrWwIfoeQ4GQBFejCbKgm9VagHSYYaOTzfC9mTRr9U
         G3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lTBu5eojvtH3Cg+6qbTtorcKtib9FdmKFYP+6u1ZlTM=;
        b=R46RTw2axgXx6c7GNg4OZwliaxidXGhAMpZ5Xg0PFtkNIixATAtjvgbq+KOxv1yNGv
         7fvRsOAkUPIoNMjUgGt+8deSykZKIKN0yrCYbobeGFgJbpHykGc4LJY4H7TYVVePiT50
         cYqlRtjUM6thh2E128mWudpxVOF5aRjx2RcjBDGsp5IGFmPSp7kvgUS/dQwWTaDq1RtI
         xW1jIZ+smd6aHWCJtHtFHlxcWAyHYqXS427X3dcOasCxVC2/9GbYHIR4oZ4ynN2Srp37
         Vkfp5pmdYrCURIXfT8DtAUoK/2+1uZxMI+lhQ2UK3hRzOoIUatpNenW8bARhwHEncvYC
         zneg==
X-Gm-Message-State: AOAM531Gqc133EI8QFoLAtF4aV4cO5kGBO7rVXHIKUlKvKKtBEJyUxwB
        wrm3YnYisKUcjMTIGgT41Dujhg==
X-Google-Smtp-Source: ABdhPJwWqntjWp9qEhGaNDY0DcpRw1SyTeDt4rha85EL0qldShYjZZny052WkxQuiCgVT8FP4un+Vg==
X-Received: by 2002:ac8:4d05:: with SMTP id w5mr16846175qtv.339.1599570693504;
        Tue, 08 Sep 2020 06:11:33 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id m196sm13394069qke.87.2020.09.08.06.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 06:11:32 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/3] misc: fastrpc: add ioctl for attaching to sensors pd
Date:   Tue,  8 Sep 2020 09:10:11 -0400
Message-Id: <20200908131013.19630-4-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200908131013.19630-1-jonathan@marek.ca>
References: <20200908131013.19630-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initializing sensors requires attaching to pd 2. Add an ioctl for that.

This corresponds to FASTRPC_INIT_ATTACH_SENSORS in the downstream driver.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/misc/fastrpc.c      | 9 ++++++---
 include/uapi/misc/fastrpc.h | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 07b381c042cd..f05f4b5934bd 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1281,7 +1281,7 @@ static int fastrpc_dmabuf_alloc(struct fastrpc_user *fl, char __user *argp)
 	return 0;
 }
 
-static int fastrpc_init_attach(struct fastrpc_user *fl)
+static int fastrpc_init_attach(struct fastrpc_user *fl, int pd)
 {
 	struct fastrpc_invoke_args args[1];
 	int tgid = fl->tgid;
@@ -1292,7 +1292,7 @@ static int fastrpc_init_attach(struct fastrpc_user *fl)
 	args[0].fd = -1;
 	args[0].reserved = 0;
 	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_ATTACH, 1, 0);
-	fl->pd = AUDIO_PD;
+	fl->pd = pd;
 
 	return fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE,
 				       sc, &args[0]);
@@ -1482,7 +1482,10 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
 		err = fastrpc_invoke(fl, argp);
 		break;
 	case FASTRPC_IOCTL_INIT_ATTACH:
-		err = fastrpc_init_attach(fl);
+		err = fastrpc_init_attach(fl, AUDIO_PD);
+		break;
+	case FASTRPC_IOCTL_INIT_ATTACH_SNS:
+		err = fastrpc_init_attach(fl, SENSORS_PD);
 		break;
 	case FASTRPC_IOCTL_INIT_CREATE:
 		err = fastrpc_init_create_process(fl, argp);
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index de31f0bd4779..0a89f95463f6 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -12,6 +12,7 @@
 #define FASTRPC_IOCTL_INIT_CREATE	_IOWR('R', 5, struct fastrpc_init_create)
 #define FASTRPC_IOCTL_MMAP		_IOWR('R', 6, struct fastrpc_req_mmap)
 #define FASTRPC_IOCTL_MUNMAP		_IOWR('R', 7, struct fastrpc_req_munmap)
+#define FASTRPC_IOCTL_INIT_ATTACH_SNS	_IO('R', 8)
 
 struct fastrpc_invoke_args {
 	__u64 ptr;
-- 
2.26.1

