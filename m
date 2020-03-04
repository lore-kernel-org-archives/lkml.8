Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB92C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5212421739
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WDIEE+bK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbgCDP03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:26:29 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42367 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbgCDP02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:26:28 -0500
Received: by mail-lj1-f195.google.com with SMTP id q19so2464744ljp.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 07:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F+RhEtXPtmYR/U69zTfewCstn7kMyr6p5puYGeQETdE=;
        b=WDIEE+bKVVDorT0Hdt3zplxv3MgbUY2SU6erAp9OlB9TrpLm9bcErrlDIGtaAY/L/J
         qXJR4sLnpm5M/u6NP6VXkNyYFI7uP7cSHO2Qj9QPLMxR2s49OwHhUIP5HINz7cB1lWSH
         67RSIJZp7/PtFcqNVk4Wr09RPtHjlZq8rE7dPQEU5IYkyicfBbDph9DyUmTMQTeKW4s/
         Tv+s1dVc78VfeDVBDExjbtLwz4y97cA4pgdAmH72d7OA2OSngMgUq8nayKP9fWdaEpTp
         ntUeHnNytUUdjGqJUrWDrENv5g6TqpWSlLRrHdcs5N7MxVwzJ7vN+RcS3R4SCfiG+04t
         m5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F+RhEtXPtmYR/U69zTfewCstn7kMyr6p5puYGeQETdE=;
        b=Z9TRODGXlhiGHRNh4aWhtC8NUyk3L0ymp/cSr6a2gGTm3CpDDsXW1kLHR4JYv78XrH
         mrMsE2ENqVB1CZmEomMT3uV0cTARB/2du7AhEDFsxqNyuRm47TMReziP4X8CBntB0UNZ
         0ZjPtEcOBDveW6S3Q9k4gzkOlQHT0TkRYRMfe+TM3yU4tiL8kBMgt/qHg8sAVL/38KAC
         vxyfZKFy2c7zfUGN9YQ54FaSSLru9BZCKMg4xjuo2yrm/98sA5S+vZFtBGHa3WLP3elS
         /5/TsNsZ3sKkp4jaXyfDY2Af0SrkPgteTlPULFSkdj/QUvBGKo+6ibF4Pyz6RYzWu/Kl
         NrrA==
X-Gm-Message-State: ANhLgQ3I2lbI5zxUY6Woqmvwk3c4zUGJN+KlV6zgbz7OnHi7BBMHG2vS
        eKwu4nIpU9H+nYfWYErmkY2oEY0djfk1KAeH+Wo7pg==
X-Google-Smtp-Source: ADFU+vul88yIimH5BIng1vyHG7r6h/Ce54aYP65phyk/cdxHcyk2OZMYC/phv9bFDAFfzrO9otGk4wTBt/v2zRAC9CI=
X-Received: by 2002:a2e:8090:: with SMTP id i16mr2341545ljg.4.1583335586741;
 Wed, 04 Mar 2020 07:26:26 -0800 (PST)
MIME-Version: 1.0
References: <ace7327f-0fd6-4f36-39ae-a8d7d1c7f06b@de.ibm.com>
 <afacbbd1-3d6b-c537-34e2-5b455e1c2267@de.ibm.com> <CAKfTPtBikHzpHY-NdRJFfOFxx+S3=4Y0aPM5s0jpHs40+9BaGA@mail.gmail.com>
 <b073a50e-4b86-56db-3fbd-6869b2716b34@de.ibm.com> <1a607a98-f12a-77bd-2062-c3e599614331@de.ibm.com>
 <CAKfTPtBZ2X8i6zMgrA1gNJmwoSnyRc76yXmLZEwboJmF-R9QVg@mail.gmail.com>
 <b664f050-72d6-a483-be0a-8504f687f225@de.ibm.com> <20200228163545.GA18662@vingu-book>
 <be45b190-d96c-1893-3ef0-f574eb595256@de.ibm.com> <49a2ebb7-c80b-9e2b-4482-7f9ff938417d@de.ibm.com>
 <ad0f263a-6837-e793-5761-fda3264fd8ad@de.ibm.com> <CAKfTPtCX4padfJm8aLrP9+b5KVgp-ff76=teu7MzMZJBYrc-7w@mail.gmail.com>
In-Reply-To: <CAKfTPtCX4padfJm8aLrP9+b5KVgp-ff76=teu7MzMZJBYrc-7w@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 4 Mar 2020 16:26:15 +0100
Message-ID: <CAKfTPtD9b6o=B6jkbWNjfAw9e1UjT9Z07vxdsVfikEQdeCtfPw@mail.gmail.com>
Subject: Re: 5.6-rc3: WARNING: CPU: 48 PID: 17435 at kernel/sched/fair.c:380 enqueue_task_fair+0x328/0x440
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Mar 2020 at 08:55, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> On Tue, 3 Mar 2020 at 08:37, Christian Borntraeger
> <borntraeger@de.ibm.com> wrote:
> >
> >
> >
[...]
> > >>> ---
> > >>>  kernel/sched/fair.c | 2 +-
> > >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > >>> index 3c8a379c357e..beb773c23e7d 100644
> > >>> --- a/kernel/sched/fair.c
> > >>> +++ b/kernel/sched/fair.c
> > >>> @@ -4035,8 +4035,8 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> > >>>             __enqueue_entity(cfs_rq, se);
> > >>>     se->on_rq = 1;
> > >>>
> > >>> +   list_add_leaf_cfs_rq(cfs_rq);
> > >>>     if (cfs_rq->nr_running == 1) {
> > >>> -           list_add_leaf_cfs_rq(cfs_rq);
> > >>>             check_enqueue_throttle(cfs_rq);
> > >>>     }
> > >>>  }
> > >>
> > >> Now running for 3 hours. I have not seen the issue yet. I can tell tomorrow if this fixes
> > >> the issue.
> > >
> > >
> > > Still running fine. I can tell for sure tomorrow, but I have the impression that this makes the
> > > WARN_ON go away.
> >
> > So I guess this change "fixed" the issue. If you want me to test additional patches, let me know.
>
> Thanks for the test. For now, I don't have any other patch to test. I
> have to look more deeply how the situation happens.
> I will let you know if I have other patch to test

So I haven't been able to figure out how we reach this situation yet.
In the meantime I'm going to make a clean patch with the fix above.

Is it ok if I add a reported -by and a tested-by you ?

>
> >
