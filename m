Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EDEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E9BC2074B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZtwkpJRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbgFIPnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730002AbgFIPnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 11:43:49 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A47C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 08:43:49 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id z206so12774809lfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 08:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mfvQ52ttcjK9Eq/voTG3poD585rerSCB/T3Uek+27ow=;
        b=ZtwkpJRD3VNhVTL/I2wbQ96ZghWx+3FqjLYZfi2FGrUA9GYI34kruy1gN1orlLo2rE
         21lpKqp0pVuBQvi7YvxSlx0RQigctaGswPEOuJ+0uGjb2Dgx1vfxPZ1hDtyVj2uCpGYb
         EKsvHqfci+huSC/6OcYspmnYGyQGUPnxa3EiRRX3GejQqvSVmTBrwCIb1yCJp3fwSwY7
         wZYfkBNiY2jUolBYLbCHDGUT4ryRlFWywnGSKRh/kPSbRPcCpYcc/4PjKIICbq3T6vUe
         q3otvxKQ9oyU2RHzFDGGmIvF8KYpN9Su8vxw6vo80hb7SGK0JmMVj8xU0spcRzu/FEXS
         gyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mfvQ52ttcjK9Eq/voTG3poD585rerSCB/T3Uek+27ow=;
        b=A8I00T4DOEn0ATktr/nc1oAEY9TIGyokgvP4uVDBnzqRxcBtCaHobk6+bpxjawrymu
         mLNijLr9+R+3oMSg4HYXLBDnzXVc7kxaAsun5qjHZuuwu1CZM0NpUmy5pjwmkXCKCYyF
         B/pw98nU9ZOlJxt/61hJu/rOZ4baKrTMmCvAlb3+0LkcDJrI9zYUraK54RG2JHj16XUJ
         R/N/gaTgDi/7Q5qZxlucgmem2hbbewOQByhi5UUc96eNJ26vxatLy+D/cSltvbYY7EJE
         e2jt43ofl8t6tyCCs0W1jYDaCI0EO71jdidNaDLdCoDpq18H2M2bb2qLVDFSuSrsoms4
         YtqQ==
X-Gm-Message-State: AOAM531GJkUzEeji8D5LYtOMqIRcBiE5fyuSx7F3Txmu4bIrgoOt3g3B
        75E96uCACcaEQdymfRO3Qpynnefhx2eGGw3++T0eVQ==
X-Google-Smtp-Source: ABdhPJzzIcCMETtg64OuH+C8AoVpH5ZWgZFaSfct8u6yHOYgGHwUtoGcjhi6YvK1e00GG7gcpCo1nwUR9vbotSJIk+o=
X-Received: by 2002:a19:4854:: with SMTP id v81mr15526135lfa.189.1591717427775;
 Tue, 09 Jun 2020 08:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200609150936.GA13060@iZj6chx1xj0e0buvshuecpZ>
In-Reply-To: <20200609150936.GA13060@iZj6chx1xj0e0buvshuecpZ>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 9 Jun 2020 17:43:36 +0200
Message-ID: <CAKfTPtCra0RQFehTJWNdfHjQMOnqxwajBgz-AGP5CrQxp_Rbsw@mail.gmail.com>
Subject: Re: [PATCH] sched: correct SD_flags returned by tl->sd_flags()
To:     Peng Liu <iwtbavbm@gmail.com>
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

On Tue, 9 Jun 2020 at 17:09, Peng Liu <iwtbavbm@gmail.com> wrote:
>
> During sched domain init, we check whether non-topological SD_flags are
> returned by tl->sd_flags(), if found, fire a waning and correct the
> violation, but the code failed to correct the violation. Correct this.
>
> Fixes: 143e1e28cb40 ("sched: Rework sched_domain topology definition")
> Signed-off-by: Peng Liu <iwtbavbm@gmail.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index ba81187bb7af..9079d865a935 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1328,7 +1328,7 @@ sd_init(struct sched_domain_topology_level *tl,
>                 sd_flags = (*tl->sd_flags)();
>         if (WARN_ONCE(sd_flags & ~TOPOLOGY_SD_FLAGS,
>                         "wrong sd_flags in topology description\n"))
> -               sd_flags &= ~TOPOLOGY_SD_FLAGS;
> +               sd_flags &= TOPOLOGY_SD_FLAGS;
>
>         /* Apply detected topology flags */
>         sd_flags |= dflags;
> --
> 2.20.1
>
