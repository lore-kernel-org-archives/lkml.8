Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC271C83006
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 05:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A67E02076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 05:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgD3FC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 01:02:27 -0400
Received: from foss.arm.com ([217.140.110.172]:48582 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbgD3FC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 01:02:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 959CC1063;
        Wed, 29 Apr 2020 22:02:25 -0700 (PDT)
Received: from [10.163.71.104] (unknown [10.163.71.104])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A8B33F305;
        Wed, 29 Apr 2020 22:02:22 -0700 (PDT)
Subject: Re: [PATCH] arm: mm: use __pfn_to_section() to get mem_section
To:     Guixiong Wei <guixiongwei@gmail.com>, catalin.marinas@arm.com,
        will@kernel.org
Cc:     steve.capper@arm.com, linux-kernel@vger.kernel.org,
        rppt@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        guro@fb.com, akpm@linux-foundation.org, tglx@linutronix.de,
        nsaenzjulienne@suse.de
References: <20200430040437.119591-1-guixiongwei@gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <bbe98908-4787-4981-0248-955b2cd2db19@arm.com>
Date:   Thu, 30 Apr 2020 10:31:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200430040437.119591-1-guixiongwei@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/30/2020 09:34 AM, Guixiong Wei wrote:
> Use __pfn_to_section() to get mem_section, instead of open-coding it.

There is no open coding here. __pfn_to_section() helper which already
wraps around __nr_to_section(pfn_to_section_nr(pfn)), should be used
directly instead.

> No semantic changes.

and functional change. Please reword the commit message.

> 
> Signed-off-by: Guixiong Wei <guixiongwei@gmail.com>
> ---
>  arch/arm64/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index e42727e3568e..d2df416b840e 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -272,7 +272,7 @@ int pfn_valid(unsigned long pfn)
>  	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
>  		return 0;
>  
> -	if (!valid_section(__nr_to_section(pfn_to_section_nr(pfn))))
> +	if (!valid_section(__pfn_to_section(pfn))
Looks good.

>  		return 0;
>  #endif
>  	return memblock_is_map_memory(addr);
> 
