Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6DAC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7302072D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 08:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L1c3dRTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgCSIHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 04:07:07 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42857 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgCSIHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:07:07 -0400
Received: by mail-lj1-f193.google.com with SMTP id q19so1348815ljp.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 01:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LOkrX7hW1zGRAHxDMsSc29fpSa89EQ6ExsGKUzqd/c4=;
        b=L1c3dRTMZB/bTBF1aoG5W0v5S6N/2LO7ZPkuHqJkB50/GOMdSn2QAJ/4cYIilCU0Eo
         fHKTV8aZfjq4m8XLvzVH8ppiK8r1FI6E0gUiCKm5SuhgbE/Hm9b4Fo+5g4b7EWqfjZcQ
         NHDFO83ryfVDgkWZUh/5tZ4yOD8vkoI+nFd17ILStwEp2JuIl8VPeBCDkhVCUyXYv9VN
         KYxxyQPtJNtDnQp8gnseX9FwDCm8RElkEpoXJvYH/RjjmVNLQievGQP6E3JgqgP7dZ9I
         Xqgs1jX6WdoiMKGNx3twCu13I3UyTTa7+qWIko7N9Z4MfI25JgVYBRCA9v5NYc0lWSSZ
         KUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LOkrX7hW1zGRAHxDMsSc29fpSa89EQ6ExsGKUzqd/c4=;
        b=MsGIFgdOEPuW3Vxj39cKKa0gdwM9A5kvYCnASLxPJu1N/z4B+vf+l1soOTuX5czOK2
         EQTE4NNrFBINMKq+cy/y7aOfrMSxya1BWxlZT/TUd67eaNW6Sc3iFl3rzi6h+NUgZIW5
         lFRXcPuOJ6nhUyD8pYjwVTisXTgPXjw3hvMNB+5lvqi7TvuXzlsVt2fAworR92sKCWoN
         6vm2I+WQ4gGMt5ob9+i709DflBr8gnL+e28SZeHtqNzKBZB6AkQGIlYrU/kGRYOA6Y34
         3okQeoz5Vw/2Kpb9q+B8V/+KqUCvO5YWOBYL+iqCZ0IjhemARwN3aQ9hYNO3+wBvQ37u
         aMiQ==
X-Gm-Message-State: ANhLgQ2b880xq8k9FeUqTz8ra3Zlc770SAB1RJmLSma8I+fzU/prN6Ht
        503q72qVy8ETwp3ZjZ0yaHYBcZM5lVPwDzw5xs/UjPao
X-Google-Smtp-Source: ADFU+vsiJTedd24y+49RLjRUaM5Ghhfhzk4I905exobtm5+wyqhF3RaqwEVB/AdGG/TzBQ3pS5yD98nyDJDM4ClzaSI=
X-Received: by 2002:a2e:9a0d:: with SMTP id o13mr1300022lji.151.1584605223303;
 Thu, 19 Mar 2020 01:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <BL0PR14MB3779226ECE6B526471FA91FD9AF40@BL0PR14MB3779.namprd14.prod.outlook.com>
In-Reply-To: <BL0PR14MB3779226ECE6B526471FA91FD9AF40@BL0PR14MB3779.namprd14.prod.outlook.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 19 Mar 2020 09:06:51 +0100
Message-ID: <CAKfTPtApQOGNLQBEGPF5UTFig2+ZbEoOVfK4GMD6uHXoeJNtzA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: fix condition of avg_load calculation
To:     Tao Zhou <ouwen210@hotmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>, "T. Zhou" <t1zhou@163.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Mar 2020 at 04:36, Tao Zhou <ouwen210@hotmail.com> wrote:
>
> In update_sg_wakeup_stats(), the comment says:
>
> Computing avg_load makes sense only when group is fully
> busy or overloaded.
>
> But, the code below this comment does not check like this.
>
> From reading the code about avg_load in other functions, I
> confirm that avg_load should be calculated in fully busy or
> overloaded case. The comment is correct and the checking
> condition is wrong. So, change that condition.
>
> Fixes: 57abff067a08 ("sched/fair: Rework find_idlest_group()")
> Signed-off-by: Tao Zhou <ouwen210@hotmail.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks

> ---
>  kernel/sched/fair.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1dea8554ead0..9cae03676b0d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8613,7 +8613,8 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
>          * Computing avg_load makes sense only when group is fully busy or
>          * overloaded
>          */
> -       if (sgs->group_type < group_fully_busy)
> +       if (sgs->group_type == group_fully_busy ||
> +               sgs->group_type == group_overloaded)
>                 sgs->avg_load = (sgs->group_load * SCHED_CAPACITY_SCALE) /
>                                 sgs->group_capacity;
>  }
> --
> 2.24.1
