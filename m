Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32FFC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 11:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B7F208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 11:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585655115;
	bh=rC/38ClZ3y2/dVShjeUj2v2u6Z9jOMJyHzY+AlOMuKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jA1CkyGXg6Eg4y4/XADBeeQw1x7Q+Qswr6J3V6qYpZSpEeDFa/z029ghdzyUnXpoX
	 aabSGTBRXD8J6LmNlY+m3PnwBPM+ySag9UaJePPYIhh/bmFG/MK1Mqkp/WbMXeQJWS
	 AuGQrye03PVylzLHjYLMD0Ympzem7Z4OaoFauZ6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbgCaLpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 07:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730424AbgCaLpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 07:45:14 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AE0420848;
        Tue, 31 Mar 2020 11:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585655113;
        bh=rC/38ClZ3y2/dVShjeUj2v2u6Z9jOMJyHzY+AlOMuKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s7+C2KpVO4692yq6aLf4raZ8PL/WkSIxfSpwsjwYJJGJioffmKvzoObEE/wevNE/S
         AK6gRkKBxtzIlVC8yTMyARLbj3aX/Qj3F7F4c8YXO5aHQEr4bvk7IKhDcqZ/GO+0Lh
         HgEJbVzxcahHnLgZjVBNYQOuSCE8XYnqzl9Ku2pI=
Date:   Tue, 31 Mar 2020 12:45:09 +0100
From:   Will Deacon <will@kernel.org>
To:     tingwei@codeaurora.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: hw_breakpoint: don't clear debug registers in
 halt mode
Message-ID: <20200331114502.GA29553@willie-the-truck>
References: <20200328083209.21793-1-tingwei@codeaurora.org>
 <20200330123946.GH1309@C02TD0UTHF1T.local>
 <20200330134218.GB10633@willie-the-truck>
 <2f4d076b2b21de3908f0821126d0c61e@codeaurora.org>
 <20200331074147.GA25612@willie-the-truck>
 <518d9ca9652c23bfc0e1831306144418@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <518d9ca9652c23bfc0e1831306144418@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 07:33:38PM +0800, tingwei@codeaurora.org wrote:
> 在 2020-03-31 15:41，Will Deacon 写道：
> > On Tue, Mar 31, 2020 at 10:39:42AM +0800, tingwei@codeaurora.org wrote:
> > > 在 2020-03-30 21:42，Will Deacon 写道：
> > > > On Mon, Mar 30, 2020 at 01:39:46PM +0100, Mark Rutland wrote:
> > > > > On Sat, Mar 28, 2020 at 04:32:09PM +0800, Tingwei Zhang wrote:
> > > > > > If external debugger sets a breakpoint for one Kernel function
> > > > > > when device is in bootloader mode and loads Kernel, this breakpoint
> > > > > > will be wiped out in hw_breakpoint_reset(). To fix this, check
> > > > > > MDSCR_EL1.HDE in hw_breakpoint_reset(). When MDSCR_EL1.HDE is
> > > > > > 0b1, halting debug is enabled. Don't reset debug registers in this
> > > > case.
> > > > >
> > > > > I don't think this is sufficient, because the kernel can still
> > > > > subsequently mess with breakpoints, and the HW debugger might not be
> > > > > attached at this point in time anyhow.
> > > > >
> > > > > I reckon this should hang off the existing "nodebumon" command line
> > > > > option, and we shouldn't use HW breakpoints at all when that is
> > > > > passed.
> > > > > Then you can pass that to prevent the kernel stomping on the external
> > > > > debugger.
> > > > >
> > > > > Will, thoughts?
> > > >
> > > > I was going to suggest the same thing, although we will also need to
> > > > take
> > > > care to reset the registers if "nodebugmon" is toggled at runtime via
> > > > the
> > > > "debug_enabled" file in debugfs.
> > > >
> > > Thanks for the suggestion, Mark and Will. It's a great idea to use
> > > "nodebugmon". When "nodebugmon" is set, Kernel won't change HW
> > > breakpoints.
> > > 
> > > For reset the registers after "debug_enabled" is toggled, I'm
> > > thinking if
> > > we are adding unnecessary complexity here.If we take that approach, we
> > > will
> > > hook "debug_enabled" interface and use smp_call_function_single() to
> > > call
> > > hw_breakpoint_reset() on each CPU. Wait for all CPUs' execution done
> > > and
> > > change "debug_enabled". External debugger would clear the
> > > breakpoints when
> > > it detaches the device and restores its breakpoints when attaches the
> > > device.
> > > Assume debug_enabled is changed to one after external debugger
> > > detaches
> > > the
> > > device. Debugger would already clear the breakpoint registers. If
> > > debgger
> > > is
> > > still attached, there's nothing Kernel can do to stop it
> > > restores/programs
> > > the breakpoint registers.
> > > 
> > > What do you think of this?
> > 
> > It's all a bit of a mess. Looking at it some more, why can't the
> > external
> > debugger simply trap access to the debug registers using EDSCR.TDA? That
> > way, we don't have to change anything in the kernel.
> > 
> 
> External debugger has the function to trap access to debug registers now.
> What do we expect debugger to do after core is stopped? Skip that msr
> instruction and continue to run?

The nicest thing to do would probably be to record all the accesses made
by the OS so that it can emulate reads and replay writes when external
debugging is over. Given that you'd still be expecting to pass "nodebugmon",
the emulation should be pretty straightforward, I think.

Will
