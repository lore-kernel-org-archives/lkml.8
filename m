Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D47C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 05:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B96C20720
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 05:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NextfourGroupOy.onmicrosoft.com header.i=@NextfourGroupOy.onmicrosoft.com header.b="cVlW7Zy4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgGJF3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 01:29:17 -0400
Received: from mail-eopbgr40066.outbound.protection.outlook.com ([40.107.4.66]:28007
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725943AbgGJF3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 01:29:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXDrG2ezDhJflQgN/KKf/atXdfFzGhGqsdZ9sIg529OSTJlvHY6sIPy+j2SLqWsykk0UYDTaS7dluyW/THSlCtmgRynNnHtwzgjI0mx/LyasCE1FyFDJrQzuzijbjep+jGKH7XH3Bv3s30ObfwLVXEDMKJmWDtNvVz1LmCv0jvrmCoNaM3HlOLJ5oKay2VqimnStREhhcDzenZIkUUgQA789IJSbP0UQzALhztE0txxtD9hUVrnntt5iCY6xbf4LQigUWXtoR1/Ml3XS6RHpGLb5ifxpGK3i0YEjLZ/K2V5tgwlHuK/EMXGY4P5hiOfcp0y2qQZIHL5pdWYGshJDUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VjAOnnwrQY8+YyBP4uoe7/omMgsbxGUC+29+Ul5Flc=;
 b=CoGNH4O0SxMOgFwaTqNf5o91S0qYEUeQWNYDLHiBewGO6OKLSDVydCm9fF/1yiTE2MjFUcI/Zyg9kOE8tIBpXnloyzbYaGaOcr+YDUHWjaYp9s3V574ETVgnPk7KSjdYUoaSxIX1I6brkI5H+bAb/e/CxeMWVPkpd+NWFjKlYNytmKvB/fNLqZdvmW26kfSh71T7+7EyTYi4QMsEt0/OwJ5dV6/BJV5pVHVJHmSyMg0uPtDSJcpD9w1aIy1k5L0XcyQqdkEEeavLEH9qcJBc5PDrioV/qX2aUWNyEKcbhoyehM5njwFhxvO/gEahThnPJlq8Az2TtbG86fD1d4izVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nextfour.com; dmarc=pass action=none header.from=nextfour.com;
 dkim=pass header.d=nextfour.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NextfourGroupOy.onmicrosoft.com;
 s=selector2-NextfourGroupOy-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VjAOnnwrQY8+YyBP4uoe7/omMgsbxGUC+29+Ul5Flc=;
 b=cVlW7Zy4uNUB53rJ/0giUdOGr66TvlgAEu9Mkl43bDZ+7VvGnr6ByS8nik+mCyn2rRRIBH+c+4Ay1RNXS4IGnYkaeG2c0T2TgJmG4q9jroSsgT30pRALOxdonpf7E2iXth/0lJ+DtXOryYe1DuTMk4zNylo70A7/cMIjWF2c9uc=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=nextfour.com;
Received: from HE1PR0302MB2682.eurprd03.prod.outlook.com (2603:10a6:3:f5::14)
 by HE1PR0301MB2139.eurprd03.prod.outlook.com (2603:10a6:3:1d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Fri, 10 Jul
 2020 05:29:02 +0000
Received: from HE1PR0302MB2682.eurprd03.prod.outlook.com
 ([fe80::e57c:5ef1:dd36:92f3]) by HE1PR0302MB2682.eurprd03.prod.outlook.com
 ([fe80::e57c:5ef1:dd36:92f3%6]) with mapi id 15.20.3174.022; Fri, 10 Jul 2020
 05:29:02 +0000
Subject: Re: a question of split_huge_page
To:     Alex Shi <alex.shi@linux.alibaba.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
References: <df2597f6-af21-5547-d39c-94c02ad17adb@linux.alibaba.com>
 <20200709155002.GF12769@casper.infradead.org>
 <20200709160750.utl46xvavceuvnom@box>
 <f761007f-4663-f72e-b0da-fc3ce9486b4b@linux.alibaba.com>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
X-Pep-Version: 2.0
Message-ID: <441ebbeb-0408-e22e-20f4-1be571c4a18e@nextfour.com>
Date:   Fri, 10 Jul 2020 08:28:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <f761007f-4663-f72e-b0da-fc3ce9486b4b@linux.alibaba.com>
Content-Type: multipart/mixed;
 boundary="------------E1A4ECF968ACCD6490110D2A"
Content-Language: en-US
X-ClientProxiedBy: HE1PR09CA0046.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::14) To HE1PR0302MB2682.eurprd03.prod.outlook.com
 (2603:10a6:3:f5::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.10.10.126] (194.157.170.35) by HE1PR09CA0046.eurprd09.prod.outlook.com (2603:10a6:7:3c::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Fri, 10 Jul 2020 05:29:00 +0000
X-Pep-Version: 2.0
X-Originating-IP: [194.157.170.35]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 361f098b-9aae-4bd5-a776-08d824922741
X-MS-TrafficTypeDiagnostic: HE1PR0301MB2139:
X-Microsoft-Antispam-PRVS: <HE1PR0301MB21394484F1A53B41525DD1C883650@HE1PR0301MB2139.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 046060344D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iljgbPFNc9PHevE/2ChTWA/WWySuZu3jZ5ASsrdMGv7FzhtRAtvUcxpzbsU3IqkVgnynrHTm224ifVt6PDaaly7VTqk5WLxvxw8yVOWz7ctHs6gDIcCFG0mxJ29gnKYQNcZ1/pQlaVf9XDVv6XG7i4hu+eP/CfucUZXPG98pseUF0sTNA6uxf50QM32XHGO4LQv5sPeITUuGuC6qJcZolN2jOeiXjUEEyiEuZah/9k1nsq5mXar7ILtOtZjH9uELprdT/UUROWS2TN8IbthOchUTAU49fKuUMJsfWNeDscyGfPaDEch/7+X4PTuseZgNe7R3Rt3r72tn7cQ/ey7Kx3tHHD0vcuPoomU2viqvvGQfxkXjgE8B4yx5SuVx+4KVGn/muUQ86TROSX443/j1Aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0302MB2682.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(39830400003)(366004)(346002)(376002)(21480400003)(2906002)(956004)(2616005)(66616009)(186003)(6486002)(16526019)(33964004)(66556008)(508600001)(52116002)(26005)(66476007)(36756003)(66946007)(86362001)(8676002)(8936002)(54906003)(5660300002)(4326008)(83380400001)(31686004)(110136005)(16576012)(235185007)(31696002)(316002)(14583001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: u57OW5oM6YHh9cOr6KavhOyTtYJ4gXnZlI5qDn0OG+gh8Nx3ew5LdOZi5ExHR2z/fk2cib4Usx39wQ7ot8dld5gUnWZbX0C51vGdp0QmGVBEtkEi+2DLiiYLfXgwTkt8byaZor3EJUOshhxkXJktGblCgt3zipR03QRW5gmkMrY0BUKjR/ExYxGHlQU7mb79AuNBY5/7xXxL9zDBHTTE0iH5y4ane57mGeCKAyQ8mhowMKF0oC8Fp8ZUpF2woN1bJzEQMWOhIFmCDHD6wVnZ5Ft6dZ6CQi7OMa0lztVAYNBStE/Gx8yO11uJ3G5zbI0ORP0O6hvNGv1kf36IUOyoz7OgRZrDJUy2e5r92otX/i1QuRR4Fsja7nocEBcFfTaiNLt88zgLZDYyR0BVu4fEdehLcQOeTVbsFZc9AARM0MMzRmVC4vABJfyQIyqlIInl0CGnEz5ZsbHnvGWlcA8ickIZTfhR1T48NsioA/Ciml8=
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 361f098b-9aae-4bd5-a776-08d824922741
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0302MB2682.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 05:29:01.9042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: heUqb1cZAJdsi0NGXzITRFM3L6whPbJvbFbu6BQ4CnB9TieMVt29XmNneyx5VY6Xxm0GKp50Ed0MkUYLHHshUtZ2Br13ijAg2XPG4anNgJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------E1A4ECF968ACCD6490110D2A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10.7.2020 7.51, Alex Shi wrote:
>
> =E5=9C=A8 2020/7/10 =E4=B8=8A=E5=8D=8812:07, Kirill A. Shutemov =E5=86=99=
=E9=81=93:
>> On Thu, Jul 09, 2020 at 04:50:02PM +0100, Matthew Wilcox wrote:
>>> On Thu, Jul 09, 2020 at 11:11:11PM +0800, Alex Shi wrote:
>>>> Hi Kirill & Matthew,
>>>>
>>>> In the func call chain, from split_huge_page() to lru_add_page_tail(),
>>>> Seems tail pages are added to lru list at line 963, but in this scenar=
io
>>>> the head page has no lru bit and isn't set the bit later. Why we do th=
is?
>>>> or do I miss sth?
>>> I don't understand how we get to split_huge_page() with a page that's
>>> not on an LRU list.  Both anonymous and page cache pages should be on
>>> an LRU list.  What am I missing?>=20
>
> Thanks a lot for quick reply!
> What I am confusing is the call chain: __iommu_dma_alloc_pages()
> to split_huge_page(), in the func, splited page,
> 	page =3D alloc_pages_node(nid, alloc_flags, order);
> And if the pages were added into lru, they maybe reclaimed and lost,
> that would be a panic bug. But in fact, this never happened for long time=
.
> Also I put a BUG() at the line, it's nevre triggered in ltp, and run_vmte=
sts


In=C2=A0 __iommu_dma_alloc_pages, after split_huge_page(),=C2=A0 who is tak=
ing a
reference on tail pages? Seems tail pages are freed and the function
errornously returns them in pages[] array for use?

> in kselftest.
>
>> Right, and it's never got removed from LRU during the split. The tail
>> pages have to be added to LRU because they now separate from the tail
>> page.
>>
> According to the explaination, looks like we could remove the code path,
> since it's never got into. (base on my v15 patchset). Any comments?
>
> Thanks
> Alex
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 7c52c5228aab..c28409509ad3 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2357,17 +2357,6 @@ static void lru_add_page_tail(struct page *head, s=
truct page *page_tail,
>         if (!list)
>                 SetPageLRU(page_tail);
>
>         if (likely(PageLRU(head)))
>                 list_add_tail(&page_tail->lru, &head->lru);
>         else if (list) {
>                 /* page reclaim is reclaiming a huge page */
>                 get_page(page_tail);
>                 list_add_tail(&page_tail->lru, list);
> -       } else {
> -               /*
> -                * Head page has not yet been counted, as an hpage,
> -                * so we must account for each subpage individually.
> -                *
> -                * Put page_tail on the list at the correct position
> -                * so they all end up in order.
> -                */
> -               VM_BUG_ON_PAGE(1, head);
> -               add_page_to_lru_list_tail(page_tail, lruvec,
> -                                         page_lru(page_tail));
>         }
>  }


--------------E1A4ECF968ACCD6490110D2A
Content-Type: application/pgp-keys;
 name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
Fq/REmUeraUWcYydE+B+4Xt5yIF/V/Zwm0o=3D
=3DZ2VJ
-----END PGP PUBLIC KEY BLOCK-----

--------------E1A4ECF968ACCD6490110D2A--
