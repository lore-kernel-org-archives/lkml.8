Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D52C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 11:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EB4920899
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 11:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592481134;
	bh=wTfRxuKc1jwLXftAH31BnUg/H44ZLv/8YpTzgFciB8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HLCLOBMjQd2Vmaih0AIUJUa5wEltwICeeZK9CucHDImiKJ1Wi2r6QGoy8/YDB0pOq
	 HFGEW1kAhcz76h1fD7lEl8n33qBRuk/dDAhCOkYEJzWTRdNsEhsn6s90jYpgwMkRs6
	 RNQqtl917BOYrPqLDl13K+25mjR6Y3orOMnIkM3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgFRLwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 07:52:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728260AbgFRLwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 07:52:12 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4FD720706;
        Thu, 18 Jun 2020 11:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592481131;
        bh=wTfRxuKc1jwLXftAH31BnUg/H44ZLv/8YpTzgFciB8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EenphTcNyB+dKYaoGyJ/fNyX0l+r6YROK2HBb8+nCr3mZ48i1aUZ7yLvXIZJLoCog
         arzhVttP19B2KO0Fmwt9w4Z6Z3MRQ8a+HAJokg4Jxv9xgWQyfdXbj7HkictVvvQeTG
         6F2NDFPA8kyBrvuJ8Q21VRKJA2OM6gw6rzGGPaoU=
Date:   Thu, 18 Jun 2020 12:52:02 +0100
From:   Will Deacon <will@kernel.org>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, arnd@arndb.de,
        borntraeger@de.ibm.com, catalin.marinas@arm.com,
        christian@brauner.io, cyphar@cyphar.com, dhowells@redhat.com,
        ebiederm@xmission.com, fenghua.yu@intel.com, geert@linux-m68k.org,
        gor@linux.ibm.com, ink@jurassic.park.msu.ru, jolsa@redhat.com,
        linux@armlinux.org.uk, lkp@intel.com, mark.rutland@arm.com,
        mattst88@gmail.com, minchan@kernel.org, mingo@redhat.com,
        monstr@monstr.eu, namhyung@kernel.org, peterz@infradead.org,
        rth@twiddle.net, sargun@sargun.me, sfr@canb.auug.org.au,
        tony.luck@intel.com, akpm@linux-foundation.org,
        alex.huangjianhui@huawei.com, zhongjubin@huawei.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] s390: fix build error for sys_call_table_emu
Message-ID: <20200618115201.GA5671@willie-the-truck>
References: <20200618110320.104013-1-nixiaoming@huawei.com>
 <20200618112702.GB4231@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618112702.GB4231@osiris>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 01:27:02PM +0200, Heiko Carstens wrote:
> On Thu, Jun 18, 2020 at 07:03:20PM +0800, Xiaoming Ni wrote:
> > Build error on s390:
> > 	arch/s390/kernel/entry.o: in function `sys_call_table_emu':
> > 	>> (.rodata+0x1288): undefined reference to `__s390_'
> > 
> > In commit ("All arch: remove system call sys_sysctl")
> >  148  common	fdatasync		sys_fdatasync			sys_fdatasync
> > -149  common	_sysctl			sys_sysctl			compat_sys_sysctl
> > +149  common	_sysctl			sys_ni_syscall
> >  150  common	mlock			sys_mlock			sys_mlock
> > 
> > After the patch is integrated, there is a format error in the generated
> > arch/s390/include/generated/asm/syscall_table.h:
> > 	SYSCALL(sys_fdatasync, sys_fdatasync)
> > 	SYSCALL(sys_ni_syscall,) /* cause build error */
> > 	SYSCALL(sys_mlock,sys_mlock)
> > 
> > There are holes in the system call number in
> >  arch/s390/kernel/syscalls/syscall.tbl. When generating syscall_table.h,
> > these hole numbers will be automatically filled with "NI_SYSCALL".
> > Therefore, delete the number 149 to fix the current compilation failure.
> >  Similarly, modify tools/perf/arch/s390/entry/syscalls/syscall.tbl.
> > 
> > Fixes: ("All arch: remove system call sys_sysctl")
> > Fixes: https://lore.kernel.org/linuxppc-dev/20200616030734.87257-1-nixiaoming@huawei.com/
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> > ---
> >  arch/s390/kernel/syscalls/syscall.tbl           | 1 -
> >  tools/perf/arch/s390/entry/syscalls/syscall.tbl | 1 -
> >  2 files changed, 2 deletions(-)
> > 
> > diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> > index f17aaf6fe5de..bcaf93994e3c 100644
> > --- a/arch/s390/kernel/syscalls/syscall.tbl
> > +++ b/arch/s390/kernel/syscalls/syscall.tbl
> > @@ -138,7 +138,6 @@
> >  146  common	writev			sys_writev			compat_sys_writev
> >  147  common	getsid			sys_getsid			sys_getsid
> >  148  common	fdatasync		sys_fdatasync			sys_fdatasync
> > -149  common	_sysctl			sys_ni_syscall
> 
> This is not correct. It should be changed to:
> 
>    149  common	_sysctl			-				-
> 
> Otherwise the generated __NR__sysctl define will be lost from
> unistd.h, which should not happen. Looking at the link above it
> _looks_ like a similar mistake was done for arm64.

I think we're ok on arm64, since it's only the compat syscall table that
is being updated and we don't export compat uapi headers (rather, they
come from arch/arm/).

Will
