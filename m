Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6117FC33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 08:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BA12467E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 08:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMIXpzyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgAOILA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 03:11:00 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20558 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726100AbgAOILA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 03:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579075858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WBfPFMcghtqViN7WRMSLb3P4wkTwFLFnAbzY/LJC8v8=;
        b=iMIXpzyNHiznpBju1tHiv84aqfoaMgbW8bsz7sS79wvXCpyXwL7a2ZYhspZ4bUlkM2vBHD
        94dCIDWAlkUW/bTLljqDBDIrAXDjKmAeuVIt7h7TciySG91ZTjeSpcNvzXb+E3xVZYQgAm
        iI2s5QsgY9QzuY9dAC5eZz2X9rH7dBs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-MdVZ5ncmOqGyAVtSqMQZyQ-1; Wed, 15 Jan 2020 03:10:53 -0500
X-MC-Unique: MdVZ5ncmOqGyAVtSqMQZyQ-1
Received: by mail-wr1-f69.google.com with SMTP id z14so7760605wrs.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 00:10:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WBfPFMcghtqViN7WRMSLb3P4wkTwFLFnAbzY/LJC8v8=;
        b=nI9dZXs7uTtHz3hQaydeCsjvQ3G9ya/wBFrEKaBBiRePsju+5+dxtp4smCA0zz0ZyA
         Tw8mMoJjC/YeCbqEOuD8L6Ryk3NPwSvx5An2Vt/IdahxnS/fXVP0PITVUlWXLwbi/Ptp
         PedBMg0MKpcAoMqkWxW8cEGiFro3yoDCCl2fWHg6/N1bvH4juV/7SL21hA9QXEnFqmXV
         fWCfiVLSfEM9e72sDjCXKuYgXMrOu8gHOr4WMG4HPrS6W2kF9zBZtTc7IEv1L1HLIJQ+
         eYcWL9QsjTyM+xlAu4QHlHnGby1l7SaE3BmUOxNv7OHgODFGVilMAEW8evikDEXZdoZ/
         AVZw==
X-Gm-Message-State: APjAAAVnaF24sIsasf83kFFhy7gS+YhQlpNqXpEknyaDVD/O5xoemwZQ
        UHllS4WA6ebskTTEGk6ZqSKDtZ1Ljl48KL0WO1H447HDyFchrPmD7uW4WorUU7GRCdidV8t6XRC
        x7V2+VCWGw+/Bw39pr4qggYrS
X-Received: by 2002:adf:ec83:: with SMTP id z3mr28665616wrn.133.1579075852276;
        Wed, 15 Jan 2020 00:10:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqz71yYmHKVP3Z5y002vbLM20gaNy6sYcooieTq4xyjwJRncgHZ8JajNxH3RyyJzUjIKW1Q4Mw==
X-Received: by 2002:adf:ec83:: with SMTP id z3mr28665589wrn.133.1579075851865;
        Wed, 15 Jan 2020 00:10:51 -0800 (PST)
Received: from localhost.localdomain ([151.29.30.195])
        by smtp.gmail.com with ESMTPSA id e12sm23495842wrn.56.2020.01.15.00.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 00:10:51 -0800 (PST)
Date:   Wed, 15 Jan 2020 09:10:48 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     stanner@posteo.de
Cc:     linux-kernel@vger.kernel.org, Hagen Pfeifer <hagen@jauu.net>,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de
Subject: Re: SCHED_DEADLINE with CPU affinity
Message-ID: <20200115081048.GA4073@localhost.localdomain>
References: <3000986a52f2c961177c95289df69535@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3000986a52f2c961177c95289df69535@posteo.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/20 10:44, stanner@posteo.de wrote:
> 
> 
> Am 13.01.2020 10:22 schrieb Juri Lelli:
> > Hi,
> > 
> > Sorry for the delay in repling (Xmas + catching-up w/ emails).
> 
> No worries
> 
> > > I fear I have not understood quite well yet why this
> > > "workaround" leads to (presumably) the same results as set_affinity
> > > would. From what I have read, I understand it as follows: For
> > > sched_dead, admission control tries to guarantee that the requested
> > > policy can be executed. To do so, it analyzes the current workload
> > > situation, taking especially the number of cores into account.
> > > 
> > > Now, with a pre-configured set, the kernel knows which tasks will run
> > > on which core, therefore it's able to judge wether a process can be
> > > deadline scheduled or not. But when using the default way, you could
> > > start your processes as SCHED_OTHER, set SCHED_DEADLINE as policy and
> > > later many of them could suddenly call set_affinity, desiring to run
> > > on
> > > the same core, therefore provoking collisions.
> > 
> > But setting affinity would still have to pass admission control, and
> > should fail in the case you are describing (IIUC).
> > 
> > https://elixir.bootlin.com/linux/latest/source/kernel/sched/core.c#L5433
> 
> Well, no, that's not what I meant.
> I understand that the kernel currently rejects the combination of
> set_affinity and
> sched_setattr.
> My question, basically is: Why does it work with exclusive cpu-sets?
> 
> As I wrote above, I assume that the difference is that the kernel knows
> which
> programs will run on which core beforehand and therefore can check the
> rules of admission control, whereas without exclusive cpu_sets it could
> happen
> any time that certain (other) deadline applications decide to switch cores
> manually,
> causing collisions with a deadline task already running on this core.
> 
> You originally wrote that this solution is "currently" required; that's why
> assume that
> in theory the admission control check could also be done dynamically when
> sched_setattr or set_affinity are called (after each other, without
> exclusive cpu sets).
> 
> Have I been clear enough now? Basically I want to know why
> cpusets+sched_deadline
> works whereas set_affinity+sched_deadline is rejected, although both seem to
> lead
> to the same result.

Oh, OK, I think I now got the question (sorry :-).

So, (exclusive) cpusets define "isolated" domains of CPUs among which
DEADLINE tasks can freely migrate following the global EDF rule:

https://elixir.bootlin.com/linux/latest/source/Documentation/scheduler/sched-deadline.rst#L413

Relaxing this constraint and allowing users to define per-task
affinities (via setaffinity) can lead to situations where affinity masks
of different tasks overlap, and this creates problem for the admission
control checks that are currently implemented.

Theory has been developed already that tackles the problem of
overlapping affinities, but that is not yet implemented (it adds
complexity that would have to be supported by strong usecases).

Best,

Juri

