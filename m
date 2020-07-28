Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F32C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6751120775
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="wlUGHodU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbgG1K1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbgG1K1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:27:32 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183F0C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:27:31 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id c6so4676570pje.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ksd9LUrv2SAGVhJ0FmbAsq4ccK2OJaCqi/fyO01WfE=;
        b=wlUGHodUqQ4+CyShn+11SeMZjYQHWKk53pL8tl3Co65gXt7kNOXN96eqmgRC+7KGjl
         TlX5g9hJ/bseyt4K27NnpzieAUX3nD6+gdEKpu+SeBhP1Udyg0ClJTwR69iWNq5IqHG5
         Vo2jFD31Oa/bsjOqQrLaBLcZgsL4Hu9PwWl++kQHH5gFtNfx5cUcGu032XnBrX7/LxMC
         LG5E/aJTdJofgXG2nayiq/12MB8D0uKdIrtnvGZb0sFfvxiG/NASoAvxsjjqt5HrDfM4
         tvmWaLUEMbnGgevSiAjF4v3IbvoKLKlsXdBUyANDJVTpk3YjLcAj7Hmza9e1BlG/rXTZ
         5eHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ksd9LUrv2SAGVhJ0FmbAsq4ccK2OJaCqi/fyO01WfE=;
        b=FETNZY5L4OEtiaU5dQW61VHOIraPBnd6WwClx5NnodDj1JeExo4aT8qqX6UDJb7or9
         ui215C9PLKPikFKicbAxMnyz5S33DO2jqDvXPoE01QpF1OfMHt3wpd1Nd4fBamFBvEbO
         TuTGKuWgv4rVLDKW4bERjThkydjm7scBWZRxscQo/J6XbS+K2vIE2zafLFmN9hUqFzwq
         +FuJtVxQW5fnIcdNWleln0n9Y6QHPzqjeVjkwDk9UvSKepTkT+3gkYpfxmlV7UKqlT7h
         CZJUjsa9Wj7QCBYH7nK+tn23NI368jDSqXxLfvopMpwAjZRklfdVfW9JbdOLx25AYmu9
         2veg==
X-Gm-Message-State: AOAM531aJTJOpMkgjFePzPsOVEn1QUK6611IuaQM5A3twRuY4sWlSX+m
        Va5nKbQ+ieyzo15MndwGmAFujA==
X-Google-Smtp-Source: ABdhPJzqf5xKIz43peJ2utVXN58W30NzDVN/y9xJMrgCp+mbDPkkyD6wciup/0435+iSlnJqRh6weg==
X-Received: by 2002:a17:90b:1881:: with SMTP id mn1mr3738579pjb.198.1595932050698;
        Tue, 28 Jul 2020 03:27:30 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([103.136.220.73])
        by smtp.gmail.com with ESMTPSA id m9sm2613056pjs.18.2020.07.28.03.27.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2020 03:27:30 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     songmuchun@bytedance.com, zhouchengming@bytedance.com
Subject: [PATCH 2/2] ftrace: setup correct flags before replace code of module rec
Date:   Tue, 28 Jul 2020 18:27:20 +0800
Message-Id: <20200728102720.46837-2-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200728102720.46837-1-zhouchengming@bytedance.com>
References: <20200728102720.46837-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When module loaded and enabled, we will use __ftrace_replace_code
for module if any ftrace_ops referenced it found. But we will get
wrong ftrace_addr for module rec in ftrace_get_addr_new, because
rec->flags has not been setup correctly.
So setup correct rec->flags when we call referenced_filters to find
ftrace_ops references it.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 kernel/trace/ftrace.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index fca01a168ae5..00087dea0174 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6190,8 +6190,17 @@ static int referenced_filters(struct dyn_ftrace *rec)
 	int cnt = 0;
 
 	for (ops = ftrace_ops_list; ops != &ftrace_list_end; ops = ops->next) {
-		if (ops_references_rec(ops, rec))
-		    cnt++;
+		if (ops_references_rec(ops, rec)) {
+			cnt++;
+			if (ops->flags & FTRACE_OPS_FL_DIRECT)
+				rec->flags |= FTRACE_FL_DIRECT;
+			if (ops->flags & FTRACE_OPS_FL_SAVE_REGS)
+				rec->flags |= FTRACE_FL_REGS;
+			if (cnt == 1 && ops->trampoline)
+				rec->flags |= FTRACE_FL_TRAMP;
+			else
+				rec->flags &= ~FTRACE_FL_TRAMP;
+		}
 	}
 
 	return cnt;
@@ -6373,7 +6382,8 @@ void ftrace_module_enable(struct module *mod)
 			cnt += referenced_filters(rec);
 
 		/* This clears FTRACE_FL_DISABLED */
-		rec->flags = cnt;
+		rec->flags &= ~FTRACE_FL_DISABLED;
+		rec->flags += cnt;
 
 		if (ftrace_start_up && cnt) {
 			int failed = __ftrace_replace_code(rec, 1);
-- 
2.20.1

