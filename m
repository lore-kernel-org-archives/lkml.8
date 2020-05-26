Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80229C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FEB02065F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nBvzZEsw";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="H7kvE2wq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgEZVrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 17:47:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11556 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726858AbgEZVrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 17:47:12 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04QLigjW023394;
        Tue, 26 May 2020 14:46:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=iiWfQmXu+hxcEQnazz+z2SUsUgrXQlH4aNasvgMy8d4=;
 b=nBvzZEswJg50NCu9h6p0XyrlSxm5GuRg4KOBvZPh+qLSzEv3cbWd8RU4JxU9feMkZ4Yd
 yltjYOZ2FbgpKOQZCOcY1rEDEXtDF24Yiu8avU/eCKZJYHYQh+5+9xEP+GoFZiRb6W2q
 cWrDL+834j+2Mysk4VxR+lxKJfvRmYD9emw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3171nhmy7a-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 26 May 2020 14:46:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 26 May 2020 14:46:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6oT563KZVH1zbfDKfdsg3kVb/zDFR8A27QixPdcxnD2GvfD3kAbHcWz6tMoXqhpjlf4oj/uxNywrEpLMzq7qT6ROKuG0iq/Hqp8tkLze2osMuVzh7s1bKS9Vl21lIzqcviNaXQ4o8ALYeBDIudDelGt7rJAdrQSh6stDkFjyk3lpgt570ROYAU8ODiBhtC6RiNKtT6CDAuNR8OUm4Di+CVomp368gHl6sXS6jzcIIgxJuuZSn3RUBPrb+zz5gW64fYEOa/HA0N0+1Du1UQFIfn2muRSDX7nkVTlYxJ5jgkosiHMPwCLsez6L2GpZN3syhG08HoAyvtjVUzQeAKE1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiWfQmXu+hxcEQnazz+z2SUsUgrXQlH4aNasvgMy8d4=;
 b=Tj8oPFrFuOa+lvhVjw94n4Xi330/2CIaAEYoWWT8wfjV3YH7keBbskxZp/ajIz5YAqMpX7GAUAT9A77qYnkq2NIoaIhxsjwydegQ4DCL4/ZFMrD+ciuhWCprdaFq19EfWgEW4B7k6vYrZBfzBxV56p3QPsLUuh1zvGjr4qe/v4GKAAtO4NRXXI3+v1U2NHAXWl4e2QD2g8VIlUrzCFQcwTi5KFidtzvonX4LAXUTmR3w7NwbpqBX5MXzv5RzxUsBLNDWAE0IXWBfL71kqpj+DRpgTCaUTNJ01HaE6Sc+kzlEkxfRYzaSVAEMhQzNduayNySF2N3tP/pq4gBhRSbxhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiWfQmXu+hxcEQnazz+z2SUsUgrXQlH4aNasvgMy8d4=;
 b=H7kvE2wqqm3rVVi1gHjJUncBIQOIL4QWnqt33fscSFIB8DKZ+s59u1qgN2VeNF0QZ3ozllqS8Ax1ryjA9uGiKeB0s676oW2Ty8+7uRHtnDFb07rn5oRTfjF4nUIerjlPN4XNck909gknVLY4Qx86lbdRBRy0g9JpL7r9fJ7JHeM=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2824.namprd15.prod.outlook.com (2603:10b6:a03:158::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Tue, 26 May
 2020 21:46:30 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::bdf1:da56:867d:f8a2]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::bdf1:da56:867d:f8a2%7]) with mapi id 15.20.3045.016; Tue, 26 May 2020
 21:46:29 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Jiri Olsa" <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [RFC] perf/core: allow ftrace for functions in
 kernel/event/core.c
Thread-Topic: [RFC] perf/core: allow ftrace for functions in
 kernel/event/core.c
Thread-Index: AQHWM6ViVS5deg/n5kWgZSYX+yJPDqi65OeAgAACB4A=
Date:   Tue, 26 May 2020 21:46:29 +0000
Message-ID: <A9B20D93-748B-4789-801E-91720E2D4F28@fb.com>
References: <20200526212826.4097888-1-songliubraving@fb.com>
 <20200526213913.GG2483@worktop.programming.kicks-ass.net>
In-Reply-To: <20200526213913.GG2483@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.80.23.2.2)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:7e06]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ce241c8-84bc-499d-8fb8-08d801be3fdc
x-ms-traffictypediagnostic: BYAPR15MB2824:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB28248A903A47CD8545AF4068B3B00@BYAPR15MB2824.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 041517DFAB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Wd3wrJis5eUvoq4WkNsn9TN2sJY6pE4X4whR83MuMDrWNUmKwe+1c7/1Tc7Lf4PpQzo+xa0zGc/O+MYUMR3nTX1f7gKMGA+Wk7pz9ziF1HjJgfDu4hj/lzhTImukNvyiLoIthI4VilTBGwwOsWbSrtFh2RwznTvtlOOF7m/o9brcGhnRYY9UAXN6qTtuVLFGnw1r21D9Wdx5mZ8twrG5GUZZUGDReZxacANps3fPG/52rGaPo8qizYICGgsgwfwTgTpasfCfz0eiNTkLXdASsnxWq5rAM90jPAGrfr7zqXQIWpP3VoFKDhYA48EH9k+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(366004)(376002)(396003)(39860400002)(136003)(36756003)(66946007)(6486002)(2906002)(71200400001)(6506007)(53546011)(4326008)(76116006)(4744005)(6512007)(5660300002)(316002)(6916009)(8936002)(186003)(33656002)(86362001)(8676002)(66556008)(66446008)(54906003)(66476007)(478600001)(64756008)(7416002)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: JPWtFSozsnwLU1jdMZ/hfZBQ6LjDBc7VV1Y8ZleunmKrnb05j6JlzSB8jVS2lOeveehSa2J+7tvqE5ASOLvnNmDXeyP5rxyUwuGBjzW9n6LGI86wZQ2/6isO4IMZCNxyvq+2k+n1DabXuKU50goMTcMp5jD0K8hDUtpJhwPWz2KRP2tAHK5S7HJJOsUFT3DHy2YAWrvDFEk/IDRSSeCVkD4GiSaylGfBryPVbQLIEJwaqb4nexXCy0xZn60E6ZLaKbLvpJIlQF4o0oUeSt+83yEOnPJj0S47ZkyL7w8+vgPy/6DLBpF8zQOH6scNRYDfIwulmMYULEovAvlCA/dQvHiFffACoY3heoGjrXxh2rUyMMXQcQQ37+C2BT11URxjn4YAWMEyyUsczRWk8ElOGCgAqt2K2E78R2oYUPXq+5QbjPQqd9fMHWeWZBP6hDonrT54Rn5+WK1mNzh6E9E2Ody5PGzDjw0tIVH2Ox/8AWSk/sYFFPbJyGqnYoWoxJe5EFts63sEdpw8yBNVEz5ktQ==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6DFECFDBCFF44F418AC390E519EE86BD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce241c8-84bc-499d-8fb8-08d801be3fdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2020 21:46:29.8619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bWeavG1WnvLt6ZHbTXF/86GGhKBDoJb4FXqQvfOE1hHqyK6T9SPpE3dvINOUrweM5IlrKJ91PY/ZiG69Q3WwVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2824
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-26_02:2020-05-26,2020-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 impostorscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 cotscore=-2147483648 priorityscore=1501 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260167
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 26, 2020, at 2:39 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Tue, May 26, 2020 at 02:28:26PM -0700, Song Liu wrote:
>> It is useful to trace functions in kernel/event/core.c. Allow ftrace for
>> them by removing $(CC_FLAGS_FTRACE) from Makefile.
>=20
> Did you try using the ftrace event with perf with this on?

I have tried a few things, like=20

  perf stat -e probe:perf_read -I 1000
  perf record -e probe:__x64_sys_perf_event_open -aR

They all work fine.=20

Do you have some tricky functions that we should double check?

Thanks,
Song
