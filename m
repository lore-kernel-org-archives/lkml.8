Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56EBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF92F20663
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fxe9u6kh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbgFEOYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:24:19 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16400 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbgFEOYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:24:11 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eda55320000>; Fri, 05 Jun 2020 07:22:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 05 Jun 2020 07:24:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 05 Jun 2020 07:24:11 -0700
Received: from [10.2.165.41] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Jun
 2020 14:24:05 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
CC:     Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <hughd@google.com>, <daniel.m.jordan@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] mm/vmstat: Add events for THP migration without split
Date:   Fri, 5 Jun 2020 10:24:03 -0400
X-Mailer: MailMate (1.13.1r5690)
Message-ID: <890AA27D-29BA-45A9-B868-5533645D73D5@nvidia.com>
In-Reply-To: <9e4acb98-c9fd-a998-03b3-38947cf61bd9@arm.com>
References: <1591243245-23052-1-git-send-email-anshuman.khandual@arm.com>
 <20200604113421.GU19604@bombadil.infradead.org>
 <CBF71911-6BB7-4AA7-AC0F-95AADBB45569@nvidia.com>
 <20200604163657.GV19604@bombadil.infradead.org>
 <2735DD7E-0DBF-428B-AAD8-FC6DAAA9CB1E@nvidia.com>
 <9e4acb98-c9fd-a998-03b3-38947cf61bd9@arm.com>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_5668B8FE-2BF9-4763-AE2B-2B434AABB132_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591366962; bh=bGum21iIYvkCRjYyGHObBLXtcMZVn88CB45dQfPvG9w=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=fxe9u6khtSqLi1h/vDUqooF2QYuW/I0EXKsdDtWcWPOHKMb3D5do2bHtcjV7PKKr6
         4BbqPPuTNILMc7xJkHPIM2woGJNMcIpAZTVaUmcDxSOEU9p6CNbZW8sSDIUb5zdWjS
         zFJBxTup0sr9eDgWUP8Wi2Z1JuBpuKwBziSJLiBlHy/9NDNlhRZxmZPVqJLVpbJ651
         WwziC1mBlfXGqiE0sPuC5GG1hS6000XFSXNmF6W1WAxcZkJpAlaB4lTiBOqBhCvllJ
         Dsa9+Kp3Js9bBSwyt3j32z1cnVcRBy4vPhoAeXfM8x96Z1gBCl7rCWN1SYbNuNIY+M
         sY6+q4jeM384w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_5668B8FE-2BF9-4763-AE2B-2B434AABB132_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 4 Jun 2020, at 23:35, Anshuman Khandual wrote:

> On 06/04/2020 10:19 PM, Zi Yan wrote:
>> On 4 Jun 2020, at 12:36, Matthew Wilcox wrote:
>>
>>> On Thu, Jun 04, 2020 at 09:51:10AM -0400, Zi Yan wrote:
>>>> On 4 Jun 2020, at 7:34, Matthew Wilcox wrote:
>>>>> On Thu, Jun 04, 2020 at 09:30:45AM +0530, Anshuman Khandual wrote:
>>>>>> +Quantifying Migration
>>>>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>> +Following events can be used to quantify page migration.
>>>>>> +
>>>>>> +- PGMIGRATE_SUCCESS
>>>>>> +- PGMIGRATE_FAIL
>>>>>> +- THP_MIGRATION_SUCCESS
>>>>>> +- THP_MIGRATION_FAILURE
>>>>>> +
>>>>>> +THP_MIGRATION_FAILURE in particular represents an event when a TH=
P could not be
>>>>>> +migrated as a single entity following an allocation failure and e=
nded up getting
>>>>>> +split into constituent normal pages before being retried. This ev=
ent, along with
>>>>>> +PGMIGRATE_SUCCESS and PGMIGRATE_FAIL will help in quantifying and=
 analyzing THP
>>>>>> +migration events including both success and failure cases.
>>>>>
>>>>> First, I'd suggest running this paragraph through 'fmt'.  That way =
you
>>>>> don't have to care about line lengths.
>>>>>
>>>>> Second, this paragraph doesn't really explain what I need to know t=
o
>>>>> understand the meaning of these numbers.  When Linux attempts to mi=
grate
>>>>> a THP, one of three things can happen:
>>>>>
>>>>>  - It is migrated as a single THP
>>>>>  - It is migrated, but had to be split
>>>>>  - Migration fails
>>>>>
>>>>> How do I turn these four numbers into an understanding of how often=
 each
>>>>> of those three situations happen?  And why do we need four numbers =
to
>>>>> report three situations?
>>>>>
>>>>> Or is there something else that can happen?  If so, I'd like that e=
xplained
>>>>> here too ;-)
>>>>
>>>> PGMIGRATE_SUCCESS and PGMIGRATE_FAIL record a combination of differe=
nt events,
>>>> so it is not easy to interpret them. Let me try to explain them.
>>>
>>> Thanks!  Very helpful explanation.
>>>
>>>> 1. migrating only base pages: PGMIGRATE_SUCCESS and PGMIGRATE_FAIL j=
ust mean
>>>> these base pages are migrated and fail to migrate respectively.
>>>> THP_MIGRATION_SUCCESS and THP_MIGRATION_FAILURE should be 0 in this =
case.
>>>> Simple.
>>>>
>>>> 2. migrating only THPs:
>>>> 	- PGMIGRATE_SUCCESS means THPs that are migrated and base pages
>>>> 	(from the split of THPs) that are migrated,
>>>>
>>>> 	- PGMIGRATE_FAIL means THPs that fail to migrate and base pages tha=
t fail to migrated.
>>>>
>>>> 	- THP_MIGRATION_SUCCESS means THPs that are migrated.
>>>>
>>>> 	- THP_MIGRATION_FAILURE means THPs that are split.
>>>>
>>>> So PGMIGRATE_SUCCESS - THP_MIGRATION_SUCCESS means the number of mig=
rated base pages,
>>>> which are from the split of THPs.
>>>
>>> Are you sure about that?  If I split a THP and each of those subpages=

>>> migrates, won't I then see PGMIGRATE_SUCCESS increase by 512?
>>
>> That is what I mean. I guess my words did not work. I should have used=
 subpages.
>>
>>>
>>>> When it comes to analyze failed migration, PGMIGRATE_FAIL - THP_MIGR=
ATION_FAILURE
>>>> means the number of pages that are failed to migrate, but we cannot =
tell how many
>>>> are base pages and how many are THPs.
>>>>
>>>> 3. migrating base pages and THP:
>>>>
>>>> The math should be very similar to the second case, except that
>>>> a) from PGMIGRATE_SUCCESS - THP_MIGRATION_SUCCESS, we cannot tell ho=
w many are pages begin
>>>> as base pages and how many are pages begin as THPs but become base p=
ages after split;
>>>> b) from PGMIGRATE_FAIL - THP_MIGRATION_FAILURE, an additional case,
>>>> base pages that begin as base pages fail to migrate, is mixed into t=
he number and we
>>>> cannot tell three cases apart.
>>>
>>> So why don't we just expose PGMIGRATE_SPLIT?  That would be defined a=
s
>>> the number of times we succeeded in migrating a THP but had to split =
it
>>> to succeed.
>>
>> It might need extra code to get that number. Currently, the subpages f=
rom split
>> THPs are appended to the end of the original page list, so we might ne=
ed a separate
>> page list for these subpages to count PGMIGRATE_SPLIT. Also what if so=
me of the
>> subpages fail to migrate? Do we increase PGMIGRATE_SPLIT or not?
>
> Thanks Zi, for such a detailed explanation. Ideally, we should separate=
 THP
> migration from base page migration in terms of statistics. PGMIGRATE_SU=
CCESS
> and PGMIGRATE_FAIL should continue to track statistics when migration s=
tarts
> with base pages. But for THP, we should track the following events.

You mean PGMIGRATE_SUCCESS and PGMIGRATE_FAIL will not track the number o=
f migrated subpages
from split THPs? Will it cause userspace issues since their semantics are=
 changed?

>
> 1. THP_MIGRATION_SUCCESS 	- THP migration is successful, without split
> 2. THP_MIGRATION_FAILURE 	- THP could neither be migrated, nor be split=


They make sense to me.

> 3. THP_MIGRATION_SPLIT_SUCCESS  - THP got split and all sub pages migra=
ted
> 4. THP_MIGRATION_SPLIT_FAILURE  - THP got split but all sub pages could=
 not be migrated
>
> THP_MIGRATION_SPLIT_FAILURE could either increment once for a single TH=
P or
> number of subpages that did not get migrated after split. As you mentio=
ned,
> this will need some extra code in the core migration. Nonetheless, if t=
hese
> new events look good, will be happy to make required changes.

Maybe THP_MIGRATION_SPLIT would be simpler? My concern is that whether we=
 need such
detailed information or not. Maybe trace points would be good enough for =
3 and 4.
But if you think it is useful to you, feel free to implement them.

BTW, in terms of stats tracking, what do you think of my patch below? I a=
m trying to
aggregate all stats counting in one place. Feel free to use it if you thi=
nk it works
for you.


diff --git a/mm/migrate.c b/mm/migrate.c
index 7bfd0962149e..0f3c60470489 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1429,9 +1429,14 @@ int migrate_pages(struct list_head *from, new_page=
_t get_new_page,
                enum migrate_mode mode, int reason)
 {
        int retry =3D 1;
+       int thp_retry =3D 1;
        int nr_failed =3D 0;
+       int nr_thp_failed =3D 0;
+       int nr_thp_split =3D 0;
        int nr_succeeded =3D 0;
+       int nr_thp_succeeded =3D 0;
        int pass =3D 0;
+       bool is_thp =3D false;
        struct page *page;
        struct page *page2;
        int swapwrite =3D current->flags & PF_SWAPWRITE;
@@ -1440,11 +1445,13 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
        if (!swapwrite)
                current->flags |=3D PF_SWAPWRITE;

-       for(pass =3D 0; pass < 10 && retry; pass++) {
+       for(pass =3D 0; pass < 10 && (retry || thp_retry); pass++) {
                retry =3D 0;
+               thp_retry =3D 0;

                list_for_each_entry_safe(page, page2, from, lru) {
 retry:
+                       is_thp =3D PageTransHuge(page);
                        cond_resched();

                        if (PageHuge(page))
@@ -1475,15 +1482,20 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
                                        unlock_page(page);
                                        if (!rc) {
                                                list_safe_reset_next(page=
, page2, lru);
+                                               nr_thp_split++;
                                                goto retry;
                                        }
                                }
                                nr_failed++;
                                goto out;
                        case -EAGAIN:
+                               if (is_thp)
+                                       thp_retry++;
                                retry++;
                                break;
                        case MIGRATEPAGE_SUCCESS:
+                               if (is_thp)
+                                       nr_thp_succeeded++;
                                nr_succeeded++;
                                break;
                        default:
@@ -1493,18 +1505,27 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
                                 * removed from migration page list and n=
ot
                                 * retried in the next outer loop.
                                 */
+                               if (is_thp)
+                                       nr_thp_failed++;
                                nr_failed++;
                                break;
                        }
                }
        }
        nr_failed +=3D retry;
+       nr_thp_failed +=3D thp_retry;
        rc =3D nr_failed;
 out:
        if (nr_succeeded)
                count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
        if (nr_failed)
                count_vm_events(PGMIGRATE_FAIL, nr_failed);
+       if (nr_thp_succeeded)
+               count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);=

+       if (nr_thp_failed)
+               count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
+       if (nr_thp_split)
+               count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
        trace_mm_migrate_pages(nr_succeeded, nr_failed, mode, reason);

        if (!swapwrite)


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_5668B8FE-2BF9-4763-AE2B-2B434AABB132_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl7aVYMPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKZ7AQAIYwKTJC6JaWsTU0mqwLJt5Jr8udBGGcl772
k1qpsv0HjkNMRNS3dWGgvdVnBkunKp5rJlXdXPmEy0qvgNafa2vYgMFZql1O/brF
s7vGXByT5dyHbrt2TaGv+clr+CEfk6gT3QDFJ+HeZn2Q92SRlIe4Ife0mAOwKHiU
t2KZ4ZUYU1NM4P/9ab0Da55NhP+4Y4Fvs14LxKdc+8OokssA/+02BAQz2WI74D8d
d4l5IbQU6faj9nhdwRc2pmWpFXFEp3CQomwyGkYWeU1k5VEz43MU0sM3pR2yltzc
Jizh5XalnUGr9QY6S9hWRSiv5k7Ma2XJUtH3xfWnvDB3vAUtQdZGz5LRzOJ9ECcg
kT5o9Skw7x60wDFw1UPyPDpH8pLNmsDuxmij3h18OyzJJl5hYGIqNwfxMwxrua9n
mXyhTyNwSbf5XKvhaYcJKQpkW4R0YTmljHXufa9bnv73/70vfzJM/y1s0F1Fsnsq
r0qeDPrjiyirNNNMcDUZcXrZDllN2IxbMfnfhr20DpCdtpQWFObKSMdhWijdNGdR
2NMpqIiUGOnKqSCtocQmxc5Gl5kwebHnJGb5mRJF9dW5g6Po4hgbLOdCgD2yKhOR
SuUGKGsf3ob8hFji+pK8YWq37jC+GZbYUAn+Kk7BRoVfnzx8F5/hLhOPoH1WQZhk
P4TEXsH1
=suKQ
-----END PGP SIGNATURE-----

--=_MailMate_5668B8FE-2BF9-4763-AE2B-2B434AABB132_=--
