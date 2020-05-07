Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08A9C47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC192216FD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VpHuDRD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgEGSKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728398AbgEGSKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:10:37 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFACDC05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 11:10:35 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id g14so8108421qts.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 11:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DfxtwXI8P8XYrWM5eaBon+8Miqx9tOiiT4uA5B/D10w=;
        b=VpHuDRD3x1EhaaRdJqrnbGTDyAXQO4MFmWH4pJHMS83w4ots6AXYPEFxqNMMm0qGZZ
         LFiJv4ekcAnYvmWhZGt06rYb+pN3owdaJPkkA/v0FeipJzuCvO10Jb/MwaRjTeMpt0UK
         t6OHkQnPhqLt4WpxTiuixQRnYh3LpnTulmrdKdCtsaeKYAPgKRqF1C8RLaT24hBj1j2E
         S/unIaQOkLs2Ga8pAx0Cwv8mml64n8ey3EGv0ST710vZNEz0elcR+8XMAJN+flMjlgMj
         LlOaEL39pa1UbV7CYf+18zzWcQVX3r4JyfjV9YIq/bFHDirTQUipLCaJ7glZdREobAiC
         JkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DfxtwXI8P8XYrWM5eaBon+8Miqx9tOiiT4uA5B/D10w=;
        b=nDnaVO0ZZUGG6M51kKlUzCNGB8v/4zrZid22zEUgCAN0jIjii9eURXmFLnFz3nIyYg
         QzdpcaxG5GpFPRS6Idtq0teMCcx0HNKaLuZiHER8Rv+1JGXe2D+D/Y31Bvb3ozLCQVxL
         tmPrKbUlejj6Q/8ZptlGXxbwuZH5YN8nAJsG7gZVH+4JijPArKRGjWcGp82ef3U93PjS
         S6E9Qr1ZSCc5nVwk9+ZuvZypS9MAbHT9h46K+dlrpwqY98J9BHp9gdqhlrtOL7KhB+Dp
         KmNDsU8AdhG4sI4X0fyZSJvmeqdxBeU7GN8EgWMCwlXVoisNkzQIsggb93J/duMGJG6F
         aT1Q==
X-Gm-Message-State: AGi0PuZWTAUUtMVyOEZh+8wCfqxvnXC6vm95XtSyXYV2stgUSt148MMY
        unRf0Ldu9ctrcehWUBkgy6vNzGUSURlxBpk8iV7IxMiIrbNtNYaMavnV40A/XDZdaUkas0+K6z7
        MCCbgjJmCjWmJfluTW0LfzI3wkipKn33VXMY55XivBxs5x5isSj9O3cbCspAtuyFMg4qtBdkX
X-Google-Smtp-Source: APiQypISczuWnNG4La/XG2W8nFH7JeUZ2tqgh5D3kd/vIRdYL3gah5ZjsGOiYjkD93PCI2ZdBobicL9VO7GJ
X-Received: by 2002:a05:6214:15d1:: with SMTP id p17mr15021011qvz.45.1588875034647;
 Thu, 07 May 2020 11:10:34 -0700 (PDT)
Date:   Thu,  7 May 2020 19:10:07 +0100
In-Reply-To: <20200507181012.29791-1-qperret@google.com>
Message-Id: <20200507181012.29791-10-qperret@google.com>
Mime-Version: 1.0
References: <20200507181012.29791-1-qperret@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH 09/14] sched/cpufreq: Export cpufreq_this_cpu_can_update()
From:   Quentin Perret <qperret@google.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, fweisbec@gmail.com, tkjos@google.com,
        kernel-team@android.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will be needed by schedutil once modularized, export it.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 kernel/sched/cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
index 82f2dda61a55..f4abe4e4e927 100644
--- a/kernel/sched/cpufreq.c
+++ b/kernel/sched/cpufreq.c
@@ -75,6 +75,7 @@ bool cpufreq_this_cpu_can_update(struct cpufreq_policy *policy)
 		(policy->dvfs_possible_from_any_cpu &&
 		 rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data)));
 }
+EXPORT_SYMBOL_GPL(cpufreq_this_cpu_can_update);
 
 #ifdef CONFIG_ENERGY_MODEL
 extern bool sched_energy_update;
-- 
2.26.2.526.g744177e7f7-goog

