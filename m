Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BC2C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED5C222C3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="lmwXCF+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgANJoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 04:44:16 -0500
Received: from mout01.posteo.de ([185.67.36.65]:45134 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgANJoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 04:44:15 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id BF25F16006C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 10:44:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1578995052; bh=ZQZSbgw/YGRKUI9Cpp6WEiaoPNlOpSORV4nBp/7wD2M=;
        h=Date:From:To:Cc:Subject:From;
        b=lmwXCF+683QlsdRUz1TNxq65LQyZ/+41R039wIbfsrMaWvNrXpAdhSnijQteskB8r
         9bcm1MK2yyeDLuQf3f28FcgLvSVEez0MRY1VqULG3ce7vbBL1R+cgfT4XzGVyjHKV8
         e1Py7Bb9xaQGA7luWjkkD8a9nfJcNjq5SivDRDOvY/R4TAupMOESqQihN5vTLkDuWH
         h9IHgochJ0GaAvBOZROWhAUPnmb3r2vEv8jmsP9StQszvMIYbpJXhG8UfgaEdKMPHI
         V26rT9TGjDWVXad/2d2cidcNgqHU4pGsT9RixgpMeg9MdSrQQ/5h2TA4TOuLjy/YXR
         iUZdu5k+HfJ5g==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 47xlsP6qlTz6tmG;
        Tue, 14 Jan 2020 10:44:09 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 14 Jan 2020 10:44:09 +0100
From:   stanner@posteo.de
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Hagen Pfeifer <hagen@jauu.net>,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de
Subject: Re: =?UTF-8?Q?SCHED=5FDEADLINE=20with=20CPU=20affinity?=
Message-ID: <3000986a52f2c961177c95289df69535@posteo.de>
X-Sender: stanner@posteo.de
User-Agent: Posteo Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 13.01.2020 10:22 schrieb Juri Lelli:
> Hi,
> 
> Sorry for the delay in repling (Xmas + catching-up w/ emails).

No worries

>> I fear I have not understood quite well yet why this
>> "workaround" leads to (presumably) the same results as set_affinity
>> would. From what I have read, I understand it as follows: For
>> sched_dead, admission control tries to guarantee that the requested
>> policy can be executed. To do so, it analyzes the current workload
>> situation, taking especially the number of cores into account.
>> 
>> Now, with a pre-configured set, the kernel knows which tasks will run
>> on which core, therefore it's able to judge wether a process can be
>> deadline scheduled or not. But when using the default way, you could
>> start your processes as SCHED_OTHER, set SCHED_DEADLINE as policy and
>> later many of them could suddenly call set_affinity, desiring to run 
>> on
>> the same core, therefore provoking collisions.
> 
> But setting affinity would still have to pass admission control, and
> should fail in the case you are describing (IIUC).
> 
> https://elixir.bootlin.com/linux/latest/source/kernel/sched/core.c#L5433

Well, no, that's not what I meant.
I understand that the kernel currently rejects the combination of 
set_affinity and
sched_setattr.
My question, basically is: Why does it work with exclusive cpu-sets?

As I wrote above, I assume that the difference is that the kernel knows 
which
programs will run on which core beforehand and therefore can check the
rules of admission control, whereas without exclusive cpu_sets it could 
happen
any time that certain (other) deadline applications decide to switch 
cores manually,
causing collisions with a deadline task already running on this core.

You originally wrote that this solution is "currently" required; that's 
why assume that
in theory the admission control check could also be done dynamically 
when
sched_setattr or set_affinity are called (after each other, without 
exclusive cpu sets).

Have I been clear enough now? Basically I want to know why 
cpusets+sched_deadline
works whereas set_affinity+sched_deadline is rejected, although both 
seem to lead
to the same result.

P.
