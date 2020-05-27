Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49017C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F87020890
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="dupqhIyD";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="GZQE6nfO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgE0Tpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 15:45:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47332 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725872AbgE0Tpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:45:35 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04RIf4Gc026703;
        Wed, 27 May 2020 11:41:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=HCr1yQCovBccrKpeVomury9/V6kJq+nebHMyH/nIpM0=;
 b=dupqhIyDmRAv0xYzo8gK/wL7Dzitx/JvwN+whaLi0U9fgMFY7qBik08OpMCBlS0Fwu0y
 CDjMXlHCPfPobSO/4RRS1SVznricU51zHkrll2COt9rrGgRh0AGrxKNw2Gq75Z7rZKge
 euhirZW5mDpuEjGtHudtRg8uJ5HjTF7ixzs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31999r2s5p-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 May 2020 11:41:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 27 May 2020 11:40:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrdahxdP1ZknMPSDRnSggL7i6a0gSJ0wilDK5uUJR+vfaFXa1ya0qlxmJro8768RKNC5EAluWkOKHCLNssDFiX2iUhaBtaLjJe9nfhPoqWgCVST/40uBkCVnZ/SdY75g3+l5xzMb2CKSbz+2L05Cwnew722bFysdG3iS863Ue40WvbzTmuF90qG50/yPHAhwmqW1VkIWV44vhH1SO55x+Q1nwvCeG+/torr5b7d8wqmCUOcaOkG4d81YootNMfRCmzSbbzqK24QR0KKzV50LhlGQ0YI3/qbJLsmbIQpsEoMsDA0Z/o4SnTDcI7f4jWfnSA5mhs0yNZTf1uAAquyDgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCr1yQCovBccrKpeVomury9/V6kJq+nebHMyH/nIpM0=;
 b=U4GKfjeMCoJ+nxXa+fh8iP4VEiW+2sFjSD1TBmrzesMjX73EiuqCRylT2hUGynEVuYM0cw3IdFTEzbBNxkdiQcq8OegjaY/C4JMcQHcG4vdBQEaSnoBYR3HimfsyzCf8G/Xax5O97dHWmjv4vKswtAqkRPgrG/U+dfa//TGby4QZzSmB6NQ7dvkZBvRchkNPnsSZ9DO+LUQBDqvbj0q/ER6FAfkUEUSh0tj2FW6BLLD3hK7DEn8XFLOoAeNnu44/ydLPpIxbgcbD7nQSPqkkFxttoqfd6L+xjCeA1f7lPEMbtydS3xuHwJa1zq0yTaj5vXHjNCL9HelocTTwg0vXCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCr1yQCovBccrKpeVomury9/V6kJq+nebHMyH/nIpM0=;
 b=GZQE6nfOrir01oPbM9oS+0yroHP6BhTINtrk1jnimo30/+/RECCPvQHEQwE0AwEYuJ3jUpK7ijXNUD6lDb8Wu23yqVlZJSsz2oqWKsoXqkWkKIvUX8sym549cg85fi6LIJXT2RxfWgBlkDxALnf0aiLolSe9ORU6Jfah3qglF2k=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB3159.namprd15.prod.outlook.com (2603:10b6:a03:101::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.29; Wed, 27 May
 2020 18:40:33 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::bdf1:da56:867d:f8a2]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::bdf1:da56:867d:f8a2%7]) with mapi id 15.20.3045.016; Wed, 27 May 2020
 18:40:33 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [RFC] perf/core: allow ftrace for functions in
 kernel/event/core.c
Thread-Topic: [RFC] perf/core: allow ftrace for functions in
 kernel/event/core.c
Thread-Index: AQHWM6ViVS5deg/n5kWgZSYX+yJPDqi65OeAgAACB4CAAIR9AIAA2eQA
Date:   Wed, 27 May 2020 18:40:33 +0000
Message-ID: <DD3FC894-134E-4A8E-A769-406FCC6B8F61@fb.com>
References: <20200526212826.4097888-1-songliubraving@fb.com>
 <20200526213913.GG2483@worktop.programming.kicks-ass.net>
 <A9B20D93-748B-4789-801E-91720E2D4F28@fb.com>
 <20200527144040.3f12026f31b20b2011fbbcee@kernel.org>
In-Reply-To: <20200527144040.3f12026f31b20b2011fbbcee@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.80.23.2.2)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:5b1c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06a74da2-1f0f-45c3-76ef-08d8026d708b
x-ms-traffictypediagnostic: BYAPR15MB3159:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB3159E76EE0E36F86126512BBB3B10@BYAPR15MB3159.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P0Kil3d3+zxOCloWJtJF1CKGHhRhLwjk083rDngXJxkKiE90T3fP1NSlL/KgyRs2W0vKgyj61uxpF1L6Ed/gaQlcOZA/VYq/sbfaJMqkB1JKRLdbewdeMkNvA6ZuLpxu5JZMPgBvjeri1QqnNMPgDvk+u69A9qtUYx3RkOIn7SB7jJC/KSweRjBV0itQruwKpNQVkFOu0OEdvfbk5jL7nAvj8MFzPc4xdaLOGjhpoKG9w5cASpP5nJRJsN3F7F9ublQjLfmXFqJ3VY3u9QqZFNFuT+onyoGlNDqFqveKKJ5yfyrW07F4Szhar8UG4Jtt+FxU3VVka+EpNNQm4CDozg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(366004)(136003)(39860400002)(396003)(7416002)(86362001)(6506007)(66446008)(6486002)(71200400001)(36756003)(66556008)(66476007)(6512007)(478600001)(64756008)(186003)(8936002)(2906002)(8676002)(4326008)(66946007)(5660300002)(54906003)(53546011)(33656002)(76116006)(2616005)(316002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 2Yf/NbSuRlu2ZCINeWdy6y85hS8kG+j26Hd1LqyFWOB9VijdOnGEA5biYgije8FoBo1/55rkf9zPSd061Qj/3aLTh6vn6Tv4guMWG109LYdGkgo1uxD4d3g4zcG6qZV8Z0UOgWHQidDnNHa6gCahGygGcC+6fnD0V6oOB8qz2x2sYb7RWX0HI3AX6efshxHr4KAgJbztayWnEONRPVeY+9RjxR7SGjruqFYIOzkk6S2o/ArChgpVzyND8BXFa7xoMgDKWzRcX960OUyDMomp3+F0zYvtJ2Y/18iPnCEbYjN6B0xaXFE24tye5CBFLFaHyT3lhp/VraEct0JMpC83RRG1scRbtU34dq3aG1ftYXBRqZqa4zyvOfGnHmO4qDCHzMo0C7x58qyM8GRoWz83Aym2fW0dvTX1vOZlFjT2nbf6mjDAlQD+d3JavZpH3XBgM3wr/+2t0ZjiVh+JNV7FgzPO0sAEdKVlHkqmgCpPjZEV2f9/YtokCBrurxyejrOHFtsi8ZvgfQIafIHhHlVboA==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6380583A76325A43A9BC0BCEAB118526@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a74da2-1f0f-45c3-76ef-08d8026d708b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 18:40:33.3515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0P9Tf4Mu9FXwygp26Hzf1Qgs+Qd/6sUzgWOTsljmiOV+mkWKphY4S6SSICt/HayiO4JTtYfVekMRPOBjiOhFxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3159
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-27,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 cotscore=-2147483648 bulkscore=0 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005270143
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 26, 2020, at 10:40 PM, Masami Hiramatsu <mhiramat@kernel.org> wrot=
e:
>=20
> On Tue, 26 May 2020 21:46:29 +0000
> Song Liu <songliubraving@fb.com> wrote:
>=20
>>=20
>>=20
>>> On May 26, 2020, at 2:39 PM, Peter Zijlstra <peterz@infradead.org> wrot=
e:
>>>=20
>>> On Tue, May 26, 2020 at 02:28:26PM -0700, Song Liu wrote:
>>>> It is useful to trace functions in kernel/event/core.c. Allow ftrace f=
or
>>>> them by removing $(CC_FLAGS_FTRACE) from Makefile.
>>>=20
>>> Did you try using the ftrace event with perf with this on?
>>=20
>> I have tried a few things, like=20
>>=20
>>  perf stat -e probe:perf_read -I 1000
>>  perf record -e probe:__x64_sys_perf_event_open -aR
>>=20
>> They all work fine.=20
>=20
> Did you try using perf with function-tracer or function-graph tracer?
> If you just want to trace those functions with kprobes, you can=20
> build your kernel with CONFIG_KPROBE_EVENTS_ON_NOTRACE=3Dy, which allows
> you to probe perf_read etc.

Thanks for the hint.=20

kprobe does work with CONFIG_KPROBE_EVENTS_ON_NOTRACE, but BPF trampoline
doesn't work. If it is safe, removing $(CC_FLAGS_FTRACE) is preferable.

Thanks,
Song
