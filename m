Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB32C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC98207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="d8UoOSPT";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="fIFsT5V5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgAMPLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:11:50 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:8098 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726567AbgAMPLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:11:50 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 00DFAV2V023386;
        Mon, 13 Jan 2020 07:11:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Y4pi7wsXmlyqkpMPGhgLGuWj8iimf/Cu5SQAopbUxOY=;
 b=d8UoOSPTplKT1RMLDNl3Ve8a4r8HOXmUmhMbW1nNHJeXcY6QbLOtAhOTQKkOYWXdOMK+
 KlZx59ccgjfnRwOrKeyf39xuZ/iVWWIlukAxSSgvWmgz6InKjiaHgdDWTfv7V4xxRNPq
 QmYxNjSwuZtvw/U1+Au/pfAJvX/+l/Nqsko= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2xfar48fxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 13 Jan 2020 07:11:42 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 13 Jan 2020 07:11:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKWEdIZ0t9ltMhZJ5bikI3nO015E8SLJEyDeh7hVdTBsLRUaHtn6nZbg2Yq/MaJS4DZPuSH5WKjHNoqKaHkPJQ0FapjO2d2zxvO1OBs+xHEPCg/THEYDk8078Or35fmVKvv+H6CAQppUdIOwLkdbMbmwbhonrmQjMkD+ASsUMEmqnz8TMqI+FgavCBJTd6x0Veicg+qX9X1mW5NAInwwENcNia58Ukjk3+BxipoLpQMvslc82oq9p6NOQn8K5I171UvqaNpRDJ2GmKG76jatP16dXb5lK0redVWfv/gvODXEdN5/ClU08dytBlVdsHW2Cx6ngxvVjSB2wyvf8xkQkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4pi7wsXmlyqkpMPGhgLGuWj8iimf/Cu5SQAopbUxOY=;
 b=a7tWJNe9TYrBqspLnoj/I7QGGgDH1YVPEjB9InGRxKjD6uVRE82KPfZpIpfe0y5GHkCbeYkiVvF9JIdFuxSCKpoVYOhv5LT5I8khTlvuJxGd5HuojuIJ2BEpIF7q7ZVhhs8YaHtGv0ma3zq8RLOQNuWcrmDcywJYadb7ta8uMhpix2PZJzoKGTaJATsVRNns7SMX5yCxcdCgXZRZDEd9Q2lRdirjm17zkBV09fk3d88sao0+MR5dTfXRmU5WoqB56gMgRmJPD1Fst/IklVliEmDkyuQwovIZgO+T4IkgISVVv8o3E9G75MPEg+4VQARCvnEUMD2tfrNZAHAsLaUK2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4pi7wsXmlyqkpMPGhgLGuWj8iimf/Cu5SQAopbUxOY=;
 b=fIFsT5V5rgteg0UL3evkryHPh7eKetcijym8D8DSa4Q2M/MYdYJIhthZyWezrFGwIpvwGx3Rdo8m4vXqOUnVPFPnnMzRJDXicpFPyUqrEYxzhE7L7rSDsb3hHRU3/0bLdHCT45l8ArEDAJXLfcq6nr1IRUKf3HibrZ2zAxp+rKw=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB2616.namprd15.prod.outlook.com (20.179.154.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Mon, 13 Jan 2020 15:11:27 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 15:11:27 +0000
Received: from tower.DHCP.thefacebook.com (2620:10d:c090:200::3:6ab2) by CO2PR05CA0001.namprd05.prod.outlook.com (2603:10b6:102:2::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.6 via Frontend Transport; Mon, 13 Jan 2020 15:11:26 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v2 2/6] mm: kmem: cleanup memcg_kmem_uncharge_memcg()
 arguments
Thread-Topic: [PATCH v2 2/6] mm: kmem: cleanup memcg_kmem_uncharge_memcg()
 arguments
Thread-Index: AQHVxysvLmVWn6eilEKfaP/B4YhTxafknHcAgAQcoAA=
Date:   Mon, 13 Jan 2020 15:11:26 +0000
Message-ID: <20200113151122.GA22139@tower.DHCP.thefacebook.com>
References: <20200109202659.752357-1-guro@fb.com>
 <20200109202659.752357-3-guro@fb.com>
 <CALvZod59FA78-cgg1_T+qg6S-YW=VGu1Lj=j+uzWS9LzjAu1Xw@mail.gmail.com>
In-Reply-To: <CALvZod59FA78-cgg1_T+qg6S-YW=VGu1Lj=j+uzWS9LzjAu1Xw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:102:2::11) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:6ab2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1b71293-173a-4b98-ad1d-08d7983adc36
x-ms-traffictypediagnostic: BYAPR15MB2616:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2616DD987B93E7E31C6B1E20BE350@BYAPR15MB2616.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(376002)(366004)(39860400002)(189003)(199004)(81166006)(5660300002)(66556008)(66476007)(64756008)(66446008)(66946007)(55016002)(4326008)(2906002)(9686003)(33656002)(6916009)(52116002)(53546011)(7696005)(81156014)(6506007)(16526019)(186003)(4744005)(478600001)(8676002)(316002)(54906003)(86362001)(1076003)(8936002)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2616;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gC6DLByeTEQaWqlpHSon7A/X0SyJ3eM49l+7fD3F1jevZmwdowEOif1K+acSJTdAJRrF2NXtzFNkFAxdeesXz8+NFscnz7TxVW3/Rl9GPddLLNOha+kNjza/YLGk9S7EVcDNenyBICt4fBk4yQFOhA964A98gry9Cngku7fcg4IqfnqeUoCmvWsiBfjTeBxJ3/YHn2Qqp1OuqdtKdsI3UKKDdgflc5EFQUeWzFXrOyW27+aCeekKpKSky907Sun5a8sYuVDEIrYFHlm6XDJ1/4kRg4NTohmVCJX/PobjOalLoJ7ViB4ippwG120hSqYtQNZGt9mzv1rrk2nDLORv2pMCvvgvYHfTvVJtD0SU+eZUDcrL7kc1KRGW5Q5BlY7Q4nngCYVYCZuB123ciIDfZDv/9CEMPWrlZ/sJXYyADLmpWwavbs0qhPaB0N1n9WxS
Content-Type: text/plain; charset="us-ascii"
Content-ID: <82884D7911372843AF18904B35C8AE4C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b71293-173a-4b98-ad1d-08d7983adc36
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 15:11:27.1777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xcFaZPMOpYzVUmnm5QTlYE5skb4dBxzZLogDIjHpLuun9Vxslyq1ikr7+M267JWb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2616
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_04:2020-01-13,2020-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=644 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 spamscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001130126
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 04:23:52PM -0800, Shakeel Butt wrote:
> On Thu, Jan 9, 2020 at 12:27 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > Drop the unused page argument and put the memcg pointer at the first
> > place. This make the function consistent with its peers:
> > __memcg_kmem_uncharge_memcg(), memcg_kmem_charge_memcg(), etc.
> >
> > Signed-off-by: Roman Gushchin <guro@fb.com>
>=20
> Why not squash this patch in the previous one?

No particular reason, could be squashed too. Just made these changes one by=
 one.
Can be perfectly squashed, but probably it's not worth another version.

>=20
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Thank you for the review!
