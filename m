Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C25C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E34220838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598436047;
	bh=4R1A9/PN9wVaIdSe/0IN1S+Pj6t3/4kfuPgweaMW0sA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=m8/Rp5c1XppxKM/EhjWGV5REbj0fn0Ep++Nnl0YTiXUegKCA7Dc/XT7fLeHvew+89
	 AeI/rz2ggUgHtZgJvmFcOQWrDPRCuyIOqkn8BBjClekUzMO+qp1UrCoF/ceKUhHMOg
	 mA8dqKQsSET7sFrWtZglWXSCCva6jhndkt0UEs+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgHZKAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 06:00:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728086AbgHZKAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:00:45 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0F0D20786;
        Wed, 26 Aug 2020 10:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598436045;
        bh=4R1A9/PN9wVaIdSe/0IN1S+Pj6t3/4kfuPgweaMW0sA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D42ocn71NjTNqMYdwTl34QJmoFLOQjaz+HOhfo1ZizZtNWyG6DHLofD9PJDYGNMPj
         OZBkYB1UgUbfj3Xcs9jik27c1CObXewe84FfvoG9x1EYE/IOssasEfZvXWCS1CJwyz
         35FtUfcaYo3aDqLXL7ssRmJCUa4d9fL3k+3VDUbo=
Date:   Wed, 26 Aug 2020 19:00:41 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: x86/kprobes: kretprobe fails to triggered if kprobe at function
 entry is not optimized (trigger by int3 breakpoint)
Message-Id: <20200826190041.2d0ff0fbe154ba62163b0c00@kernel.org>
In-Reply-To: <20200826180645.9b609fc05df2a149564df1b8@kernel.org>
References: <8816bdbbc55c4d2397e0b02aad2825d3@trendmicro.com>
        <20200825005426.f592075d13be740cb3c9aa77@kernel.org>
        <7396e7b2079644a6aafd9670a111232b@trendmicro.com>
        <20200825151538.f856d701a34f4e0561a64932@kernel.org>
        <20200825120911.GX1362448@hirez.programming.kicks-ass.net>
        <d3027772a6834f89a1ddc07c0fefaa0a@trendmicro.com>
        <20200826172239.ff175be78ee5f3a4380579c3@kernel.org>
        <20200826180645.9b609fc05df2a149564df1b8@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020 18:06:45 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Wed, 26 Aug 2020 17:22:39 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Wed, 26 Aug 2020 07:07:09 +0000
> > "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com> wrote:
> > 
> > > 
> > > > -----Original Message-----
> > > > From: peterz@infradead.org <peterz@infradead.org>
> > > > Sent: Tuesday, August 25, 2020 8:09 PM
> > > > To: Masami Hiramatsu <mhiramat@kernel.org>
> > > > Cc: Eddy Wu (RD-TW) <Eddy_Wu@trendmicro.com>; linux-kernel@vger.kernel.org; x86@kernel.org; David S. Miller
> > > > <davem@davemloft.net>
> > > > Subject: Re: x86/kprobes: kretprobe fails to triggered if kprobe at function entry is not optimized (trigger by int3 breakpoint)
> > > >
> > > > Surely we can do a lockless list for this. We have llist_add() and
> > > > llist_del_first() to make a lockless LIFO/stack.
> > > >
> > > 
> > > llist operations require atomic cmpxchg, for some arch doesn't have CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG, in_nmi() check might still needed.
> > > (HAVE_KRETPROBES && !CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG): arc, arm, csky, mips
> > 
> > Good catch. In those cases, we can add in_nmi() check at arch dependent code.
> 
> Oops, in_nmi() check is needed in pre_kretprobe_handler() which has no
> arch dependent code. Hmm, so we still need an weak function to check it...

Oops, again. Sorry I found a big misunderstand. I found the in_nmi() check is
completely unnecessary with Jiri's commit 9b38cc704e84 ("kretprobe: Prevent 
triggering kretprobe from within kprobe_flush_task").

This commit introduced the kprobe_busy_begin/end() to the kretproeb trampoline
handler, which set a dummy kprobe to the per-cpu current kprobe pointer.
This current-kprobe is checked at the kprobe pre handler to prevent kprobes
(including kretprobe) recursion.

This means, if an NMI interrupts a kretprobe operation (both pre-handler and
trampoline-handler) and it hits the same kretprobe, this nested kretprobe
handlers never be called, because there is a current kprobe is already set.
Thus, we are totally safe from double-lock issue in the kretprobe handlers.

So we can just remove the in_nmi() check from pre_kretprobe_handler() if
we introduced a generic trampoline handler, since kprobe_busy_begin/end()
must called from the trampoline handlers. Currently it is used on x86 only.

Of course, this doesn't solve the llist_del_first() contention in the
pre_kretprobe_handler(). So anyway we need a lock for per-probe llist
(if I understand llist.h comment correctly.)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
