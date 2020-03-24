Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8B0C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B942080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="FcxBNDH5";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="gDh5X72p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgCXWZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 18:25:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33182 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728094AbgCXWZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 18:25:48 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 02OMGQVf022454;
        Tue, 24 Mar 2020 15:25:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=dU4AYwVJ3ywBetTvmpAy5xfNdzAz4d/EDWEW+qIh8OY=;
 b=FcxBNDH5do7+xWTx1BX68WnGb8dNVRZyZPms8EYeK474lf0vo9JZ5mfshu8L89pnef5h
 91vBAzyI7DlYK2UYM5VigX/bAf+Nt201Pcr/gzE7ChdfWWIjXsJscS4bcY4HigZ9Js6T
 a3H3F5Rb93Zyoh4EQ0lU+EZewbU/Mkzuub8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2ywekngad3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 Mar 2020 15:25:39 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 24 Mar 2020 15:25:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2utdutbpO5AAwqYGpemtLveC3Deoteza/DaYquCqxTI23jTy0BM1MdULWtrFA8rfZUUjBcc1HsCnYAKJSM4Pmty9C9qeJXWbHREdMmQxJDrSrfwP+0Q6fUAX7YHkdvrngIk5Xf7NCK74YRuJ+deYIKq3xGbj8sHy4NtWOm0jmCow9BPR+8EafSQJMdHQy2LL+bUkDnrcjdMaAeMQRSrE5vlYyjaKqo7r1OaVgOTiA8RpbRk2RI82/Dw2K4/9b7K2l8gEijLH+d7DTpPhyE/cyNCijw2tImm9RVHy4GIXFGjLj8A2sRK3Wn02AbskoUlFDlo5I4/oVVi40PbuCLFKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dU4AYwVJ3ywBetTvmpAy5xfNdzAz4d/EDWEW+qIh8OY=;
 b=GsRp8Syt52VWlBVNy9cYv0CScUGfTUWp05K51zSR/bJh1thHy+NP2OOcmNOQMCZViz5pKj7jS8SoFqRR8DaKZV4UY0Tk6zGSgQGa0+UV5kV/mF/K2VcyQw83rxo4xgvQXAJeiKwHaWNYZXXwGAnnB0a4AzG+CnBTr3b+m60E9RGFQ1/+04Qw8WTDwlCYTqrgFlll9ngE4PR1PWiDUL9YiAC/kHRdm4nERLQTven63M2UhIS2buiKtNzPC0++bx3d/7VD5PYdEyYBFKBFq/1utr4CQqhq097zU6LDhHQ89eXeYXXI/c3b3OVxrA0nP2xCUa4IOI4yLfWLRwLflTDFRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dU4AYwVJ3ywBetTvmpAy5xfNdzAz4d/EDWEW+qIh8OY=;
 b=gDh5X72pwIpPT5Up82iHbxHVZuQGaIV7DCOnoengdMB/LQ+ENVbqnzKXPWyJSg6OPu5FyMamXcEGBZWxTmpD/uq59QH4FnHrmGSS/MktVO6IB5mE9+drDjOHWt/j0+T4Mwfi9UiermpfmrFDnjuJKx1sYAE4wCaDwS8JnfZghm0=
Received: from MW3PR15MB3882.namprd15.prod.outlook.com (2603:10b6:303:49::11)
 by MW3PR15MB3963.namprd15.prod.outlook.com (2603:10b6:303:50::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Tue, 24 Mar
 2020 22:25:37 +0000
Received: from MW3PR15MB3882.namprd15.prod.outlook.com
 ([fe80::c570:6c46:cc47:5ca5]) by MW3PR15MB3882.namprd15.prod.outlook.com
 ([fe80::c570:6c46:cc47:5ca5%5]) with mapi id 15.20.2835.023; Tue, 24 Mar 2020
 22:25:37 +0000
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
Thread-Index: AQHWAiT9KEupE+dDF0SaZgMOIv1+LqhYRjSAgAALyQA=
Date:   Tue, 24 Mar 2020 22:25:37 +0000
Message-ID: <92D9FFD5-D381-4E46-92BE-F981F0F91388@fb.com>
References: <20200324214125.153584-1-songliubraving@fb.com>
 <4359BCB5-1FB5-4A5A-B528-10CDDA97A5DF@fb.com>
In-Reply-To: <4359BCB5-1FB5-4A5A-B528-10CDDA97A5DF@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.60.0.2.5)
x-originating-ip: [2620:10d:c090:400::5:393e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac079969-b72a-4660-fb94-08d7d0424741
x-ms-traffictypediagnostic: MW3PR15MB3963:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR15MB3963DC687AE8E9CD5FDF56E2B3F10@MW3PR15MB3963.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(346002)(39860400002)(366004)(186003)(5660300002)(66946007)(76116006)(66556008)(66476007)(64756008)(66446008)(33656002)(478600001)(6916009)(2616005)(8676002)(8936002)(2906002)(36756003)(6486002)(316002)(71200400001)(81156014)(81166006)(6512007)(4326008)(53546011)(54906003)(86362001)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR15MB3963;H:MW3PR15MB3882.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FDUfSD4UiDQrDGt0rmBD/jBu3xrKXaDom5Ae1RwUmslki0phrB1lk1Qlji6dsnB99Zd/AES5wvrB+/vpdUW6TZ/TKvhBcr4l9XPrHWQZ4drXeG9rD54kouq4UsbgOuCa1TtjgTfUPJaanrnN8LxcH5cqDpSx1bQ/kSNJLHdq5iPODnFTx1to17nOijapombaCOr0aPk/J779GkKeLSA3JYLOvWOS1AopqL4JTS1LAnGmWidVB1z+jnOwKHU5TVKHx3lHx4XlYLyF543LeboKEubMJ+9Dx5x/6zT0Ir57IlRG9nB1g3tFHVVASyDY4Szq5nCRLcRqwL/jqjtRu3MpdBvSuw304KkaVTMZKyDduuSt8372fCI+PhsAaNluhwi4yKN0m+21oZsMbvtPklyy/KmO+l6ikZXr2/5O381HT7W2CMLsAIdKbNk6YUsbaVtj
x-ms-exchange-antispam-messagedata: hhuxXTP7xt+GaV86YzPaBJYuNI7CHrJeoGV9Tpxwnq9ZHNoxnztVHELr3iTpUKdx+eaKON3KtTV9f82+OBb2k7/HN4OHiLDydA8w6iwuIPDUmSt91dx7D/VfkzLI7IB2HLcFp1P+PtJpbux9ClRvLX5QZKY+kN7Cg2sumRgWHoZiOFshwsKvY10TqI/RsAvK
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7B633632D4FF5F46A7AEF8E3AE984A07@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ac079969-b72a-4660-fb94-08d7d0424741
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 22:25:37.5860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xS4AS0Ik26VnRmp0yFuREFFKMhlI1xzZpqehjQksRdq1bcfMYl1RJcMf6Oi+pcLTFg6y0WARV2T6z8V39b5s8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3963
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-24_09:2020-03-23,2020-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 clxscore=1015 adultscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240111
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 24, 2020, at 2:43 PM, Song Liu <songliubraving@fb.com> wrote:
>=20
>=20
>=20
>> On Mar 24, 2020, at 2:41 PM, Song Liu <songliubraving@fb.com> wrote:
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
>> Changes in v12:
>> Fix new failures perf_event_tests. (kernel test robot)
>=20
> Typo in subject. This is actually v12.=20

I was stupid... This version didn't work... Please discard it.=20

Song

