Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0705C4332D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 22:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F24D20753
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 22:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qIDyCaG5";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="HvGQ3SxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCRWjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 18:39:25 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38634 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726704AbgCRWjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 18:39:25 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 02IMYlhe020713;
        Wed, 18 Mar 2020 15:37:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=SsHsst7FnDDqMehvYhJY69sQ0h8GoteDH+x6tcYOWtY=;
 b=qIDyCaG5JitTuSt8gaYuT2g7v6ef9AvwCaMEkd1XEy/00Dgr8ltzIP9xAdvAgwN5VJ2N
 aWgI4HMIKsi4OmbQjUPIsP9F7UQwfJI78i5NBUtUDz0NHACYLEh+TUFc/9QMY44vzt35
 sD46PdveeuvVCd7VSFX00G8DHluYbVRI8DA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 2yugve3kjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 18 Mar 2020 15:37:09 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 18 Mar 2020 15:37:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEORmsDn3Zk3OU2QrE8gNjAbOiEXDuxF+h6WS8YPqiNTiA0bTFGVBBiWCM1p27UUXo+LVJ20VfPocj5rE/uOPiK4kj6fX5kBMPxkK08WTY1SZsRv39nKGyNFEZ3gUUlhY3gACEvqafPVDWW5ETMQl7sLluIrsOwYEVWSDT+ssw+DosGjrV3LT6l5sQ2A9phx5guyxlOx0SQNVFw8pE2CqHf+FOHFPFUDRPWtiWWt9RhZa0vfKzPVKCQuZWMQjwzwNnEOoajyfE/+40l+7zQCX4tE5CL07r6nWRFFf7uZUyflPkuLzUc817PQ2S8VsmsJp+pATzGit9KBQGmi6puJKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsHsst7FnDDqMehvYhJY69sQ0h8GoteDH+x6tcYOWtY=;
 b=RTAhTKNteaci4pRaWxbdizXsEwZiwKWX+Gl8frx+T3qIFCtY2nY0gmlmQs9AM8fYzSuowJwTYEHvva1/cenP74mxxVpglWnwxHcIZllg+qOpZYZzIcm+kR1ituhCw6p7KlwjerNg0NvXSUPv43SNYbVh3TUWoJ//Io+OycMBZvjsMw0TT5DDKZJBldyVqJlFbkPzNmMqNe7fDt4A40RJ+xwa1waFX8gg4bsLTMuMaI7cR0taCdQR27S5Lqjr9ixTGRHsMigMllu8qdn6PqKRTqi4SBvg2Hxiselfw2Crb+T3ef0WAHrhzj1ePrFpf8vVU+oVATChFX2wO9EmKZ/mgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsHsst7FnDDqMehvYhJY69sQ0h8GoteDH+x6tcYOWtY=;
 b=HvGQ3SxGV0h9agjzrMwZ/zYjLfVvREdWQoq4GUAEDBXF0Jjbn+Q8D6Xo9aUD6hlY05kSi23k2LGTV4cAcdxgPtV/CZf/eQZdUjf/pjtXM469A0WVrrBnyIg7qc+cfXNWayBhc8AOG+P1QUjGY3R9kqju8PQuV6/vV5+5ESJnsjY=
Received: from MW3PR15MB3882.namprd15.prod.outlook.com (2603:10b6:303:49::11)
 by MW3PR15MB3788.namprd15.prod.outlook.com (2603:10b6:303:4e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Wed, 18 Mar
 2020 22:37:06 +0000
Received: from MW3PR15MB3882.namprd15.prod.outlook.com
 ([fe80::c570:6c46:cc47:5ca5]) by MW3PR15MB3882.namprd15.prod.outlook.com
 ([fe80::c570:6c46:cc47:5ca5%5]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 22:37:06 +0000
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
Thread-Index: AQHV0V1Eb2FOWrPLeESAdNuK47ZqO6f5iwUAgEHpoACAEtBmgIAAt9+AgAAYmICAADNDgA==
Date:   Wed, 18 Mar 2020 22:37:06 +0000
Message-ID: <9C8BEC29-47C2-4322-B169-FD9177BBCECD@fb.com>
References: <20200122195027.2112449-1-songliubraving@fb.com>
 <20200124091552.GB14914@hirez.programming.kicks-ass.net>
 <83AF3F97-7F98-4D52-A230-F04A0AB67284@fb.com>
 <7BA78C8F-9D71-4BDB-BCCE-3036DCF3C653@fb.com>
 <20200318180535.GJ20730@hirez.programming.kicks-ass.net>
 <20200318193337.GB20760@hirez.programming.kicks-ass.net>
In-Reply-To: <20200318193337.GB20760@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.60.0.2.5)
x-originating-ip: [2620:10d:c090:400::5:424]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64478518-bb0b-4011-a2ea-08d7cb8ce341
x-ms-traffictypediagnostic: MW3PR15MB3788:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR15MB3788E37F34ABEDF2C5A9CEB1B3F70@MW3PR15MB3788.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(366004)(136003)(376002)(199004)(54906003)(478600001)(316002)(36756003)(53546011)(6506007)(8936002)(81156014)(81166006)(4326008)(4744005)(2616005)(8676002)(186003)(5660300002)(86362001)(2906002)(71200400001)(6512007)(33656002)(66946007)(66556008)(66446008)(6486002)(76116006)(64756008)(66476007)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR15MB3788;H:MW3PR15MB3882.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lG6ftWnWgsNfWpLBDPRhKGxld8HaXN/8CNFiSeCBQUsjg/MqBc5V2XCwMmDFsnay2MZO2PkMHQ17oylcpSPHEhoAIhBy7thhRxekVikqXxkjA7dNGMEN4ARwRZZ4+FhzUzMLT7sXMGVSe/IiYPR7BE8EhvF9yLC3A81mkFWQkHvIyRH6o1TYztChiRvOuDNp36XaQm9TF3dgousCT3lzabQgXQyhOkAUVziW5lY3rAPfmh+nlGBB4EfZzzxYtoKiBut1f4MxeKqTFSDpZbbtEZFA6MWk+EO5vf6OEyCqbyPV5sQRWyOQ/6lGN3BP7TSPL174p6PgS5rkdvNtjmS22OJ7pg3yzoGn1PitNBQOp+IgGUxlpylqDXVlAIH13YSO+K/iVbAxIrD+i3niIUvL9fGG58Iy9KdbMW9wo7rzqPyjixEnz13bYqiQcODdWDYJ
x-ms-exchange-antispam-messagedata: Xjxlop/YIhBcZgTZMCA4YKhSZEDOazYZneWEQ0BNwS+E6twSkaZc8/7VVwtofPTEAww6oLC6p7P0W9XzeRV8cbEiM7ts72kF11IZ2EkbU0H4aHqZ5kK6Uv6+bYincz/vxYqgk8h9rmIOf7bQOJea+BnOxvMrcHMCZtnZiWjJHxiUFkgB/ZyCe3hWWv8LsCj/
Content-Type: text/plain; charset="us-ascii"
Content-ID: <693D014C23103948B6853721398AB1B7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 64478518-bb0b-4011-a2ea-08d7cb8ce341
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 22:37:06.2394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eJn5tkrIbx73cj7yESqnYRhLbxShl2wdKrSOjEyXH3NzVPRd+kJ4RyXTjdRjQ/1Th6a4evKExmtCuwf8GnGEog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3788
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-18_07:2020-03-18,2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003180097
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 18, 2020, at 12:33 PM, Peter Zijlstra <peterz@infradead.org> wrote=
:
>=20
> On Wed, Mar 18, 2020 at 07:05:35PM +0100, Peter Zijlstra wrote:
>> On Wed, Mar 18, 2020 at 07:07:29AM +0000, Song Liu wrote:
>=20
>>> Could you please share your thoughts on this? I think we cannot use cur=
rent
>>> in list_update_cgroup_event(), unless we call it on the target CPU.=20
>>=20
>> Bah, that cgroup crap is 'wrong'. It's pointless to track the
>> cpuctx->cgrp state for disabled events.
>>=20
>> Let me see if I can unravel that crud.
>=20
> This compiles, but I've no clue how to operate cgroups. Please test.

Thanks Peter! This fixes the issue I saw. And the code looks good too.=20

Reviewed-and-tested-by: Song Liu <songliubraving@fb.com>

[...]

