Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC7FC352A3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 00:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEC82187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 00:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581641157;
	bh=hQaIhNS8DFoALBzdyvbQhF+6CkLsosAbH7kEQqZoSx0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=nDT9EYJWkDtbIjz+t+jnoCCS/dxECRR8TCldGoH0hQGTNONjmNJSszz8HUaYrLkjZ
	 DAiYjdpKdA3nxUOaO5jS7Uhf81bfuErxk95heK9E4AG9fjcAXkUG/VEimA01GZ6053
	 sfFIXMRfTaGZmLVLDeuM6p12Voa5w4m8WFUJ3a2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgBNAp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 19:45:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:39538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727595AbgBNAp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 19:45:56 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20CAB2187F;
        Fri, 14 Feb 2020 00:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581641155;
        bh=hQaIhNS8DFoALBzdyvbQhF+6CkLsosAbH7kEQqZoSx0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WCUlWSng5jqGrPcJgAFevUz+lLuQDN7SY4909ywjshwaD80RdkTvzJ+e72Z4wwc6m
         ryZVm8pWRRpoLTtveM+irxGM5k+x4x/VTqGrarxR3tIXT/EIa4qUBIWdoKMJetxuVo
         NVC5Nsv/GroRBTcRXkWf0TBnmUkIwYkpT7PUpXfU=
Date:   Fri, 14 Feb 2020 09:45:50 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH v3] perf test: Fix test trace+probe_vfs_getname.sh
Message-Id: <20200214094550.228422235c7785519c7f24cc@kernel.org>
In-Reply-To: <20200213181140.GA28626@kernel.org>
References: <20200213122009.31810-1-tmricht@linux.ibm.com>
        <20200213143048.GA22170@kernel.org>
        <20200214020151.c93187535a8ccd0fb146a301@kernel.org>
        <20200213181140.GA28626@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2020 15:11:40 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Fri, Feb 14, 2020 at 02:01:51AM +0900, Masami Hiramatsu escreveu:
> > On Thu, 13 Feb 2020 11:30:48 -0300 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>  
> > > Em Thu, Feb 13, 2020 at 01:20:09PM +0100, Thomas Richter escreveu:
> > > > This test places a kprobe to function getname_flags() in the kernel
> > > > which has the following prototype:
>  
> > > >   struct filename *
> > > >   getname_flags(const char __user *filename, int flags, int *empty)
>  
> > > > Variable filename points to a filename located in user space memory.
> > > > Looking at
> > > > commit 88903c464321c ("tracing/probe: Add ustring type for user-space string")
> > > > the kprobe should indicate that user space memory is accessed.
>  
> > > > The following patch specifies user space memory access first and if this
> > > > fails use type 'string' in case 'ustring' is not supported.
>  
> > > What are you fixing?
>  
> > > I haven't seen any example of this test failing, and right now testing
> > > it with:
>  
> > > [root@quaco ~]# uname -a
> > > Linux quaco 5.6.0-rc1+ #1 SMP Wed Feb 12 15:42:16 -03 2020 x86_64 x86_64 x86_64 GNU/Linux
> > > [root@quaco ~]#
>  
> > This bug doesn't happen on x86 or other archs on which user-address space and
> > kernel address space is same. On some arch (ppc64 in this case?) user-address
> > space is partially or completely same as kernel address space. (Yes, they switch
> > the world when running into the kernel) In this case, we need to use different
> > data access functions for each spaces. That is why I introduced "ustring" type
> > for kprobe event.
> > As far as I can see, Thomas's patch is sane.
> 
> Well, without his patch, on x86, the test he is claiming to be fixing
> works well, with his patch it stops working, see the rest of my reply.

OK, let me see.


> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> index 7cb99b433888..30c1eadbc5be 100644
> --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> @@ -13,7 +13,9 @@ add_probe_vfs_getname() {
>  	local verbose=$1
>  	if [ $had_vfs_getname -eq 1 ] ; then
>  		line=$(perf probe -L getname_flags 2>&1 | egrep 'result.*=.*filename;' | sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/')
> -		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
> +		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->uptr:ustring" || \
> +		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring" || \
> +		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->uptr:string" || \
>  		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:string"
>  	fi
>  }

This looks no good (depends on architecture or debuginfo). In fs/namei.c,

struct filename *
getname_flags(const char __user *filename, int flags, int *empty)
...
        kname = (char *)result->iname;
        result->name = kname;
...
        result->uptr = filename;
        result->aname = NULL;
        audit_getname(result);
        return result;
}

And the line number script, egreps below line.

        result->uptr = filename;

However, the probe on this line will hit *before* execute this line.
Note that kprobes is a breakpoint, which breaks into this line execution,
not after executed.

So, I thik at this point, result->uptr should be NULL, but filename and
result->name already have assigned value.

Thus, the fix should be something like below.

> 		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
> - 		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:string"
> +		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring" || \

Thomas, is this OK for you too, or would you have any reason to trace
result->uptr?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
