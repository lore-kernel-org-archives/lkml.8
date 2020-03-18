Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430A3C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 07:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B0AC2076A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 07:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="LBDzEwjG";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Kt8d/Dru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgCRHIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 03:08:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33622 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726452AbgCRHIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 03:08:17 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 02I77ugL011162;
        Wed, 18 Mar 2020 00:07:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=lU1GbP5Z2ENq0QKBY42Q1YpfdK1OQ+XdkxO+xcXTZeU=;
 b=LBDzEwjGjBy9Btp8LaXzJsiuljkZV2r4JHE3DQwtEkIiVVTzXh4EWdxSmhAKSnTvPUwV
 2cwHUYx0DtCnM2xf5SmubfCpPZE/c+4eRk4kHk3C7zbzFemmMbZcEIK7jofV4kg4A0Ao
 TtSWlTEqxLB+F5WHIj3ZNaDeEKoffqo2hSM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2yu7ynhgp0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 18 Mar 2020 00:07:56 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 18 Mar 2020 00:07:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1fph4Cz09MIuRI+Z9A72yoFQapzWrptW5agcyfHgjEjnKVPZO84mibtkUkiJFufjDGZoljBeJMLGHdN8je9XkUBSmuB/ge9no5cfSosnninCOHRvfuJ/+5QszvoJ834JPWagzpQM9TkxSOabLkImH9D/qM5lsdTw4J/9LOIGd34Q3Gmr0K7ah7Pnf7eO/dUpD40JliXDY99b2JQwF4ql9CGL0xVjg6MzKurPOdXn2Uu+u1vLyqOL9dtlluqqx3lgrzUAGjQgMFm3zbOk305huP7dhrvW3xM+4lxFarMgfocyYa4Ydo4QlZKvvpWpDoCIIIpZCzaFMaAoV/hgCp18A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lU1GbP5Z2ENq0QKBY42Q1YpfdK1OQ+XdkxO+xcXTZeU=;
 b=mz3kly6UUEnuriS6XMwkvyf77W4yyy6njUEVsQAPH92NN0VXZc2WW2RNVuLY+hQcz/c5wkm3Akex4OANdOFNWv0EXKF/BQ794y2BjVQXl6/izlWcGSdgy6z0sNPOgr7kkrvVmNN8XLgyS9apgKY8SDGR4ZP6iezqzmQDQSTB+WMvNAZ7/w6+qEEz8CzSaqsV/6Q4I+HuJS/IB30sj8uYx+G0qLAEN7rKk8wQ4zqusTDDYwfub4ojFf1hb0crh35NqT0mcx782H84uEYBeEEWob8QyVCOcRGI4lgBmOz2vatNzQOD3Fdb7ygU6vXv0iW49G+7mL3xbJuXwA4pou7U4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lU1GbP5Z2ENq0QKBY42Q1YpfdK1OQ+XdkxO+xcXTZeU=;
 b=Kt8d/DruDiWfXHj+kE9d02N4lbQHPEZXcrRJckttglclE69Ob1jjx9bocrKOmMo6JsvtKtiZlkf7VZboLhCrICJK6Cga6SWppMLaiYhy1GN/2qZQJVq3FDYyoK7Z5HrAhyloc0butW2BAEEdvQvCqHC2QLbgl2NcYprjP1YCrJ8=
Received: from MW3PR15MB3882.namprd15.prod.outlook.com (2603:10b6:303:49::11)
 by MW3PR15MB4009.namprd15.prod.outlook.com (2603:10b6:303:51::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Wed, 18 Mar
 2020 07:07:30 +0000
Received: from MW3PR15MB3882.namprd15.prod.outlook.com
 ([fe80::c570:6c46:cc47:5ca5]) by MW3PR15MB3882.namprd15.prod.outlook.com
 ([fe80::c570:6c46:cc47:5ca5%5]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 07:07:29 +0000
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
Subject: Re: [PATCH v2] perf/core: install cgroup events to correct cpuctx
Thread-Topic: [PATCH v2] perf/core: install cgroup events to correct cpuctx
Thread-Index: AQHV0V1Eb2FOWrPLeESAdNuK47ZqO6f5iwUAgEHpoACAEtBmgA==
Date:   Wed, 18 Mar 2020 07:07:29 +0000
Message-ID: <7BA78C8F-9D71-4BDB-BCCE-3036DCF3C653@fb.com>
References: <20200122195027.2112449-1-songliubraving@fb.com>
 <20200124091552.GB14914@hirez.programming.kicks-ass.net>
 <83AF3F97-7F98-4D52-A230-F04A0AB67284@fb.com>
In-Reply-To: <83AF3F97-7F98-4D52-A230-F04A0AB67284@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.60.0.2.5)
x-originating-ip: [2620:10d:c090:400::5:424]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1842994f-2030-40a0-dcfc-08d7cb0b05dd
x-ms-traffictypediagnostic: MW3PR15MB4009:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR15MB4009E6664E24DF991A2A6CABB3F70@MW3PR15MB4009.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(376002)(136003)(346002)(199004)(6486002)(4326008)(36756003)(2906002)(76116006)(478600001)(6512007)(71200400001)(33656002)(186003)(86362001)(5660300002)(2616005)(81156014)(8936002)(81166006)(66946007)(8676002)(64756008)(66476007)(66446008)(66556008)(6916009)(54906003)(53546011)(316002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR15MB4009;H:MW3PR15MB3882.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EoWly4Egnfcd11IyR62K1HoKZDUfSGQAI5hKM1pghe4x8SGPYGxxB/HeUSElqPP4ojoZNnru1zOhvYG4a+mLN1gDEdTq0RHHEXyRfebYu26XVbqAhpkFkFeTIuAwxa4IvgwfiB2VwPfQihCKTB8oFe0n13uvnPuoM8/9u7MTTftpI1efL68YQrrNlemwE4tQtjmwgJTDIwj+VkaOa0N+SHS60q/sAmdmMMIg5CEhi9/Fn3cXiTkIJuffz6cemy9jve86Eg+mcs4w+o96dQ3RzwjAU1QojJEthodfm9m9a63AK0xF+qhpSd9Sfo55pLFoGA/FOjBnfpkvZXISw5mME3F5FcZKCOGGQxfqE/zw0/Xou6hLFG6cfhxHDIZ+2xWDVeWZg61O2KAfh7RHa8QkU+of652dACRzQCqPYwJw/FNpb5wTxscAHt/c4a7HjtBd
x-ms-exchange-antispam-messagedata: 6UadMJkC/x6fhnBGq8OlPFwTMtCY3DEv3Yu1Q5kA6iUwDRK3oc6gsWNMWzN38wyD/oSU5vcf/9eGYYUoB6f/Aa9zGLr6irYxkOVHukPcKbn4qb9uhxnnvisUjPND7d0QqMwjeU2pxDSvgBcNjeR9rjkTp2Sjrk5LHLtPIuHOhNirQTeb0G4PbJBKerCu9Rmg
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6C2345A7209DC74497BFB909908B47CC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1842994f-2030-40a0-dcfc-08d7cb0b05dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 07:07:29.8474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4LomyPXm5htWw6MXXRTjdfR/9dC7u3QJPfzcJNDnvvxvLbbxC4O2v5Nu+vCJrJOjjIQONLiUa9CfhMrnwaq0/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB4009
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-18_02:2020-03-17,2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003180035
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,=20

> On Mar 5, 2020, at 11:48 PM, Song Liu <songliubraving@fb.com> wrote:
>=20
>=20
>=20
>> On Jan 24, 2020, at 1:15 AM, Peter Zijlstra <peterz@infradead.org> wrote=
:
>>=20
>> On Wed, Jan 22, 2020 at 11:50:27AM -0800, Song Liu wrote:
>>> cgroup events are always installed in the cpuctx. However, when it is n=
ot
>>> installed via IPI, list_update_cgroup_event() adds it to cpuctx of curr=
ent
>>> CPU, which triggers the following with CONFIG_DEBUG_LIST:
>>>=20
>>=20
>>> [   31.777570] list_add double add: new=3Dffff888ff7cf0db0, prev=3Dffff=
888ff7ce82f0, next=3Dffff888ff7cf0db0.
>>=20
>>> To reproduce this, we can simply run:
>>> perf stat -e cs -a &
>>> perf stat -e cs -G anycgroup
>>>=20
>>> Fix this by installing it to cpuctx that contains event->ctx, and the
>>> proper cgrp_cpuctx_list.
>>>=20
>>> Fixes: db0503e4f675 ("perf/core: Optimize perf_install_in_event()")
>>> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>> Cc: Andi Kleen <andi@firstfloor.org>
>>> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
>>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>>> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
>>> Cc: Jiri Olsa <jolsa@redhat.com>
>>> Cc: Namhyung Kim <namhyung@kernel.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Signed-off-by: Song Liu <songliubraving@fb.com>
>>=20
>> Thanks!
>=20
> I just realized this won't fully fix the problem, because later in=20
> list_update_cgroup_event() we use "current":
>=20
> 	struct perf_cgroup *cgrp =3D perf_cgroup_from_task(current, ctx);

Could you please share your thoughts on this? I think we cannot use current
in list_update_cgroup_event(), unless we call it on the target CPU.=20

Thanks,
Song


>=20
> I don't have a good idea to fix this cleanly. How about we just use IPI=20
> to install cgroup events (like v1):
>=20
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a1f8bde19b56..36e8fe27e2a1 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2682,14 +2682,18 @@ perf_install_in_context(struct perf_event_context=
 *ctx,
> 	smp_store_release(&event->ctx, ctx);
>=20
> 	/*
> -	 * perf_event_attr::disabled events will not run and can be initialized
> -	 * without IPI. Except when this is the first event for the context, in
> -	 * that case we need the magic of the IPI to set ctx->is_active.
> +	 * perf_event_attr::disabled events will not run and can be
> +	 * initialized without IPI. Except:
> +	 *   1. when this is the first event for the context, in that case
> +	 *      we need the magic of the IPI to set ctx->is_active;
> +	 *   2. cgroup event in OFF state, because it is installed in the
> +	 *      cpuctx.
> 	 *
> 	 * The IOC_ENABLE that is sure to follow the creation of a disabled
> 	 * event will issue the IPI and reprogram the hardware.
> 	 */
> -	if (__perf_effective_state(event) =3D=3D PERF_EVENT_STATE_OFF && ctx->n=
r_events) {
> +	if (__perf_effective_state(event) =3D=3D PERF_EVENT_STATE_OFF &&
> +	    !is_cgroup_event(event) && ctx->nr_events) {
> 		raw_spin_lock_irq(&ctx->lock);
> 		if (ctx->task =3D=3D TASK_TOMBSTONE) {
> 			raw_spin_unlock_irq(&ctx->lock);
>=20
> Thanks,
> Song
>=20
>=20
>=20

