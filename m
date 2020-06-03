Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4C5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6F6F206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgFCLRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 07:17:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:60678 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgFCLRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 07:17:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 415EFAC40;
        Wed,  3 Jun 2020 11:17:50 +0000 (UTC)
Subject: Re: [PATCH] mm: thp: Add new kernel parameters
 transparent_hugepage_defrag/khugepaged_defrag
To:     Gavin Guo <gavin.guo@canonical.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org
References: <20200603065049.11598-1-gavin.guo@canonical.com>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <14faa6c7-6701-7a8e-3e88-4febee20f56e@suse.cz>
Date:   Wed, 3 Jun 2020 13:17:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200603065049.11598-1-gavin.guo@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/3/20 8:50 AM, Gavin Guo wrote:
> There is no way to set up the defrag options in boot time. And it's
> useful to set it up by default instead of making it work by a
> systemd/upstart service or put the command to set up defrag inside
> /etc/rc.local.
> 
> Signed-off-by: Gavin Guo <gavin.guo@canonical.com>

Well, maybe isntead of adding these handlers, we could extend the new boot
parameter sysctl support (handling procfs /proc/sys/) to sysfs (/sys) as well,
as Eric already suggested? [1]

[1] https://lore.kernel.org/linux-api/87bloj2skm.fsf@x220.int.ebiederm.org/

> ---
>  .../admin-guide/kernel-parameters.txt         | 18 ++++++++
>  mm/huge_memory.c                              | 43 +++++++++++++++++++
>  mm/khugepaged.c                               | 21 +++++++++
>  3 files changed, 82 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 6253849afac2..a9fd020d78db 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2149,6 +2149,16 @@
>  	kgdbwait	[KGDB] Stop kernel execution and enter the
>  			kernel debugger at the earliest opportunity.
>  
> +	khugepaged_defrag=
> +			[KNL]
> +			Format: { "0" | "1" }
> +			0 - disable the defrag
> +			1 - enable the defrag
> +			Control the defrag efforts when generating the
> +			transparent hugepages through khugepaged.
> +			See Documentation/admin-guide/mm/transhuge.rst
> +			for more details.
> +
>  	kmac=		[MIPS] korina ethernet MAC address.
>  			Configure the RouterBoard 532 series on-chip
>  			Ethernet adapter MAC address.
> @@ -5146,6 +5156,14 @@
>  			See Documentation/admin-guide/mm/transhuge.rst
>  			for more details.
>  
> +	transparent_hugepage_defrag=
> +			[KNL]
> +			Format: [always|defer|defer+madvise|madvise|never]
> +			Control the defrag efforts when generating the
> +			transparent hugepages.
> +			See Documentation/admin-guide/mm/transhuge.rst
> +			for more details.
> +
>  	tsc=		Disable clocksource stability checks for TSC.
>  			Format: <string>
>  			[x86] reliable: mark tsc clocksource as reliable, this
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 8091b780cd7a..86b20a3a1aac 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -481,6 +481,49 @@ static int __init setup_transparent_hugepage(char *str)
>  }
>  __setup("transparent_hugepage=", setup_transparent_hugepage);
>  
> +static int __init setup_transparent_hugepage_defrag(char *str)
> +{
> +	int ret = 0;
> +	if (!str)
> +		goto out;
> +	if (!strcmp(str, "always")) {
> +		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags);
> +		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags);
> +		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags);
> +		set_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags);
> +		ret = 1;
> +	} else if (!strcmp(str, "defer+madvise")) {
> +		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags);
> +		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags);
> +		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags);
> +		set_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags);
> +		ret = 1;
> +	} else if (!strcmp(str, "defer")) {
> +		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags);
> +		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags);
> +		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags);
> +		set_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags);
> +		ret = 1;
> +	} else if (!strcmp(str, "madvise")) {
> +		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags);
> +		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags);
> +		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags);
> +		set_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags);
> +		ret = 1;
> +	} else if (!strcmp(str, "never")) {
> +		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags);
> +		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags);
> +		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags);
> +		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags);
> +		ret = 1;
> +	}
> +out:
> +	if (!ret)
> +		pr_warn("transparent_hugepage_defrag= cannot parse, ignored\n");
> +	return ret;
> +}
> +__setup("transparent_hugepage_defrag=", setup_transparent_hugepage_defrag);
> +
>  pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
>  {
>  	if (likely(vma->vm_flags & VM_WRITE))
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index b043c40a21d4..39bbf2107a23 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -394,6 +394,27 @@ int __init khugepaged_init(void)
>  	return 0;
>  }
>  
> +static int __init setup_khugepaged_defrag(char *str)
> +{
> +	int ret = 0;
> +	if (!str)
> +		goto out;
> +	if (!strcmp(str, "0")) {
> +		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG,
> +			  &transparent_hugepage_flags);
> +		ret = 1;
> +	} else if (!strcmp(str, "1")) {
> +		set_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG,
> +			&transparent_hugepage_flags);
> +		ret = 1;
> +	}
> +out:
> +	if (!ret)
> +		pr_warn("khugepaged_defrag= cannot parse, ignored\n");
> +	return ret;
> +}
> +__setup("khugepaged_defrag=", setup_khugepaged_defrag);
> +
>  void __init khugepaged_destroy(void)
>  {
>  	kmem_cache_destroy(mm_slot_cache);
> 

