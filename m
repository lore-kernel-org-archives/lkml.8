Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DBCC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE9BB2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598284485;
	bh=tlhDK74kblmVgmQocqJM+lzR26F0EmsbpcsbtBOo7GU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=W+Oj+QTg5CgOg/qJynUj33JL467EPxMGgqHFQJyI6Dm/PYMBwho50EEW9KlGPXnBK
	 NXm1E12R2hAqFs5tIMOVrmNUo5HIK+/zvMxIz0rfX5g0+VpUF3pVjQQIN87G541Y6f
	 2bmBactif/fwAg7xz0etMA7Pyir+qRKhxoTJ0RR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgHXPyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:54:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgHXPyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:54:31 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 881562071E;
        Mon, 24 Aug 2020 15:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598284470;
        bh=tlhDK74kblmVgmQocqJM+lzR26F0EmsbpcsbtBOo7GU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HkH5jFfh96DQqgd/LjAA1YFjVvnBb9dVSC9uS7doB+zXKALcwbFmo9k4mSrXvmXiq
         8bJ0XY87PnEpPVL4MD3fgon/4RAHnIx8r23aTkoIjixOnqZ2Zuu7kOr0HnPPMiTNOO
         20NMQgy6tK5G3uJ5xabhslhnmZhp/0i8H/61SXNY=
Date:   Tue, 25 Aug 2020 00:54:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: x86/kprobes: kretprobe fails to triggered if kprobe at function
 entry is not optimized (trigger by int3 breakpoint)
Message-Id: <20200825005426.f592075d13be740cb3c9aa77@kernel.org>
In-Reply-To: <8816bdbbc55c4d2397e0b02aad2825d3@trendmicro.com>
References: <8816bdbbc55c4d2397e0b02aad2825d3@trendmicro.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Aug 2020 12:02:58 +0000
"Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com> wrote:

> Greetings!
> 
> Starting from kernel 5.8 (x86_64), kretprobe handler will always missed if corresponding kprobe on function entry is not optimized (using break point instead).

Oops, good catch. I always enabled ftrace hook for kretprobe, I didn't noticed that.

> Step to reproduce this:
> 1) Build the kretprobe example module (CONFIG_SAMPLE_KRETPROBES=m)
> 2) Disable jump optimization (`sysctl debug.kprobes-optimization=0` or register any kprobe.post_handler at same location)
> 3) Insert the kretprobe_example module
> 4) Launch some process to trigger _do_fork
> 5) Remove kretprobe_example module
> 6) dmesg shows that all probing instances are missed
> 
> Example output:
> # sysctl debug.kprobes-optimization=0
> debug.kprobes-optimization = 0
> # insmod samples/kprobes/kretprobe_example.ko
> # ls > /dev/null
> # rmmod kretprobe_example
> # dmesg
> [48555.067295] Planted return probe at _do_fork: 0000000038ae0211
> [48560.229459] kretprobe at 0000000038ae0211 unregistered
> [48560.229460] Missed probing 3 instances of _do_fork
> 
> After bisecting, I found this behavior seems to introduce by this commit: (5.8-rc1)
> 0d00449c7a28a1514595630735df383dec606812 x86: Replace ist_enter() with nmi_enter()
> This make kprobe_int3_handler() effectively running as NMI context, which pre_handler_kretprobe() explicitly checked to prevent recursion.

Thanks for the bisecting! 

> 
> (in_nmi() check appears from v3.17)
> f96f56780ca584930bb3a2769d73fd9a101bcbbe kprobes: Skip kretprobe hit in NMI context to avoid deadlock
> 
> To make kretprobe work again with int3 breakpoint, I think we can replace the in_nmi() check with in_nmi() == (1 << NMI_SHIFT) at kprobe_int3_handler() and skip kretprobe if nested NMI.

Ah, I see. Now int3 is a kind of NMI, so in the handler in_nmi() always returns !0.

> Did a quick test on 5.9-rc2 and it seems to be working.
> I'm not sure if it is the best way to do since it may also require change to other architecture as well, any thought?

Hmm, this behavior is arch-dependent. So I think we need an weak function like this.

@kernel/kprobes.c

bool __weak arch_kprobe_in_nmi(void)
{
	return in_nmi()
}

@arch/x86/kernel/kprobes/core.c

bool arch_kprobe_in_nmi(void)
{
       /*
        * Since the int3 is one of NMI, we have to check in_nmi() is
        * bigger than 1 << NMI_SHIFT instead of !0.
        */
       return in_nmi() > (1 << NMI_SHIFT);
}

And use arch_kprobe_in_nmi() instead of in_nmi() in kprobes.c.

Thanks,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
