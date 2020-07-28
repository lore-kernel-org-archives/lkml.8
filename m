Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195B9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 18:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFE192070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 18:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="yKLE1prp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732174AbgG1SIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 14:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732157AbgG1SI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 14:08:29 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E02C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 11:08:29 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x9so10322064plr.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 11:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qYYHTthmGmJmqtQXZTsCmho3z7DfhWTZpaNa8DTuo20=;
        b=yKLE1prpIEfBrMQizKQZKaVHGb/NsvlAND9f475pZHCYIxnXGjK4ZpqI0nzeTZY0Bc
         WOgByJKi4xBsbmEWuxYLWvArOUT7a/U05BM2yuPy9z8UWj/Z9vPDIutslcMVXhx+tI/f
         KOShE7baX4n86nzgIqYYTNLcNzF7fshl6so5oAtBvYC3+CECJDI94GoOWjGc3UIYFgLM
         lFEWmWOwhGKDEqD5E9FHc+rdTxasMVc2MF8HBGe3YZhp0CV9gbxuZab7kna9wkTyFDXI
         s7vfF4fTVVb79d7nd3Mrtgom2muNY/iD89j2WwEzi1JKrMdQLc955Qrr19QcYLmz2Gxh
         6v1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qYYHTthmGmJmqtQXZTsCmho3z7DfhWTZpaNa8DTuo20=;
        b=Rpdmf6yN5DPcsQ8a/nJXfepL2p4OHM9RwInZ5ICOEXp0xWYqbA4P94VQF6aIoDRbZK
         pJ1Tn5ZWgAj9HiSluRTEmGcQkn7foJ1WT1tvdWSj8ULTcAYO4jr9D5J5YJlUvSHLbly7
         nq3e7r0VLsgU2UqwRmDsW8HcbeQiDWVazk3KGCwbNVw9qWvxUI0f+PkdmUgi19490wc/
         rWxzU58LYsulikH/BK6YN70SlN6Gq54f2wlVH0KmMSAgnLaMnnnXcbR+KJNelZbr9G1E
         aRa6asj0HZKADlslCmbUXqTAuyUFojVTTw10XaXo/NWPm483WEcgXat9cHK6aabyX6rq
         zotQ==
X-Gm-Message-State: AOAM533CV5JiqaHE8mYPIItVWmYh0H7fIOyi0SulHfrGI6fTiDOD3iJE
        WZfrQ422DE2olzouR0xOSmh3eQ==
X-Google-Smtp-Source: ABdhPJxee49DFdmLDI4r5lD0bPORKVD8XKosrTFF1Toa5yjTrk10rhlNO0JSR6NFyXNj537V7KMELA==
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr5858929pjp.228.1595959709350;
        Tue, 28 Jul 2020 11:08:29 -0700 (PDT)
Received: from C02CV1DAMD6P.sso.bytedance.com ([103.136.221.69])
        by smtp.gmail.com with ESMTPSA id n2sm19539822pfq.140.2020.07.28.11.08.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2020 11:08:29 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     zhouchengming@bytedance.com, songmuchun@bytedance.com
Subject: [PATCH 2/2] ftrace: skip special ftrace_ops when enable module
Date:   Wed, 29 Jul 2020 02:05:54 +0800
Message-Id: <20200728180554.65203-2-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200728180554.65203-1-zhouchengming@bytedance.com>
References: <20200728180554.65203-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enable module, we find all ftrace_ops referenced it on the
ftrace_ops_list. But FTRACE_OPS_FL_DIRECT and FTRACE_OPS_FL_IPMODIFY
flag are special, and should not be set automatically. So warn and
skip ftrace_ops that have these two flags.
Also check if only one ftrace_ops references the module, in which case
we can use trampoline as an optimization.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 kernel/trace/ftrace.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index a3d141f53c9e..8c1d9e3daa67 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6191,9 +6191,17 @@ static int referenced_filters(struct dyn_ftrace *rec)
 
 	for (ops = ftrace_ops_list; ops != &ftrace_list_end; ops = ops->next) {
 		if (ops_references_rec(ops, rec)) {
+			if (WARN_ON_ONCE(ops->flags & FTRACE_OPS_FL_DIRECT))
+				continue;
+			if (WARN_ON_ONCE(ops->flags & FTRACE_OPS_FL_IPMODIFY))
+				continue;
 			cnt++;
 			if (ops->flags & FTRACE_OPS_FL_SAVE_REGS)
 				rec->flags |= FTRACE_FL_REGS;
+			if (cnt == 1 && ops->trampoline)
+				rec->flags |= FTRACE_FL_TRAMP;
+			else
+				rec->flags &= ~FTRACE_FL_TRAMP;
 		}
 	}
 
-- 
2.20.1

