Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C4FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE99F20674
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3LnSqcA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbgA3OXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 09:23:17 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38815 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgA3OXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 09:23:16 -0500
Received: by mail-pg1-f196.google.com with SMTP id a33so1733697pgm.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 06:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6T7BA/VeHSTmsgbu5fmQVa4i4NpuWX85GL9aH8ZEE74=;
        b=R3LnSqcAeDVQOAHlpG1owMpEpBN/wKJXlNPE4yy2OJftYy+o1XFdg2UvFuYOcApUCs
         wzj6xHPsgPqTmDBIZ31a33yVDP95XBf9aS8RiBaegWDx0USmHQD2N6xncypmbbIL/V7S
         pAZF1CnqdBCMYawpCCBIulwl5/aQ0566iMvNDUqD0+AwGHu/QG8wdXxZQtTPEX4MvPUC
         TJsILeo5ZsI7D1qb7HpdCPLQbJX37Lnr/P/obM2hE2jPsiRiv9YkcHI+EORU2tzzekTd
         lusGAtCSo5AWjvSe9SLGDRS1HbgWyDPTbTnruPvJ3wy/CXxvixVGmJ+tpuY6OacDhaFS
         i1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6T7BA/VeHSTmsgbu5fmQVa4i4NpuWX85GL9aH8ZEE74=;
        b=UmvxQX907rQRJd6z6WTBja5q5Bx5wbOR9JNnOM+yROHF8SPssv6lF2yF8654xAEgC7
         XurP5W17yRCQvWFSrkea3K2BFjQcNhxw79rNqORexxPpxbUQ/uO0ykzW4cnWhiVuyon8
         aZZtPDF9IJWQasFrhul6cvbf9ZSasg/jP2Y40gfRyAIvFXY11vsohiHuzS4GrKRZ1JXy
         IepAhi53q3ag1+Pyn9g8GOk3j49gLOt7AjKJ7I3UEd6jHc6RJr029ogmU3MJcUZSJHCh
         Lo2zSi63USowa7ftt4Wn40sUr/mH3iQcDTvKq/DcDyUupYtBHsT7QY4p/MqEg1ECIFeu
         oHxw==
X-Gm-Message-State: APjAAAV8LtHLhzIBzYvn08/Qqnav6WLcnJMxtiiedhuQ52OGqR3MROFE
        tdqOZGtV3r7RC0vhzVIKk0A=
X-Google-Smtp-Source: APXvYqyd+aww2fw9g4HcNT4GjoA8fFMGIE5pWD4/IgsGGZeCK+OdvzCgNlecdkjgsjA9wLillvUIvA==
X-Received: by 2002:aa7:874b:: with SMTP id g11mr5469169pfo.225.1580394195955;
        Thu, 30 Jan 2020 06:23:15 -0800 (PST)
Received: from localhost.localdomain ([103.211.17.117])
        by smtp.googlemail.com with ESMTPSA id m71sm9840602pje.0.2020.01.30.06.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 06:23:15 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH v2] callchain: Annotate RCU pointer with __rcu
Date:   Thu, 30 Jan 2020 19:48:19 +0530
Message-Id: <20200130141818.18391-1-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes following instances of sparse error
error: incompatible types in comparison expression
(different address spaces)
kernel/events/callchain.c:66:9: error: incompatible types in comparison
kernel/events/callchain.c:96:9: error: incompatible types in comparison
kernel/events/callchain.c:161:19: error: incompatible types in comparison

This introduces the following warning
kernel/events/callchain.c:65:17: warning: incorrect type in assignment
which is fixed as below

callchain_cpus_entries is annotated as an RCU pointer.
Hence rcu_dereference_protected or similar RCU API is
required to dereference the pointer.

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
v2:
- Squash both the commits into a single one.

 kernel/events/callchain.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index c2b41a263166..a672d02a1b3a 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -32,7 +32,7 @@ static inline size_t perf_callchain_entry__sizeof(void)
 static DEFINE_PER_CPU(int, callchain_recursion[PERF_NR_CONTEXTS]);
 static atomic_t nr_callchain_events;
 static DEFINE_MUTEX(callchain_mutex);
-static struct callchain_cpus_entries *callchain_cpus_entries;
+static struct callchain_cpus_entries __rcu *callchain_cpus_entries;
 
 
 __weak void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
@@ -62,7 +62,8 @@ static void release_callchain_buffers(void)
 {
 	struct callchain_cpus_entries *entries;
 
-	entries = callchain_cpus_entries;
+	entries = rcu_dereference_protected(callchain_cpus_entries,
+					    lockdep_is_held(&callchain_mutex));
 	RCU_INIT_POINTER(callchain_cpus_entries, NULL);
 	call_rcu(&entries->rcu_head, release_callchain_buffers_rcu);
 }
-- 
2.24.1

