Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861CDC11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FDF2465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tyFafhAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgBTKJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 05:09:19 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32885 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgBTKJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 05:09:18 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so1713866pgk.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 02:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6Cs2yKf1Mj6L8mC6FxbiRVQOnPOuCFoW1oNMmgN/AK4=;
        b=tyFafhAvy5PRkRfV5T11BWejdwAb7oinJiVslkWHS0MmDK6tKVcrklv3xAA1Oo6ZBt
         CdOgs/eb+oZYzaL5odSTg5y47Jcsl3AlF8l8FhOn6b7dYbjr7ByfKgxWnkARxZhjyN1O
         A8P6hcDkB4RH01ZbFO+ywdjyz1fEYyEANWtupxg/3HQHTaYt/wRjET7KHNgjPgmycrfV
         OdfP3lOK/XqAbSxqgYODKQJettzLsin7eHjPReDp9zxtuUvvcvhEhLzLhJlMTgJbsKkR
         TXZvSImybVHF0XZ5ci20CUFG/0JTLnCCmV6eQaeDNqufQnWhbx/9u1ulO8hFMy7Bo/9C
         9Xqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6Cs2yKf1Mj6L8mC6FxbiRVQOnPOuCFoW1oNMmgN/AK4=;
        b=Zo/EQUs8UujxWa/TZOlCPpS8fN7hkaIenXcA6Ivztg89geNV6CKuqmOwTcekHVe0yE
         WCq5lR4spzc13ORI8g+2SHG2J5Pw49gsgprqFTPNLL1ehGfTCRoNIfPgA/4pJPiPpyTj
         ASapYs3P2952mFvydp7fxwCjMW9AqwMfiZ02+v8s575wbmYEzhXA/gbKM3m8KxC/OoTL
         sxvrNazlSXFlDEdkcNpZZLakWhmpN0We5iJyprS2AvWNgv+S7N9hyTtxROYS1GVlwcsU
         Euc/OZyX1OAwRy3uOG+9+W2hNEBLslkN9UF391oE8oiKmLXUv0HY5kaoBIxeP1F8i4P+
         h+CA==
X-Gm-Message-State: APjAAAVikyFb75sJegcl8fkzX0/GhVUr2K5NcUmydXeWbHbCjSXPnHlD
        EqRhq1BbInR4+e1wiK4Lr3k=
X-Google-Smtp-Source: APXvYqw1RK1VOyfBQNPgyhQsItWzyQsVbOC6cRR4fej6gaqdfEqXif09tWFW5VikNFhdqBGvvaPByQ==
X-Received: by 2002:aa7:9816:: with SMTP id e22mr32015789pfl.229.1582193358143;
        Thu, 20 Feb 2020 02:09:18 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id g16sm3205852pgb.54.2020.02.20.02.09.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 20 Feb 2020 02:09:17 -0800 (PST)
Date:   Thu, 20 Feb 2020 18:09:15 +0800
From:   chenqiwu <qiwuchen55@gmail.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH] sched/fair: add !se->on_rq check before dequeue entity
Message-ID: <20200220100915.GA14721@cqw-OptiPlex-7050>
References: <1582183784-13502-1-git-send-email-qiwuchen55@gmail.com>
 <CAKfTPtDzb9XD5wrMhcvGn+dz27nh58taDrdp36YHKNusp739Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDzb9XD5wrMhcvGn+dz27nh58taDrdp36YHKNusp739Og@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 10:38:02AM +0100, Vincent Guittot wrote:
> On Thu, 20 Feb 2020 at 08:29, <qiwuchen55@gmail.com> wrote:
> >
> > From: chenqiwu <chenqiwu@xiaomi.com>
> >
> > We igonre checking for !se->on_rq condition before dequeue one
> > entity from cfs rq. It must be required in case the entity has
> > been dequeued.
> 
> Do you have a use case that triggers this situation ?
> 
> This is the only way to reach this situation seems to be dequeuing a
> task on a throttled cfs_rq
>
Sorry, I have no use case triggers this situation. It's just found by
reading code.
I agree the situation you mentioned above may have a racy with
dequeue_task_fair() in the following code path:
__schedule
	pick_next_task_fair
		put_prev_entity
			check_cfs_rq_runtime
				throttle_cfs_rq
					dequeue_entity

So this check is worth to be added for dequeue_task_fair().
