Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D972AC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A74DD2074B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pCDqqkMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgDUHSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 03:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgDUHSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 03:18:04 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1D1C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 00:18:04 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id f8so10240670lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 00:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BX4Z7l5ylvlpD/cGHF2TlCLLoCRJ2GUG9rjWlG7lI/8=;
        b=pCDqqkMcZ8vHjCvBaXooqfUmIfX2khXqw1s6Yg3SpnDKlOmiSEv8xbReXpZqKhBfhh
         6zVHpQmaB9IR1qSmFRPtVPpgsi6i2aHhCe4kF8JlZjHCafKzkw5Ec1rewA9VxKbagYMu
         soRP69kCOqDjaVLiEUbq1YjNpgAn4yuVZzA6nvVl576LiLB9RA45lbLr+Ba6h6sbV6Ug
         KlLVy0/1GScs1nWRXNiUb6Bucb61GFQNfqNs77JOQBv9gAQd0QvVIKPVsCqimGoC+uSN
         8uvkw4dNLVaWQRPHz7b4mZ6QfOJTfBj3Wi3RPidxv1GMzVUfSUToD1fEVqmRUtPMwoAb
         eQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BX4Z7l5ylvlpD/cGHF2TlCLLoCRJ2GUG9rjWlG7lI/8=;
        b=M7QNxE2sHMVVr8fWa8e/WXlH3NjSfNemC0Twks8LyNgyOEwzC9vXEQbWK8/P8OBcot
         ulXMZ+3j0ZgDT9V7V/YfmCZ4gmjXOdbBKXFSO4IB+8VYmiWirHS5iwarcZRp6/ZDaZ1t
         B2/zvVblHNzk6erl+OPShH/4h/P1QgwzRlvlNJ8vnTam3xZeDrdIzqfQBJ1bVsalFq5N
         lkHIH0n1UYvw9ZLfYOSZiLqHqO2ex/S1UC6u5pksretsfGSdAepVFe9UIMYbBivJymc4
         nCqa+0XharD3ao1/bqDIeNX+93TrG94fwiZFr0Dw2GcMtwmb2KJyCnVHxsPsDRBqiQja
         62QQ==
X-Gm-Message-State: AGi0PuZMf+fhApxfwlJJ5hQY18/kJJ0MMRFWTwo8+9tJqhCOi9eShcGj
        FcG36O4ydRlsYkLc6LUVg8GuxmJsiGqN20rYFIxgpjNB
X-Google-Smtp-Source: APiQypK+PN9MRPeavkXiNY/zDMA/5bCPt8NvlD44YYisUkDb0UYn+96ndAzPVQnpgAS/jc8q0p8sQPBX38uI96K42yw=
X-Received: by 2002:a19:c7d8:: with SMTP id x207mr12632280lff.190.1587453482312;
 Tue, 21 Apr 2020 00:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587393807.git.yu.c.chen@intel.com> <34d7c9496b77c928fcbe6085213115bd4d48d5a2.1587393807.git.yu.c.chen@intel.com>
In-Reply-To: <34d7c9496b77c928fcbe6085213115bd4d48d5a2.1587393807.git.yu.c.chen@intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 21 Apr 2020 09:17:50 +0200
Message-ID: <CAKfTPtAh0mgPyQLe9W3iPt_7eUZWqa1x+kTmdsP2+qxi_5icWw@mail.gmail.com>
Subject: Re: [PATCH 1/2][v2] sched: Make newidle_balance() static again
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Apr 2020 at 17:01, Chen Yu <yu.c.chen@intel.com> wrote:
>
> After Commit 6e2df0581f56 ("sched: Fix pick_next_task() vs 'change'
> pattern race"), there is no need to expose newidle_balance() as it
> is only used within fair.c file. Change this function back to static again.
>
> No functional change.
>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> v2: Rename the remaining idle_balance() to newidle_balance()
>     to fix an compile error when CONFIG_SMP is not set.
> ---
>  kernel/sched/fair.c  | 6 ++++--
>  kernel/sched/sched.h | 4 ----
>  2 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 02f323b85b6d..cca5c9b7b5ae 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3873,6 +3873,8 @@ static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq)
>         return cfs_rq->avg.load_avg;
>  }
>
> +static int newidle_balance(struct rq *this_rq, struct rq_flags *rf);
> +
>  static inline unsigned long task_util(struct task_struct *p)
>  {
>         return READ_ONCE(p->se.avg.util_avg);
> @@ -4054,7 +4056,7 @@ attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
>  static inline void
>  detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
>
> -static inline int idle_balance(struct rq *rq, struct rq_flags *rf)
> +static inline int newidle_balance(struct rq *rq, struct rq_flags *rf)
>  {
>         return 0;
>  }
> @@ -10425,7 +10427,7 @@ static inline void nohz_newidle_balance(struct rq *this_rq) { }
>   *     0 - failed, no new tasks
>   *   > 0 - success, new (fair) tasks present
>   */
> -int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> +static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  {
>         unsigned long next_balance = jiffies + HZ;
>         int this_cpu = this_rq->cpu;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index db3a57675ccf..be83f88495fb 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1504,14 +1504,10 @@ static inline void unregister_sched_domain_sysctl(void)
>  }
>  #endif
>
> -extern int newidle_balance(struct rq *this_rq, struct rq_flags *rf);
> -
>  #else
>
>  static inline void sched_ttwu_pending(void) { }
>
> -static inline int newidle_balance(struct rq *this_rq, struct rq_flags *rf) { return 0; }
> -
>  #endif /* CONFIG_SMP */
>
>  #include "stats.h"
> --
> 2.17.1
>
