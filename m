Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644A4C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 21:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2800D20719
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 21:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GvyVZ71d";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Dcl3NM76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgCXVnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 17:43:37 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48100 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727023AbgCXVng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 17:43:36 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02OLg8r6012855;
        Tue, 24 Mar 2020 14:43:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=REZ9KNkd7/1KtehiIGE20PfHNFrIWc1oDW1NFt4iWR4=;
 b=GvyVZ71defOtueCgCT5wVtIzsRDeq158B4t3gqfgeHmaA70GD5hLSwCoZtldiAoFVtiH
 vY0pOemOh8K1KuGWATQpX+9IMgTgZDdb3C7MBKiNNi4lClHpZIxe5115XHeXZ6cSgF6c
 9mTUf+HKiMoznbRP/4KFVh1Xe0/QXW3zty4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2yy3gy65f2-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 Mar 2020 14:43:30 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 24 Mar 2020 14:43:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5GtcHBo8W5OwFnmmli9eKHztwaYxT4PRv5nPO4CSxByZCheWjo4U8HL+xIjQ5UPmm9yNcWBgqTsGWeUY1Sv8Tr+MR71d6GzKV2ombTKjZIRpOR9NQfc0aFvgd+jJ1GUw7kRVzW9LwxYKEzN0l3MgqTn8VBArzBwwKx1mrYjGxUaYyo/G+zoZWYSbZjUFzce/aTvAoIxlYtTmIq01a8ZdHWAOjQnqMrc9LSD0cokMlHaUjbq1dIrUu7JEZXPYpR3J84RYgnOr/heM85tWrIRVvfiK2JI5p9HwcQSzEkT5ob5RciIxOOk4HR66qyaEn3FTRP/GMIeRkuTKTQlcmCQRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REZ9KNkd7/1KtehiIGE20PfHNFrIWc1oDW1NFt4iWR4=;
 b=VXgdOAy/PDNrzJKdNGw7WurbEW02z4c2pfdShwBRUQ5wcI1bExLPIYviSeAKdEnubIJcOm0OfgSvMuhQCWob7B71ukPAjQpq7tyCTWPIzJNhG8isSu7HEBfe/i4z/dckwvmEQ6kgCCjQqu2CQW/0xG61y4FA5LFUDdxA+sb2M/AyDuIPxka+qAlQ0DUITIoseJ27dQh+410v8FrWos82G7Tlof5GTCmSVEpAs3xs7HOzVSHAHc62DmVFfwV8jcBGMae1C/X+aA/SXrYn6CwK8FFW6AM3ujgG9oa3ACiMgJ4kiG0cVoGnHsOj+HuQqz7cFOs42o6SxotpjQLzgJqTEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REZ9KNkd7/1KtehiIGE20PfHNFrIWc1oDW1NFt4iWR4=;
 b=Dcl3NM76327AaPD9AerkKuh551ah1hN/RidAi0T95z1GFpoT1X4U4da6FvGQkGF2VbnEyg3VWRoJTZYM6jcVHFlfb4ujv54muod0QwN0nMm6IExfEFoUCog6CTDw9Fk9aOkK5Fgp5WWn4yzHtSWevJSuisvet/Ac95g9a8DRue0=
Received: from MW3PR15MB3882.namprd15.prod.outlook.com (2603:10b6:303:49::11)
 by MW3PR15MB3930.namprd15.prod.outlook.com (2603:10b6:303:46::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Tue, 24 Mar
 2020 21:43:26 +0000
Received: from MW3PR15MB3882.namprd15.prod.outlook.com
 ([fe80::c570:6c46:cc47:5ca5]) by MW3PR15MB3882.namprd15.prod.outlook.com
 ([fe80::c570:6c46:cc47:5ca5%5]) with mapi id 15.20.2835.023; Tue, 24 Mar 2020
 21:43:26 +0000
From:   Song Liu <songliubraving@fb.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
CC:     Kernel Team <Kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v11] perf: Sharing PMU counters across compatible events
Thread-Topic: [PATCH v11] perf: Sharing PMU counters across compatible events
Thread-Index: AQHWAiT9KEupE+dDF0SaZgMOIv1+LqhYRjSA
Date:   Tue, 24 Mar 2020 21:43:26 +0000
Message-ID: <4359BCB5-1FB5-4A5A-B528-10CDDA97A5DF@fb.com>
References: <20200324214125.153584-1-songliubraving@fb.com>
In-Reply-To: <20200324214125.153584-1-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.60.0.2.5)
x-originating-ip: [2620:10d:c090:400::5:393e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b138d1bb-b0a2-41a3-1475-08d7d03c6281
x-ms-traffictypediagnostic: MW3PR15MB3930:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR15MB3930C41833098B580DBE9FE4B3F10@MW3PR15MB3930.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(36756003)(4326008)(71200400001)(6506007)(64756008)(66476007)(498600001)(66946007)(53546011)(76116006)(66446008)(86362001)(54906003)(66556008)(6916009)(2906002)(2616005)(186003)(8936002)(33656002)(8676002)(81156014)(81166006)(5660300002)(6512007)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR15MB3930;H:MW3PR15MB3882.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lvQSCLXzKYapZvu3QPLypZWMKCHvSyWObDJv2ecI+AbFTMGrCgSDS3PMYpiMijUYwoipCn8lXJdwEujEWpGj40c12bpoZUO7KmxDZhbDuVgleTzpy4Je3rLF1ab8av+165CPlum8uiRyzXuKyBBD4uUOEIZio8gviU6Mn4/l3XHPS7uRVo4dBLZeJURC1TFyWHNFu199KRAxCoH9Vb1ETLz13oIeaj/ZdE0D118u3/K8C8NgHfEX9O1mR9erwsXW/ng0ZP2DLIW8A+N2yUkuuYMOLjLYVQuLJk8/XemKW0xExLxPmiaJ2LDRiv5Si0UnjnWlrMv9bmdNX327LDWx1WbB1xlnU+8ZeNjC+72+bxQa1wZdP4PbgFckmf1gi3oBNVbpNn38PUU+B0oZwjFFYVFosZ16x0YG3Y3D5HuRTK33ghyHDppJfklN/CG5Hiiv
x-ms-exchange-antispam-messagedata: sG03FACtJ2otRgnHgb87fX3bD8UGZS6AZWqUWs1FX9nQQxO0PcrhpY8nztrgzHSK7g9x4R//l2+vb5Y69NixJQaW3EaA6FAYPjSCX+6ikSYas/m+hzu9dGHOaQv5RIMWNUehlCFVWxmvNpt4vUCGVdS+nr1EgaXnr++BSZdL9TNf0dH5nWew3SrIUqOj0DGw
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AB3101DA2E09574EBC7726AE5D31101C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b138d1bb-b0a2-41a3-1475-08d7d03c6281
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 21:43:26.3644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c33/M54/ayXV/AO715hw98SPxWBNneUhVt/ZnOn5mfRg5hdKoojvZ8sYTrcvmJEBejQ+hSNKd939F6zVMrS5Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3930
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-24_09:2020-03-23,2020-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=995 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240108
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 24, 2020, at 2:41 PM, Song Liu <songliubraving@fb.com> wrote:
>=20
> This patch tries to enable PMU sharing. When multiple perf_events are
> counting the same metric, they can share the hardware PMU counter. We
> call these events as "compatible events".
>=20
> The PMU sharing are limited to events within the same perf_event_context
> (ctx). When a event is installed or enabled, search the ctx for compatibl=
e
> events. This is implemented in perf_event_setup_dup(). One of these
> compatible events are picked as the master (stored in event->dup_master).
> Similarly, when the event is removed or disabled, perf_event_remove_dup()
> is used to clean up sharing.
>=20
> If the master event is a cgroup event or a event in a group, it is
> possible that some slave events are ACTIVE, but the master event is not.
> To handle this scenario, we introduced PERF_EVENT_STATE_ENABLED. Also,
> since PMU drivers write into event->count, master event needs another
> variable (master_count) for the reading of this event.
>=20
> On the critical paths (add, del read), sharing PMU counters doesn't
> increase the complexity. Helper functions event_pmu_[add|del|read]() are
> introduced to cover these cases. All these functions have O(1) time
> complexity.
>=20
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>
>=20
> ---
> Changes in v12:
> Fix new failures perf_event_tests. (kernel test robot)

Typo in subject. This is actually v12.=20

Thanks,
Song
