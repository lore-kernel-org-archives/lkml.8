Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD6EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C00F1207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="gl70EDnX";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="DPoRfyWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgHSPjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:39:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51266 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726887AbgHSPje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 11:39:34 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07JFV8ic012816;
        Wed, 19 Aug 2020 08:38:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=W8JyWnNa9962r0brFiR3N7Z5pK214GSI6DV1viwAYeE=;
 b=gl70EDnX9t7DetVZbWEGFwrvBmPBH20NxMys6d1phGCADtW7ruN3tFH96N3TE0FjN2zB
 TDgzp8RdHdiZVGrJtCZP1RC2Chq0/tIRULjD9nfi9jdr2323T19r4EYEtu3nWGjYG39v
 2fANGGZv3p+Kq9ZlUXxsMMUIQsup4/MYbPg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3304p3h4bm-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 19 Aug 2020 08:38:35 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 19 Aug 2020 08:38:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFfEj80buTguk7NWDlMIhw0wQiPU/cJfl4wrU30Z7NQrfcJe0dX+JggtZ/w6rGe4eAKTTSkL0g9inrEJ5/WKfWc7utZBsG+wjm5Cwf/J+UbY/M8GpRilpVVNUeTqTs4xgT1tQygre8uWGfdmuzOgME6qxgSmpivJUyVGVPp2O5n3wfDoZlKj9jQ7JSqWGHkcGaHQWE7Imkz+WwP97yK+B5NSMGYLb7BQz6YEFp3OYZM5UW3QaBbyLN3x5J9R06xjOUr8ne96YfcxBVjSALLMT1dAql/G7g0QbLUGw3eMf2Cg4wOF39Z2qVWtBiK4wrvboE2YqGBU+gzuuA+79GA3cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8JyWnNa9962r0brFiR3N7Z5pK214GSI6DV1viwAYeE=;
 b=ghdbHYVI/IzXHngEbdZ8OINw4hBXEjoNkG94uYZnJskPadVtVSiXrGnn7FTptZk8a7QcoHMzzxTCauLSHEsa7UlT+IU+P4bo/lFIHM5MxVcWG4udJGl0KQqkCVln/Q2KSKNF0X2Pkr+PT4oyyNTs9CRxxNlgn8Hqapxqsof62gGlR8AY/iJT8nU95MLMS4/zXOBRr6y4Uj7SmcsVBYs+Tkmjsir5mHC82m3kiGUf55oHXewlDcsWWGFwwM1yZl6BrhVFLmYteD4RXmHy6fKYn/5uHYzs84m8BDwzf0YRMWtc+hORlTGu/YmoQL6cEk2vdIWdl7dR3kuQcjG/fRYYxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8JyWnNa9962r0brFiR3N7Z5pK214GSI6DV1viwAYeE=;
 b=DPoRfyWzzXAEsx8tLw282+BtboMOnmPxX8ZiOxQy0M7YPqe0qV94yDmpSwgDct9fMz42n9z4Af03dFSBWN1Cyoz8WenMaO+Zt+sfzZtM/k1GtujveL31KQdncuKOW3CvC0rdv5rOzqWGEI21hUeX74zNSCkRNFNm5I5l90C/UsI=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BY5PR15MB3665.namprd15.prod.outlook.com (2603:10b6:a03:1f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Wed, 19 Aug
 2020 15:38:31 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::119c:968d:fb22:66e]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::119c:968d:fb22:66e%4]) with mapi id 15.20.3283.020; Wed, 19 Aug 2020
 15:38:31 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Wei Li <liwei391@huawei.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "huawei.libin@huawei.com" <huawei.libin@huawei.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf record: Correct the help info of option
 "--no-bpf-event"
Thread-Topic: [PATCH] perf record: Correct the help info of option
 "--no-bpf-event"
Thread-Index: AQHWdde6ERx1KvYqZ0qqpeKxpiFINKk/keEA
Date:   Wed, 19 Aug 2020 15:38:30 +0000
Message-ID: <C77EA4D3-4AC9-4CED-8995-CA99285198BA@fb.com>
References: <20200819031947.12115-1-liwei391@huawei.com>
In-Reply-To: <20200819031947.12115-1-liwei391@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.80.23.2.2)
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:91bd]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bd1038e-fb4f-436e-91a5-08d84455ecea
x-ms-traffictypediagnostic: BY5PR15MB3665:
x-microsoft-antispam-prvs: <BY5PR15MB366551DC05AF8B1856AF2A77B35D0@BY5PR15MB3665.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jrxy+mpzxiChnOdvT7ZtqjGhhWtE2HQEevX+5sICW8urennQoe3fcyGDhsOLxCVTILQ6z4/O+d0wsXH/k0W/rNv/BXkETPUBum732nTWEVMoDa5+ht6VuNLN8wWBM5IguqM4Z39+tqQC+/qvIvWK/KmKSTtmvrukXHEAEkAaW21CE7Qesv8Mel1T1RsC3sRrh8eHpbSGdLRS3b3LxYcajuOIPcZgCDP9sKcaoUBXeMhsLRMBvrE/pGcE/84/jw1Ogpw73fE7S9Fm40an+9jtEMYUIMpOUSqUyh9bmirQyqvj/ueCjSZXpVVLC+WELgOB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(5660300002)(6486002)(8936002)(66476007)(6512007)(66556008)(66946007)(558084003)(76116006)(53546011)(4326008)(64756008)(66446008)(6506007)(186003)(2906002)(8676002)(86362001)(498600001)(54906003)(33656002)(36756003)(71200400001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: MyaGIicjMbL76zhdLWhnz+L3RlIU15sWEICVxetpVyGdTh9MRPozJFL6hJxk9+2lIBG0+jXBtEctXaAJt+xqeGefNqIBWQczOKiAS6kZnhSxP36FIlUMhvUDog0Ut9b4op4JMf3GhkZrKv1w5+NFyFw9cOH2rx9kXic2B55dNYFaRq29mh4E7wlJQT0F6d16fgtJ0Bgdb9SJHgk1H6oa6jmJWLDc6GtU8TjVlcGfSQqnjZtRNdQ+/9K6DnS2gAxPVF7kxI8wlroO6FzRlGCl1Uc3l4TMnAxbdpdkB/txZaohtZC3gRIHoHUG0LSCjjLi+W5swxJxAVuqQXDu4QCY+bOKD0erDocUqrmK2m3Aj4ln7pRsXOpAuh00NMQXQNBcEWSatxgvn4C4UFPlyu9zW66J3NbizdaLQQkzOb0d2wvp2re12dzfr4KmOWSsg9pjlFWl7aK/bVaJnqGw3aMl0eFBh2Nxu5FgV1qZJPwLsZYTvq9vIozP0UT1thziXLI+qtO8wYScIVYdVijeSLMbZEU0HhiGBVnlKX+hm9t+W9PRe7Y1YDV6rYlsofMDDlVSTBIGh55ftARnFVe/HL2tIWmAYiBo9GMXuHLokmgsyhDOawJMi+msiSI2r/8u5IvSu/foZLKt2eJ5BY4D/wB5vk3P+/Mqdlz8/+L+R03Qkh+KIvarPihpYlntPGbuVMnj
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0FBFFE7022A921409DCD33971898CD18@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd1038e-fb4f-436e-91a5-08d84455ecea
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2020 15:38:30.8561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nOTKxbmndpgcON8YbXMMOPOorMziya84lQNSTkEgB1nUJyyj4tY4ZMxM+eBgPJJuHps708skRzg/fIvWvImo/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3665
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-19_09:2020-08-19,2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=940
 spamscore=0 mlxscore=0 clxscore=1011 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008190133
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 18, 2020, at 8:19 PM, Wei Li <liwei391@huawei.com> wrote:
>=20
> The help info of option "--no-bpf-event" is wrongly described as
> "record bpf events", correct it.
>=20
> Fixes: 71184c6ab7e6 ("perf record: Replace option --bpf-event with --no-b=
pf-event")
> Signed-off-by: Wei Li <liwei391@huawei.com>

Thanks for the fix!

Acked-by: Song Liu <songliubraving@fb.com>


