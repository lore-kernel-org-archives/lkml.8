Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A866C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01855206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="hYIr72p0";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="VbQEB94p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgHQFnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 01:43:22 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40762 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726185AbgHQFnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 01:43:21 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07H5h9s0026518;
        Sun, 16 Aug 2020 22:43:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=nYk8a+jia3iE1k7y4Jcic7LqJKxE/oAdy9UbeS01K9A=;
 b=hYIr72p0hCuMGAcjku3xPvtiMDAt1/Z530XhgGXEVfZCeBVTuqc2G088NyUTB6PhCNEP
 ECc8KEH4fQXh0n8Z+yPx0gnKJ7bMMOoYk0cfqF3iQdLoCfO+p4DWag+0LvVggs92BcXJ
 DA+M/UygfvMBfHfChs6R/p0UkZlwSuvhuic= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32xyhk3kux-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 16 Aug 2020 22:43:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 16 Aug 2020 22:43:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSTwR9Nn1PinUNQo3U6FmQrqLkTUtRJfWVu2bApzT5bCpQUN6IeHxArNl0rwC9tUkNWnOnJLaBJ/cEinQ0GU7CFS3w4ZO+3/7NrD4V+EsZkQFH3nuJVFR7f/u1BMVrM86j1OEBuhjigNeHq3Hv15zwjKRn5wRiVYckvf5lbj5CW5ANaRnWNVWWkRq4uwqZPAZ5jLyaz5EjUPKHuUKxk07AijhBJhravEP++c0WSv13+5FKtyKwtld+mWoM4CklxzQGWjTG+NLNgEhOEJob82Aon/t8YrOHjewHqvZvOAMMS5PzHWniw+WSk2LhyFUZRzLupjdy5OGscaIDFI2sZrUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYk8a+jia3iE1k7y4Jcic7LqJKxE/oAdy9UbeS01K9A=;
 b=MtTLGIOZv8PWRL9GEDDIm4stT42te+KvU3KBRp6ZZ5K/eDpPtISID1OpmC+/k4wD76tnENx1lEglNmG0+84enDQHR6mvL2btVel7GhZX17g8vQYfKhe+F86lZjMxy84sfI3yHACZ01tYEsH4QkNKGCC2LJSHzHTLHOM2bpEzMkAWHhOHsSs7Rftc7B4m/S1IMoXjFWydjoToHAWOSW8LffET0Dp8VMCIgiswApGw6tuknQ9I30jC4ueqgtthQtppGDaG9ikHRzunOTRzNonXWjA6ay5zeb2W3OKXCB+IPraPYJnOAotpMr0jXsGKz9rJi3A/WxW+BC7ytwrVZdXrpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYk8a+jia3iE1k7y4Jcic7LqJKxE/oAdy9UbeS01K9A=;
 b=VbQEB94pmdik2Ouw6/GxlbFRg+mydpAYewstJ6/sSzO5Cutkm4vD6wuQ/OD4Aj884HojrXtMB6C2rHf6euTraSu62XL1JYp6Dw4BTWW/Fci6QIf2nigaGHD92tuG/xEw9k8W2iHRzXRBY673dGpRL7YjpDmIs2q1hNDFQMS70ws=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2648.namprd15.prod.outlook.com (2603:10b6:a03:150::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.23; Mon, 17 Aug
 2020 05:43:06 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::119c:968d:fb22:66e]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::119c:968d:fb22:66e%4]) with mapi id 15.20.3283.020; Mon, 17 Aug 2020
 05:43:06 +0000
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
Thread-Index: AQHWdA4T+6PyWIZ5c0iaUFwxmwC/66k7ynEA
Date:   Mon, 17 Aug 2020 05:43:06 +0000
Message-ID: <852258AE-75B6-404A-B236-9EEF37AEE43F@fb.com>
References: <alpine.LSU.2.11.2008161338360.20413@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2008161338360.20413@eggly.anvils>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.80.23.2.2)
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:91bd]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3c27ef0-69d5-4299-66a0-08d842706a8c
x-ms-traffictypediagnostic: BYAPR15MB2648:
x-microsoft-antispam-prvs: <BYAPR15MB2648D223A176799AE15C4F32B35F0@BYAPR15MB2648.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ecevC9ucLvoERdhM2PZBXuRx/Kbj5tT/tpGqNvFn1pemYXVQBp7TtVPoQqWRx8CWqZwqC4TaKdthifpnYVy33pX2j4A5f1g/xw9c7g95btP3RWuhnZwgiVx2+qucXNsXJFkTFVpIdV5CZB1+beaZbC/aJBVyP0IXuz6I/MJu2EWFlr2/uymfU1B7jTr0AzQeMXgWI+D6Jofz0sbCRoBGYU00spBo3FZChFVi6/vz6c033oyAs553GWu4gXLk548sZbvkOigidQdqeyGHWj2purVLWQEvaryxGW4gpSugLZhHfCAbeaaA08m5FM5aKzoVS688tSkBkVadKWFU9fwCmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(346002)(39860400002)(366004)(2616005)(6512007)(5660300002)(6506007)(36756003)(4326008)(33656002)(186003)(71200400001)(8936002)(478600001)(2906002)(53546011)(66446008)(64756008)(66476007)(83380400001)(8676002)(86362001)(66946007)(54906003)(76116006)(6916009)(66556008)(6486002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: FsFi+hS61mQXQg/Nieib2ipkMC01U7/tNQvNztxVAiNi3mj4jL9G2p5Y/6gjIyTUeBw80rlaoPU7wtiWyHY/zRScbSuenfsZhFvwePPHzZLt7jnf7ZNF0YWPxrCm3uxUsP5T71HDjn4Xq/Xqd3/l5cWirTqQx9/Q0jF4p25Ypw/AG2mKgbkVLEM55x0cmVqI/ZGd9e3OVOZjvPBhPW+06sxUxjMDAlzo0AD+9cBI3THyqLVzgTrey9bGNGema29mxOYxzDbc+YiACG/zoiyVdQ8ip6mkOaUcn7kcYvB7Nr1vb3YvapZ/Mss10detBPrRTCx4sIskZXXZjd1Mzq64rElt3PnOz+d9QaxD9Q5fnBXqA82nSKlpC+Brrr7rMIp2Y8WYLk3JsojBnLKyAtrQkcLVFsAdIc/SYkGoqTl2KMN2HX1H/CsKxiB62cwBRNz8HfN17vmd+T42rVSkwDwc5RMaks+LExj4cwfMsA77YxonLKyH7E1n5Wb/873r4Qfqy6F4NRZoL+jfbaqp8oAx3L8BZIFcoyWtTKbVdhewr+V01bUH7PLznwYRyP/NiMNMwALgVDNSM/EsdTeERzqbdRNq/tVjsqg7Ahwo/aSr/H/1MsnuyeamkSCAic03JvH5kF8Y/kNK4nHGoqFR/ZCbH3tjQtoHNYEbLHuwdrMBH3Z0sgop/6+7o89sj+H7KNua
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8B06E2BB002CA343B09060B57D593E0E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c27ef0-69d5-4299-66a0-08d842706a8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2020 05:43:06.1823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +7sy4JzPBw81GDE8wVuEGk8YIdSeyae2DfZCSPKhhuLpFpeHxeqKIk+uqyt7sQGGq+Gm/8Ow0UKSnWjuUonQ5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2648
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-17_02:2020-08-17,2020-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 clxscore=1011
 mlxlogscore=952 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008170046
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 16, 2020, at 1:44 PM, Hugh Dickins <hughd@google.com> wrote:
>=20
> syzbot crashed on the VM_BUG_ON_PAGE(PageTail) in munlock_vma_page(),
> when called from uprobes __replace_page().  Which of many ways to fix it?
> Settled on not calling when PageCompound (since Head and Tail are equals
> in this context, PageCompound the usual check in uprobes.c, and the prior
> use of FOLL_SPLIT_PMD will have cleared PageMlocked already).
>=20
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Fixes: 5a52c9df62b4 ("uprobe: use FOLL_SPLIT_PMD instead of FOLL_SPLIT")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: stable@vger.kernel.org # v5.4+
> ---
> This one is not a 5.9-rc regression, but still good to fix.
>=20
> kernel/events/uprobes.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> --- v5.9-rc/kernel/events/uprobes.c	2020-08-12 19:46:50.851196584 -0700
> +++ linux/kernel/events/uprobes.c	2020-08-16 13:18:35.292821674 -0700
> @@ -205,7 +205,7 @@ static int __replace_page(struct vm_area
> 		try_to_free_swap(old_page);
> 	page_vma_mapped_walk_done(&pvmw);
>=20
> -	if (vma->vm_flags & VM_LOCKED)
> +	if ((vma->vm_flags & VM_LOCKED) && !PageCompound(old_page))

Do we need munlock_vma_page() for THP page head?=20

Thanks,
Song

> 		munlock_vma_page(old_page);
> 	put_page(old_page);
>=20

