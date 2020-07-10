Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5863FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E3232078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NextfourGroupOy.onmicrosoft.com header.i=@NextfourGroupOy.onmicrosoft.com header.b="eQpLyHnU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgGJHWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 03:22:17 -0400
Received: from mail-eopbgr10073.outbound.protection.outlook.com ([40.107.1.73]:63906
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726288AbgGJHWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 03:22:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtQeU/7/EveuFWojXdCVM/jryEJ9OoE+y6NTdEcFJvru646bkHF7q4bPyDpu03VyJDSpLDDAIQg5C3Y563UOS87MBp5ol4r86JjjWWy+UX0WRB6EpISTWt3k4QE5rNgz8y1lMQ+MPboBMCIIz/aiFuPG1C10Yrrsq7NTtRSZETdhzHl55pHFQzOsjaXT30yC464T51uaP5k4kPCzlZWX8bXHXrKDE5zKggr6gClptaqFQT6Z/3CDt10FH+0Oyc8q10b5QsKBKp4Bv2Vak2j7Xg+O9U2QCK+0XT+ZLNVnLhxNmWNBVUSwWZ8WpQk+SVQvypUcz+C7btIymqW93AKiEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8CCIAI1Q7gFMg2NESYLOISl/m2xFtfgmHEexTinWYA=;
 b=DlAbFwzFzSM5p1vuUXB7OPQaIrjMobpqRNT95WZf54Z2Rr0uz4UE7dvEttNWZwl1jhGKySYfrVzXrPaEOrC+edZ99qkLdQxCgcz+xb8lA5MPiW2bvBvaxdFOd/ZzALbFaRRt80DyGn2vWpIBuk7oqPU/qQlS8yFHp3i060goIzRcJKuu00Jgpk3gY426MiDBL0x86kfYX52p2Qs3u0v5myPJrbVtwmIRK4YKibXI394ux44kA/Ib3JNHVaXPP8xazDptJWbeaOZnTyRvut5F9ic1I3v8+xrvRUe975pYQ5W+rNCWfJL+BChBDCDu+zKDXUz3CjLzJiXsgQOfCCNtFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nextfour.com; dmarc=pass action=none header.from=nextfour.com;
 dkim=pass header.d=nextfour.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NextfourGroupOy.onmicrosoft.com;
 s=selector2-NextfourGroupOy-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8CCIAI1Q7gFMg2NESYLOISl/m2xFtfgmHEexTinWYA=;
 b=eQpLyHnUCdqLQKUb3pUSHY9Yu5jbfkXHm5nNGhVY6qR6/LC+A0p6Ir0uyglX2YFHOt6ghprrwhSIRu6+Og571vBD6r+/nskmB9lL5R1r9YnwSvdtCqPxp9/s+K7lls6zAWgA+9DWtTWrN/WLfz0U54hgLWshNPr+/2ufYuRUsto=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=nextfour.com;
Received: from HE1PR0302MB2682.eurprd03.prod.outlook.com (2603:10a6:3:f5::14)
 by HE1PR03MB3113.eurprd03.prod.outlook.com (2603:10a6:7:5e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Fri, 10 Jul
 2020 07:22:10 +0000
Received: from HE1PR0302MB2682.eurprd03.prod.outlook.com
 ([fe80::e57c:5ef1:dd36:92f3]) by HE1PR0302MB2682.eurprd03.prod.outlook.com
 ([fe80::e57c:5ef1:dd36:92f3%6]) with mapi id 15.20.3174.022; Fri, 10 Jul 2020
 07:22:10 +0000
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
 <441ebbeb-0408-e22e-20f4-1be571c4a18e@nextfour.com>
 <b6faa876-4c20-e99f-2e41-770871a5403d@linux.alibaba.com>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
X-Pep-Version: 2.0
Message-ID: <e061f44c-c1f9-d02a-59db-0cd9b213df6f@nextfour.com>
Date:   Fri, 10 Jul 2020 10:22:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <b6faa876-4c20-e99f-2e41-770871a5403d@linux.alibaba.com>
Content-Type: multipart/mixed;
 boundary="------------FA6F8C6E10F6277D639547ED"
Content-Language: en-US
X-ClientProxiedBy: HE1PR07CA0020.eurprd07.prod.outlook.com
 (2603:10a6:7:67::30) To HE1PR0302MB2682.eurprd03.prod.outlook.com
 (2603:10a6:3:f5::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.10.10.126] (194.157.170.35) by HE1PR07CA0020.eurprd07.prod.outlook.com (2603:10a6:7:67::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.13 via Frontend Transport; Fri, 10 Jul 2020 07:22:10 +0000
X-Pep-Version: 2.0
X-Originating-IP: [194.157.170.35]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b557bb1b-b44c-42c2-c8bb-08d824a1f589
X-MS-TrafficTypeDiagnostic: HE1PR03MB3113:
X-Microsoft-Antispam-PRVS: <HE1PR03MB3113DFB5D17A556EA1B3CCFB83650@HE1PR03MB3113.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mkgB672BYKjuKjrTzihV1KZyJTfX7ytza3uBvhkwEdxUZQ86l/Hx13Tqcy9nhUHMrzjk6by2t0cjdetUVl3Hwx5JQa5TY8HhM2L2kwsxWNIS1/i4blK6bLIkMIEg1EzPzzr1m4brQHd8+or3vp/Dv11YB4TQfDYTNG6/iZne7rhv/nqjmUffAF8E6JK/j3rOMu08e1jVatkl85gbkJpQda3Tm8Kgz3JFAL4POKNfvnnRrvju3+oS8TCRhQDXUKIBpVpFU/gFchRGpfiae7lWqa8O3iItOwTnMbupRojkr3MW9886ObCA1b+jqU37hznpz3XO26crkyX4DhtWfZvoz12PEDOYdgURBif8n6ltdkJfgJBXx1C/puAhPBNALeSFvlhwg+XIj7k7oJk1GImH4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0302MB2682.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39830400003)(376002)(136003)(366004)(346002)(86362001)(8676002)(31696002)(83380400001)(36756003)(5660300002)(235185007)(2616005)(956004)(31686004)(66556008)(66476007)(66616009)(508600001)(2906002)(16526019)(4326008)(186003)(316002)(6486002)(26005)(110136005)(52116002)(54906003)(33964004)(66946007)(21480400003)(16576012)(8936002)(14583001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: yScUlnFsTWkZkpVwixhMDcEBzyFgvDYI+d7VJ1EJRe7eBM8gI6h67TPfHz6u1am0avc32BJ3p6AgAmW77U+yHjw0xuyiuRwyd/IkZV954HFJie065MS3zD2aKOreN56KIqs6uFlcxCQfzs0Tng6jd+RR/Ki9aFpvrNgd4hvrovM2UU9IXmPsj6tmDbDbzjdD0NOCsJ9QA7v+v4n8t+tWU0Q6SEne+i2cDqqC6/ZXW6UqVcyb4JhgT/957UGp6Xlp3EUDKNGLI3A/+WQ+SwY5nRYZH2CLLkXx9DtQNXN4ra+M4qrOVuy4rSSlYMQ9JDWbi2SjNv/nj4FwUUEU0ZEGkbvrdoGI2MdAZ4amrh3C+LGCBTDAeh0ng9gPHKhGY8g+Ly/DJXqkmr5B11F5zfsWb4XfoHNFNVOJGajrt0ytO5b6EqfBsYiClhCaOxIBHnFW2aFe/EixfTUAH1nYgIVShfifo0NBs+ARE5un4FkSmlQ=
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b557bb1b-b44c-42c2-c8bb-08d824a1f589
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0302MB2682.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 07:22:10.3016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gRnCLz2CM3rDB6wPTZNUyHOyxcBch96h2d5xWEhb1LiKysKETmuNZ7MugUwIPWODzJAJcH+yjk0ActTnpdx346z41LwU0sY4S2pRsz6bKEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR03MB3113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------FA6F8C6E10F6277D639547ED
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 10.7.2020 10.00, Alex Shi wrote:
>
> =E5=9C=A8 2020/7/10 =E4=B8=8B=E5=8D=881:28, Mika Penttil=C3=A4 =E5=86=99=
=E9=81=93:
>>> Thanks a lot for quick reply!
>>> What I am confusing is the call chain: __iommu_dma_alloc_pages()
>>> to split_huge_page(), in the func, splited page,
>>> 	page =3D alloc_pages_node(nid, alloc_flags, order);
>>> And if the pages were added into lru, they maybe reclaimed and lost,
>>> that would be a panic bug. But in fact, this never happened for long ti=
me.
>>> Also I put a BUG() at the line, it's nevre triggered in ltp, and run_vm=
tests
>> In=C2=A0 __iommu_dma_alloc_pages, after split_huge_page(),=C2=A0 who is =
taking a
>> reference on tail pages? Seems tail pages are freed and the function
>> errornously returns them in pages[] array for use?
>>
> Why you say so? It looks like the tail page returned and be used
> 	pages =3D __iommu_dma_alloc_pages() in iommu_dma_alloc_remap()
> and still on node's lru. Is this right?
>
> thanks!
IMHO they are new pages coming from alloc_pages_node() so they are not
on lru. And split_huge_page() frees not pinned tail pages again to page
allocator.

Thanks,
Mika




--------------FA6F8C6E10F6277D639547ED
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

--------------FA6F8C6E10F6277D639547ED--
