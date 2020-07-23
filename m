Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEAAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 04:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A1E820768
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 04:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQFBaVc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgGWEs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 00:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgGWEs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 00:48:29 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14387C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 21:48:29 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id s190so865561ooa.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 21:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sUCL94PZfXP1MwR6x13KWCVDB5awWyt94Bx2yEZZxlQ=;
        b=FQFBaVc/XNqmBDVi93JCidz6GXUn1V4SB2tNHx/g3BasbtQ7CY6HhEthIDXNtYiZ50
         L/9zfCtxST0F9zGJ5UBebq7+aNMR0D4cICaj4l2hYk+L3OdqVl0f+6wZIBloHreI0XdT
         nGqLJKQjTSXqZGuyp0RUfxMyDzVS8PblaUX3AnMQu1AMNip9wZORHCCyn3v0lyUeUdF6
         VqDbJmpiwxscxNON4sqE5qTG4prbz81fKGeWs4LqR3NMVrfCpW9FP/r2cbq62CmHURBs
         TF7rJbpq/7E/nrvqIW2W136VVXTCbaUNrT45Np2PWZYd4AsCXe9C+hGCL+F2Z/8J6cat
         6iEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sUCL94PZfXP1MwR6x13KWCVDB5awWyt94Bx2yEZZxlQ=;
        b=BrDLHQkM+soczl1ZfH/GjVT+SqraYoBWHIy4aqDzKl50IGt3HGvZuEiERhRWnCQLZb
         kSRdqQTibHVHvahxmO47hRGZmOBKYtMQ2JPeqEfzn7rF5HQUOw0zFtdPKbFTUOSJsPpE
         Py/0/lwh3t50lqfiQJqEI5f2BaIkiVh/SLPUVkoKgvzNN33+FdC+breO8CYXC1vSIZK0
         V5h9iO6qjhq2/pXPdroEpaghX79z/dZQZzAYLz+SrLPYt0fPDbG1aOeIgPv9iy8nyiJD
         0sVhnD8GsDxELTsrPPY95NmsGxPhqYHFdEcGbDEzmKZjbTwml4McSW8sX5Jqg1BccFxr
         GBZA==
X-Gm-Message-State: AOAM532tAwxjuDb6lmUSv/HXlZ74ic3b4PFQih6UFP+96PcCkrpRLnSZ
        SR02fUmgz1EeR6ArfYEfiaxqhl++9X9bQifq4Y0qkuPi
X-Google-Smtp-Source: ABdhPJyvGOY3Fkbx3RIX0HRNcxgDav6fGsvoZJi//cCymgiQtzWl8V1vZ0bjj4aPsVKPpUYzXeBhGcwXgEM4NEFIYso=
X-Received: by 2002:a4a:d4d9:: with SMTP id r25mr2966102oos.51.1595479708532;
 Wed, 22 Jul 2020 21:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <1595250506-9769-1-git-send-email-qianjun.kernel@gmail.com> <87eep32zod.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87eep32zod.fsf@nanos.tec.linutronix.de>
From:   jun qian <qianjun.kernel@gmail.com>
Date:   Thu, 23 Jul 2020 12:48:17 +0800
Message-ID: <CAKc596LR-=yabCEo_PT0p6Ynr5EWEXc1Fq+CcpPMeo9t3ALV9Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2] Softirq:avoid large sched delay from the pending softirqs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     peterz@infradead.org, will@kernel.org, luto@kernel.org,
        linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 2:05 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> qianjun.kernel@gmail.com writes:
> > +
> > +             end =3D ktime_get();
> > +             delta =3D ktime_to_us(end - start);
>
> What's the point of this conversion? That's a division for no value
> because you can simply define the maximum time in nanoseconds with the
> same effect, i.e.
>
>         ktime_t end =3D ktime_get() + MAX_SOFTIRQ_TIME_NS;
>
>         if (need_resched() && ktime_get() > end)
>                 break;
>
> So you can spare all that start, delta and conversion dance and keep the
> code simple.
>
> Also notice that need_resched() wants to be evaluated first because
> there is no point to do the more expensive time read if need_resched()
> is false.
good suggestion=EF=BC=8CThanks

I will make changes in the next version
>
> Thanks,
>
>         tglx
