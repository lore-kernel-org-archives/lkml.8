Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037C4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDC6120771
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgFRX5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 19:57:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728401AbgFRX4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 19:56:42 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A62E5217A0;
        Thu, 18 Jun 2020 23:56:42 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jm4Of-003lUP-NJ; Thu, 18 Jun 2020 19:56:41 -0400
Message-ID: <20200618235641.608168693@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 18 Jun 2020 19:56:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kaitao Cheng <pilgrimtao@gmail.com>
Subject: [for-linus][PATCH 17/17] ftrace: Fix maybe-uninitialized compiler warning
References: <20200618235556.451120786@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaitao Cheng <pilgrimtao@gmail.com>

During build compiler reports some 'false positive' warnings about
variables {'seq_ops', 'filtered_pids', 'other_pids'} may be used
uninitialized. This patch silences these warnings.
Also delete some useless spaces

Link: https://lkml.kernel.org/r/20200529141214.37648-1-pilgrimtao@gmail.com

Signed-off-by: Kaitao Cheng <pilgrimtao@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c163c3531faf..1903b80db6eb 100644
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
 
@@ -7151,6 +7151,10 @@ static int pid_open(struct inode *inode, struct file *file, int type)
 	case TRACE_NO_PIDS:
 		seq_ops = &ftrace_no_pid_sops;
 		break;
+	default:
+		trace_array_put(tr);
+		WARN_ON_ONCE(1);
+		return -EINVAL;
 	}
 
 	ret = seq_open(file, seq_ops);
@@ -7229,6 +7233,10 @@ pid_write(struct file *filp, const char __user *ubuf,
 		other_pids = rcu_dereference_protected(tr->function_pids,
 					     lockdep_is_held(&ftrace_lock));
 		break;
+	default:
+		ret = -EINVAL;
+		WARN_ON_ONCE(1);
+		goto out;
 	}
 
 	ret = trace_pid_write(filtered_pids, &pid_list, ubuf, cnt);
-- 
2.26.2


