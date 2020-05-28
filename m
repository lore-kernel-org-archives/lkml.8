Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3CBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 313032063A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRx/7hQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgE1IgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 04:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgE1IgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 04:36:08 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFB3C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 01:36:08 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id p20so15663026iop.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 01:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uT4eWMkMaTt5Zn1KFtI5xywQUYmU8P3QSNVJGXKzf1g=;
        b=nRx/7hQDbzvh0zE2bELOPZMvmbyrBSSJchv7YXY7hu95TtsV0GImzIozBFVzixn3qq
         9gOFv+hWi1rk/ctIxUw9SFTvh2yQnqnEm2pnia+vvvRJCvmBFWxlBZkpPmsbDLSFSbQq
         3E+KuV3F2n366R2rnaGVuITocKBRjltpjv7o8StM4pZs7eZXp0Ky/EkSM7gxgig/ms18
         Sokd3uVogGgu10zRre1esV6qy3LuFK4JrkJrNIi8XBnXai6KZtx9TekJkzNAeb5vbY7e
         OQ7Og3yx1wcb+W/f/BQUoXgJM9lapSMlZQzXi5qFpv8Z+BloOflub5KkD0jRp9CsKzo1
         nKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uT4eWMkMaTt5Zn1KFtI5xywQUYmU8P3QSNVJGXKzf1g=;
        b=K5iF39HPA2ideey+4BcZjDMu7jjF9xqkTJjj7vj8Xk9wK1JMN6EKTP6Kila2itpbAw
         QVxxhTCt4gKTfwMp+3RlHCZU7LeDmJaKfXTEDa23Uc61lJ0hqsoD2TGoPF4stomU9mgD
         SgM1+YlhJu4wI/JuHwljAYtERFY4ITkABTxaqitRt6gHHn77WoaUBT8cZUGCvCF2W8KB
         /Cy0hSxqQ6sPcD+rphp7Fn4PAbDgAaWsUXsDchbB7Fw4sfEhlj3JYiaafLVy45OPcsU6
         dNnd7PNubXBSDIaZJb0UYq3jqO24whqqSboliYsHZeBNkkL1mp0mdZpsplaYrwYVH1im
         JOMQ==
X-Gm-Message-State: AOAM5305ciVptWg7JVaIrg8c3cp5K4n6s0ePG4HrXoqzozF6ojmxmRuZ
        WjoPNHApcZYysp3+uG31+/BwBkOluLsx+RE5fvI=
X-Google-Smtp-Source: ABdhPJyeFM2Qs4iPQhKzae7gJIe6e+GDWTcI/+u0v4jlKsDGWeXWEzm+1KOPAb8D1V/Gq9eT9KPXWrcEIUvDOTVMOiM=
X-Received: by 2002:a05:6638:dc3:: with SMTP id m3mr1560724jaj.98.1590654967518;
 Thu, 28 May 2020 01:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200527194633.1660952-2-bigeasy@linutronix.de>
 <20200528030657.1690-1-laijs@linux.alibaba.com> <20200528080844.37wgxcy77uu7pmmz@linutronix.de>
In-Reply-To: <20200528080844.37wgxcy77uu7pmmz@linutronix.de>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 28 May 2020 16:35:56 +0800
Message-ID: <CAJhGHyCa=GTb5rXsfO1DrJ8aT4WMrh6r8t9m-PCwDkHapfQG7w@mail.gmail.com>
Subject: Re: [PATCH 1/2] workqueue: pin the pool while it is managing
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 4:08 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2020-05-28 03:06:55 [+0000], Lai Jiangshan wrote:
> > So that put_unbound_pool() can ensure all workers in idle,
> > no unfinished manager. And it doens't need to wait any manager
> > and can go to delete all the idle workers straight away.
> >
> > Also removes manager waitqueue, because it is unneeded and as
> > Sebastian Andrzej Siewior said:
> >
> >   The workqueue code has it's internal spinlock (pool::lock) and also
> >   implicit spinlock usage in the wq_manager waitqueue. These spinlocks
> >   are converted to 'sleeping' spinlocks on a RT-kernel.
> >
> >   Workqueue functions can be invoked from contexts which are truly atom=
ic
> >   even on a PREEMPT_RT enabled kernel. Taking sleeping locks from such
> >   contexts is forbidden.
> >
> >   pool::lock can be converted to a raw spinlock as the lock held times
> >   are short. But the workqueue manager waitqueue is handled inside of
> >   pool::lock held regions which again violates the lock nesting rules
> >   of raw and regular spinlocks.
>
> This seems to work for my test case I had test my chance. And lockdep
> didn't complain so=E2=80=A6
>
> If you prefer this over my 1/2 what do we do about 2/2? Do you want me
> to repost it?

I think we can just wait until Tejun reviews them.

If there is something wrong that I missed in my patch, your patches
are the best choice.

If I need to update my patch, I will repost the 3 patches
(2 of mine, the 2/2 of yours). At least I forgot to add
"Reported-by Sebastian Andrzej Siewior <bigeasy@linutronix.de>"
in the patch.

If Tejun queues my patches right away, you can rebase the 2/2
of yours and repost it.

Lai

>
> Sebastian
