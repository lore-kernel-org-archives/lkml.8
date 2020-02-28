Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C526EC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 21:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4975246AE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 21:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgB1VZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 16:25:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38225 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgB1VZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 16:25:32 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j7n86-0006fe-Ci; Fri, 28 Feb 2020 22:25:06 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 77AB0100EA1; Fri, 28 Feb 2020 22:25:05 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        krisman@collabora.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, rostedt@goodmis.org,
        ryao@gentoo.org, dvhart@infradead.org, mingo@redhat.com,
        z.figura12@gmail.com, steven@valvesoftware.com,
        pgriffais@valvesoftware.com, steven@liquorix.net,
        malteskarupke@web.de
Subject: Re: [PATCH v3 1/4] futex: Implement mechanism to wait on any of several futexes
In-Reply-To: <20200228194958.GO14946@hirez.programming.kicks-ass.net>
References: <20200213214525.183689-1-andrealmeid@collabora.com> <20200213214525.183689-2-andrealmeid@collabora.com> <20200228190717.GM18400@hirez.programming.kicks-ass.net> <20200228194958.GO14946@hirez.programming.kicks-ass.net>
Date:   Fri, 28 Feb 2020 22:25:05 +0100
Message-ID: <87tv3aflqm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
> On Fri, Feb 28, 2020 at 08:07:17PM +0100, Peter Zijlstra wrote:
>> So I have a problem with this vector layout, it doesn't allow for
>> per-futex flags, and esp. with that multi-size futex support that
>> becomes important, but also with the already extand private/shared and
>> wait_bitset flags this means you cannot have a vector with mixed wait
>> types.
>
> Alternatively, we throw the entire single-syscall futex interface under
> the bus and design a bunch of new syscalls that are natively vectored or
> something.
>
> Thomas mentioned something like that, the problem is, ofcourse, that we
> then want to fix a whole bunch of historical ills, and the probmem
> becomes much bigger.

We keep piling features on top of an interface and mechanism which is
fragile as hell and horrible to maintain. Adding vectoring, multi size
and whatever is not making it any better.

There is also the long standing issue with NUMA, which we can't address
with the current pile at all.

So I'm really advocating that all involved parties sit down ASAP and
hash out a new and less convoluted mechanism where all the magic new
features can be addressed in a sane way so that the 'F' in Futex really
only means Fast and not some other word starting with 'F'.

Thanks,

        tglx
