Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81083C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A91520B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nfk9ZNse";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YPba05wB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbgFRUSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:18:24 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:31868 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726517AbgFRUSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:18:22 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05IKBo8S025293;
        Thu, 18 Jun 2020 13:18:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=4YGzrhLPDf91n3b5+3ADa5r7OkmCRMfChN6tsK7e4C8=;
 b=nfk9ZNsex7Iu1BrBNU1pCIAAN2A0gmk+lljEIfmiKXmYi9FvOLOYPEauzMUBs24uIS5w
 1uBz/xjrMo0NoPpIsINEeI2Z+v+RAfEDVMGwdpEs376ZxVac01JnWK6ZHYw2Oi2EDoDc
 Urocne79BrW2hFIoCVqaJmMOKyr7jAV6f+s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31q660x95w-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Jun 2020 13:18:15 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 13:18:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKeL1/nYgY1Ads4pKhxQg1EXRqcnKe0wxdT7Q/yo8h3pRRwYCtTSej51qwTP3yTVZ5j8gFKMV5rjt+3STWB8jAorJYm03aeqf43Y5nIHZoB2pH/TGVxYkr7oAFg31n5bV0YKJ5LrC19f5nG6ggo4SNIMWJC9CFzoSqDdOiqQFJ7pPCFRF8i+aQ94dQch3u1D6WDTZE4wa5ZuxFx0+aNtLd+2R2oCMQvT4xzrfhl8eN7uEtTDqOQ+SVtrOuIsf721VFzqupVrOjEmCT0FTIvREA/xyR/SJG0RQKUbD5G0OuBlAZUQWWIaciOxwddMYzKYwu9G8qx9qA1j3odugGunAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YGzrhLPDf91n3b5+3ADa5r7OkmCRMfChN6tsK7e4C8=;
 b=btweW/xv+nwi6NYj30XhX9D6WLxkFBiDE2EPTjXMb4+kmsDpul4oW+USHZjfn5MYJYce3bSGt3rgZbt5N0accaznSSTx+wOPJZDxfx594harEU6+CDA2dN1EMITHxMVUdhAnuFWX0AWX5tDMXkv5hgyjN1NBxN3wvE2OnRzeUB6nqLRoRd4O+D0MNTGKjV/0HUOGd8Sx54H6OUuLAMvjYIu7Ioa674Q8T3stWOVMajDo8dmFFbaH3ER53Etj21b2D1icqDcpu7HQ5eJeGD4Gxql4ZuOMeAfA9s/zZWmmV4yitHD1iGS2N8w6Sa7swlBP3z1CF5MtQViCzjpUkX+I+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YGzrhLPDf91n3b5+3ADa5r7OkmCRMfChN6tsK7e4C8=;
 b=YPba05wBPLcir509uyNUHwp7ABi+7CgN289EU0e9+qSHpbS1AlgfNgvkcWcF4vSc0tudsOrj+QATyAgtq6Cqf4rOiaOWNbIkcgeGFZCGzmXS2+PIL/qNXVw+MVgycIsNp7JHW7ysL4n15omj3P64azJ0ovTF0ZWARFqTzLb0+mQ=
Received: from BN8PR15MB2995.namprd15.prod.outlook.com (2603:10b6:408:8a::16)
 by BN8PR15MB3220.namprd15.prod.outlook.com (2603:10b6:408:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 20:18:06 +0000
Received: from BN8PR15MB2995.namprd15.prod.outlook.com
 ([fe80::a89e:b0f9:d0b9:51a2]) by BN8PR15MB2995.namprd15.prod.outlook.com
 ([fe80::a89e:b0f9:d0b9:51a2%5]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 20:18:06 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>, Tejun Heo <tj@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Francis Ricci <fjricci@fb.com>
Subject: Re: WARNING with LBR + precise_ip=2 + bpf_get_stackid()
Thread-Topic: WARNING with LBR + precise_ip=2 + bpf_get_stackid()
Thread-Index: AQHWRZVzS1zA6qEPN0CAIz19Cc1kQqjesqEAgAAdWwA=
Date:   Thu, 18 Jun 2020 20:18:06 +0000
Message-ID: <694A8714-F178-4211-A9DC-DA7604B8D5B0@fb.com>
References: <ED7B9430-6489-4260-B3C5-9CFA2E3AA87A@fb.com>
 <20200618183302.GN576905@hirez.programming.kicks-ass.net>
In-Reply-To: <20200618183302.GN576905@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.80.23.2.2)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:e176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73a6a2fe-d9ef-43bb-a0f2-08d813c4b66f
x-ms-traffictypediagnostic: BN8PR15MB3220:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB3220567870AE515D4534C7D3B39B0@BN8PR15MB3220.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FiT2INIyAy8VkGP8Jt1pufO1ySlr+c0A4ycHr5QAqJCOmoORuGLHl/CNejlqCwEoq226JtXeeD0OxY9YRrE4wArmb7K8Bs0e+GU4GrIjnlIoz9y5wlX824n9hZQRwVc4vHUCBe1IWsGMbbEceaGJCqqdeR54MWuiJQ6TwmLW/ukxRJ+iydRvoupcd0ytNh5JIS75uAu8+i4djt3j8GdfHffW4l825nYq5B+GIrYdfKIl2DwPyc6eL7dHdLUFcoALZcKhQJxPpw1xRClzSZGrzrKWNqy+mm4FEtN9GPEtjz55cQ1HcvxfwX9PMPLOKK4mb+18bEUUHGJARenokwuZ9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2995.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(346002)(376002)(396003)(39860400002)(4744005)(6486002)(5660300002)(2906002)(36756003)(478600001)(6512007)(6916009)(71200400001)(8936002)(4326008)(8676002)(316002)(54906003)(2616005)(33656002)(66946007)(66476007)(64756008)(66556008)(66446008)(91956017)(76116006)(186003)(6506007)(53546011)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: wOnz2fwJATWty+sQnfzaEOWGGcr2mVRxPq2D+K8Uq2K/SEKnjq9i/6CMulghUMjH1nQJsr/VyAVltzV36SLF0mKJVcfp0atCjBiAfF22d0eXJogOcfVzF3jL4NaGMKrCc5fMosr9udZt4UgcnYQk67n5Qa/6u8bpQNzFE2jzobnutBcmBy2ffgU/sAkX+hyL1nb9rWfkG5jLY7Gi7p10Av/LUFD3vuevOWCf1xkrlNrfO46kNx5A+eHWIh/jhGUyVHtzi+0riRWGnPmiYOMoOgkB6wROUL1ijWHp7ysp0XZhqiOvFghTN97O6r3qJ1mfx4iE7YDOkI96tqoAf4nJYdsBAd7IA36ez+zSFJLN0gerLcjohjZpczuVwEfEYb5EbuwqZrdsR7SCVGYpXINyLfAzlxk1RSZtoNRMZvGfohpyLUKTLweeuILoFp8xP2fcnRr79AXKL5++XWvue7s0J2igGwpniaspKfbkuiFMEZx+B/cgW6EeCqUwmV1FQAhaRQ7Q75eyVNhSRTJxgRlcGw==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E9AF1E6EE688B94C8D620B75FA83A5E1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a6a2fe-d9ef-43bb-a0f2-08d813c4b66f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 20:18:06.7512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XTsVS9Hj85jhSZ1wMQqXnSASU+57HGs+BlaikvFceJ0D0UYVxAx6r4nJWGkZ+vAeEcYOMI6hrQkZRUDvSAoZjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3220
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_15:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 clxscore=1015 mlxscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 mlxlogscore=835 adultscore=0 impostorscore=0 malwarescore=0
 cotscore=-2147483648 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006180154
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 18, 2020, at 11:33 AM, Peter Zijlstra <peterz@infradead.org> wrote=
:
>=20
> On Thu, Jun 18, 2020 at 05:25:24PM +0000, Song Liu wrote:
>=20

[...]

>> 0xfffffe00004d1380 __start_orc_unwind
>> 0xfffffe00004d1388 unwind_next_frame.cold.7
>> 0xfffffe00004d13c8 perf_callchain_kernel
>> 0xfffffe00004d1418 entry_SYSCALL_64
>> 0xfffffe00004d1450 get_perf_callchain
>> 0xfffffe00004d14b0 bpf_get_stack
>=20
> This, this is where it gets buggerd. This is a BPF problem, not a perf
> problem.
>=20
> You'll note that if you ask perf for a PERF_SAMPLE_CALLCHAIN we'll do
> that early in setup_pebs_fixed_sample_data().

We did notice perf works fine in similar scenario. I guess need similar=20
logic in BPF.=20

Thanks,
Song

