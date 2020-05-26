Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C10C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61A9920DD4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Lisgty72";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="MoR0AyYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391903AbgEZWKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 18:10:30 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62188 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391578AbgEZWK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 18:10:27 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 04QM8g6p006561;
        Tue, 26 May 2020 15:08:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=lLrqFXOa2xXI54ecWTnzNhJNwm/ZGZtyng1ZSlrdymg=;
 b=Lisgty72EiZbHbrBlLCs2i/Gl8yKDjvlQJxs4kuEu/aoPWm4MNs/oVg2ry/bm7HVViAj
 RyGRQLh1zdIjqdKXAN7QY6Z62goehMvy1N+VcOIN3oqyGTnyAH34TEVyr4FN/5xQLmqn
 Qf+UDN7mCI4zzIdglvKn7sY4hfldXngc1K0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 316ygpnmqe-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 26 May 2020 15:08:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 26 May 2020 15:08:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCCmI4pSjbN89GGdP/EkuZRXgwEWwYgiamZieJ/Kct/1bqiRq7vOlPYOUCjlik22ssug9Dr2hdD59FO/q/xnGrukrIT0a3sUbybsldCHpZXYW/ZRG1vkJ6+/0uQ9108QFB36EkSpY4dN/Cc+NJIUjN3R/3mAFx4QescdMVc+/M7KxU9N3UPqNiQRqfo6YJmE1HIq7XAgJySVNFq+L6r/vly1s5y5Sen+7iwHp8Ocu3wGymc/FxwzHinV6fNw+YE0oJ3/jRZeqp49CBp9GcZOV+ODBzII4ednK5keYVZKvGPktDqr/puRb2sWlgj1yhoFbqULPlLGQbiTavgoIF6KTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLrqFXOa2xXI54ecWTnzNhJNwm/ZGZtyng1ZSlrdymg=;
 b=h+yCMoA+pNV5p7+B55vX/7mqCRr0vKM9uGK5zAsPdLysEVUk2vo4pfYSvkOn+UwA9py9LltmSsFR6yyq9BGxb9N5KCGN9AxqR5ytPJjqlw14Fi7NZaZX2fVptjldQmDqtst2Sa/qZruoYr5BLgko9ARQleJ2UhnQ3Zh/omScq/oWGlLYGHiahXL9NDeGDQI1d1FSNVqLiXcGXrArFaveKohZja6s+YYEDDc0iRRj9gw1eaNdXZp66Dlkf8b2cpsf5Pc9I7MxUpyGc05Ce4E50sGBTyrLVo6AvW0aJDrE5cToMHZOxIHUSBt57cJK5P+W1TJ91iR0FE3q8tSCTOmFlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLrqFXOa2xXI54ecWTnzNhJNwm/ZGZtyng1ZSlrdymg=;
 b=MoR0AyYxS5m6LwofwZh3iK45MpH7rWrVnQL9HmnbVzHaqgG9BbK3vm0U3usFTrqlxcZ8fFf28V+wKWYB5cD9leVtjnfMsaI6ysogSXLxWnwi3H0St+8asq/SiDxVC3QMrWaE1myW5/jmnFsu3s0QJq+RNWHx5Hm89G794sPF+hs=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2917.namprd15.prod.outlook.com (2603:10b6:a03:f5::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Tue, 26 May
 2020 22:08:38 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::bdf1:da56:867d:f8a2]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::bdf1:da56:867d:f8a2%7]) with mapi id 15.20.3045.016; Tue, 26 May 2020
 22:08:37 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Jiri Olsa" <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [RFC] perf/core: allow ftrace for functions in
 kernel/event/core.c
Thread-Topic: [RFC] perf/core: allow ftrace for functions in
 kernel/event/core.c
Thread-Index: AQHWM6ViVS5deg/n5kWgZSYX+yJPDqi65OeAgAACB4CAAAIsgIAABAOA
Date:   Tue, 26 May 2020 22:08:37 +0000
Message-ID: <226406AB-1245-4F4E-879C-B3B0320811DD@fb.com>
References: <20200526212826.4097888-1-songliubraving@fb.com>
 <20200526213913.GG2483@worktop.programming.kicks-ass.net>
 <A9B20D93-748B-4789-801E-91720E2D4F28@fb.com>
 <20200526215415.GH2483@worktop.programming.kicks-ass.net>
In-Reply-To: <20200526215415.GH2483@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.80.23.2.2)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:7e06]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ddd179c-52a1-43ef-f20b-08d801c1576a
x-ms-traffictypediagnostic: BYAPR15MB2917:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB29171B1CC082B2BBA8A055E1B3B00@BYAPR15MB2917.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 041517DFAB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9SYAsdiAxpeYQ6PShRXEqBahByQnRWUHD1HGKHxJkrjt+UakPW6Aun1lsFkHdIhkOCePgHIV/k9dR3JSopW5Ld66s9jkvox0b7ycBe3JqCgOZqQ/ehy5Bel0aIrnVxhrNrVi3TU4CCfNczzJeWPS0KPRKatWqCqShr/F/YA0X9EF2RxMRDG3cWX5dHDd5qByocNCoAkSkCxvAGkQTPbnwlF9tvgI+YH/4afbLPbZI2yN7JvaHZh6gN/YzdClrPUfZM++404Fsd8sNOqakJcw4OLpBDfHxDjqNik/T9vTOi3GcEPO+rffJcCPrYWJxWCB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(136003)(346002)(396003)(366004)(66946007)(6512007)(54906003)(53546011)(71200400001)(6506007)(186003)(86362001)(4326008)(316002)(6486002)(5660300002)(2616005)(478600001)(64756008)(2906002)(6916009)(66446008)(66556008)(76116006)(36756003)(33656002)(8676002)(8936002)(66476007)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: nZX0pTOPUh1RNsIyxZQk1/F4LiYkgKdTGCDo7T7qFZWVJsj8Q5ar2DdMgjnkCrqsCqYH3cGjsBGppiK4pDEvw9NwFb9gkTGc9wleNuqtD4WCM3Qr2tIjlrqjhzRLGcHzNuRdrLa3vDIM3orm6ScQkrXC7e9R908nEgO5h0FVHlNQ76GdPJWmjyDUMxnEWW50I2zlpLX0L49P1Ot2YwieaESqAjCRA7O8DDrIFTM9m4dWj88NEnRQABefoPWy+mPYPxCP9v54tQGjs03X1I/mYZYTsraWNKuRPIfPZw9eC2ykNMe50YeNuZHHVdGO2f8rKupKy0VOFcCpnZNce1P2iUHko6Dza53+NEtLAYoWxNcpF8PL3ViYTPXf8W3qf3ckD8f5GU1dlswOiLTAnfGmwQ0F6qDG7I090v0A0YE2ZJv0dAhK5WpPT+zIoGZAVuE3llmJm7yxkFvuxgLu8AelBhfBmXdBvC/rhaWB6MVgEyu84ffFb4nXo6u6FjjUUMmbz9nP0EvDV2z1KIZyKGFA9g==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0CB12D5A4073D946B2F7E1764B231177@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ddd179c-52a1-43ef-f20b-08d801c1576a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2020 22:08:37.8288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j2f6nC6Hiu7d1kdd6ZNMkIodVdeVHs77qeQUTAHj+f60PWvLIs8dH19r5b6zUBIPEOfdkZh0QQdypB5wk5OFyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2917
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-26_02:2020-05-26,2020-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 spamscore=0 mlxscore=0 bulkscore=0 cotscore=-2147483648 mlxlogscore=999
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005260171
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 26, 2020, at 2:54 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Tue, May 26, 2020 at 09:46:29PM +0000, Song Liu wrote:
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
>>=20
>> Do you have some tricky functions that we should double check?
>=20
> I've no idea what probe: does. iirc there's something like
> ftrace:function that is like regular function tracing.

Those are kprobes. I have CONFIG_HAVE_KPROBES_ON_FTRACE=3Dy in .config.=20

>=20
> At some point using that made the kernel really sick due to recursion
> between ftrace and perf. Quite possibly that's been fixed, dunno.

I also tried on ctx_sched_out() and event_sched_out(). They also work
as expected.=20

Thanks,
Song

