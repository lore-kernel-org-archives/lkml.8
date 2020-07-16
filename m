Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A309C433EA
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E3C9207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgGPOjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:39:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58243 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgGPOjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:39:37 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1jw52t-0006u5-M8
        for linux-kernel@vger.kernel.org; Thu, 16 Jul 2020 14:39:35 +0000
Received: by mail-io1-f71.google.com with SMTP id k12so3709695iom.19
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 07:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R6Vp2q7Z0AYp/kVnpoBWr500ikgjJpj3Qnu3Hl9IZkg=;
        b=rwUvdALN4JCX6IoZRivraED9mK3rj8lNzuNqiUJC5hKycSqJBq0ZV+xFAQejKqGg4X
         NCCwvyi3ZYMNe7AyjJvrSDtRpMtEFZCDIwWH4k2x+VZ9yYOvZTRa/HBnJMFdNfc2ppKq
         JQSzeA1kE6bf6/vrTmv7VtH9IayJj0/Ofy9eb7WaXPrAR7KTnRJXNQ8hTpywsYeVUdOu
         TY+5Ywj4Q6cCQTV/2EW0WeT0eR2Z1kcIKzgjhMa7DqWmooIbUyWx69fGB/qhVDM1YabH
         Uk9ugcwjm9ny/+jy7q0gBtSyY8xe59MRGZV1rXe6Is8B5rkyEZlim43JtolAat/PQgXy
         VnyA==
X-Gm-Message-State: AOAM532hTIXeCNtweXy0XtESFw0onQk6iQ3tpE3Qf1gjaHZUcqcU8Ncg
        KcMhFxYAi4KsznhtCFmw8m7wSxkwLnFRAAcS+rttKmqFiPwrYKvt/TmDWJaYs0CT5/VbNYyKC6D
        ywvU6rCmSAMoW10EbVpGYDQQ08MNTILpEMhcXt8zdSA==
X-Received: by 2002:a92:aac8:: with SMTP id p69mr5123498ill.26.1594910372940;
        Thu, 16 Jul 2020 07:39:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBPP1hBjN4dv0mJH0CucnCvELVhUU8DEtOkN3QnRH7+kA6uRArkIsCl5a4LLp7dyeEYbWQWw==
X-Received: by 2002:a92:aac8:: with SMTP id p69mr5123478ill.26.1594910372525;
        Thu, 16 Jul 2020 07:39:32 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:90fa:132a:bf3e:99a1])
        by smtp.gmail.com with ESMTPSA id j19sm2779760ile.36.2020.07.16.07.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 07:39:31 -0700 (PDT)
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "test_bpf: flag tests that cannot be jited on s390"
Date:   Thu, 16 Jul 2020 09:39:31 -0500
Message-Id: <20200716143931.330122-1-seth.forshee@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 3203c9010060806ff88c9989aeab4dc8d9a474dc.

The s390 bpf JIT previously had a restriction on the maximum
program size, which required some tests in test_bpf to be flagged
as expected failures. The program size limitation has been removed,
and the tests now pass, so these tests should no longer be flagged.

Fixes: d1242b10ff03 ("s390/bpf: Remove JITed image size limitations")
Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 lib/test_bpf.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index a5fddf9ebcb7..ca7d635bccd9 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -5275,31 +5275,21 @@ static struct bpf_test tests[] = {
 	{	/* Mainly checking JIT here. */
 		"BPF_MAXINSNS: Ctx heavy transformations",
 		{ },
-#if defined(CONFIG_BPF_JIT_ALWAYS_ON) && defined(CONFIG_S390)
-		CLASSIC | FLAG_EXPECTED_FAIL,
-#else
 		CLASSIC,
-#endif
 		{ },
 		{
 			{  1, SKB_VLAN_PRESENT },
 			{ 10, SKB_VLAN_PRESENT }
 		},
 		.fill_helper = bpf_fill_maxinsns6,
-		.expected_errcode = -ENOTSUPP,
 	},
 	{	/* Mainly checking JIT here. */
 		"BPF_MAXINSNS: Call heavy transformations",
 		{ },
-#if defined(CONFIG_BPF_JIT_ALWAYS_ON) && defined(CONFIG_S390)
-		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
-#else
 		CLASSIC | FLAG_NO_DATA,
-#endif
 		{ },
 		{ { 1, 0 }, { 10, 0 } },
 		.fill_helper = bpf_fill_maxinsns7,
-		.expected_errcode = -ENOTSUPP,
 	},
 	{	/* Mainly checking JIT here. */
 		"BPF_MAXINSNS: Jump heavy test",
@@ -5350,28 +5340,18 @@ static struct bpf_test tests[] = {
 	{
 		"BPF_MAXINSNS: exec all MSH",
 		{ },
-#if defined(CONFIG_BPF_JIT_ALWAYS_ON) && defined(CONFIG_S390)
-		CLASSIC | FLAG_EXPECTED_FAIL,
-#else
 		CLASSIC,
-#endif
 		{ 0xfa, 0xfb, 0xfc, 0xfd, },
 		{ { 4, 0xababab83 } },
 		.fill_helper = bpf_fill_maxinsns13,
-		.expected_errcode = -ENOTSUPP,
 	},
 	{
 		"BPF_MAXINSNS: ld_abs+get_processor_id",
 		{ },
-#if defined(CONFIG_BPF_JIT_ALWAYS_ON) && defined(CONFIG_S390)
-		CLASSIC | FLAG_EXPECTED_FAIL,
-#else
 		CLASSIC,
-#endif
 		{ },
 		{ { 1, 0xbee } },
 		.fill_helper = bpf_fill_ld_abs_get_processor_id,
-		.expected_errcode = -ENOTSUPP,
 	},
 	/*
 	 * LD_IND / LD_ABS on fragmented SKBs
-- 
2.27.0

