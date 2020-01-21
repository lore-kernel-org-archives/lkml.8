Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A118EC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 18:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3C921734
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 18:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="V3C6TBQ6";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="F9CJLHbJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgAUS4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:56:36 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54566 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728186AbgAUS4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 13:56:36 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00LIuJ96006117;
        Tue, 21 Jan 2020 10:56:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Taax/73H7Tp0KWI1XGRQbJB9SfXH4ixZd4TGoZiRAfc=;
 b=V3C6TBQ6/XEECZL5kyjlngwBWpJiG/mOJ0W5x8szW8SMxNYLy0EChwukNsiwo5ALmiBg
 AYfQl3BTLKSIrxx3ECVrk+cNYxIit7sHT3U8r6gFqcjibc39BUACTFOUAewzDbdQN9nW
 sjYufnessN8No7zQ0UTtms1P92cvE+CJS4o= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xmjeut8mt-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Jan 2020 10:56:24 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 21 Jan 2020 10:56:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K776RscJURdSnUv0hyILa8xpJ+M4unoUxlf9y3fiIm7fIrUrg9uWtxDqQIOoZni4u1wWBWAMeZnTbGTMmnzpUKOjWLBryRu1eni8b4YTwBFVqiQKix94gWCYsAPDqq1vgnnRbbsUGmi+tOlbAmXVy2FZjsvDLpF0WBdO8Qo7KyBG1ro0WFm/7dzNhmPVh72iaGcNNk2jkXu1G7XzIhcYjNUbYniJhsf0QWjMEj+c5WErsTDPTYPP82VJOfUXepY8bnrCiw4Ele1TE0wUVUpibT5uK1S85QVNvvA0/9TmadXoTHbdEoBHCnUwuoxysICukz8+Rn0MtVQtbClAXHqEqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Taax/73H7Tp0KWI1XGRQbJB9SfXH4ixZd4TGoZiRAfc=;
 b=VBmV4LPgo7P1BMvBiXjNoqwkDX+tXcyyS8EfcNDXN73W8C8roBhv3eQIakasWjDSQIMEFR0skh2dT2u2A53/paqJ3Bkmqu5iqbmJb5kGw4IP8mBlgOxhdCB5wIAQcWIFXdbZaTD5tpS+Ig4JCt8QFlnwm+GbaNGH8npYxTu0qUlGW3btSJct7fihK9CFA87wZ2EAkpSYGPeH6UkGYnzY2ACi9g8J6X/MLZJwoxSpWJL/ztDPg6F/r3tGPiHGJWZOspfxKVYRuSSex7T8OY8rzrLqZiVSaeZfMAgFvEBWj9FoeE5o08BcU6ltfVrNQoD0ayMK5xZi7bQnOt5aKvQdUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Taax/73H7Tp0KWI1XGRQbJB9SfXH4ixZd4TGoZiRAfc=;
 b=F9CJLHbJLuHeR5qb0Vff5b3EgZX7Lnjc5Xb98NGx1y4D1R4XMwdslxrLJuK7VPlUid1wlCsRo3wy1WZMOAxJVp2Y5jkbc5TEq1oPiXeQPb412FNFQW2U/0EIqfJ9KoItiIedZ03uJ24zYc8yWQR68UQi6Sgv2MKHdA8UDdKDoqo=
Received: from BYAPR15MB3029.namprd15.prod.outlook.com (20.178.238.208) by
 BYAPR15MB3048.namprd15.prod.outlook.com (20.178.238.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.25; Tue, 21 Jan 2020 18:55:57 +0000
Received: from BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d]) by BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d%3]) with mapi id 15.20.2644.026; Tue, 21 Jan 2020
 18:55:57 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] perf/core: fix mlock accounting in perf_mmap()
Thread-Topic: [PATCH] perf/core: fix mlock accounting in perf_mmap()
Thread-Index: AQHVzZAqGLJCzWUf7k+i3M02AZWX8qfzOs4AgAJC5AA=
Date:   Tue, 21 Jan 2020 18:55:57 +0000
Message-ID: <79CAEE07-57BC-4915-A812-DD99AAF1B809@fb.com>
References: <20200117234503.1324050-1-songliubraving@fb.com>
 <87blqybknz.fsf@ashishki-desk.ger.corp.intel.com>
In-Reply-To: <87blqybknz.fsf@ashishki-desk.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.40.2.2.4)
x-originating-ip: [2620:10d:c090:200::3:aa7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c6e3d91-2962-4cdc-5201-08d79ea38c9c
x-ms-traffictypediagnostic: BYAPR15MB3048:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB3048DB97C38CD6D187583B1CB30D0@BYAPR15MB3048.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(346002)(39860400002)(366004)(189003)(199004)(186003)(8676002)(53546011)(86362001)(6916009)(71200400001)(6506007)(6486002)(2616005)(36756003)(6512007)(54906003)(5660300002)(33656002)(478600001)(4326008)(316002)(8936002)(66946007)(64756008)(66446008)(66556008)(81156014)(76116006)(66476007)(91956017)(81166006)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3048;H:BYAPR15MB3029.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qDdn7px+UOmvkgPQTzWmbpOyZ7U2IpQtmGfAIQ5oY11Jt/4AARMfhCWpGPmoputwoixh6y1Mkf1C2nOrtM6RT3myuSj9xO44IwYX1Pm0dMq8NIM918hKrpqkEdQRmqlPo2u1XTM0FCTjv0D9MhljbQLqA07KDYY/7J854tAbT/HCtTX0dUbG1DxDdc+MHcstNCbV5qfhq6c6+O0k5osnvgTnzdQWB3D2i1pH+StYYx0WFzEPXo3Xk1Zj72lmOb6vKvc7+XFpsEE3pc3WJB53tWNVr41qXLbPTF4fjtBn61Ae6wh9ZGoeh/2zGCITCiKrN4NlaUZhLJ8srTiCI+y/cdh0DBz36kP2FvogVAbLK+ekPq96cl3i7tdyNyS88eLJpmqmbVk2x1P/fCcDs9u2xjcKjY3Ahj1VH52yGm7oG6lfbB+Skhgd3nPP9eQLYboD
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D4D04A439997734D8ECA97E15013B5B5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6e3d91-2962-4cdc-5201-08d79ea38c9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 18:55:57.0608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oU3AI63j6/wRg9cc0w46loPOOsKw1hGm/wTj1aOGCarA8JsA07/1fIN/Dd6bmaGoFZ/YYOI+n1mfXPTIhvhKhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3048
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.634
 definitions=2020-01-21_06:2020-01-21,2020-01-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 spamscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001210141
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 20, 2020, at 12:24 AM, Alexander Shishkin <alexander.shishkin@linu=
x.intel.com> wrote:
>=20
> Song Liu <songliubraving@fb.com> writes:
>=20
>> sysctl_perf_event_mlock and user->locked_vm can change value
>> independently, so we can't guarantee:
>>=20
>>    user->locked_vm <=3D user_lock_limit
>=20
> This means: if the sysctl got sufficiently decreased, so that the
> existing locked_vm exceeds it, we need to deal with the overflow, right?

Reducing sysctl is one way to generate the overflow. Another way is to=20
call setrlimit() from user space to allow bigger user->locked_vm.=20

>=20
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index a1f8bde19b56..89acdd1574ef 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -5920,11 +5920,31 @@ static int perf_mmap(struct file *file, struct v=
m_area_struct *vma)
>>=20
>> 	if (user_locked > user_lock_limit) {
>> 		/*
>> -		 * charge locked_vm until it hits user_lock_limit;
>> -		 * charge the rest from pinned_vm
>> +		 * sysctl_perf_event_mlock and user->locked_vm can change
>> +		 * value independently, so we can't guarantee:
>> +		 *
>> +		 *    user->locked_vm <=3D user_lock_limit
>> +		 *
>> +		 * We need be careful to make sure user_extra >=3D0.
>> +		 *
>> +		 * Using "user_locked - user_extra" to avoid calling
>> +		 * atomic_long_read() again.
>> 		 */
>> -		extra =3D user_locked - user_lock_limit;
>> -		user_extra -=3D extra;
>> +		if (user_locked - user_extra >=3D user_lock_limit) {
>> +			/*
>> +			 * already used all user_locked_limit, charge all
>> +			 * to pinned_vm
>> +			 */
>> +			extra =3D user_extra;
>> +			user_extra =3D 0;
>> +		} else {
>> +			/*
>> +			 * charge locked_vm until it hits user_lock_limit;
>> +			 * charge the rest from pinned_vm
>> +			 */
>> +			extra =3D user_locked - user_lock_limit;
>> +			user_extra -=3D extra;
>> +		}
>=20
> How about the below for the sake of brevity?
>=20
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 763cf34b5a63..632505ce6c12 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5917,7 +5917,14 @@ static int perf_mmap(struct file *file, struct vm_=
area_struct *vma)
> 	 */
> 	user_lock_limit *=3D num_online_cpus();
>=20
> -	user_locked =3D atomic_long_read(&user->locked_vm) + user_extra;
> +	user_locked =3D atomic_long_read(&user->locked_vm);
> +	/*
> +	 * If perf_event_mlock has changed since earlier mmaps, so that
> +	 * it's smaller than user->locked_vm, discard the overflow.
> +	 */

Since changes in perf_event_mlock is not the only reason for the overflow,=
=20
we need to revise this comment.=20

> +	if (user_locked > user_lock_limit)
> +		user_locked =3D user_lock_limit;
> +	user_locked +=3D user_extra;
>=20
> 	if (user_locked > user_lock_limit) {
> 		/*

I think this is logically correct, and probably easier to follow. Let me=20
respin v2 based on this version.=20

Thanks,
Song

