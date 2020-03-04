Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCED3C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 21:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C5D20716
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 21:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="B+SQ9R+9";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="C+8huLhE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388446AbgCDV6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 16:58:18 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43300 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387931AbgCDV6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 16:58:18 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 024LtZqZ013987;
        Wed, 4 Mar 2020 13:58:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=iok187FsPZ7bx5uFOU6/LN/guczVl9tBlDVt+jE17gU=;
 b=B+SQ9R+9R9TNYJsKzL2tlBO9wb810ikqo9K043TV+LU9zaCpY21+U+BxAObcSpX9FKN6
 qYQxCtN7dn1vvvLDG4+btvV85QOldYI5VfroZ3/JEK5PW4GrrX/azjInFcDbfVakVmxg
 yjNRjitSF/QQPFgvKKGXflQiQp9MQjhDuJM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2yhv7vqjk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 04 Mar 2020 13:58:07 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 4 Mar 2020 13:58:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n00sN4ecdmBc6QyKbKZmAwlIrmscLQHVNswg7uPpvAy/s04lFd+y1soFlJ/Z4rYOol/fEUyxRq0inRCv04ke55wjkJhn7LSzOVOB2XEV1TSO1yk7y2CCIp+/K1Hh4LweZ6T7eE0HebIwAToEv5+yf2MqHgznnFXlqQzmGwO0Mv/zn3uoJHTwS54BYsesm6NN7qn5ntGJ/0pYXSw0J778aB8DaWDirPNo10JrOtQLRlJOFi3ytpfKVD72/bzf4LYDdtS+xuknhnO3UvsDv6LoY94zmGYDA1S7LCdhVOBf/7pDhEzZsI22FSe6oypRXL8B/iY4PoUoh1j0trNCrwZhkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iok187FsPZ7bx5uFOU6/LN/guczVl9tBlDVt+jE17gU=;
 b=kh6sutKoB8M/w9dGp3Q7uTx32Z27K3Zces3FDUjjS1a2c73hdcKZMeknTb5b27Z7yFvjT7bB0HVuxRUzvw91VfLT+NCq+VTb+1RWKtEH77Ba55/q4qDlS3izobldcthRwfTEannJG1PilR36wygNE6MBqRQuvOmQOitLe1LVT+lFWB73ul9zjl9aNOP/akj9tqf3Z0QNWmtHW3HMQefKFZ34brxpJzGqb5CTqzRDQQVi7iAhI8FwZjLBegVCuvMmUe56vyK9RBke2EXUX/pm34nAoX7kHreERP1e8aNd1Me2QT6gqj+vwumQHB7pkSJYheinElp2Ue4tP48079iJUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iok187FsPZ7bx5uFOU6/LN/guczVl9tBlDVt+jE17gU=;
 b=C+8huLhE5xopzzskkNl/oZXDV/IT4LKXJ7QlhZ9+CU6vcYvXS8cmKCxJfESMwy9MLg9Uo/AtA2SIDGFJkOeXC0fawpuawMBZ4sT09GyvmgL5AuKeVc3+wwzJSx/ip5Jzp26lVdHtfCyXrtVZxwuOIjwQxqE38c4irlYbQur6LY4=
Received: from MW3PR15MB3882.namprd15.prod.outlook.com (2603:10b6:303:49::11)
 by MW3PR15MB3962.namprd15.prod.outlook.com (2603:10b6:303:45::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 4 Mar
 2020 21:58:03 +0000
Received: from MW3PR15MB3882.namprd15.prod.outlook.com
 ([fe80::c570:6c46:cc47:5ca5]) by MW3PR15MB3882.namprd15.prod.outlook.com
 ([fe80::c570:6c46:cc47:5ca5%5]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 21:58:03 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v10] perf: Sharing PMU counters across compatible events
Thread-Topic: [PATCH v10] perf: Sharing PMU counters across compatible events
Thread-Index: AQHV0ceIFPg0JiU2jUSAuybmBxXqTagwkW4AgAAC5QCAB/tAAIAArNEA
Date:   Wed, 4 Mar 2020 21:58:03 +0000
Message-ID: <CD97579C-B416-478A-A004-F1B0E35B8D12@fb.com>
References: <20200123083127.446105-1-songliubraving@fb.com>
 <20200228093604.GH18400@hirez.programming.kicks-ass.net>
 <20200228094626.GN14946@hirez.programming.kicks-ass.net>
 <22C4E3F7-E367-4305-A40E-C39A8E46C1B9@fb.com>
In-Reply-To: <22C4E3F7-E367-4305-A40E-C39A8E46C1B9@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.60.0.2.5)
x-originating-ip: [2620:10d:c090:400::5:4f8d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e19b93c9-4718-4683-f31c-08d7c0871d35
x-ms-traffictypediagnostic: MW3PR15MB3962:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR15MB3962366AD0A5A73D363099BCB3E50@MW3PR15MB3962.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(366004)(346002)(136003)(189003)(199004)(36756003)(66446008)(6916009)(6486002)(186003)(478600001)(6512007)(4326008)(2616005)(6506007)(54906003)(2906002)(53546011)(86362001)(71200400001)(316002)(76116006)(8936002)(66946007)(8676002)(66476007)(81166006)(81156014)(33656002)(5660300002)(66556008)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR15MB3962;H:MW3PR15MB3882.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VbpopFel8LaXudk+tOeMeK2cgUEelSgtWOTiGkEpTYkY9IRAbdafvsxtB++XDvSwq7TDDIANcJPkMJETvxHTrZzEunjVi126MS8vJJA3huX10eYldJjGTHxPnOrPYtu0G3Ch4iawjF7HcP9T8zr8/X1XeTJxZYHGmrYIDyJsSHMt30sWUk94g4KGKxEKi4iNAhX8Gz3Q4KB5hRSIReL0Nk/BidkpndJUXI3ttpoWn+E083JoT9Uj1TuQej6iz14bjHCnP/vydyOzi00ducu+6TkKcHMPVHm3+l9PVtVCwtooNTSR3WK5sZ91Dgr8cE8OGwUFFrqQrbQNpl8Z4N6e/LkmqrMLyptnhBmwbVo/dVZihEZ9J+15vf4TzKxW7n1aHqiPZ24nzfc/vlCRmGonoN44ek94y5Nebfn7j9E+T8NJeattc7ADF4OnULHb5vAu
x-ms-exchange-antispam-messagedata: 8J1vefJxehFDTSY7YD+AR2vcUIfqcxq+jegdffB5VZVyP2Dt7rrzLJ14m9e2E/6ZMfCjYOiLPTdcAtRRf32m5A2TyASMosZ2tFV1NPNrCGBxBMNk2Pv56PnV6VP2zt8Mb3SyzPwU8M0NwYpetClf+AJc/6wRXgMEPaGbl8BsWFB7h61d2mMNrApZdlVMR4jo
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CD57E8C8A319A446BDA77AD07040A4C3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e19b93c9-4718-4683-f31c-08d7c0871d35
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 21:58:03.7734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bufsqFWxnHLO/GoK2kxb1b6yQtRkX329hzzMmqk4gdbRGtUj8YouI99yTDWyRP1F1xF0Z4jzn6IJEvsiSFNOQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3962
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_09:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040140
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 4, 2020, at 8:48 AM, Song Liu <songliubraving@fb.com> wrote:
>=20
> Hi Peter,=20
>=20
>> On Feb 28, 2020, at 1:46 AM, Peter Zijlstra <peterz@infradead.org> wrote=
:
>>=20
>> On Fri, Feb 28, 2020 at 10:36:04AM +0100, Peter Zijlstra wrote:
>>> +
>>> + /*
>>> + * Flip an active event to a new master; this is tricky because
>>> + * for an active event event_pmu_read() can be called at any
>>> + * time from NMI context.
>>> + *
>>> + * This means we need to have ->dup_master and
>>> + * ->dup_count consistent at all times. Of course we cannot do
>>> + * two writes at once :/
>>> + *
>>> + * Instead, flip ->dup_master to EVENT_TOMBSTONE, this will
>>> + * make event_pmu_read_dup() NOP. Then we can set
>>> + * ->dup_count and finally set ->dup_master to the new_master
>>> + * to let event_pmu_read_dup() rip.
>>> + */
>>> + WRITE_ONCE(tmp->dup_master, EVENT_TOMBSTONE);
>>> + barrier();
>>> +
>>> + count =3D local64_read(&new_master->count);
>>> + local64_set(&tmp->dup_count, count);
>>> +
>>> + if (tmp =3D=3D new_master)
>>> + local64_set(&tmp->master_count, count);
>>> +
>>> + barrier();
>>> + WRITE_ONCE(tmp->dup_master, new_master);
>>> dup_count++;
>>=20
>>> @@ -4453,12 +4484,14 @@ static void __perf_event_read(void *info
>>>=20
>>> static inline u64 perf_event_count(struct perf_event *event)
>>> {
>>> - if (event->dup_master =3D=3D event) {
>>> - return local64_read(&event->master_count) +
>>> - atomic64_read(&event->master_child_count);
>>> - }
>>> + u64 count;
>>>=20
>>> - return local64_read(&event->count) + atomic64_read(&event->child_coun=
t);
>>> + if (likely(event->dup_master !=3D event))
>>> + count =3D local64_read(&event->count);
>>> + else
>>> + count =3D local64_read(&event->master_count);
>>> +
>>> + return count + atomic64_read(&event->child_count);
>>> }
>>>=20
>>> /*
>>=20
>> One thing that I've failed to mention so far (but has sorta been implied
>> if you thought carefully) is that ->dup_master and ->master_count also
>> need to be consistent at all times. Even !ACTIVE events can have
>> perf_event_count() called on them.
>>=20
>> Worse; I just realize that perf_event_count() is called remotely, so we
>> need SMP ordering between reading ->dup_master and ->master_count
>> *groan*....
>=20
> Thanks for all these fixes! I run some tests with these changes. It works
> well in general, with a few minor things to improve:
>=20
> 1. Current perf_event_compatible() doesn't get full potential of sharing.=
=20
>   Many bits in perf_event_attr doesn't really matter for sharing, e.g.,=20
>   disabled, inherit, etc. I guess we can take a closer look at it after
>   fixing the core logic.=20
>=20
> 2. There is something wrong with cgroup events, that the first reading=20
>   of perf-stat is sometimes not accurate. But this also happens without
>   PMU sharing. I will debug that separately.
>=20
> 3. I guess we still need to handle SMP ordering in perf_event_count(). I
>   haven't got into it yet.=20

I guess the following is sufficient for the SMP ordering with=20
perf_event_count()?

diff --git a/kernel/events/core.c b/kernel/events/core.c
index b91956276fee..83a263c85f42 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
 /* tear down dup_master, no more sharing for this event */
@@ -1715,14 +1713,13 @@ static void perf_event_exit_dup_master(struct perf_=
event *event)
        WARN_ON_ONCE(event->state < PERF_EVENT_STATE_OFF ||
                     event->state > PERF_EVENT_STATE_INACTIVE);

+       /* restore event->count and event->child_count */
+       local64_set(&event->count, local64_read(&event->master_count));
+
        event->dup_active =3D 0;
        WRITE_ONCE(event->dup_master, NULL);

        barrier();
-
-       /* restore event->count and event->child_count */
-       local64_set(&event->count, local64_read(&event->master_count));
 }

Thanks,
Song=
