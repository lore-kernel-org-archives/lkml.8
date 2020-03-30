Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3481C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F29E2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgC3UQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 16:16:57 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:39820 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgC3UQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 16:16:57 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jJ0pz-0001xk-8G; Mon, 30 Mar 2020 14:16:47 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jJ0py-0005pf-Ai; Mon, 30 Mar 2020 14:16:47 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
References: <20200330181544.1595733-1-kasong@redhat.com>
Date:   Mon, 30 Mar 2020 15:14:06 -0500
In-Reply-To: <20200330181544.1595733-1-kasong@redhat.com> (Kairui Song's
        message of "Tue, 31 Mar 2020 02:15:44 +0800")
Message-ID: <87369py50x.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jJ0py-0005pf-Ai;;;mid=<87369py50x.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18POivBtpLy4qX5Ci7Y3ZVo2RKkhoDPLpY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] crash_dump: remove saved_max_pfn
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kairui Song <kasong@redhat.com> writes:

> This variable is no longer used.
>
> saved_max_pfn was originally introduce in commit 92aa63a5a1bf ("[PATCH]
> kdump: Retrieve saved max pfn"), used to make sure that user does not
> try to read the physical memory beyond saved_max_pfn. But since
> commit 921d58c0e699 ("vmcore: remove saved_max_pfn check")
> it's no longer used for the check.
>
> Only user left is Calary IOMMU, which start using it from
> commit 95b68dec0d52 ("calgary iommu: use the first kernels TCE tables
> in kdump"). But again, recently in commit 90dc392fc445 ("x86: Remove
> the calgary IOMMU driver"), Calary IOMMU is removed and this variable
> no longer have any user.
>
> So just remove it.
>
> Signed-off-by: Kairui Song <kasong@redhat.com>

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Can we merge this through the tip tree?


> ---
>  arch/x86/kernel/e820.c     | 8 --------
>  include/linux/crash_dump.h | 2 --
>  kernel/crash_dump.c        | 6 ------
>  3 files changed, 16 deletions(-)
>
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index c5399e80c59c..4d13c57f370a 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -910,14 +910,6 @@ static int __init parse_memmap_one(char *p)
>  		return -EINVAL;
>  
>  	if (!strncmp(p, "exactmap", 8)) {
> -#ifdef CONFIG_CRASH_DUMP
> -		/*
> -		 * If we are doing a crash dump, we still need to know
> -		 * the real memory size before the original memory map is
> -		 * reset.
> -		 */
> -		saved_max_pfn = e820__end_of_ram_pfn();
> -#endif
>  		e820_table->nr_entries = 0;
>  		userdef = 1;
>  		return 0;
> diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
> index 4664fc1871de..bc156285d097 100644
> --- a/include/linux/crash_dump.h
> +++ b/include/linux/crash_dump.h
> @@ -97,8 +97,6 @@ extern void unregister_oldmem_pfn_is_ram(void);
>  static inline bool is_kdump_kernel(void) { return 0; }
>  #endif /* CONFIG_CRASH_DUMP */
>  
> -extern unsigned long saved_max_pfn;
> -
>  /* Device Dump information to be filled by drivers */
>  struct vmcoredd_data {
>  	char dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Unique name of the dump */
> diff --git a/kernel/crash_dump.c b/kernel/crash_dump.c
> index 9c23ae074b40..92da32275af5 100644
> --- a/kernel/crash_dump.c
> +++ b/kernel/crash_dump.c
> @@ -5,12 +5,6 @@
>  #include <linux/errno.h>
>  #include <linux/export.h>
>  
> -/*
> - * If we have booted due to a crash, max_pfn will be a very low value. We need
> - * to know the amount of memory that the previous kernel used.
> - */
> -unsigned long saved_max_pfn;
> -
>  /*
>   * stores the physical address of elf header of crash image
>   *
