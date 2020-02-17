Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD2CC35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 12:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5821820578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 12:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581941419;
	bh=dVB6xTlXZp8Wu2yUdOgldXAQVk5MQeJ+RYVpiRtj5eQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=cvmz56f4boBhBrS1lQm4botRsf0HvqN7uHrTh47Dyz0zBwriVq+gQmmrNXual2PbE
	 64hSOoGrO75aXl/rejM21jp8ft1By8Du8Kf4tkwMVmNRhwy+NTBbqIOeuyfLRpUOqC
	 0kEs9IZLLeTEmkXbNW8TuT/qrbL2GTqcHX7QKtZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbgBQMKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 07:10:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729049AbgBQMKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 07:10:17 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 799B320578;
        Mon, 17 Feb 2020 12:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581941416;
        bh=dVB6xTlXZp8Wu2yUdOgldXAQVk5MQeJ+RYVpiRtj5eQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IObpV/3XESuy9pr6prF8WWrfljQhLXCZ3hu+Y2MbKowytN2B9IUqqagrmpQ2ypkTq
         qGsICut5fkhgxr3pE2CS/1mYOQEZYuV1DOmdhl0kKj6VHBw5KkWNLrCnM1/v+eGmil
         Sd9mQ/0kOkRINHg5KuPU+HrLwPNe1fHHqoku3poA=
Date:   Mon, 17 Feb 2020 21:10:10 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH v4] perf test: Fix test trace+probe_vfs_getname.sh on
 s390
Message-Id: <20200217211010.fa9c643c517c110abaa5b554@kernel.org>
In-Reply-To: <20200217102111.61137-1-tmricht@linux.ibm.com>
References: <20200217102111.61137-1-tmricht@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 11:21:11 +0100
Thomas Richter <tmricht@linux.ibm.com> wrote:

> This test places a kprobe to function getname_flags() in the kernel
> which has the following prototype:
> 
>   struct filename *
>   getname_flags(const char __user *filename, int flags, int *empty)
> 
> Variable filename points to a filename located in user space memory.
> Looking at
> commit 88903c464321c ("tracing/probe: Add ustring type for user-space string")
> the kprobe should indicate that user space memory is accessed.
> 
> Output before:
>    [root@m35lp76 perf]# ./perf test  66 67
>    66: Use vfs_getname probe to get syscall args filenames   : FAILED!
>    67: Check open filename arg using perf trace + vfs_getname: FAILED!
>    [root@m35lp76 perf]#
> 
> Output after:
>    [root@m35lp76 perf]# ./perf test  66 67
>    66: Use vfs_getname probe to get syscall args filenames   : Ok
>    67: Check open filename arg using perf trace + vfs_getname: Ok
>    [root@m35lp76 perf]#
> 
> Comments from Masami Hiramatsu:
> This bug doesn't happen on x86 or other archs on which user-address
> space and kernel address space is same. On some arch (ppc64 in this case?)
> user-address space is partially or completely same as kernel address space.
> (Yes, they switch the world when running into the kernel) In this case,
> we need to use different data access functions for each spaces.
> That is why I introduced "ustring" type for kprobe event.
> As far as I can see, Thomas's patch is sane. Thomas, could you show us
> your result on your test environment?
> Thank you
> 
> Comments from Thomas Richter:
> Test results included above.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> ---
>  tools/perf/tests/shell/lib/probe_vfs_getname.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> index 7cb99b433888..c2cc42daf924 100644
> --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> @@ -14,7 +14,7 @@ add_probe_vfs_getname() {
>  	if [ $had_vfs_getname -eq 1 ] ; then
>  		line=$(perf probe -L getname_flags 2>&1 | egrep 'result.*=.*filename;' | sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/')
>  		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
> -		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:string"
> +		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring"
>  	fi
>  }
>  
> -- 
> 2.21.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
