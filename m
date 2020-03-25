Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208B1C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4A32077D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbgCYLW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 07:22:59 -0400
Received: from foss.arm.com ([217.140.110.172]:46878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbgCYLW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 07:22:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A75F31B;
        Wed, 25 Mar 2020 04:22:58 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97A883F71F;
        Wed, 25 Mar 2020 04:22:57 -0700 (PDT)
References: <20200324125533.17447-1-valentin.schneider@arm.com> <jhjmu85sm8b.mognet@arm.com> <4aa814d5-abcd-23b3-323c-5a3503ae3d0a@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com, mgorman@techsingularity.net
Subject: Re: [PATCH] sched/topology: Fix overlapping sched_group build
Message-ID: <jhjlfnosmpv.mognet@arm.com>
In-reply-to: <4aa814d5-abcd-23b3-323c-5a3503ae3d0a@arm.com>
Date:   Wed, 25 Mar 2020 11:22:52 +0000
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Mar 25 2020, Dietmar Eggemann wrote:
>> I somehow missed that this triggers the WARN_ON_ONCE() in
>> init_overlap_sched_group(). Gotta figure out why.
>
> Cool, seems like qemu can emulate this!
>
>
> qemu-system-aarch64 -kernel Image -hda ./qemu-image-aarch64.img -append
> 'root=/dev/vda console=ttyAMA0 loglevel=8 sched_debug' -smp cores=8
> --nographic -m 512 -cpu cortex-a53 -machine virt -numa
> node,cpus=0-1,nodeid=0 -numa node,cpus=2-3,nodeid=1, -numa
> node,cpus=4-5,nodeid=2, -numa node,cpus=6-7,nodeid=3, -numa
> dist,src=0,dst=1,val=12, -numa dist,src=0,dst=2,val=20, -numa
> dist,src=0,dst=3,val=22, -numa dist,src=1,dst=2,val=22, -numa
> dist,src=1,dst=3,val=24, -numa dist,src=2,dst=3,val=12
>
> ...
> [    0.711685]
> [    0.711767]   10 12 20 22
> [    0.711860]   12 10 22 24
> [    0.711917]   20 22 10 12
> [    0.711970]   22 24 12 10
> [    0.712036]
> [    0.718356] CPU0 attaching sched-domain(s):
> [    0.718433]  domain-0: span=0-1 level=MC
> [    0.718646]   groups: 0:{ span=0 cap=1006 }, 1:{ span=1 cap=1015 }
> [    0.718865]   domain-1: span=0-3 level=NUMA
> [    0.718906]    groups: 0:{ span=0-1 cap=2021 }, 2:{ span=2-3 cap=2014 }
> [    0.719044]    domain-2: span=0-5 level=NUMA
> [    0.719082]     groups: 0:{ span=0-3 cap=4035 }, 4:{ span=4-7 cap=3855 }
> [    0.719164] ERROR: groups don't span domain->span
> [    0.719191]     domain-3: span=0-7 level=NUMA
> [    0.719228]      groups: 0:{ span=0-5 mask=0-1 cap=5974 }, 6:{
> span=4-7 mask=6-7 cap=3964 }
> [    0.719961] CPU1 attaching sched-domain(s):
> ...
>

I wasn't aware you could specify the distances directly on the CLI,
that's awesome! Thanks for pointing this out.
