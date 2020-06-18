Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F191C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 00:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46B1521527
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 00:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HN5C7ut0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgFRAMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 20:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgFRAMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 20:12:07 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5161EC06174E;
        Wed, 17 Jun 2020 17:12:06 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n11so3914401qkn.8;
        Wed, 17 Jun 2020 17:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=edtf2eABu219UZLqaAwwL2YPJpuQp4rR5iROhIj3sug=;
        b=HN5C7ut0vfhPtRFQUUi3d7lVBooP4PiOOS8rtAO1wN2+3kIBmscyVYtBfzy+CP+2jj
         0G1rXyqnaQPrnGyjoGGX1Vbb1z2Ty7h/4k2aRisn2B+7VHZuN3+Wer2/yISSOY5cHmd3
         iPMjbeu59zG6DxpC29JslX1GOUYriYf9N5Zyst0SY8Z7etxMMGX3yX32PKPxMcCBNWoK
         wb7YdmZ6b8L5C73GGHL5UFbZpxNkvZtd85b3EMZFGSCvtsYRhjfx7NIkgoOGNFTS7qFy
         wKOi3TFptgKcrZ9uE+AxLvNyeLEP2fNVWlZhMZFjFEIao6f1rWGXLPmHyY2x3pvfNoLw
         Z+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=edtf2eABu219UZLqaAwwL2YPJpuQp4rR5iROhIj3sug=;
        b=ib63NhK9tQWPLp5D6BG1x1P/46j7nauuClX/desB1RrKkcHcmBMgujmWmekQgz0mwU
         knFtPdpsNxMzcVWhV9130V3ywE4aBnBS4CPgEc424InqoncJxvQlltM3vUImbgYq5tmM
         qG0bV9pE4gz3UVs1DL8uAk3UM3BoR5fdSxfBIkOyc/ZgSzjzu2v9I9dWx6KoRhcEUZ20
         DdsHvIW4MocIsV8zhox52o6024hUcxIeyioLrkcWKUByVvNEXzrhHIRTGtMHmZalsBlI
         fF+n5t/zifvntK9kvaQBd/03bc9siwivZZ5I7zh2iRDPjyDeFjfvOdGXFw3jR9j3Dy8o
         e1cA==
X-Gm-Message-State: AOAM532idZkUbGMSF+OXb6YF0kL0R3UFTTDorQ5O0ijwRp6dcO5uLvX5
        Hb95WOvi2il4PMh099saIf8=
X-Google-Smtp-Source: ABdhPJzgSG6bY0yPlJdrhmH0It6v98GQcK8Jc28vmTtFveOm6v1hG+rgwoeUub8MjxuFGNDrVruAKA==
X-Received: by 2002:a37:de0c:: with SMTP id h12mr1254711qkj.466.1592439126137;
        Wed, 17 Jun 2020 17:12:06 -0700 (PDT)
Received: from linux.home ([2604:2000:1344:41d:9c3:b47c:c995:4853])
        by smtp.googlemail.com with ESMTPSA id b26sm1699066qta.84.2020.06.17.17.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 17:12:05 -0700 (PDT)
From:   Gaurav Singh <gaurav1086@gmail.com>
To:     gaurav1086@gmail.com, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        linux-ia64@vger.kernel.org (open list:IA64 (Itanium) PLATFORM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ia64: Add null pointer check for task in default_handler
Date:   Wed, 17 Jun 2020 20:11:46 -0400
Message-Id: <20200618001157.26035-1-gaurav1086@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200611150221.15665-1-gaurav1086@gmail.com>
References: <20200611150221.15665-1-gaurav1086@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the task is NULL and the if condition is true 
then task->pid would cause null pointer dereference. 
Fix this by adding additional null check.

Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
---
 arch/ia64/kernel/perfmon_default_smpl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/kernel/perfmon_default_smpl.c b/arch/ia64/kernel/perfmon_default_smpl.c
index a40c56020fc5..2732b4cf4296 100644
--- a/arch/ia64/kernel/perfmon_default_smpl.c
+++ b/arch/ia64/kernel/perfmon_default_smpl.c
@@ -111,7 +111,7 @@ default_handler(struct task_struct *task, void *buf, pfm_ovfl_arg_t *arg, struct
 	unsigned char ovfl_notify;
 
 	if (unlikely(buf == NULL || arg == NULL|| regs == NULL || task == NULL)) {
-		DPRINT(("[%d] invalid arguments buf=%p arg=%p\n", task->pid, buf, arg));
+		DPRINT(("[%d] invalid arguments buf=%p arg=%p\n", task? task->pid : -1, buf, arg));
 		return -EINVAL;
 	}
 
-- 
2.17.1

