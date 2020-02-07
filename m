Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444C7C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1006A21775
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="dtc2qxdB";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="EvvSVUqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgBGUE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 15:04:27 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:29124 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727012AbgBGUE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 15:04:27 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 017JsCda019699;
        Fri, 7 Feb 2020 12:04:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=hNgVx3bF/lpnJxZUFvJoDKaBlM66fdJkZZKPCgMntYY=;
 b=dtc2qxdByHMlZ2iraw85CCROHez6zddUFMQj8c94H7lCf/NofZt4mzD6sw7Jzlr6nd5a
 l/fLypP1LGN1nIe90awUACj8s8yGoPoAy3hONlEMUxNuUqI38osGCFqfD+hOZJn9rCaF
 7haFgdgUbufACQXfPxBJ19JfI9Onc2tKt/k= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2y0w44vs6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 07 Feb 2020 12:04:13 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 7 Feb 2020 12:04:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3KzBtfxOvCkgmqLXrL/6gie/sWLIDeMYBAtvXvcsKtH/pnv5xkZfWFPoU5u7XZfAWwFRdDvAeziQmEyOAxZQSo6iWeX1x4oBpWrLT66MClQKKdTrqNKQ1HUyUCvjnfh+nPl+J8J036yv478kqJUSlcK4IvDn6whSc+KqDHLktXc/yJBeMvSHvlYgO45BzkpXncpgYT1byW7Q5fvwNx4iPhM34a7tcZj3FSAIa3YO3Aq6xFyxHPayzrWAgkFPqXG3aUL/71AY1rn7Zb0Gx+RptS32FNbgJFhybw4FvRUsJADXvWnZCU8qFVM2ZFy1MspBlWBlJq46QNY/fGAodCSuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNgVx3bF/lpnJxZUFvJoDKaBlM66fdJkZZKPCgMntYY=;
 b=B6RlUSXPeGWHJ4UEUWUZFcqhgViFDiN0fGjoKycHMbZyap6oEYXBQT/3MGROE8jBchb9nctqzj/rzDBXHugjh2Ul44aIEfXWOwOFQRC5yqocbE2qJafewy3ZEQk2hEDSmAz2JsnZoS1Di/2lft33b4YeLkyMOEgu3lXhOzqwQHCLbwoFn5ds0wbvvAH1ZztaUKsoXfC48NWrYcXGe9p4tk0RCp6s+2jKkF75J8xmBdhVAeaXgLaeFTS+blHhSIwOgCcosERyaWdQNT0+EO1rsmFJTTagZracu8G2A4tEgaJ0B8Y/PyoSPWI8aU2bJKcNLaoaOKsuwh/oYazdouHq5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNgVx3bF/lpnJxZUFvJoDKaBlM66fdJkZZKPCgMntYY=;
 b=EvvSVUqaib/l7l1QjMNWhNEIIpl5IxQcUdr16SL/GHebnXRl49Igy93BJ9qsuDgaVPg3PhjMeEPZ7O1gkPRyxHu1al1vgwYUrnOs//O3pJJbAzX4XdmcFqmUnPUanS88afourFK+Jke1tkicTZGoZKkEtKUtynFbSzL3FvAHqAU=
Received: from BYAPR15MB3029.namprd15.prod.outlook.com (20.178.238.208) by
 BYAPR15MB2808.namprd15.prod.outlook.com (20.179.156.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.25; Fri, 7 Feb 2020 20:03:37 +0000
Received: from BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d]) by BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d%3]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 20:03:36 +0000
From:   Song Liu <songliubraving@fb.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, "Tejun Heo" <tj@kernel.org>
Subject: Re: [PATCH v10] perf: Sharing PMU counters across compatible events
Thread-Topic: [PATCH v10] perf: Sharing PMU counters across compatible events
Thread-Index: AQHV0ceIFPg0JiU2jUSAuybmBxXqTagQP8yA
Date:   Fri, 7 Feb 2020 20:03:36 +0000
Message-ID: <4360A101-E777-423F-8F6C-A54D99BA151E@fb.com>
References: <20200123083127.446105-1-songliubraving@fb.com>
In-Reply-To: <20200123083127.446105-1-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.40.2.2.4)
x-originating-ip: [2620:10d:c090:200::3:48ca]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a500465-f64e-4a7b-9850-08d7ac08d167
x-ms-traffictypediagnostic: BYAPR15MB2808:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2808F52D7D5F2F2FC3C6E819B31C0@BYAPR15MB2808.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0306EE2ED4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(39860400002)(396003)(366004)(346002)(189003)(199004)(71200400001)(6512007)(186003)(54906003)(8676002)(86362001)(81156014)(81166006)(478600001)(110136005)(316002)(33656002)(6486002)(91956017)(5660300002)(2616005)(36756003)(53546011)(66446008)(66946007)(6506007)(64756008)(8936002)(4326008)(76116006)(66556008)(66476007)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2808;H:BYAPR15MB3029.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TkKNslDu1OiGNQvI2l27wDZsc1NHNkUSiGy8DtJBvTW1+rTSNRThat7BiWDTVRIuJvcn4De054HK3nPR/c1jnGNltAFUtChjReDfxHBIDHNFflPfAqFDeKWKDEpDPmmDcaaFgxjT99I++PceAOajBcrNe5q8zjBAHVeSzRDWbYGcH/NhX9JiDlB1TeBWvPcKFtks3J569sC9LLLVM1hTTXJtRY2ygODGZhbOcInOmQcT13hBCZMSU6/qkZkrBuQL38KH5XvyDp9iwQ8FQgyZz/Kyz+hbxWUKW556y6Htw+FPUjvvhHi9ysndQUKAHfT1Ky51L7HKoImXFhW0Dp6m7O+0IasXahSe3qaUa9eejK4kvRsGczQGgNWFmrxn9mGL1FBXG9oYJxg/dAmoPFyN+a+0aETgBrmqt69Jxvr8L6yFlUhN3U+U7T5jh8Ka31wv
x-ms-exchange-antispam-messagedata: mn02iqCwP2m0P0w0dhFpVf3gARJO1FVUy93l0g1v9uhrypw4KV3veVQV5Ws/gHNPDWCYWTqu2RB5mUmtdmze/qIfGTd/xGL9KzLZ7xXrNyvkmIJXaukM737NUNz0BYVzkBDGDoINoS1svOGq5y2Wb0luZBDfsqTQOPLkLw2ktlAL/GV9ukLLukIgDu390izj
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B99359502D5FAA4298A4668FECBC9215@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a500465-f64e-4a7b-9850-08d7ac08d167
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2020 20:03:36.8747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x3dk3GC2zlPR4rcRyi5J8cV6zIdbRgg573KhKpWSLLbNoyLahWkORM51mX6i/6kXdXrG2yQm6XIxFND9DL/RcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2808
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-07_05:2020-02-07,2020-02-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 spamscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002070142
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,=20

> On Jan 23, 2020, at 12:31 AM, Song Liu <songliubraving@fb.com> wrote:
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
> A new state PERF_EVENT_STATE_ENABLED is introduced for the master event.
> This state is used when the slave event is ACTIVE, but the master event
> is not.
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
> Signed-off-by: Song Liu <songliubraving@fb.com>

Could you please share your feedback on this version?

Thanks,
Song
