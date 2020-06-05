Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCD5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68FC2206FA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="i2scYsaj";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Keq44251"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgFEV7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 17:59:33 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36154 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728126AbgFEV7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 17:59:32 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 055LwBDw032732;
        Fri, 5 Jun 2020 14:58:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=3ihJKPlYIQosm9gNE4h0NCMmsxHKu2k+AbR3zYhPUAQ=;
 b=i2scYsaj5Ly1z78IQgi2yq5x6CX1EEujk9URQlH8keffr+R37kOqpbGh77KBAcwaMdDx
 0Ee3MKPhqGJT8cd/du5+ylTq4VtcpNuvjTJh7sg9l+IIlwL5mz3rY9cYni5nrMT/1I6r
 /f5OGMIYzbT0VKdcK9S/PFTRknKkI0kqrcA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 31f8yj5q95-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Jun 2020 14:58:50 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Jun 2020 14:58:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7V3y57zXOYJi7Kceu+V9Bhop1mXL+R0pv9tFHlRBO63Np83L8BJHQHl9Id2x/eimlaXiC8gDgpLxclh8wJYP1SQjC/yChEcOqK12cv/5ip/MTjJByuhdw3y+MrSIQsUVHB7V2o5LsYN197dPIEiWKH3TPrnyGlzfREYZDOVKl1c7BS79ntJ6jSmt4Rh3LpiSZxbGYWhByZAIk9mLacT7Sq7HT/Bc0MRnEv9q0P5bA2vIBEmedDmY5MVP08bIO89bJN1r57bZcU0eCX61L/kVV2Y64nRI+8LHsy4JxB86xb3lh9MvPtHQfAxmU2+7zTqRWm3c96+Y9iDFqpIzY51JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ihJKPlYIQosm9gNE4h0NCMmsxHKu2k+AbR3zYhPUAQ=;
 b=JpgDQdO2vCWZZUJI1MjP0PkO3CI5QHweIk+bF7vuSfnR4SPg7Xuf1ghVN/lDYa3aOE2gN65vgIKXmeYdx0AbKd5Yyf2n8ytig9xaJ/kHjeM/wLprG6p67imuzI3yam+Z9L6jmYNEc9cVQN3RsFbsufMKTnXMV/SvsTMJbXotrp25l68Uoum2ZUdQXsrhlSYZiGionLf1283lsEIbw8lKhKyyG+ybCe0VU45t95Xa4EqnIx/qs9fRX8/u7gy+l30VcEvMuk4enllGsMgyXnZ1FAA/Gl3wGYv4d/ihWxAc967i/Nc2SQfk+e5CblmuIN+3Df0c+MR59bKGthGw0NcYGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ihJKPlYIQosm9gNE4h0NCMmsxHKu2k+AbR3zYhPUAQ=;
 b=Keq442516jv6x39YVZuZoAk5sdmjXlocT2Zor2AnJQvBB3k+iDWxFOvn64vjXTYFabhuKYm8Mlh64HhkaLEFkrIDUbqcB91v1gGO2FIjHrR5vTxg0S6BxzYHaZSeRuIpqFgMeScoIbQjC7WT0Pco+KWYVK9u1CiuvzDYcT+N1VM=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB3431.namprd15.prod.outlook.com (2603:10b6:a03:108::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 21:58:48 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::bdf1:da56:867d:f8a2]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::bdf1:da56:867d:f8a2%7]) with mapi id 15.20.3066.018; Fri, 5 Jun 2020
 21:58:48 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Jiri Olsa" <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [RFC] perf/core: allow ftrace for functions in
 kernel/event/core.c
Thread-Topic: [RFC] perf/core: allow ftrace for functions in
 kernel/event/core.c
Thread-Index: AQHWM6ViVS5deg/n5kWgZSYX+yJPDqi65OeAgAACB4CAAAIsgIAAAuWAgA+1r4A=
Date:   Fri, 5 Jun 2020 21:58:48 +0000
Message-ID: <595AB855-8E84-4367-AEEC-C140F035C9B4@fb.com>
References: <20200526212826.4097888-1-songliubraving@fb.com>
 <20200526213913.GG2483@worktop.programming.kicks-ass.net>
 <A9B20D93-748B-4789-801E-91720E2D4F28@fb.com>
 <20200526215415.GH2483@worktop.programming.kicks-ass.net>
 <20200526180437.45aed950@gandalf.local.home>
In-Reply-To: <20200526180437.45aed950@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.80.23.2.2)
authentication-results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:a3db]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5bba2ea0-b803-4fd1-030f-08d8099ba006
x-ms-traffictypediagnostic: BYAPR15MB3431:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB343177319523A0FA56628677B3860@BYAPR15MB3431.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0425A67DEF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: USrx3LA+tCcG5aKouSXJqP+b1qX6iDXA8B+QPxWkesKIzVjnUGQw46TTWmmX3541JgGSsd0Tzr1FDN0Rt2joABXiG4oYH3iPD2IjN1ps9QnVFC0PoUy7/8+YiEc+b8pKujsda6mvbX8q0WReoF4dKRpoMEhyM3B8igS2vF7wrmCqsQMnbCWsfHVQjPNTN7+FPrmHL0vG3EDfMU4RqWhMSa1xkA7s15bS3Pr5P+Er8A8pXTBP00oXuH4AwvDYW9UpkuFELDjKo+4rROor3yyNyGuYXd5aQ6UJEBRGLOQ1loinDPSfzUEWpHkAyAprWw3keETeEK7+IEhDC7HCgd8Tkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(396003)(346002)(366004)(39860400002)(64756008)(7416002)(6916009)(8936002)(5660300002)(53546011)(316002)(71200400001)(86362001)(2616005)(6506007)(8676002)(66446008)(2906002)(54906003)(66476007)(478600001)(6486002)(4326008)(76116006)(66946007)(36756003)(66556008)(186003)(6512007)(83380400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: FmH0i33zPzUdtskpS3xoGbiGCjlKNYmqzSVmvBazaXB+UZAAaIp1bkKsxvhrJrPjSp7/3Mgcj1CTSMO5HZ0UaRL3R30woNVX+4NaFTEnlXKP2pRTsvtvwSEXMN7RtCaWHjNw5dWVbBK2JdSzKmWKNbPEBG6G/QlQYzOGok6Z2ACcex5o31oHoFb1v5/ToBUP6ISlmwX4Yw6ZEDADrTx/1aVvmeIaQUilrxPUbqEMdEZVLMbzBLu+5zXdbYLadZnuVEBtcu1UsMLeqve8gOWukHfqJG26EprfYS/fZbvEn9xPyhBevywSjYyqLUhIrI1k83crUJSAQAMZXUgnjdmz0KoT4DISHbkiVF0GLDIvB0AFyKaa0G152pVsaJ+OXKO1VPIHX90SUe450pFctOIMpD3ic1+H59kscU1hbrpJBvMyoPa4ApHAORUWbzL1h//N6KlGWYl8JcuAUfgEQ2xCjGQ0PMuPZVeK1/JdJfJ8ptqPDwewxtNh9MOmYmkgSd0g6oKMSIA4mJ4czxM8aW/oAw==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3B708EC0B62139489A007044228224FB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bba2ea0-b803-4fd1-030f-08d8099ba006
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 21:58:48.1015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mKDi+xJE31ZWWgSp50grQXb89bEfMPg3++dyeVmUysNxZuEeQMNzokRQHuPubsuDBgdmChrY8eTPCAh8UeiL9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3431
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-05_07:2020-06-04,2020-06-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 bulkscore=0 cotscore=-2147483648 malwarescore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006050161
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

> On May 26, 2020, at 3:04 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Tue, 26 May 2020 23:54:15 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>> On Tue, May 26, 2020 at 09:46:29PM +0000, Song Liu wrote:
>>>=20
>>>=20
>>>> On May 26, 2020, at 2:39 PM, Peter Zijlstra <peterz@infradead.org> wro=
te:
>>>>=20
>>>> On Tue, May 26, 2020 at 02:28:26PM -0700, Song Liu wrote: =20
>>>>> It is useful to trace functions in kernel/event/core.c. Allow ftrace =
for
>>>>> them by removing $(CC_FLAGS_FTRACE) from Makefile. =20
>>>>=20
>>>> Did you try using the ftrace event with perf with this on? =20
>>>=20
>>> I have tried a few things, like=20
>>>=20
>>>  perf stat -e probe:perf_read -I 1000
>>>  perf record -e probe:__x64_sys_perf_event_open -aR
>>>=20
>>> They all work fine.=20
>>>=20
>>> Do you have some tricky functions that we should double check? =20
>>=20
>> I've no idea what probe: does. iirc there's something like
>> ftrace:function that is like regular function tracing.
>>=20
>> At some point using that made the kernel really sick due to recursion
>> between ftrace and perf. Quite possibly that's been fixed, dunno.
>=20
> In the early days there was a lot of issues with recursions, but I added =
a
> lot of recursion protection since then. I'll give this patch a spin and s=
ee
> if I can make it crash.

How does this work in your tests?=20

Thanks,
Song

