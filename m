Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD06AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3C8720675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CaAH029j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbgGGV5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:57:20 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12494 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbgGGV5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:57:20 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f04ef550000>; Tue, 07 Jul 2020 14:55:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 Jul 2020 14:57:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 Jul 2020 14:57:19 -0700
Received: from [10.2.50.36] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Jul
 2020 21:57:18 +0000
Subject: Re: [PATCH V3] mm/vmstat: Add events for THP migration without split
To:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
CC:     <linux-mm@kvack.org>, Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Hugh Dickins" <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        <linux-kernel@vger.kernel.org>
References: <1594080415-27924-1-git-send-email-anshuman.khandual@arm.com>
 <20200707130406.21ce3d61a4cce25831abb2d1@linux-foundation.org>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <dfb0661f-60bc-92a4-9a10-3cf09342714c@nvidia.com>
Date:   Tue, 7 Jul 2020 14:57:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200707130406.21ce3d61a4cce25831abb2d1@linux-foundation.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594158933; bh=UkjuVJX7qXH4aNelVrfrk3vUbsAK4xxYDBiu8YGtRZ8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=CaAH029jU/ZygbHUlEeyaPeQXOxoPlgNNwtuI50UlNXAm6hjhNSjwIpfiVPUGchMl
         iO/RuP4kZ/ABSyY7LCnlVUGN7otdsM1kAFeDVqNfmbzcn0G0PGPFtxpLssBWYdOxsc
         yw8J6TeVnmAe9Jl1Ch1ATKJuEgWuwhosNiGg9p9Ac1i7kFSjtdBH+cDyyQWVsVSlXw
         brIN7QyXVi5EzYO4bfEqYnBFl7IR7rcmJWdaU6E2DQgsnaa3Ci2/N/Gb2Q0knguFO/
         FL2S+jfmg19kC0ZIathlvEr7PIiJRLL7oStSYeg2bGkrRJSNZfFXBAfYpOjLJRx9ej
         HBIQ7khdtkhMA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-07 13:04, Andrew Morton wrote:
> On Tue,  7 Jul 2020 05:36:55 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> 
>> Add following new vmstat events which will help in validating THP migration
>> without split. Statistics reported through these new VM events will help in
>> performance debugging.
>>
>> 1. THP_MIGRATION_SUCCESS
>> 2. THP_MIGRATION_FAILURE
>> 3. THP_MIGRATION_SPLIT
>>
>> In addition, these new events also update normal page migration statistics
>> appropriately via PGMIGRATE_SUCCESS and PGMIGRATE_FAILURE. While here, this
>> updates current trace event 'mm_migrate_pages' to accommodate now available
>> THP statistics.
> 
> Patch looks straightforward enough.  It would be nice to see some
> confirmation from others that these metrics are a desirable thing to
> export.

Taking a peek now.

> 
>> ...
>>
>> -	trace_mm_migrate_pages(nr_succeeded, nr_failed, mode, reason);
>> +	if (nr_thp_succeeded)
>> +		count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
>> +	if (nr_thp_failed)
>> +		count_vm_events(THP_MIGRATION_FAILURE, nr_thp_failed);
>> +	if (nr_thp_split)
>> +		count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
> 
> Are these "if"s worthwhile to have?

No, they are not. And there are a couple more pre-existing cases as well,
right above what can be seen here (this patch just follows the local pattern)
that should also be removed.



thanks,
-- 
John Hubbard
NVIDIA
