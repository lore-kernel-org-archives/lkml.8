Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806C7C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA2220728
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BhKFJ+4F";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="NkCQ81vB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgCFHtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 02:49:18 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45560 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725853AbgCFHtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 02:49:18 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0267gcqE030124;
        Thu, 5 Mar 2020 23:48:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=lvdb6LBvpZEBqSDLj9BPsrBhfl05CzUPmpkM4YswBj8=;
 b=BhKFJ+4FvVhEe0vYVJDdw+aKYVQ0T8CSU0a6E6e8dF8nOVI2613Qf0pT5TKoC3gQo8Pf
 kHrtV5Jk/TRgMovFYu1NmQFsoO3kkNBEW4A6Wb+aueuzY6uGF+vFQ00JdwlH5KaCRLP+
 pLGqlmPKJ0q5AieTtyM7ckDhKawHpZWNhgc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2yk7x8ahw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 05 Mar 2020 23:48:59 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 5 Mar 2020 23:48:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQLKgLa0ILmTC60qO13b9x7cY65jYgKhsZkdr3LsuwzFKeYTF5+K+sWcdro9rf44Lc93j7iI0uLcM9D/OIgo28qTAltyFkR1zgb86rYydyUBduz6lDyJC6ezujW4ohcvFMas0RS5HhKutBOo8HT2R5qhjaJDco90nZDjw1WZpFnJZXCPJKbV0O4POwGEEMtT4U459unQoA0MWwQYAz07FRGzNZDquMntxdEGIPRTaz2HCqKVP2AsCe2s2k0gaMa7f7apyiTcp3tr9C77zn09xll0xksvdrSeyUISSMChvUU5liTO/yfZ3JONbfKxwE8Dv02YuXxjfq3zZVBAL2obcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvdb6LBvpZEBqSDLj9BPsrBhfl05CzUPmpkM4YswBj8=;
 b=K3AbieLoTHWFkkE7Ir5caK1GhZCELe1RfmxfBzc6q7iWj7abyrWy9pI0bRlMOVDCDFITH83XJncReDskMls44+AZHQnKZfxTuDOrQemUZLaJRJt9Q1EwzwX7t9jYt29WyYs9pQzGeos9PXbEjp9XQXTcJmN4qsYU8ZVAYWSMjcmgdk32gyFo16UClG9EjQJ0Hde/uqLCcmicUBi8AOOTkQIuq787WEI8px1v+S8kSQixnbCUlDH8pl7etPcKDUDqvwU1eArAi4DjHcF0kYluR+P5bBhQ88Pdj309T0PK07SdboV2XnS+y/wMTUpKdrsAE+MqlkWizeGKJzVIuAY2UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvdb6LBvpZEBqSDLj9BPsrBhfl05CzUPmpkM4YswBj8=;
 b=NkCQ81vBNSmkd7lGmDW8wMULJCYvIwD/ltZpy8IFE61Io6oZPOoUjEUODNH9alUQTovNobmTQXIXqqGPgG8NmazFvPLNpzjPII5u61bs35kXADwjBRHK+kGq8ES9tcbrNHP1le45j/+DE47z7gdHaXX+Pcb7ehHVfE5PX5a237A=
Received: from MW3PR15MB3882.namprd15.prod.outlook.com (2603:10b6:303:49::11)
 by MW3PR15MB4012.namprd15.prod.outlook.com (2603:10b6:303:47::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Fri, 6 Mar
 2020 07:48:57 +0000
Received: from MW3PR15MB3882.namprd15.prod.outlook.com
 ([fe80::c570:6c46:cc47:5ca5]) by MW3PR15MB3882.namprd15.prod.outlook.com
 ([fe80::c570:6c46:cc47:5ca5%5]) with mapi id 15.20.2772.019; Fri, 6 Mar 2020
 07:48:57 +0000
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
Thread-Index: AQHV0V1Eb2FOWrPLeESAdNuK47ZqO6f5iwUAgEHpoAA=
Date:   Fri, 6 Mar 2020 07:48:56 +0000
Message-ID: <83AF3F97-7F98-4D52-A230-F04A0AB67284@fb.com>
References: <20200122195027.2112449-1-songliubraving@fb.com>
 <20200124091552.GB14914@hirez.programming.kicks-ass.net>
In-Reply-To: <20200124091552.GB14914@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.60.0.2.5)
x-originating-ip: [2620:10d:c090:400::5:f46a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c6c5933-4d63-43bc-6d82-08d7c1a2d356
x-ms-traffictypediagnostic: MW3PR15MB4012:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR15MB40121B745D47773CB843B2E3B3E30@MW3PR15MB4012.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0334223192
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(136003)(396003)(39860400002)(199004)(189003)(478600001)(86362001)(33656002)(316002)(8676002)(81166006)(81156014)(54906003)(186003)(2906002)(8936002)(36756003)(6506007)(71200400001)(5660300002)(53546011)(6916009)(4326008)(6486002)(66946007)(76116006)(66556008)(66446008)(64756008)(2616005)(66476007)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR15MB4012;H:MW3PR15MB3882.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Z/YsNVaHAuePIIcTD9asxBVbz5sFnL3QztJiIiURwydMj5+1BJ8qQhB/UU6Wyo0DT00nWcIevfPra/nokfq6AXX3ZgNw1pOH1hHf/XR4JFfem8aYRYXS+m3Ph00jeHuPVthwXvpJT1ouEvEv/rLNvYTVdp4ZBYHRHALD4oAajr0qpWZvYT96ReS816wrca4hqrr+xa4CKDZq1Y9AJwC+l/dOu/R7U3DFFF0HWspz60BnTovBh9uGmf4bQUmg7TiOSvvpve00buzSamvokQSK+9VvP6IvuhDsoGpZU1ECbOR9R7auHaaRH9c2GvjwVt7fsrWDgTYaidaYvJEHLObOw2NlHF4SOmmS5TY4lzn3QmaWL+XiTsrBzGVOvHeJbiWjBWJ41H4kuOimCrrEaDpaBJpbaI1V2aV+zgT6Zx4vLEEVzG/IWjiTxCjE+jEPQiy
x-ms-exchange-antispam-messagedata: JhyQjrjs6FpBwfrh4yGJag06yZRV0OWuIEqLuKg3AnBKbZ1YXrOBH2uAYTmeCKAKLET/CYtnf/jPZPKBOWSdfQq7RFtwxF5Z2qWwUmGFQdS73anuU9L20ZT1GbNxyLFgWG4EyizG0Pf5nIfIYm6ftrwjiyeQJd++skRkBzjs8AUkhS9Pikfh9CR/yaCW31+U
Content-Type: text/plain; charset="us-ascii"
Content-ID: <821F7309E2BCE4459356DD6A37E012A5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6c5933-4d63-43bc-6d82-08d7c1a2d356
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2020 07:48:56.9140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aQbKWaWoFLYwgdykRbPt5bgfQFarfnCY1u9WpCUIg4GnQtP4e40gzwYZwFYS/WFcmVDca1Z1+C8nEZi6pAWtfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB4012
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-06_01:2020-03-05,2020-03-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003060054
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 24, 2020, at 1:15 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Wed, Jan 22, 2020 at 11:50:27AM -0800, Song Liu wrote:
>> cgroup events are always installed in the cpuctx. However, when it is no=
t
>> installed via IPI, list_update_cgroup_event() adds it to cpuctx of curre=
nt
>> CPU, which triggers the following with CONFIG_DEBUG_LIST:
>>=20
>=20
>> [   31.777570] list_add double add: new=3Dffff888ff7cf0db0, prev=3Dffff8=
88ff7ce82f0, next=3Dffff888ff7cf0db0.
>=20
>> To reproduce this, we can simply run:
>>  perf stat -e cs -a &
>>  perf stat -e cs -G anycgroup
>>=20
>> Fix this by installing it to cpuctx that contains event->ctx, and the
>> proper cgrp_cpuctx_list.
>>=20
>> Fixes: db0503e4f675 ("perf/core: Optimize perf_install_in_event()")
>> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Cc: Andi Kleen <andi@firstfloor.org>
>> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
>> Cc: Jiri Olsa <jolsa@redhat.com>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>=20
> Thanks!

I just realized this won't fully fix the problem, because later in=20
list_update_cgroup_event() we use "current":

	struct perf_cgroup *cgrp =3D perf_cgroup_from_task(current, ctx);

I don't have a good idea to fix this cleanly. How about we just use IPI=20
to install cgroup events (like v1):

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a1f8bde19b56..36e8fe27e2a1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2682,14 +2682,18 @@ perf_install_in_context(struct perf_event_context *=
ctx,
	smp_store_release(&event->ctx, ctx);

	/*
-	 * perf_event_attr::disabled events will not run and can be initialized
-	 * without IPI. Except when this is the first event for the context, in
-	 * that case we need the magic of the IPI to set ctx->is_active.
+	 * perf_event_attr::disabled events will not run and can be
+	 * initialized without IPI. Except:
+	 *   1. when this is the first event for the context, in that case
+	 *      we need the magic of the IPI to set ctx->is_active;
+	 *   2. cgroup event in OFF state, because it is installed in the
+	 *      cpuctx.
	 *
	 * The IOC_ENABLE that is sure to follow the creation of a disabled
	 * event will issue the IPI and reprogram the hardware.
	 */
-	if (__perf_effective_state(event) =3D=3D PERF_EVENT_STATE_OFF && ctx->nr_=
events) {
+	if (__perf_effective_state(event) =3D=3D PERF_EVENT_STATE_OFF &&
+	    !is_cgroup_event(event) && ctx->nr_events) {
		raw_spin_lock_irq(&ctx->lock);
		if (ctx->task =3D=3D TASK_TOMBSTONE) {
			raw_spin_unlock_irq(&ctx->lock);

Thanks,
Song



