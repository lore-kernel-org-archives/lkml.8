Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A48FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 22:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5ADB20705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 22:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="OsUimM/f";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Pvd1WGTu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgAaWhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 17:37:17 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50240 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726206AbgAaWhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 17:37:16 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00VMUFff005172;
        Fri, 31 Jan 2020 14:37:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=iuw/AxQntj12wh0tIGz0jaS0Tg2qc3eFF8D/MSDfl/A=;
 b=OsUimM/f5q0de4fOMbzv2yCsLIJgAPiGw9gIJlWPty7/IFkho3fGMuhxKX+96bU7ux+e
 r44Nwh5YGL3FPMEgQLa9+68YsztX3VHEI26vC5yOqJlH/5Ciibm0ruOL+1cd2VK61nLG
 3lQ5pywQkWXRcfiUDgRaY+O9RkLdpSEnutc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2xvs2gsav9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 31 Jan 2020 14:37:07 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 31 Jan 2020 14:37:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCeWRNU8luiqlGnZLRliLB+HLduLaPWfJ3S1GlyIbBD2IoFJ1vv6xHeeYRa8MJRV5LzuMM4T0SfJv35IHrOXSi+uEvfUZBSqhwuleZGk3mqmzelQx1vBewf8ffr3g8/BxVPSHReEJrO7X+rBEAw7CxhYTJ+gJek7nHcFMKJ4s77aJobi3QqV40Y4ekthyEJIORP5GxhLMlzom1vciJj2rCekkSRCiiAJUJQLxiNlvLHdD6DCZ1zIF/hFSeu8LR+SvF4PFjBaCiWRixkm8mONENAAyM8jS4TAHoevE4QMMC4QObMs/qd6za5SJmjtsBwrQINbGYyrNJp4xFSVF1HQtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuw/AxQntj12wh0tIGz0jaS0Tg2qc3eFF8D/MSDfl/A=;
 b=GDohGWSI13L7tvhRwNfzvbjC0vuZUwYdNbbntiPDo9fhdC5F2Tre7zG1ck9PIEHgktiFqsBbgvDn6uiCR+uIXx+Plvdl2rJYx596ewT43KgXKcETIoPougnzRb3JyFH0E8puLBiEj7S7ch6axNE3tw+091Igc/DSjAAdA3OKoTwqiisuUJ/Vx8r5bXHTZOxrIcqc/jKO0MWNgYXKkhD6kUaNEuAHba3ZNkbbTXnfNxOiWJaIj3/3pQfulrE0L1P1Y6Cbj+n0oOsPBK7jUTh1PWaz9Uz8V6t0PrXS8PenZsU+aHse+1dbjs+0HHHgJYFGVOC1oIW4+Zi3DHJCxP+DOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuw/AxQntj12wh0tIGz0jaS0Tg2qc3eFF8D/MSDfl/A=;
 b=Pvd1WGTuMqQSbt04aY50lNJP+FavYc0jJjydG8n96KOz7pctxJu5md2D6pTY4ZAa/YJTM1FCwWgvzlzxyN98kAShU73JLgtNc9C2m88/8eHwqYICMtZxZzoodFTqFS+QxKx16nEkzQ5cBIiMhhl7bjNZeBvSW87NeYl7oUjh6lY=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB3382.namprd15.prod.outlook.com (20.179.58.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Fri, 31 Jan 2020 22:37:06 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2665.027; Fri, 31 Jan 2020
 22:37:06 +0000
Received: from xps (2620:10d:c090:180::e269) by MWHPR1401CA0022.namprd14.prod.outlook.com (2603:10b6:301:4b::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.23 via Frontend Transport; Fri, 31 Jan 2020 22:37:04 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
CC:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mm: Allocate shrinker_map on appropriate NUMA node
Thread-Topic: [PATCH v3] mm: Allocate shrinker_map on appropriate NUMA node
Thread-Index: AQHV2FDEQ0TLsOdw8U+0qIMbICIwsKgFXUUA
Date:   Fri, 31 Jan 2020 22:37:06 +0000
Message-ID: <20200131223700.GB20909@xps>
References: <158047248934.390127.5043060848569612747.stgit@localhost.localdomain>
 <ebe1c944-2e0f-136d-dd09-0bb37d500fe2@redhat.com>
 <5f3fc9a9-9a22-ccc3-5971-9783b60807bc@virtuozzo.com>
 <20200131154735.GA4520@dhcp22.suse.cz>
 <a03cb815-8f80-03db-c1bd-39af960db601@virtuozzo.com>
 <20200131160151.GB4520@dhcp22.suse.cz>
 <fff0e636-4c36-ed10-281c-8cdb0687c839@virtuozzo.com>
In-Reply-To: <fff0e636-4c36-ed10-281c-8cdb0687c839@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1401CA0022.namprd14.prod.outlook.com
 (2603:10b6:301:4b::32) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::e269]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8b9575c-e0a4-429f-7af5-08d7a69e1973
x-ms-traffictypediagnostic: BYAPR15MB3382:
x-microsoft-antispam-prvs: <BYAPR15MB3382B98DB7C8269BF3C94BCABE070@BYAPR15MB3382.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 029976C540
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(376002)(396003)(39860400002)(199004)(189003)(316002)(2906002)(54906003)(186003)(33716001)(16526019)(6496006)(478600001)(55016002)(9686003)(9576002)(1076003)(4744005)(5660300002)(6916009)(86362001)(52116002)(81156014)(8936002)(66556008)(8676002)(66946007)(64756008)(71200400001)(66446008)(81166006)(4326008)(66476007)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3382;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GtUVL/52shDvoWRuWz2GqJbg5rnNNG1w7cDLWC9peAGggRtenzAsYkXr8Eb5bp3dSSIEVAEQgWl5ppv4gBbwTPiYrMDlHSaijk98IYRVj8ohdn6jy0ZsCLajDNZxFGiYh9NeLQwSMOaeoYACqgdTL5B3SXnFYoJwl242mDW30guXdAskFi+THh95SyygLw+WVcWN9+285zauPPslsYNwKKLYZbefP0ahK/Y902hACmfLMDp9rgo69f+PBR8Rs5vKeWf/AY7XcT0Ouz0lJtJ13CWuodF9BKNUwdAxCHRGOm2vUZkRlUO+TSUvNeaeVUnMshglMoyxxlEHGgG+azUQmBPW0vKGfsf+VCeWCnv+uOBYzRZu1S/HIX7ESXXWoU848t9VuGAdIh6oA0+7drCubESxhCKlPW8Kw4tLwPtdcY3i+qudk/h7rMx13GyHLXjO
x-ms-exchange-antispam-messagedata: ylZV19NanquandY1DFZ4XBLWBLSaTPStRyNByn0LDm4NDXNnBY+AcbL/xbBqJlOli0trQB3P3R5L05YlnI09dJAocGXl8N5kwZeh67CCrY6cuzg05x0NP1g9aKUQAoORxqx6OF4h+/QMArYspz8ZKv1sE/TL/OMpiCBjc9npb2Q=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DBD59B52FC8B0C409AB494BF87D6213C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b9575c-e0a4-429f-7af5-08d7a69e1973
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2020 22:37:06.0535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vnHSXEqW3/cr0eCNBLXMJqkm2iqCUgSCGzcXyE5mMSo3kzixSvlKlNZLPt5rkDE1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3382
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-31_07:2020-01-31,2020-01-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=696 adultscore=0 clxscore=1011 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001310179
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 07:08:49PM +0300, Kirill Tkhai wrote:
> mm: Allocate shrinker_map on appropriate NUMA node
>=20
> From: Kirill Tkhai <ktkhai@virtuozzo.com>
>=20
> Despite shrinker_map may be touched from any cpu
> (e.g., a bit there may be set by a task running
> everywhere); kswapd is always bound to specific
> node. So, we will allocate shrinker_map from
> related NUMA node to respect its NUMA locality.
> Also, this follows generic way we use for allocation
> memcg's per-node data.
>=20
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks!
