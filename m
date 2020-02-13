Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA96C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5405A21734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581586354;
	bh=Mp02jb5VyNOUcYiGHG03dLsGS6YV0r6/6Xce19xl4T0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VJnPzdXJabKFEdE+kGFcP40Ubg8aR3Tr6SWf8NSS4tLgNDC4tWdDKxf0UvJUDslAB
	 yU7cBfkakei3gziSK/JlI4sv+SDi+nC9EF6KjNy4sQwwxF7piFj6flwKgwaHcXUTA8
	 WSP3CG8q8QHgDGym4IY1dPmsiW3icpNLLjg8tnrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbgBMJcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:32:33 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55474 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbgBMJcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:32:32 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so5374180wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 01:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Szpi62myEK2IMzveHJnGljROe4VEIiMR6+A5LS1u+08=;
        b=IZ/jRT8tVuua0sL39WTc+wyGo7krKaHTgpTnUl6GA1IzY929+tYE9xzDHAPJ7eTUO4
         ewWD2AVTtOansBKEcImgFyD7gZaWyArRt8E4YCpaAgHfU8WHenLdRYHI4xn8aASzxx79
         Ki6UFtPL8l51d6rRU+Ku9dAGw/oAWy/+YbVcLRm0aGNzTvj9oW3bFAbNM2aYs0W3QG5W
         DL1T4RR4+IfykhyLhURbuLf1MT9uIEnqFMTovXQLXmhV0F8nHfMhqg9U1C25ocG9RUUP
         nZiL9rIzo9xWbB5is9YKKSA4GKFwUsl08AgZMdpUceBZ2bfFJc3BmsqHDu7tyHSP4GfX
         2AAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Szpi62myEK2IMzveHJnGljROe4VEIiMR6+A5LS1u+08=;
        b=idDhyXlSlSQHWqHdko+rJxHdXsopWRr1J+O3GSSJaxWe7a98Y/RLoa1OJLOdNPHwiP
         I0qXhEMKxdQYtXoI5TjL75Zgm8h33F92t1bUR5GjZXm7DvAm+tCD+yjm+CRPs3HIgr/k
         5Wdeum5+pg2cpXeRMGQQi6N5bSHSQu7H+mDLbBdr0etpEUa32hJF9PgMI9ZFBNsyHofU
         0rZlQJo8zGrJ3lod4mP6dxvbFGm8LAntg4+9a6ypVq2venzoSUlqdvvK5soLpf9BCIaH
         6nnBLUA5CC7itECtOdORjQrgRkvGpREBRnTwjv0jLRqdmsmNOh656MmKw7sKsrKKtJsD
         d+Yw==
X-Gm-Message-State: APjAAAXDYpFcNROZGbG1e0kzJ8etuk/UYweTmmHdlsMGJRQiklXxDXoj
        FN1qZfsBzA4tNtX1Ez9qWVs=
X-Google-Smtp-Source: APXvYqzsD2FBaQGfErOtCUuWNM+0vrFghHrVr/9Xriu0M2+OB7g2HYg2A1mGS+dIBGwoOTZNi3+MgA==
X-Received: by 2002:a1c:6a06:: with SMTP id f6mr4886871wmc.137.1581586350475;
        Thu, 13 Feb 2020 01:32:30 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id l2sm2160747wme.1.2020.02.13.01.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 01:32:29 -0800 (PST)
Date:   Thu, 13 Feb 2020 10:32:27 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, vishal.l.verma@intel.com,
        hch@lst.de, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: Re: [PATCH v4 4/6] x86/mm: Introduce CONFIG_KEEP_NUMA
Message-ID: <20200213093227.GA90266@gmail.com>
References: <157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157966229575.2508551.1892426244277171485.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157966229575.2508551.1892426244277171485.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dan Williams <dan.j.williams@intel.com> wrote:

> Currently x86 numa_meminfo is marked __initdata in the
> CONFIG_MEMORY_HOTPLUG=n case. In support of a new facility to allow
> drivers to map reserved memory to a 'target_node'
> (phys_to_target_node()), add support for removing the __initdata
> designation for those users. Both memory hotplug and
> phys_to_target_node() users select CONFIG_KEEP_NUMA to tell the arch to
> maintain its physical address to numa mapping infrastructure post init.
> 
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <x86@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/x86/mm/numa.c   |    6 +-----
>  include/linux/numa.h |    6 ++++++
>  mm/Kconfig           |    5 +++++
>  3 files changed, 12 insertions(+), 5 deletions(-)

The concept and the x86 portions look sane, just a few minor nits:

> 
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 99f7a68738f0..5289d9d6799a 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -25,11 +25,7 @@ nodemask_t numa_nodes_parsed __initdata;
>  struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
>  EXPORT_SYMBOL(node_data);
>  
> -static struct numa_meminfo numa_meminfo
> -#ifndef CONFIG_MEMORY_HOTPLUG
> -__initdata
> -#endif
> -;
> +static struct numa_meminfo numa_meminfo __initdata_numa;
>  
>  static int numa_distance_cnt;
>  static u8 *numa_distance;
> diff --git a/include/linux/numa.h b/include/linux/numa.h
> index 20f4e44b186c..c005ed6b807b 100644
> --- a/include/linux/numa.h
> +++ b/include/linux/numa.h
> @@ -13,6 +13,12 @@
>  
>  #define	NUMA_NO_NODE	(-1)
>  
> +#ifdef CONFIG_KEEP_NUMA
> +#define __initdata_numa
> +#else
> +#define __initdata_numa __initdata
> +#endif
> +
>  #ifdef CONFIG_NUMA
>  int numa_map_to_online_node(int node);
>  #else
> diff --git a/mm/Kconfig b/mm/Kconfig
> index ab80933be65f..001f1185eadf 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -139,6 +139,10 @@ config HAVE_FAST_GUP
>  config ARCH_KEEP_MEMBLOCK
>  	bool
>  
> +# Keep arch numa mapping infrastructure post-init.

s/numa/NUMA

Please also capitalize consistently in the rest of the series.

> +config KEEP_NUMA
> +	bool


So most of our recent new NUMA options followed the naming pattern of:

  CONFIG_NUMA_*

Such as CONFIG_NUMA_BALANCING or CONFIG_NUMA_EMU.

So I'd suggesting naming it to CONFIG_NUMA_KEEP, or, a bit more 
descriptively, such as CONFIG_NUMA_KEEP_MAPPING or such?

'Keeping NUMA' is kind of lame - of course we keep NUMA. ;-)

Thanks,

	Ingo
