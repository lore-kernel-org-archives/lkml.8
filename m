Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADF1C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 14:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BC2020855
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 14:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599747681;
	bh=2rpnh2RBD5R8RyuJb8iyA1MzLro0dvc3KgNjFzIDVuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qlZjaREAWvBKQszm7xjPF1ojYb7U2QV8/DCg/k5UyLKmlnCtz98E2TVGKPCrAvC4A
	 JOhRFNVZupzCmJDAxpqEYgp7RUvtvJ/fVg33AlgR+um8D78Knx7beeV0n/FYeiIJ+H
	 ZMktWzU8PTXlitoUmTGdc+jFJu6t7V2+S67fW36c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731034AbgIJOVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 10:21:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731114AbgIJOKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:10:31 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E99121D79;
        Thu, 10 Sep 2020 13:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599745479;
        bh=2rpnh2RBD5R8RyuJb8iyA1MzLro0dvc3KgNjFzIDVuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bFaQIQNda2L/zgJFisbB6HcjzJzEwgktRzodCLDh5GSC2QkY63lALnClSCNIfic78
         i9E4FbbSJu2aO8gccL/lgqJaVZrlPVgFwRVvIs5cwAiu9h/Gjc66jHBx3d6Ka4ayE8
         u5PlTvF3xUplHGXeFQ5FPcP6mYpaS7ctOEayPkFw=
Date:   Thu, 10 Sep 2020 16:44:35 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -rc v1] gcov: Disable gcov build with GCC 10
Message-ID: <20200910134435.GK421756@unreal>
References: <20200904155808.4997-1-leon@kernel.org>
 <6fac3754-f8db-85f5-bdb1-b4c8e7ccc046@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fac3754-f8db-85f5-bdb1-b4c8e7ccc046@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 02:52:01PM +0200, Peter Oberparleiter wrote:
> On 04.09.2020 17:58, Leon Romanovsky wrote:
> > GCOV built with GCC 10 doesn't initialize n_function variable.
> > This produces different kernel panics as was seen by Colin in
> > Ubuntu [1] and me in FC 32 [2].
> >
> > As a workaround, let's disable GCOV build for broken GCC 10 version.
> >
> > [1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1891288
> > [2] https://lore.kernel.org/lkml/20200827133932.3338519-1-leon@kernel.org
> > Cc: Colin Ian King <colin.king@canonical.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>
> The following patch should fix the problem with gcov and GCC 10.
> I successfully tested it with kernel 5.9-rc4 on s390 using GCC 10.1.1
> and also with GCC 9.1.1 to see that it didn't break support for previous
> GCC versions. In both cases there were no kernel panics and gcov worked
> fine.
>
> Could you try this patch to see if it also fixes the problem in your
> environment?

It worked for me, Thanks
Tested-by: Leon Romanovsky <leonro@nvidia.com>

>
> ---8<---
> From: Peter Oberparleiter <oberpar@linux.ibm.com>
> Subject: [PATCH] gcov: add support for GCC 10.1
>
> Using gcov to collect coverage data for kernels compiled with GCC 10.1
> causes random malfunctions and kernel crashes. This is the result of a
> changed GCOV_COUNTERS value in GCC 10.1 that causes a mismatch between
> the layout of the gcov_info structure created by GCC profiling code and
> the related structure used by the kernel.
>
> Fix this by updating the in-kernel GCOV_COUNTERS value. Also re-enable
> config GCOV_KERNEL for use with GCC 10.
>
> Reported-by: Colin Ian King <colin.king@canonical.com>
> Reported-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> ---
>  kernel/gcov/Kconfig   | 1 -
>  kernel/gcov/gcc_4_7.c | 4 +++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
> index bb4b680e8455..3110c77230c7 100644
> --- a/kernel/gcov/Kconfig
> +++ b/kernel/gcov/Kconfig
> @@ -4,7 +4,6 @@ menu "GCOV-based kernel profiling"
>  config GCOV_KERNEL
>  	bool "Enable gcov-based kernel profiling"
>  	depends on DEBUG_FS
> -	depends on !CC_IS_GCC || GCC_VERSION < 100000
>  	select CONSTRUCTORS if !UML
>  	default n
>  	help
> diff --git a/kernel/gcov/gcc_4_7.c b/kernel/gcov/gcc_4_7.c
> index 908fdf5098c3..53c67c87f141 100644
> --- a/kernel/gcov/gcc_4_7.c
> +++ b/kernel/gcov/gcc_4_7.c
> @@ -19,7 +19,9 @@
>  #include <linux/vmalloc.h>
>  #include "gcov.h"
>
> -#if (__GNUC__ >= 7)
> +#if (__GNUC__ >= 10)
> +#define GCOV_COUNTERS			8
> +#elif (__GNUC__ >= 7)
>  #define GCOV_COUNTERS			9
>  #elif (__GNUC__ > 5) || (__GNUC__ == 5 && __GNUC_MINOR__ >= 1)
>  #define GCOV_COUNTERS			10
> --
> 2.21.0
>
