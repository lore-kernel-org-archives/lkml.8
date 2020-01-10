Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67055C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB0120842
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="U3krlYXg";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="J/8fvjxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgAJRiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:38:16 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:22584 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726739AbgAJRiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:38:15 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 00AHZxbp019688;
        Fri, 10 Jan 2020 09:38:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=nqNHdy0VWYSPh1L6FftU8dPjjrat8LaCduSxXPteZzE=;
 b=U3krlYXgjjtDwgB92Z77h0sBSRp1cPxcT0t9gCrdP0/rbGXupKPjXNlawTQa/3SDnhA3
 GUrJFgxWhYAm3txsv66xoRt0ROwc65zNCASpG+W8TlROEZQX/mz8oEn3QgHiiYlJVoYo
 JeAKBYTDMYuwRmhJOiJYD6F9CiYpnFzLAmU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2xekk1uahj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Jan 2020 09:38:02 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 10 Jan 2020 09:38:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAwOW2H7hkjsKDKBf107WimZhSvxyY64c2hOHnQm5OGH6+/wxMzlSAbNgiyVgSFY/X4lSV6htfQuXdRkiv57HJ3p0xjRZI7DRJoSXZXaD3ggT5HRaOpsawC8N++5k61tUMJMwWJPyy0udsehL5wbUh6Gn98rKJCzwMYH0xJXkWuCS4Ksvk6sxVj9QaHDvtiuRd0DMpG+z48etEowxe+IgzF52v/5opL+eZDw193enbta2oYDwch43x6IVszXJZxMRSsmnLbIxMn2PvOkJeOfvkJ6/VEJVoTEHdIwenyKBWkTxQQlQpLIrqcHxmcBr53bqroq/4er0QP6VzUb0yPvig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqNHdy0VWYSPh1L6FftU8dPjjrat8LaCduSxXPteZzE=;
 b=ixH2nfK2lmP4WXLo2RXpwXPKh7TzU3QWZNK51PNL60pnqC7t99KMuD9ExAFKodqtrdyS6tPCBE9rk/QI9TnwtnJWU0MB9Caio6XfpPU7jhtH18G8/zQ2ni3lra4l1EyGBlolq2YWG0eZjjEySk6gk9MiTJ0v6WZ5l8l+Wflurb83bQ1PhC2BuT2ODJFvV+S9GDKmhCNxZ9A9IpdA7lAnsfA+SIHRKKmAypRLoYXgTRHPNcHEz0nshpqRZgUv+tQHsh1ngBf6OOeiipYxX0W/tQNBRUbGjDGvwCsUQCMGIDoKcP73khMm37dFtAgBosOfKGb46oEf0BDgO/1owMbW1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqNHdy0VWYSPh1L6FftU8dPjjrat8LaCduSxXPteZzE=;
 b=J/8fvjxG0cyH+aV0J/HKnc+fYg50rfHDQidLuu9T5xO1lB/ItJgG1MsBxTKEDYfy3/+mLkzf0gdJe7tBt4cgpOtTecIf+Pj5GpghcZdcgRG4jxWdKdRnNW6fKvUB/b7/Z+/kKA9CpwZSq4mI511+B949YCqr14GD2fCsu81ekIM=
Received: from BYAPR15MB3029.namprd15.prod.outlook.com (20.178.238.208) by
 BYAPR15MB3125.namprd15.prod.outlook.com (20.178.238.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.13; Fri, 10 Jan 2020 17:37:45 +0000
Received: from BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d]) by BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d%3]) with mapi id 15.20.2623.013; Fri, 10 Jan 2020
 17:37:45 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v9] perf: Sharing PMU counters across compatible events
Thread-Topic: [PATCH v9] perf: Sharing PMU counters across compatible events
Thread-Index: AQHVtQPKZjAIrpT67EGLkBjlWidLzafkAaAAgABNrAA=
Date:   Fri, 10 Jan 2020 17:37:45 +0000
Message-ID: <CF654118-59C1-46AA-B9DB-CA14D9FFACF7@fb.com>
References: <20191217175948.3298747-1-songliubraving@fb.com>
 <20200110125944.GJ2844@hirez.programming.kicks-ass.net>
In-Reply-To: <20200110125944.GJ2844@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.40.2.2.4)
x-originating-ip: [2620:10d:c090:200::2:5f0e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: daabbf4d-f86b-415a-5e5b-08d795f3cd77
x-ms-traffictypediagnostic: BYAPR15MB3125:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB3125E5587E8B5000766CE12EB3380@BYAPR15MB3125.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 02788FF38E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39860400002)(346002)(376002)(366004)(189003)(199004)(91956017)(6916009)(478600001)(4326008)(66946007)(2616005)(36756003)(316002)(81166006)(8676002)(8936002)(54906003)(81156014)(71200400001)(5660300002)(186003)(76116006)(6486002)(6506007)(2906002)(64756008)(66556008)(86362001)(66476007)(53546011)(66446008)(6512007)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3125;H:BYAPR15MB3029.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m0XdtB1d5IhQSemn+9JdSbGmUhgSArn+s0CXCT4pQR2IfAYqSf3AAOhbmAYBPwXNKOf6KAiHhICOoKuZamPCRULG6xlC3EiLrOt1+VKGl+T1zVSm6PzEB30VdjWPYsNO9Svt1N/xFNHW+fJ1mogj11OLOETUMIPPYc20nJQxyVnK0ct9pyWnidw3M0eXuGt33Q+srlnovgr7fPpHlP1lu1KwKsMe8riMMem7f4wljv+XbuLAz2bJba289QECXqWMXk66QK0Q8LfxN49HU3gkZYllhMPCuZmngJ7Kl1dPsIJPt329GXBdM4JOaLMdPwtCqyhZZlF8R4JR/DZwPBJgQGtSxkEMqUkFd6Yh1ez4/7EAbCPvVC3jFovvsyj15uN4VLX1UOPWGf/+n4Zm+7Yfn9SCcmthz35Yuo5cNK6QS0Y8ey2fHOsw0thd10Z47XEE
Content-Type: text/plain; charset="us-ascii"
Content-ID: <52FB5CC0256C2748B12EDE77512D5B3A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: daabbf4d-f86b-415a-5e5b-08d795f3cd77
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2020 17:37:45.0849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GIhir0y+zzpeakVteSqvdmrei2UgCXxeW7rPG8ZSXdzQDA2pGwsQO6fFSf5cpbczLQ1IZaRLCuM3GOfCjCRwLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3125
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-10_01:2020-01-10,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001100142
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thanks for your review!

> On Jan 10, 2020, at 4:59 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Tue, Dec 17, 2019 at 09:59:48AM -0800, Song Liu wrote:
>=20
> This is starting to look good, find a few comments below.
>=20
>> include/linux/perf_event.h |  13 +-
>> kernel/events/core.c       | 363 ++++++++++++++++++++++++++++++++-----
>> 2 files changed, 332 insertions(+), 44 deletions(-)
>>=20
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index 6d4c22aee384..45a346ee33d2 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -547,7 +547,9 @@ enum perf_event_state {
>> 	PERF_EVENT_STATE_ERROR		=3D -2,
>> 	PERF_EVENT_STATE_OFF		=3D -1,
>> 	PERF_EVENT_STATE_INACTIVE	=3D  0,
>> -	PERF_EVENT_STATE_ACTIVE		=3D  1,
>> +	/* the hw PMC is enabled, but this event is not counting */
>> +	PERF_EVENT_STATE_ENABLED	=3D  1,
>> +	PERF_EVENT_STATE_ACTIVE		=3D  2,
>> };
>=20
> It's probably best to extend the comment above instead of adding a
> comment for one of the states.

Will update.=20

>=20
>>=20
>> struct file;
>=20
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 4ff86d57f9e5..7d4b6ac46de5 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -1657,6 +1657,181 @@ perf_event_groups_next(struct perf_event *event)
>> 		event =3D rb_entry_safe(rb_next(&event->group_node),	\
>> 				typeof(*event), group_node))
>>=20
>> +static inline bool perf_event_can_share(struct perf_event *event)
>> +{
>> +	/* only share hardware counting events */
>> +	return !is_sampling_event(event);
>> +	return !is_software_event(event) && !is_sampling_event(event);
>=20
> One of those return statements is too many; I'm thinking you meant to
> only have the second.

Exactly! The first line is for vm tests. Sorry for the confusion.=20

>=20
>> +}
>> +
[...]
>> +	active_count =3D event->dup_active_count;
>> +	perf_event_exit_dup_master(event);
>> +
>> +	if (!count)
>> +		return;
>> +
>> +	if (count =3D=3D 1) {
>> +		/* no more sharing */
>> +		new_master->dup_master =3D NULL;
>> +	} else {
>> +		perf_event_init_dup_master(new_master);
>> +		new_master->dup_active_count =3D active_count;
>> +	}
>> +
>> +	if (active_count) {
>=20
> Would it make sense to do something like:
>=20
> 		new_master->hw.idx =3D event->hw.idx;
>=20
> That should ensure x86_schedule_events() can do with the fast path;
> after all, we're adding back the 'same' event. If we do this; this wants
> a comment though.

I think this make sense for x86, but maybe not as much for other architectu=
res.
For example, it is most likely a no-op for RISC-V. Maybe we can add a new A=
PI
to struct pmu, like "void copy_hw_config(struct perf_event *, struct perf_e=
vent *)".=20
For x86, it will be like=20

	void x86_copy_hw_config(from, to) {
		to->hw.idx =3D from->hw.idx;
	}

>=20
>> +		WARN_ON_ONCE(event->pmu->add(new_master, PERF_EF_START));
>=20
> For consistency that probably ought to be:
>=20
> 		new_master->pmu->add(new_master, PERF_EF_START);

Will fix.=20

>=20
>> +		if (new_master->state =3D=3D PERF_EVENT_STATE_INACTIVE)
>> +			new_master->state =3D PERF_EVENT_STATE_ENABLED;
>=20
> If this really should not be perf_event_set_state() we need a comment
> explaining why -- I think I see, but it's still early and I've not had
> nearly enough tea to wake me up.

Will add comment.=20

[...]

>>=20
>> @@ -2242,9 +2494,9 @@ static void __perf_event_disable(struct perf_event=
 *event,
>> 	}
>>=20
>> 	if (event =3D=3D event->group_leader)
>> -		group_sched_out(event, cpuctx, ctx);
>> +		group_sched_out(event, cpuctx, ctx, true);
>> 	else
>> -		event_sched_out(event, cpuctx, ctx);
>> +		event_sched_out(event, cpuctx, ctx, true);
>>=20
>> 	perf_event_set_state(event, PERF_EVENT_STATE_OFF);
>> }
>=20
> So the above event_sched_out(.remove_dup) is very inconsistent with the
> below ctx_resched(.event_add_dup).

[...]

>> @@ -2810,7 +3069,7 @@ static void __perf_event_enable(struct perf_event =
*event,
>> 	if (ctx->task)
>> 		WARN_ON_ONCE(task_ctx !=3D ctx);
>>=20
>> -	ctx_resched(cpuctx, task_ctx, get_event_type(event));
>> +	ctx_resched(cpuctx, task_ctx, get_event_type(event), event);
>> }
>>=20
>> /*
>=20
> We basically need:
>=20
> * perf_event_setup_dup() after add_event_to_ctx(), but before *sched_in()
>   - perf_install_in_context()
>   - perf_event_enable()
>   - inherit_event()
>=20
> * perf_event_remove_dup() after *sched_out(), but before list_del_event()
>   - perf_remove_from_context()
>   - perf_event_disable()
>=20
> AFAICT we can do that without changing *sched_out() and ctx_resched(),
> with probably less lines changed over all.

We currently need these changes to sched_out() and ctx_resched() because we
only do setup_dup() and remove_dup() when the whole ctx is scheduled out.=20
Maybe this is not really necessary? I am not sure whether simpler code need=
=20
more reschedules. Let me take a closer look...

>=20
>> @@ -4051,6 +4310,9 @@ static void __perf_event_read(void *info)
>>=20
>> static inline u64 perf_event_count(struct perf_event *event)
>> {
>> +	if (event->dup_master =3D=3D event)
>> +		return local64_read(&event->master_count) +
>> +			atomic64_read(&event->master_child_count);
>=20
> Wants {}

Will fix.=20

Thanks again,
Song=
