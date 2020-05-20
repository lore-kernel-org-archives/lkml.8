Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322DDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 05:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBC34207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 05:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FCAqyvhI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgETFRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 01:17:22 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1280 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbgETFRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 01:17:21 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec4bd120000>; Tue, 19 May 2020 22:16:02 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 19 May 2020 22:17:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 19 May 2020 22:17:21 -0700
Received: from [10.2.90.179] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 May
 2020 05:17:21 +0000
Subject: Re: [RFC V2] mm/vmstat: Add events for PMD based THP migration
 without split
To:     Anshuman Khandual <anshuman.khandual@arm.com>, <linux-mm@kvack.org>
CC:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <ziy@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
References: <1589784156-28831-1-git-send-email-anshuman.khandual@arm.com>
 <67be2597-c019-63c1-b551-d4571a44f1a5@nvidia.com>
 <88aa238d-9de1-9f6a-a3b0-51fbe073090d@arm.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <6b1e16d8-7340-f481-52b0-a0d0e3823a29@nvidia.com>
Date:   Tue, 19 May 2020 22:17:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <88aa238d-9de1-9f6a-a3b0-51fbe073090d@arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589951762; bh=Aybn1e6tgUQyOaiSwSOtqxOp8LjMr/Tq8kt9qdbE0CQ=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=FCAqyvhIjqwCh4oafY8izsnNpil07oYQlLUlowiA4qHHwG0oh8DNMbR3oaXPnWy3E
         /4Zl6Hj2sH2j0P0AJ1ahFW++OOwsPRZv9KuEQYhC+gk2UmbTEvTcFwg6UtZZWD24S8
         UsQqhUk0JsFA5heLUFQmRgL6uA6zn14QB/spdGCsTRuTu5RS83lzXG74KQvjgGp86+
         ick+TYcJmH8dADz73tZaziM+CtlfDx+Zmt2c/5Aa7AiSN2hByWGEldRh6Yk0KNK79h
         DPG2oJhODNDlxjsIYLE53pJwxrwQLlk4Ax2hSxEOJd5jp8SG7kg5UyAEVoc/E7yIV+
         dau4Z7zFjGHUw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-19 20:32, Anshuman Khandual wrote:
...
>> How about not being quite so granular on the THP config options, and
>> just guarding these events with the overall CONFIG_TRANSPARENT_HUGEPAGE
>> option, instead of the sub-option CONFIG_ARCH_ENABLE_THP_MIGRATION?
>>
>> I tentatively think it's harmless and not really misleading to have
>> /proc/vmstat showing this in all THP-enabled configurations:
>>
>> thp_pmd_migration_success 0
>> thp_pmd_migration_failure 0
>>
>> ...if THP is enabled, and *whether or not* _THP_MIGRATION is enabled.
>> And this simplifies things a bit. Given how the .config options can get,
>> I think simplifying would be nice.
>>
>> However, I'm ready to be corrected on that, if it's a bad idea for
>> other API reasons perhaps.=C2=A0 Can anyone please comment?
>=20
> There is no THP migration events to track unless it is enabled. Why to
> show these statistics (as 0) when its not even possible. If the config
> simplicity is the only intended rationale here, it might not be the
> case either. These events and their tracking would still need to be
> wrapped with CONFIG_TRANSPARENT_HUGEPAGE otherwise.
>=20
> If your concern is more towards CONFIG_ARCH_ENABLE_THP_MIGRATION being
> unsuitable or with complex dependencies, then that is something how THP
> migration feature itself is implemented currently and adding VM events
> does not address that. A possible patch in the future patch could solve
> all these (together).
>=20
> But sure, let's hear it for what others have to say on this.


Well, I don't want to hold up progress. If it's not very convincing to you,
let's just drop the idea/ It was kind of weak. :)


>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 THP_PMD_MIGRATION_SUCCESS,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 THP_PMD_MIGRATION_FAILURE,
>>> +#endif
>>>  =C2=A0 #endif
>>>  =C2=A0 #ifdef CONFIG_MEMORY_BALLOON
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BALLOON_INFLATE=
,
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index 7160c1556f79..5325700a3e90 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1170,6 +1170,18 @@ static int __unmap_and_move(struct page *page, s=
truct page *newpage,
>>>  =C2=A0 #define ICE_noinline
>>>  =C2=A0 #endif
>>>  =C2=A0 +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>>> +static inline void thp_migration_success(bool success)
>>
>>
>> I think this should be named
>>
>>  =C2=A0=C2=A0=C2=A0 thp_pmd_migration_success()
>>
>> , since that's what you're really counting. Or, you could
>> name the events THP_MIGRATION_SUCCESS|FAILURE. Either way,
>> just so the function name matches the events it's counting.
>=20
> Makes sense but IMHO we should keep _pmd_ to be more specific.
> Will change the name here as thp_pmd_migration_success().
>=20
>>
>>
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 if (success)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 count_vm_event(THP_PMD_MIGR=
ATION_SUCCESS);
>>> +=C2=A0=C2=A0=C2=A0 else
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 count_vm_event(THP_PMD_MIGR=
ATION_FAILURE);
>>> +}
>>> +#else
>>> +static inline void thp_migration_success(bool success) { }
>>
>>
>> This whole ifdef clause would disappear if my suggestion above is
>=20
> We will have to protect these with CONFIG_TRANSPARENT_HUGEPAGE as
> the events are still conditionally available.
>=20

Yes you are right, of course. And I even worked through that, but then
when I sat down to write a response my fingers typed v1 of my understanding
instead of v2. No one knows why. :) Sorry about the misinformation there.

>> accepted. However, if not, then I believe the convention for this
>> kind of situation is:
>>
>> static inline void thp_migration_success(bool success)
>> {
>> }
>=20
> AFAIK, we have examples both ways but will change if this is preferred.
>=20

Not worth worrying about, but I do recall a few recent code reviews that
all preferred the multi-line version, which is why I suggested it.

Anyway, either way, with the thp_pmd_migration_success() name change, you
can add:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
--=20
John Hubbard
NVIDIA
