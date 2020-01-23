Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10D2C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 17:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAECA207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 17:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="QUVqXlen";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="LetSPxRM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgAWRY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 12:24:26 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56740 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726605AbgAWRY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 12:24:26 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00NHMGnE006182;
        Thu, 23 Jan 2020 09:24:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=M7Zp3MAx8ilI2OXAHDH9JT6r3PGucj1IV3tg6Si79ro=;
 b=QUVqXlenHf0x6IVYbD5NkhqDtWSH2MRgOElpt125g6PsNrQM5N8OuD+hSWeHmOaYEtIf
 GEfSMpGOtuq8sV0GLmK+ShqfspjYgjLyL+KffZONjjt48m1eyE5rBigbSVBBhS4SI6fy
 ASza/YC0OoZatrcm7mQJExzW4ObZqGf6Eds= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2xqemegdcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Jan 2020 09:24:13 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 23 Jan 2020 09:24:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAFfcddBGcIC4jMEarm8ZAMEAI47YpuGqEHf18TKDzQDYob1nmPrT4PRaXvzWlSwxey+jrk8WJ/SdAv8EN/VAyEylZ3G7ZZHSVcFNHuewjspF8EJEB955Kt4e77ysiPoEuv60kmn0z0fnqx0zkx+XfypnC3qBOuO0AfByiyiwxbJK2obT4M6nTYZrp27lUuICbbdZS+dnmz/MTRcnqhbCKbu3cTgihxou1B1WZOcAkmcmN09MtpZiHT/hvOD4SmrldormMa8JBw6GY36G6ciF1+im2h4i8El14t174yu5yPy2Yu0sYm8uq85zGD3a+Cm/HIqaUVT9pfr/iLZz+09Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7Zp3MAx8ilI2OXAHDH9JT6r3PGucj1IV3tg6Si79ro=;
 b=M2oVPZ272IVaCP9aHWPPCHISM8++oSq1qQWxVMk0EQET+Cv4F5WvWlSn5Fn5K3fjvzoQSaUPkQnVb+YrhSFB0Kf9PRbWGlnfy4m1wBxVqbeqwDYKzOchoVcvlgQKLvf3ukxDYbtjwqwLjrdkVUIjSRyIu1U4m3JLlTVzslrAdXrhjP9k6ar6jUTkW4xCqaXTD3MR/XKosSxWPqUqVG4y8iBXDWN76fT2fVW/koZpzmEnJdzv4G1Cmyu3rbcHI4aK5+oA4mPeVVBDXih8hPnyHevloaCCiM23Q7wjQ5MxBQzYsWSrmq37XHkKXG+GHIpzEVi/4NtOZyYlgUpq0S7p5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7Zp3MAx8ilI2OXAHDH9JT6r3PGucj1IV3tg6Si79ro=;
 b=LetSPxRM7w6bYfNRML68vwywtHKjymn1JM2KOhcEyJ6csjtp4GK4SvwPzgzwfv0k9CCrKVxVpkDh+VVvEmbO1P5gGnjf3jyv9w4Omk+7UXUv3xr5Ke3ySmv64BdlJCaz/YTwy/92qZtFpkAVQpFPIfARuzUYytqEbVa5OGZ7BAE=
Received: from BYAPR15MB3029.namprd15.prod.outlook.com (20.178.238.208) by
 BYAPR15MB2807.namprd15.prod.outlook.com (20.179.158.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.24; Thu, 23 Jan 2020 17:24:11 +0000
Received: from BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d]) by BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d%3]) with mapi id 15.20.2644.028; Thu, 23 Jan 2020
 17:24:11 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] perf/core: fix mlock accounting in perf_mmap()
Thread-Topic: [PATCH] perf/core: fix mlock accounting in perf_mmap()
Thread-Index: AQHVzZAqGLJCzWUf7k+i3M02AZWX8qfzOs4AgAJC5ACAAoOtAIAAh1iA
Date:   Thu, 23 Jan 2020 17:24:11 +0000
Message-ID: <DE0F33E7-79BD-4817-ABD6-7D8E57074802@fb.com>
References: <20200117234503.1324050-1-songliubraving@fb.com>
 <87blqybknz.fsf@ashishki-desk.ger.corp.intel.com>
 <79CAEE07-57BC-4915-A812-DD99AAF1B809@fb.com>
 <875zh2bkcv.fsf@ashishki-desk.ger.corp.intel.com>
In-Reply-To: <875zh2bkcv.fsf@ashishki-desk.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.40.2.2.4)
x-originating-ip: [2620:10d:c090:200::2:1c66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c691de0-5742-42d1-f660-08d7a0290fd0
x-ms-traffictypediagnostic: BYAPR15MB2807:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB28075FFE81AAC8206FA089DDB30F0@BYAPR15MB2807.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(66446008)(91956017)(66556008)(64756008)(6506007)(316002)(76116006)(66476007)(66946007)(53546011)(71200400001)(6512007)(36756003)(6486002)(86362001)(6916009)(186003)(478600001)(2906002)(4744005)(4326008)(81156014)(2616005)(33656002)(54906003)(8936002)(8676002)(5660300002)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2807;H:BYAPR15MB3029.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LGvr/1kunxHIn4xw//pz42UZU2MRqveMNsy8J1KGi/1Rtt+8ILjlH0VV6Opjn13wIn7E9DVBZEx9+7xtP94t902FxPSap0Hoon3xgBD50IM3Suz6bOwZIHCjkb9ohbBs1sWt03ley+qxp7dz9VQQOqN8E5jMEYyT88ZAgzKivf5BUGuCaogfTGRiCTgQ5n6YhNTGx871V4CLFJI4CtydOVZvQm1RTAMf3dgObFxidtR5AiP1oXywyZEisNc+BzF+Skh+dDRlw2PXWt35F1+VQgIwhRY/AW7Y4mWqni21pRnPTf5QbWcCyXoEbVWSFqcnXb8ciut3bvBSe103b1mqEOKtg6Dvuy8Ph2YMqQCOjFTbHRPqvVEDTIPfMdl+qp3Zl0j8x/OGCzagh7F8pnl2LH1MbOsbeBLQiD5AiAOO7UjvAh6DRLXqEVpbXXQ0kZuz
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5E4B3D98726EB54F88F99C2E6F0790DD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c691de0-5742-42d1-f660-08d7a0290fd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 17:24:11.3441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IDna76OpIRhx8GFuUcx3luFgE5jcq4AQpVVgVwrAyol0w+hNV8NYGZDTQwva3PI5KwFyVkI08wNKMBT7c0mCeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2807
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-23_10:2020-01-23,2020-01-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001230135
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 23, 2020, at 1:19 AM, Alexander Shishkin <alexander.shishkin@linux=
.intel.com> wrote:
>=20
> Song Liu <songliubraving@fb.com> writes:
>=20
>>> On Jan 20, 2020, at 12:24 AM, Alexander Shishkin <alexander.shishkin@li=
nux.intel.com> wrote:
>>>=20
>>> Song Liu <songliubraving@fb.com> writes:
>>>=20
>>>> sysctl_perf_event_mlock and user->locked_vm can change value
>>>> independently, so we can't guarantee:
>>>>=20
>>>>   user->locked_vm <=3D user_lock_limit
>>>=20
>>> This means: if the sysctl got sufficiently decreased, so that the
>>> existing locked_vm exceeds it, we need to deal with the overflow, right=
?
>>=20
>> Reducing sysctl is one way to generate the overflow. Another way is to=20
>> call setrlimit() from user space to allow bigger user->locked_vm.=20
>=20
> You mean RLIMIT_MEMLOCK? That's a limit on mm->pinned_vm. Doesn't affect
> user->locked_vm.

This depends. For example, bpf_charge_memlock() uses RLIMIT_MEMLOCK as the
limit for user->locked_vm. This makes sense, because the bpf map created by=
=20
a process may stay longer than the process.=20

Thanks,
Song

