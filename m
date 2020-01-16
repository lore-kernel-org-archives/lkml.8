Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17521C33CAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 00:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D702020748
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 00:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="pXyu3rBv";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="BVh8hSD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbgAQAAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 19:00:05 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:22920 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726189AbgAQAAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 19:00:05 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 00GNtf7s009020;
        Thu, 16 Jan 2020 15:59:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=XGj+A4Ij+wbI4SpmauNL9iiBCPrJa41ekgKMAd5jB68=;
 b=pXyu3rBviVz17SyxO6JShkKTblYO5rdAzv2vun/zlRVpIJoNJLb3BvDrVQ8Nj3Y7kML+
 ia9u/UgdH39mSI7LHDQf6Il+F21KpFCdTvfie0eCX0HOt/U5B+3rDDMGduIA3qUMkAev
 VMLejeo1hb3zk79uvHpr4jSWOxNltdLMwIg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 2xk0s7r91t-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 Jan 2020 15:59:50 -0800
Received: from ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) by
 snc-exhub102.TheFacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 16 Jan 2020 15:59:49 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 16 Jan 2020 15:59:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aF4JKMLz7No90TUW/OA+VeE/1Cjhyr17+E/kB0y08Gz68uHYtnwjc6zYNOq+JmtCf//WZgIGfdi/9HuzmueKPZgPThTpC4uZ5deCTZtvsys4BBTiN2uyWcxA7GVfczlDk+DjiGtoa2/oSxExSg/0Km+vC0OtSlmdPglizlUXdVUryzAkSVXVjJagB4ZYxQ1Py8NW51AnEgRYyJ/L/FJv8as0mg6QDuxaegI6GNpz6klzdh6IlNs+rQbWBqAJCflzddqbzz1P+u+YfuP485dw4uFcNVRCCo7i0hbz5mkAZSJ6thUDi1NUrldp0PK9OUBpb2xKQW2zAJog1ahKKetBLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGj+A4Ij+wbI4SpmauNL9iiBCPrJa41ekgKMAd5jB68=;
 b=Vk+iWwI1W0kYwdBK7WjwAArFoQL+A68GiX9naXL8DYBXA8svV9fl6fQgGRXkyBJybT6eJ+N12oymB95jwpF/Ldv1UGOclkYgCsnI+ZOVleMl/D15/AJGx5Ou7ChkS27PcYhAYvI5RyvEey0Oz/PEP46Df97G9Z5XjINKYIlmlTQpm0qw5rpgjSmAMcaLH52AZ3WXGAxsOidkFInQ/jR+F1C19x5ILp/Fz0kfuSf4elJXaxp6pmnNXFBUaahmUPS1frBpe8oPTfsmM+8QQVeSg0k1n8RA7ui6LzN9vCPHrmnVxVp14ly2KdCqsq5rLY6OpQqmvVm/sQrhTCKrmXAcLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGj+A4Ij+wbI4SpmauNL9iiBCPrJa41ekgKMAd5jB68=;
 b=BVh8hSD3Kw1l2czS7k/IrfxPzcrAnrlaEEgeHVmgvrWhA+pLANIf6h/pszRDgJz3ggn5Xmak8J/HYduDxNxl72WEElK9c/zo4XaHu8DmWD3OFtGZeK8+G4G7himTqogY4i5rQPX8rOpmOQwgIjFD/gofux5nXs7WRun2FseC+uQ=
Received: from BYAPR15MB3029.namprd15.prod.outlook.com (20.178.238.208) by
 BYAPR15MB2597.namprd15.prod.outlook.com (20.179.157.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Thu, 16 Jan 2020 23:59:14 +0000
Received: from BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d]) by BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d%3]) with mapi id 15.20.2644.023; Thu, 16 Jan 2020
 23:59:14 +0000
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
Thread-Index: AQHVtQPKZjAIrpT67EGLkBjlWidLzafkAaAAgABNrACACdiTgA==
Date:   Thu, 16 Jan 2020 23:59:13 +0000
Message-ID: <CDB64D32-4E89-4884-88B8-66DCB1DFA8E3@fb.com>
References: <20191217175948.3298747-1-songliubraving@fb.com>
 <20200110125944.GJ2844@hirez.programming.kicks-ass.net>
 <CF654118-59C1-46AA-B9DB-CA14D9FFACF7@fb.com>
In-Reply-To: <CF654118-59C1-46AA-B9DB-CA14D9FFACF7@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.40.2.2.4)
x-originating-ip: [2620:10d:c090:200::76e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3fa8de6-77d0-4315-621f-08d79ae016c6
x-ms-traffictypediagnostic: BYAPR15MB2597:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2597403C1DF24B3BF2F3DAA9B3360@BYAPR15MB2597.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(39860400002)(376002)(366004)(189003)(199004)(81166006)(81156014)(6512007)(91956017)(53546011)(4326008)(76116006)(86362001)(36756003)(478600001)(66556008)(66476007)(66946007)(186003)(2616005)(33656002)(71200400001)(5660300002)(64756008)(66446008)(54906003)(8936002)(2906002)(8676002)(316002)(6916009)(6506007)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2597;H:BYAPR15MB3029.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YTM7qXMIekTd1BtB3eW60hWJDRN96ODKbh0VYcd6jWkILI9FnBH6A3jyyG9nMg2p6dqsuTpZflv77e8USgnmLU+usw3I0Bs24Dmc3j+6MwBKBCMprOLWf5FTycA9ZRMCDbyHkYYwZAvxema2FM/nkV5feBZ0hraPkfDPHEMov0xxM0RSlXl0aJpvSu4XZxte6BlJpVQ2c2Xi7HCtjhAX03A/PYF+BfNywdEcpvpkcrdwJpyz8G8wfHL4y8fmHiHFbG/6C+P5nTc9zOY78PidxR4PcOARMg8HwDU+AuKTmaz9FZMqxF2c1xG3yqnfZtfJqLhuOkIITdEDJWs2xKfXejea0yyWqc3oEG/xsK8Q+0B0ZnS4bFDuTigSL5XbpIlnnJO8B2RsYGM1xZDjTTUEITnnEsP13mHupyG7SLesdoHqCt/vSVn1vBVQrhc/nyD+
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2EF1423DAE43B64DACC0894286B7D9E9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c3fa8de6-77d0-4315-621f-08d79ae016c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 23:59:13.9157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h3UjxYKXC4i+8cmJBHcaN1IAE/p5qa9gIFURM3Hqh9uqOJGIREbt5SWmZJwIfjhLYxGpPLhnAFM/37bm5VDnAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2597
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-16_06:2020-01-16,2020-01-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=839 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001160190
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,=20

> On Jan 10, 2020, at 9:37 AM, Song Liu <songliubraving@fb.com> wrote:
>=20
>>>=20
>>> @@ -2242,9 +2494,9 @@ static void __perf_event_disable(struct perf_even=
t *event,
>>> 	}
>>>=20
>>> 	if (event =3D=3D event->group_leader)
>>> -		group_sched_out(event, cpuctx, ctx);
>>> +		group_sched_out(event, cpuctx, ctx, true);
>>> 	else
>>> -		event_sched_out(event, cpuctx, ctx);
>>> +		event_sched_out(event, cpuctx, ctx, true);
>>>=20
>>> 	perf_event_set_state(event, PERF_EVENT_STATE_OFF);
>>> }
>>=20
>> So the above event_sched_out(.remove_dup) is very inconsistent with the
>> below ctx_resched(.event_add_dup).
>=20
> [...]
>=20
>>> @@ -2810,7 +3069,7 @@ static void __perf_event_enable(struct perf_event=
 *event,
>>> 	if (ctx->task)
>>> 		WARN_ON_ONCE(task_ctx !=3D ctx);
>>>=20
>>> -	ctx_resched(cpuctx, task_ctx, get_event_type(event));
>>> +	ctx_resched(cpuctx, task_ctx, get_event_type(event), event);
>>> }
>>>=20
>>> /*
>>=20
>> We basically need:
>>=20
>> * perf_event_setup_dup() after add_event_to_ctx(), but before *sched_in(=
)
>>  - perf_install_in_context()
>>  - perf_event_enable()
>>  - inherit_event()
>>=20
>> * perf_event_remove_dup() after *sched_out(), but before list_del_event(=
)
>>  - perf_remove_from_context()
>>  - perf_event_disable()

Quick question:

For the remove_dup() path, if we do it after *_sched_out(), we will need to=
=20
disable-then-enable the pmu for one extra time. In current version, we only
call perf_event_remove_dup() in event_sched_out(), where extra disable/enab=
le
is not necessary. Is it a good tradeoff to add one extra disable-enable for=
=20
cleaner code?

Thanks,
Song=
