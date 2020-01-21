Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D80C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 19:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8657F2073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 19:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bKUujUIl";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="hcDQvYVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgAUTfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 14:35:48 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:4780 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726229AbgAUTfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 14:35:47 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 00LJT5pv030145;
        Tue, 21 Jan 2020 11:35:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=UZa+g8i6nyI45FsSmsTDMWJFiz+MxhyCPj7gZXTJQ0I=;
 b=bKUujUIlnVcEadvfL9pH/C4dh0OlBvYPiADghHOVp6FzWQveCK9ZI4RutRMRdfG9BUXI
 P12u1YaQHAfircuil2TKy9CoRZermTLKfa6NEyhkeTCIlSFPig0B0jfUrtJxGDr73/tI
 mR7FqKOvowWvWUE/yKcgh2yz0kACyNWoaHY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 2xp5vs0k0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Jan 2020 11:35:35 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 21 Jan 2020 11:35:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+pEjz154vOODRklc8MQtI/zEsKEcgzNL+Z0WqN7GcCqFMc0Fie+YkQNvuTd+dYRjs8EzvaMzg4g+4zJe2+9XjGuSyg5gf92enpL509qnes6e0GUxPbTT97KqIBM3H3e1+NPiQeGq04hGQoeabPyHULK1h3xVvcKsnaRZSBBXqvsD4jKToYvbh6PGxNP1nqGHFZZ2J86nbLbS4hVI86/ek5O0Vkf79Lx9DvdbFgyKWjLt5izCt4UvwNVMcY4NNAMB4J+BXQCU0rqUsX2d3UYddMpTVzJNSjiFboAFxSX753lDSYUXHZSWeloVGSXmPGSAj0uzUHOhI0Qghk3D/bc4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZa+g8i6nyI45FsSmsTDMWJFiz+MxhyCPj7gZXTJQ0I=;
 b=icunvZN72Nc6U8/0MueRv2eCqFd7iNgAezc2yiuwtYGr3eRkCzQyznXRHX/2H0Z9e/Oy+hiIW9nEWDbGc4Rp7VptdXz4b1jJELyCZ5eSuDH3V3oAd4s6Xlcq6W0z1KCd6Qpd+WJKBhyvZfGvKXVhtf83n029aSJzDhaqJWjU8kaPdRmHSLDWG0JoaVZ7pUs9yTGJaCZDhOjCfaESFOaySEaNclmHRutcj5IOfIcSMn63uSfeeQW9/Cf9Q2e7sm2p7rGHcB3/cf+22w1phATxwMhSaB8hMAR9AZW3Yxu6Le0OW3nyW/aAfHPR4rENaQZKAjMvMr24Ah5xui5P03958Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZa+g8i6nyI45FsSmsTDMWJFiz+MxhyCPj7gZXTJQ0I=;
 b=hcDQvYVptp8F933rh5OvQ2VR3dSVyn7pjXFp9sBpL2ElU3XkbOvZO/PFgibx+9Cd0jFlNNaUOhNXbq7ljzt0AvqlKhMoZJNWoQZsyMKF7tm47creQ0NF15WWwMUaA83/gjJ2MGb+/VBBfY63Tw9puclBxfuY59UWThlpcxPN6mo=
Received: from BYAPR15MB3029.namprd15.prod.outlook.com (20.178.238.208) by
 BYAPR15MB2807.namprd15.prod.outlook.com (20.179.158.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.24; Tue, 21 Jan 2020 19:35:33 +0000
Received: from BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d]) by BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d%3]) with mapi id 15.20.2644.026; Tue, 21 Jan 2020
 19:35:33 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] perf/core: fix mlock accounting in perf_mmap()
Thread-Topic: [PATCH] perf/core: fix mlock accounting in perf_mmap()
Thread-Index: AQHVzZAqGLJCzWUf7k+i3M02AZWX8qfzOs4AgAJN9AA=
Date:   Tue, 21 Jan 2020 19:35:33 +0000
Message-ID: <5145CBD8-9CBA-4B26-B48E-2E974E42A28E@fb.com>
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
x-ms-office365-filtering-correlation-id: c85da22e-eeb3-418c-f2c9-08d79ea914d7
x-ms-traffictypediagnostic: BYAPR15MB2807:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB28071FA3A0604AB4BAE9BEF9B30D0@BYAPR15MB2807.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(53546011)(64756008)(66446008)(316002)(66946007)(76116006)(66476007)(6506007)(66556008)(71200400001)(6486002)(36756003)(6916009)(86362001)(6512007)(186003)(478600001)(2906002)(8676002)(81156014)(5660300002)(81166006)(33656002)(54906003)(2616005)(8936002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2807;H:BYAPR15MB3029.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bve4oI9Ry0D9zZ6AGwTt4Y/kk/uSM7/QahAQwUWDSFqx7arsXLDyRW1Z1VzSZ0ziqJiRZZcYDevMu++x/LhXVcLPCjX2am21n26yBD+S4m3n64n5aGqYIGYsFfeHbGuuZhUgmfISb0e4mNSUHTZY5a+GdtEjUNudJh1w8yjmvMvKZPXDP4J4InunclHL0Owr8TagtgLDGwDbWcILOnu+Gh9Bw5pFFJPeOWF32Ur/4gzj8+YyIh3YY9L6r6syVOSEUWwHWj5UfOYi+aisS6u9klIvxjNSYzB3YPJOyP3IMWe91zxJyS3JcPbbrhSsn68coIwVrcNhISbZFsbV+A8i+IB8t+3JooiNVGTWDOJy3mGQ39Qwi0GPNvI81+G/zD6pifcx4qiwBt+0vH/tuF+w19tYwvDvpnEcBbRW1LZx1l9+f7LlzbZl0Hqq2/8pVS/X
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D134823B1594E54D8C5B4A7CA7C968DD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c85da22e-eeb3-418c-f2c9-08d79ea914d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 19:35:33.0384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kR2amDUF17CC00qapi90Nk7vpj0GIZxTMLKfvNTe5vjBcvGSAU9rDoIlH12L3xLkWfTW1h7S5MEQxfCyUiuYIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2807
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.634
 definitions=2020-01-21_06:2020-01-21,2020-01-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001210144
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
> +	if (user_locked > user_lock_limit)
> +		user_locked =3D user_lock_limit;
> +	user_locked +=3D user_extra;
>=20
> 	if (user_locked > user_lock_limit) {
> 		/*

Actually, I think this is cleaner.=20

diff --git i/kernel/events/core.c w/kernel/events/core.c
index 2173c23c25b4..debd84fcf9cc 100644
--- i/kernel/events/core.c
+++ w/kernel/events/core.c
@@ -5916,14 +5916,18 @@ static int perf_mmap(struct file *file, struct vm_a=
rea_struct *vma)
         */
        user_lock_limit *=3D num_online_cpus();

-       user_locked =3D atomic_long_read(&user->locked_vm) + user_extra;
+       user_locked =3D atomic_long_read(&user->locked_vm);

        if (user_locked > user_lock_limit) {
+               /* charge all to pinned_vm */
+               extra =3D user_extra;
+               user_extra =3D 0;
+       } else if (user_lock + user_extra > user_lock_limit)
                /*
                 * charge locked_vm until it hits user_lock_limit;
                 * charge the rest from pinned_vm
                 */
-               extra =3D user_locked - user_lock_limit;
+               extra =3D user_locked + user_extra - user_lock_limit;
                user_extra -=3D extra;
        }

Alexander, does this look good to you?=20

Thanks,
Song=
