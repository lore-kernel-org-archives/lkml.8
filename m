Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB8FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69B4F21532
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592594854;
	bh=rXkm2yZFs8wKNU/+Cn6r1srxIA98fiRUp/CywARoGo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q2ksQqlTCkkyRTGSSFvLIe+KxljKXT5oVcWemnzjrMaGEu0Z3IVstZz1v4egZIKOM
	 xqRjLLI9OHQfSX5zbWJXhptGG/m4sZjIY5PSuECb6s8R7aA+P6pdNRX9/fFFT1Z9rn
	 Zb51Wp0Xw//0v9Gfrf0VuOQEl64nAnWTSjVsm3UI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388407AbgFST1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:27:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388345AbgFST1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:27:32 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C02FD21531;
        Fri, 19 Jun 2020 19:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592594852;
        bh=rXkm2yZFs8wKNU/+Cn6r1srxIA98fiRUp/CywARoGo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iPITOYSnR+qcpPVoMeBIx4vf1JMjRJjq+3vD6az1YTTlV5W5zzvHfjkTqndezCOOF
         2dcwSPCk5E128kkAgjGKshlX3geLNdS9/fvHI3g8gkpF1rvPDlhY+9FNGKDaLQMsh0
         DeGXEznxg9tVzygsMT9OBAYG41pinu0jBVSpnluQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D7352405FF; Fri, 19 Jun 2020 16:27:29 -0300 (-03)
Date:   Fri, 19 Jun 2020 16:27:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>,
        alexander.shishkin@linux.intel.com, arnd@arndb.de,
        borntraeger@de.ibm.com, catalin.marinas@arm.com,
        christian@brauner.io, cyphar@cyphar.com, dhowells@redhat.com,
        ebiederm@xmission.com, fenghua.yu@intel.com, geert@linux-m68k.org,
        gor@linux.ibm.com, ink@jurassic.park.msu.ru, jolsa@redhat.com,
        linux@armlinux.org.uk, lkp@intel.com, mark.rutland@arm.com,
        mattst88@gmail.com, minchan@kernel.org, mingo@redhat.com,
        monstr@monstr.eu, namhyung@kernel.org, peterz@infradead.org,
        rth@twiddle.net, sargun@sargun.me, sfr@canb.auug.org.au,
        tony.luck@intel.com, will@kernel.org, akpm@linux-foundation.org,
        alex.huangjianhui@huawei.com, zhongjubin@huawei.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] s390: fix build error for sys_call_table_emu
Message-ID: <20200619192729.GA29309@kernel.org>
References: <20200618141426.16884-1-nixiaoming@huawei.com>
 <20200619141717.GB9971@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619141717.GB9971@osiris>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 19, 2020 at 04:17:17PM +0200, Heiko Carstens escreveu:
> On Thu, Jun 18, 2020 at 10:14:26PM +0800, Xiaoming Ni wrote:
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
> > According to the guidance of Heiko Carstens, use "-" to fill the empty system call
> >  Similarly, modify tools/perf/arch/s390/entry/syscalls/syscall.tbl.
> > 
> > Fixes: ("All arch: remove system call sys_sysctl")
> > Fixes: https://lore.kernel.org/linuxppc-dev/20200616030734.87257-1-nixiaoming@huawei.com/
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> > 
> > changes in v2:
> > 	use "-" to fill the empty system call
> > 
> > v1: https://lore.kernel.org/lkml/20200618110320.104013-1-nixiaoming@huawei.com/
> > ---
> >  arch/s390/kernel/syscalls/syscall.tbl           | 2 +-
> >  tools/perf/arch/s390/entry/syscalls/syscall.tbl | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

I get just copies of that file when it gets out of sync, so I suppose
the patch should be just for arch/s390/kernel/syscalls/syscall.tbl and
processed by the s/390 maintainer?

- Arnaldo
