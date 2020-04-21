Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD77C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5783E2098B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587453052;
	bh=hsizFFgivkzOViOLBSilwEvs359qWyHCxMIKdaeooMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ABXIlrotdDYrfptYzxbtjWe3O8mudA9DNdFBgluU0Xtxp5zce7ng1fBRsdF6ty+rf
	 PV5jZtoQuTd724gEBZ56X3ZZKA4194ZiEtFbZdxFMC7Lwc+2oE+qDBBmMLwgZOuVzL
	 eNR6jlGww06NMs2i4yQBNY49A90Cml/FqUIYTZBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgDUHKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 03:10:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgDUHKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 03:10:50 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF59B2087E;
        Tue, 21 Apr 2020 07:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587453049;
        bh=hsizFFgivkzOViOLBSilwEvs359qWyHCxMIKdaeooMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q3P88V8Q8zehk0TI8EWqhabS+NsHwdzffavu38u+KSLSabvfM7D6VEK9+iIFyOrf7
         jiWBNCUpGXRNYuXEPzQoOLXUa7hxKKwrlbDCErMb7IklITrKZzu+HJOlYhNHnYJc+R
         BeaQ1L5Thq/CKMlGewDj0ZhX23vSHBDL79SNeYto=
Date:   Tue, 21 Apr 2020 08:10:45 +0100
From:   Will Deacon <will@kernel.org>
To:     tingwei@codeaurora.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: hw_breakpoint: don't clear debug registers in
 halt mode
Message-ID: <20200421071043.GA14844@willie-the-truck>
References: <20200328083209.21793-1-tingwei@codeaurora.org>
 <20200330123946.GH1309@C02TD0UTHF1T.local>
 <20200330134218.GB10633@willie-the-truck>
 <2f4d076b2b21de3908f0821126d0c61e@codeaurora.org>
 <20200331074147.GA25612@willie-the-truck>
 <518d9ca9652c23bfc0e1831306144418@codeaurora.org>
 <20200331114502.GA29553@willie-the-truck>
 <20b8c92a16db07978dfcb8cdf3b0e185@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20b8c92a16db07978dfcb8cdf3b0e185@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 11:49:11AM +0800, tingwei@codeaurora.org wrote:
> 在 2020-03-31 19:45，Will Deacon 写道：
> > On Tue, Mar 31, 2020 at 07:33:38PM +0800, tingwei@codeaurora.org wrote:
> > > 在 2020-03-31 15:41，Will Deacon 写道：
> > > > On Tue, Mar 31, 2020 at 10:39:42AM +0800, tingwei@codeaurora.org wrote:
> > > > > For reset the registers after "debug_enabled" is toggled, I'm
> > > > > thinking if
> > > > > we are adding unnecessary complexity here.If we take that approach, we
> > > > > will
> > > > > hook "debug_enabled" interface and use smp_call_function_single() to
> > > > > call
> > > > > hw_breakpoint_reset() on each CPU. Wait for all CPUs' execution done
> > > > > and
> > > > > change "debug_enabled". External debugger would clear the
> > > > > breakpoints when
> > > > > it detaches the device and restores its breakpoints when attaches the
> > > > > device.
> > > > > Assume debug_enabled is changed to one after external debugger
> > > > > detaches
> > > > > the
> > > > > device. Debugger would already clear the breakpoint registers. If
> > > > > debgger
> > > > > is
> > > > > still attached, there's nothing Kernel can do to stop it
> > > > > restores/programs
> > > > > the breakpoint registers.
> > > > >
> > > > > What do you think of this?
> > > >
> > > > It's all a bit of a mess. Looking at it some more, why can't the
> > > > external
> > > > debugger simply trap access to the debug registers using EDSCR.TDA? That
> > > > way, we don't have to change anything in the kernel.
> > > >
> > > 
> > > External debugger has the function to trap access to debug registers
> > > now.
> > > What do we expect debugger to do after core is stopped? Skip that msr
> > > instruction and continue to run?
> > 
> > The nicest thing to do would probably be to record all the accesses made
> > by the OS so that it can emulate reads and replay writes when external
> > debugging is over. Given that you'd still be expecting to pass
> > "nodebugmon",
> > the emulation should be pretty straightforward, I think.
> > 
> 
> To provide an update on this, I've worked with external debugger vendor on
> this.
> Now external debugger can trap the write to debug registers and ignore the
> write.
> This is the first step.

Thanks for the update! Please let us know if you run into any unforeseen
problems.

Will
