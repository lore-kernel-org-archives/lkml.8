Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C06C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F30324695
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="VXgDEvMT";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="UYyOd+tA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405485AbgAPRmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:42:10 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:2830 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393635AbgAPRk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:40:27 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00GHY9YT011392;
        Thu, 16 Jan 2020 09:40:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=6s+YYiYy0h9ardOuLOrcnfHZHEWKGxHwuAlAHUJEO4I=;
 b=VXgDEvMT3JE0ck/Q6eRctzdVMAIXIMjtgJ74w1LGRuhuHkNOJyGxbSNs3/HXLqtS+7Uc
 z71WG7DfWr2CgezXTX2daDLHj/djGoUcrNYSFzQytkIiOEH+t6Kw3/Va3TOt4Y0JH7ds
 k25Er4OKua69KDHQsMwdju6qRBpw1jY6QMU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xjj1uak15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 Jan 2020 09:40:19 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 16 Jan 2020 09:40:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArWcUJrTx4e/BImoZJEg9NZKCS5xw4ubAn/U/kxH6yl+WX4QtTfrcBTDqN2HHYcYHOvbhmU+egXCyam640zLGB+Co2FvVSc9357j2x5Z4/kcmNHoaZd+2NSXeEX2AbtDkeZGeZCXEItUkWsRSQQuRl7/u7C0aPXz5RPSajqA7J7cgp0Rx1s8bagGebXaGIqt8Sewk4pjjlUlJ9JQXBDSJ0vVw9jlCKj5wiYXID6JL3a/VAvxr1H6CJyxQm3l3k9qHOgNIOzIiPmFltJ7PoVPxOjJ2yHQwMIMs9M/UcsqhqcGEvPRlo7ZZ9dJo+OkTfTykqOzhUTbZk4qpfJzR2gL5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6s+YYiYy0h9ardOuLOrcnfHZHEWKGxHwuAlAHUJEO4I=;
 b=CxrpK2zW99PzCUfc8gNgDVBXRvWj8ut1imzvbXbSvydmkJ/zDxcOe4FCbVnyz1tDouAffgxE0cCC6z21O8riNtFcN5tY/9sMuHt72DPa/dCdz5bC/BV7woSSJr/St4Sg7I/trXav5Qfa5Q+UiYvvE71uh6wUTfOggihAkAXlPevz7Rxy8SXCskfjk8UWk4qlqag9IgZ877Tnmd7nDk+xtsspNyX+0KPExtLqLKWiQyxfk2rbmzTtL7devSH0NuPvLIdYGMS06ZvpsyT1QGVoPHqcOR9IKFNxmrFfJ3xlZ1n6EFoi7EjF8vny1JA3HfTSxV2FDokmyxaXD4VPkNUBSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6s+YYiYy0h9ardOuLOrcnfHZHEWKGxHwuAlAHUJEO4I=;
 b=UYyOd+tAfxhyMOhRBfmbQSZAaXH2OG33WRae0sNR3jio3K7O6fNwSe3AbpV3xOAWZR7w02Rvpb8B43jtFoFuNZyYAWzPSmpQJ/mp3/dhHStTHE498XCg0H7F1UeMvjIVnAcKhscQVSQyQ4b0TOTgctNzqrDKFtanffIttYbyJk4=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB3254.namprd15.prod.outlook.com (20.179.59.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Thu, 16 Jan 2020 17:40:15 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2623.018; Thu, 16 Jan 2020
 17:40:14 +0000
Received: from tower.DHCP.thefacebook.com (2620:10d:c090:200::2:492d) by MWHPR10CA0004.namprd10.prod.outlook.com (2603:10b6:301::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Thu, 16 Jan 2020 17:40:13 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v2 6/6] mm: kmem: rename (__)memcg_kmem_(un)charge_memcg()
 to __memcg_kmem_(un)charge()
Thread-Topic: [PATCH v2 6/6] mm: kmem: rename
 (__)memcg_kmem_(un)charge_memcg() to __memcg_kmem_(un)charge()
Thread-Index: AQHVzJKbgVUSlNYKkESLg4k9oItO2aftjtoA
Date:   Thu, 16 Jan 2020 17:40:14 +0000
Message-ID: <20200116174010.GA15833@tower.DHCP.thefacebook.com>
References: <20200109202659.752357-1-guro@fb.com>
 <20200109202659.752357-7-guro@fb.com> <20200116173002.GF57074@cmpxchg.org>
In-Reply-To: <20200116173002.GF57074@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR10CA0004.namprd10.prod.outlook.com (2603:10b6:301::14)
 To BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:492d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23ebee7f-c5e9-4568-abdc-08d79aab24d0
x-ms-traffictypediagnostic: BYAPR15MB3254:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB325449ECDB439DC1855A336DBE360@BYAPR15MB3254.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(366004)(39860400002)(189003)(199004)(4744005)(52116002)(1076003)(8936002)(8676002)(66946007)(66556008)(86362001)(71200400001)(6506007)(66446008)(64756008)(16526019)(66476007)(54906003)(81156014)(7696005)(5660300002)(2906002)(6916009)(316002)(81166006)(478600001)(9686003)(33656002)(4326008)(186003)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3254;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /88UTiiESvFryIYrPVbpJcQDj4PrgLQAEWEGoL04DQ4PHDlLQCl7/b+xJ2KB29qNd8KlLCjGtGRRA2op7hcI3Zic/no7+E3gFWNzrZ/k4reS/IchW9zokabaxuEYGJSovGtme8PexGtFjrSQbDz0fdDEk4id7FgI6DiQDnJpzRTwxELKgT8MzZqgYlfqsGcicoggdmE6LuQdCJ5MRd1UhfKOdkHgOhtGDSP4jHPeSyv8XXW4m6p2nqHsugawIDPZzJsJr2/61+IGrQn03ErEUW9+IrOTm/3HLL9M2M+sqNrwvV+c69sGfJqS74cTjjDVHjKXJZIBRP9iMWpXAN9rvJrZyBR8jENyS+GgPl9CCn2xRZammXr6B8B0m7NZM62cByaB0JS2RE86u/xch34FOIxxlmiuuxZ5VNader05ldffjbH6NOHW5izU2zJ0hjKG
Content-Type: text/plain; charset="us-ascii"
Content-ID: <795EB003EDC6FB458C73B493DF0DD550@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ebee7f-c5e9-4568-abdc-08d79aab24d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 17:40:14.6043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l299UcLCFgOufrgjtu09PrCq5MfI6152S+8zc4GX+UWKf15iHRRPCvg8i6IczClf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3254
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-16_05:2020-01-16,2020-01-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 spamscore=0 malwarescore=0 mlxscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxlogscore=393 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001160142
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 12:30:02PM -0500, Johannes Weiner wrote:
> On Thu, Jan 09, 2020 at 12:26:59PM -0800, Roman Gushchin wrote:
> > Drop the _memcg suffix from (__)memcg_kmem_(un)charge functions.
> > It's shorter and more obvious.
> >=20
> > These are the most basic functions which are just (un)charging the
> > given cgroup with the given amount of pages.
> >=20
> > Also fix up the corresponding comments.
> >=20
> > Signed-off-by: Roman Gushchin <guro@fb.com>
>=20
> This looks good to me. I also appreciate the grouping of the functions
> by layer (first charge/uncharge, then charge_page/uncharge_page).
>=20
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thank you for the review!
