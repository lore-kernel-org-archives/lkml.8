Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9A5C33CA8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 04:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD092187F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 04:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387571AbgAMEFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 23:05:08 -0500
Received: from foss.arm.com ([217.140.110.172]:34008 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387415AbgAMEFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 23:05:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B992F30E;
        Sun, 12 Jan 2020 20:05:07 -0800 (PST)
Received: from [10.162.43.142] (p8cg001049571a15.blr.arm.com [10.162.43.142])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E2A33F6C4;
        Sun, 12 Jan 2020 20:04:59 -0800 (PST)
Subject: Re: [PATCH V11 1/5] mm/hotplug: Introduce arch callback validating
 the hot remove range
To:     kbuild test robot <lkp@intel.com>
Cc:     mark.rutland@arm.com, david@redhat.com, catalin.marinas@arm.com,
        linux-mm@kvack.org, arunks@codeaurora.org, cpandya@codeaurora.org,
        will@kernel.org, ira.weiny@intel.com, steven.price@arm.com,
        valentin.schneider@arm.com, suzuki.poulose@arm.com,
        Robin.Murphy@arm.com, broonie@kernel.org, cai@lca.pw,
        ard.biesheuvel@arm.com, dan.j.williams@intel.com,
        linux-arm-kernel@lists.infradead.org, osalvador@suse.de,
        kbuild-all@lists.01.org, steve.capper@arm.com, logang@deltatee.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net
References: <1578625755-11792-2-git-send-email-anshuman.khandual@arm.com>
 <202001112247.k6CzgJBj%lkp@intel.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <bf4362af-2ba0-9099-985a-7b32fdbc6871@arm.com>
Date:   Mon, 13 Jan 2020 09:36:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <202001112247.k6CzgJBj%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/11/2020 07:41 PM, kbuild test robot wrote:
>    mm/memory_hotplug.c: In function 'check_hotremove_memory_range':
>>> mm/memory_hotplug.c:1027:7: error: implicit declaration of function 'arch_memory_removable'; did you mean 'add_memory_resource'? [-Werror=implicit-function-declaration]
>      rc = arch_memory_removable(start, size);
>           ^~~~~~~~~~~~~~~~~~~~~
>           add_memory_resource
>    At top level:
>    mm/memory_hotplug.c:1017:12: warning: 'check_hotremove_memory_range' defined but not used [-Wunused-function]
>     static int check_hotremove_memory_range(u64 start, u64 size)
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> vim +1027 mm/memory_hotplug.c
> 
>   1016	
>   1017	static int check_hotremove_memory_range(u64 start, u64 size)
>   1018	{
>   1019		int rc;
>   1020	
>   1021		BUG_ON(check_hotplug_memory_range(start, size));
>   1022	
>   1023		/*
>   1024		 * First check if the platform is willing to have this
>   1025		 * memory range removed else just abort.
>   1026		 */
>> 1027		rc = arch_memory_removable(start, size);
>   1028		if (!rc)
>   1029			return -EINVAL;
>   1030	
>   1031		return 0;
>   1032	}
>   1033	


Both the build failures reported here could be solved by moving
check_hotremove_memory_range() inside CONFIG_MEMORY_HOTREMOVE
wrappers, will fix it.

- Anshuman
