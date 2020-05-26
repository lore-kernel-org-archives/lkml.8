Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BF3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C7C8208DB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DrYv4A9P";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="RdYrG5ax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391885AbgEZWK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 18:10:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43576 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389342AbgEZWKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 18:10:24 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 04QMA0wk031463;
        Tue, 26 May 2020 15:10:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=WEjCwj6MpzH6ukKsonI+KU8xiXcZtxYFsn53IjGzYNo=;
 b=DrYv4A9P5pJwARW5gupjX5Iqk3Y/PeUGvXgKybMXcPBVXvp54tvkwMCps7Zd3MI9zGsk
 r+gZF749lm08Ge9bnrBZfJwDSCGM3LcmFo3FUZEiqtgieerBcvZFVPdddX7lLu1HIaGB
 ahfcgmWY0m3WzzNRMksx+tDa/Jg4avyUwts= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 316yb155ex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 26 May 2020 15:10:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 26 May 2020 15:09:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRUuJRUr+/L0AHa+MBaz6kaD/UwGr8L+uOlqTM1JCyntToXXNwyeRWqK8f6nQdc4KG06hFcCY6e6JPnl1zmtUhdY2Z071ImVFISQBqEuguD3qdPDH8/yzCHiTm8ZroaTl9XgK0NcwXEyX/12ripOltbcul07+lhXYQuKU5PhKrK6UySFYA7JL06cxvTFE8EsjegATn72hR3RBpPAH7/ZiXTUlswSfWzPo+QY4zzvAsr5InpLTtbQuSOQwkWQ0WIOE9Pv+OLZAnGQdn0zQ9UFoKnxFsrSDIOnucwe3bTTh1madQ69oDyNRdpEB53TnBexjs/xmfRCLOPzAyxUTUyHuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEjCwj6MpzH6ukKsonI+KU8xiXcZtxYFsn53IjGzYNo=;
 b=eyE4DOtSAZ0fOupAMynGg9wgzl1Yw5/OXjnJftnCDsIjzC73osjk7IJduDEshsZ4d4GejK+cKrbwqCgSMtfYEty2XLEVTuSEhccsKaqYo15JFxDfw0M7c1wgWbalvHP/2tkUr3rgfeYnxv86mDH3LU895Ii/8VPFNnfl7QCboCHWLEJsXvx9pbO9ZhDxuWVNmh6QEKOnHDmtdLeQQLHuXd9MdD5cbccsRmEBjjfLGRvOMeIQxgIK6qA4cop+aax3Jh0W5yQe19nKaPIYgeDNsiVuplqQs/9PHLUfhZleGNwI7vBnQHmjWVcgVV00y4vNGL+mb5tZNavW1yYEBUfHrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEjCwj6MpzH6ukKsonI+KU8xiXcZtxYFsn53IjGzYNo=;
 b=RdYrG5axbh/O8D5kUGKMAjKake41TVY6ckG7ihnQS/afRbztsdUpy8mHny1B3Sno5quvXBLRFOTMGmcaFXOBCwSEDTNhaIueLEoD2fSjpnklMmnSHelc0VelfgkhIr4LGwbBDxpeMNOY4kuR/nBPKdurYFR2kIxFSH6UoJJm2ek=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB3254.namprd15.prod.outlook.com (2603:10b6:a03:110::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Tue, 26 May
 2020 22:09:51 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::bdf1:da56:867d:f8a2]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::bdf1:da56:867d:f8a2%7]) with mapi id 15.20.3045.016; Tue, 26 May 2020
 22:09:51 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Jiri Olsa" <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [RFC] perf/core: allow ftrace for functions in
 kernel/event/core.c
Thread-Topic: [RFC] perf/core: allow ftrace for functions in
 kernel/event/core.c
Thread-Index: AQHWM6ViVS5deg/n5kWgZSYX+yJPDqi65OeAgAACB4CAAAIsgIAAAuWAgAABdQA=
Date:   Tue, 26 May 2020 22:09:51 +0000
Message-ID: <196BAA45-AD7A-4DAE-A4C8-CED3DF2C6E17@fb.com>
References: <20200526212826.4097888-1-songliubraving@fb.com>
 <20200526213913.GG2483@worktop.programming.kicks-ass.net>
 <A9B20D93-748B-4789-801E-91720E2D4F28@fb.com>
 <20200526215415.GH2483@worktop.programming.kicks-ass.net>
 <20200526180437.45aed950@gandalf.local.home>
In-Reply-To: <20200526180437.45aed950@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.80.23.2.2)
authentication-results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:7e06]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03698b4a-fe29-4cd3-29d7-08d801c1831b
x-ms-traffictypediagnostic: BYAPR15MB3254:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB32542B4AD7E826CD22AECA98B3B00@BYAPR15MB3254.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 041517DFAB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: azeNGXG9nZmQNenYColia0X58KstFdz9vK4e3gj5xSfe4oYkH3C9ZcnVLm/5zKf9OG/J47FiYjiZtCWjxILxN+yHO+HTuLvEdWG/oVGGTcQTJEodx7f4py35sJaF4hbKmBsZ2YFVXrwUoNkfOG+LW3toWIGFqYAwForeBbGHz/IyXhgHueKjD+HtptYFNVKYjWlmnx5BEWE2k6z+CfKoiiWbfLtApA9V69e7wLRxF2moIrI6t0luCTQ+/cHWuXm4lOTs0wI/5+LW4CxaSyrUD3QgObOYpAki24d94ghsqEKrDuvQX3pLolYwYKIlcFUyufwA2ETPBxo5Lg3pUIYUJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(376002)(346002)(136003)(366004)(396003)(36756003)(71200400001)(6916009)(6486002)(6512007)(5660300002)(316002)(54906003)(66446008)(33656002)(64756008)(2906002)(478600001)(7416002)(66556008)(4326008)(86362001)(66476007)(8676002)(76116006)(6506007)(8936002)(66946007)(53546011)(2616005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: CGZ3S/SeDcymKvnxKQ81znUi1KgLp1mBneUMFgB4YmdwWAN9kcu5Zufev8brQ//+wmtMgUPBQxhBWApWcVpWqzu09aLsZQemOlezwRqLQL/Bnwq8ZOBf8n+bxgaMCSKc1Y6MOVBY+ZhUe8bA9okrdEVNODF9dttyBoKy/WdZNuJY0kEftYUXsXgXFqrV2FpOdFlDAgvQRKRH5UjcHBTndI7F/4Poldj22vsl1a556iA/v38BNbNeKC+sT+GCn6dWMH632LZ11XluLoZAhyWiMsBce58sEZ0codMnFS2M+h/G0otz1ndXEVDgctWIEhnF1IjNcYapD4IV1r+gIXcdW1pLlkGrm+8Fn3zouP8p1/hRw9eCdsmTaYXqPtAe0yzOiBtYdahAAXR3Tnf4TXRLnBWrR77fGOiEzhk1fHklGADy87woqtUyw5U912QpLBlSXFWwYMb5mtMTBQFIxPAOWZmemoHM/K8uX97Qnh5J1KkBj1nMnfoRyReahxGrwKprC9LBnLVO9AS6a1BX6WtyFw==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <727EA5194B08C14EA1CD69904AAC3B11@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 03698b4a-fe29-4cd3-29d7-08d801c1831b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2020 22:09:51.1537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pJiSXg6COIXps6JQXFYmm/vtLqHEvODJSPvRmjXV1WXnwjD2F3tdC2YLZa9qLA8f3xkT7kz59NneIvvps85YCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3254
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-26_02:2020-05-26,2020-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1015 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
 cotscore=-2147483648 spamscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260171
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 26, 2020, at 3:04 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Tue, 26 May 2020 23:54:15 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>> On Tue, May 26, 2020 at 09:46:29PM +0000, Song Liu wrote:
>>>=20
>>>=20
>>>> On May 26, 2020, at 2:39 PM, Peter Zijlstra <peterz@infradead.org> wro=
te:
>>>>=20
>>>> On Tue, May 26, 2020 at 02:28:26PM -0700, Song Liu wrote: =20
>>>>> It is useful to trace functions in kernel/event/core.c. Allow ftrace =
for
>>>>> them by removing $(CC_FLAGS_FTRACE) from Makefile. =20
>>>>=20
>>>> Did you try using the ftrace event with perf with this on? =20
>>>=20
>>> I have tried a few things, like=20
>>>=20
>>>  perf stat -e probe:perf_read -I 1000
>>>  perf record -e probe:__x64_sys_perf_event_open -aR
>>>=20
>>> They all work fine.=20
>>>=20
>>> Do you have some tricky functions that we should double check? =20
>>=20
>> I've no idea what probe: does. iirc there's something like
>> ftrace:function that is like regular function tracing.
>>=20
>> At some point using that made the kernel really sick due to recursion
>> between ftrace and perf. Quite possibly that's been fixed, dunno.
>=20
> In the early days there was a lot of issues with recursions, but I added =
a
> lot of recursion protection since then. I'll give this patch a spin and s=
ee
> if I can make it crash.

Thanks!=20

Song=
