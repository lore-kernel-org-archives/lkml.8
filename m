Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0766C38A30
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 01:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90B4521D94
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 01:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="i3goe2YD";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="IfTAojLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgDUBNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 21:13:47 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:64804 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726079AbgDUBNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 21:13:46 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03L1C5Rg025148;
        Mon, 20 Apr 2020 18:13:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=frPEsI590KXDIRcXfHpAoM/aKfMsrT1F29laEs0V6HI=;
 b=i3goe2YDpzoXlnyWZkfw9E+FlOaEgKa+FrW2Dg7pd63gRPpILp5A0fXFf5kZiDe44zEK
 LQXGhI2ox8EfLUdzrOZteYGsj6BzRmyWoroDaoYjLcc2alAGIJNpUU7tWhehMQnV5RGY
 KkSwja3uIJ95EVzKlpdTrk8jht/Xok4ZJBI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 30ghc68bxf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 Apr 2020 18:13:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 20 Apr 2020 18:13:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EsBw6cDr9yeNy2gtx3x+Sgd7GZiLyKdDPACrF6ocTxaZj/p7Kx9PFxIgBVqm5+7HYBjBPQUcnQP2X/+tg5Wtd38y12x94ILlMPdGgaV7P4aKLpOPahM3is+89CbJR0B/LJtS3YPaLO+1PjvoeNpS75NG1w9eyRJj8visclMNvd0oo+gaXFj270DXbBFB00I1of5rmup9/57ZXm36wG6WNV+KgHnST7UiD2vhA263r3wSBnwGwXH4C+TvKc5B46pPB4XgUHtBxzOCn5R0JiYj/KXfIXebbW7ryH16h1euxVNX9UsoQ4nVIuUuPdUHhoLHlBLZ8wN4CPvZ5941BwD8HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frPEsI590KXDIRcXfHpAoM/aKfMsrT1F29laEs0V6HI=;
 b=egSS85dyRLLp8azdE6mtOTn/CTM6RHazDlQ2ki5Oz80vGywj9ESAiuw3oBgrtF9r0KSWl1Hvt3qaTBdt+jIpLUIxpmJSA0uuXd5aUT6HbP0qmO3dw/xY9IoUo/Y5zRnN3KdHAn/hdlLBCQmaPb70Pdr7ttDf5P3aw8kMGLidsbMqBwC0jgLiQ7b/+0O95QxVeWqLmBtz7YwwMiQ9T2n4xu8v21M5qkfTrHaGTr/hfvdc33QdpDWokeaE3un9GX/ELgM905e144Drn+qWNG029DtyM16Zp9Nodr3b9N461mk8yUGg0bPXoe2mRhqH94Jjdko90XQaaP4vqL8Vr4KVEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frPEsI590KXDIRcXfHpAoM/aKfMsrT1F29laEs0V6HI=;
 b=IfTAojLae85CwpBZPfraSEb2ZcjFA/hje8FWAn5CKJUq16aEITZtz63pFW90l2ioBkRqcpVUy0PcCGE9QlDiigv/CVBMLno1jqAQf3N+5BnDQIPSLFuRgkkJvAS5FiT7EyV9p4iKlCD66yQPUS1fXnQDFlJYpUqIergHCOIRsxU=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2904.namprd15.prod.outlook.com (2603:10b6:a03:b0::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 01:13:32 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::bdf1:da56:867d:f8a2]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::bdf1:da56:867d:f8a2%7]) with mapi id 15.20.2921.030; Tue, 21 Apr 2020
 01:13:32 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>,
        "kernel test robot" <rong.a.chen@intel.com>
Subject: Re: [PATCH v12] perf: Sharing PMU counters across compatible events
Thread-Topic: [PATCH v12] perf: Sharing PMU counters across compatible events
Thread-Index: AQHWBzHW5dF+e/R99EaK1PXwCxhLFqiCwbOAgAAkDgA=
Date:   Tue, 21 Apr 2020 01:13:32 +0000
Message-ID: <DD112BD6-F623-4039-A0E1-D395D705A528@fb.com>
References: <20200331075533.2347393-1-songliubraving@fb.com>
 <20200420230429.GT2483@worktop.programming.kicks-ass.net>
In-Reply-To: <20200420230429.GT2483@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.60.0.2.5)
x-originating-ip: [2620:10d:c090:400::5:8478]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 203d98f8-12d5-498e-1603-08d7e59135a3
x-ms-traffictypediagnostic: BYAPR15MB2904:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB290466C216B84864B439C9B8B3D50@BYAPR15MB2904.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:644;
x-forefront-prvs: 038002787A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(136003)(39860400002)(366004)(396003)(346002)(376002)(5660300002)(186003)(66476007)(64756008)(71200400001)(316002)(6506007)(53546011)(478600001)(66556008)(66446008)(91956017)(2616005)(66946007)(76116006)(4326008)(36756003)(86362001)(6486002)(6512007)(6916009)(8936002)(2906002)(81156014)(8676002)(54906003)(33656002)(87944003)(21314003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AC62cY6dmwlKZ8QSlSZyP5j2tsh/4RI+i3WISnN6DYa4o5cPV2SikJ9CATSiDOcR/G7G/oDYOkfGg+0U8jMEtwfMZibGcbEMYTg7Y5k0aXABGIix9CvhaLkgy4ZcvXziHsT0l/8brNT0prwDR/2WeVRfJLV335rKOSy7N2amMRgvtRqgifo7ONQHZPByeK1BS+1zJZk6HtPVVcSAJpTsgW0FBJ7oqik0w27WT6LdJussrZivR1oSRGV6wR14BadtiHVkIIiNOlq1m4eHyzyxpPDZYsRehtY0xOLX8pLfs+D8nx73O2FqsGIgTOZ8EZ9v833OZ7H5Q5cSzHOVEH6VYUzGT14LTQDxofV2jan0db2G9OaKDP3ziINvuaAczTsmf3mcnx4N475SwfPYfjTirTNVOx8BGXZW/sT4a8Ftdxvcb+zuI335Xd3GdJ+mYeCervCWmCGVc0gOTGoq54eC3IfsliJMRJErFL9WKck1oj0fv/aN3CPYgMy2XvThWcc1WJUPicEkFhroPUebcRRe8Q==
x-ms-exchange-antispam-messagedata: FHnDvwEEbGiBl8e18RbILt9RoNc5aaU0TUZyrYXd3xlHww+TvO87r+HWJ6yjjUdqgVvGxfBGNWAS8M4U3mEURzUfSbLXuTH/hp7AjoIDPavoFNhsDBqoIy3xooQS7qlYoy3YZAfXg5pIzV0nD4tUJPTVy8dHhWoDc6GpysliEzRATFd4yhikkeGtBot6n5/0WRRsGnhpb9toxZQb8qrZEHU2derfKixb5uy01DTnvGjnP0+g8j5nKA0LIXfr1mNBE1x93WA7seFzloKr/E012QGuIbT2bthaZLZOFHhhNTPTInu858XXXVg7JVNcRnNgCgj/Lv52Sr/UAlHa39TkeFbnw2bYwUCyJq97wJLDSMBsXWIQN5SQN4eHcfOup7mRTlGNqW9zdjEh0rl7UnLgGSQ0fWmXOtV0ptG8AAY+3CkuJ6A9tGpWExhav/ALeE8/xp11oeiDBy99w2ZGNdix4FPVN/DGNGO6DytxWHchTqli47bWikP8EPY8YIWO8sSSQYvqE5AAGDtLE6t4KBjIV8by5O8Dk9ks0qWAMAx8gE1zeAkm744AOJl9gbrnky8N0pHkL4vGiNB6s7AUl8HVNd+a+CLmaprMUSW9i9eNRhYrEgE+/KhLdXIpY/q7H2t/58N1y8SrmjPUPWKk+pX9tKtUpDqGt9QSoXwxaN2nYhmZ6/4FeqQmYb9Z8BdrUX3fBoGoObYSsjT40uMEJL828OxlYEzYzqNhJuMu87z1ZLhMEhZGMOjrZHMfFadQHZmFHGS1qtnOXRdPX0Xq/7sMAMdkIR5L96bRDRtibUkQd0anIe/f8wgzCwW2C/ulJe/IAz5seymSEH2zdcLQikZujw==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <361FE072B7ADD240ADA5F18BE69A530E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 203d98f8-12d5-498e-1603-08d7e59135a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2020 01:13:32.7614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YzMMlpsxpPxiBdWXBe/nWfNzO/IYpUIgSEkB34CeMec38PK7pb6TR6cZgp4BeXVaPU3BBr1lz4EMGA9iDNjK0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2904
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_09:2020-04-20,2020-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210008
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 20, 2020, at 4:04 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Tue, Mar 31, 2020 at 12:55:33AM -0700, Song Liu wrote:
>> @@ -1778,6 +1775,246 @@ perf_event_groups_next(struct perf_event *event)
>> 		event =3D rb_entry_safe(rb_next(&event->group_node),	\
>> 				typeof(*event), group_node))
>>=20
>> +static inline bool perf_event_can_share(struct perf_event *event)
>> +{
>> +	/* only share hardware counting events */
>> +	return !is_sampling_event(event);
>> +	return !is_software_event(event) && !is_sampling_event(event);
>> +}
>=20
> ISTR pointing out before that one of those returns is superfluous.

This is totally my fault. Will fix in next version.=20

>=20
>> +/*
>> + * Returns whether the two events can share a PMU counter.
>> + *
>> + * Note: This function does NOT check perf_event_can_share() for
>> + * the two events, they should be checked before this function
>> + */

[...]

>> +
>> +	barrier();
>> +
>> +	WRITE_ONCE(event->dup_master, event);
>> +	event->dup_master =3D event;
>> +}
>=20
> OK, set up master_count, dup_count, barrier, set dup_master.
>=20
>> +/* tear down dup_master, no more sharing for this event */
>> +static void perf_event_exit_dup_master(struct perf_event *event)
>> +{
>> +	WARN_ON_ONCE(event->state < PERF_EVENT_STATE_OFF ||
>> +		     event->state > PERF_EVENT_STATE_INACTIVE);
>> +
>> +	/* restore event->count and event->child_count */
>> +	local64_set(&event->count, local64_read(&event->master_count));
>> +
>> +	event->dup_active =3D 0;
>> +	WRITE_ONCE(event->dup_master, NULL);
>> +
>> +	barrier();
>> +}
>=20
> XXX ordering doesn't make sense, I think you want the barrier() between
> setting count and dup_master, that way you'll get the correct result out
> of perf_event_count() no matter the timing.

Will fix.=20

>=20
>> +#define EVENT_TOMBSTONE ((void *)-1L)
>> +
>> +/*
>> + * sync data count from dup_master to event, called on event_pmu_read()
>> + * and event_pmu_del()
>> + */
>> +static void
>> +event_pmu_read_dup(struct perf_event *event, struct perf_event *master)
>> +{
>> +	u64 prev_count, new_count;
>> +
>> +	if (master =3D=3D EVENT_TOMBSTONE)
>> +		return;
>> +
>> +again:
>> +	prev_count =3D local64_read(&event->dup_count);
>> +	if (master->state > PERF_EVENT_STATE_INACTIVE)
>> +		master->pmu->read(master);
>> +	new_count =3D local64_read(&master->count);
>> +	if (local64_cmpxchg(&event->dup_count, prev_count, new_count) !=3D pre=
v_count)
>> +		goto again;
>> +
>> +	if (event =3D=3D master)
>> +		local64_add(new_count - prev_count, &event->master_count);
>> +	else
>> +		local64_add(new_count - prev_count, &event->count);
>> +}
>> +
>> +/* After adding a event to the ctx, try find compatible event(s). */
>> +static void
>> +perf_event_setup_dup(struct perf_event *event, struct perf_event_contex=
t *ctx)
>> +{
>> +	struct perf_event *tmp;
>> +
>> +	if (event->state < PERF_EVENT_STATE_OFF ||
>> +	    !perf_event_can_share(event))
>> +		return;
>> +
>> +	/* look for dup with other events */
>> +	list_for_each_entry(tmp, &ctx->event_list, event_entry) {
>> +		if (tmp =3D=3D event ||
>> +		    !perf_event_can_share(tmp) ||
>> +		    !perf_event_compatible(event, tmp))
>> +			continue;
>> +		if (tmp->state < PERF_EVENT_STATE_INACTIVE)
>> +			continue;
>> +
>> +		/* first dup, pick tmp as the master */
>> +		if (!tmp->dup_master) {
>> +			if (tmp->state =3D=3D PERF_EVENT_STATE_ACTIVE)
>> +				tmp->pmu->read(tmp);
>> +			perf_event_init_dup_master(tmp);
>> +		}
>> +
>> +		event->dup_master =3D tmp->dup_master;
>> +
>> +		break;
>> +	}
>> +}
>> +
>> +/* Remove dup_master for the event */
>> +static void
>> +perf_event_remove_dup(struct perf_event *event, struct perf_event_conte=
xt *ctx)
>> +
>> +{
>> +	struct perf_event *tmp, *new_master;
>> +	int dup_count, active_count;
>> +	int ret;
>> +
>> +	/* no sharing */
>> +	if (!event->dup_master)
>> +		return;
>> +
>> +	WARN_ON_ONCE(event->state < PERF_EVENT_STATE_OFF ||
>> +		     event->state > PERF_EVENT_STATE_ENABLED);
>> +
>> +	/* this event is not the master */
>> +	if (event->dup_master !=3D event) {
>> +		event->dup_master =3D NULL;
>> +		return;
>> +	}
>> +
>> +	active_count =3D event->dup_active;
>> +	if (active_count) {
>> +		perf_pmu_disable(event->pmu);
>> +		event->pmu->del(event, 0);
>> +	}
>> +
>> +	/* this event is the master */
>> +	dup_count =3D 0;
>> +	new_master =3D NULL;
>> +	list_for_each_entry(tmp, &ctx->event_list, event_entry) {
>> +		u64 count;
>> +
>> +		if (tmp->dup_master !=3D event || tmp =3D=3D event)
>> +			continue;
>> +		if (!new_master) {
>> +			new_master =3D tmp;
>> +			list_del_init(&new_master->dup_active_list);
>> +		}
>> +
>> +		if (tmp->state =3D=3D PERF_EVENT_STATE_ACTIVE) {
>> +			/* sync read from old master */
>> +			event_pmu_read_dup(tmp, event);
>> +		}
>> +		/*
>> +		 * Flip an active event to a new master; this is tricky
>> +		 * because for an active event event_pmu_read() can be
>> +		 * called at any time from NMI context.
>> +		 *
>> +		 * This means we need to have ->dup_master and ->dup_count
>> +		 * consistent at all times. Of course we cannot do two
>> +		 * writes at once :/
>> +		 *
>> +		 * Instead, flip ->dup_master to EVENT_TOMBSTONE, this will
>> +		 * make event_pmu_read_dup() NOP. Then we can set
>> +		 * ->dup_count and finally set ->dup_master to the
>> +		 * new_master to let event_pmu_read_dup() rip.
>> +		 */
>> +		WRITE_ONCE(tmp->dup_master, EVENT_TOMBSTONE);
>> +		barrier();
>> +
>> +		count =3D local64_read(&new_master->count);
>> +		local64_set(&tmp->dup_count, count);
>> +
>> +		if (tmp =3D=3D new_master)
>> +			local64_set(&tmp->master_count, count);
>> +		else if (tmp->state =3D=3D PERF_EVENT_STATE_ACTIVE)
>> +			list_move_tail(&tmp->dup_active_list,
>> +				       &new_master->dup_active_list);
>> +
>> +		barrier();
>> +		WRITE_ONCE(tmp->dup_master, new_master);
>> +		dup_count++;
>> +	}
>> +
>> +	perf_event_exit_dup_master(event);
>> +
>> +	if (!dup_count)
>> +		return;
>> +
>> +	if (active_count) {
>> +		/* copy hardware configure to switch faster */
>> +		if (event->pmu->copy_hw_config)
>> +			event->pmu->copy_hw_config(event, new_master);
>> +
>> +		ret =3D new_master->pmu->add(new_master, PERF_EF_START);
>> +		/*
>> +		 * Since we just removed the old master (@event), it should be
>> +		 * impossible to fail to schedule the new master, an identical
>> +		 * event.
>> +		 */
>> +		WARN_ON_ONCE(ret);
>> +		if (new_master->state =3D=3D PERF_EVENT_STATE_INACTIVE) {
>> +			/*
>> +			 * We don't need to update time, so don't call
>> +			 * perf_event_set_state().
>> +			 */
>> +			new_master->state =3D PERF_EVENT_STATE_ENABLED;
>> +		}
>> +		perf_pmu_enable(new_master->pmu);
>> +	}
>> +
>> +	if (dup_count =3D=3D 1) {
>> +		/*
>> +		 * We set up as a master, but there aren't any more duplicates.
>> +		 * Simply clear ->dup_master, as ->master_count =3D=3D ->count per
>> +		 * the above.
>> +		 */
>> +		WRITE_ONCE(new_master->dup_master, NULL);
>> +	} else {
>> +		new_master->dup_active =3D active_count;
>> +	}
>> +}
>> +
>> /*
>>  * Add an event from the lists for its context.
>>  * Must be called with ctx->mutex and ctx->lock held.
>=20
>> @@ -4223,7 +4534,14 @@ static void __perf_event_read(void *info)
>>=20
>> static inline u64 perf_event_count(struct perf_event *event)
>> {
>> -	return local64_read(&event->count) + atomic64_read(&event->child_count=
);
>> +	u64 count;
>> +
>> +	if (likely(event->dup_master !=3D event))
>> +		count =3D local64_read(&event->count);
>> +	else
>> +		count =3D local64_read(&event->master_count);
>> +
>> +	return count + atomic64_read(&event->child_count);
>> }
>=20
> So lsat time I said something about SMP ordering here. Where did that
> go?

I guess we will need something with EVENT_TOMBSTONE? That's not clean, I gu=
ess.

>=20
> Specifically, without ordering it is possible to observe dup_master and
> dup_count out of order. So while we might then see dup_master, we might
> then also see an old dup_count, which would give 'interesting' effects.
>=20
> Granted, adding memory barriers all over this will suck :/

Can we somehow guarantee dup_master and the counts sits in the same=20
cache line? In that way, we can get rid of most of these barriers.=20

Thanks,
Song





