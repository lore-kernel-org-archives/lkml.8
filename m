Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BC6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 073C823119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgHFQtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:49:02 -0400
Received: from foss.arm.com ([217.140.110.172]:45206 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729099AbgHFQmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:42:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3829131B;
        Thu,  6 Aug 2020 04:25:59 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15FF43F99C;
        Thu,  6 Aug 2020 04:25:51 -0700 (PDT)
Subject: Re: [PATCH v4 00/10] sched: Instrument sched domain flags
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com, Quentin Perret <qperret@google.com>
References: <20200731115502.12954-1-valentin.schneider@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <306502b9-522a-43d9-1209-15675009bf1b@arm.com>
Date:   Thu, 6 Aug 2020 13:25:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200731115502.12954-1-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/2020 13:54, Valentin Schneider wrote:
> Hi,
> 
> I've repeatedly stared at an SD flag and asked myself "how should that be
> set up in the domain hierarchy anyway?". I figured that if we formalize our
> flags zoology a bit, we could also do some runtime assertions on them -
> this is what this series is all about.
> 
> Patches
> =======
> 
> The idea is to associate the flags with metaflags that describes how they
> should be set in a sched domain hierarchy ("if this SD has it, all its {parents,
> children} have it") or how they behave wrt degeneration - details are in the
> comments and commit logs. 
> 
> The good thing is that the debugging bits go away when CONFIG_SCHED_DEBUG isn't
> set. The bad thing is that this replaces SD_* flags definitions with some
> unsavoury macros. This is mainly because I wanted to avoid having to duplicate
> work between declaring the flags and declaring their metaflags.
> 
> o Patches 1-3 are topology cleanups / fixes
> o Patches 4-6 instrument SD flags and add assertions
> o Patches 7-10 leverage the instrumentation to factorize domain degeneration
> 
> Revisions
> =========
> 
> v3 -> v4
> --------
> 
> o Reordered the series to have fixes / cleanups first
> 
> o Added SD_ASYM_CPUCAPACITY propagation (Quentin)
> o Made ARM revert back to the default sched topology (Dietmar)
> o Removed SD_SERIALIZE degeneration special case (Peter)
> 
> o Made SD_NUMA and SD_SERIALIZE have SDF_NEEDS_GROUPS
> 
>   As discussed on v3, I thought this wasn't required, but thinking some more
>   about it there can be cases where that changes the current behaviour. For
>   instance, in the following wacky triangle:
> 
>       0\ 30
>       | \
>   20  |  2
>       | /
>       1/ 30
> 
>   there are two unique distances thus two NUMA topology levels, however the
>   first one for node 2 would have the same span as its child domain and thus
>   should be degenerated. If we don't give SD_NUMA and SD_SERIALIZE
>   SDF_NEEDS_GROUPS, this domain wouldn't be denegerated since its child
>   *doesn't* have either SD_NUMA or SD_SERIALIZE (it's the first NUMA domain),
>   and we'd have this weird NUMA domain lingering with a single group.

LGTM.

Tested on Arm & Arm64 dual-cluster big.LITTLE (so only
default_topology[]) with CONFIG_SCHED_MC=y for the following cases:

(1) normal bring-up
(2) CPU hp all but one CPU of one cluster
(3) CPU hp entire cluster

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
