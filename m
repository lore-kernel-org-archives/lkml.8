Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CEFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 03:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBB322072D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 03:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgGODgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 23:36:01 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:42686 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgGODgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 23:36:01 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvYD7-000181-1R; Tue, 14 Jul 2020 21:35:57 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvYD5-0005mz-Hq; Tue, 14 Jul 2020 21:35:56 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200714105505.935079-1-hch@lst.de>
        <20200714105505.935079-7-hch@lst.de>
Date:   Tue, 14 Jul 2020 22:33:05 -0500
In-Reply-To: <20200714105505.935079-7-hch@lst.de> (Christoph Hellwig's message
        of "Tue, 14 Jul 2020 12:55:05 +0200")
Message-ID: <87v9ip4fm6.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jvYD5-0005mz-Hq;;;mid=<87v9ip4fm6.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18jRvo1LY05IcyELAS/Dyw89Gb+7bU2HOk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 6/6] exec: use force_uaccess_begin during exec and exit
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> Both exec and exit want to ensure that the uaccess routines actually do
> access user pointers.  Use the newly added force_uaccess_begin helper
> instead of an open coded set_fs for that to prepare for kernel builds
> where set_fs() does not exist.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Have you played with a tree with all of your patches
and placing force_uaccess_begin in init/main.c:start_kernel?

Somewhere deep in the arch code we seem to have it all backwards
and kernel threads are all set_fs(KERNEL_DS).  So just putting
a force_uaccess_begin somewhere very early should be enough
to switch things around.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/exec.c     | 7 ++++++-
>  kernel/exit.c | 2 +-
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index e6e8a9a7032784..769af470b69124 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1380,7 +1380,12 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	if (retval)
>  		goto out_unlock;
>  
> -	set_fs(USER_DS);
> +	/*
> +	 * Ensure that the uaccess routines can actually operate on userspace
> +	 * pointers:
> +	 */
> +	force_uaccess_begin();
> +
>  	me->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC | PF_KTHREAD |
>  					PF_NOFREEZE | PF_NO_SETAFFINITY);
>  	flush_thread();
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 727150f2810338..17d486a20f0dc6 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -731,7 +731,7 @@ void __noreturn do_exit(long code)
>  	 * mm_release()->clear_child_tid() from writing to a user-controlled
>  	 * kernel address.
>  	 */
> -	set_fs(USER_DS);
> +	force_uaccess_begin();
>  
>  	if (unlikely(in_atomic())) {
>  		pr_info("note: %s[%d] exited with preempt_count %d\n",
