Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90806C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69C082064A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yBKQklaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439539AbgDPHko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 03:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439257AbgDPHkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:40:36 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DD9C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 00:40:35 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id j3so6263835ljg.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 00:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/vK0t1CeFnmzHdgV/edRSsR0Xg8bPdUElYkVOWjizyQ=;
        b=yBKQklaBBof8noCP4t3aOXQhmuV0x8tl82n8KD6avGbKMt5AU3JJqG2jA3+I1YGBbN
         uMnavUM0BlsEPtF5/Zg329kbYvWn8dWlOkDIr5bpKFoJV/oi40m28aOQG4E+f5MIMd+n
         R5Gj1OoxCn5Vd4ZR1Gg/aBasA7YTNKWVxNd/DqAawxq0uPziPp0rOgSB70esqprrT3/S
         By93R3tV0pZ3Ix/pQOsUIM886pC8H6NhUxXpHESSMlNmmGasdPFyOQxyRkT5ziuIalKi
         Hf9oPU9TAWlHmdTc5J/0D8XYCL7ponQuYaP3io1dpaccUxQCHwGCuA7n/MJcyXlwO0hh
         IweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/vK0t1CeFnmzHdgV/edRSsR0Xg8bPdUElYkVOWjizyQ=;
        b=a0agzQdtfxe1TkujGYvPPu/hqkRFfcUV7jpcm2y25loYp5Za/XBNXJtPZXHYcO6WVp
         U49YdrrOiKHq5FBR6q/fysfY3v4yKCz3cPwpaAgpnZB0HSY4fRQfsmJHKuwG8tiplXHy
         IbiwC8YOYKAMO0xnpq4ZAd8+fajZjLLOODM6TPN9XryPUuIo8k1FdDEhPuFPbsi4uQ6A
         4i6yRWx2UzSdSQITqWrRu856GddIs65Ph7Sq2+iz+UYA96zkXKkDv/e/lDSO1W8zkgL/
         gGoGOPc7mYa9JKb4ASItTbk+Avct1vrLq3GGWAt8+lQYCdPnd++IpQFBWj/7DYx6zMhL
         0+cA==
X-Gm-Message-State: AGi0PuakzRrLGafrJwMsN39yUNcMew6duihUGD44gl4gK1bQvAH4uZbO
        DZtJ6n3xHLfmeEzd6fxDv7dcxVOWCrxRaZneJJdw36yO
X-Google-Smtp-Source: APiQypLjiwIz85ndoP02JEFzC6OGmP2VbovPd0aEDhYLLIbUv4hPBoVf+s3S6P6hepcFjvglT0g3bAvXbUKJNC0hZaE=
X-Received: by 2002:a2e:800a:: with SMTP id j10mr5688029ljg.65.1587022834016;
 Thu, 16 Apr 2020 00:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200415210512.805-1-valentin.schneider@arm.com> <20200415210512.805-2-valentin.schneider@arm.com>
In-Reply-To: <20200415210512.805-2-valentin.schneider@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 16 Apr 2020 09:40:22 +0200
Message-ID: <CAKfTPtCn+NkJ+UWJQ_KJkQjSVY9vOrS36xzbPn6-15xTHKPznQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] sched/fair: find_idlest_group(): Remove unused
 sd_flag parameter
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020 at 23:05, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> The last use of that parameter was removed by commit
>
>   57abff067a08 ("sched/fair: Rework find_idlest_group()")
>
> Get rid of the parameter.
>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

This patch is not directly related to others

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 02f323b85b6d..98321d8dde7e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5821,8 +5821,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
>  }
>
>  static struct sched_group *
> -find_idlest_group(struct sched_domain *sd, struct task_struct *p,
> -                 int this_cpu, int sd_flag);
> +find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu);
>
>  /*
>   * find_idlest_group_cpu - find the idlest CPU among the CPUs in the group.
> @@ -5905,7 +5904,7 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
>                         continue;
>                 }
>
> -               group = find_idlest_group(sd, p, cpu, sd_flag);
> +               group = find_idlest_group(sd, p, cpu);
>                 if (!group) {
>                         sd = sd->child;
>                         continue;
> @@ -8677,8 +8676,7 @@ static bool update_pick_idlest(struct sched_group *idlest,
>   * Assumes p is allowed on at least one CPU in sd.
>   */
>  static struct sched_group *
> -find_idlest_group(struct sched_domain *sd, struct task_struct *p,
> -                 int this_cpu, int sd_flag)
> +find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>  {
>         struct sched_group *idlest = NULL, *local = NULL, *group = sd->groups;
>         struct sg_lb_stats local_sgs, tmp_sgs;
> --
> 2.24.0
>
