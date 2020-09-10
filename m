Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747B5C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 209B2207EA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhW5ilmv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgIJSYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgIJSQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:16:22 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759EBC061796
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:15:45 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gr14so10154833ejb.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EjroAkfsxrKtCy0Ubpv2tKVEkMRZLXOZ0SySu7UagEs=;
        b=dhW5ilmv8SIYNLxmDFFj8Df+SAWU2DumBkJioFX+0EscCmg+AfOAPKL4TpW6wNBwut
         a4IJlgU68DkDNCWf/vtWl227mhaRXxxmNqDy3Z72fBK1Fd9biP0yMUxlsykdwSbO03nd
         2XaVPRsfDtxmatPuztMTO3VJJ2kLihSX4CK0yafoP/yxHHDIUNJPd6uDPGHi+cVLXiYv
         zcSBoYhiqxnYgBxGTSsg5pN5pZiA//cdFk7NF+LgDAppMa5IbnOp6+2fcMFWqSSfmPnT
         Wlt0eSptjogkykD9efYU6FItNeEikdMtqlZVOj69FXYFlk/NwMxdnc2SyBr1X5WlBSr2
         lXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EjroAkfsxrKtCy0Ubpv2tKVEkMRZLXOZ0SySu7UagEs=;
        b=Lk9eJXYwc48bLajITCOV6Wv3KplJ6V8MyfUb0+3RdYOWV3nVYOcYxBt9//9HGWr1S3
         Y2s5baTU68hq58vK04wNivTc4djrPms3uMAJukXdtV4HVOMEW/yvpxdaFOPQP/KJ20RN
         BW6oUWfnsUj3zKxs3SfYBVZKre4tCerHis8zzVggvdv78EO6EyR/Kok7VFZb8ddwA6sA
         ypfEJHiCm6uxPK/qAk8iJIT9m1ewdaVD4J2Sdn/doN7i0GbuRw2Y0dr7fNt62LbFdCn/
         nZNC94jwZJ8i3FZKZXK0E2W4g6TQKmBrIjgsdfYbAl0S5KjIXqkZ8wqoVParh1Vnuq71
         HoPQ==
X-Gm-Message-State: AOAM533v1n+DitGbd2KkzFES+BMkOy8vlyb0NFxJD72Z9PrShJV0MsVL
        KvxjiaM20BBPVXBbHEMyWBrdNLp/caQ=
X-Google-Smtp-Source: ABdhPJz+Xba1s3W+7a7/sDj23I8eqeFZDqMMZgvoRaCZKrdO9Niu1y3PV4oLzlRQqnexdddCdh9/hA==
X-Received: by 2002:a17:906:7fcb:: with SMTP id r11mr9837299ejs.519.1599761743628;
        Thu, 10 Sep 2020 11:15:43 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id y6sm8636117edj.50.2020.09.10.11.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 11:15:42 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 07/11] habanalabs: allow to wait on CS without sleep
Date:   Thu, 10 Sep 2020 21:15:20 +0300
Message-Id: <20200910181524.21460-7-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910181524.21460-1-oded.gabbay@gmail.com>
References: <20200910181524.21460-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The user sometimes wants to check if a CS has completed to clean resources.
In that case, the user doesn't want to sleep but just to check if the CS
has finished and continue with his code.

Add a new definition to the API of the wait on CS. The new definition says
that if the timeout is 0, the driver won't sleep at all but return
immediately after checking if the CS has finished.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/command_submission.c | 7 +++++--
 include/uapi/misc/habanalabs.h                      | 3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 470bffbe9bdc..b2b974ecc431 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -1180,8 +1180,11 @@ static long _hl_cs_wait_ioctl(struct hl_device *hdev,
 				"Can't wait on CS %llu because current CS is at seq %llu\n",
 				seq, ctx->cs_sequence);
 	} else if (fence) {
-		rc = wait_for_completion_interruptible_timeout(
-				&fence->completion, timeout);
+		if (!timeout_us)
+			rc = completion_done(&fence->completion);
+		else
+			rc = wait_for_completion_interruptible_timeout(
+					&fence->completion, timeout);
 
 		if (fence->error == -ETIMEDOUT)
 			rc = -ETIMEDOUT;
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 69fb44d35292..d449f8a31ce6 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -914,6 +914,9 @@ struct hl_debug_args {
  * inside the kernel until the CS has finished or until the user-requested
  * timeout has expired.
  *
+ * If the timeout value is 0, the driver won't sleep at all. It will check
+ * the status of the CS and return immediately
+ *
  * The return value of the IOCTL is a standard Linux error code. The possible
  * values are:
  *
-- 
2.17.1

