Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B410C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0F620663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="QC2aZGNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgCLNW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:22:58 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:39900 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725978AbgCLNW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:22:58 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02CCd8CQ006630;
        Thu, 12 Mar 2020 05:48:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=8GA/JcmvOIdjbFtI2qkXuFwFE0oCqdARTGdk//fqsT4=;
 b=QC2aZGNPeF1j7ssKflddzZBBFhmU/JaJsSSxuZeOgDcLaI/xlQylZW0iVeb17dgSEYxd
 6J54iqkrdnLw4AqKMWz1kWInJWw+38gT/SCr/janKQ8QN/9oqK/yiR/sW9sDeBa+OPoO
 Q1eChSogapnQOkpVFPdNJVIELyIP2/5LIjSI4LG4f5h6CkxE/bhYV9pHSghpUOFJjVH5
 p93bV13jEvqPdUGaUKrMd8kQlaWHLAN/c9CkOqtCRcfPdVC+E4O6ip0q35VrFHTlmz4V
 OtNylR5BwMq5i3Gwn2BGuN2OHmLGL2BGttbE0K+OVasW01FESMd4WFu3rs/m+qHl3D8r gA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0b-002c1b01.pphosted.com with ESMTP id 2yqf32rug2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Mar 2020 05:48:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIrcv6AiggXebWBDd1LTtKHT5JpcEZkJcCrDwuY1c7NbGSMF2wAk64Et0Vr5NxQZ+3aYw7mttLpBVyMqLf3HZozZCvx2v+VTmNDrQtgTHATTf67dBct8QJK1DGeeTNZp+3x2kNqGH09u0ayDrxmYdlEuzBBDNrWyY2XCvHt6TI0dKKvIVDPWZJzcjtulIiB6iVFqzrZsDlkGdbVgvWv5mpagnBQKzkkvPo4kPxmNnbBX4hmLd2HPjsDkTrybW4muRMgC78QYkn0QxOeFTlURj7Ugx0QAP72x4gFdV3ocTGlqFmlYV+e2T90N6Du6wNSVicCz5RxQ8DKlDWuTyG9w4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GA/JcmvOIdjbFtI2qkXuFwFE0oCqdARTGdk//fqsT4=;
 b=cgCe9SLpB3bpXzw4Npj7Z4PaYIpa79m0aoZrCFE89sWoyx0+EtbCa+DIJLBtSieTG9DlYDqRgcExhkK2uPV+uzxbsk34ir5+QiQCzNC8lQvF3Zo/eVLP/6Y/1vy+zn2+uvTfh3XAdclbe/yzNHZuO0KcZdUh2V02fVrvQwqDh66alci1lBBJsMWpla1HzdC+1fv3hkItdKGLjAStxbVwQW4MxzXxqWv2rg7YA7hkOBw8dPVNfK5jVMza/OIlxvqp93ar2SmnEMR/99znw5nDsC2P3ZLFUU/DErff9cSHOX5foxkq7kwhA2blihPq34jnieYSRkp03ZSEVUUYU+HjaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BL0PR02MB5601.namprd02.prod.outlook.com (2603:10b6:208:88::10)
 by BL0PR02MB5394.namprd02.prod.outlook.com (2603:10b6:208:37::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Thu, 12 Mar
 2020 12:48:22 +0000
Received: from BL0PR02MB5601.namprd02.prod.outlook.com
 ([fe80::ddf8:e6cc:908f:a98c]) by BL0PR02MB5601.namprd02.prod.outlook.com
 ([fe80::ddf8:e6cc:908f:a98c%6]) with mapi id 15.20.2814.007; Thu, 12 Mar 2020
 12:48:22 +0000
From:   Ivan Teterevkov <ivan.teterevkov@nutanix.com>
To:     David Rientjes <rientjes@google.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "oneukum@suse.com" <oneukum@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH] mm/vmscan: add vm_swappiness configuration knobs
Thread-Topic: [PATCH] mm/vmscan: add vm_swappiness configuration knobs
Thread-Index: AdX3zHNqbuFpQvKERxyPueA21j6FDgAD0RWAACPlSzA=
Date:   Thu, 12 Mar 2020 12:48:22 +0000
Message-ID: <BL0PR02MB5601808F36BE202813E9D562E9FD0@BL0PR02MB5601.namprd02.prod.outlook.com>
References: <BL0PR02MB560167492CA4094C91589930E9FC0@BL0PR02MB5601.namprd02.prod.outlook.com>
 <alpine.DEB.2.21.2003111227230.171292@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.2003111227230.171292@chino.kir.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d86b2342-960b-42d2-af6f-08d7c683a5ec
x-ms-traffictypediagnostic: BL0PR02MB5394:
x-microsoft-antispam-prvs: <BL0PR02MB5394092E586D2F494F6CB51AE9FD0@BL0PR02MB5394.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(366004)(396003)(39860400002)(199004)(6506007)(86362001)(33656002)(4326008)(55016002)(26005)(316002)(71200400001)(8676002)(8936002)(7696005)(66946007)(66556008)(81156014)(76116006)(52536014)(2906002)(81166006)(64756008)(66446008)(5660300002)(66476007)(478600001)(9686003)(44832011)(186003)(7416002)(54906003)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR02MB5394;H:BL0PR02MB5601.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xy/zmVSvxubRH65+qpwaALSw194iFNRzwDjNy628l5vjRWCPqk6KwExq2D5b9t0kXrhe7CsT4VFnjGMpdTTDpY5stBaaQM/uW2nlPKKuc9ErfRaBkf3zxejQs/xU7rQcVUvici4+KFwbg5tClaAGpiSLvp1xfQ8bN6OJVANwo2KciQTkgob4ge5AxaJHBHEncDqeKYz6Y/mzAMfYVj0p90tG8DAbRx602tpomVzgiHa0n47PV2F3Yu/fVxMS/F7bX7nCuPwILHIC+lo0qPVHEKirbKFifKAL3Gzk+VNihtFXatK0rDaFDcZPJtICMglQb9OGDnxhzpqLti48f3o6qreQYCa4H8Vph9df5K5+Y7CloE1I8tP/PoME7/mbx0C8zhkb9NVduntbAEEN8Mzy8XoLpXCMh4vAtFG+cY6sSKryIf5dm782roOGbjICDG4X
x-ms-exchange-antispam-messagedata: AYmqrfwa6yZksHLR7lxNLIGAa03wqywEvPuXR4wCJfwLA5ZBCivgnSQImD9/VkJyifSRudpq6uVU8ye6r3q9TbtkxZbbNpHBtCM4y0EGBL3yywx27M1sRL1hsEmi8ECEIGlMBb8+2NT2YhlS/kOnSQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86b2342-960b-42d2-af6f-08d7c683a5ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 12:48:22.2172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cCCLJ2Ik9QUsx4XVdtfPo6VHerR2TBnHDx5nqiC5GQmjL3VhftiwO9z1Ff91gJ4LcYEwBtHewxHJ0kOplqbfbOymLmu8a1lkDICfMgy6+rE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5394
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-12_04:2020-03-11,2020-03-12 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020, David Rientjes wrote:

> On Wed, 11 Mar 2020, Ivan Teterevkov wrote:
>=20
> > This patch adds a couple of knobs:
> >
> > - The configuration option (CONFIG_VM_SWAPPINESS).
> > - The command line parameter (vm_swappiness).
> >
> > The default value is preserved, but now defined by CONFIG_VM_SWAPPINESS=
.
> >
> > Historically, the default swappiness is set to the well-known value 60,
> > and this works well for the majority of cases. The vm_swappiness is als=
o
> > exposed as the kernel parameter that can be changed at runtime too, e.g=
.
> > with sysctl.
> >
> > This approach might not suit well some configurations, e.g. systemd-bas=
ed
> > distros, where systemd is put in charge of the cgroup controllers,
> > including the memory one. In such cases, the default swappiness 60
> > is copied across the cgroup subtrees early at startup, when systemd
> > is arranging the slices for its services, before the sysctl.conf
> > or tmpfiles.d/*.conf changes are applied.
> >
>=20
> Seems like something that can be fully handled by an initscript that woul=
d
> set the sysctl and then iterate the memcg hierarchy propagating the
> non-default value.  I don't think that's too much of an ask if userspace
> wants to manipulate the swappiness value.
>=20

This is exactly what I'm trying to avoid: in some distros there is no way
to tackle the configuration early enough, e.g. in systemd-based systems
the systemd is the process that starts first and arranges memcg in a way
it's configured, but unfortunately, it doesn't offer the swappiness knob.

There could be a script to iterate the memcg later, but there would be a
race condition with the system entity that's put in charge of the memcg
because the configuration can't be changed atomically, e.g. a possible
script could iterate the memcg tree and update each memory.swappiness
while systemd is creating another slice or scope subtree.

> Or maybe we can be more clever: have memcg->swappiness store -1 by defaul=
t
> unless it is changed by the user explicitly and then have
> mem_cgroup_swappiness() return vm_swappiness for this value.  If the user
> overwrites it, it's intended.
>=20

Does it mean that -1 would become a reference to the vm_swappiness
or the parent's memory.swappiness? It sounds interesting and if so then
it would address my issues with the swappiness but would also change
the existing memcg behaviour: if the referred-to value changed, would
the memory.swappiness backed by -1 also change?

> So there are a couple options here but I don't think one of them is to ad=
d
> a new config option or kernel command line option.
>=20

The vm_swappiness starts its lifespan in the kernel and thus
why not to facilitate it with a simple "constructor" there?

> > One could run a script to traverse the cgroup trees later and set the
> > desired memory.swappiness individually in each occurrence when the runt=
ime
> > is set up, but this would require some amount of work to implement
> > properly. Instead, why not set the default swappiness as early as possi=
ble?
> >
> > Signed-off-by: Ivan Teterevkov <ivan.teterevkov@nutanix.com>
> > ---
> >  .../admin-guide/kernel-parameters.txt         |  4 ++++
> >  mm/Kconfig                                    | 10 ++++++++
> >  mm/vmscan.c                                   | 24 ++++++++++++++++++-
> >  3 files changed, 37 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt
> b/Documentation/admin-guide/kernel-parameters.txt
> > index c07815d230bc..5d54a4303522 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -5317,6 +5317,10 @@
> >  			  P	Enable page structure init time poisoning
> >  			  -	Disable all of the above options
> >
> > +	vm_swappiness=3D	[KNL]
> > +			Sets the default vm_swappiness.
> > +			Ranges from 0 to 100, the default value is 60.
> > +
> >  	vmalloc=3Dnn[KMG]	[KNL,BOOT] Forces the vmalloc area to have an
> exact
> >  			size of <nn>. This can be used to increase the
> >  			minimum size (128MB on x86). It can also be used to
> diff --git a/mm/Kconfig b/mm/Kconfig index ab80933be65f..ec59c19e578e
> 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -739,4 +739,14 @@ config ARCH_HAS_HUGEPD  config
> MAPPING_DIRTY_HELPERS
> >          bool
> >
> > +config VM_SWAPPINESS
> > +	int "Default memory swappiness"
> > +	default 60
> > +	range 0 100
> > +	help
> > +	  Sets the default vm_swappiness, that could be changed later
> > +	  in the runtime, e.g. kernel command line, sysctl, etc.
> > +
> > +	  Higher value means more swappy. Historically, defaults to 60.
> > +
> >  endmenu
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 876370565455..7d2d3550f698 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -163,7 +163,29 @@ struct scan_control {
> >  /*
> >   * From 0 .. 100.  Higher means more swappy.
> >   */
> > -int vm_swappiness =3D 60;
> > +int vm_swappiness =3D CONFIG_VM_SWAPPINESS;
> > +
> > +static int __init swappiness_cmdline(char *str) {
> > +	int val, err;
> > +
> > +	if (!str)
> > +		return -EINVAL;
> > +
> > +	err =3D kstrtoint(str, 10, &val);
> > +	if (err)
> > +		return -EINVAL;
> > +
> > +	if (val < 0 || val > 100)
> > +		return -EINVAL;
> > +
> > +	vm_swappiness =3D val;
> > +
> > +	return 0;
> > +}
> > +
> > +early_param("vm_swappiness", swappiness_cmdline);
> > +
> >  /*
> >   * The total number of pages which are beyond the high watermark withi=
n all
> >   * zones.
