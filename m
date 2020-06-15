Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC77C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7ADE2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nppFjF0B";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="BsH4L2SM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731318AbgFOS2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 14:28:44 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:61750 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729354AbgFOS2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 14:28:43 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05FIJFLd002396;
        Mon, 15 Jun 2020 11:27:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=YBUVcWUW7gQ2Kpphzlu1G8jQ7bzvuBZNvBltgIou7J4=;
 b=nppFjF0B5B9zYFFbH1exv77b5cj/U0qt1di89CzJAbKdxUMErW+bkVevLVwPOOz2STF3
 Nwz1gFCr62jpvTILZ+vMsTkS2h282zc5leTjdnqf2gCdbgUD2UOWFi4u2JKg/epXPw3R
 sYX7cGcFMZejRMnriEZAILNsFqxy3CF7nZ4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31nesqnw03-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 15 Jun 2020 11:27:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 15 Jun 2020 11:27:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUGpiFS+uZp1y3+LTAXczfM//vjR3f2EiomOR/jiSXCKkjEMtv+WecuN1jcascy6KaGiqgDDhJrfUKvSlMhAw/eVz9FVDkQ/n0U22GlshSoIXMkq6a0ApejQijkmfZxzSNBXZQuIMg+5EeAPqDgRXZZQ8EGmxpOWiNGaL7ezFHfLNuY+2/IAp+sr1pDbcpVZuB7XtGuxWhmgL7EK5MyeyCp9wIhsNXtRVfwx4GcncIi4EaaCfHxkqfeuXHONOs8TCUOIt2NYSYzGk1v3BZWLsGlqXVNI3Syzd05SFD4Istq1vNRxPukx3C4OpsZGu7xjHqYSBCvmTBnb5aQjCMWscg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBUVcWUW7gQ2Kpphzlu1G8jQ7bzvuBZNvBltgIou7J4=;
 b=awOpEMMTErNgC3CPWu1A7ydmqabUFX0/HRyarIXTwYLh6fZ02ZOv8idjvUHq3cHLTFO4ngnenUhNhjwvLuaOEaDk8Mkzl/jSxZE5THz634Bvh0TxOFoWUdNKOgRPj6CQwFi1WTSoR8+9TvYPOM+Rhx3KCFyIRYofzOn7HXD8ol4MxXSCr1k9q7NGkCyVTz5cJ/6fXQQEAK1qUuw8tQyEY8whmJBWXHdE8W1Slxc0/8FtKXpdjRN17MK/R0LVQcS+x9wd+iegS60foFCioAiRIvuIq1hqds2vX41atUFvZoWz80nXkd82N/eUo2fzTE6DBrX+pLo53vszvp1F2Pw8hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBUVcWUW7gQ2Kpphzlu1G8jQ7bzvuBZNvBltgIou7J4=;
 b=BsH4L2SMocY2+QkpnW/UYMuEvgab4ZrUmgwfO2JSXbD/yAl6C49Vs05f2cjj6W/1xHlhSl3y2JnkBg05z4LrWy1PAAXDujQ8zfVpgSFhaQkV5pWOvm4LuOrAUQ81xQheh35YLU6JgE4QFQ89Y26P3H81l3hUejLxHeI2NX6Wbfo=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2408.namprd15.prod.outlook.com (2603:10b6:a02:85::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Mon, 15 Jun
 2020 18:27:48 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::543:b185:ef4a:7e8]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::543:b185:ef4a:7e8%5]) with mapi id 15.20.3088.029; Mon, 15 Jun 2020
 18:27:48 +0000
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
Thread-Index: AQHWM6ViVS5deg/n5kWgZSYX+yJPDqi65OeAgAACB4CAAAIsgIAAAuWAgA+1r4CAAAEBAIAPe1mA
Date:   Mon, 15 Jun 2020 18:27:48 +0000
Message-ID: <CC73BE8A-E727-46BC-A28C-4964B5A71678@fb.com>
References: <20200526212826.4097888-1-songliubraving@fb.com>
 <20200526213913.GG2483@worktop.programming.kicks-ass.net>
 <A9B20D93-748B-4789-801E-91720E2D4F28@fb.com>
 <20200526215415.GH2483@worktop.programming.kicks-ass.net>
 <20200526180437.45aed950@gandalf.local.home>
 <595AB855-8E84-4367-AEEC-C140F035C9B4@fb.com>
 <20200605180222.6cc3b34c@oasis.local.home>
In-Reply-To: <20200605180222.6cc3b34c@oasis.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.80.23.2.2)
authentication-results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c091:480::1:ee8d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af508230-aa42-4981-56f0-08d81159ce65
x-ms-traffictypediagnostic: BYAPR15MB2408:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2408F8F818FACFC4172CEAE7B39C0@BYAPR15MB2408.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 64SV5/NwTFYi/AHOLNEH/ASnFXw1kcNDU4fLAClm8BYJP+HQz182RhZrJZxP040Kr9UXhIrQyfMaxoaJ20NxKaINFNc7G1PLoDw2munZaVjXyTXVk02gt7cg/2Z8sasqC3TcBSDsy7CmxK/fySDfR7beqXzqw+55lQOzvc5ynRCAV9jBjRSclQFS1gS5BmblWlkzdnp87qq/tqEEBF2xShP2lAuI0V/bKGC6KJiulorBkrO4/bf30c5NLEU9UzBLd2Vd7/DB/dQiFyYs35QWCLFgCZ+uPsvkaEupenq09jZwA9CMaMM+KKNkn0lCWfOd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(366004)(346002)(136003)(376002)(478600001)(316002)(8936002)(54906003)(33656002)(8676002)(7416002)(71200400001)(36756003)(6512007)(6486002)(186003)(4744005)(2906002)(91956017)(76116006)(2616005)(6916009)(4326008)(66946007)(53546011)(6506007)(66476007)(64756008)(66556008)(5660300002)(66446008)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: dSnaUdxQ6Cj899LUrMorSzHK1TnzIpLzdD0uLjtKoZnTsVXLg6F/wpO3VDU0xn8UGt69Ab90zwup+KzchTZsK01DEDvIK3tv7quzKtpE3vZkkiLdDZ+ntl6MYGiSpYLJ37UOaS9ZmMGvdLmr6LnZGyIZg1fH6QC88nt1pnZ5Y/yeX+AQOGvq31aTx1NmVEQK1K5b7dCoCfCS/iOG+h0CQ9zf+BAf3LIanG114LD5yosmvaco0168svJ5hmN5etuGlHY5uVvI7Wr5XLBSH9+1shT/mJSdUprfYfeMLPgZLBOYg/z/0OcSJQzQxIUlYJJZ/iSCKvloIBK/msxQKgRBSYOnM4saahy3saZrg/GS6cZ1gs0oUWOOPJpYOrRNmQzE6LsUnD7xzLXfNw9Tzg9rNHuDmse5YmB9xufaQeCWC0ChJlpuX80QYobyQWuSTSX4WtgN8+5lRTh5Naj0pN1Kg7wUScvj+/z9KdADVn8TYomx93PtqgYOf4KbJrAEcXjtTKcKNQ5Nt6rLGYfMTcecew==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5A72E9A55F0587418F9B93313FF471F9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: af508230-aa42-4981-56f0-08d81159ce65
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 18:27:48.3855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /mJy+WZqkumd8EFCKrRyXSQiuUIV1msdEHX2QUckA1GE5EZAPaEVbjwKVPh5XpORuAcmklTIh5nuR3sZM9QmHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2408
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-15_07:2020-06-15,2020-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 cotscore=-2147483648 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 mlxlogscore=901
 lowpriorityscore=0 phishscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006150137
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

> On Jun 5, 2020, at 3:02 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Fri, 5 Jun 2020 21:58:48 +0000
> Song Liu <songliubraving@fb.com> wrote:
>=20
>>=20
>> How does this work in your tests?=20
>=20
> I started it, but got distracted by other work. It did not crash with
> the little testing I did do. I wanted to also look at my patch that
> adds tracing to the ftrace directory too.
>=20
> I'll try to remember to address this some more next week. Feel free to
> ping me again then.

Have you got chance to run these tests?

Thanks,
Song

