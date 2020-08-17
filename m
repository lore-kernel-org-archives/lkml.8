Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F778C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEA252072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="j/YKVXIO";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="c2ajIzpO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390568AbgHQSNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:13:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35562 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731061AbgHQQGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:06:53 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07HFw0P0006388;
        Mon, 17 Aug 2020 09:06:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=x0atie+zrVbqihaZOJcQyK+2kpDmK1O+5kzea62RDJA=;
 b=j/YKVXIOZ0xoYmAiHi13aBETJxqgi9SnjxOZmb+jE/eZuZbKJrySAnhwn9KbdxpgfGPN
 ZTANhHCFW7NeERunCwiI1xiR3vaEzGhcE0YSLOU9v2SD1olOvjtJIK3+ECXcsesk8/NH
 agZ4/gIob28pAe5YCI9ddAwZ8t5cZ6ALhUU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32xdepgndb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 17 Aug 2020 09:06:35 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 17 Aug 2020 09:06:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYlcmycZgK52R1g9X3Z9O1ttnzlzdCkFCQMMiVOHXtUzrXcAtm3I5i2vvLUgKb6B95A+6lu/T2f3z7cqDHwZUfrs1KaVfsufosoyK38rNRAWx77ImykhK3VDq66e45BFY1n2CZK6mraSjmyKH9+Q+h66iD5BT3T5CV9X8axcOLCIibBna3HzIEh49y3upQB78u3t9JbOVQWXX4fF/ixpf1jIqffPrTU7sZ6tq8mmL8a+Cd6YMXjnzxjVLAuBbttOt9EGityhF7oyBNmtOkCAmEosvXPXfG82+Ds0jJLdze3ew3IYx9JyJFhPzhHYAP0A0C3OwK7WdamNJZr7C4Xl6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0atie+zrVbqihaZOJcQyK+2kpDmK1O+5kzea62RDJA=;
 b=kxaO+P3YHUu6cNehz4QMSfOMjL2UzHq519wu1FvmQKzPRYCGeetCvf4MNmJAqfNTC7KAu9NrKSE79hqGeDPmbUukcAQ2WOWAxk2LIV9g14v2Rs5gYFoKq4iH6glEz+cC6T+cWfQkpJdNaJ5nKGOW//CaMpTMTnKtHLswRhyHO55U/g63fNZgdNCGsqFGPbPumxR1ixBCe6WpUI0KG/+7klDZxYoy/9XJmxoZTFVoVVw9zc564b97dXNpVAsC7yRf9f6817QkozIw78/lDHZzFj7IuurPwxftfhm1KmK9VlOWh30g0ZU3YqKxlKf1mJOi6bijZYDF3l/yhPgDFgFtQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0atie+zrVbqihaZOJcQyK+2kpDmK1O+5kzea62RDJA=;
 b=c2ajIzpOzBGfDciX+wpUHXYjgz95x9v3cBeuBSd2Cr7m1nk/DwgdacHTob1BbuAKXbHGtqbfdq47+PG0gMltZCLG+AthGavxcpeYKnCdlH7QwDQ0bG3RFTV9O04SQMIU8h22S+nuvAmMlHeAjP3FpustVOfod0Qnv22t0RDKyp8=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2568.namprd15.prod.outlook.com (2603:10b6:a03:14c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Mon, 17 Aug
 2020 16:06:20 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::119c:968d:fb22:66e]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::119c:968d:fb22:66e%4]) with mapi id 15.20.3283.020; Mon, 17 Aug 2020
 16:06:20 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] uprobes: __replace_page() avoid BUG in munlock_vma_page()
Thread-Topic: [PATCH] uprobes: __replace_page() avoid BUG in
 munlock_vma_page()
Thread-Index: AQHWdA4T+6PyWIZ5c0iaUFwxmwC/66k7ynEAgAAaeYCAAJOoAA==
Date:   Mon, 17 Aug 2020 16:06:19 +0000
Message-ID: <C1C463D2-39C5-413F-B99C-3F73B1C07BF1@fb.com>
References: <alpine.LSU.2.11.2008161338360.20413@eggly.anvils>
 <852258AE-75B6-404A-B236-9EEF37AEE43F@fb.com>
 <alpine.LSU.2.11.2008162340320.1025@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2008162340320.1025@eggly.anvils>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.80.23.2.2)
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:91bd]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d496cdcc-9822-4fad-e910-08d842c77af3
x-ms-traffictypediagnostic: BYAPR15MB2568:
x-microsoft-antispam-prvs: <BYAPR15MB2568703D8605E12DE02272B4B35F0@BYAPR15MB2568.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mvtPDATQXl5ZjYxuAd2Q3Cw7ff5Na1gSqQ0/+Fl+pHTMXJz6aE0Xjb0R5HtzY3h8tHs8NJkA8NukPPOzi7KLbdwlctLfpRGkx/VHyvVwpa2SOuWk3heTc83HP4t8Ud6sdS3uJcliXIMI+zAJ7rKkPoDfyImU0i5pJwjYRTIpNOQipRvT5ZMt7hll8uxrkshX09gqygYmjJNte6EJhKD10JKZavo02RuurqCnBvIL5jh/T9S00YjqGb4KbxPDaqRXWC1tY8oSP1A1kArI3Lq9Mi+MAYDI9ZOTBoXO18vHJxKacc+jFT2ZNHTbm6armsxjpEuVOWE/bNQatMkSKNpx/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39860400002)(376002)(346002)(396003)(5660300002)(6512007)(86362001)(83380400001)(66446008)(66556008)(66476007)(76116006)(64756008)(53546011)(36756003)(6506007)(66946007)(71200400001)(54906003)(2906002)(316002)(8936002)(186003)(6916009)(2616005)(478600001)(8676002)(6486002)(33656002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: q5im7AAOhFbZ0bOoRkJH1zH7jFY68LsCdJXd5HI6qCi5keTE5xfx0Q7N4w0ZN25PbKvKGy3hWI3RrKnHsntNBvG1K4GwSBWB8F1Yd45f1NyKn6wiaJVpPJ7jGviAZDf5brXvGwv1yKklDq79wXxoWhjTriQqUkSgO6+d7txjg9KUGP0T0VFhuYFzPOwloEBnOLsUizBUIfVhwyIfAnrl0QtFDgxdoB5Zl6vl+XmYgPUdpj5ni9rAJV2byO1+CzNT6PKs+XMzNdTf8ijMJcNXCYcUv3Zt4SzRUkpA9xNHu92mBoUcKNz/pkNw/h4/cJGuBD44SHMHMXbiIRqkDFWG6tOTl/Cx9m6f/gCvlrXPcZfexrI8HtJt/TXvByC91uCi+a4X0CqmCX2k8qgv5pj+US/o7a99oAsDnp6gKA5ry+ma7q8HDV5gRj95cVWqDoT4CVpK7MtfhJdyXBxKJynQCIw8jcX7xHMdkJ7x0g1iwOAEda5uiR9pApZ45aUvbE0+JpKhCjJfgUS5bgCI4Ofzunk6S7wxLtXS9ON0F0uOdsJL49z8Egt0bUB1p+B+dFlJ+Ps2kLU5H4ZXIY6uYr4LnJd3jCLAxAnBVioLnY9DFbT5sGlQaJMn7//M4gmt9xCHFLD0xyqIX9OXme1KdfuUOS7ZeOprEkE6mTazxDcr0RbDmMKg8x2Aggyn+vEruzKl
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BE3B58A21F059F48890CB389F8ACC26A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d496cdcc-9822-4fad-e910-08d842c77af3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2020 16:06:19.9806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ai8AITWDAu3FCBd6ZEd4DwHt2EYuGWsfHe90XlR+9vi78gfvHPIHE40G6MIxsHwxN103DNP+QnrC+qokSfO4xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2568
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-17_13:2020-08-17,2020-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008170119
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 17, 2020, at 12:17 AM, Hugh Dickins <hughd@google.com> wrote:
>=20
> On Mon, 17 Aug 2020, Song Liu wrote:
>>> On Aug 16, 2020, at 1:44 PM, Hugh Dickins <hughd@google.com> wrote:
>>>=20
>>> syzbot crashed on the VM_BUG_ON_PAGE(PageTail) in munlock_vma_page(),
>>> when called from uprobes __replace_page().  Which of many ways to fix i=
t?
>>> Settled on not calling when PageCompound (since Head and Tail are equal=
s
>>> in this context, PageCompound the usual check in uprobes.c, and the pri=
or
>>> use of FOLL_SPLIT_PMD will have cleared PageMlocked already).
>>>=20
>>> Reported-by: syzbot <syzkaller@googlegroups.com>
>>> Fixes: 5a52c9df62b4 ("uprobe: use FOLL_SPLIT_PMD instead of FOLL_SPLIT"=
)
>>> Signed-off-by: Hugh Dickins <hughd@google.com>
>>> Cc: stable@vger.kernel.org # v5.4+
>>> ---
>>> This one is not a 5.9-rc regression, but still good to fix.
>>>=20
>>> kernel/events/uprobes.c |    2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> --- v5.9-rc/kernel/events/uprobes.c	2020-08-12 19:46:50.851196584 -0700
>>> +++ linux/kernel/events/uprobes.c	2020-08-16 13:18:35.292821674 -0700
>>> @@ -205,7 +205,7 @@ static int __replace_page(struct vm_area
>>> 		try_to_free_swap(old_page);
>>> 	page_vma_mapped_walk_done(&pvmw);
>>>=20
>>> -	if (vma->vm_flags & VM_LOCKED)
>>> +	if ((vma->vm_flags & VM_LOCKED) && !PageCompound(old_page))
>>=20
>> Do we need munlock_vma_page() for THP page head?=20
>=20
> No: as the commit message says "the prior use of FOLL_SPLIT_PMD
> will have cleared PageMlocked already" - our THP implementation
> has difficulty supporting Mlocked consistently when the huge page is
> somewhere mapped by ptes, so one of the things that __split_huge_pmd()
> does is clear_page_mlock(), then PageDoubleMap will prevent Mlocked
> being set again once GUP has brought the old_page pte back in.
>=20
> But if you'd prefer us to munlock_vma_page(compound_head(old_page))
> instead, I can certainly change the patch: it's one of the options
> I considered, but couldn't quite bring myself to do it that way,
> knowing that actually it would never find PageMlocked set.  (If
> PageMlocked were allowed on tail pages, I'd have used a PageMlocked
> test instead of the PageCompound one: I spent nearly an hour
> bikeshedding the alternatives here!)
>=20
> (One day I must remind myself of when munlock_vma_page() should be
> used, versus when clear_page_mlock() should be used: I think it comes
> down to a choice of which stats get incremented, but I may also be
> forgetting something more important: anyway, no obvious reason to
> depart from the munlock_vma_page() that's always been used here.)

Thanks a lot for the explanation!

Acked-by: Song Liu <songliubraving@fb.com>
