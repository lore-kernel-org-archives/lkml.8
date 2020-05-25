Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA16C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 00:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3398020776
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 00:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="kWX8qOsB";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="SctEVXh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388641AbgEYAGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 20:06:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:26912 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388149AbgEYAGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 20:06:14 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 04P02JPH029953;
        Sun, 24 May 2020 17:06:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=cF9Aa7VUBWYCfCDoJL9s8lxtXiRzvQ/o+AjWHRyBiRQ=;
 b=kWX8qOsBrY6I/z82s2M52LC2Fmq2P+lGuFTwJD+OAMfSCxbTNQ61bYDzmNWFB2xq7Q88
 1zBS89GmI+lvmMhqAG5yX24Ztl7GszyI+CxgUOhPxjLJkAY5wvthH6yyXLHh8NjG0GeV
 LdUq5xoQ33myZhOY4TF3XepgipPP+MYy5Fg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 316ygp48cx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 24 May 2020 17:06:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 24 May 2020 17:06:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lo7yX91tEXu7byl4dowuxbUsXe5sn+a/98HpwQIfEFr0o+Buv0WRS2pSwexRwx1bDjWpJOk1yHZtzOPqLZ5TF5184dFafqJoE0wt+DYJK0fjDY+iLR4nu4GENG+ny/6KSUWNqZFsG0B9S9TSQYZ3gRjkwJbcdXC62lSTNIzbN1O3SEH6L+Vq28wQapLAGe3PyIvTkCFpib2Z6uLzQLeZ/bGGYCuN5mxNdakIFei1L8P0pqssi/KmV/eHFDwdPkDOFtsQMn8Rpl3VQn+5cuVIqqSHptinMY276TVU7CgwDV0LkEbKJPg8yc3Mmjvzjky8++T7TyVswTxNpma734caJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cF9Aa7VUBWYCfCDoJL9s8lxtXiRzvQ/o+AjWHRyBiRQ=;
 b=JimEG7q/zDpkVJBZ1N8DVNDiRvLTGQ9pCxbx8FtcE8Tf17HIOLfQyZXzMfbGa/OD8HZxZUmm3QCSLhZu3gphqhYheokL9fm8ppxpubR2VBVsZqkcChqNGdqyIy9XxrCJY4QrLnGmmbHELxdNyxIqLtkWjP5+3s0vTLk74QPXrkNS17z0CnVqtKPlQsQTWnqSyeW/NLSYB+eSsQTNk8Sx451Cnn7C5Ky65EEbLoSdU3jvfo3xx2P0NLjWQ/iuZEVghaZDpNg1ENb1TVboqFjGOPoB6p3gZBtM0DboXf9TsnBmt0Ap0srlROorNR1LfyX1u5dpqzPp1PgQTiqUY0J/Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cF9Aa7VUBWYCfCDoJL9s8lxtXiRzvQ/o+AjWHRyBiRQ=;
 b=SctEVXh2UZ2Oh3b9AkrRlwNlmQdkSkiLX+uPSDRHCRenSOGlzb4pnxSxY5cmehBpIZ6kdknuMIfOTPrTkdI2bhz//JT2BOrzfnpgulowMVSQMSF24jieZ4SDAzGWgh4Lbnvc61yJ99a7JllflqrJIqWBhzSXVsaMPVjgRpy9ntE=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2726.namprd15.prod.outlook.com (2603:10b6:a03:157::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Mon, 25 May
 2020 00:05:46 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::bdf1:da56:867d:f8a2]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::bdf1:da56:867d:f8a2%7]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 00:05:40 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] mm,thp: stop leaking unreleased file pages
Thread-Topic: [PATCH] mm,thp: stop leaking unreleased file pages
Thread-Index: AQHWMW24n9w2hRwgcEyvzNMwGpSUgKi37ZcA
Date:   Mon, 25 May 2020 00:05:40 +0000
Message-ID: <649C7E6B-BD4B-49F6-8CF2-E600AB4B94FF@fb.com>
References: <alpine.LSU.2.11.2005231837500.1766@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2005231837500.1766@eggly.anvils>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.80.23.2.2)
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:b76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d77327f-74eb-4b53-6cd7-08d8003f5c83
x-ms-traffictypediagnostic: BYAPR15MB2726:
x-microsoft-antispam-prvs: <BYAPR15MB2726D21E3379DB3AF71B5284B3B30@BYAPR15MB2726.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0414DF926F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u/NZKZ/ZOCtuCL4AJuV76FIUCRAKma8oEdNNaewazjUOK3r8qjD5r8B0OMPN9cVYxSrb1ppSOur7gNvfnWVZAIexhHdXlQ8lJvUTgfPfmu7OcMOnwQrFikVtrFZ/juSVmZmIto9a5ZzpEo0s5rLjOE8pzrGHmyz6XINMXwvArNlFB2L074EBMkkzij1Z7jwdLiGS8mRkHD7C4Wc0Pk66Tg0RH96LD8QM1je1LRthSx8acs5STHVbU8SaV/eWAjPo88uitFqlfkmImblp6jDPqGCWZN80zxcH/YAz+3ZMVCB/iZpOqPJVr7CXYeoKMhJ+Z3LxRivkj5GzuXIipe7IrqBnAfru9aPSGefCpdf4WuT7FhDPl6wNfEVqcvsc+S6V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(346002)(376002)(39860400002)(136003)(396003)(66946007)(76116006)(54906003)(53546011)(4744005)(64756008)(66446008)(66556008)(66476007)(6486002)(478600001)(71200400001)(2906002)(5660300002)(6512007)(33656002)(36756003)(186003)(8676002)(8936002)(6506007)(4326008)(316002)(86362001)(2616005)(6916009)(142933001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /TSrEM72sIxP444CDtJzBwcoqDSmZiJu8ZksgQOvEtk/4Q4xnvaqaPlFVTG7tCf7CDBIqWuR0BE+DaXoXunM/XazzjTxw2einuDEnI3el0EeWvo4dwe3VIoycgmvzEj7fxtlt84NDSnmaRpFBUDxxoSScRQQ5klhx2rIquDIvsNpiycbLKC28UQOKDDrs0cXI+pAR2JA5Q8T8akjWMPmP+j1NSaPTg9htg+A4P0ifLlmTqzmYKdEHDgBkcF9QqyJd+/FpZ8n7Es7ODeRgdfaZaH1Mrqg242nY3eESx2QXA3dcnOe4ubpVjrQhcmHPaiWCrvU+z1aeigJUQERwHyqnKVCZdJQ6fERdrctZCMBdMxmRyTRhW7SF8csqJ3vlxuwt9sujWsqebRTSwQoG1+rI/e2WqBUR5Jb9HmobrQDsqSqefzDK5RKjaKqpm58f3xLroElXJmvYLmZEFtmIcd0LXdfCAiSPUN8qbcYD1lvE/RxGGnnNt5VEuqoWEeUHNAyIZJuBfbDnb3ObTrL/fX+hA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A172B347CA786544AEAD5E6CFC9BF487@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d77327f-74eb-4b53-6cd7-08d8003f5c83
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2020 00:05:40.6362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cPQvskRN9X5vG7n6RdHM4Q6LWP1AOah9tcQ1AdDvcQ84K9hisOxnkzZ6QJcBW/pxqyMl9DQz3ai3uLbMVqu/Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2726
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-24_07:2020-05-22,2020-05-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 spamscore=0 mlxscore=0 bulkscore=0 cotscore=-2147483648 mlxlogscore=905
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1011 impostorscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005240204
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 23, 2020, at 6:50 PM, Hugh Dickins <hughd@google.com> wrote:
>=20
> When collapse_file() calls try_to_release_page(), it has already
> isolated the page: so if releasing buffers happens to fail (as it
> sometimes does), remember to putback_lru_page(): otherwise that page is
> left unreclaimable and unfreeable, and the file extent uncollapsible.
>=20
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) F=
S")
> Cc: stable@vger.kernel.org # v5.4+

Acked-by: Song Liu <songliubraving@fb.com>

Thanks for the fix!

> ---
>=20
> mm/khugepaged.c |    1 +
> 1 file changed, 1 insertion(+)
>=20
> --- 5.7-rc6/mm/khugepaged.c	2020-04-12 16:24:37.710999073 -0700
> +++ linux/mm/khugepaged.c	2020-05-10 17:06:21.788398646 -0700
> @@ -1692,6 +1692,7 @@ static void collapse_file(struct mm_stru
> 		if (page_has_private(page) &&
> 		    !try_to_release_page(page, GFP_KERNEL)) {
> 			result =3D SCAN_PAGE_HAS_PRIVATE;
> +			putback_lru_page(page);
> 			goto out_unlock;
> 		}
>=20

