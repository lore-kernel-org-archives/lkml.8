Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0D4C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8935206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="obj7tBtr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgBMRPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:15:37 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]:42465 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgBMRPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 12:15:36 -0500
Received: by mail-lj1-f170.google.com with SMTP id d10so7493245ljl.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 09:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ZgnOA2RdYtHkbQdDxZ4YJyDdLwvDtzxs2Sj136XFtk=;
        b=obj7tBtrmvKlOHKhtyTYC09hT6nbkdjmpEN7XYnGuuciKphxb5wkIxq/x7JAWuvnq9
         wRl9dDJQ+RIyfFTd1pXN4zIkwraBNbYiW7Y6X6h8ZZtkBhfTp95iktaVQrvtsHuy66yT
         Nn7kezc+1iYATMKNa2V03UcGN++jZcVYi0onzJERai/ahzUOaHpepbC7mTJkPzQOXvxL
         EL9KZZ75ud6DO9s8+U+8ZOTVvxmM+fXyDXkh+/lg9LgyUqpYd0pSaLIQRnxdb0eXy3lo
         yNb7BpKysQYP5KwCrFAXqbCs9s3GbfCCk+OLQXpbmoUawKXSER39co0gZNhED13sKljt
         rzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ZgnOA2RdYtHkbQdDxZ4YJyDdLwvDtzxs2Sj136XFtk=;
        b=unNw06PKZ8TIqhXKAIYqDhSG3lHDBIvsmtQA1Kw3cPn6pHQSPdENnliZUqdWV6hMPe
         DjZAXuIVlFBsUdyZcsodS0yKiiBXaVnYDkiLV6W3hIagqeuLctJZ5dT9xYSCpnc1dNqU
         xh7fgyGp88ZMzkat2pOclFe61oyuiL6lcLezOMwFQQiiwmrT8A9HMdNC6f9DI5GituWA
         eZ8NnaKCLllxbCD1v/wcPiTvnjq+U1e/mmsJcoQagZF9nwoBAoq0/EWqnPahBsZZTgQF
         GeyBbv4MOHIL6VRs1/DXR1QqjuPxKY02HOffk6qshxtUREyyqWWpbqMivGz14oIz+v/1
         Wshg==
X-Gm-Message-State: APjAAAXckonvkKmEJbb0bXpA2rlZTMAi23GqU/fffg992xReOT9S3rvT
        YXGjuvEXKMEqL5MHIA2iSRWh1ImGEFbWfCwXXVjclQ==
X-Google-Smtp-Source: APXvYqzJ78Hp+J0EQOUH7hmwCA6ls2xSoGkR+p3ZYGSQevYWjXtzfJblxbeqTO0P8uf32WdUMdXjL5e/b1QEEU8BVsQ=
X-Received: by 2002:a2e:96c6:: with SMTP id d6mr11906253ljj.4.1581614134958;
 Thu, 13 Feb 2020 09:15:34 -0800 (PST)
MIME-Version: 1.0
References: <20200212133715.GU3420@suse.de> <20200212194903.GS3466@techsingularity.net>
 <CAKfTPtDA5GamN4A1SnegYwYCk123TqUDE9EHFbHTgKCMR+yqGQ@mail.gmail.com>
 <20200213131658.9600-1-hdanton@sina.com> <20200213134655.GX3466@techsingularity.net>
 <20200213150026.GB6541@lorien.usersys.redhat.com> <20200213151430.GY3466@techsingularity.net>
 <CAKfTPtDjKW45QyXnF7Pu42AP48mNbDWTUttMSoDgDzOO5GSfnA@mail.gmail.com>
 <20200213163437.GZ3466@techsingularity.net> <CAKfTPtD8k-LMaXz_MNmxeW5aXDO4ZZ6j=gwCRTRU89OJ9nUEGw@mail.gmail.com>
 <20200213170220.GA3466@techsingularity.net>
In-Reply-To: <20200213170220.GA3466@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 13 Feb 2020 18:15:23 +0100
Message-ID: <CAKfTPtB7W9x3YmYGH48DW=qnap+ZPq6to0sonovkmc-wAD1sVQ@mail.gmail.com>
Subject: Re: [RFC 2/4] sched/numa: replace runnable_load_avg by load_avg
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2020 at 18:02, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Thu, Feb 13, 2020 at 05:38:31PM +0100, Vincent Guittot wrote:
> > > > Your test doesn't explicitly ensure that the 1 condition is met
> > > >
> > > > That being said, I'm not sure it's really a wrong thing ? I mean
> > > > load_balance will probably try to pull back some tasks on src but as
> > > > long as it is not a task with dst node as preferred node, it should
> > > > not be that harmfull
> > >
> > > My thinking was that if source has as many or more running tasks than
> > > the destination *after* the move that it's not harmful and does not add
> > > work for the load balancer.
> >
> > load_balancer will see an imbalance but fbq_classify_group/queue
> > should be there to prevent from pulling back tasks that are on the
> > preferred node but only other tasks
> >
>
> Yes, exactly. Between fbq_classify and migrate_degrades_locality, I'm
> expecting that the load balancer will only override NUMA balancing when
> there is no better option. When the imbalance check, I want to avoid
> the situation where NUMA balancing moves a task for locality, LB pulls
> it back for balance, NUMA retries the move etc because it's stupid. The
> locality matters but being continually dequeue/enqueue is unhelpful.
>
> While there might be grounds for relaxing the degree an imbalance is
> allowed across SD domains, I am avoiding looking in that direction again
> until the load balancer and NUMA balancer stop overriding each other for
> silly reasons (or the NUMA balancer fighting itself which can happen).

make sense

>
> --
> Mel Gorman
> SUSE Labs
