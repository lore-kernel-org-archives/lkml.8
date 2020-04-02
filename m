Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D3CC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 00:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659DC20721
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 00:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0jhSZQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732735AbgDBAHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 20:07:48 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:34722 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732137AbgDBAHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 20:07:48 -0400
Received: by mail-il1-f195.google.com with SMTP id t11so1886377ils.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 17:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N4lUFYhSPSno/B7zHZ88HhgsSs6cCcRd0Ct0S+LW7sA=;
        b=a0jhSZQZpIvwANQUvz/KpGmiptmEPARdT86t9EaS56dP+5s0Tk0cHTy2seWymQet4k
         aRsf8fMNXc9ir9mjC4f34q1x9EUaT8ofr8NyJT6U0W2WsjK9xL3qwZh5qb2TcpBoQFzj
         32r8BjkXGZssAjmze28jBiKIGfFNt93K+4DpS1lWNPJQFSbE5/IXcOt6vTIiM/+Hxbi9
         sAA4YneljKS/tnMw0p3rFhnsiuqYgj0DvyHZJbX/yIg1CUzKxuQ5UH2pAJae7Cs5laSx
         ZJfR8RcNlaHQIh0GTpiTONEaCe1nX2vvfoapd/8X/PfzuA3e2hiy6FyG55UnETrwVeYL
         P5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N4lUFYhSPSno/B7zHZ88HhgsSs6cCcRd0Ct0S+LW7sA=;
        b=dFZnGyPBJyfg0iMpyjCulDfKXt3o1OGvI1hUqi/FCqO8sg8lkNddEBicbFRTNUq42C
         HO0q7TVJBZsUVqwg2cZNNa1mIxnQRS/rYnCTJqEho92dBXpqzFN8vQbo/HH3U9cg6+6a
         Jn7modAqNu3/keOcy8QKjUyXq9/JQosh6S2ZGZzLRKsRVTIyEXlywcG5hxmzVoDs/PFO
         KnxqSFVih8SSAI1MInI1V+jAAKdojVPXlxuhoA64YC8LWcPoXPArdXZzJxFjGMxY9ROG
         CTLlxbSw2oGFhwtdnmZ45NJXEWvWXbnUBhyG8sp3/B0rN0TyLBblX96sUUQz2SqwEyNl
         xPuw==
X-Gm-Message-State: AGi0PuZosEc1xq38CyMLY+IDG2FHe1gtXpvNAMID2NS1sauv+6z9VKcd
        hflOaJffo/7mI1HeJmzgjkvZ3nm9FRO6GGtgo+bIZ9Ij
X-Google-Smtp-Source: APiQypIg4OVOEAKMMANmen+nbk0Yvx8OP/YDpxHQhOU5zmGnNPF40JjEgj6sLEU3X4CKO6BGsvXvklR2EKMAgN5xDFQ=
X-Received: by 2002:a92:3d84:: with SMTP id k4mr617537ilf.47.1585786067160;
 Wed, 01 Apr 2020 17:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200327074308.GY11705@shao2-debian> <20200327175350.rw5gex6cwum3ohnu@linutronix.de>
 <CAJhGHyDmw5Fwq5mgb1h=7GBegQKP2HQnPTxcRps-0PvGbC2PWg@mail.gmail.com>
 <CAJhGHyBS9Z=x-X2Bxzbic2sfqj=STqr+K8Tgu1UfYMQDm6MtBg@mail.gmail.com> <20200401130346.e7cdsqgxppa6ohje@linutronix.de>
In-Reply-To: <20200401130346.e7cdsqgxppa6ohje@linutronix.de>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 2 Apr 2020 08:07:35 +0800
Message-ID: <CAJhGHyBmcY75Rhc7UFyK7Ozho+aqOcX2EaxePhZFu9rt0w3-mA@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Don't double assign worker->sleeping
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, LKP <lkp@lists.01.org>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 9:03 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2020-04-01 11:44:06 [+0800], Lai Jiangshan wrote:
> > On Wed, Apr 1, 2020 at 11:22 AM Lai Jiangshan <jiangshanlai@gmail.com> =
wrote:
> > >
> > > Hello
> Hi Lai,
>
> =E2=80=A6
> > > 2) wq_worker_running() can be interrupted(async-page-faulted in virtu=
al machine)
> > > and nr_running would be decreased twice.
> >
> > would be *increased* twice
> >
> > I just saw the V2 patch, this issue is not listed, but need to be fixed=
 too.
>
> | void wq_worker_running(struct task_struct *task)
> | {
> |         struct worker *worker =3D kthread_data(task);
> |
> |         if (!worker->sleeping)
> |                 return;
> |         if (!(worker->flags & WORKER_NOT_RUNNING))
> |                 atomic_inc(&worker->pool->nr_running);
> *0
> |         worker->sleeping =3D 0;
> *1
> | }
>
> So an interrupt
> - before *0, the preempting caller drop early in wq_worker_sleeping(), on=
ly one
>   atomic_inc()

If it is preempted on *0, the preempting caller drop early in
wq_worker_sleeping()
so there is no atomic decreasing, only one atomic_inc() in the
preempting caller.
The preempted point here, wq_worker_running(), has already just done
atomic_inc(),
the total number of atomic_inc() is two, while the number of atomic decreas=
ing
is one.

>
> - after *1, the preempting task will invoke wq_worker_sleeping() and do
>   dec() + inc().
>
> What did I miss here?
>
> Sebastian
