Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CC8C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 15:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2302B20870
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 15:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRSRzUUC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387903AbgEWPxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 11:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgEWPxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 11:53:11 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91BFC061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 08:53:11 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ci21so6298325pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 08:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=esmMd/5Lzy1U7WGPOxHUeyLgPwXqqxfhbjwryYCGedo=;
        b=mRSRzUUCFMthEgMPFMtMpWoLmzuRI5h9o1Ru3nBuMijJVGbxroEXc/ovQafRIBiftT
         tyKL1TOt0VlvbLDzKlCzdbJLfk4nLvEiah//zC8kSR3nomghfojPP+R6NLYrbzx78jIq
         TndmKMWIAnVp9iheqh00TDUUzQyqeTJzJilA/Fv3/cifQt1J72GC7qQcG0cH3i9wiT/j
         MDFOe8qYWHDbgzND5QY8l6si/NytdozMdmmDDu1wUzpxRRyS4bLBp4bF/B0GLMZaAGr7
         VT2f9tNrbaQ0GsYrEOE1HUpwD28oYu4oIsekCVti+8TUwm40plz7CMsshhkELPQODHsk
         5bpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=esmMd/5Lzy1U7WGPOxHUeyLgPwXqqxfhbjwryYCGedo=;
        b=rdgmWMfDkw8HU1Jgq5yjoX4BNqR2AjexIjxKvJNGnkTJq3T/Qcqml4HjgvVVBit8IE
         pZw/FJCItXrZgHggpKKBtscmf0VVdsEM915pIiolS32vjrNjffkJeBE5OwGHZ4fasDof
         cMDPK3V6hoEYlJn9UKhLgAC6Sq3bXvWNpGa80zhXSIUYr/YtS4AjNemqGYXFFuH3brdI
         eoi/14ycCq5g0K6OiO4rXQJ5lH2mAu4bqqa4bdOKMNQUV01PbsZtTY7i343c9VQIau1D
         PSXIpVXNLSgdtMkUwnm7i5VWtrhuVImwWJZO99NglKFUs2LeBsP8C8lbqjWM3MU9xx8y
         ZJkA==
X-Gm-Message-State: AOAM532s9wS+pfy4rX7bXSJc6HAwu+pdG5wUiohZOu7KdZdBiv781O8S
        80v68sZzA56ItG0KbsDkAl4=
X-Google-Smtp-Source: ABdhPJxpbKDkSdFC+NvOAsMR7cwnLGz1umWT8k4iyBZYsp5wlegHkHI+Js+bjHORjfs22TW/tHaNdg==
X-Received: by 2002:a17:90a:9606:: with SMTP id v6mr11398023pjo.20.1590249191425;
        Sat, 23 May 2020 08:53:11 -0700 (PDT)
Received: from Smcdef-MBP.lan ([103.136.220.68])
        by smtp.gmail.com with ESMTPSA id n21sm9265061pjo.25.2020.05.23.08.53.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 May 2020 08:53:11 -0700 (PDT)
From:   Kaitao Cheng <pilgrimtao@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, Kaitao Cheng <pilgrimtao@gmail.com>
Subject: [PATCH] trace/ftrace: fix maybe-uninitialized compiler warning
Date:   Sat, 23 May 2020 23:53:04 +0800
Message-Id: <20200523155304.29554-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During build compiler reports some 'false positive' warnings about
variables {'seq_ops', 'filtered_pids', 'other_pids'} may be used
uninitialized. This patch silences these warnings.
Also delete some useless spaces

Signed-off-by: Kaitao Cheng <pilgrimtao@gmail.com>
---
 kernel/trace/ftrace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 7d0ebd104706..01a61bdc4e63 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2260,7 +2260,7 @@ ftrace_find_tramp_ops_next(struct dyn_ftrace *rec,
 
 		if (hash_contains_ip(ip, op->func_hash))
 			return op;
-	} 
+	}
 
 	return NULL;
 }
@@ -3599,7 +3599,7 @@ static int t_show(struct seq_file *m, void *v)
 			if (direct)
 				seq_printf(m, "\n\tdirect-->%pS", (void *)direct);
 		}
-	}	
+	}
 
 	seq_putc(m, '\n');
 
@@ -7151,6 +7151,9 @@ static int pid_open(struct inode *inode, struct file *file, int type)
 	case TRACE_NO_PIDS:
 		seq_ops = &ftrace_no_pid_sops;
 		break;
+	default:
+		trace_array_put(tr);
+		return -EINVAL;
 	}
 
 	ret = seq_open(file, seq_ops);
@@ -7229,6 +7232,9 @@ pid_write(struct file *filp, const char __user *ubuf,
 		other_pids = rcu_dereference_protected(tr->function_pids,
 					     lockdep_is_held(&ftrace_lock));
 		break;
+	default:
+		ret = -EINVAL;
+		goto out;
 	}
 
 	ret = trace_pid_write(filtered_pids, &pid_list, ubuf, cnt);
-- 
2.20.1

