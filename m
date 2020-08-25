Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70584C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E5D520665
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598364206;
	bh=Hi87Dnni+zuNjEdDGPHH1MVoXgRvXXA82mSVAGXzYd8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2o5BhqYJUi3ru3+uWsnz4viCVOnqyrRtaZmSM8uIJ2jkL9/aPKgsRnZkWcfqAWc8p
	 C6IerNd9U9zRPGDLI1MVx/gUJEXzvxrNg0FJ6g2SZ9OixYOFfV1s06nz5AgHzfbah2
	 u2dR0rRMtttePGdCDQrAMyynXILwmsEjz2LzOV0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgHYODY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:03:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbgHYN76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:59:58 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A20D72076C;
        Tue, 25 Aug 2020 13:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598363997;
        bh=Hi87Dnni+zuNjEdDGPHH1MVoXgRvXXA82mSVAGXzYd8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vYUEXt2nYPzRxjb4lktLjiQQEwvXW+aDCR+BoAONSISl4cD4MAp/uWi17RUo23Xxz
         klhbo4mLM1QcV3oOBZUjzBUUUE5GZZj0XJm7Zw8nFveG3IOwIqAoyAQSvUYYCXREjX
         +SQBUjkHLkiIYLQCkmew42r/T2W8ao99HwQrskEc=
Date:   Tue, 25 Aug 2020 22:59:54 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     peterz@infradead.org
Cc:     "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: x86/kprobes: kretprobe fails to triggered if kprobe at function
 entry is not optimized (trigger by int3 breakpoint)
Message-Id: <20200825225954.2202d28b449f2354d5c88070@kernel.org>
In-Reply-To: <20200825133005.GY1362448@hirez.programming.kicks-ass.net>
References: <8816bdbbc55c4d2397e0b02aad2825d3@trendmicro.com>
        <20200825005426.f592075d13be740cb3c9aa77@kernel.org>
        <7396e7b2079644a6aafd9670a111232b@trendmicro.com>
        <20200825151538.f856d701a34f4e0561a64932@kernel.org>
        <20200825120911.GX1362448@hirez.programming.kicks-ass.net>
        <20200825221555.a2d72c9754284feced6a8536@kernel.org>
        <20200825133005.GY1362448@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Aug 2020 15:30:05 +0200
peterz@infradead.org wrote:

> On Tue, Aug 25, 2020 at 10:15:55PM +0900, Masami Hiramatsu wrote:
> 
> > > damn... one last problem is dangling instances.. so close.
> > > We can apparently unregister a kretprobe while there's still active
> > > kretprobe_instance's out referencing it.
> > 
> > Yeah, kretprobe already provided the per-instance data (as far as
> > I know, only systemtap depends on it). We need to provide it for
> > such users.
> > But if we only have one lock, we can avoid checking NMI because
> > we can check the recursion with trylock. It is needed only if the
> > kretprobe uses per-instance data. Or we can just pass a dummy
> > instance on the stack.
> 
> I think it is true in general, you can unregister a rp while tasks are
> preempted.

Would you mean the kretprobe handler (or trampoline handler) will be
preempted? All kprobes (including kretprobe) handler is running in
non-preemptive state, so it shouldn't happen...

> 
> Anyway,. I think I have a solution, just need to talk to paulmck for a
> bit.

Ah, you mentioned that the removing the kfree() from the trampline
handler? I think we can make an rcu callback which will kfree() the
given instances. (If it works in NMI)

> 
> > > Ignoring that issue for the moment, the below seems to actually work.
> > 
> > OK, this looks good to me too.
> > I'll make a series to rewrite kretprobe based on this patch, OK?
> 
> Please, I'll send the fix along when I have it.

OK, I'm planning to (1) add a generic trampoline code (2) cleanup per-arch
trampoline to use generic one, (3) rewrite the generic trampoline to use
lockless code. Then it will not break anything.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
