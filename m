Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645A3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42BF120707
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEvH/XEl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgE2OMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 10:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgE2OMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 10:12:23 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4994DC03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 07:12:22 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h95so490518pje.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 07:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q+ZXJZD6VNc3L6gubIiUbw9tjndzrYoirfTHkhQnlLo=;
        b=bEvH/XElNbmrZFWh62hcAeEhGBTCMtQV+iBAho/OsJYyO4ZG+xCJIRGQuBvoi2iclY
         UzX3B7ckDIiAokiGuHAGHmjLtKYjF2r6cFFXtOjJuLN3yxPBrUt3KDJ8yzf7i1B8fICk
         gPcXR9qSIFWkZciCI1Vc9Iv+HXxJ98PjCe6OBgYvYWybzidzgFROYFnwX0oawk+VR4sy
         01+0D412JQ3uh7sjlTbBDfKanhN+F+jjU0SZCLpixqUo4kvowQTJKo1OtDpPVpjceT+2
         4QA0dV6JvcdMiCLkxqdbQa0JphAEIZiHbEa99niiFoeAXKBfR+cPcOwnVMpjqIIVxmwh
         SERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q+ZXJZD6VNc3L6gubIiUbw9tjndzrYoirfTHkhQnlLo=;
        b=CYkHfl8F/TPCVqXMTWHu9juLECpWOMamfrd6Nbb5DKtKRh8QmT9e+kqxVvXHFGpjkB
         WPWaqmbgp8/T2yfMHsxvfctH7OJD7IFWVEyCd6Mj35LORyt8NxBTmmicbEBJRH5o4DRf
         XcrORpbE9PlO8R3ZZ5lX8OQNlpwdmJfKLATzVI3DXjfRtfgvoavCTGO9PIzr3GxEA6xS
         at90Xzyzo9jfUMPIbrONojvYs6Z/KrwfQdGaYAqRlr1Q/G+LECh1t3fC5KBA/uuTOWOo
         l/hWPTytVFgowFEXwn0LVBbYVy+rQYMcbK3s0B9UhmvpUOnO5APP+teihHjzdhh98J2t
         vpnA==
X-Gm-Message-State: AOAM5300iWSC740Fig8dBmcmoe/5X30Dl5vKeSTZtXyomPguhJ+DK5qT
        YmK+1Ip5wz71i3gXtF2/ZCM=
X-Google-Smtp-Source: ABdhPJxdp9Zz/MjXWV7ihsrKN9B5ZQKm9rXmZpgRiVjaMh0MCw5q2iRM3s36MP143EE9j1ZL5hEaRA==
X-Received: by 2002:a17:90a:e016:: with SMTP id u22mr9743494pjy.28.1590761541784;
        Fri, 29 May 2020 07:12:21 -0700 (PDT)
Received: from localhost.localdomain ([103.136.221.67])
        by smtp.gmail.com with ESMTPSA id d8sm7544020pfq.123.2020.05.29.07.12.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 07:12:21 -0700 (PDT)
From:   Kaitao Cheng <pilgrimtao@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Kaitao Cheng <pilgrimtao@gmail.com>
Subject: [PATCH v2] trace/ftrace: fix maybe-uninitialized compiler warning
Date:   Fri, 29 May 2020 22:12:14 +0800
Message-Id: <20200529141214.37648-1-pilgrimtao@gmail.com>
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
 kernel/trace/ftrace.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 7d0ebd104706..b4a458990ad0 100644
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
2.20.1

