Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94868C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 16:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A77206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 16:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595609694;
	bh=azXTuPtD0wyxhJb8+S80ttgXv1X66U18s0TnoZF41UA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=bR5gxFB3RJPE+1sDFTxckU+Pz6CylsfnIrUyKt0SGRy14hmTwJ7vCXaRBbxbRaSFs
	 cKaUbWz+/1+rlJGY9ETzW176ZIb6PZor61+WxKKW9/VYfUO/HpLCQWr2uEaoHU2sV/
	 9QOWnbd5zIyLVPfrJbL6BavuQCGjDAlawtjwoC9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgGXQyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 12:54:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbgGXQyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 12:54:52 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E05642067D;
        Fri, 24 Jul 2020 16:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595609691;
        bh=azXTuPtD0wyxhJb8+S80ttgXv1X66U18s0TnoZF41UA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zloXNCE9NRhNj/XI9NCCd6p1AAExb8vucsyQl478RGtY28vDzOVkDucgKtkbl8La8
         ibNTj5s/UOlYsUTV0n7bVo5QY7ig4T2uODiZsILUzoTZuQJUHnsEnH+2hrNdH4jtC4
         p92gnj/uPjhZ6Pe74RteAMaWm7x0NS99W8shLD2M=
Date:   Sat, 25 Jul 2020 01:54:45 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 3/3] arm64: implement KPROBES_ON_FTRACE
Message-Id: <20200725015445.d789abc36fcef2d7bd3436dd@kernel.org>
In-Reply-To: <20200724150611.40b17827@xhacker.debian>
References: <20191225172625.69811b3e@xhacker.debian>
        <20191225173001.6c0e3fb2@xhacker.debian>
        <20191226115707.902545688aa90b34e2e550b3@kernel.org>
        <20191226110348.146bb80b@xhacker.debian>
        <20191226121108.0cd1b078@xhacker.debian>
        <20191226182607.06770598a00507090a046951@kernel.org>
        <20200721222455.e99fb8660f69f61ad1bc8942@kernel.org>
        <20200724150611.40b17827@xhacker.debian>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 15:06:11 +0800
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> 
> On Tue, 21 Jul 2020 22:24:55 +0900 Masami Hiramatsu wrote:
> 
> > 
> > 
> > Hi Jisheng,
> 
> Hi,
> 
> > 
> > Would you be still working on this series?
> 
> I will rebase the implementation on the latest code, then try to address
> your comments and Mark's comments. I will send out patches in this weekend.
> 
> > 
> > If you are still want to put a probe on func+4, it is OK if you can
> > completely emulate the 1st instruction. (lr save on the stack and
> > change the regs->sp)
> 
> Will check which is the better solution.

Thanks Jisheng!

What I'm considering is the consistency of pre_handler()@addr and 
post_handler()@addr+4. Also, whether the value of regs (and stacks) is
same as the user expected.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
