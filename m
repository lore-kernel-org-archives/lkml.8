Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E236EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B874C207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="j9Vz5mZT";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="N5P7fkvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbgFRUMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:12:22 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56966 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728027AbgFRUMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:12:15 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05IK6nUP005849;
        Thu, 18 Jun 2020 13:12:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=4STLDbGDzrR0eS+1sdZdP0FnsSMF3jxnneWP0FpSxK4=;
 b=j9Vz5mZTcq9j0iG0kiGzODy+pfIWoc4McYgTYMkJNEz6HnzijCiex5JX1EKd00bclzWn
 lRqLhWMjl/7pjEC8XhPWpzhNtq8C0WcfOmGWxbuJ2oRAiVyzmPRsmyY2NPcXnpGurbDu
 W7d7vIymoYnpx0kwy1WeBRutHzqjrKriy3U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31q653p46k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Jun 2020 13:12:04 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 13:12:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuM4aTx1wmxqsqlT9TEwpWvvLlCB7847fnQOXmYVORt9ogCCT2VGyK9WLi7dHmoFAWaQVucyLGkrIHssQprji4sNpqfO52j4mRm/DeeT8u0KTBH5KsIu23kBT1dp5JRtobkfVe0kyTUb2L1r2+stnERj/8K/128uLUjHSYRywzoJsqomXZVQL3Ar+bMfi3bzX5TxRPm9ez+bqqUSDxHuIcpLv9hEJIshbRp8jwxUiP+ALhSto6vvlJI/d/x/ykOdJT3khW7y+05hzGnFyzU5NEDQUUlVH4o8sgKWfRuWGugy1ksIIu79oqrtbGxnRzUROUW0zrWULj+qLPV4Hyul/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4STLDbGDzrR0eS+1sdZdP0FnsSMF3jxnneWP0FpSxK4=;
 b=GzuTxU9ev7CkxUB9YmKO1BdztwxGiln01v5zNP2YT6q5gqVHw/Gj6MLDNsnVgAPsvNFUr9gqasQbYJazWRirFx0amPYcbydb75NYC4XL/yjqIpuGa0HN/uAkR1qUVgubeqne3j54/xerFRicqyEioQuDVzVO7SezRGvkk4UQNLeeBbOew8P7oJTkniA2XFmazramERKnQancynwzwmPqEs7tLhZ5TJTMOyk6hgT8VF7/h31dCeWSAqIdAIACS0tcuicSL+reCitn+xSe96cBMlFqef6Rkcp78cZXMB4+raLin42ZPJ5Up4VFE/prGhkfWSgKoejdgyI0Lm4OVv+C9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4STLDbGDzrR0eS+1sdZdP0FnsSMF3jxnneWP0FpSxK4=;
 b=N5P7fkvSoyBwkgw607K0AmSc1Y/NX9W9UL9IYOM6CVo79GjWU5P9BPMcKR2rICKEG3SuYl83YrdhL03M+M+P/1gv5oxju5PxL4Gnmt+0TwgbH3H4Dl1/tWeIJ7wvYfpF5yzzSMY7OuI0yEMQeb1A3ytC36SNR9ek91FSLemDIHs=
Received: from BN8PR15MB2995.namprd15.prod.outlook.com (2603:10b6:408:8a::16)
 by BN6PR15MB1426.namprd15.prod.outlook.com (2603:10b6:404:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 20:12:02 +0000
Received: from BN8PR15MB2995.namprd15.prod.outlook.com
 ([fe80::a89e:b0f9:d0b9:51a2]) by BN8PR15MB2995.namprd15.prod.outlook.com
 ([fe80::a89e:b0f9:d0b9:51a2%5]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 20:12:02 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Tejun Heo" <tj@kernel.org>,
        kernel test robot <rong.a.chen@intel.com>
Subject: Re: [PATCH v13] perf: Sharing PMU counters across compatible events
Thread-Topic: [PATCH v13] perf: Sharing PMU counters across compatible events
Thread-Index: AQHWIBe1hSxRU5CLwU+YRwxb8aVK4KjeYB6AgAC5JoA=
Date:   Thu, 18 Jun 2020 20:12:02 +0000
Message-ID: <69985C8A-0214-4D1C-B511-039BC3261C0A@fb.com>
References: <20200502002131.3031835-1-songliubraving@fb.com>
 <277BC90B-3A58-4C7C-84B1-B04FE47B08F7@linux.vnet.ibm.com>
In-Reply-To: <277BC90B-3A58-4C7C-84B1-B04FE47B08F7@linux.vnet.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.80.23.2.2)
authentication-results: linux.vnet.ibm.com; dkim=none (message not signed)
 header.d=none;linux.vnet.ibm.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:e176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6adbc578-98d0-4453-76fd-08d813c3dd3d
x-ms-traffictypediagnostic: BN6PR15MB1426:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR15MB1426E5BC7DEFF94E0F90023CB39B0@BN6PR15MB1426.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Xc4SHX90H7vTCq9NRgyAjP0YVg2q0OYoOdC188SQFZ05NJrFOX7YUcrDfvwS5N5c8ukwevgP97nVOdSlM3Uo97WMZFH2YbZfHG8d/TwE0DcBGWvDjWB3tj6sPUPZg/m3mmPkl6HWCsmA+KmkA7NW2fI3PyGpBv5Wdp23LdHa5/DevlHbKHceStloriAqhLYFpM02gG/lGK6TL8RayCvsxtI7eSJho9uzEvOHdguazpTADfz2HYWXYt3zno5OdCTByTR3H0w+4wYFc4n0tSdIH0dZVe0u7Qo6OKQIKAbXXHdMKrNiijKSo/L1A08wmWOYhkDzlX3mOs1uhcM9jmtfQZVzULJfqmz1S79+9rUsl8ou8oBMgRzOupr+G0qKzT+dvNsImAKop5A9TKpvwc2zw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2995.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(346002)(376002)(366004)(136003)(66556008)(64756008)(2906002)(91956017)(76116006)(66476007)(83380400001)(66946007)(71200400001)(66446008)(5660300002)(966005)(8676002)(8936002)(6512007)(6486002)(2616005)(478600001)(6506007)(53546011)(186003)(54906003)(316002)(6916009)(86362001)(4326008)(36756003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: aO2p+EMA84ukfuGOmfFnPnC0kafqjdaCaG2lK67kTXM6vpjsySF9IVj0kh4NNK15vPOWGsZ1gOS33Hb19cY6pEY05pJL0VqhJvf9SubICAe19MAONzt/jqY9PwjoFuIGpDQcxRYQ0wacfqjg2OtSJrUOvrhpN2OIdNesgwq648z5bjcZN9ffvp3GEEEV5/ph5EGix8tRoG6q239SJkzb8cgg2qAuucRLg+ufqBKq7w6qxdXAeq9VhtmO7xzxdZ5jDra91p4DBHAlgiCL1YMShhn8NPqCFks9NKfY+Pdc6EpouTk5eb2OIBxJBvMKLHCL8Du4op8UwVX7nAXZBpv0h9vZgcFw+x0rdmVifaIee7o8NQhCuZaEqwtaLd1W8WsPUoLRUlxFRvvaYHJMzMnOvgbBHbNxPnZ7/2KgFj9T7+Jzf9pV/MYz/f9P/1Eaf6u+uKV6v5CeNEMF5/p+R688Urjn5TA6jUGZehClxBJGFBu+i4nweTcysxv/CnojGr540a4/I6hP7zxK0f3My7uPZw==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CC9401BA71852042ABFF7E9D253CB95E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6adbc578-98d0-4453-76fd-08d813c3dd3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 20:12:02.3119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BXkthcIY8GuLL+mpcaYRqmtIatHSfnmLvT4kmtuEbCbO6AiJBn7B0t7c4dK0sU2jREv+UxGITsui/20fOlcTSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1426
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_15:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 priorityscore=1501 impostorscore=0 cotscore=-2147483648 suspectscore=0
 spamscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180153
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 18, 2020, at 2:09 AM, Athira Rajeev <atrajeev@linux.vnet.ibm.com> =
wrote:
>=20
>=20
>=20
>> On 02-May-2020, at 5:51 AM, Song Liu <songliubraving@fb.com> wrote:
>>=20
>> This patch tries to enable PMU sharing. When multiple perf_events are
>> counting the same metric, they can share the hardware PMU counter. We
>> call these events as "compatible events".
>>=20
>> The PMU sharing are limited to events within the same perf_event_context
>> (ctx). When a event is installed or enabled, search the ctx for compatib=
le
>> events. This is implemented in perf_event_setup_dup(). One of these
>> compatible events are picked as the master (stored in event->dup_master)=
.
>> Similarly, when the event is removed or disabled, perf_event_remove_dup(=
)
>> is used to clean up sharing.
>>=20
>> If the master event is a cgroup event or a event in a group, it is
>> possible that some slave events are ACTIVE, but the master event is not.
>> To handle this scenario, we introduced PERF_EVENT_STATE_ENABLED. Also,
>> since PMU drivers write into event->count, master event needs another
>> variable (master_count) for the reading of this event.
>>=20
>> On the critical paths (add, del read), sharing PMU counters doesn't
>> increase the complexity. Helper functions event_pmu_[add|del|read]() are
>> introduced to cover these cases. All these functions have O(1) time
>> complexity.
>>=20
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
>> Cc: Jiri Olsa <jolsa@kernel.org>
>> Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: Tejun Heo <tj@kernel.org>
>> Reported-by: kernel test robot <rong.a.chen@intel.com>
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>>=20
>> ---
>> Changes in v13:
>> Fix memory ordering in perf_event_exit_dup_master and perf_event_count.
>> Remove test code in perf_event_can_share().
>>=20
>> Changes in v12:
>> Add perf_event->dup_active_list to fix rdpmc. (kernel test robot)
>> Fix event reset. (kernel test robot)
>> Do not consider sharing when the perf event is disabled.
>>=20
>> Changes in v11:
>> Fold in major fixes by Peter.
>> In perf_event_remove_dup(), del() old master before add() new master.
>>=20
>> Changes in v10:
>> Simplify logic that calls perf_event_setup_dup() and
>> perf_event_remove_dup(). (Peter)
>> Other small fixes. (Peter)
>>=20
>> Changes in v9:
>> Avoid ctx_resched() on remove/disable event (Peter).
>> Compare the whole perf_event_attr in perf_event_compatible().
>> Small fixes/improvements (Peter).
>>=20
>> Changes in v8:
>> Fix issues with task event (Jiri).
>> Fix issues with event inherit.
>> Fix mmap'ed events, i.e. perf test 4 (kernel test bot).
>>=20
>> Changes in v7:
>> Major rewrite to avoid allocating extra master event.
>> (cherry picked from commit 8b98afc0ec100b017a5e80c184809939d4f01f8d)
>>=20
>> fix perf_event_count()
>> ---
>> arch/x86/events/core.c     |   7 +
>> include/linux/perf_event.h |  22 +-
>> kernel/events/core.c       | 422 ++++++++++++++++++++++++++++++++++---
>> 3 files changed, 416 insertions(+), 35 deletions(-)
>>=20
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 9e63ee50b19a..a245cac31a19 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -2345,6 +2345,11 @@ static int x86_pmu_aux_output_match(struct perf_e=
vent *event)
>> 	return 0;
>> }
>>=20
>> +static void x86_copy_hw_config(struct perf_event *old, struct perf_even=
t *new)
>> +{
>> +	new->hw.idx =3D old->hw.idx;
>> +}
>> +
>> static struct pmu pmu =3D {
>> 	.pmu_enable		=3D x86_pmu_enable,
>> 	.pmu_disable		=3D x86_pmu_disable,
>> @@ -2373,6 +2378,8 @@ static struct pmu pmu =3D {
>> 	.check_period		=3D x86_pmu_check_period,
>>=20
>> 	.aux_output_match	=3D x86_pmu_aux_output_match,
>> +
>> +	.copy_hw_config		=3D x86_copy_hw_config,
>> };
>>=20
>> void arch_perf_update_userpage(struct perf_event *event,
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index 87e21681759c..1306fbd920fd 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -503,6 +503,13 @@ struct pmu {
>> 	 * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
>> 	 */
>> 	int (*check_period)		(struct perf_event *event, u64 value); /* optional=
 */
>> +
>> +	/*
>> +	 * Copy hw configuration from one event to another. This is used
>> +	 * to make switching master faster in PMC sharing.
>> +	 */
>> +	void (*copy_hw_config)		(struct perf_event *old,
>> +					 struct perf_event *new); /* optional */
>> };
>>=20
>> enum perf_addr_filter_action_t {
>> @@ -552,6 +559,10 @@ struct perf_addr_filter_range {
>>=20
>> /**
>>  * enum perf_event_state - the states of an event:
>> + *
>> + * PERF_EVENT_STATE_ENABLED:	Special state for PMC sharing: the hw PMC
>> + *				is enabled, but this event is not counting.
>> + *				See perf_event_init_dup_master().
>>  */
>> enum perf_event_state {
>> 	PERF_EVENT_STATE_DEAD		=3D -4,
>> @@ -559,7 +570,8 @@ enum perf_event_state {
>> 	PERF_EVENT_STATE_ERROR		=3D -2,
>> 	PERF_EVENT_STATE_OFF		=3D -1,
>> 	PERF_EVENT_STATE_INACTIVE	=3D  0,
>> -	PERF_EVENT_STATE_ACTIVE		=3D  1,
>> +	PERF_EVENT_STATE_ENABLED	=3D  1,
>> +	PERF_EVENT_STATE_ACTIVE		=3D  2,
>> };
>>=20
>> struct file;
>> @@ -645,6 +657,7 @@ struct perf_event {
>> 	int				group_caps;
>>=20
>> 	struct perf_event		*group_leader;
>> +	struct perf_event		*dup_master;  /* for PMU sharing */
>> 	struct pmu			*pmu;
>> 	void				*pmu_private;
>>=20
>> @@ -762,6 +775,13 @@ struct perf_event {
>> 	void *security;
>> #endif
>> 	struct list_head		sb_list;
>> +
>> +	int				dup_active;
>> +	/* See event_pmu_read_dup() */
>> +	local64_t			dup_count;
>> +	/* See perf_event_init_dup_master() */
>> +	local64_t			master_count;
>> +	struct list_head		dup_active_list;
>> #endif /* CONFIG_PERF_EVENTS */
>> };
>>=20
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 206dd29c3c6c..40c8b15407b7 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -1002,7 +1002,6 @@ perf_cgroup_event_enable(struct perf_event *event,=
 struct perf_event_context *ct
>> 	 */
>> 	cpuctx =3D container_of(ctx, struct perf_cpu_context, ctx);
>>=20
>> -	pr_info("%s cpu %d\n", __func__, smp_processor_id());
>> 	/*
>> 	 * Since setting cpuctx->cgrp is conditional on the current @cgrp
>> 	 * matching the event's cgroup, we must do this for every new event,
>> @@ -1012,8 +1011,6 @@ perf_cgroup_event_enable(struct perf_event *event,=
 struct perf_event_context *ct
>> 	if (ctx->is_active && !cpuctx->cgrp) {
>> 		struct perf_cgroup *cgrp =3D perf_cgroup_from_task(current, ctx);
>>=20
>> -		pr_info("%s cpu %d cgrp %px\n", __func__, smp_processor_id(),
>> -			cgrp);
>=20
> Hi Song Liu,
>=20
> I had  problem in trying to apply this patch on latest upstream. Example,=
 the `pr_info` in perf_cgroup_event_enable. Looks like there were some loca=
l changes on top of which this patch was created. Could you please confirm =
to make sure there are no other changes missing.

Sorry for the confusion. You are right that those two pr_info() are from a =
local
commit. I pushed latest version to=20

https://git.kernel.org/pub/scm/linux/kernel/git/song/linux.git/log/?h=3Dpmu=
-share

Please let me know if you have problem with it.=20

Thanks,
Song=
