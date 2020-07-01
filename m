Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3295C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9524620771
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgGAB2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 21:28:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:39091 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgGAB2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 21:28:12 -0400
IronPort-SDR: Wp3I0SUAqtgwW03Ujh/FTsOzPCYZBX7SbMe7c7RJO3yjUO7hFKR3yx50jfOqLcCLh5262Szj1a
 hmYKu5Q0iakQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="126063173"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="126063173"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 18:28:12 -0700
IronPort-SDR: vJpC9c2ju7gYWK/45yBYB3OIJK02r58VOs+HGboGK9z9tREKl9UPd6EtISSPSlzpJnk5lQUips
 sI351JY9ufJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="321090981"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jun 2020 18:28:10 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <rientjes@google.com>, <dan.j.williams@intel.com>
Subject: Re: [RFC][PATCH 8/8] mm/numa: new reclaim mode to enable reclaim-based migration
References: <20200629234503.749E5340@viggo.jf.intel.com>
        <20200629234517.A7EC4BD3@viggo.jf.intel.com>
        <87v9j9ow3a.fsf@yhuang-dev.intel.com>
        <29c67873-3cb9-e121-382c-9b81491016bc@linux.alibaba.com>
        <87mu4knjq8.fsf@yhuang-dev.intel.com>
        <cdcdc19a-0dde-8392-6f3b-2480c2d740d0@linux.alibaba.com>
Date:   Wed, 01 Jul 2020 09:28:10 +0800
In-Reply-To: <cdcdc19a-0dde-8392-6f3b-2480c2d740d0@linux.alibaba.com> (Yang
        Shi's message of "Tue, 30 Jun 2020 18:12:42 -0700")
Message-ID: <87bll0nhw5.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Shi <yang.shi@linux.alibaba.com> writes:

> On 6/30/20 5:48 PM, Huang, Ying wrote:
>> Hi, Yang,
>>
>> Yang Shi <yang.shi@linux.alibaba.com> writes:
>>
>>>>> diff -puN mm/vmscan.c~enable-numa-demotion mm/vmscan.c
>>>>> --- a/mm/vmscan.c~enable-numa-demotion	2020-06-29 16:35:01.017312549 -0700
>>>>> +++ b/mm/vmscan.c	2020-06-29 16:35:01.023312549 -0700
>>>>> @@ -4165,9 +4165,10 @@ int node_reclaim_mode __read_mostly;
>>>>>     * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
>>>>>     * ABI.  New bits are OK, but existing bits can never change.
>>>>>     */
>>>>> -#define RECLAIM_RSVD  (1<<0)	/* (currently ignored/unused) */
>>>>> -#define RECLAIM_WRITE (1<<1)	/* Writeout pages during reclaim */
>>>>> -#define RECLAIM_UNMAP (1<<2)	/* Unmap pages during reclaim */
>>>>> +#define RECLAIM_RSVD	(1<<0)	/* (currently ignored/unused) */
>>>>> +#define RECLAIM_WRITE	(1<<1)	/* Writeout pages during reclaim */
>>>>> +#define RECLAIM_UNMAP	(1<<2)	/* Unmap pages during reclaim */
>>>>> +#define RECLAIM_MIGRATE	(1<<3)	/* Migrate pages during reclaim */
>>>>>      /*
>>>>>     * Priority for NODE_RECLAIM. This determines the fraction of pages
>>>> I found that RECLAIM_MIGRATE is defined but never referenced in the
>>>> patch.
>>>>
>>>> If my understanding of the code were correct, shrink_do_demote_mapping()
>>>> is called by shrink_page_list(), which is used by kswapd and direct
>>>> reclaim.  So as long as the persistent memory node is onlined,
>>>> reclaim-based migration will be enabled regardless of node reclaim mode.
>>> It looks so according to the code. But the intention of a new node
>>> reclaim mode is to do migration on reclaim *only when* the
>>> RECLAIM_MODE is enabled by the users.
>>>
>>> It looks the patch just clear the migration target node masks if the
>>> memory is offlined.
>>>
>>> So, I'm supposed you need check if node_reclaim is enabled before
>>> doing migration in shrink_page_list() and also need make node reclaim
>>> to adopt the new mode.
>> But why shouldn't we migrate in kswapd and direct reclaim?  I think that
>> we may need a way to control it, but shouldn't disable it
>> unconditionally.
>
> Let me share some background. In the past discussions on LKML and last
> year's LSFMM the opt-in approach was preferred since the new feature
> might be not stable and mature.  So the new node reclaim mode was
> suggested by both Mel and Michal. I'm supposed this is still a valid
> point now.

Is there any technical reason?  I think the code isn't very complex.  If
we really worry about stable and mature, isn't it enough to provide some
way to enable/disable the feature?  Even for kswapd and direct reclaim?

Best Regards,
Huang, Ying

> Once it is mature and stable enough we definitely could make it
> universally preferred and default behavior.
>
>>
>>> Please refer to
>>> https://lore.kernel.org/linux-mm/1560468577-101178-6-git-send-email-yang.shi@linux.alibaba.com/
>>>
>> Best Regards,
>> Huang, Ying
