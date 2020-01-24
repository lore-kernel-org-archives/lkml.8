Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A598C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 21:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313B92077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 21:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qhFS6Ovf";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="a77kMqQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgAXV3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 16:29:41 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:13292 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725747AbgAXV3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 16:29:41 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00OLN9FU001077;
        Fri, 24 Jan 2020 13:28:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=C3iDzxcgnls7Q5rOfp3pyAvSEkMw5YNp5/FIEGjr3+M=;
 b=qhFS6Ovf841vp1ONtzywkH0fTvdgpZ7LdX/JWcU6nRUDUP8tihrnmAtiq3U7BjxEjN2L
 k0zeGFVhvoIDIttDy2rsM5ZyQVwH9FtBBDlIkwQiJDFoENrdV22HkeihA5Xu+LlvHFPV
 V+MiY9bsOLsjcRmjFXDZNuV7wr1QhYY72jg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xr63brq0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 24 Jan 2020 13:28:28 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 24 Jan 2020 13:28:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+nAu2HLsEvtz5u32cWAyZs3W8EjVPLEa/nGcdfUKXnfxuI/8LOt++hkgv1hm6wCbPDJbdpDQSBRzHn9kNURLxMf+gi6ZNQPqLw7I/ez8dI/z+SY4moWR+6NWxOjOKZyCAp+0AyYgaOp6lEUnz5KW3XPr6yMu1fKUOtdxijsAxR2+PrSMvFPN8HyaSOa2yjAXwKw5vsa2eVwK3xSAsUNJC0FWRmQ/VC3n+aS0sILK4WqkVtWAig4rJxJnp0YUpXaYpgoZj32FurvqH3BGvz4O3grYogAyJihkAwpDrO+V2fmSj8w59tUseAHoizDDqJ9nQbxYuxkkDtcrJ6dww0kpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3iDzxcgnls7Q5rOfp3pyAvSEkMw5YNp5/FIEGjr3+M=;
 b=Q7jCAvT2LMMprtsBwsg3FWR09Q29xAlahHg22zdS2Cv+zzmN2O/PTJsH49XDG8lrU8FM0vKuWWOAF64QBUGzwR7cGuWEHNZ5j7Qgjdp1Y2WnKLMZJpCeue3fLu/wLf3fYrxmYtu7DJDVVtH08h7IHguRJxXcErPKE23pR0ZKI6hITZMq1RzVb5nSlwI90IoJVJz+XHMrruEFhiweIHqEnBt2/gXQQAWfkP++UXYmlfqzklxM8JK86KATUf2ORrxqsn/4AKHEpSHQiqlhVqYQVXypoTugjedd17tfRqxtAEEOxRRhf8w8gtbiOIkNozX7B7MAwZLPktrmmFKmNe/3UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3iDzxcgnls7Q5rOfp3pyAvSEkMw5YNp5/FIEGjr3+M=;
 b=a77kMqQ+zpkiWDVj++YD3juTpHnUyJrwW/Vd5ENW9FwwEMT/R8k8qb+BgSSrjedyRgkHQd692Jfy+n3rgYwGWA0bfCyTIrG6IGCaIHm7wV4PkCy1hJO4datTag36jzBcU/0NnTFXYTzGe2C/+EKih41gB9DKoK2A1DgNpNxOIHE=
Received: from BYAPR15MB3029.namprd15.prod.outlook.com (20.178.238.208) by
 BYAPR15MB2823.namprd15.prod.outlook.com (20.179.158.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Fri, 24 Jan 2020 21:28:26 +0000
Received: from BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d]) by BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d%3]) with mapi id 15.20.2665.017; Fri, 24 Jan 2020
 21:28:26 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] perf/core: fix mlock accounting in perf_mmap()
Thread-Topic: [PATCH v3] perf/core: fix mlock accounting in perf_mmap()
Thread-Index: AQHV0hibb+4nJKVWcEm/RwrBoFjiL6f5jF2AgADJ1IA=
Date:   Fri, 24 Jan 2020 21:28:26 +0000
Message-ID: <0E502E71-B1A8-493B-BD9F-24F15BEDA1D6@fb.com>
References: <20200123181146.2238074-1-songliubraving@fb.com>
 <87zhed9pek.fsf@ashishki-desk.ger.corp.intel.com>
In-Reply-To: <87zhed9pek.fsf@ashishki-desk.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.40.2.2.4)
x-originating-ip: [2620:10d:c090:200::3:f503]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d720a4a5-a2b9-43d3-0204-08d7a114591a
x-ms-traffictypediagnostic: BYAPR15MB2823:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB28239C203CC862D952149D09B30E0@BYAPR15MB2823.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02929ECF07
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(366004)(396003)(136003)(189003)(199004)(4326008)(2906002)(36756003)(5660300002)(8676002)(316002)(8936002)(81156014)(86362001)(81166006)(54906003)(2616005)(66446008)(64756008)(66476007)(91956017)(15650500001)(66946007)(71200400001)(6916009)(76116006)(478600001)(33656002)(6506007)(53546011)(6486002)(186003)(6512007)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2823;H:BYAPR15MB3029.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uoMcJACfjQu98upHoCzTCfvgbIydgNGHIxlA6YruCSPNaD+9tpRz0qhN6CVR6Fgvbj/kMwwaF2ANh9EtybAFBsvbyDe03JFmqgpwnvE5B9ZBpIvrJlvdRE7uDfjBzgQ7a4eIdlzEGSyACJ5r8En3kxSPoE00uIVq734tLTLGT+o7f31GTz8ViHLzd30b8mft+s9bTRx1w3xZcGlZG5Vpwwgisc4xEXQqELCmK8JlDvO/eZkWbblQ+9xPaZi/0ycLqAqmQfbSmmLck2Q4awuqqlCOWZOsdF0MnP1OarsGFy52g+djwQ/dCX1vTSjEh214Nv8JVMlFBZA7k0YMiFkIdrvCk27RA5Xz1Sn+ndGsvU6TFbqDs7cJJNG2xR9Bv6C2govhX0OgLxK7/7JWuJ/h3GBv8HJlntaYTNUOzBHxuwOmZ3DlK8s3+Uf+ZHOndGmB
x-ms-exchange-antispam-messagedata: scfmjMXakIJLMOm02QMB6eIJt9cdCfz7HkgWUEFnofs9s5WfvSUDApKzkNTvQGZ5i5xa6HK6BMCRFiHeFu1+3xK8H9JlZgUtgRa1GMRT/ltLe/YIExjdE9HU9v5Ur4068lqq4MevJE9toO2ZY1Qg3ad8/3q1UVRy0GhKJtOj7kwtge/NBt/31VRKnTXmXsRW
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E003F42E1A1CDF42AC142C209BAF5698@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d720a4a5-a2b9-43d3-0204-08d7a114591a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2020 21:28:26.0430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fPOeMS5q1C69SuRSiIM1aHoa82y01cej/H0TZn77gw5zblW3Vas6n9jU0TAv40O8HwuWT3pcPUcUAQUYx9XCOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2823
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-24_07:2020-01-24,2020-01-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001240175
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Alex!

> On Jan 24, 2020, at 1:25 AM, Alexander Shishkin <alexander.shishkin@linux=
.intel.com> wrote:
>=20
> Song Liu <songliubraving@fb.com> writes:
>=20
>> Eecreasing sysctl_perf_event_mlock between two consecutive perf_mmap()s =
of
>=20
> Typo: "Decreasing".

Peter, could you please fix this typo when you apply the patch? I guess
it is not necessary to spam the list with a v4 just for this typo.=20

Thanks,
Song

>=20
>> a perf ring buffer may lead to an integer underflow in locked memory
>> accounting. This may lead to the undesired behaviors, such as failures i=
n
>> BPF map creation.
>>=20
>> Address this by adjusting the accounting logic to take into account the
>> possibility that the amount of already locked memory may exceed the
>> current limit.
>>=20
>> Fixes: c4b75479741c ("perf/core: Make the mlock accounting simple again"=
)
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> Suggested-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
>> Cc: Jiri Olsa <jolsa@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>=20
> Other than that,
>=20
> Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>=20
> Thanks,
> --
> Alex

