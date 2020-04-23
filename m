Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C986EC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A366620781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K8nCnasd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgDWMBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 08:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728105AbgDWMBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 08:01:45 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B4FC035494
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 05:01:43 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id z16so5356557uae.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 05:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6RVs2stJFURA5obC9tinkDwdWMYjzoWbL6NDUAFkfJc=;
        b=K8nCnasdq2dphiiwitIx4wTqF8rQ2vHosaLRf0I6j4X1Auyesyc9LQa9sJBSOE8LXn
         RUiDGK+PF23YstAv8BfimoXZsEIdg4UDm84WK7IVAST1dINvmZj5lUuZhI+icMUxnCN3
         llC8msaMa7N6K3+fqtVUNkfrKzgLK/ke2MlOmZXJ7NeX8jcmHGIzHDsVmbC4RZTG01Fb
         /UI3vyzuKTtA3h4txojoGIH1ROGhobBzTpCfydyfrP4FUzrGev3IwU1HEq0bymCwPf0i
         SPL5sF+Jc8u2qU/fwuAnr/TsCOPd6Pn0PhcsFfNsl2fHYJpyOz5rHMvNjnUZwO+TUhRk
         yG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6RVs2stJFURA5obC9tinkDwdWMYjzoWbL6NDUAFkfJc=;
        b=E+YDl+Ux80Ntuo/2TGZaDWSc189mgo0AEhHT1XigTlxLiuElQoFNzwDgP2RmdCYWQa
         oxGe27m6UZsMTU7a38hY1jYIolp8PuR1jxMPt1R0zSpuXiTNpMugtOwNY5I/2MRxHGAq
         /NzhxqoXGDzpwc9voEmAJ5+3IkHyGrc5LtyPguWsZXl+QExCkz+IIVSNio496bulGbhH
         rihKBZs2BdUmpLkSg17RqwT4w7LrMXTMlBQc0sq33HuNujugcu30HOnQIF2NEByOB3x8
         232KnGX+89ADkIAffaOjpgFSPdmX1FDtf1jdWA3yVX0fRKIvM83ZSuyvQnDgwBJE8hPb
         Dr2w==
X-Gm-Message-State: AGi0Pub+SETeoHQTw8R19ntykqXaJa3shADxuRs4zipAuKEWiCWlBjjU
        g0dPmYWMTFGxKglMNP09tnUu6/JHuJgj9XJN+cFdEQ==
X-Google-Smtp-Source: APiQypLAE/dZqg6TS0myimYufru0Tg8JlRJ/jTb/tyV3d5Gxm1RzbIMIW9jjrAJmVkv4Gv29z7oZ5rYJSBMsmcAsEGo=
X-Received: by 2002:a67:ead1:: with SMTP id s17mr2598171vso.200.1587643301378;
 Thu, 23 Apr 2020 05:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200422112719.826676174@infradead.org> <20200422112831.811655681@infradead.org>
 <CAPDyKFo+qCZU=snj==4CFRfL9R0KLcG2RMYeFW_BMX=-Mo5rtg@mail.gmail.com> <20200423085938.GV20713@hirez.programming.kicks-ass.net>
In-Reply-To: <20200423085938.GV20713@hirez.programming.kicks-ass.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Apr 2020 14:01:05 +0200
Message-ID: <CAPDyKFo0AX9EycOdxLKQxMbOUsnLri=OqWi3o991feqc6_Q26g@mail.gmail.com>
Subject: Re: [PATCH 10/23] sched,mmc: Convert to sched_set_fifo*()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>, qais.yousef@arm.com,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Benjamin Segall <bsegall@google.com>, mgorman@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Apr 2020 at 10:59, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Apr 22, 2020 at 06:59:35PM +0200, Ulf Hansson wrote:
> > On Wed, 22 Apr 2020 at 13:29, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > Because SCHED_FIFO is a broken scheduler model (see previous patches)
> > > take away the priority field, the kernel can't possibly make an
> > > informed decision.
> > >
> > > In this case, use fifo_low, because it only cares about being above
> > > SCHED_NORMAL. Effectively no change in behaviour.
> > >
> > > Cc: ulf.hansson@linaro.org
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Reviewed-by: Ingo Molnar <mingo@kernel.org>
> >
> > Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Thanks!
>
> > FYI: I am slowly moving towards removing the entire kthread for the
> > sdio_irq_thread(). It shouldn't be too far off to be posted, one or
> > two kernel releases or so.
>
> Moving over to regular threaded interrupts? Anyway, cool, if these
> series collide it's easy enough to drop this patch on the floor if it
> turns out obsolete.

In principle, the only reason for the kthread is that we need it for
polling - for hosts that don't support SDIO irqs. So, I am thinking of
replacing the kthread with a workqueue, as we already have one for
hosts that are using non-threaded IRQs.

Kind regards
Uffe
