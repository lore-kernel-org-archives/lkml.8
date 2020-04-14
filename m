Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316BCC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 17:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 154CE206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 17:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407624AbgDNRVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 13:21:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33659 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407594AbgDNRV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 13:21:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id a25so15353474wrd.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 10:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pFmpb+RA+NWz9T4WQIzSSblNv9ya5RwMO1G2Lr5Br/c=;
        b=E6pl8bRclDUQzmGxEzTlKzs+PpS3PN26S3O2BW8s/c+jjR1SADr/4GISXuCvRQ8sDZ
         Uq0CvTqg/lDvhhrCnd3GLiMhZB89ZdSg+yAlmsQYeNP8Osf/ryS6rn0QvhdHQf/pF7nr
         Nq2r0GZ50CdTabInS4ypwtxqZiG5vqP1iWrCq1trpMb2wpPV9AFWLtE8UCPp3OeARDeX
         snwgmU76EjgYadBuvTiAYcf+8V+ljniluq81u2pAfS7JaWEqr8WnuJCUcpytaewLt9dZ
         X2KSVDOF1BJ/0Uv9kpgBuimnFLwhsHb5IftPetiXuFXOgNn16kF7+5V79NpYInGWNwNu
         ZNFA==
X-Gm-Message-State: AGi0PubeNcqRRfhkUy0X0D+1TvLepZLPL7yWSVyWyS/FeKmxqvhd6RRn
        gVVozr5BX548ujyLQUzQgBY=
X-Google-Smtp-Source: APiQypKGLMd4Io+mmJCD/aE71mw75UTb89hD2sdyZ51tFIcs+6M14eUwDvUS4XBySaMGdiIp8wTneg==
X-Received: by 2002:a5d:6091:: with SMTP id w17mr21891200wrt.382.1586884886048;
        Tue, 14 Apr 2020 10:21:26 -0700 (PDT)
Received: from darkstar ([51.154.17.58])
        by smtp.gmail.com with ESMTPSA id j135sm20463515wmj.46.2020.04.14.10.21.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Apr 2020 10:21:25 -0700 (PDT)
Date:   Tue, 14 Apr 2020 19:21:20 +0200
From:   Patrick Bellasi <patrick.bellasi@matbug.net>
To:     Quentin Perret <qperret@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        ctheegal@codeaurora.org, dianders@chromium.org,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH] sched/core: Fix reset-on-fork from RT with uclamp
Message-ID: <20200414172120.GA20442@darkstar>
References: <20200414161320.251897-1-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414161320.251897-1-qperret@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-Apr 17:13, Quentin Perret wrote:
> uclamp_fork() resets the uclamp values to their default when the
> reset-on-fork flag is set. It also checks whether the task has a RT
> policy, and sets its uclamp.min to 1024 accordingly. However, during
> reset-on-fork, the task's policy is lowered to SCHED_NORMAL right after,
> hence leading to an erroneous uclamp.min setting for the new task if it
> was forked from RT.

Right, good catch. Thanks.

> Fix this by removing the unnecessary check on rt_policy() in
> uclamp_fork() as this doesn't make sense if the reset-on-fork flag is
> set.
> 
> Reported-by: Chitti Babu Theegala <ctheegal@codeaurora.org>
> Signed-off-by: Quentin Perret <qperret@google.com>

Fixes: 1a00d999971c ("sched/uclamp: Set default clamps for RT tasks")
Reviewed-by: Patrick Bellasi <patrick.bellasi@matbug.net>

> ---
>  kernel/sched/core.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3a61a3b8eaa9..9ea3e484eea2 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1234,10 +1234,6 @@ static void uclamp_fork(struct task_struct *p)
>  	for_each_clamp_id(clamp_id) {
>  		unsigned int clamp_value = uclamp_none(clamp_id);
>  
> -		/* By default, RT tasks always get 100% boost */
> -		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
> -			clamp_value = uclamp_none(UCLAMP_MAX);
> -
>  		uclamp_se_set(&p->uclamp_req[clamp_id], clamp_value, false);
>  	}
>  }
> -- 
> 2.26.0.110.g2183baf09c-goog
> 

-- 
#include <best/regards.h>

Patrick Bellasi
