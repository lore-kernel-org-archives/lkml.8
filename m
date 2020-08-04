Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB37EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 18:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 882B3206DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 18:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="rGblPsO3";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="dN3+Z61l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgHDSA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 14:00:56 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41424 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725826AbgHDSAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 14:00:53 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 074HnLI4009249;
        Tue, 4 Aug 2020 10:59:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=pa8u/GKLY4RbyaexJihD8zu2qgRcBQY18akMNg3FhhY=;
 b=rGblPsO3KfnaB5TPykulwB7GreR4tE2makZsPSiOxgB1hsF5yCmj2qqbl4Rd/vlvhp51
 9YjNUVBRecUpfJL3chela06KisI4MGX4fFsLARsb6yDUrrflkElizoE93XiyRfILP0sS
 U0+kPzUotlTy5ZFVw6hOFEpC4uIcUyWaZqQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32n80tdu9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 04 Aug 2020 10:59:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 4 Aug 2020 10:59:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWWIPtp8GIM2CI84w9p4tDunzMK1nJUU+bcMm2/mk4IW6NWKgg1LhTxlvqfLwyHHpmUx60rGuLAmhC3RwjntEJRHro+vhCaUgV9gYka7A55Bk3f+6njt6jtUlNeIPzj50M3eJP3CPb7nC/fwyI0eGJPH1cVcbxvx+Ip2vgUEs6/yNT9IfpPFDDrx8Jbb85DQDYZ0ro1co50maCEa3dxGinlMwD/1mYqSLqRK/YycRhJQoe+fJeWLor9o67l++/D849T1QO5HPhrLlP/jvMf6dr/jIBmcmQctFD7RkMQAEOHqflnE4IubUkHv9sb8F7/xjyURv1RsXha+Nkpm7bndlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pa8u/GKLY4RbyaexJihD8zu2qgRcBQY18akMNg3FhhY=;
 b=icYNgTM+XKexu7EO5IWPHHurc0mp6fPuDqD2nZQVUZfKV86jezDtQ1o1OmZmBynjn6ZwulPTh+nEUswwH/sct/fcN83sEtZIiSQ5+EMyYWdjlCbTG024fSgAGxNcPQaLP/XG7Ud+xwiLBGSI20+yhZ+A48ErD/h+OEVje3ZUfvwnRAS3gPcdogwckJt601vZNtaaMckDBFeJQnIc0Qzd1RRS1sQqokUNRsf5irJCJsQDPLu/AFDPEoCRydd3cobkCWBmBIgq7Cunjtsam7jVBHdAXhTqg4KaDcdPc1m/nF+j1QtKA9zcEI0LcnGJKKyJ70Ld8oZxmewt5f13NlW68w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pa8u/GKLY4RbyaexJihD8zu2qgRcBQY18akMNg3FhhY=;
 b=dN3+Z61lOFWVawQt+/Shz+69C4cZccGLb2bJBEpf4jPU+Hvt3SEaQoLiBbVOiRqwfNiZ7YMcr90UKypGGPrSdhmHbPAzfF/eUqId2QEZUzJJU0mS1EPzJP26kWtUARywoMS91SdSmysqxYub77eIpQh/Qa/EFCY1VstJzcKaw3s=
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by BY5PR15MB3569.namprd15.prod.outlook.com (2603:10b6:a03:1ff::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Tue, 4 Aug
 2020 17:59:49 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::f4b9:8011:9aaa:e4ea]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::f4b9:8011:9aaa:e4ea%3]) with mapi id 15.20.3239.022; Tue, 4 Aug 2020
 17:59:49 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
CC:     Nick Terrell <nickrterrell@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Kernel Team <Kernel-team@fb.com>,
        Yann Collet <yann.collet.73@gmail.com>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Sven Schmidt <4sschmid@informatik.uni-hamburg.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] lz4: Fix kernel decompression speed
Thread-Topic: [PATCH] lz4: Fix kernel decompression speed
Thread-Index: AQHWac5eBX2DbmatdkS0UNeom8wg5qkm7qKAgAAP/ACAADLTAIABDQgA
Date:   Tue, 4 Aug 2020 17:59:49 +0000
Message-ID: <9753118F-84DD-44C4-8B8C-F45B8EE0FC14@fb.com>
References: <20200803194022.2966806-1-nickrterrell@gmail.com>
 <20200803215747.GA1644409@rani.riverdale.lan>
 <3961E1BD-8F58-4240-A3B3-B7032A405B42@fb.com>
 <20200804015654.GA1943218@rani.riverdale.lan>
In-Reply-To: <20200804015654.GA1943218@rani.riverdale.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: alum.mit.edu; dkim=none (message not signed)
 header.d=none;alum.mit.edu; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:9999]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4f4e021-9c92-4804-593c-08d838a02e1a
x-ms-traffictypediagnostic: BY5PR15MB3569:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR15MB35698A86F306B0D49D13BD21AB4A0@BY5PR15MB3569.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lH0n4+VUAOu+ZAUkK9stXsmjls+zD54QWr9b+iMUsPzYxKcmgHm5ARlsweMEeWqx28VUVDKIm4+0qp+bR3X6xHG4dAJ6aYdz5QCWjg42QQGRfAhvuKTIdgEf2XKwSnDkJlT0ClAuxA24a6Xt9jjss6fphuVYltNl/RcXpLBEWQ7JRYc0isQ1b25uHbSavCHoWblhMtEeoTgt5CHunqxyOyXFZ6QI1GDPg9ljKzu9KeNVONFKghmSSFNuOdQESko7NwqH7raOzsNt4uJEdX/xWjiP4hOFsXEK2uvO1c+51vxk+oujR1GsPrdfs+c9soCs4avw6DkUzQ+1KcsQRjroqUEBFxBCVImfA9X6HhvQ78HUlB7rRaAdMRFy69ZCgbI5+NGPWDI1iwOleMzqNF9O0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(366004)(346002)(376002)(39860400002)(2906002)(6486002)(66556008)(478600001)(966005)(66446008)(71200400001)(64756008)(66946007)(66476007)(33656002)(2616005)(6512007)(76116006)(86362001)(8936002)(8676002)(4326008)(6506007)(5660300002)(53546011)(83380400001)(54906003)(316002)(186003)(36756003)(7416002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Ya3lbs6WjmHPxKeA2qEgaJFk1W8WMDxeGt+9duLfLU9bkTsT0wyzL65IEbslZ7aTv++Q6wPDBtPuXJhzIvYNVV7Kl9j/vPggrKm9y9xIXr8dB7co6OS5kJAu2ngdDxLeSWymWPvd9Yji4/bL/mPm54YKos+SnXdWOBXe7FveiUTgf7lo8/6dGcC82b9Mx7FI7l65wK62IysJX6s18x0p8MFP5DV7Jo+moOHkeC79jhQeO/3c1oB1RzmOyxyvk4iRoclGTOm0ClnXf5jVKCOiRV66FVWLRGgXlJBi/Tn44HDgTDmwfNBexJQysLgui4w1km2yvDYqy57mESyUVMdv6h60N37PEpUrpWBMywkIi9j4TYcsidCz4W41lkKBtKv9cjw7BSzuRwqY7qtPAEbGZnYcBx7zUeMdH4Xrv1BGQgE06Zz8myPdoP6JiUj5W/LHy/m6fOx9sHFyatw7phznrWdfUGxXOBRovD0yZmQq0YiK7s+EJ4Ob0gx0EKqAax9auIf2lmx5vgzEb4w1UThTM4VAhd5WVYKOtQbns/FdhWy6ZUHe7a0r04Qr9l7FloRRQRfbg5ZlYc9e0puXB75LVtj7csQfbBFdSzKVov5gt1kyVR8duMt6CO1Mso1+JFE/9n9qmqqKfWKtrcHS/fcBm8kZz6cHwpwG4zw2DupqMEHWpVIkoJZAW4Seaa2FmQVu
Content-Type: text/plain; charset="us-ascii"
Content-ID: <39F0AC20E99A4E4F95D2504E8AE871BB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f4e021-9c92-4804-593c-08d838a02e1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2020 17:59:49.0857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F7qmsQQAIbNYAgwG5Z7HyZ/bJ29Ux/P9lLrxyBuFeZgxfDs6ViQ2WNfeU1ymp/NL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3569
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-04_04:2020-08-03,2020-08-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 mlxscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008040131
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 3, 2020, at 6:56 PM, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>=20
> On Mon, Aug 03, 2020 at 10:55:01PM +0000, Nick Terrell wrote:
>>=20
>>=20
>>> On Aug 3, 2020, at 2:57 PM, Arvind Sankar <nivedita@alum.mit.edu> wrote=
:
>>>=20
>>> On Mon, Aug 03, 2020 at 12:40:22PM -0700, Nick Terrell wrote:
>>>> From: Nick Terrell <terrelln@fb.com>
>>>>=20
>>>> This patch replaces all memcpy() calls with LZ4_memcpy() which calls
>>>> __builtin_memcpy() so the compiler can inline it.
>>>>=20
>>>> LZ4 relies heavily on memcpy() with a constant size being inlined. In
>>>> x86 and i386 pre-boot environments memcpy() cannot be inlined because
>>>> memcpy() doesn't get defined as __builtin_memcpy().
>>>>=20
>>>> An equivalent patch has been applied upstream so that the next import
>>>> won't lose this change [1].
>>>>=20
>>>> I've measured the kernel decompression speed using QEMU before and aft=
er
>>>> this patch for the x86_64 and i386 architectures. The speed-up is abou=
t
>>>> 10x as shown below.
>>>>=20
>>>> Code	Arch	Kernel Size	Time	Speed
>>>> v5.8	x86_64	11504832 B	148 ms	 79 MB/s
>>>> patch	x86_64	11503872 B	 13 ms	885 MB/s
>>>> v5.8	i386	 9621216 B	 91 ms	106 MB/s
>>>> patch	i386	 9620224 B	 10 ms	962 MB/s
>>>>=20
>>>> I also measured the time to decompress the initramfs on x86_64, i386,
>>>> and arm. All three show the same decompression speed before and after,
>>>> as expected.
>>>>=20
>>>> [1] https://github.com/lz4/lz4/pull/890
>>>>=20
>>>=20
>>> Hi Nick, would you be able to test the below patch's performance to
>>> verify it gives the same speedup? It removes the #undef in misc.c which
>>> causes the decompressors to not use the builtin version. It should be
>>> equivalent to yours except for applying it to all the decompressors.
>>>=20
>>> Thanks.
>>=20
>> I will measure it. I would expect it to provide the same speed up. It wo=
uld be great to fix
>> the problem for x86/i386 in general.
>=20
> Thanks. I tried using RDTSC to get some timings under QEMU, and I get
> similar speedup as you have for LZ4, and around 15-20% or so for ZSTD
> (on 64-bit) -- I see that ZSTD_copy8 is already using __builtin_memcpy,
> but there must be more that can be optimized? There's a couple 1/2-byte
> sized copies in huf_decompress.c.

I tested your patch. I saw the same performance as my patch for LZ4, as exp=
ected.
I saw that zstd decompression time went from 84 ms -> 63 ms, a 25% improvem=
ent.

I will get started on a zstd patch. I look forward to your x86 patch gettin=
g merged!

Thanks,
Nick

