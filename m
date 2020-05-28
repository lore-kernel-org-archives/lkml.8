Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90169C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 635A0207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Izd8YsFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390388AbgE1N2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 09:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390344AbgE1N1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:27:15 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF678C05BD1E;
        Thu, 28 May 2020 06:27:15 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id a18so82202ilp.7;
        Thu, 28 May 2020 06:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H100vx4HtZK6A8WC+MIYosS8a3IpEO7hNBhEASfUOGM=;
        b=Izd8YsFoxhrf/1rw5M5WLdUssMEblhPRFZbRnHk6wEbHvn9LJq/RfQAGTtUetmykel
         MOhYZKyvOVJSYLdlLFfShdGrq9SMN2sPFA+GAm1dsyKkYKv6EObC/H7VvAfhZY2PlAmf
         pgPMjrRV5WsPGMxOhLiHG/QWE7pQ/NZ+tXnPv4UZxUo1hVqaXdIw7hgDpagohmhVhCDt
         RtmCk06wnHq/Xvgi3eG+MNPH+e703foRfuxjTbyojVnN++2QrNr1VjuqTJzfjc2l1smX
         90Gv6A2QngX8fqBmhrbZY5csJK5rPjYJ841MdL5opCQBrE3cVNN7oES+1ncGMfSaoPwH
         OAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H100vx4HtZK6A8WC+MIYosS8a3IpEO7hNBhEASfUOGM=;
        b=fMbtfgMkTcJ6KYcd8abR71L/vRuJgpdmPDPRtLx5J/YXX4iY7IkLQnUrDoxcQRM+0F
         cEYvsBrhc3JdtJ4cajddVDmMP4eQi7QjVoFE2oxFNPf0xdF7rH0hD+rqWUomgxB1vdkl
         7NaRqroxxchldU3Z/RM6lh8w0fLXjKSvWAkkO9j1C7yr+EoLJIvJWhY7yDBDNPF1D5NF
         e21X8DPMPAgH94eFZDi39L1ikX7s6VYAssJdRhVz1y8zKLokEztHd/uhvd6m2gp1pLUi
         tkVQAETIKNIovOIbbZuqzMeZpImCaokPUcHmMiTEH03d38wy9cgYOwi2n4mvToCe6qgT
         kLfg==
X-Gm-Message-State: AOAM531eyoAuAthUD5euMj4DylWTixeWLHYG39axqPIYcqyR/fjuIRh8
        KnpVAh8vl7F0aMA1aSjtPgfyL0VN3Ct49q+P0Gk=
X-Google-Smtp-Source: ABdhPJxGPhlnZHmpjVMecMlBqT/wtOYf9Xer8dYZPvRWWvcAX/A325G0HQBL8wQLIvRxLZy8YeldYw6LKMdciO8dO4I=
X-Received: by 2002:a92:c8d1:: with SMTP id c17mr2695246ilq.308.1590672435135;
 Thu, 28 May 2020 06:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200527075715.36849-1-qiang.zhang@windriver.com>
 <284c7851-4e89-a00f-a2e6-aa8e2e1f3fce@web.de> <DM6PR11MB32573F3884A864ECD586235EFF8E0@DM6PR11MB3257.namprd11.prod.outlook.com>
 <DM6PR11MB3257D6E7E93A518392502809FF8E0@DM6PR11MB3257.namprd11.prod.outlook.com>
 <20200528095703.GH30374@kadam> <CAJhGHyD1nV=M=ccycqCMt86GMuZGkO9trbJ=4ti4EzP9kta6iA@mail.gmail.com>
 <20200528122545.GP22511@kadam>
In-Reply-To: <20200528122545.GP22511@kadam>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 28 May 2020 21:27:03 +0800
Message-ID: <CAJhGHyBUkMZ=cV+Qf-5+PMAFqgebbRLc46OZSSUSgoRROpUk2A@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHY1XSB3b3JrcXVldWU6IFJlbW92ZSB1bm5lY2Vzc2FyeQ==?=
        =?UTF-8?B?IGtmcmVlKCkgY2FsbCBpbiByY3VfZnJlZV93cSgp?=
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>,
        Markus Elfring <markus.elfring@web.de>,
        Tejun Heo <tj@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 8:27 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Thu, May 28, 2020 at 08:08:06PM +0800, Lai Jiangshan wrote:
> > On Thu, May 28, 2020 at 5:57 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > >
> > > Guys, the patch is wrong.  The kfree is harmless when this is called
> > > from destroy_workqueue() and required when it's called from
> > > pwq_unbound_release_workfn().  Lai Jiangshan already explained this
> > > already.  Why are we still discussing this?
> > >
> >
> > I'm also confused why they have been debating about the changelog
> > after the patch was queued. My statement was about "the patch is
> > a correct cleanup, but the changelog is totally misleading".
> >
> > destroy_workqueue(percpu_wq) -> rcu_free_wq()
> > or
> > destroy_workqueue(unbound_wq) -> put_pwq() ->
> > pwq_unbound_release_workfn() -> rcu_free_wq()
> >
> > So the patch is correct to me. Only can destroy_workqueue()
> > lead to rcu_free_wq().
>
> It looks like there are lots of paths which call put_pwq() and
> put_pwq_unlocked().
>
>   1168  static void pwq_dec_nr_in_flight(struct pool_workqueue *pwq, int color)
>   1169  {
>   1170          /* uncolored work items don't participate in flushing or nr_active */
>   1171          if (color == WORK_NO_COLOR)
>   1172                  goto out_put;
>   1173
>
> We don't take an extra reference in this function.
>
>   1200  out_put:
>   1201          put_pwq(pwq);
>   1202  }
>
> I don't know this code well, so I will defer to your expertise if you
> say it is correct.

wq owns the ultimate or permanent references to itself by
owning references to wq->numa_pwq_tbl[node], wq->dfl_pwq.
The pwq's references keep the pwq in wq->pwqs.

Only destroy_workqueue() can release these ultimate references
and then (after maybe a period of time) deplete the wq->pwqs
finally and then free itself in rcu callback.

Actually, in short, we don't need the care about the above
detail. The responsibility to free rescuer is on
destroy_workqueue(), and since it does the free early,
it doesn't need to do it again later.

e2dca7adff8f moved the free of rescuer into rcu callback,
and I didn't check all the changes between then and now.
But at least now, the rescuer is not accessed in rcu mananer,
so we don't need to free it in rcu mananer.

>
> >
> > Still, the kfree(NULL) is harmless. But it is cleaner
> > to have the patch. But the changelog is wrong, even after
> > the lengthened debating, and English is not my mother tongue,
> > so I just looked on.
>
> We have tried to tell Markus not to advise people about commit messages
> but he doesn't listen.  He has discouraged some contributors.  :/
>
> regards,
> dan carpenter
