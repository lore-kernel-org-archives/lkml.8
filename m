Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C552C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB8A4207CB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Vv8F37mw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731420AbgEZHCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 03:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgEZHCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 03:02:52 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681BBC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:02:52 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x18so7167207pll.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Z0xKW5jGYiiw/3GeT46+0muUjmlt6YQxeB0UtKHbHyM=;
        b=Vv8F37mwKuXZ6y6Td16tf0OUUP4hiVqV1UO/3rkj623bgN1I9ccIiuIUReqYK0kEOl
         z95nqbfEpLcPYdvjItQhC9tHwQqtcoSb0qxCxd9zRpA16kGUzdsHLtI5EvyOCE0M7dQP
         Cp9EaLylJDiyIKi3uDP7V28Cn73JrLniaq0PcZ6uv29k8P0nNIf1KFCAgTo1UHZ7Lut7
         okCsi4st/LIAYpRmvAbbY2KSqfAa+zk28yH4vHKRdV05tcGY1okQvUqE35PdGGN0dhvU
         NpgvU9/QCVU9TNrdrbj2Hb0MXA5ZVakywr/sexsFoyef0xUozbuJwgD2ex+/kTxifgL/
         sgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z0xKW5jGYiiw/3GeT46+0muUjmlt6YQxeB0UtKHbHyM=;
        b=q+NiQdgVcgzrdUXkdmOEfcoRxhViFFHnKK9c3ln/Kjyl+yv4D4tHzDHrD8Gy+pMBYO
         V7253KrLsw1vno6RnfzTCkAdb4kRqN4Tq+gKifuYD2gUuRaHh1rFgMMzZrooZes6nFOO
         J48++8HpkjwMm9o0xn2Gp9qEs6eQuE54l6tbB/hQGc20jf/rdZLen5CwAlDHUw6VUAjy
         ZZxtEyBCzYEG46Nlt9XrcLBmgXAbCg1U2zqiyWzpOZCVn98F3C/eyWqQk4fQDG+peLkP
         hC/WMioJ/HnFQmSvXmTC50D5treLpeaQxP/ZtJO8Vk4Ces2OhqspOJyQWd0Qa9HJD052
         W47w==
X-Gm-Message-State: AOAM530//3eMml9kg1IhUEOOE6nETU49OoN2UM5QtjhmSEjIHSN/kr7H
        umBk+AVg1fuMVbO1b2ZIbGv/YQ==
X-Google-Smtp-Source: ABdhPJxeYDGp3LFQVg6j6dk5cVoVcGPzcAKqKwzg4Z7E15ygv7v81Xe5OwKMQK1KH/AW0urpZT5vCQ==
X-Received: by 2002:a17:90a:aa8d:: with SMTP id l13mr25740072pjq.92.1590476571974;
        Tue, 26 May 2020 00:02:51 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id q34sm15167431pja.22.2020.05.26.00.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 00:02:51 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com
Subject: [RFC PATCH v4 01/13] ptrace: Use regset_size() for dynamic regset size.
Date:   Tue, 26 May 2020 15:02:30 +0800
Message-Id: <3700190a602a6d30fcbf76e1eea667e29a65c4c9.1590474856.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590474856.git.greentime.hu@sifive.com>
References: <cover.1590474856.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It uses regset_size() instead of using regset->n and regset->size directly.
In this case, it will call the get_size() ported by arch dynamically to
support dynamic regset size case.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 kernel/ptrace.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 43d6179508d6..6877105e1b1e 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -882,13 +882,18 @@ static int ptrace_regset(struct task_struct *task, int req, unsigned int type,
 	const struct user_regset_view *view = task_user_regset_view(task);
 	const struct user_regset *regset = find_regset(view, type);
 	int regset_no;
+	unsigned int size;
 
-	if (!regset || (kiov->iov_len % regset->size) != 0)
+	if (!regset)
 		return -EINVAL;
 
 	regset_no = regset - view->regsets;
-	kiov->iov_len = min(kiov->iov_len,
-			    (__kernel_size_t) (regset->n * regset->size));
+	size = regset_size(task, regset);
+
+	if ((kiov->iov_len % size) != 0)
+		return -EINVAL;
+
+	kiov->iov_len = min(kiov->iov_len, (__kernel_size_t) size);
 
 	if (req == PTRACE_GETREGSET)
 		return copy_regset_to_user(task, view, regset_no, 0,
-- 
2.26.2

