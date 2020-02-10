Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B861C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D63820870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="SnZ5ejLB";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="c1egseJH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgBJSxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:53:37 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42844 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726991AbgBJSxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:53:35 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01AIq7LB002073;
        Mon, 10 Feb 2020 10:53:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=76oEEevSo0h5Ir+fcv17M2wPS+BoC9m7SpTS+PHfqzg=;
 b=SnZ5ejLBJx7lE5rzCUV9+1aeiToL6fX4DA8JyCHNOdPwUyeGLG6ZyjeWm3aPB+4/aD7E
 7g1zNtqnz0g02tnHrtaPo0ytRgvZZKEAWf9tnJpzyQKaRaQvw+CEsH25uNgI1xZdyElg
 b/qiZhbn+medOUTjS+CsYAi3c3eS3a8tlW4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2y1ukurttd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 10 Feb 2020 10:53:22 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 10 Feb 2020 10:53:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3EYhCqeOca+E0SucroJ8R4AM8RLtfIj282umEm/PIvKnCRtLil6HJAHFCwv+v4ZvR53smjX06DFkZbI69zffV2Tbx5kA/6Vzp5QazJhRgHFOn5JxZQi7rVJjinsTgFtdIkYJIN7dyekIdQ3DLJOVs5LXAT6HGS5KDR+h+LpFaWIp88cL9hI6Ge11IpCgRdbyKg+O52Ow+Ha7HeaG0PApAITmrYXluWSB9cA4IeoxTSemQXviKqWf1GLwmRdmshTjEvLTi9kvc4i8YVtkfnOg1ckZEth/4h6l6MaOykXZj/n5r8o2TS6OG4LiRIH7EG9HHhqx6NBxYEFB+yi63pjIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76oEEevSo0h5Ir+fcv17M2wPS+BoC9m7SpTS+PHfqzg=;
 b=HkEQSEab1+f777mzQbAZYrU5gwYB59IpYdNe1KE1tOqrS2k6WVDDUarqiaNuWLN8LvzytYQi+UhaKO7E7CkVry00/bxava18DQAgK3uxlbe8v/CDC3l7zHPcHo3dH3y3IS88OSHBmalti83DtI+ts7/IWq4g+VxiNeu9B7PKwUXsMqSX8OWSmoX/MerbTVs4ahI/XkPSj5KeID7U5yEU/xBOEPEFO3AaTsnF8cEM1QRV7tShlO8C5vBbj20YH5S6XymW5RH1mSXg+AVqISP7DV55cVyZU+RDDoSTzjoo+NEWCc0LsaoUUDCU805QPxMbAsrj4QiO9cBclJg+kAUOZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76oEEevSo0h5Ir+fcv17M2wPS+BoC9m7SpTS+PHfqzg=;
 b=c1egseJHfpm3OaXHrCXNn4XBhjkwyYQEcG9z2B1D2DS0Khms6+DkQbdGOZaibaBNrGuixwTDMxhLJgL4+sAkGuiQSXjQcnxV6MNAjps2Rt2vM6jy8oCtm7RNBxxthw4IBNXgg3ldIIe3r1ek66AEw0Dh/lfT/4TjcIo6N7JVrpk=
Received: from BYAPR15MB3029.namprd15.prod.outlook.com (20.178.238.208) by
 BYAPR15MB3287.namprd15.prod.outlook.com (20.179.57.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Mon, 10 Feb 2020 18:53:20 +0000
Received: from BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d]) by BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d%3]) with mapi id 15.20.2707.028; Mon, 10 Feb 2020
 18:53:20 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Kim Phillips <kim.phillips@amd.com>
CC:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/3 v2] perf stat: don't report a null stalled cycles per
 insn metric
Thread-Topic: [PATCH 1/3 v2] perf stat: don't report a null stalled cycles per
 insn metric
Thread-Index: AQHV3gtC4rVViboGVU++YBPq+UJJxqgUyqIA
Date:   Mon, 10 Feb 2020 18:53:20 +0000
Message-ID: <D2E25104-C81C-4DF5-B781-E3F839AD3836@fb.com>
References: <20200207230613.26709-1-kim.phillips@amd.com>
In-Reply-To: <20200207230613.26709-1-kim.phillips@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.40.2.2.4)
x-originating-ip: [2620:10d:c090:200::6281]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4365550d-43bd-416e-69d3-08d7ae5a7fa3
x-ms-traffictypediagnostic: BYAPR15MB3287:
x-microsoft-antispam-prvs: <BYAPR15MB3287C9BA9FBA0D24021EAD80B3190@BYAPR15MB3287.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03094A4065
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(376002)(346002)(136003)(189003)(199004)(33656002)(316002)(36756003)(71200400001)(8936002)(4326008)(81156014)(86362001)(186003)(6486002)(81166006)(2616005)(6916009)(53546011)(6506007)(8676002)(5660300002)(2906002)(478600001)(66556008)(66446008)(91956017)(64756008)(66476007)(76116006)(66946007)(6512007)(54906003)(7416002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3287;H:BYAPR15MB3029.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vP4Ek8FV3Y67/PQDt7WvpFb9T4KtcvGgihug5BTcfY0+dhY1oUyd2D/WJMK/fyqLlZxc5RTgURxJBIig486rgKHNb6Szq3osUgJTXyByjKxAoPzT9zuE0y5TPfjBgASsK3oMQNxApXDtdfltiLCCbTs+2gfpFTbK7Q76fy8v25BhRY1MNZRMulNUikpN2IXZrwMVyY6mdNA5HhfioIrYSHK4O2+xkS+lvBFiDirFIRvmElr6VYmStoQgDtKcKeRPqORbdnRMYC4krXWF64hbpGevdFtpepHxQ06MrsloDF/usF7+aC0DPXbUVBraXonbgywkSb4KcG0d3FgIpKspTZ91B5MwiES/GMfWoYQd/khztGtwBp1DmPJwv7ZjtOk7dDG1p/xF3epcEIoksZp9Q41FEVIO1ZH859vxT2gXP2RlMkgfXk3iPBSNIsIacuOi
x-ms-exchange-antispam-messagedata: pGao/OU70/rjd+mHtwEGugkPeAM22CKbpQ0n4q63ObLHoITlW24olyWC0T2e6XppoQ35JGmXzT+8dKTEul8VZcEY1XGbNA/7To60bjrJpcLUnNzVNSphA6oukQj3j8YsrndqUIyOBO+LAQKTwV2fo/yV4XCvuwMgRQoTwvP7qiw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A460C3E55A7C0F46AE87A9BCB62DA9A3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4365550d-43bd-416e-69d3-08d7ae5a7fa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2020 18:53:20.6730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LDXo8CR7a6j1/X6ycVObkxDozTnqm3+MpmPHB8RkBwCCv57fulw+yd8ABCEkys7MuT1rIutHG/PQWSLXLR+byQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3287
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-10_06:2020-02-10,2020-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100138
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 7, 2020, at 3:06 PM, Kim Phillips <kim.phillips@amd.com> wrote:
>=20
> For data collected on machines with front end stalled cycles supported,
> such as found on modern AMD CPU families, commit 146540fb545b ("perf
> stat: Always separate stalled cycles per insn") introduces a new line
> in CSV output with a leading comma that upsets some automated scripts.
> Scripts have to use "-e ex_ret_instr" to work around this issue, after
> upgrading to a version of perf with that commit.
>=20
> We could add "if (have_frontend_stalled && !config->csv_sep)"
> to the not (total && avg) else clause, to emphasize that CSV users
> are usually scripts, and are written to do only what is needed, i.e.,
> they wouldn't typically invoke "perf stat" without specifying an
> explicit event list.
>=20
> But - let alone CSV output - why should users now tolerate a constant
> 0-reporting extra line in regular terminal output?:
>=20
> BEFORE:
>=20
> $ sudo perf stat --all-cpus -einstructions,cycles -- sleep 1
>=20
> Performance counter stats for 'system wide':
>=20
>       181,110,981      instructions              #    0.58  insn per cycl=
e
>                                                  #    0.00  stalled cycle=
s per insn
>       309,876,469      cycles
>=20
>       1.002202582 seconds time elapsed
>=20
> The user would not like to see the now permanent
> "0.00  stalled cycles per insn" line fixture, as it gives
> no useful information.
>=20
> So this patch removes the printing of the zeroed stalled cycles
> line altogether, almost reverting the very original commit fb4605ba47e7
> ("perf stat: Check for frontend stalled for metrics"), which seems
> like it was written to normalize --metric-only column output
> of common Intel machines at the time: modern Intel machines
> have ceased to support the genericised frontend stalled metrics AFAICT.
>=20
> AFTER:
>=20
> $ sudo perf stat --all-cpus -einstructions,cycles -- sleep 1
>=20
> Performance counter stats for 'system wide':
>=20
>       244,071,432      instructions              #    0.69  insn per cycl=
e
>       355,353,490      cycles
>=20
>       1.001862516 seconds time elapsed
>=20
> Output behaviour when stalled cycles is indeed measured is not affected
> (BEFORE =3D=3D AFTER):
>=20
> $ sudo perf stat --all-cpus -einstructions,cycles,stalled-cycles-frontend=
 -- sleep 1
>=20
> Performance counter stats for 'system wide':
>=20
>       247,227,799      instructions              #    0.63  insn per cycl=
e
>                                                  #    0.26  stalled cycle=
s per insn
>       394,745,636      cycles
>        63,194,485      stalled-cycles-frontend   #   16.01% frontend cycl=
es idle
>=20
>       1.002079770 seconds time elapsed
>=20
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Jin Yao <yao.jin@linux.intel.com>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Kim Phillips <kim.phillips@amd.com>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> Acked-by: Andi Kleen <ak@linux.intel.com>
> Fixes: 146540fb545b ("perf stat: Always separate stalled cycles per insn"=
)
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>

Acked-by: Song Liu <songliubraving@fb.com>

Thanks for improving perf on AMD systems! =
