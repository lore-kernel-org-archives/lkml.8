Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58897C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2545F2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kKv/L7vB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbgFDQtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:49:20 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16418 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729115AbgFDQtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:49:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed925b70001>; Thu, 04 Jun 2020 09:47:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 04 Jun 2020 09:49:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 04 Jun 2020 09:49:19 -0700
Received: from [10.2.160.11] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Jun
 2020 16:49:14 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Anshuman Khandual <anshuman.khandual@arm.com>,
        <linux-mm@kvack.org>, <hughd@google.com>,
        <daniel.m.jordan@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] mm/vmstat: Add events for THP migration without split
Date:   Thu, 4 Jun 2020 12:49:11 -0400
X-Mailer: MailMate (1.13.1r5690)
Message-ID: <2735DD7E-0DBF-428B-AAD8-FC6DAAA9CB1E@nvidia.com>
In-Reply-To: <20200604163657.GV19604@bombadil.infradead.org>
References: <1591243245-23052-1-git-send-email-anshuman.khandual@arm.com>
 <20200604113421.GU19604@bombadil.infradead.org>
 <CBF71911-6BB7-4AA7-AC0F-95AADBB45569@nvidia.com>
 <20200604163657.GV19604@bombadil.infradead.org>
MIME-Version: 1.0
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_A4ED6843-C123-4162-A906-90C702BB03B0_=";
        micalg=pgp-sha1; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591289271; bh=9jxqYKYmUi9T0lPIKiYfQvc0KSyKz1JyLr8UsgVX//U=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=kKv/L7vBPBk/l0nuxQ5lowYaWiWMkd5IZAdWsHsnLGwjCX8nhvkvd/e6jMBgGYx9a
         X/KL22UIparl4xy1Fn2WKXAIX7si0cH8oomJGB41zCHir5soIDK9SLqyno5+kntpZ7
         DIF1YZHKPyBEkOMWXPb66+ylN1YVnrNA6ZZboiFcRPMUAGL1yD1Mz1d2wS+Jz1R8oI
         cBY9u3XtYoGDEmlFyr7372w4u6GbEBF/oXtQZldBfZZeWXjX/+4K5ADBRNFqVtRXk8
         jZDh4nVnLGLCUGrYr6epvArrR/534qDIijE3FdUrBhZP18r2tGekEwIyElYpcA6Ifp
         aLPolhPycoppQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_A4ED6843-C123-4162-A906-90C702BB03B0_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 4 Jun 2020, at 12:36, Matthew Wilcox wrote:

> On Thu, Jun 04, 2020 at 09:51:10AM -0400, Zi Yan wrote:
>> On 4 Jun 2020, at 7:34, Matthew Wilcox wrote:
>>> On Thu, Jun 04, 2020 at 09:30:45AM +0530, Anshuman Khandual wrote:
>>>> +Quantifying Migration
>>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> +Following events can be used to quantify page migration.
>>>> +
>>>> +- PGMIGRATE_SUCCESS
>>>> +- PGMIGRATE_FAIL
>>>> +- THP_MIGRATION_SUCCESS
>>>> +- THP_MIGRATION_FAILURE
>>>> +
>>>> +THP_MIGRATION_FAILURE in particular represents an event when a THP =
could not be
>>>> +migrated as a single entity following an allocation failure and end=
ed up getting
>>>> +split into constituent normal pages before being retried. This even=
t, along with
>>>> +PGMIGRATE_SUCCESS and PGMIGRATE_FAIL will help in quantifying and a=
nalyzing THP
>>>> +migration events including both success and failure cases.
>>>
>>> First, I'd suggest running this paragraph through 'fmt'.  That way yo=
u
>>> don't have to care about line lengths.
>>>
>>> Second, this paragraph doesn't really explain what I need to know to
>>> understand the meaning of these numbers.  When Linux attempts to migr=
ate
>>> a THP, one of three things can happen:
>>>
>>>  - It is migrated as a single THP
>>>  - It is migrated, but had to be split
>>>  - Migration fails
>>>
>>> How do I turn these four numbers into an understanding of how often e=
ach
>>> of those three situations happen?  And why do we need four numbers to=

>>> report three situations?
>>>
>>> Or is there something else that can happen?  If so, I'd like that exp=
lained
>>> here too ;-)
>>
>> PGMIGRATE_SUCCESS and PGMIGRATE_FAIL record a combination of different=
 events,
>> so it is not easy to interpret them. Let me try to explain them.
>
> Thanks!  Very helpful explanation.
>
>> 1. migrating only base pages: PGMIGRATE_SUCCESS and PGMIGRATE_FAIL jus=
t mean
>> these base pages are migrated and fail to migrate respectively.
>> THP_MIGRATION_SUCCESS and THP_MIGRATION_FAILURE should be 0 in this ca=
se.
>> Simple.
>>
>> 2. migrating only THPs:
>> 	- PGMIGRATE_SUCCESS means THPs that are migrated and base pages
>> 	(from the split of THPs) that are migrated,
>>
>> 	- PGMIGRATE_FAIL means THPs that fail to migrate and base pages that =
fail to migrated.
>>
>> 	- THP_MIGRATION_SUCCESS means THPs that are migrated.
>>
>> 	- THP_MIGRATION_FAILURE means THPs that are split.
>>
>> So PGMIGRATE_SUCCESS - THP_MIGRATION_SUCCESS means the number of migra=
ted base pages,
>> which are from the split of THPs.
>
> Are you sure about that?  If I split a THP and each of those subpages
> migrates, won't I then see PGMIGRATE_SUCCESS increase by 512?

That is what I mean. I guess my words did not work. I should have used su=
bpages.

>
>> When it comes to analyze failed migration, PGMIGRATE_FAIL - THP_MIGRAT=
ION_FAILURE
>> means the number of pages that are failed to migrate, but we cannot te=
ll how many
>> are base pages and how many are THPs.
>>
>> 3. migrating base pages and THP:
>>
>> The math should be very similar to the second case, except that
>> a) from PGMIGRATE_SUCCESS - THP_MIGRATION_SUCCESS, we cannot tell how =
many are pages begin
>> as base pages and how many are pages begin as THPs but become base pag=
es after split;
>> b) from PGMIGRATE_FAIL - THP_MIGRATION_FAILURE, an additional case,
>> base pages that begin as base pages fail to migrate, is mixed into the=
 number and we
>> cannot tell three cases apart.
>
> So why don't we just expose PGMIGRATE_SPLIT?  That would be defined as
> the number of times we succeeded in migrating a THP but had to split it=

> to succeed.

It might need extra code to get that number. Currently, the subpages from=
 split
THPs are appended to the end of the original page list, so we might need =
a separate
page list for these subpages to count PGMIGRATE_SPLIT. Also what if some =
of the
subpages fail to migrate? Do we increase PGMIGRATE_SPLIT or not?



--
Best Regards,
Yan Zi

--=_MailMate_A4ED6843-C123-4162-A906-90C702BB03B0_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBAgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl7ZJgcPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKufkP/3J8Y37r2ENRwdN/0rs8ooTU6ZNJfhnmKoPA
pPHcJkXZQrJSYULulx/9lbEuH/dpCM5o917iQQz6eWO+ZCAsRMjkJZ3mEVOXcOka
fd8/d6/d3fE8BxcKe1E4xwDWNQFv1xwaDJl/OBQqeuHNjFz5Dy8zl4a1o3AqVDwu
WePQA+rrzQXNnFwxJuFtujSJGxR+KZAuDFipoBVJ3hu2hLQgCg0zV8rC7HgkSo/V
kddiqdahY+jvDaNCsK69bSLXEBWjzO7tpcMGEaXkrMAS2wOjrt1Hr15FyD4n33t8
r4R+Te9hbxtedTaxCEuIPk9ZaYkGiG2dHBVyMCEYWQZpKJ73Z+KnVzYu3thHu5PK
eh4fmU6swgUISSvBvZ7MAKviKTSWYvvKuOauLHYuKF8EeZ1ByhFga73DsybJJA4P
bKrFQi0a/v1fbh41BOvXrriZawxUtTXedfjKnc/TYDKJrzKKsKjpJ0DSyvUTblX/
c6waIJIsfRrnFvwHee0oe0332bk0h1lrurxudM4L8qhYGlr13Nm3epukeID6YxR8
V+QU4NcUiVWE64UchjIl2BinZ7gu2QE3KAd+O0EFSG8D0vaqVtZnwqPrxfxWt2AF
Yi2PFQxTZ73HHPWpZ93jxpBRWcviWjXffjgkiis/NT7wyBrfWvgB8Vf3Z3DtPiqr
uTIsy4Cn
=U2ps
-----END PGP SIGNATURE-----

--=_MailMate_A4ED6843-C123-4162-A906-90C702BB03B0_=--
