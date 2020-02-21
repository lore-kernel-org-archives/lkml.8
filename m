Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470AEC35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC8024656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aunIb6a5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgBUL4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 06:56:55 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34224 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgBUL4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:56:54 -0500
Received: by mail-lf1-f66.google.com with SMTP id l18so1314090lfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 03:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WqvqteUL02nF35aPikvaB2EzjdMLOZk+dtxcf7VAZU4=;
        b=aunIb6a5G6Ktg69dhtVysybM8juQBWfgx5I0gK/uM5eIQ2op2sVE3pIeiJIudw2gB/
         NV/8yTZUBTikWco8M4Hhy/0hBB1prqENPbewIB70o8GQPJDFvtrh/rbx3pFPk/tNwADw
         xHezzG3Uuzd1pRSAEqw9MktFAYrY4Nu5JEn7ZpHJHgpSyH0ZFuwIloFhM075ZwTKpA7s
         CqSKU7GrsEV+XLPFCwiq7aLFc5zOSARXcBfkcpRKopKj1Fd2UTFQCrCeP5JMmuGM7DWf
         EhDSjFvKYitAgovZvM3mFkm8XyLgc31CTTcPqScEcS6p0wF/Uhqomna6zImvs+3cZYKc
         8XGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WqvqteUL02nF35aPikvaB2EzjdMLOZk+dtxcf7VAZU4=;
        b=A4wW55GRo9mZp3PzSLbWoTNjgaDeo/JQRCmADVDVdBLhjNbVojOcj7GGmqAP1Dxigr
         J4Y3v4ijtw9QOCOuQSjWNOINsinEtfQrMjog1Oi7ZqxVP6Vds2OMx7apZ1CyIf4zWqD9
         jhRyI6vwf7HD+G+2zuzoalv+xngKpiTiovamEn+5wvxqeDaM4GQFtR+HUt2nZyn1F6rX
         ejAkB+63T/qwgYz/5I0zajcLZcCAEfsUCgZkjNpH6svAXw1txGbLOt2OKZggiq/HDi0t
         f+4c1v4J4MX5e6NXaJFvP/0INGWa9NYDxVVEeSaXN2WjeGXMhRrRwqQSlfa/fWcjEr3i
         pXsw==
X-Gm-Message-State: APjAAAXReFF65yOFVY212Yv6v/AmjZRwA7aDQW2ZQ5VBIEydV62XMCnF
        cn/5ntkV4EgPD6E8bZh9vt8qYZHIqc/zHUyR81XaMg==
X-Google-Smtp-Source: APXvYqyevcJdek9iM0N8TKg7dnTMW58JtxQs/FBflx9EW1P9BTgQC+2fwHMFg/5AVGLr2s2b52Usx6dYjw1Sule9Y+A=
X-Received: by 2002:ac2:52a3:: with SMTP id r3mr19674556lfm.189.1582286212249;
 Fri, 21 Feb 2020 03:56:52 -0800 (PST)
MIME-Version: 1.0
References: <20200214152729.6059-1-vincent.guittot@linaro.org>
 <20200214152729.6059-4-vincent.guittot@linaro.org> <e115029f-d577-ba31-e8b1-bb0d1a3f0f80@arm.com>
In-Reply-To: <e115029f-d577-ba31-e8b1-bb0d1a3f0f80@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 21 Feb 2020 12:56:40 +0100
Message-ID: <CAKfTPtDiVVS-HhwESxjXAkzrhZD_qv=xdcNimTtLGtVjM-OLZQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] sched/pelt: Remove unused runnable load average
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2020 at 10:58, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 14/02/2020 16:27, Vincent Guittot wrote:
>
> [...]
>
> fdef CONFIG_SMP
> > @@ -2940,15 +2913,12 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
> >               u32 divider = LOAD_AVG_MAX - 1024 + se->avg.period_contrib;
> >
> >               se->avg.load_avg = div_u64(se_weight(se) * se->avg.load_sum, divider);
> > -             se->avg.runnable_load_avg =
> > -                     div_u64(se_runnable(se) * se->avg.runnable_load_sum, divider);
> >       } while (0);
> >  #endif
> >
> >       enqueue_load_avg(cfs_rq, se);
> >       if (se->on_rq) {
> >               account_entity_enqueue(cfs_rq, se);
> > -             enqueue_runnable_load_avg(cfs_rq, se);
> >       }
>
> Nit pick: No curly brackets needed anymore.
>

good catch

> [...]
