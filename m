Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4F8C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A841B2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SCTFpBe+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633358AbgDNUpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633343AbgDNUpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:45:19 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E90C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:45:19 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id u10so513945ual.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1nQoHzY7Vq+dku+c89gQWF9S4/oj+wkTrvP3Wtwkeew=;
        b=SCTFpBe+EJMWAnxttwEG8FJf9k17ZjaG8iQwISmQhLhAlMv69xpmPL1+L9Oy0b3gar
         XVHLExwtSRMPhhgjoQuqsku+kXwrO8moRaeslPL/VxdHRC3KGUgnLA93Z/UYo4K4MxlU
         KcDJ3FGOddyRHZCQCNBWwcuzTA27njMtVlSlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1nQoHzY7Vq+dku+c89gQWF9S4/oj+wkTrvP3Wtwkeew=;
        b=ZiDUTenO1KejRy8ZGj75OFOsgGf2IRSQVvJB3IOnSmVENWI+KBl+eLyFEHmotso3ik
         AVbmhxFefPAOOHT0hw/iE643RBmiK5TCcDvQ6esF5v1F1f2LJXG2NqCe/jEXmwyxYJFb
         TesoDMAflyN4rWYL70I/+ctMhtJ4ppI8Jd7rAmQEfnORJs6wTK6Po54DVhohxUx5PvNB
         eY4RTR+QrCo4V8hwFYI2qawP/z4MjWJ1ywNZdML+YaN/layVvmzljbnJBytesEgaZ3oV
         sKPRX+M7EPxbkKFFKrjmn1RHL4LJLjUKIUkkBdbbhPsRqYdb1uZEBsneOWNJeMqgAj6/
         FtWA==
X-Gm-Message-State: AGi0Pua6mtV5ym0EyDB2VGfJCWAaibfv/7KkitjQ3qy1EW0cCukeOFUW
        M6G0tROLsIn96CIdfwylDJnvxwMOA8g=
X-Google-Smtp-Source: APiQypKT6eNndCqXWM8CNlZ2PJSkQCv+8LSb+WVO8+uJM2Urc9tyOl34sd/f7DZxWQIPEwfDwO3gaQ==
X-Received: by 2002:ab0:3496:: with SMTP id c22mr1950003uar.49.1586897116674;
        Tue, 14 Apr 2020 13:45:16 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id t66sm1420611vkb.23.2020.04.14.13.45.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 13:45:15 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id p28so848237vsg.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:45:15 -0700 (PDT)
X-Received: by 2002:a05:6102:3204:: with SMTP id r4mr1752068vsf.109.1586897114591;
 Tue, 14 Apr 2020 13:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200414161320.251897-1-qperret@google.com>
In-Reply-To: <20200414161320.251897-1-qperret@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 14 Apr 2020 13:45:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vo4h43vS1K1+ziAJhQ3UG+Zrx8JN8Q1tkMWU1Oh6OavA@mail.gmail.com>
Message-ID: <CAD=FV=Vo4h43vS1K1+ziAJhQ3UG+Zrx8JN8Q1tkMWU1Oh6OavA@mail.gmail.com>
Subject: Re: [PATCH] sched/core: Fix reset-on-fork from RT with uclamp
To:     Quentin Perret <qperret@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        bsegall@google.com, mgorman@suse.de, ctheegal@codeaurora.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        qais.yousef@arm.com, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 14, 2020 at 9:13 AM Quentin Perret <qperret@google.com> wrote:
>
> uclamp_fork() resets the uclamp values to their default when the
> reset-on-fork flag is set. It also checks whether the task has a RT
> policy, and sets its uclamp.min to 1024 accordingly. However, during
> reset-on-fork, the task's policy is lowered to SCHED_NORMAL right after,
> hence leading to an erroneous uclamp.min setting for the new task if it
> was forked from RT.
>
> Fix this by removing the unnecessary check on rt_policy() in
> uclamp_fork() as this doesn't make sense if the reset-on-fork flag is
> set.
>
> Reported-by: Chitti Babu Theegala <ctheegal@codeaurora.org>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  kernel/sched/core.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3a61a3b8eaa9..9ea3e484eea2 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1234,10 +1234,6 @@ static void uclamp_fork(struct task_struct *p)
>         for_each_clamp_id(clamp_id) {
>                 unsigned int clamp_value = uclamp_none(clamp_id);
>
> -               /* By default, RT tasks always get 100% boost */
> -               if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
> -                       clamp_value = uclamp_none(UCLAMP_MAX);
> -
>                 uclamp_se_set(&p->uclamp_req[clamp_id], clamp_value, false);

The local variable "clamp_value" doesn't have a lot of value anymore,
does it?  (Pun intended).  Remove it?

-Doug
