Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC66CC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 07:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD0320748
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 07:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585640514;
	bh=5iFie0hFJZbTkxQfX1zpVUAdSViyONJlf5tfYCSCM90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pJebWMmmOKpBMS11vyJvQNIsiGbelwjlOe363FbhhRApnRpnxDrCcc+S/m46Vq5Qk
	 MpDy9ay3TXWNFMc+g8wRRD2JeC8wuQoDM42DfCeiDrYJru2ECeCbLHRNLwjAum1Kbp
	 47tDbbMPgLuEfauMYKAiS2fmaKafE3Mwvvsf8/FQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbgCaHlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 03:41:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbgCaHlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 03:41:53 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6109D206DB;
        Tue, 31 Mar 2020 07:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585640512;
        bh=5iFie0hFJZbTkxQfX1zpVUAdSViyONJlf5tfYCSCM90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WpA59XPGa8R71SOKM3cUhV4bJJb6J9lAvZeIUmwwwW1bWXp1YARIYTGnL7YmXDF+d
         LDzhBrS/g+v7WummotEcUhWcRN9ycSGlBv/AXQe5fUH+nj/6AU4bvJUiPKP5jPtIzu
         X5mg8Tvnns1q6E42t+LvvlanLibgc3PoXVRqJpD8=
Date:   Tue, 31 Mar 2020 08:41:47 +0100
From:   Will Deacon <will@kernel.org>
To:     tingwei@codeaurora.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: hw_breakpoint: don't clear debug registers in
 halt mode
Message-ID: <20200331074147.GA25612@willie-the-truck>
References: <20200328083209.21793-1-tingwei@codeaurora.org>
 <20200330123946.GH1309@C02TD0UTHF1T.local>
 <20200330134218.GB10633@willie-the-truck>
 <2f4d076b2b21de3908f0821126d0c61e@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f4d076b2b21de3908f0821126d0c61e@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 10:39:42AM +0800, tingwei@codeaurora.org wrote:
> 在 2020-03-30 21:42，Will Deacon 写道：
> > On Mon, Mar 30, 2020 at 01:39:46PM +0100, Mark Rutland wrote:
> > > On Sat, Mar 28, 2020 at 04:32:09PM +0800, Tingwei Zhang wrote:
> > > > If external debugger sets a breakpoint for one Kernel function
> > > > when device is in bootloader mode and loads Kernel, this breakpoint
> > > > will be wiped out in hw_breakpoint_reset(). To fix this, check
> > > > MDSCR_EL1.HDE in hw_breakpoint_reset(). When MDSCR_EL1.HDE is
> > > > 0b1, halting debug is enabled. Don't reset debug registers in this
> > case.
> > > 
> > > I don't think this is sufficient, because the kernel can still
> > > subsequently mess with breakpoints, and the HW debugger might not be
> > > attached at this point in time anyhow.
> > > 
> > > I reckon this should hang off the existing "nodebumon" command line
> > > option, and we shouldn't use HW breakpoints at all when that is
> > > passed.
> > > Then you can pass that to prevent the kernel stomping on the external
> > > debugger.
> > > 
> > > Will, thoughts?
> > 
> > I was going to suggest the same thing, although we will also need to
> > take
> > care to reset the registers if "nodebugmon" is toggled at runtime via
> > the
> > "debug_enabled" file in debugfs.
> > 
> Thanks for the suggestion, Mark and Will. It's a great idea to use
> "nodebugmon". When "nodebugmon" is set, Kernel won't change HW breakpoints.
> 
> For reset the registers after "debug_enabled" is toggled, I'm thinking if
> we are adding unnecessary complexity here.If we take that approach, we will
> hook "debug_enabled" interface and use smp_call_function_single() to call
> hw_breakpoint_reset() on each CPU. Wait for all CPUs' execution done and
> change "debug_enabled". External debugger would clear the breakpoints when
> it detaches the device and restores its breakpoints when attaches the
> device.
> Assume debug_enabled is changed to one after external debugger detaches the
> device. Debugger would already clear the breakpoint registers. If debgger is
> still attached, there's nothing Kernel can do to stop it restores/programs
> the breakpoint registers.
> 
> What do you think of this?

It's all a bit of a mess. Looking at it some more, why can't the external
debugger simply trap access to the debug registers using EDSCR.TDA? That
way, we don't have to change anything in the kernel.

Will
