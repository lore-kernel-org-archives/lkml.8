Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B526C3B196
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 10:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6292168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 10:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581677626;
	bh=BfxKhaEfkI1P/IrhM/bvf+jUvC8uhJg/KC/l8N4bzFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zwSyk86NfBoI2rwv1pwti+3WTDMQwINC8S8oT9iy2XPxS0+N8X7JdBPpOiX091XFW
	 4AOXAz44Dtr83itybHGdX7xth3Qb5fjJex5qzA5IVry04F4PCbk/kDLXJlUs0OAfGP
	 qUzIegnC5go9ZNM1MuME789C58eyDnMABKKhCxmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbgBNKxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 05:53:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37723 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgBNKxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 05:53:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so10373875wru.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 02:53:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VLOBDvst4bIPerm7KXdCwIEY1gBBSsuj6FxK6yl1RCQ=;
        b=WqesLDPSLxnLBG/vGlHPRoTGGG2WYZFh9DTaDl/GGkgZ/m9ZR7UOM+W6EruktEFEln
         W8S6y4QLwmNUjLDaVymPmDBba2/VdBErO0z526/qtSx6E3OZh3EZRuSQY6cLWu4UsWu1
         00Pav6uvcSvU7QnF2scT8vtWimLNYcVJVvtSfBd/k+8DdUgTsLLAXegXHjLKkV1EX8JK
         IfYC6DIi7uX/L09HtcW54pcTwAb6DHL2jC4Vfs7fbccbfwX/vQN/mzBi//6uYfEnwC/6
         Jnt3FyucmqEDEONRk64AWZaNMGYSrNWZThaXDqoW4cSygjZEqZuGRbFAsAACT9R4+qf2
         63cw==
X-Gm-Message-State: APjAAAVlKVTapSOIXJhPPdNwx9u1yxqntlp6yhbdge/8uWw4e+ZZuE98
        MvqX+tEDbHVsGCeLWmOb86yuqUQD
X-Google-Smtp-Source: APXvYqzVUXtzKOtrAV72o9ta2w8SN0eNxEEaHTPls/CwB8hU1wpi97W3J5KoEMAMBW4ucMUcCBcWhg==
X-Received: by 2002:a05:6000:128a:: with SMTP id f10mr3604643wrx.116.1581677622854;
        Fri, 14 Feb 2020 02:53:42 -0800 (PST)
Received: from localhost (ip-37-188-133-87.eurotel.cz. [37.188.133.87])
        by smtp.gmail.com with ESMTPSA id t9sm6937926wrv.63.2020.02.14.02.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 02:53:42 -0800 (PST)
Date:   Fri, 14 Feb 2020 11:53:41 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, david@redhat.com, jgross@suse.com,
        bsingharora@gmail.com
Subject: Re: [PATCH v3] mm/hotplug: Only respect mem= parameter during boot
 stage
Message-ID: <20200214105341.GU31689@dhcp22.suse.cz>
References: <20200204050643.20925-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204050643.20925-1-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04-02-20 13:06:43, Baoquan He wrote:
> In commit 357b4da50a62 ("x86: respect memory size limiting via mem=
> parameter") a global varialbe max_mem_size is added to store
> the value parsed from 'mem= ', then checked when memory region is
> added. This truly stops those DIMMs from being added into system memory
> during boot-time.
> 
> However, it also limits the later memory hotplug functionality. Any
> DIMM can't be hotplugged any more if its region is beyond the
> max_mem_size. We will get errors like:
> 
> [  216.387164] acpi PNP0C80:02: add_memory failed
> [  216.389301] acpi PNP0C80:02: acpi_memory_enable_device() error
> [  216.392187] acpi PNP0C80:02: Enumeration failure
> 
> This will cause issue in a known use case where 'mem=' is added to
> the hypervisor. The memory that lies after 'mem=' boundary will be
> assigned to KVM guests. After commit 357b4da50a62 merged, memory
> can't be extended dynamically if system memory on hypervisor is not
> sufficient.
> 
> So fix it by also checking if it's during boot-time restricting to add
> memory. Otherwise, skip the restriction.
> 
> And also add this use case to document of 'mem=' kernel parameter.

I have to say I am not entirely happy about this change but the breakage
seems to be real so we have to live with that. If there are usecases that
need to restrict the physical memory range for real we would have to add
a new command line parameter.

> Fixes: 357b4da50a62 ("x86: respect memory size limiting via mem= parameter")
> Signed-off-by: Baoquan He <bhe@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> v2->v3:
>   In discussion of v1 and v2, People have concern about the use case
>   related to the code change. So add the use case into patch log and
>   document of 'mem=' in kernel-parameters.txt.
> 
>  Documentation/admin-guide/kernel-parameters.txt | 13 +++++++++++--
>  mm/memory_hotplug.c                             |  8 +++++++-
>  2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index ddc5ccdd4cd1..b809767e5f74 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2533,13 +2533,22 @@
>  			For details see: Documentation/admin-guide/hw-vuln/mds.rst
>  
>  	mem=nn[KMG]	[KNL,BOOT] Force usage of a specific amount of memory
> -			Amount of memory to be used when the kernel is not able
> -			to see the whole system memory or for test.
> +			Amount of memory to be used in cases as follows:
> +
> +			1 for test;
> +			2 when the kernel is not able to see the whole system memory;
> +			3 memory that lies after 'mem=' boundary is excluded from
> +			 the hypervisor, then assigned to KVM guests.
> +
>  			[X86] Work as limiting max address. Use together
>  			with memmap= to avoid physical address space collisions.
>  			Without memmap= PCI devices could be placed at addresses
>  			belonging to unused RAM.
>  
> +			Note that this only takes effects during boot time since
> +			in above case 3, memory may need be hot added after boot
> +			if system memory of hypervisor is not sufficient.
> +
>  	mem=nopentium	[BUGS=X86-32] Disable usage of 4MB pages for kernel
>  			memory.
>  
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 36d80915ddc2..e6c75ceacf9a 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -105,7 +105,13 @@ static struct resource *register_memory_resource(u64 start, u64 size)
>  	unsigned long flags =  IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>  	char *resource_name = "System RAM";
>  
> -	if (start + size > max_mem_size)
> +	/*
> +	 * Make sure value parsed from 'mem=' only restricts memory adding
> +	 * while booting, so that memory hotplug won't be impacted. Please
> +	 * refer to document of 'mem=' in kernel-parameters.txt for more
> +	 * details.
> +	 */
> +	if (start + size > max_mem_size && system_state < SYSTEM_RUNNING)
>  		return ERR_PTR(-E2BIG);
>  
>  	/*
> -- 
> 2.17.2

-- 
Michal Hocko
SUSE Labs
