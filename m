Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648A1C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CAE1207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BjGYjixc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgIBUtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 16:49:13 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4842 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIBUtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 16:49:06 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5005340000>; Wed, 02 Sep 2020 13:48:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 02 Sep 2020 13:49:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 02 Sep 2020 13:49:06 -0700
Received: from [10.2.161.253] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 20:49:01 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     <linux-mm@kvack.org>, Roman Gushchin <guro@fb.com>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 01/16] mm: add pagechain container for storing
 multiple pages.
Date:   Wed, 2 Sep 2020 16:48:59 -0400
X-Mailer: MailMate (1.13.1r5705)
Message-ID: <57FD8627-2411-448B-9F0E-E4742CAF6C82@nvidia.com>
In-Reply-To: <5a91ac07-2c15-2e15-caec-5570bacf415b@infradead.org>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200902180628.4052244-2-zi.yan@sent.com>
 <5a91ac07-2c15-2e15-caec-5570bacf415b@infradead.org>
MIME-Version: 1.0
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_468D2D46-BBC2-4AE2-AEBE-C13C1109D934_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599079732; bh=Bnc1QocclEa0CaEoPiXV6Akeua3Riy/viDElinHY9lw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=BjGYjixcu/d8DuitSP+9BYHvVNmuPlesnvtO63FJ0MQjHNVIffDeXPAMCthoJX0uM
         +xu1H+DlXvjMNnQ2f+xynadcl7pTwoSlo5eqDx9hq643XnYJ9YFpgzuDlwcFKWTYvT
         sBj/HQz8ag7qq6/2x92diZ4e1y5lRE3dmg25LdmD6Ujtzk5guP7YOeDtCZMUjia6qK
         DmSffjoiS5YgHPG+zvZvK+FPmtoWWTFv5SFpLsD8vhPAue4n7hION0b2cgFq/ltlr0
         GY3kSDk9kpfEofRAp6pJ0dGLa+35Hxp2EXSGCDz+T6tk1ndXnSBFtr29ta9XhZ2dM1
         bdvtUllSbHqmA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_468D2D46-BBC2-4AE2-AEBE-C13C1109D934_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2 Sep 2020, at 16:29, Randy Dunlap wrote:

> On 9/2/20 11:06 AM, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> When depositing page table pages for 1GB THPs, we need 512 PTE pages +=

>> 1 PMD page. Instead of counting and depositing 513 pages, we can use t=
he
>> PMD page as a leader page and chain the rest 512 PTE pages with ->lru.=

>> This, however, prevents us depositing PMD pages with ->lru, which is
>> currently used by depositing PTE pages for 2MB THPs. So add a new
>> pagechain container for PMD pages.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  include/linux/pagechain.h | 73 ++++++++++++++++++++++++++++++++++++++=
+
>>  1 file changed, 73 insertions(+)
>>  create mode 100644 include/linux/pagechain.h
>>
>> diff --git a/include/linux/pagechain.h b/include/linux/pagechain.h
>> new file mode 100644
>> index 000000000000..be536142b413
>> --- /dev/null
>> +++ b/include/linux/pagechain.h
>> @@ -0,0 +1,73 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * include/linux/pagechain.h
>> + *
>> + * In many places it is efficient to batch an operation up against mu=
ltiple
>> + * pages. A pagechain is a multipage container which is used for that=
=2E
>> + */
>> +
>> +#ifndef _LINUX_PAGECHAIN_H
>> +#define _LINUX_PAGECHAIN_H
>> +
>> +#include <linux/slab.h>
>> +
>> +/* 14 pointers + two long's align the pagechain structure to a power =
of two */
>> +#define PAGECHAIN_SIZE	13
>
> OK, I'll bite.  I see neither 14 pointers nor 2 longs below.
> Is the comment out of date or am I just confuzed?
>
> Update: struct list_head is 2 pointers, so I see 15 pointers & one unsi=
gned int.
> Where are the 2 longs?

My bad. Will change this to:

/* 15 pointers + one long align the pagechain structure to a power of two=
 */
#define PAGECHAIN_SIZE  13

struct page;

struct pagechain {
    struct list_head list;
    unsigned long nr;
    struct page *pages[PAGECHAIN_SIZE];
};


Thanks for checking.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_468D2D46-BBC2-4AE2-AEBE-C13C1109D934_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl9QBTsPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKqRsQAId/jV9PpVTmeiDgUZA5dsaQ6pGR4X7LNpOB
IkfXIwZYANfQviqFP3hjyfK2W07nLEXDUEXNu2XYBxoCXh7MCrkbv90Oqtj8874I
j/q6AeWZFketB4Fk88EBdbGt9NyV7uh2lg5WERawznBHwQVXM9eC8jHt9eL0bNHk
2o2JJiK18e2WtbGySUDwzF0MiDWpkzG/8jFpKzPPOmfon3QijPFlePfbt/2cdXcn
+uOL+c50StvNqDnFN2xz0Rh6BiRsrrUbHzWn3LqtktlPYqeIIx0CUK3JPqZwqQ8g
8TZYeMZtESKn6bBCQwK+wzW/aAbHIMNlYxrZwjE1camp3XVdMB7skqgh8eIji9eO
WAhjfyBOlxsQtvSWz2ruENNiICjvDH0TPbab8dJz0bQX6SCqZuvziTYdUXcuwNxY
Tjim6E1tcI14AxR4mFw7YqVd8v21Pddna/JF6vE0pY7wEK2hHgWdqVAwcT7Zyv27
WzXSepDRCI1l1ObEMX0+w+KsjT8i/eJcd9KlerTJFchpnyHORLxy2zpKCwlvV6Hl
JVsc4FccsvJehCBCQ7wAC9KpCuuzaqY7rhLq0SmRZOyI0f7F2zTunNbf1bAVqRn0
8T3ytJncHj2OBYrtYK43KhwgRFBjLZxGzZZZ6dfqsXlnYCZ3wpeESR0np0Jf19fU
HB0z5jiI
=nvIn
-----END PGP SIGNATURE-----

--=_MailMate_468D2D46-BBC2-4AE2-AEBE-C13C1109D934_=--
