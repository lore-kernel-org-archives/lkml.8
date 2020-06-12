Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EA8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88BAA206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SQhP3Z+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgFLTA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:00:29 -0400
Received: from mail-dm6nam10on2135.outbound.protection.outlook.com ([40.107.93.135]:53793
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726219AbgFLTA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:00:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9AWszs7xt1UpAnCZ42jvn8UmiCHqpIrv+Hntci+xRWRTrLwJdECcFOAo4aaaD+AcOoLfUw7cYBkZxo4RS7Dhr2boHaNgWoki3Whrn+a3UcWK+R1H1YBo2DfAiRw650bklMT9aW5UtjWhfVpFu9LzaG2gC3bC1ziKhgFYPJjwSH1YMWmqO1Yg7Rk+GPN3qrpfoCRpjCqprpTHEAf5ASsOmWKmxFvUXBgDebLAFKnSXOVdwgtIFsFEOLRJ7SfIUvoXhPTPgyn5senX9K7h9iMQb2qSFvmuwzaZUzx1fJEFtpPXtoyT0RqnFxGm4c5MEo9b+cDfsMfwlnQL3Thbxdx+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZOzYtYYy4YMfCPqWH0YfUQQUUsra+kP3Q82vuyMDrM=;
 b=h37u+sDIHplwo9UvnQoEDiSgFheO3J5EZIoxvE4h8k4cjA7pCp6JR4c6f4KjOLDcYrWoHrXyXQ1Xqe/nhmOiBQLupuLliSQL79Onb/elpJ8GK+3ZTxdqkLQxRdrZWnzj/zzUNFG7oc6XkCWxKCWGu5Uz6qa4LxJgIFsgMWlPBpUnFgvCsKLfs9LzoNy4iVLMl4UsZVNIMywSYichVgeMzunPufPhLOkYuNdkePwSnvOIGCNn+hetxgCn3fnv0a6zoFGPFu465M/oWKp9n2nZcQrBR7UCt644UBpRkJ0B+8kK4Gzp4lU8Y6EsD073CAxo9qq4Gr0RTimW5d6oe5G6zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZOzYtYYy4YMfCPqWH0YfUQQUUsra+kP3Q82vuyMDrM=;
 b=SQhP3Z+/La9FMwuyBKwQGrBsW9x9EmDNPh/6CD/g/rPSMGgKveMXVNxX6cptpbPs8eo5gmRHXrr2475fH+lWxYzQNMtObvZphwv7nQtwvmPmyEXFF93lYDIXNiDLw6WTY1Lra/ydtkTU/d+jhpwJMQ78lvfn7OSEtV4sIlREGQI=
Received: from BN7PR21MB1667.namprd21.prod.outlook.com (2603:10b6:406:ad::15)
 by BN6PR21MB0626.namprd21.prod.outlook.com (2603:10b6:404:11a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.7; Fri, 12 Jun
 2020 19:00:14 +0000
Received: from BN7PR21MB1667.namprd21.prod.outlook.com
 ([fe80::9132:d87f:7a76:e632]) by BN7PR21MB1667.namprd21.prod.outlook.com
 ([fe80::9132:d87f:7a76:e632%3]) with mapi id 15.20.3109.011; Fri, 12 Jun 2020
 19:00:13 +0000
From:   Steve MacLean <Steve.MacLean@microsoft.com>
To:     Nick Gasson <nick.gasson@arm.com>, Ian Rogers <irogers@google.com>
CC:     Steve MacLean <steve.maclean@linux.microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v4] perf inject --jit: Remove //anon mmap
 events
Thread-Topic: [EXTERNAL] Re: [PATCH v4] perf inject --jit: Remove //anon mmap
 events
Thread-Index: AQHWM8mKGkvgLkOO8Em0Algb20rYzKi8SrMAgAACEUCAAB83gIAA0mCAgAYSsoCAACu4AIAAE0SAgBHal7A=
Date:   Fri, 12 Jun 2020 19:00:13 +0000
Message-ID: <BN7PR21MB166740321F6EACF49E9BC874F7810@BN7PR21MB1667.namprd21.prod.outlook.com>
References: <1590544271-125795-1-git-send-email-steve.maclean@linux.microsoft.com>
 <CAP-5=fXGXqkTbSwKv7eq9UkPvVqRJXDm3E-XNxD8+5fmQk3bpg@mail.gmail.com>
 <MN2PR21MB15185419971A29EF52B8138FF7B10@MN2PR21MB1518.namprd21.prod.outlook.com>
 <CAP-5=fVHo262Lo_Re31wM8Bt0soJ-m51J7MEnwvdTg5P8J6e6A@mail.gmail.com>
 <CAP-5=fV7F4u66388HC-q8btOYWKxtb1gTTi4LK_Besb-zE25Rw@mail.gmail.com>
 <xgl9tuzvz4wc.fsf@arm.com>
 <CAP-5=fWU==y-DMd5sD7AxHCUNg0L4Qt_VRVvyDVNYPCOdxmU_A@mail.gmail.com>
 <xgl9mu5nyugm.fsf@arm.com>
In-Reply-To: <xgl9mu5nyugm.fsf@arm.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-06-12T19:00:11Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d3aa0a85-c0c8-4965-8072-356270cd1449;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [75.182.186.176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d4c82566-2d48-4a24-3291-08d80f02d6bc
x-ms-traffictypediagnostic: BN6PR21MB0626:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR21MB06265BE748C3E285627C819DF7810@BN6PR21MB0626.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0432A04947
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jHe8uW1cjvNgaDzxRhfPqVkfGTIpuEDAAhl5EhuyLDf+9dgnpxDjCtu3tLZd4xbayCIk7NLFhK22O3Vb9Rs1FreUIWBSztsNSenleCYGlYAHoFGJyR5a36qQe7zR00imNyQqbtlY60OtcPkQ+gHUmklI2v4f8btEFi06M1ye/74iI3tc5zbGfAb0zP8rX2i/zGJntMNl34XC+sOnttiqlx7VDmulnipzAWKV5DR/y9CQ+2hfcGiPPGKkP0M72wWWyI/sVU4QVpgyz6FAiLCXU4/iHfHPEP30Pnxi5NgCdil7pDELWp4e8cQNLVwD07+arhXGtw3iPRI+k87Q2NQx/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR21MB1667.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(6506007)(83380400001)(76116006)(82950400001)(2906002)(66946007)(66556008)(7696005)(86362001)(54906003)(7416002)(26005)(82960400001)(64756008)(66476007)(186003)(66446008)(52536014)(5660300002)(8676002)(4326008)(478600001)(316002)(110136005)(10290500003)(8990500004)(71200400001)(55016002)(8936002)(33656002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: HSK2Ta2oDrF+lq2ajCeoZSN6oAIF1jq8ihvZ/30rmcV3zFryOR2M8MOgpvcICHhcC8J5E3xL3Zk+1mwgnMoQ+Mj9mRxlNTJQ8O8acXBReNELZCLmQkoATFOW5CAel8Mu87so6HS62U4dgp7mVlMOTL5vu7gk/M7ZwyEeoQ2QgZIRmd2rVu5fBEVBQK4TVe8NXnrYmdbBhCGqClMb4YbcAew+/EBmONHYjBfBzkdpd6CP1LGHmaEj4innEsVbLJaGnGybmjOrgTwX97gAeg49VqsSFaU3HCfE96PJCe6e5OAG0YuPjJ5XO7uWQRV+fcitE/udQOuYullG5rbLfrapOXvqqKb7Z5/CgLGgTCbDXvlCVCB2los8rla9OVEJjrxDJEeN0XEQbsJTz+IUzWOphF4NeF7ANHYQFhq2no9slVtS9FiHXa3P3Pvg8l7GOgduNnA5rFng2ZAJ8XLCoc2uyV6SSMm1a0KaLW9gYM8AV1aOFAcwU4E/N0SL1I1TxQ4C
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c82566-2d48-4a24-3291-08d80f02d6bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2020 19:00:13.8335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mq/D6PWSpRnL0EsIc0kMltpwVcL+G6MNcVDgGJZDXVaD2yjeUv6n3Ib7S/+gULIilt6O6/bW1ft2tpwCZoHwVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0626
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Hi Ian,
>>>
>>>> I tried this as well with latest perf/core. The difference is that=20
>>> unresolved addresses currently look like:
>>>
>>>      0.00%  java             [JIT] tid 221782       [.] 0x0000ffff45149=
9a4
>>>      0.00%  java             [JIT] tid 221782       [.] 0x0000ffff4514f=
3e8
>>>      0.00%  java             [JIT] tid 221782       [.] 0x0000ffff45149=
394
>>>
>>> But after Steve's patch this becomes:
>>>
>>>      0.00%  java             [unknown]              [.] 0x0000ffff58557=
d14
>>>      0.00%  java             [unknown]              [.] 0x0000ffff785c0=
3b4
>>>      0.00%  java             [unknown]              [.] 0x0000ffff58386=
520
>>>
>>> I couldn't see any events that were symbolised before but are no=20
>>> longer symbolised after this patch.
>>
>> I see this, thanks for digging into the explanation! Were you able to=20
>> get a test case where the unknowns went down? For example, by forcing=20
>> the code cache size to be small? This is the result I'd expect to see.
>
>I tried the same Dacapo benchmark as you with different values of InitialC=
odeCacheSize and grepped for -e '\[unknown\]' -e '\[JIT\]'.
>
>       Base   Patched
> 100M  338    373
> 50M   333    315
> 25M   323    368
> 15M   1238   309
> 10M   2600   333
> 1M    6035   337
>
>This looks fairly convincing to me: the cliff at 15M is where the code cac=
he starts needing to be enlarged.
>

Removing the anonymous mappings causes a small regression.  Specifically,
the reporting of the module name goes from "[JIT] tid <tid>" to "[unknown]"=
.
This occurs when the JIT fails to report memory used in jitdump before it=20
is used.

However there is also confirmation that JAVA does see the reported issue=20
when using a small code cache.  The current patch resolves the issue in
this case.

I see two options:

+ Accept the regression. Since this is a regression for a jit dump=20
reporting synchronization error, this may be a reasonable option.

+ Design a more complicated patch. Either
    + Only strip parts of // anon mmap events overlapping existing=20
      jitted-<pid>-<code_index>.so mmap events.
    + Only strip parts of // anon mmap events overlapping prior
      // anon mmap events

Any opinions?
