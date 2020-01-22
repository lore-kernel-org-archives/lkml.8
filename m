Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447CDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193612465B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579704469;
	bh=iGhKZwakJs42H/3vv6PL/lPNZYOMCVLzVyr9jWnb1Ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=giENbveBWKFbZrVJe3Ujw/mAPVqh+XsdmaWJlqBWU38Dg69KahPV33yPJANTdinVx
	 sH/tN3cYP7AgpnMtKFJ9T1GQGD6wd1nSPSsSJAC3RPXNRQQmr1bTscc2P0BM+2y9PI
	 ntetBD8cRSiacfCiIWTzuayQUCYJ8fD33Xb0B+8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgAVOrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 09:47:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:33900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgAVOrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 09:47:48 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB3D921835;
        Wed, 22 Jan 2020 14:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579704467;
        bh=iGhKZwakJs42H/3vv6PL/lPNZYOMCVLzVyr9jWnb1Ws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gQ0JHEXzVtt1qhRCk7weZHxDeTz1iI4eishO7/If3CCQJJcwBErXGhMrn5kGcUASH
         0jw9DGc+GKyc6OcKhnHxpQVW28nXOl28Fl7GbJaCuk6jlvcXD1mVkFgyUOlOxCgyBc
         sNJd8qXtB8jihGAArNSchUHslZq1fMViU8NxU3Qc=
Date:   Wed, 22 Jan 2020 14:47:42 +0000
From:   Will Deacon <will@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Zijlstra <peterz@infradead.org>, raphael.gault@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [RFC v5 00/57] objtool: Add support for arm64
Message-ID: <20200122144741.GA16622@willie-the-truck>
References: <20200109160300.26150-1-jthierry@redhat.com>
 <20200112084258.GA44004@ubuntu-x2-xlarge-x86>
 <d5bf34f0-22cc-ba46-41b4-96a52d7acfa4@redhat.com>
 <20200121103101.GE11154@willie-the-truck>
 <CAKwvOd=_PqQWUvd_WZRpEr+T==3w6LpsHKBz3E9ybaQ0javVkw@mail.gmail.com>
 <20200121180632.GA13592@willie-the-truck>
 <20200121183009.253yh6aehvnvxoew@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121183009.253yh6aehvnvxoew@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 12:30:09PM -0600, Josh Poimboeuf wrote:
> On Tue, Jan 21, 2020 at 06:06:34PM +0000, Will Deacon wrote:
> > On Tue, Jan 21, 2020 at 09:08:29AM -0800, Nick Desaulniers wrote:
> > > On Tue, Jan 21, 2020 at 2:31 AM Will Deacon <will@kernel.org> wrote:
> > > >
> > > > On Mon, Jan 13, 2020 at 07:57:48AM +0000, Julien Thierry wrote:
> > > > > On 1/12/20 8:42 AM, Nathan Chancellor wrote:
> > > > > > The 0day bot reported a couple of issues with clang with this series;
> > > > > > the full report is available here (clang reports are only sent to our
> > > > > > mailing lists for manual triage for the time being):
> > > > > >
> > > > > > https://groups.google.com/d/msg/clang-built-linux/MJbl_xPxawg/mWjgDgZgBwAJ
> > > > > >
> > > > >
> > > > > Thanks, I'll have a look at those.
> > > > >
> > > > > > The first obvious issue is that this series appears to depend on a GCC
> > > > > > plugin? I'll be quite honest, objtool and everything it does is rather
> > > > > > over my head but I see this warning during configuration (allyesconfig):
> > > > > >
> > > > > > WARNING: unmet direct dependencies detected for GCC_PLUGIN_SWITCH_TABLES
> > > > > >    Depends on [n]: GCC_PLUGINS [=n] && ARM64 [=y]
> > > > > >      Selected by [y]:
> > > > > >        - ARM64 [=y] && STACK_VALIDATION [=y]
> > > > > >
> > > > > > Followed by the actual error:
> > > > > >
> > > > > > error: unable to load plugin
> > > > > > './scripts/gcc-plugins/arm64_switch_table_detection_plugin.so':
> > > > > > './scripts/gcc-plugins/arm64_switch_table_detection_plugin.so: cannot
> > > > > > open shared object file: No such file or directory'
> > > > > >
> > > > > > If this plugin is absolutely necessary and can't be implemented in
> > > > > > another way so that clang can be used, seems like STACK_VALIDATION
> > > > > > should only be selected on ARM64 when CONFIG_CC_IS_GCC is not zero.
> > > > > >
> > > > >
> > > > > So currently the plugin is necessary for proper validation. One option can
> > > > > be to just let objtool output false positives on files containing jump
> > > > > tables when the plugin cannot be used. But overall I guess it makes more
> > > > > sense to disable stack validation for non-gcc builds, for now.
> > > >
> > > > Alternatively, could we add '-fno-jump-tables' to the KBUILD_CFLAGS if
> > > > STACK_VALIDATION is selected but we're not using GCC? Is that sufficient
> > > > to prevent generation of these things?
> > > 
> > > Surely we wouldn't want to replace jump tables with long chains of
> > > comparisons just because objtool couldn't validate jump tables without
> > > a GCC plugin for aarch64 for some reason, right?  objtool validation
> > > is valuable, but tying runtime performance to a GCC plugin used for
> > > validation seems bad.
> > 
> > I'm only suggesting it if STACK_VALIDATION is selected. It's off by default,
> > and lives in Kconfig.debug. I'd prefer that to "cross your fingers are do
> > nothing differently", which is what the other option seems to be.
> 
> I don't know what the right answer is here, but keep in mind that
> objtool is on by default for x86, so don't be surprised if that
> eventually happens to arch64 too.
> 
> Short term it might be ok to disable jump tables with objtool enabled,
> or to disable objtool when clang is in use, but long term we'll need to
> figure out a better solution.

Oh, absolutely. No objection from me fixing this properly in the long
term. I just don't want to be in a situation where STACK_VALIDATION is
silently ignored in the meantime.

Will
