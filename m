Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152C7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 23:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D703C2068D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 23:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qvZgk+NM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgFIXGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 19:06:19 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2548 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbgFIXGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 19:06:18 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ee015db0000>; Tue, 09 Jun 2020 16:06:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 09 Jun 2020 16:06:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 09 Jun 2020 16:06:17 -0700
Received: from [10.2.165.41] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Jun
 2020 23:06:12 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
CC:     Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <hughd@google.com>, <daniel.m.jordan@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] mm/vmstat: Add events for THP migration without split
Date:   Tue, 9 Jun 2020 19:06:10 -0400
X-Mailer: MailMate (1.13.1r5690)
Message-ID: <1E6593E8-CF43-4E34-A2A6-4DFCE58F9096@nvidia.com>
In-Reply-To: <6401ee03-e6b3-c8f5-58b5-4f615c1b7bfc@arm.com>
References: <1591243245-23052-1-git-send-email-anshuman.khandual@arm.com>
 <20200604113421.GU19604@bombadil.infradead.org>
 <CBF71911-6BB7-4AA7-AC0F-95AADBB45569@nvidia.com>
 <20200604163657.GV19604@bombadil.infradead.org>
 <2735DD7E-0DBF-428B-AAD8-FC6DAAA9CB1E@nvidia.com>
 <9e4acb98-c9fd-a998-03b3-38947cf61bd9@arm.com>
 <890AA27D-29BA-45A9-B868-5533645D73D5@nvidia.com>
 <6401ee03-e6b3-c8f5-58b5-4f615c1b7bfc@arm.com>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_1EE9867F-54E5-40E0-8105-FA2C3B229A75_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591743963; bh=WpmdAcfZZbxVBRxIS2VdaEwN8LVUvNF+6jP2wJAYoGI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=qvZgk+NMSGQ0yUq6kMmIeXGuncevM0FgmJfErqtMeYgsYlEMKYbKoxK9aA4iJ9YW9
         inV2+hu3WHd5jHniKAu/Uex16axBX7hDP0BoyPY8gFYVIUS5yikDsdVZCGyLRQBUuM
         nM6vo3Q95vPSYWFUMrsiEdavd+bqee2nv1WEfeMxVaNCVmCjSUxXekPXKNPszzzsG1
         h3F/kq+dqBPi4wO3FUHHzUgQ6sGU1zkDXAHBzbceWzjMd2bW++6qragUT8zhczU52m
         ktiNkwT+LatnKS/ZQ0SzQ65+IN1W7i0MroSQYBFmQNofO653Grzt7EcAxai/NL4yrK
         FJOkIDYbrOOCw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_1EE9867F-54E5-40E0-8105-FA2C3B229A75_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 9 Jun 2020, at 7:35, Anshuman Khandual wrote:

> On 06/05/2020 07:54 PM, Zi Yan wrote:
>> On 4 Jun 2020, at 23:35, Anshuman Khandual wrote:
>>
>>> On 06/04/2020 10:19 PM, Zi Yan wrote:
>>>> On 4 Jun 2020, at 12:36, Matthew Wilcox wrote:
>>>>
>>>>> On Thu, Jun 04, 2020 at 09:51:10AM -0400, Zi Yan wrote:
>>>>>> On 4 Jun 2020, at 7:34, Matthew Wilcox wrote:
>>>>>>> On Thu, Jun 04, 2020 at 09:30:45AM +0530, Anshuman Khandual wrote=
:
>>>>>>>> +Quantifying Migration
>>>>>>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=

>>>>>>>> +Following events can be used to quantify page migration.
>>>>>>>> +
>>>>>>>> +- PGMIGRATE_SUCCESS
>>>>>>>> +- PGMIGRATE_FAIL
>>>>>>>> +- THP_MIGRATION_SUCCESS
>>>>>>>> +- THP_MIGRATION_FAILURE
>>>>>>>> +
>>>>>>>> +THP_MIGRATION_FAILURE in particular represents an event when a =
THP could not be
>>>>>>>> +migrated as a single entity following an allocation failure and=
 ended up getting
>>>>>>>> +split into constituent normal pages before being retried. This =
event, along with
>>>>>>>> +PGMIGRATE_SUCCESS and PGMIGRATE_FAIL will help in quantifying a=
nd analyzing THP
>>>>>>>> +migration events including both success and failure cases.
>>>>>>>
>>>>>>> First, I'd suggest running this paragraph through 'fmt'.  That wa=
y you
>>>>>>> don't have to care about line lengths.
>>>>>>>
>>>>>>> Second, this paragraph doesn't really explain what I need to know=
 to
>>>>>>> understand the meaning of these numbers.  When Linux attempts to =
migrate
>>>>>>> a THP, one of three things can happen:
>>>>>>>>>>>>>  - It is migrated as a single THP
>>>>>>>  - It is migrated, but had to be split
>>>>>>>  - Migration fails
>>>>>>>
>>>>>>> How do I turn these four numbers into an understanding of how oft=
en each
>>>>>>> of those three situations happen?  And why do we need four number=
s to
>>>>>>> report three situations?
>>>>>>>
>>>>>>> Or is there something else that can happen?  If so, I'd like that=
 explained
>>>>>>> here too ;-)
>>>>>>
>>>>>> PGMIGRATE_SUCCESS and PGMIGRATE_FAIL record a combination of diffe=
rent events,
>>>>>> so it is not easy to interpret them. Let me try to explain them.
>>>>>
>>>>> Thanks!  Very helpful explanation.
>>>>>
>>>>>> 1. migrating only base pages: PGMIGRATE_SUCCESS and PGMIGRATE_FAIL=
 just mean
>>>>>> these base pages are migrated and fail to migrate respectively.
>>>>>> THP_MIGRATION_SUCCESS and THP_MIGRATION_FAILURE should be 0 in thi=
s case.
>>>>>> Simple.
>>>>>>
>>>>>> 2. migrating only THPs:
>>>>>> 	- PGMIGRATE_SUCCESS means THPs that are migrated and base pages
>>>>>> 	(from the split of THPs) that are migrated,
>>>>>>
>>>>>> 	- PGMIGRATE_FAIL means THPs that fail to migrate and base pages t=
hat fail to migrated.
>>>>>>
>>>>>> 	- THP_MIGRATION_SUCCESS means THPs that are migrated.
>>>>>>
>>>>>> 	- THP_MIGRATION_FAILURE means THPs that are split.
>>>>>>
>>>>>> So PGMIGRATE_SUCCESS - THP_MIGRATION_SUCCESS means the number of m=
igrated base pages,
>>>>>> which are from the split of THPs.
>>>>>
>>>>> Are you sure about that?  If I split a THP and each of those subpag=
es
>>>>> migrates, won't I then see PGMIGRATE_SUCCESS increase by 512?
>>>>
>>>> That is what I mean. I guess my words did not work. I should have us=
ed subpages.
>>>>
>>>>>
>>>>>> When it comes to analyze failed migration, PGMIGRATE_FAIL - THP_MI=
GRATION_FAILURE
>>>>>> means the number of pages that are failed to migrate, but we canno=
t tell how many
>>>>>> are base pages and how many are THPs.
>>>>>>
>>>>>> 3. migrating base pages and THP:
>>>>>>
>>>>>> The math should be very similar to the second case, except that
>>>>>> a) from PGMIGRATE_SUCCESS - THP_MIGRATION_SUCCESS, we cannot tell =
how many are pages begin
>>>>>> as base pages and how many are pages begin as THPs but become base=
 pages after split;
>>>>>> b) from PGMIGRATE_FAIL - THP_MIGRATION_FAILURE, an additional case=
,
>>>>>> base pages that begin as base pages fail to migrate, is mixed into=
 the number and we
>>>>>> cannot tell three cases apart.
>>>>>
>>>>> So why don't we just expose PGMIGRATE_SPLIT?  That would be defined=
 as
>>>>> the number of times we succeeded in migrating a THP but had to spli=
t it
>>>>> to succeed.
>>>>
>>>> It might need extra code to get that number. Currently, the subpages=
 from split
>>>> THPs are appended to the end of the original page list, so we might =
need a separate
>>>> page list for these subpages to count PGMIGRATE_SPLIT. Also what if =
some of the
>>>> subpages fail to migrate? Do we increase PGMIGRATE_SPLIT or not?
>>>
>>> Thanks Zi, for such a detailed explanation. Ideally, we should separa=
te THP
>>> migration from base page migration in terms of statistics. PGMIGRATE_=
SUCCESS
>>> and PGMIGRATE_FAIL should continue to track statistics when migration=
 starts
>>> with base pages. But for THP, we should track the following events.
>>
>> You mean PGMIGRATE_SUCCESS and PGMIGRATE_FAIL will not track the numbe=
r of migrated subpages
>> from split THPs? Will it cause userspace issues since their semantics =
are changed?
>
> Yeah, basic idea is to carve out all THP migration related statistics f=
rom
> the normal page migration. Not sure if that might cause any issue for u=
ser
> space as you have mentioned. Does /proc/vmstat indicate some sort of an=
 ABI
> whose semantics can not really change ? Some more opinions here from ot=
hers
> would be helpful.
>
> The current situation is definitely bit problematic where PGMIGRATE_SUC=
CESS
> increments (+1) both for normal and successful THP migration. Same situ=
ation
> for PGMIGRATE_FAILURE as well. Hence, there are two clear choices avail=
able.
>
> 1. THP and normal page migration stats are separate and mutually exclus=
ive
>
> OR
>
> 2. THP migration has specific counters but normal page migration counte=
rs
>    still account for everything in THP migration in terms of normal pag=
es
>
> But IIUC, either way the current PGMIGRATE_SUCCESS or PGMIGRATE_FAIL st=
ats
> will change for the user as visible from /proc/vmstat.

Why? In the case 2, PGMIGRATE_SUCCESS and PGMIGRATE_FAIL would remain the=
 same
as today, right?

>
>>
>>>
>>> 1. THP_MIGRATION_SUCCESS 	- THP migration is successful, without spli=
t
>>> 2. THP_MIGRATION_FAILURE 	- THP could neither be migrated, nor be spl=
it
>>
>> They make sense to me.>
>>> 3. THP_MIGRATION_SPLIT_SUCCESS  - THP got split and all sub pages mig=
rated
>>> 4. THP_MIGRATION_SPLIT_FAILURE  - THP got split but all sub pages cou=
ld not be migrated
>>>
>>> THP_MIGRATION_SPLIT_FAILURE could either increment once for a single =
THP or
>>> number of subpages that did not get migrated after split. As you ment=
ioned,
>>> this will need some extra code in the core migration. Nonetheless, if=
 these
>>> new events look good, will be happy to make required changes.
>>
>> Maybe THP_MIGRATION_SPLIT would be simpler? My concern is that whether=
 we need such
>
> Also, it will not require a new migration queue tracking the split THP =
sub pages.
>
>> detailed information or not. Maybe trace points would be good enough f=
or 3 and 4.
>
> But without a separate queue for split THP subpages, will it be possibl=
e to track
> (3) and (4) through trace events ? Just wondering, where are the interc=
ept points.

Not easily. You could get a trace of the migration result and the physica=
l address
of individual page, whether each is a THP or not, and the split of a THP.=

You then can see which THP is split and what is the migration result of i=
ts subpages.
It is more analysis effort but less kernel code.

>
>> But if you think it is useful to you, feel free to implement them.
>
> Original idea was that, all stats here should give high level view but =
new upcoming
> trace events should help in details like which particular subpages coul=
d not be
> migrated resulting in a THP_MIGRATION_SPLIT_FAILURE increment etc.
>
>>
>> BTW, in terms of stats tracking, what do you think of my patch below? =
I am trying to
>> aggregate all stats counting in one place. Feel free to use it if you =
think it works
>> for you.
>
> Assume that, I could take the liberty to add your 'Signed-off-by' in ca=
se end up
> using this code chunk below. This seems to be going with option (2) as =
mentioned
> before.

Feel free to do so.

>
>>
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 7bfd0962149e..0f3c60470489 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1429,9 +1429,14 @@ int migrate_pages(struct list_head *from, new_p=
age_t get_new_page,
>>                 enum migrate_mode mode, int reason)
>>  {
>>         int retry =3D 1;
>> +       int thp_retry =3D 1;
>>         int nr_failed =3D 0;
>> +       int nr_thp_failed =3D 0;
>> +       int nr_thp_split =3D 0;
>>         int nr_succeeded =3D 0;
>> +       int nr_thp_succeeded =3D 0;
>>         int pass =3D 0;
>> +       bool is_thp =3D false;
>>         struct page *page;
>>         struct page *page2;
>>         int swapwrite =3D current->flags & PF_SWAPWRITE;
>> @@ -1440,11 +1445,13 @@ int migrate_pages(struct list_head *from, new_=
page_t get_new_page,
>>         if (!swapwrite)
>>                 current->flags |=3D PF_SWAPWRITE;
>>
>> -       for(pass =3D 0; pass < 10 && retry; pass++) {
>> +       for(pass =3D 0; pass < 10 && (retry || thp_retry); pass++) {
>
> 'thp_retry' check might not be necessary here as 'retry' already
> contains 'thp_retry'.

Right.
>
>>                 retry =3D 0;
>> +               thp_retry =3D 0;
>>
>>                 list_for_each_entry_safe(page, page2, from, lru) {
>>  retry:
>> +                       is_thp =3D PageTransHuge(page);
>>                         cond_resched();
>>
>>                         if (PageHuge(page))
>> @@ -1475,15 +1482,20 @@ int migrate_pages(struct list_head *from, new_=
page_t get_new_page,
>>                                         unlock_page(page);
>>                                         if (!rc) {
>>                                                 list_safe_reset_next(p=
age, page2, lru);
>> +                                               nr_thp_split++;
>>                                                 goto retry;
>>                                         }
>>                                 }
>
> Check 'if_thp' and increment 'nr_thp_failed' like 'default' case and
> also increment nr_failed by (1 << order) for the THP being migrated.

Right. hpage_nr_pages() would be better.

>
>
>>                                 nr_failed++;
>>                                 goto out;
>>                         case -EAGAIN:
>> +                               if (is_thp)
>> +                                       thp_retry++;
>>                                 retry++;
>>                                 break;
>>                         case MIGRATEPAGE_SUCCESS:
>> +                               if (is_thp)
>> +                                       nr_thp_succeeded++;
>
> Increment nr_succeeded by (1 << order) for the THP being migrated.
Ditto.

>
>>                                 nr_succeeded++;
>>                                 break;
>>                         default:
>> @@ -1493,18 +1505,27 @@ int migrate_pages(struct list_head *from, new_=
page_t get_new_page,
>>                                  * removed from migration page list an=
d not
>>                                  * retried in the next outer loop.
>>                                  */
>> +                               if (is_thp)
>> +                                       nr_thp_failed++;
>
> Increment nr_failed by (1 << order) for the THP being migrated.
Ditto.
>
>>                                 nr_failed++;
>>                                 break;
>>                         }
>>                 }
>>         }
>>         nr_failed +=3D retry;
>> +       nr_thp_failed +=3D thp_retry;
>>         rc =3D nr_failed;
>
> Right, nr_failed already contains nr_thp_failed. Hence need not change.=

>
>>         if (nr_succeeded)
>>                 count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
>>         if (nr_failed)
>>                 count_vm_events(PGMIGRATE_FAIL, nr_failed);
>> +       if (nr_thp_succeeded)
>> +               count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeede=
d);
>> +       if (nr_thp_failed)
>> +               count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
>> +       if (nr_thp_split)
>> +               count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
>>         trace_mm_migrate_pages(nr_succeeded, nr_failed, mode, reason);=

>
> This existing trace event should add stats for THP migration as well.

Sure.
>
>>
>>         if (!swapwrite)
>>
>
> Regardless, this change set (may be with some more modifications), make=
s sense if
> we decide to go with option (2), where existing normal page migration s=
tats will
> cover THP related stats as well. But it will be really great, if we get=
 some more
> opinions on this. Meanwhile, will continue looking into it further.

Thank you for working on this. :)

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_1EE9867F-54E5-40E0-8105-FA2C3B229A75_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl7gFeIPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKQ5MQAKZumzLWYY8yETk+9JzsCQ67nYKyLuoUdr4c
0sna/EHB9FElnfR8/whC+guZFEAGACze92SjuX9RBYHOF0f/yfpV6ChpkLalSe7c
PwNvVMo9L9bqB2yu92sQyNlw+OC2HnG/vXkXBMBRi/eV7vQFVmqqyTCjY2xjdR3o
b/61TOkuj1zxERU6mMTZOaqwflQvH8IAnfix/EALNvTDE/WFciRP/dmSjfrm2qj5
SdAMBWK8p5UKbYIP1x4rpUvXcLSA51cph2PETwTCGat+7Ew9uQ9/MT9DP6YkFGqU
FdTCdGAXBYKwbyugizSXxn0HsL3kGKZkDcBovyraLPAhPxKzLLzI3HuLIMmP3aUy
+IqVhJ0tIrgjl2AJXpnvALzsqCmVK9omY6ORHqJlYxRHkQJAb30dpDGRxL1hCOdf
1mEKVPZ3DO/1DzV0+2pNEZGu1TuOFTLk/ptud57n7AlkZ8jakjVi6V9rVd5D8Fr8
dvCFrr3yHzAEGSWRuhXlEW6HJQsi9Yn1wBKW1GK5xP/XpHav8WU2EKgFGNDN/UlD
aDpbosMLp0VfU8xbgAzOa+DtvopcUm+suNaCzhAzDfAkD3ItHg7q6Xmpe9jo+jP8
nuLUO2/Mxa8nr/aIHRXqEUZHOqCZU2ylrL25zddWwSb0gRSW7UpR5w0fRDkki+AY
VuFVtBIm
=bZj1
-----END PGP SIGNATURE-----

--=_MailMate_1EE9867F-54E5-40E0-8105-FA2C3B229A75_=--
