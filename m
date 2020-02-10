Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBEDC35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89602085B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="KI8NQIRX";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="JBnrs1qX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgBJSxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:53:39 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:17552 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726991AbgBJSxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:53:38 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 01AIZYDe005271;
        Mon, 10 Feb 2020 10:52:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=jOzHjZSNYfUX+qChiPwoFqMPOXgtOqIStR+HioRkBM4=;
 b=KI8NQIRX/+KMnmUR+xfnxm3IxngPn0ZPodInRAOOWKPg7b+1DOjToKUc+AA8/FcndN3o
 Eomodnh2sh/a1ahZIctQZKHcRAtNEAv6XXsAB4R486G5sfPHu3gMd3yXyg0ZVNiGHuxs
 3TDCpi6BAVSF7DqioktApZFmV9FudwZdsyY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2y2ftep05d-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 10 Feb 2020 10:52:23 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 10 Feb 2020 10:52:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZx6tqCmYJdOB94coix87OhDxN0TxG6hCy7NAliOxmBSZtdgUMP0RtJ/Xv2Hn7D6ZzH8w2Q2+0d/qsn3JB97jLooEiXGHBRMRCUK9waXeMIMK1OPWi+ZfLfbCUFLAT0clJDCeYpUOBXDwpAFkmpbrNKbexANNwsW7SeCvkweeEhKESah5eS/cPGx66euOx2S7NbuLkOkmj9D9yi9wCbBwscvOzNsHvN21Wu1634iwhee649IzXwpgamBe2KtURJv93W1iXdAkSDzACbAebF/CxUxt85FLJCtw3tyIUkJvFfrw6HFDCboiSID7XbBzffLPa2V+dmK6liNje4nLNWufg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOzHjZSNYfUX+qChiPwoFqMPOXgtOqIStR+HioRkBM4=;
 b=jM5Qjb/OwRW1Md7ZbCH3Qs1qs6YC6BDiNaPEvLsu+h2OyzfXTnwbJzPjci83T4hVrl1lsqlPmaNFPhj9IHASNyI+ShpNbka52gDBGrGBof9T285vuYsaG12lAVXAKkDf2bSTAd5DOCAUdGiDJb31Y2Gj58j1v6nlxO/ye8jqeJMt9Jx+xGnLXlpuwVvexOVrJwSekM3e9uTofvaDWdIcLH3A9btxkQJuAf7ctyCgDpCC5B58OTXEULQU+jwhqiAzYmH2qIJznBm8rT44MrBbo6+nhfdF8BgqTUrcmR/2+QgBwtXTrT/ioyVaBWy0uknzJBhWpSqkY/inMgQ4DD7NxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOzHjZSNYfUX+qChiPwoFqMPOXgtOqIStR+HioRkBM4=;
 b=JBnrs1qXPbeccnTpZPnSA5vzUTncpYXOFBcbBmsG5Y3HRfbDhuGiLG5vdchwZoWHkttE2JZLAfzrFufIpmxJ18KNRIZc5Z4XSEVH6bECnfhAP9ubzMU1kkN5NrsOT73DUjUklwYWBGh3JwGDqQibclVBGUEzE50wddveYtMAsz0=
Received: from BYAPR15MB3029.namprd15.prod.outlook.com (20.178.238.208) by
 BYAPR15MB2485.namprd15.prod.outlook.com (52.135.194.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.25; Mon, 10 Feb 2020 18:52:18 +0000
Received: from BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d]) by BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d%3]) with mapi id 15.20.2707.028; Mon, 10 Feb 2020
 18:52:17 +0000
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
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 2/3 v2] perf symbols: Update the list of kernel idle
 symbols
Thread-Topic: [PATCH 2/3 v2] perf symbols: Update the list of kernel idle
 symbols
Thread-Index: AQHV3gtQ30a2WiQpFEWvpind6FUCXagUyleA
Date:   Mon, 10 Feb 2020 18:52:17 +0000
Message-ID: <A3A96AB6-C21C-4F3D-A69C-C968D43195B2@fb.com>
References: <20200207230613.26709-1-kim.phillips@amd.com>
 <20200207230613.26709-2-kim.phillips@amd.com>
In-Reply-To: <20200207230613.26709-2-kim.phillips@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.40.2.2.4)
x-originating-ip: [2620:10d:c090:200::6281]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3baa7e84-b04f-44a3-3841-08d7ae5a5a28
x-ms-traffictypediagnostic: BYAPR15MB2485:
x-microsoft-antispam-prvs: <BYAPR15MB248591FCF463BD856A075C66B3190@BYAPR15MB2485.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 03094A4065
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(346002)(376002)(136003)(189003)(199004)(5660300002)(2906002)(6486002)(7416002)(8676002)(316002)(81166006)(81156014)(8936002)(4744005)(6512007)(478600001)(86362001)(186003)(53546011)(6506007)(4326008)(54906003)(36756003)(6916009)(33656002)(71200400001)(66446008)(91956017)(66556008)(76116006)(66476007)(2616005)(66946007)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2485;H:BYAPR15MB3029.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dCksaMBr9CjfaKOpM9k55oi58S9O4K/ealjXRY5ML/HZgmeR7RQRuNCXUB7vU5gnFaZXZP/x/g9d+GR7iAkT7oGHp5oaXlFyCkyLyHj3opOdJoKcc5Lwdh285UgcvoWi5fAr0T1+I5kR4OdO14ysfPCGFQkgm52MVHojWku2iNvjPdhMyjicgPEhr4IKO3/hWpbZoGAsuh+CEQny+C7n9S+9gHeIoOVycl9zbGpFXFW2IL+/NC3H/zPhnu5cyPSKlkbTHefMUoWZhKYxc7GKLd+M1BRiJtswcYkQgn/HP2iVDXJLJoW3Z8z5UYBk4dZ9QWZmWxCZxLwYBAxZ/hVIF7JLlCUFXN97y2fCh63C7VidgPbvWNnuQa09X8w8kVOu+IhftwNc4kvkyZnwAJgUEy+UpcUZth2BSMwnCQA7IecXxOheOKXvY2BkrfQjgiaV
x-ms-exchange-antispam-messagedata: 3AT+Ras0Z0pLeO6ExP0yNm0/lYT+bKNbaBi/SHLOuTQAeIq1pRBhhfqm44ugdPAUxX2c7/nYzdmdl9JX/JoIdeRLaJp0U4zKedtvIr1cQZUZP4rtYZGsKHOaLbzAJm/ClABEM9kqM1sGhLLB+8PJf2nt/OAHur/hURYbFdBXxOI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <49F800BADE5E8540B8ECEE84645D77FF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3baa7e84-b04f-44a3-3841-08d7ae5a5a28
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2020 18:52:17.8060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2RCp8okDfsmV7pyp2RrBcB5vcYiN8TL87e+8VeuMb9DAPsEg8OpuSWZVYaY0yD0c89vBKENF0be80Qukz5nkvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2485
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-10_06:2020-02-10,2020-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002100137
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 7, 2020, at 3:06 PM, Kim Phillips <kim.phillips@amd.com> wrote:
>=20
> "acpi_idle_do_entry", "acpi_processor_ffh_cstate_enter", and "idle_cpu"
> appear in 'perf top' output, at least on AMD systems.
>=20
> Add them to perf's idle_symbols list, so they don't dominate 'perf top'
> output.
>=20
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Jin Yao <yao.jin@linux.intel.com>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Kim Phillips <kim.phillips@amd.com>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>

Acked-by: Song Liu <songliubraving@fb.com>

