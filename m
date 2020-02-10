Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09818C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7611214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="hRh9+R/s";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="We9LjQJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbgBJSw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:52:26 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:3268 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727052AbgBJSwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:52:25 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01AIpS2J020767;
        Mon, 10 Feb 2020 10:51:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=HBFx7mfH1GQS9WP1SC3HHvazWLnkdh96BMFE8giTXDA=;
 b=hRh9+R/slCEa2EBJhoCFc8zHU4ideeOHnUqEeIKsHRRVje9XPN4WGenho40lzeGIx7Kt
 ALpV6g9fQ5GYQWE0XcMoB6OEsue8Sw4whlcztAluKrZst0fPdTgFfcm4bjxcUA/n1KlN
 X4k+At9PJMTofMvtazXEWKtusSp7qA77XzY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2y2dmwp5vc-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 10 Feb 2020 10:51:57 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 10 Feb 2020 10:51:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLQAoh7LysVWWq85LJNs/g/373ocI2Jw74c+mJZWZta9LVNyiN5WWu+Hw7R3w/aPJijvHRIqiKRja2n6wKLF6fx9/pYVclxle6iE8tHLqx8eAYXYSjfWPDVfvsVw32nxT3dVshvWZeAJd9HjHZt63owitQj/y0iIbFUYwDpLMzs5viL7dOl96C1DpZB7NufX0QJhBw9TH2mvz9A0VzLOdBbK5ppHZ+9SEO7w33Bf00KGm7MkcbfFJpfsH71bHRhDwR4lN4THjSzKZXLuwcctEcBuGxQQnXrPDIvyo6BbMDRZieaYeIIPQ1HZJuweyL4ID4CzE898Ltv9MEzu0220Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBFx7mfH1GQS9WP1SC3HHvazWLnkdh96BMFE8giTXDA=;
 b=lZd7vbWT4wlbRULrA0rkdwuVLssaXj97k2j6CJKBbPwpLOUDn9LEoV4tAxDyA21m4pYXvNLhNcSrTbwyi5+jCpqMuO67Pe4amCs+4NW9zQiX31dNhrL0NN53srttOTzHlCgcBgoZwOUv2akdblJxqQDucNiAgHMPNgN/AZ8x941NKsKdZaiZoVEN5IaAuu2sDC496sQ2ytKRWr5D2BRu88u4fz5owqPdzLkojHY3WuC4jH8yL5rGM/Ny0Vrr4s5pX1XTE0OmDUe4fay/uoz9DT3VsnYM38yquQBWrUV946UFRHNL9BwcJyhu8Cbqu5uEfjkZj1VCSQw3mJY9xpKfQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBFx7mfH1GQS9WP1SC3HHvazWLnkdh96BMFE8giTXDA=;
 b=We9LjQJ2ct48hDSdK2BIbZmVg06/grb6VSto9HndwjdDQLOC9ueXyscMMN25u6HMAhJ/3eIZx9YeJPBJuoOQ5uRsRA/kmfsg3A3FyA1ZZVIbkMqbF1crK5uFjv6PyzHzCviJKOUHXDDii2td4ViwYhrVx9/9/3ePvJSD70dL+BY=
Received: from BYAPR15MB3029.namprd15.prod.outlook.com (20.178.238.208) by
 BYAPR15MB2485.namprd15.prod.outlook.com (52.135.194.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.25; Mon, 10 Feb 2020 18:51:54 +0000
Received: from BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d]) by BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d%3]) with mapi id 15.20.2707.028; Mon, 10 Feb 2020
 18:51:54 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Kim Phillips <kim.phillips@amd.com>
CC:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3 v2] perf symbols: convert symbol__is_idle to use
 strlist
Thread-Topic: [PATCH 3/3 v2] perf symbols: convert symbol__is_idle to use
 strlist
Thread-Index: AQHV4C+ryuc5a9gsUEGZKHquvhKhr6gUxfKA
Date:   Mon, 10 Feb 2020 18:51:53 +0000
Message-ID: <4F6B8692-B1FE-4108-A6B3-44EEE5F92C97@fb.com>
References: <20200207230613.26709-1-kim.phillips@amd.com>
 <20200210163147.25358-1-kim.phillips@amd.com>
In-Reply-To: <20200210163147.25358-1-kim.phillips@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.40.2.2.4)
x-originating-ip: [2620:10d:c090:200::6281]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b4c69a8-d5cb-4d1e-36bc-08d7ae5a4bec
x-ms-traffictypediagnostic: BYAPR15MB2485:
x-microsoft-antispam-prvs: <BYAPR15MB24853626AA61FAE2BF6D98FDB3190@BYAPR15MB2485.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 03094A4065
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(346002)(376002)(136003)(189003)(199004)(966005)(5660300002)(2906002)(6486002)(7416002)(8676002)(316002)(81166006)(81156014)(8936002)(6512007)(478600001)(86362001)(186003)(53546011)(6506007)(4326008)(54906003)(36756003)(6916009)(33656002)(71200400001)(66446008)(66556008)(76116006)(66476007)(2616005)(66946007)(64756008)(101420200001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2485;H:BYAPR15MB3029.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X2f4ppGHprq7F0xhA2hq+AETIQkavHXL057mM0/QyBbyf4iFTtWbj52AwdVbChIrmUXawmclbqYYJ+KZgXyW8yPoroZ7eKJ43146/VfZ5GfFYJsGBiQdPCN3DgKCaPDT96k82TwL0B1rSjmbW11njA8nxPSfYAg50VT7RcoG8g/t5d0AfLJdzJl28EYLvv9/L8MWEzoiUZbw/x1mN3anESNF3eHc/oKebpP+Tr1dzLuxy9ioGcBc5mR7q6sW07bDEv++H0k2zAPThWwPaZ+Y3Si/rO2jJY958WjPmhIZUq2BRYtmqDVJbk9+/Y3akutNNb/OAe5h7eG32ZLtD01t1OmNZ9tyHT+uNUR4M+WdJYVUa4soUcPaKDXPLC4P0zxDeNRLMa1LiD1Ekynd0Fw/UAOF0Ayx9V1TzQwieFdO1lp18oAencSRYqDL8sc9UrDF6tW91xWPfZ8NQ0cXlPxwZHkTqVmsslx2B/yQ2soAiIgw/6R86MjfYkP1JN8zklX0tew7WfUYMkzANQEt7KNBpXtsClHOftv8oiXBL5++SKsqUohasjbiWIcm0xpgeccltfR49s4ee3l+121yXAQ+BA==
x-ms-exchange-antispam-messagedata: UUP+tBqKk5ND4A3QnaL7wh5iWd7yVZUmdkq4O/qriA5bmIK7UINrPOKER7mcfYrsCE6goZan5+A3U3MSxJyYWc63jv2pRsbklb3Xo+CXcakd0lP69Nwr7HkXIElpKqTA7PfKGZRq/m9+9msCIics4oTp2D1Lzv5/0zUdqTelZNU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9303694C772D11479344C0DA2D0FDDE9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4c69a8-d5cb-4d1e-36bc-08d7ae5a4bec
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2020 18:51:53.8297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dR+4aSbmBjubxEqLQUHPQIxK9nUAlfIPWUoeOF8MFi5pqvLoUfem121BrReQUlmzQaAFFy7lQFJGjKUL0Em7BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2485
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-10_06:2020-02-10,2020-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 clxscore=1011 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100138
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 10, 2020, at 8:31 AM, Kim Phillips <kim.phillips@amd.com> wrote:
>=20
> Use the more optimized strlist implementation to do the idle function
> lookup.
>=20
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Jin Yao <yao.jin@linux.intel.com>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Kim Phillips <kim.phillips@amd.com>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> ---
> v2: new this series, based on Jiri's comment:
>=20
> https://lore.kernel.org/lkml/20200120092844.GC608405@krava/
>=20
> ...and this time with the Cc list intact.
>=20
> tools/perf/util/symbol.c | 14 +++++++++-----
> 1 file changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index f3120c4f47ad..1077013d8ce2 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -654,13 +654,17 @@ static bool symbol__is_idle(const char *name)
> 		NULL
> 	};
> 	int i;
> +	static struct strlist *idle_symbols_list;

nit, probably just personal preference:

Maybe move idle_symbols_list out of the function and add the logic=20
to symbol__init()?

Other than this:

Acked-by: Song Liu <songliubraving@fb.com>

>=20
> -	for (i =3D 0; idle_symbols[i]; i++) {
> -		if (!strcmp(idle_symbols[i], name))
> -			return true;
> -	}
> +	if (idle_symbols_list)
> +		return strlist__has_entry(idle_symbols_list, name);
>=20
> -	return false;
> +	idle_symbols_list =3D strlist__new(NULL, NULL);
> +
> +	for (i =3D 0; idle_symbols[i]; i++)
> +		strlist__add(idle_symbols_list, idle_symbols[i]);
> +
> +	return strlist__has_entry(idle_symbols_list, name);
> }
>=20
> static int map__process_kallsym_symbol(void *arg, const char *name,
> --=20
> 2.25.0
>=20

