Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6FFC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01A7D2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S5HfZ0Q5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407018AbgDNIKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406992AbgDNIJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:09:13 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E264C0A3BDC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 01:09:12 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id r7so11426498ljg.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 01:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BH97faggmx227cgHpqUW9JiWE/eaQpsgM1AKIb1xoFQ=;
        b=S5HfZ0Q5do+ZQxO2izw86Wx99lJRZBoj9bO6GRsr6lRMbs7Zis4y7ox6OxZ1fIztwm
         qYcpGxmBntky93DfrWAuFE8EDrtGsG+alRgjrwcEr4D7YkUYe4HFCKr0qhGv9QYFI1fq
         1RZX6r+CnUrUgHQ8TI7Xcre5arBYpcZAyOIoGmoHPJkdOi/Fe8MS2rDY7K7MAiU6T7oK
         R77uuqj+NDzQCY+8tqAu7pqhXCNs21XyLBEI41F1rXwv+TKgSVZQha/NjZv0iuzEVPvy
         00d6h7tU5vJzQqtHdRcRRC3ZdMYE/GXKHsvQeEpzn8fxHjmwuJzRGxFX831SibCGwXEk
         MqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BH97faggmx227cgHpqUW9JiWE/eaQpsgM1AKIb1xoFQ=;
        b=K82H/PLkIOLXwBH4FuJCXjmp5LoImfSyAtlohK/NvfMusfMnjkXiO65sbG5EOWpI1b
         bRj91kCDL1W9fjuqFFsge/m8NAb+rswJJ3ju1S2wKGMeUmtu7zVFm9MF/EkVtAqNyM5q
         RlA1PwUXI9u37P2Wk3sKGz2ciTc44MCPfpJky7vQBUMjdg6pjPBzXxidWn5ZsU621/cd
         NPjEBuHdY3ErTTyDkcqiBMYOE6Eunt5vgPPj9ZhHjVfQKGimuw/ioJl+UjZ3KOcNbzfj
         HUYtTK7K+IQMhVzesJFPvoitQgHHnI4NVsRNH5eOmwyHoHyP7R9DtTvDGv3vwqsdWVd/
         JMKA==
X-Gm-Message-State: AGi0PuaHPPti+Zr1VeiRnKWzDEFlyuUBzhf0Yp1j/lx3wnm3wsdibGnS
        XN1zpV/JRpEl6HsBKkHGkrdEehM7vSCp/fobgWIQOw==
X-Google-Smtp-Source: APiQypIIk2cLXHtiC8MnuNrPh7up9FX+y9rMvbK44VZBdB7km9+JE7XQ6tW30FdFYhEhIsN78Q87x1WEPGMi4vfe+OM=
X-Received: by 2002:a2e:9d98:: with SMTP id c24mr12075706ljj.137.1586851750461;
 Tue, 14 Apr 2020 01:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <1586779281-103078-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1586779281-103078-1-git-send-email-zou_wei@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 14 Apr 2020 10:08:58 +0200
Message-ID: <CAKfTPtDtJo2Vnziy9cLGyORqmN-1u+Mf=jKZmeKR0yMuHz1kuA@mail.gmail.com>
Subject: Re: [PATCH-next] sched/topology: use true, false for bool variable
To:     Zou Wei <zou_wei@huawei.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Mon, 13 Apr 2020 at 13:55, Zou Wei <zou_wei@huawei.com> wrote:
>
> Fixes coccicheck warning:
>
> kernel/sched/topology.c:224:3-22: WARNING: Assignment of 0/1 to bool variable
> kernel/sched/topology.c:226:3-22: WARNING: Assignment of 0/1 to bool variable
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

You will probably be interested by this thread
https://lkml.org/lkml/2020/3/27/785

> ---
>  kernel/sched/topology.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 8344757b..e4d6464 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -221,9 +221,9 @@ int sched_energy_aware_handler(struct ctl_table *table, int write,
>                 state = static_branch_unlikely(&sched_energy_present);
>                 if (state != sysctl_sched_energy_aware) {
>                         mutex_lock(&sched_energy_mutex);
> -                       sched_energy_update = 1;
> +                       sched_energy_update = true;
>                         rebuild_sched_domains();
> -                       sched_energy_update = 0;
> +                       sched_energy_update = false;
>                         mutex_unlock(&sched_energy_mutex);
>                 }
>         }
> --
> 2.6.2
>
