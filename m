Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7E4C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB892070A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgCWUcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:32:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42787 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgCWUcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:32:07 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jGTjr-0006j7-Sh; Mon, 23 Mar 2020 21:32:00 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 21BCA1040AA; Mon, 23 Mar 2020 21:31:59 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Chris Friesen <chris.friesen@windriver.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Christoph Lameter <cl@linux.com>, Vu Tran <vu.tran@windriver.com>,
        Jim Somerville <Jim.Somerville@windriver.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] affine kernel threads to specified cpumask
In-Reply-To: <af285c22-2a3f-5aa6-3fdb-27fba73389bd@windriver.com>
References: <20200323135414.GA28634@fuller.cnet> <87k13boxcn.fsf@nanos.tec.linutronix.de> <af285c22-2a3f-5aa6-3fdb-27fba73389bd@windriver.com>
Date:   Mon, 23 Mar 2020 21:31:59 +0100
Message-ID: <87imiuq0cg.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris,

Chris Friesen <chris.friesen@windriver.com> writes:
> On 3/23/2020 10:22 AM, Thomas Gleixner wrote:
>> Marcelo Tosatti <mtosatti@redhat.com> writes:
>>> This allows CPU isolation (that is not allowing certain threads
>>> to execute on certain CPUs) without using the isolcpus= parameter,
>>> making it possible to enable load balancing on such CPUs
>>> during runtime.
>> 
>> I'm surely missing some background information, but that sentence does
>> not make any sense to me.
>
> The idea is to affine general kernel threads to specific "housekeeping" 
> CPUs, while still allowing load balancing of tasks.
>
> The isolcpus= boot parameter would prevent kernel threads from running 
> on the isolated CPUs, but it disables load balancing on the isolated CPUs.

So why can't we just have a isolcpus mode which allows that instead of
adding more command line options which are slightly different?

We just added some magic for managed interrupts to isolcpus, which is
surely interesting for your scenario as well...

Thanks,

        tglx

