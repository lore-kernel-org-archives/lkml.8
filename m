Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE98C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 18:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6768924125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 18:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="PGL5E3Wo";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="H8w3snO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgAUSjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:39:15 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:31518 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728901AbgAUSjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 13:39:15 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00LISL98028062;
        Tue, 21 Jan 2020 10:38:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=SFlqpa3BhnH31weZJ5eTTJ7srD3FmLX3fPm5NeavGyE=;
 b=PGL5E3Wow4A/tcqpdu2zOfr9+08yLGQ5GuN52HJvOnnDwwdC45lM8aURgqhUm6EdcT7Z
 4SUaom4QlFsGZN+2yp+uwsacoNGzTFAStiITSBm4fHehcLuNHG/x8R4IuqTFdS+4dloa
 +jQTBM14oYQM95/P9dgB+/cQnNr7tcDNG3A= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xnwtjtddj-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Jan 2020 10:38:46 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 21 Jan 2020 10:38:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QynWwfGwHmpWEu4NbvbaTJfginySve7iRpzNgGaoabfEdX+WG2UPKmSkjzf6XsP3jk3Q+QLE5nSeA6TSbjmCYEm1FtyLjHsmiFWs9LjkwGD9kFzz46TtRjA5tWZ5PxkrbdIv/s+QOTMi6wak8edWAwtwVA1XZZi3w9CgyoCKyLVGwEn2SBgIHGsbvnlnn3xYIrXaVHwRNdh7vCktk+QL6ioiqR92a48vIUZzZfN0a8FaH4Cqoktr7I8gXzv2sVBpl2KmC4dwKfXhVKzw16MkEiZP0rAP/c45P9F3DdcPZA7Vu+17Ukq8znJrvvS781lZx0Q8jbSbJGmopX1adP4sPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFlqpa3BhnH31weZJ5eTTJ7srD3FmLX3fPm5NeavGyE=;
 b=SYZWRsjgnkAyQTO0zmTF2btphmrUxerBqb/C6GloqeJU4mOadBnQtNgbnfJ7/nzMa7Ys8dUvEuYxv88ln3+tLxxVjz1bcUC95oRFimf+eT7W1Rlow//wbqIEQQT690GfBRkSXtxK6amJaO58xdtv64D3g4Dy24X7nviFxV1ef37rp0txt39EK3gJUDL6AgZ469+0HBDZDu0tFfXPu1PxYVKrRxuiofL9uzzfaCTG1HmYs04yTeAqRHnKiYt39I73ncyWm2ItRJjMi/rAlueWTJ3zwh70/FxVadRo3xc9jiNR+2/IyKJ88YhnDYHqGTeQpiROsHHo5t/HHsEl6Mq5WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFlqpa3BhnH31weZJ5eTTJ7srD3FmLX3fPm5NeavGyE=;
 b=H8w3snO2JRUBkI0vZAr9rGgiQWkSkwQ0HGuXje5XD+J9O7rnXuxoDNbSKPkNw3CFIhmyjxDjDFcaKETCVpFEIV7AA4L08eS99Um79NHywDVMj+ZVtdqzGTo1a2HO7OPM1NUqbFUbCme9s83UyN5NJ4YmGWj3dxx3bqr3+1HQOQ8=
Received: from BYAPR15MB3029.namprd15.prod.outlook.com (20.178.238.208) by
 BYAPR15MB3320.namprd15.prod.outlook.com (20.179.56.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Tue, 21 Jan 2020 18:38:41 +0000
Received: from BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d]) by BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d%3]) with mapi id 15.20.2644.026; Tue, 21 Jan 2020
 18:38:41 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Andi Kleen <andi@firstfloor.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] perf/core: Install cgroup event via IPI
Thread-Topic: [PATCH] perf/core: Install cgroup event via IPI
Thread-Index: AQHVzJINgbr4Iyan/U2RyJmj0CEACafzRCgAgAI2soA=
Date:   Tue, 21 Jan 2020 18:38:40 +0000
Message-ID: <C754CC54-2BFE-4363-BB05-6382DF984165@fb.com>
References: <20200116172555.3674873-1-songliubraving@fb.com>
 <20200120085022.GJ14879@hirez.programming.kicks-ass.net>
In-Reply-To: <20200120085022.GJ14879@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.40.2.2.4)
x-originating-ip: [2620:10d:c090:200::3:aa7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e787d49f-a580-404d-8fd0-08d79ea12333
x-ms-traffictypediagnostic: BYAPR15MB3320:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB33203A1B147A27B61357BF60B30D0@BYAPR15MB3320.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(136003)(376002)(366004)(199004)(189003)(6486002)(6512007)(33656002)(8676002)(5660300002)(86362001)(71200400001)(2616005)(66476007)(316002)(4326008)(6916009)(54906003)(81156014)(36756003)(45080400002)(81166006)(64756008)(66446008)(6506007)(66556008)(2906002)(66946007)(8936002)(186003)(478600001)(76116006)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3320;H:BYAPR15MB3029.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XscqVM8Z9wxNDpN83q9A/cMbDEU8KgzHrIWSDdO0gijdVGgZE0HxAFzgqDRj9hBVsfFIbPsIh8sVu/mEoofDKC6zezOUNc5S1qXWnLYtpbfdKcGfKvIfSMCpIINP97rJuki3yP3BTq3ric1MP57i0PjF0Cd3/YZD13S/cHhyCCu9gFfVUyYu8kTY7JZfon0c9C7t/fNN4sFnOczUakDy2jlTtggwyybpbY19aMxcv21DURDrAT9B8F81FYBPYLdPuAW5h4O8/S3ohZg3GAUzi6KglD2gAk3VxTcK0PBQlmghLRlSO/wK4QYTn5Ku0qQUwo2wn+NIDf3IhYcDk/9JRJ+Tp1DAk4vuUKiiMbMYh4Nokr9YoV5U/M3WgQaxkcE/xnVJmGlSnVKOEvQ1QCatubWPZw2+B+svEB1utGJYX5J7sibNKklAuBzuDSevY2bE
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BEEB159081552C4FA9B12E89434B4D6C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e787d49f-a580-404d-8fd0-08d79ea12333
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 18:38:40.6473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uRf+De7EIFwrfNqaTehL6a6uqxhD8IJ0aufzPZqoRQBrxwz0wjIUGHBd6aWyo4wkdmIRMZj9sT8Tp3kPKh6P6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3320
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.634
 definitions=2020-01-21_06:2020-01-21,2020-01-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 suspectscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 impostorscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001210139
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 20, 2020, at 12:50 AM, Peter Zijlstra <peterz@infradead.org> wrote=
:
>=20
> On Thu, Jan 16, 2020 at 09:25:55AM -0800, Song Liu wrote:
>> cgroup events in OFF state cannot be installed without IPI, otherwise, i=
t
>> may trigger the following calltrace with CONFIG_DEBUG_LIST:
>>=20
>> [   31.776974] ------------[ cut here ]------------
>> [   31.777570] list_add double add: new=3Dffff888ff7cf0db0, prev=3Dffff8=
88ff7ce82f0, next=3Dffff888ff7cf0db0.
>> [   31.778737] WARNING: CPU: 3 PID: 1186 at lib/list_debug.c:31 __list_a=
dd_valid+0x67/0x70
>> [   31.779745] Modules linked in:
>> [   31.780138] CPU: 3 PID: 1186 Comm: perf Tainted: G        W         5=
.5.0-rc6+ #3962
>> [   31.781125] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BI=
OS 1.11.0-2.el7 04/01/2014
>> [   31.782199] RIP: 0010:__list_add_valid+0x67/0x70
>=20
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index a1f8bde19b56..36e8fe27e2a1 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -2682,14 +2682,18 @@ perf_install_in_context(struct perf_event_contex=
t *ctx,
>> 	smp_store_release(&event->ctx, ctx);
>>=20
>> 	/*
>> -	 * perf_event_attr::disabled events will not run and can be initialize=
d
>> -	 * without IPI. Except when this is the first event for the context, i=
n
>> -	 * that case we need the magic of the IPI to set ctx->is_active.
>> +	 * perf_event_attr::disabled events will not run and can be
>> +	 * initialized without IPI. Except:
>> +	 *   1. when this is the first event for the context, in that case
>> +	 *      we need the magic of the IPI to set ctx->is_active;
>> +	 *   2. cgroup event in OFF state, because it is installed in the
>> +	 *      cpuctx.
>> 	 *
>> 	 * The IOC_ENABLE that is sure to follow the creation of a disabled
>> 	 * event will issue the IPI and reprogram the hardware.
>> 	 */
>> -	if (__perf_effective_state(event) =3D=3D PERF_EVENT_STATE_OFF && ctx->=
nr_events) {
>> +	if (__perf_effective_state(event) =3D=3D PERF_EVENT_STATE_OFF &&
>> +	    !is_cgroup_event(event) && ctx->nr_events) {
>> 		raw_spin_lock_irq(&ctx->lock);
>> 		if (ctx->task =3D=3D TASK_TOMBSTONE) {
>> 			raw_spin_unlock_irq(&ctx->lock);
>=20
> I don't think this is right. Because cgroup events are always per-cpu
> events, ctx =3D=3D &cpuctx->ctx, so the locking should work out just fine=
.
>=20
> What does appear to be the problem is that:
>=20
>  add_event_to_ctx()
>    list_update_cgroup_event()
>      cpuctx =3D __get_cpu_context(ctx)
>=20
> uses this_cpu_ptr() and we're now calling it from the 'wrong' CPU.

Yes, this is because add_event_to_ctx() is called from wrong CPU.=20

>=20
> But I'm thinking the below should also work just fine, hmm?

And yes, this also fixes it. Thanks!

Would you send official PATCH?

Song

