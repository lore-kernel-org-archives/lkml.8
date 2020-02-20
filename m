Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E74C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 19:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B79208C4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 19:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aTmzlFn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgBTTXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 14:23:12 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38973 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbgBTTXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 14:23:12 -0500
Received: by mail-ot1-f66.google.com with SMTP id 77so4748578oty.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 11:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bk1eIitMT2MS22kRJrkHf2a6nr5vMQhVA+AkCVP3xms=;
        b=aTmzlFn5tqMffO4aaSdqSmOjwnlwPlhLBMDWmHM5hEgVohGoR95LIESWPin+FgU3m5
         6SBKmIyXfz3mR7ZJGUztrCkEqttjywHypYPY01n74LbVdLtnW3lI3mGg/tCdRKylIrWc
         Jq7asmZQKCD4pm93CxVIrFT9tn3nfGJqSSm8Vsd6HIo/Kcxe7LRKiOXtJ1R+KmDSgYri
         yOJUHQv1/vVwu32bZ3WZIRFgjHFVUSuwrRUtJOBVFSUsAgNS/5PGnC2AW02w3iZZp4zg
         Ia0U7nlOur/8FVS0Sgvy3hruRsr6xz+P5Rcb6cHozsula5vu8Q6sy6WkorjtHYEKafsR
         OD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bk1eIitMT2MS22kRJrkHf2a6nr5vMQhVA+AkCVP3xms=;
        b=l6S/bB9rUqrYHVrQLITv06yeqtRwzn3goLIxwFvYP5HLSmUKEtYhtSdH8cDDs1p3T7
         MHw0ZW05UZfCmUcEgTom3pOcXdMFLlr7HCSaaeGRP2NNqaMiKixwy4jl59VhjHh8csue
         VgZJE+rvEH49qxkc2GFAzPm/ExEc2IlJhIEYB+tGFCkX4+d3EQ8WOD9K5U+EHRyYeyD5
         zFWF7RseOMcx6IOMRdrut2kQti958Z7WeiabNTeXR/Supl0fhK6IZM4IHUSRIcFw+8y9
         W7IQfSNvPmAHk6I4HBBDmZ0jpDA9goitBqR09Ub8OZVl+cEXXEUlVPwqKFEeQ7l5OclB
         CJ2A==
X-Gm-Message-State: APjAAAWl9YVqu7z7R2YRp9ujAdWVxOWszVt5+iHJFPdKfJEz3lJ0laXW
        41hFtsqQsXdjypd5dfh77zFXsbvkvHiPnGkyX0MQHQ==
X-Google-Smtp-Source: APXvYqzc0r7mnwBlUc3tSqHO71Kmj09WeY278uUEiCztDiRqODK1P9Hy8XAqcMq8l4Nh1mPh3JVbkAAfzAHEF3HNj0E=
X-Received: by 2002:a9d:7b4e:: with SMTP id f14mr24990667oto.355.1582226589659;
 Thu, 20 Feb 2020 11:23:09 -0800 (PST)
MIME-Version: 1.0
References: <20200211213128.73302-1-almasrymina@google.com>
 <20200211151906.637d1703e4756066583b89da@linux-foundation.org>
 <CAHS8izPUFQWq3PzhhRzp7u11173_-cmRkNuQWEswS51Xz6ZM0Q@mail.gmail.com> <20200219130648.83e6810848774c6fd649c445@linux-foundation.org>
In-Reply-To: <20200219130648.83e6810848774c6fd649c445@linux-foundation.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 20 Feb 2020 11:22:58 -0800
Message-ID: <CAHS8izN_FJektipBwiLsCO8ysMTM7k=CR_k3OV7+_y0ZbrGw+A@mail.gmail.com>
Subject: Re: [PATCH v12 1/9] hugetlb_cgroup: Add hugetlb_cgroup reservation counter
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, shuah <shuah@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 1:06 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 19 Feb 2020 11:05:41 -0800 Mina Almasry <almasrymina@google.com> wrote:
>
> > On Tue, Feb 11, 2020 at 3:19 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Tue, 11 Feb 2020 13:31:20 -0800 Mina Almasry <almasrymina@google.com> wrote:
> > >
> > > > These counters will track hugetlb reservations rather than hugetlb
> > > > memory faulted in. This patch only adds the counter, following patches
> > > > add the charging and uncharging of the counter.
> > >
> > > We're still pretty thin on review here, but as it's v12 and Mike
> > > appears to be signed up to look at this work, I'll add them to -next to
> > > help move things forward.
> > >
> >
> > Hi Andrew,
> >
> > Since the patches were merged into -next there have been build fixes
> > and test fixes and some review comments. Would you like me to submit
> > *new* patches to address these, or would you like me to squash the
> > fixes into my existing patch series and submit another iteration of
> > the patch series?
>
> What you did worked OK ;)
>
> Please check the end result next time I release a kernel.

Thanks Andrew! Things definitely moved along after the patchseries got
into -next :D

By my count I think all my patches outside of the tests patch have
been acked or reviewed. When you have a chance I have a couple of
questions:

1. For the non-tests patch, anything pending on those preventing
eventual submission to linus's tree?
2. For the tests patch, I only have a Tested-by from Sandipan. Is that
good enough? If the worst comes to worst and I don't get a review on
that patch I would rather (if possible) that 'tests' patch can be
dropped while I nag folks for a review, rather than block submission
of the entire patch series. I ask because it's been out for review for
some time and it's the one I got least discussion on so I'm not sure
I'll have a review by the time it's needed.

Thanks again!
