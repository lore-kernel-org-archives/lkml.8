Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDDEC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9EE7208DB
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QV0KmwhU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgHaJSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 05:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbgHaJR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:17:58 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF74DC061573;
        Mon, 31 Aug 2020 02:17:58 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id i13so2822351pjv.0;
        Mon, 31 Aug 2020 02:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o9UCQOw6Icrdln138Yk46bjdxyexHm5RqSjvFlYBk8U=;
        b=QV0KmwhUYJy5ozjdtSeFUEk/E4pQQqWsKgdToJoD/9YQZKXQzVrRNVm2CZmSW7TZpY
         oIAB1rJR2+QB6+QRoiknh0AAG+UZFAg0/eyjwWIpFf3mky9NVRsEZeppZvxZYsqZ8d6y
         T+hMBvRqeU6FyjB5PXk8g5MneZPl2TMGcswUcDtkq2U3ILQ+qvrsmgsEWWyZNJuJ+kOY
         ona9dzJvjwpO6dvARumpTQHpOcYzYvCIhRPUiTmPN0yk6X08t8gOv857AfhilV/09meS
         nkctTeb7Gbqb0dBZDccPMaeD0PYaT0YxQw6zMFHywHPmqvSyasf5drdUC09xQwhkGPiR
         yf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o9UCQOw6Icrdln138Yk46bjdxyexHm5RqSjvFlYBk8U=;
        b=XdpTM5gjkRVF+OZ8OeoblcMor//dGMGlokZec0Y6Tep5adzZgDIPNHwUQ2gaZ+JKg8
         YWYqocvKjoAoIcdpMeMdywYQ3IMZI21D39rO/HrqnwWEyFJoeDL1HJUuxxpOjjwZI/Fb
         75l0RHbR7s45VOKSt2fwSqTQHYixyVFMZWtAzm6N7NiyIhr71cJlSSIXaG6BSmOTQbXY
         OafHVyGlgnQDPdQMensE9i50xO67u6Cu75vQChnTMkTW690Gbgkb+CuD+E10oeUd789z
         IzOmlkLD+UMjx5RC6imF+Sz4q4Ns1W6GPV+sZuwLF57jFoI00ciR+FkG6tY3j9rfWaoH
         0c1w==
X-Gm-Message-State: AOAM532dmLyFSKELE2w9qmXvwjKSXWFAUoiv1Nf+ZVCaOEngFyNNBp4f
        VN4K+v/YrnkDq+IByYeD0Sk=
X-Google-Smtp-Source: ABdhPJzHLac6/DDTF1AE1XtRQ7vEWY8uXAp6KCf1OcV7sb7Qvzlg9wW2K1FvfKJHLDLnoMvCcqcpmA==
X-Received: by 2002:a17:90a:714b:: with SMTP id g11mr574043pjs.216.1598865478274;
        Mon, 31 Aug 2020 02:17:58 -0700 (PDT)
Received: from localhost.localdomain ([49.207.195.77])
        by smtp.gmail.com with ESMTPSA id k5sm6847055pgk.78.2020.08.31.02.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 02:17:57 -0700 (PDT)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     anant.thazhemadam@gmail.com, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        Michel Lespinasse <walken@google.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arch: ia64 - Update put_filp to fput
Date:   Mon, 31 Aug 2020 14:47:46 +0530
Message-Id: <20200831091747.9305-1-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function `put_filp`, (along with almost all references of it) seems to
have been deprecated and exist no more, and neither the prototype nor
the function definition seem to be a part of the main kernel tree anymore. 
It has been recommended that `fput` be used instead, so it felt like it 
was about time this was updated too

Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
 arch/ia64/kernel/perfmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/kernel/perfmon.c b/arch/ia64/kernel/perfmon.c
index 0dc3611e7971..91349e38b9be 100644
--- a/arch/ia64/kernel/perfmon.c
+++ b/arch/ia64/kernel/perfmon.c
@@ -2644,7 +2644,7 @@ pfm_context_create(pfm_context_t *ctx, void *arg, int count, struct pt_regs *reg
 
 buffer_error:
 	path = filp->f_path;
-	put_filp(filp);
+	fput(filp);
 	path_put(&path);
 
 	if (ctx->ctx_buf_fmt) {
-- 
2.25.1

