Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECF8C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83C6207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="jhaE541s";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="JiTDOaFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgAMPbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:31:37 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:24318 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726163AbgAMPbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:31:37 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 00DFTMTU021622;
        Mon, 13 Jan 2020 07:31:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=0KLPGoPecQavyPiHoG87v3pmLgf0vf8+HlKcXMH/WxM=;
 b=jhaE541sK3IDIldKJlOGXmYbTL7fHLrdRPOXIv9HBZGMuhKHcQi+/jMMogv216uzP9dM
 PGoNFcZmJz/IfVHSOyNuB8gb4bv6LknYAUpsWjez0okZJCRWmgDhbuI4a6o2TnGkHBCP
 26hE8DL7GcFcWIomTTh3V/T6oETMjD8cG1Y= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 2xfawr8kqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 13 Jan 2020 07:31:28 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 13 Jan 2020 07:31:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0FkjbQRIVkm9qrQ9GKgBV/YwxjabJiZSaQ7VM6eQXozhO3NPorVfg5H5SsTCt4K02LBKp4y2Gi95HV8Jyc6H4NCYQlaLVeK1bM93krUW8xCyoOcvSXJiqmviYpz+9vF01fsUBWifAOGWaX/FxtBTDUXQzb79aF1kFh8w5VkOxnHiAHsbnXFNyKKtGE+I4F0zuD1DY2S427jwnaEPoLGqhkuZ0Xb3TIKjYlYz8Cnp+OH8y7RNcWfefwPlsTwxLl7W5OCpO7FEx38KQyhCg8BCB0EWgXQQfOZocnSlQZL/POajilfRzdJ4oRwepmpKgabhyLwR29b9huTQvKE7R/fTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KLPGoPecQavyPiHoG87v3pmLgf0vf8+HlKcXMH/WxM=;
 b=HAOswPQLdlfmNzv7X0zIte2pMuN0z78ehfZR9+J80ayUhFrUMOqHNRvCqI4/TIkZ7a98sevSp/iYtHFRYHtXOXHg0vIu1Gte+rYzErBoS6IKzCyeoMn91HB9pcIvtsui9+e5qZA6wv59ZDgPBCWlzN5Kh1TfnpO1EFxVvB2CZTS9liL+njqsHcbIwOb9DRINfSqQxXNTnKFqn/I3x/8e3WfUVOtM1QMAOSDSJ7IhtHTrzIa80032s9guA6vAVno47F3jgUT+LTZc1CzYgc6ylBJ+ikhzggODX7FFdEAfBiCALcRjeufavPnL+wjRFShc+9QK40Jpxwaz3OuBXHbZZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KLPGoPecQavyPiHoG87v3pmLgf0vf8+HlKcXMH/WxM=;
 b=JiTDOaFMsaHvoyu7NnBTvpXeb/cgEIu0MjkZZC+xbiI2u3TCq1O6xQy8oRSsSS5CUq2idM821usUsdkJzkbhqf1FlCU2JCr9sV2Y3xfbEcqCLZHjvNNteGJK3i+v7q7UqsOCcXrrGN63MtGoL4zLEYIe5PwYus3HxvjmiCNy26w=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB2216.namprd15.prod.outlook.com (52.135.197.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.14; Mon, 13 Jan 2020 15:31:25 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 15:31:25 +0000
Received: from tower.DHCP.thefacebook.com (2620:10d:c090:200::3:6ab2) by CO2PR07CA0084.namprd07.prod.outlook.com (2603:10b6:100::52) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend Transport; Mon, 13 Jan 2020 15:31:24 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Bharata B Rao <bharata@linux.ibm.com>
CC:     "mhocko@kernel.org" <mhocko@kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "longman@redhat.com" <longman@redhat.com>
Subject: Re: [PATCH 00/16] The new slab memory controller
Thread-Topic: [PATCH 00/16] The new slab memory controller
Thread-Index: AQHVrnGR5S0BeZVm/Uu7NV5uFsOBDKexspaAgABmrQCAAM5tAIAAxC0AgDTTVQCAAHDugA==
Date:   Mon, 13 Jan 2020 15:31:25 +0000
Message-ID: <20200113153121.GB22139@tower.DHCP.thefacebook.com>
References: <20190905214553.1643060-1-guro@fb.com>
 <20191209091746.GA16989@in.ibm.com> <20191209115649.GA17552@in.ibm.com>
 <20191209180418.GA15797@localhost.localdomain>
 <20191210062308.GC17552@in.ibm.com>
 <20191210180516.GA23940@localhost.localdomain>
 <20200113084710.GC8458@in.ibm.com>
In-Reply-To: <20200113084710.GC8458@in.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR07CA0084.namprd07.prod.outlook.com (2603:10b6:100::52)
 To BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:6ab2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad295e7a-164c-49dc-b740-08d7983da66a
x-ms-traffictypediagnostic: BYAPR15MB2216:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2216D66833CB55261DB05ABEBE350@BYAPR15MB2216.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(376002)(396003)(39860400002)(346002)(189003)(199004)(33656002)(4326008)(16526019)(86362001)(6506007)(186003)(316002)(1076003)(478600001)(54906003)(6916009)(81156014)(66946007)(55016002)(81166006)(66446008)(8936002)(64756008)(9686003)(52116002)(66556008)(8676002)(66476007)(7696005)(71200400001)(5660300002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2216;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yQeVzjqD3P7CyWtNkgleUFzV5quRBjKTi85dswgZ21XbRP87vIwF4d3gkkWzoXmrCLVSW8/F8dxdpgPPma63D8O4aC3wW8v/AKcS9TvXa0OkNQwmDS3JQwTDxXDbx69aRWv5L0EAVzHclDbVg7Ind3XRgs3FopQhwHsfSvNRhJR+UGs5rGhp55SQe1SKnHwpPnJ53zo+SjtYmc4MgSWlslh8Alwkne34fINPk7XS+L5HOGIzXzfrGxfP4b2yOXkQ3c+ZeP5Q+fD5NOlb+VhVfIVNelZpB8sL9eIHD9+9rbClvzEVR0gRIwvnIMVpnPXcNW341Pym9C/KdicKPnez1IsVvAB2q7e6bxE9OqpUul4lqAjPm/C4l5qQVB1FiK7rZng0rF9hXqD/NOL+LKcQq25yBGsb7KwNL8ZsqYt2MKOqY+YAYlFyH1rmFisnxrVM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <979FC2F42C7F2C4C92026A30A929CC5F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ad295e7a-164c-49dc-b740-08d7983da66a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 15:31:25.2171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ae2TgFjOxqFOWVIsy1l3W5EDXDARGbRJAwf2sdXxFgxKfrqgXFNpTiYD8sGc6nX7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2216
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_05:2020-01-13,2020-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 clxscore=1015 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001130128
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 02:17:10PM +0530, Bharata B Rao wrote:
> On Tue, Dec 10, 2019 at 06:05:20PM +0000, Roman Gushchin wrote:
> > >=20
> > > With slab patches
> > > # docker stats --no-stream
> > > CONTAINER ID        NAME                CPU %               MEM USAGE=
 / LIMIT   MEM %               NET I/O             BLOCK I/O           PIDS
> > > 24bc99d94d91        sleek               0.00%               1MiB / 25=
MiB        4.00%               1.81kB / 0B         0B / 0B             0
> > >=20
> > > Without slab patches
> > > # docker stats --no-stream
> > > CONTAINER ID        NAME                CPU %               MEM USAGE=
 / LIMIT   MEM %               NET I/O             BLOCK I/O           PIDS
> > > 52382f8aaa13        sleek               0.00%               8.688MiB =
/ 25MiB    34.75%              1.53kB / 0B         0B / 0B             0
> > >=20
> > > So that's an improvement of MEM USAGE from 8.688MiB to 1MiB. Note tha=
t this
> > > docker container isn't doing anything useful and hence the numbers
> > > aren't representative of any workload.
> >=20
> > Cool, that's great!
> >=20
> > Small containers is where the relative win is the biggest. Of course, i=
t will
> > decrease with the size of containers, but it's expected.
> >=20
> > If you'll get any additional numbers, please, share them. It's really
> > interesting, especially if you have larger-than-4k pages.
>=20
> I run a couple of workloads contained within a memory cgroup and measured
> memory.kmem.usage_in_bytes and memory.usage_in_bytes with and without
> this patchset on PowerPC host. I see significant reduction in
> memory.kmem.usage_in_bytes and some reduction in memory.usage_in_bytes.
> Before posting the numbers, would like to get the following clarified:
>=20
> In the original case, the memory cgroup is charged (including kmem chargi=
ng)
 > when a new slab page is allocated. In your patch, the subpage charging i=
s
> done in slab_pre_alloc_hook routine. However in this case, I couldn't fin=
d
> where exactly kmem counters are being charged/updated. Hence wanted to
> make sure that the reduction in memory.kmem.usage_in_bytes that I am
> seeing is indeed real and not because kmem accounting was missed out for
> slab usage?
>=20
> Also, I see all non-root allocations are coming from a single set of
> kmem_caches. Guess <kmemcache_name>-memcg caches don't yet show up in
> /proc/slabinfo and nor their stats is accumulated into /proc/slabinfo?

Hello Bharata!

First I'd look at global slab counters in /proc/meminfo (or vmstat).
These are reflecting the total system-wide amount of pages used by all slab
memory and they are accurate.

What about cgroup-level counters, they are not perfect in the version which
I posted. In general on cgroup v1 kernel memory is accounted twice: as a pa=
rt
of total memory (memory.usage_in_bytes) and as a separate value
(memory.kmem.usage_in_bytes). The version of the slab controller which you =
test
doesn't support the second one. Also, it doesn't include the space used by =
the
accounting meta-data (1 pointer per object) into the accounting.
But after all the difference in memory.usage_in_bytes values beside some ma=
rgin
(~10% of the difference) is meaningful.

The next version which I'm working on right now (and hope to post in a week=
 or so)
will address these issues.

Thanks!
