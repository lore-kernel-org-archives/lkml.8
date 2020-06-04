Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDCFC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EDA620772
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="S3MN2CsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgFDNvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 09:51:21 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12117 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbgFDNvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 09:51:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed8fc490000>; Thu, 04 Jun 2020 06:51:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 04 Jun 2020 06:51:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 04 Jun 2020 06:51:17 -0700
Received: from [172.16.126.1] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Jun
 2020 13:51:12 +0000
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
Date:   Thu, 4 Jun 2020 09:51:10 -0400
X-Mailer: MailMate (1.13.1r5690)
Message-ID: <CBF71911-6BB7-4AA7-AC0F-95AADBB45569@nvidia.com>
In-Reply-To: <20200604113421.GU19604@bombadil.infradead.org>
References: <1591243245-23052-1-git-send-email-anshuman.khandual@arm.com>
 <20200604113421.GU19604@bombadil.infradead.org>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_14682522-75A2-44FC-BE91-C7DBFB196D9A_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591278665; bh=xnhPaiMqqc4nlbRrKLrmALj0c7s6CIZKia+CcF/YPpg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=S3MN2CsQUiEvFN5+1jL+Zo/1bslDttFUozBGhY/MwWr4Uc9fjzUkb7MmkmMH8Jh8T
         tVRzph8vB5Z3saQ//E68PRXPoIkXGcyoOMuWmwrSf4KhUl3hTBb2kgDyLuVEXTB9GG
         jmLEJkCdv2SxZDI7uzeXdTsF7T9ATYYmQs/y3sRjKqfzkDkosM1LOKS9mnR1TuqSJB
         JAz0X0rIZGHQQs/kUoDuZ2RSX9q4DOr9rkXRtcno3fL4paydagkZy5pO/khO7RNc3q
         MkBhoz0hKvalQQu6vvZnq0BMU37OcRd9nkpxMqFdH3MK01hpfL/QrLQ7TXCKGaM3fO
         K5FJVxs86atAw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_14682522-75A2-44FC-BE91-C7DBFB196D9A_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 4 Jun 2020, at 7:34, Matthew Wilcox wrote:

> On Thu, Jun 04, 2020 at 09:30:45AM +0530, Anshuman Khandual wrote:
>> Add the following new VM events which will help in validating THP migr=
ation
>> without split. Statistics reported through these new events will help =
in
>> performance debugging.
>>
>> 1. THP_MIGRATION_SUCCESS
>> 2. THP_MIGRATION_FAILURE
>>
>> THP_MIGRATION_FAILURE in particular represents an event when a THP cou=
ld
>> not be migrated as a single entity following an allocation failure and=

>> ended up getting split into constituent normal pages before being retr=
ied.
>> This event, along with PGMIGRATE_SUCCESS and PGMIGRATE_FAIL will help =
in
>> quantifying and analyzing THP migration events including both success =
and
>> failure cases.
>
>> +Quantifying Migration
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +Following events can be used to quantify page migration.
>> +
>> +- PGMIGRATE_SUCCESS
>> +- PGMIGRATE_FAIL
>> +- THP_MIGRATION_SUCCESS
>> +- THP_MIGRATION_FAILURE
>> +
>> +THP_MIGRATION_FAILURE in particular represents an event when a THP co=
uld not be
>> +migrated as a single entity following an allocation failure and ended=
 up getting
>> +split into constituent normal pages before being retried. This event,=
 along with
>> +PGMIGRATE_SUCCESS and PGMIGRATE_FAIL will help in quantifying and ana=
lyzing THP
>> +migration events including both success and failure cases.
>
> First, I'd suggest running this paragraph through 'fmt'.  That way you
> don't have to care about line lengths.
>
> Second, this paragraph doesn't really explain what I need to know to
> understand the meaning of these numbers.  When Linux attempts to migrat=
e
> a THP, one of three things can happen:
>
>  - It is migrated as a single THP
>  - It is migrated, but had to be split
>  - Migration fails
>
> How do I turn these four numbers into an understanding of how often eac=
h
> of those three situations happen?  And why do we need four numbers to
> report three situations?
>
> Or is there something else that can happen?  If so, I'd like that expla=
ined
> here too ;-)

PGMIGRATE_SUCCESS and PGMIGRATE_FAIL record a combination of different ev=
ents,
so it is not easy to interpret them. Let me try to explain them.

1. migrating only base pages: PGMIGRATE_SUCCESS and PGMIGRATE_FAIL just m=
ean
these base pages are migrated and fail to migrate respectively.
THP_MIGRATION_SUCCESS and THP_MIGRATION_FAILURE should be 0 in this case.=

Simple.

2. migrating only THPs:
	- PGMIGRATE_SUCCESS means THPs that are migrated and base pages
	(from the split of THPs) that are migrated,

	- PGMIGRATE_FAIL means THPs that fail to migrate and base pages that fai=
l to migrated.

	- THP_MIGRATION_SUCCESS means THPs that are migrated.

	- THP_MIGRATION_FAILURE means THPs that are split.

So PGMIGRATE_SUCCESS - THP_MIGRATION_SUCCESS means the number of migrated=
 base pages,
which are from the split of THPs.

When it comes to analyze failed migration, PGMIGRATE_FAIL - THP_MIGRATION=
_FAILURE
means the number of pages that are failed to migrate, but we cannot tell =
how many
are base pages and how many are THPs.

3. migrating base pages and THP:

The math should be very similar to the second case, except that
a) from PGMIGRATE_SUCCESS - THP_MIGRATION_SUCCESS, we cannot tell how man=
y are pages begin
as base pages and how many are pages begin as THPs but become base pages =
after split;
b) from PGMIGRATE_FAIL - THP_MIGRATION_FAILURE, an additional case,
base pages that begin as base pages fail to migrate, is mixed into the nu=
mber and we
cannot tell three cases apart.


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_14682522-75A2-44FC-BE91-C7DBFB196D9A_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl7Y/E4PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK7G8P/1ZGboP8MJmRB4+p9ksu5Rhm/fbibfPmfc3O
DjG91b5FNmUqHNcsX28SJnBIREoDooqB0sZFrpOkKTMm71Ej+4eSgKqBG/hN32WT
cvLYkjN2CWrKYaIx+HpDcD4dFHYo+7Kwg1JdB2/ex6+Hm6JVsskgU6i7cqqpmwHD
1JhbA0liWiuEPHrOEULNeEXhqi6V0JEQguwv9r13puBzl79dx6C8lcrxeMEQ7gIj
KkQUhSECoovqEb6qpZLNT2iyFCFDiZFxS+ovwsVySZqyUawDi417aV2ER54pDKXt
SW75Fr6sbc+BEhRz8fbsNjHLdLtEqGGESvzyDOyTBoOFVjwQSs6MZTeaCe/m0tj+
KrnFuCcFf/B3KDjFpdDfB+5Lrzo6S4ceROHcEc2P3GYVMqHMor64azQ1i7y/ungD
3eMHZeeWZ55X9OGju5lMy3luiiNpGyoNLJlECFAxhwPvhdlTKv0pm4ka4NprT44C
LetY91kKJ8g/9fHqIp8g5iyIOn/4/hpouVShgDyqRjmPb+78ebDrcI0OxaWfQ0aE
Do4n8MpKpFBC6YIpytyOCMdsN2tykGxuckMj33F8VefTcmZFUpiwAq89KIjdLLZG
Ic1l7rYI+ra98HJJciXM1+faErDwOvmoC19yhXpFHmYrEB2UC3F1Wau7F0yk0l8I
Q3gJljBr
=Rphb
-----END PGP SIGNATURE-----

--=_MailMate_14682522-75A2-44FC-BE91-C7DBFB196D9A_=--
