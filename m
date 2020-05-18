Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35681C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 117FB206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgERHGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 03:06:19 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:15995 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726676AbgERHGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 03:06:17 -0400
Subject: Re: [PATCH] mm, compaction: Indicate when compaction is manually
 triggered by sysctl
To:     Guilherme Piccoli <gpiccoli@canonical.com>,
        David Rientjes <rientjes@google.com>
CC:     "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Gavin Guo <gavin.guo@canonical.com>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20200507215946.22589-1-gpiccoli@canonical.com>
 <20200507160438.ed336a1e00c23c6863d75ae5@linux-foundation.org>
 <CALJn8nNDqWwanhmutCiP-WBLN1eSg2URrG2j5R4kzgHTYObs7Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2005081129100.236131@chino.kir.corp.google.com>
 <CAHD1Q_wF6Mzf5JipXGZKvn2YDR+FQ6ePuKOe-1W-t_VapxMCxg@mail.gmail.com>
 <alpine.DEB.2.22.394.2005101821160.172131@chino.kir.corp.google.com>
 <CAHD1Q_zrQmUTRpdW3bZ0CRKuu2dKgueXUjqCNtC5oyZ67CGp2A@mail.gmail.com>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <6bf5e178-f2c8-f453-9035-93e31995bb53@sony.com>
Date:   Mon, 18 May 2020 09:06:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHD1Q_zrQmUTRpdW3bZ0CRKuu2dKgueXUjqCNtC5oyZ67CGp2A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Nc2YKFL4 c=1 sm=1 tr=0 a=kIrCkORFHx6JeP9rmF/Kww==:117 a=IkcTkHD0fZMA:10 a=sTwFKg_x9MkA:10 a=1XWaLZrsAAAA:8 a=-k7fE2aBq4CcJps1nlAA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/20 1:26 PM, Guilherme Piccoli wrote:
> On Sun, May 10, 2020 at 10:25 PM David Rientjes <rientjes@google.com> wrote:
>> [...]
>> The kernel log is not preferred for this (or drop_caches, really) because
>> the amount of info can causing important information to be lost.  We don't
>> really gain anything by printing that someone manually triggered
>> compaction; they could just write to the kernel log themselves if they
>> really wanted to.  The reverse is not true: we can't suppress your kernel
>> message with this patch.
>>
>> Instead, a statsfs-like approach could be used to indicate when this has
>> happened and there is no chance of losing events because it got scrolled
>> off the kernel log.  It has the added benefit of not requiring the entire
>> log to be parsed for such events.
> OK, agreed! Let's forget the kernel log. So, do you think the way to
> go is the statsfs, not a zoneinfo stat, a per-node thing? I'm saying
> that because kernel mm subsystem statistics seem pretty.."comfortable"
> the way they are, in files like vmstat, zoneinfo, etc. Let me know
> your thoughts on this, if I could work on that or should wait statsfs.
> Thanks,
>
>
> Guilherme

I think a trace notification in compaction like kcompad_wake would be good.

