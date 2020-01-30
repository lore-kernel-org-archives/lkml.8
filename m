Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA47FC33CB2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 02:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE39206D5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 02:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="prEKWpAM";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="LQMuE0Ov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgA3Clz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 21:41:55 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35954 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726719AbgA3Clz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 21:41:55 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00U2au16013744;
        Wed, 29 Jan 2020 18:41:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=TDktIcI5o9ZCItUIhhVsmJxLHnhN2ITyMd6+sSXbToA=;
 b=prEKWpAMdmYZHyoMmGn3xcKdAAH0AftLIfhb5eSDiQvhVmFZHL44e11oSw41/EPXahje
 30KtTa381+Svu37nRPkDspc4LoTyvz/IqVby0z1Ug9KA6ctkiPrP0bCRCb49GMmlnnZL
 YMqWupMfISZ/hGSdXioO+P0HICycMab0jiw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xucv9aw19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 29 Jan 2020 18:41:44 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 29 Jan 2020 18:41:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgUGIFejpJOfZx2sO73oAUuo/hT8Uo5Mfu0qPTV0c9IXHKPL8OFPJn8WuYcF/frNXIz9CFMjxGzJYb26JN+VQ3HqzJgw3Rv5RFpYtqHYzbe61S7FFqba1S9MQSmT8lxdMWOfg2ccKhsPSKyxWBhvEMSDBhZYkbBt4SmLmaJ3qyKGhUpRlD24i/YpZMoUx4JzVcQXgZEImIijbdzB7aTUTs0EOL+u0sclpsSNdsAATBOB2eXkccPEK2LduconbD/3bY2i3QgQLRzuZbSeNUKd8nvmCjRZTogipWXnVFz0A9UPnMH8b3mozIHHKyO6U7KdfjMk+X48OT2Cyw2qzNlBIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDktIcI5o9ZCItUIhhVsmJxLHnhN2ITyMd6+sSXbToA=;
 b=SCKjRMko9Fk82bczehT28uVvJQSnbHhq/+b37wMk0WYvkqULxAyXrkg6HqeNRCqlKDUwUQYuUchG4PeICuc+a/pClfT1IgJzSiczog9SlcXxGndPvovueE8K4HwNmrcN4xWh4T3uxSpNxkZaMzRaUerN75Wcnsiok/OuHimHheO2Q9yh93Jdw7O06CIXbgNU5v06cYwS/kqsmxO0IV8DdiMyVkpzidu4GdpTmnrNKGs6lpVP8kFqJ14JAQau4DZvihRk4pmVf51P2n6huYBuGvOEbquBeDTE0y4vBURgtCMRkbsmH9NPmbrXp6MYxy46+X6/fGRxBkxtZ9LvMZO7qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDktIcI5o9ZCItUIhhVsmJxLHnhN2ITyMd6+sSXbToA=;
 b=LQMuE0Ov5an7jyn5XL/p8KEm4nVxlGwopLoFRnm9wcQ0K7nBEUc19ReZ58fDafis+sku8aPpplWwJhBnNhBZO1Ssffeb1ld/WRinsTpimuknToiaL3PB/WAuvJ5HBBx2R78SKwkK8iM92S1/b/cMEf4vqE8cCjqhgEgXhusyUSQ=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB2854.namprd15.prod.outlook.com (20.178.206.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Thu, 30 Jan 2020 02:41:41 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2665.027; Thu, 30 Jan 2020
 02:41:41 +0000
Received: from xps.DHCP.thefacebook.com (2620:10d:c090:180::ade2) by MWHPR22CA0036.namprd22.prod.outlook.com (2603:10b6:300:69::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend Transport; Thu, 30 Jan 2020 02:41:39 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Bharata B Rao <bharata@linux.ibm.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Vladimir Davydov" <vdavydov.dev@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 00/28] The new cgroup slab memory controller
Thread-Topic: [PATCH v2 00/28] The new cgroup slab memory controller
Thread-Index: AQHV1Thx8lEkKPj+0UO2O+yf+Epkr6gCeVAAgAAJ0oA=
Date:   Thu, 30 Jan 2020 02:41:41 +0000
Message-ID: <20200130024135.GA14994@xps.DHCP.thefacebook.com>
References: <20200127173453.2089565-1-guro@fb.com>
 <20200130020626.GA21973@in.ibm.com>
In-Reply-To: <20200130020626.GA21973@in.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0036.namprd22.prod.outlook.com
 (2603:10b6:300:69::22) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::ade2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc0a3bfd-d647-4ab8-c8b3-08d7a52defb4
x-ms-traffictypediagnostic: BYAPR15MB2854:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB285426024DDA0A3AC15C7B70BE040@BYAPR15MB2854.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 02981BE340
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(346002)(39860400002)(366004)(199004)(189003)(1076003)(54906003)(71200400001)(52116002)(478600001)(7696005)(6666004)(316002)(6506007)(5660300002)(8936002)(186003)(55016002)(33656002)(16526019)(9686003)(4326008)(2906002)(81156014)(8676002)(66556008)(66476007)(66946007)(81166006)(6916009)(66446008)(86362001)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2854;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XWXEa6aVOxNVnnG2u4KHw324a3WIU3OuBwcUdgL2zKzegF647aUEYrjOeyp+557vESRr8/59jWcN8/3GU+vNTeb2F0afD62Hi+neHK5z5wasDG0Y89avB5MS4/kw9Y1rWQZBveWuTrNN8AJoK9pHa3J24KXtIdhgcAqryU7Zt3uus3729ECpgD5fSD99/IOVs1n3o/S93pZMblL01jMeuyX2Zpmbc5eG8I8B+XDQpjgriULQGqOlO1EO9kw+3f8S4RY9auYkHI61rv2aehVt8cNO9Y5HTQIsQILxdKjDI6FRzF++y5wmSupwL+/blJK2rwUTk+9xILzt3VGQduq9jVt3nlTVJCCpFZCc5zL8leJ32BFbCIFW59RXFMtnb3nyAIMwEMkST5i3JuBHRKDtIgdoFgmqhLNmEJFvKhVEudZ+KIe5l+DVdn0SUt8GgvY2
x-ms-exchange-antispam-messagedata: TVngLFPb78gNxXV4WKFytFx0TvSPZfdh4oQjg4khlbZhAUq5swN2SQpZuKwOjDXJJv0HpAzXXe13JIWOJFhuZQjvx4O7RJ81UXqA+80RrCehWO0xpXNmUAPoWESqrh6iMHVTSbyZ3nIW48HOQvY9iH16KQJDIZ2fKRZ8JjhS7uM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B4E436C6CCD5734981B919CCFDCD468D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0a3bfd-d647-4ab8-c8b3-08d7a52defb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2020 02:41:41.5665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hwcWntSBxYuS5ifI0pnKFKxiT/EQ+oovErVhPXcBe7bCSDpaYeI9dehbgmTg7gc+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2854
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-29_08:2020-01-28,2020-01-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001300014
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 07:36:26AM +0530, Bharata B Rao wrote:
> On Mon, Jan 27, 2020 at 09:34:25AM -0800, Roman Gushchin wrote:
> > The existing cgroup slab memory controller is based on the idea of
> > replicating slab allocator internals for each memory cgroup.
> > This approach promises a low memory overhead (one pointer per page),
> > and isn't adding too much code on hot allocation and release paths.
> > But is has a very serious flaw: it leads to a low slab utilization.
> >=20
> > Using a drgn* script I've got an estimation of slab utilization on
> > a number of machines running different production workloads. In most
> > cases it was between 45% and 65%, and the best number I've seen was
> > around 85%. Turning kmem accounting off brings it to high 90s. Also
> > it brings back 30-50% of slab memory. It means that the real price
> > of the existing slab memory controller is way bigger than a pointer
> > per page.
> >=20
> > The real reason why the existing design leads to a low slab utilization
> > is simple: slab pages are used exclusively by one memory cgroup.
> > If there are only few allocations of certain size made by a cgroup,
> > or if some active objects (e.g. dentries) are left after the cgroup is
> > deleted, or the cgroup contains a single-threaded application which is
> > barely allocating any kernel objects, but does it every time on a new C=
PU:
> > in all these cases the resulting slab utilization is very low.
> > If kmem accounting is off, the kernel is able to use free space
> > on slab pages for other allocations.
> >=20
> > Arguably it wasn't an issue back to days when the kmem controller was
> > introduced and was an opt-in feature, which had to be turned on
> > individually for each memory cgroup. But now it's turned on by default
> > on both cgroup v1 and v2. And modern systemd-based systems tend to
> > create a large number of cgroups.
> >=20
> > This patchset provides a new implementation of the slab memory controll=
er,
> > which aims to reach a much better slab utilization by sharing slab page=
s
> > between multiple memory cgroups. Below is the short description of the =
new
> > design (more details in commit messages).
> >=20
> > Accounting is performed per-object instead of per-page. Slab-related
> > vmstat counters are converted to bytes. Charging is performed on page-b=
asis,
> > with rounding up and remembering leftovers.
> >=20
> > Memcg ownership data is stored in a per-slab-page vector: for each slab=
 page
> > a vector of corresponding size is allocated. To keep slab memory repare=
nting
> > working, instead of saving a pointer to the memory cgroup directly an
> > intermediate object is used. It's simply a pointer to a memcg (which ca=
n be
> > easily changed to the parent) with a built-in reference counter. This s=
cheme
> > allows to reparent all allocated objects without walking them over and
> > changing memcg pointer to the parent.
> >=20
> > Instead of creating an individual set of kmem_caches for each memory cg=
roup,
> > two global sets are used: the root set for non-accounted and root-cgrou=
p
> > allocations and the second set for all other allocations. This allows t=
o
> > simplify the lifetime management of individual kmem_caches: they are
> > destroyed with root counterparts. It allows to remove a good amount of =
code
> > and make things generally simpler.
> >=20
> > The patchset* has been tested on a number of different workloads in our
> > production. In all cases it saved significant amount of memory, measure=
d
> > from high hundreds of MBs to single GBs per host. On average, the size
> > of slab memory has been reduced by 35-45%.
>=20
> Here are some numbers from multiple runs of sysbench and kernel compilati=
on
> with this patchset on a 10 core POWER8 host:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Peak usage of memory.kmem.usage_in_bytes, memory.usage_in_bytes and
> meminfo:Slab for Sysbench oltp_read_write with mysqld running as part
> of a mem cgroup (Sampling every 5s)
> -------------------------------------------------------------------------=
-
> 				5.5.0-rc7-mm1	+slab patch	%reduction
> -------------------------------------------------------------------------=
-
> memory.kmem.usage_in_bytes	15859712	4456448		72
> memory.usage_in_bytes		337510400	335806464	.5
> Slab: (kB)			814336		607296		25
>=20
> memory.kmem.usage_in_bytes	16187392	4653056		71
> memory.usage_in_bytes		318832640	300154880	5
> Slab: (kB)			789888		559744		29
> -------------------------------------------------------------------------=
-
>=20
>=20
> Peak usage of memory.kmem.usage_in_bytes, memory.usage_in_bytes and
> meminfo:Slab for kernel compilation (make -s -j64) Compilation was
> done from bash that is in a memory cgroup. (Sampling every 5s)
> -------------------------------------------------------------------------=
-
> 				5.5.0-rc7-mm1	+slab patch	%reduction
> -------------------------------------------------------------------------=
-
> memory.kmem.usage_in_bytes	338493440	231931904	31
> memory.usage_in_bytes		7368015872	6275923968	15
> Slab: (kB)			1139072		785408		31
>=20
> memory.kmem.usage_in_bytes	341835776	236453888	30
> memory.usage_in_bytes		6540427264	6072893440	7
> Slab: (kB)			1074304		761280		29
>=20
> memory.kmem.usage_in_bytes	340525056	233570304	31
> memory.usage_in_bytes		6406209536	6177357824	3
> Slab: (kB)			1244288		739712		40
> -------------------------------------------------------------------------=
-
>=20
> Slab consumption right after boot
> -------------------------------------------------------------------------=
-
> 				5.5.0-rc7-mm1	+slab patch	%reduction
> -------------------------------------------------------------------------=
-
> Slab: (kB)			821888		583424		29
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Summary:
>=20
> With sysbench and kernel compilation,  memory.kmem.usage_in_bytes shows
> around 70% and 30% reduction consistently.
>=20
> Didn't see consistent reduction of memory.usage_in_bytes with sysbench an=
d
> kernel compilation.
>=20
> Slab usage (from /proc/meminfo) shows consistent 30% reduction and the
> same is seen right after boot too.

That's just perfect!

memory.usage_in_bytes was most likely the same because the freed space
was taken by pagecache.

Thank you very much for testing!

Roman
