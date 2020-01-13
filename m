Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAEAC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 20:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC15A222C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 20:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="j4tGnHoQ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="gn3IHrYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgAMUju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 15:39:50 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30506 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726878AbgAMUjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 15:39:49 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 00DKcw4E010781;
        Mon, 13 Jan 2020 12:39:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=srnuwSGJG6J5gDwMFeFpELpZximfkFyvtIRh+YF9ObU=;
 b=j4tGnHoQrn0VO72R3ZilY+ETY93j4vwV5izzE2wtTAwkQ2wNJS86K46fWU8epCot1kZ2
 ZwZ1r82o1LQRPfKHw3tCLeM5IKzxwheRpcBltvrRi2hAI7p4JQT9xcStM1xXrv7kQEgs
 n0HKeYBu/hRcneXL+wbJwWv7/kAFnEmVfFc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 2xfawra53x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 13 Jan 2020 12:39:14 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 13 Jan 2020 12:39:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/Qd20ac8VazB/kxI44YiXb8ZpVf+HE62eRiAcDvDt9YXg2yybHFUkopuTX8aZd/3+BAQfoC7nX9aW04k3hyOiVlJ7KdBXes2LFUBlOjcyAppB03LI5VYE/ibesNcI9ptwZsbkpI6krp8oaAH2LomKA0sj+xG/kdEZg8miZielwaJL+mmTW8dA/oQaAwMuMY//XD46HJg9WAJL4z/Y4bYqlwjoxuKFx4vZayWzwWeC5D/aW53oGulNFPhB73idBxJ8Motfqf7GDg5kYqqL6zlzm2n0E8P6UDHRJNGIafn19HjD9fqDfECH02KWb9g8HlkBgzuMsrbuMik2PZGB73wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srnuwSGJG6J5gDwMFeFpELpZximfkFyvtIRh+YF9ObU=;
 b=U3nzjvo3A0Z6s02QGAq8LRrt//JbBplJz84HtAStbRjM0LvIeMCHFVt8KbgoRUi/YosvqQpkuth2TeVzu2KFjXO6mVFZDMFIDUhXcOXr7zfQYgt1OhTSnYU5N+f1vZOsigtXTJTCepRgyVRSTXmsdgw6cdeGLibUZvHsY7b29lZwo1GGOUdNFBbTgIlFYqUvndgo8VRaagUHn2NdIKnx/HpPz/crL82MGpNlVULgrHYqatzXYy0DJBBVZQKIMU2H2EGhuenuFc/+M9e2arBowD+uFU0/78xSZS9ofCUOlYMK06scHXe+3FGgJuGirdexybdrxkfQ0/ExVJSGf0XSew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srnuwSGJG6J5gDwMFeFpELpZximfkFyvtIRh+YF9ObU=;
 b=gn3IHrYeUrQAiJ3BeAOmpCRWjDjrUYMVyTTcKPfDSOtpdvKl1ivmqmWR6NNPAQnJl0O6QkyyOGmOXX4cA7t1fdCLpgITNClEIOBY6wxlOkpMPmnXCpLF+a5HLNP0z1GHw7jIRyE3rHQ66fyZ9SVbah0vVWkyLvxEG57ljyE87nk=
Received: from BYAPR15MB3029.namprd15.prod.outlook.com (20.178.238.208) by
 BYAPR15MB3334.namprd15.prod.outlook.com (20.179.57.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Mon, 13 Jan 2020 20:39:11 +0000
Received: from BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d]) by BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d%3]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 20:39:11 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "james.bottomley@hansenpartnership.com" 
        <james.bottomley@hansenpartnership.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Will Deacon <will.deacon@arm.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Robert Richter <rric@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/9] perf/core: open access for CAP_SYS_PERFMON
 privileged process
Thread-Topic: [PATCH v4 2/9] perf/core: open access for CAP_SYS_PERFMON
 privileged process
Thread-Index: AQHVtYUpMC7X/V/PgEituL3lQIWiD6fhEFaAgAFGyQCAAbsNAIAAHqKAgAAO5YCAAHXsgIAACgUAgAADSQCAAJ0NAIAD1/8A
Date:   Mon, 13 Jan 2020 20:39:10 +0000
Message-ID: <2794FEDA-8259-41C0-AF43-28AE2BEB4E26@fb.com>
References: <c0460c78-b1a6-b5f7-7119-d97e5998f308@linux.intel.com>
 <c93309dc-b920-f5fa-f997-e8b2faf47b88@linux.intel.com>
 <20200108160713.GI2844@hirez.programming.kicks-ass.net>
 <cc239899-5c52-2fd0-286d-4bff18877937@linux.intel.com>
 <20200110140234.GO2844@hirez.programming.kicks-ass.net>
 <20200111005213.6dfd98fb36ace098004bde0e@kernel.org>
 <20200110164531.GA2598@kernel.org>
 <20200111084735.0ff01c758bfbfd0ae2e1f24e@kernel.org>
 <2B79131A-3F76-47F5-AAB4-08BCA820473F@fb.com>
 <5e191833.1c69fb81.8bc25.a88c@mx.google.com>
 <158a4033-f8d6-8af7-77b0-20e62ec913b0@linux.intel.com>
In-Reply-To: <158a4033-f8d6-8af7-77b0-20e62ec913b0@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.40.2.2.4)
x-originating-ip: [2620:10d:c090:200::6df5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a87b7a05-e80c-4d39-d882-08d79868a523
x-ms-traffictypediagnostic: BYAPR15MB3334:
x-microsoft-antispam-prvs: <BYAPR15MB3334919273DA6339F2C2BC62B3350@BYAPR15MB3334.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(199004)(189003)(7416002)(186003)(76116006)(54906003)(2616005)(86362001)(6486002)(498600001)(71200400001)(6916009)(5660300002)(66446008)(33656002)(66476007)(36756003)(81166006)(81156014)(8936002)(6512007)(64756008)(66556008)(2906002)(53546011)(6506007)(91956017)(4326008)(8676002)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3334;H:BYAPR15MB3029.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sxe7qoOdzxA+U2Z9nZTqKeVBNWGW8wiq26AiBjF4VEXgAVNIpRBAcn5nFsClabnVhrY0V6HGq7z8sNzHzVr8pbChKPhOfjThP/Zaq8Vgzu3SqjVkCJjYEDCew+DLsBJRkZLGOAcdMIOZlnMpgaGMTn8unUvxYjaSdv1iovgUxAEeXCB3oSc6KNYWGSp7aiqI3xQFiQyTX7+igTlNrkKk3u4oCDtat+4l1HQVpZDcHC+eUeYVIGu7rqy//KUtSZWcJ3rtSEP+XHd4/sFlLLOsqdygtrwzSTJpt3R2Mu+Liy+WOzdblwXtsj/zkm+DcXPy5DB9XpCVJOPI8L03eaMUA2CKSyn1N/OdBnpXG2cXd6QdNNuOTQ1cvcAbMPjL0lpwQAZbBjg5uDuxvPYh8vZZ6WOTu7I8ANpx0y/DuIM9GmZWngtWDkGEStjC/1XGqRZ2
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4E052D1263306F4C99322179A5ACE9A7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a87b7a05-e80c-4d39-d882-08d79868a523
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 20:39:10.7277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0pcBRuL6i4iyJ1QToxUvBK7pR75FeW3sWduq/pYamHSCgYNVv0QDzqigEKntEuMP7Nt9uS5ursgvpteesceZqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3334
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_06:2020-01-13,2020-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 clxscore=1015 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001130168
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 11, 2020, at 1:57 AM, Alexey Budankov <alexey.budankov@linux.intel=
.com> wrote:
>=20
>=20
> On 11.01.2020 3:35, arnaldo.melo@gmail.com wrote:
>> <keescook@chromium.org>,Jann Horn <jannh@google.com>,Thomas Gleixner <tg=
lx@linutronix.de>,Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,Lionel La=
ndwerlin <lionel.g.landwerlin@intel.com>,linux-kernel <linux-kernel@vger.ke=
rnel.org>,"linux-security-module@vger.kernel.org" <linux-security-module@vg=
er.kernel.org>,"selinux@vger.kernel.org" <selinux@vger.kernel.org>,"intel-g=
fx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,"bpf@vger.kerne=
l.org" <bpf@vger.kernel.org>,"linux-parisc@vger.kernel.org" <linux-parisc@v=
ger.kernel.org>,"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.=
org>,"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,=
"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.or=
g>,"oprofile-list@lists.sf.net" <oprofile-list@lists.sf.net>
>> From: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Message-ID: <A7F0BF73-9189-44BA-9264-C88F2F51CBF3@kernel.org>
>>=20
>> On January 10, 2020 9:23:27 PM GMT-03:00, Song Liu <songliubraving@fb.co=
m> wrote:
>>>=20
>>>=20
>>>> On Jan 10, 2020, at 3:47 PM, Masami Hiramatsu <mhiramat@kernel.org>
>>> wrote:
>>>>=20
>>>> On Fri, 10 Jan 2020 13:45:31 -0300
>>>> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>>>=20
>>>>> Em Sat, Jan 11, 2020 at 12:52:13AM +0900, Masami Hiramatsu escreveu:
>>>>>> On Fri, 10 Jan 2020 15:02:34 +0100 Peter Zijlstra
>>> <peterz@infradead.org> wrote:
>>>>>>> Again, this only allows attaching to previously created kprobes,
>>> it does
>>>>>>> not allow creating kprobes, right?
>>>>>=20
>>>>>>> That is; I don't think CAP_SYS_PERFMON should be allowed to create
>>>>>>> kprobes.
>>>>>=20
>>>>>>> As might be clear; I don't actually know what the user-ABI is for
>>>>>>> creating kprobes.
>>>>>=20
>>>>>> There are 2 ABIs nowadays, ftrace and ebpf. perf-probe uses ftrace
>>> interface to
>>>>>> define new kprobe events, and those events are treated as
>>> completely same as
>>>>>> tracepoint events. On the other hand, ebpf tries to define new
>>> probe event
>>>>>> via perf_event interface. Above one is that interface. IOW, it
>>> creates new kprobe.
>>>>>=20
>>>>> Masami, any plans to make 'perf probe' use the perf_event_open()
>>>>> interface for creating kprobes/uprobes?
>>>>=20
>>>> Would you mean perf probe to switch to perf_event_open()?
>>>> No, perf probe is for setting up the ftrace probe events. I think we
>>> can add an
>>>> option to use perf_event_open(). But current kprobe creation from
>>> perf_event_open()
>>>> is separated from ftrace by design.
>>>=20
>>> I guess we can extend event parser to understand kprobe directly.
>>> Instead of
>>>=20
>>> 	perf probe kernel_func
>>> 	perf stat/record -e probe:kernel_func ...
>>>=20
>>> We can just do=20
>>>=20
>>> 	perf stat/record -e kprobe:kernel_func ...
>>=20
>>=20
>> You took the words from my mouth, exactly, that is a perfect use case, a=
n alternative to the 'perf probe' one of making a disabled event that then =
gets activated via record/stat/trace, in many cases it's better, removes th=
e explicit probe setup case.
>=20
> Arnaldo, Masami, Song,
>=20
> What do you think about making this also open to CAP_SYS_PERFMON privileg=
ed processes?

I think we should at least allow CAP_SYS_PERFMON to create some kprobes. Ma=
ybe we can=20
limited that to per-task kprobes, and the task should be owned by the user?

Thanks,
Song


