Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5784C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A2120757
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="zzzgCgv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389457AbgDBPoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:44:07 -0400
Received: from mail-bn7nam10on2046.outbound.protection.outlook.com ([40.107.92.46]:8028
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389413AbgDBPoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:44:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjUy8rPCAvA6Q/aZy3GgJjKpBrWVymZ/xWTZme4xOimsP+A/4vzC7XdXmT1PKNGpV8eq4d+M7aufxS9bjcxcRMF7ct/vfLuizMRehJmugIlTWwBG3DXpun74HcKDtmdYOWEPfmFnpywj5cuyuXLqGv+Wq5azOqPu5ZiM6fVsSRtgG51HI54BC39L9T7ui3r1Y+GOAcSGiIPe581EGHgI89ZSpnBU1V8bpgM4skvDAnsadRLcc91cT0LQ/ZFh1hWtr31WHGezB4DFQHP/MgNa6aPdV3OFvfxI/wXMqjGVqVY4BRlIcdwaopqq/TbXFdh/KTaGbgK5Uc44eDT6UUftvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urZ1Z5Zws6vHH2QwFUM5KbN7S6ite+SjOd8q6/FgyJo=;
 b=H9gNOTUMCAZtHAnN52r6Tm2BlTm8Vl0lJ7gq82jAjAeUgl7S25MTPu3v+vYeIspPimnzbQJh8jxBimVZ5luLo1z566vgMFyEATI/aD0CWbec71wRGp81WeoaWjWiOuT5tEw0du1IegS2U+qOIN1mqJkspOk88Rbvq3WeL4Hxd9L4PKCWW7hUnc7xrDrR1YDsLwohbwr2F1Pp7/wMliN5rzrsljIgDtCvgp2rTzLKAL7P7NhnO/kUyi3Q8LJEykW0Bz9qgmh6wqKiteqohcbLOyM0SsFZPwc6bGOEoA04UgmbLs6yfPI77jLxBAPTuBOGr+4hoW1TrftAyRzRMmG8HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urZ1Z5Zws6vHH2QwFUM5KbN7S6ite+SjOd8q6/FgyJo=;
 b=zzzgCgv9t7cXt5lT0Iw6JvhNRh+8VPU5o7jQcZfmyuTEmEaBfg+cf+6ahovDd/s1LQ/40C6s72pnUovxI8QPlcY4WWfDVn+qMHTVezFr8DqBr1EliuyxoNj2FwR5F9hyiuWoLYrv4UkJ10W2tYwmRJxcj2YuqeSu7FGnIEdSXjw=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (2603:10b6:a03:4a::18)
 by BYAPR05MB4376.namprd05.prod.outlook.com (2603:10b6:a02:f7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.12; Thu, 2 Apr
 2020 15:44:00 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::7c65:25af:faf7:5331]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::7c65:25af:faf7:5331%2]) with mapi id 15.20.2878.014; Thu, 2 Apr 2020
 15:44:00 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 2/2] x86/kvm/vmx: Prevent split lock detection induced #AC
 wreckage
Thread-Topic: [patch 2/2] x86/kvm/vmx: Prevent split lock detection induced
 #AC wreckage
Thread-Index: AQHWCO7TQEdzxFpLhEGvPpyBQxsUlqhl9XCAgAADv4A=
Date:   Thu, 2 Apr 2020 15:44:00 +0000
Message-ID: <18758F52-BB97-4F47-9481-F66AF4465A06@vmware.com>
References: <20200402123258.895628824@linutronix.de>
 <20200402124205.334622628@linutronix.de>
 <20200402153035.GA13879@linux.intel.com>
In-Reply-To: <20200402153035.GA13879@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [2601:647:4700:9b2:1153:aafd:5246:5949]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9de6861a-f2fb-45d3-5ea6-08d7d71ca9e1
x-ms-traffictypediagnostic: BYAPR05MB4376:|BYAPR05MB4376:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB4376A519DF49F212802A6595D0C60@BYAPR05MB4376.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4776.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(7416002)(966005)(36756003)(6916009)(81156014)(66476007)(76116006)(66446008)(66556008)(81166006)(8676002)(66946007)(8936002)(64756008)(5660300002)(6486002)(71200400001)(4326008)(478600001)(86362001)(54906003)(2906002)(186003)(33656002)(53546011)(2616005)(6506007)(316002)(6512007);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nIBaSNhF3zlLjF13xy5gYcrsaavGkf5XDIXm/mwKmF2r8p12VrduhFddqqfENRh0N2OYdRzIOtBeMdoXx4dE9M9wMSj2Re0Qd2yEUuoDgnr1lLdhR6Y88+JSx4LPagvzBqLpJuv6BH6CtWFu3cFzKmp+1A84mRItnI2jOckOlAgvj+1ARni2XuCV2c+r/npdt1DTlLyWlDcmdxJ/iOOBJfM0TZqVViOBf39xseR72zaPg5EQNPG8YR6XXZp816XSDVBKHoHaNKOecFb1Y4xlPtEgyzLtcIoY4Ro0EsLacB5ck2+tocblfUOQe3x3/i0l1kYbbcYpxUpy8mFBrGylwnaBVFYgsw9EyHKaz3qQO29/FEa28iLsl3PvF0PdBPMW0afz9zPbS5BbtNt+3mAzA5WaMVoU0ra6Yp6ySjK0qZ4rXFxj3LrxO6cCJpVhS7YZnpH0rPJ1+kHR9hT342MXWrj7d5ZvvXB+IKdDuldsuR3/YmqqS3v8jrIm1Vbn0IvW0b8JzkQJXoVun/7x5qd1Pg==
x-ms-exchange-antispam-messagedata: 17HJsqsoaPIf7Nf6EqiIHTrEZC1LKdBY7OriGN0NnLl54SwANnyfNk8TtoQrGe1p3ukUr/0gxepVZ9rhVgVfdRhtFQ64zcYdQyrbLSe+qCsl14R4H/hc8IHw5jm21SxLtrZKXr/n5oXjVxtPvHlecRbPIlIs0vN/mLpQg8peU+4MRQrmtyE83AcQ3NYleouYYzzfX0YzLT5b2s4Xkm5XNg==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <748CE06D1F28FB468C86DF2FF95EBBD8@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de6861a-f2fb-45d3-5ea6-08d7d71ca9e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 15:44:00.4380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f/7bAuHDyOzgsZTRPq+vIdUHfRzsZRJYaUka1is7jRjACsDxzeMrj3m6KsLOHj+DJYunj72F8aBKWwOlWq8RgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4376
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Apr 2, 2020, at 8:30 AM, Sean Christopherson <sean.j.christopherson@in=
tel.com> wrote:
>=20
> On Thu, Apr 02, 2020 at 02:33:00PM +0200, Thomas Gleixner wrote:
>> Without at least minimal handling for split lock detection induced #AC, =
VMX
>> will just run into the same problem as the VMWare hypervisor, which was
>> reported by Kenneth.
>>=20
>> It will inject the #AC blindly into the guest whether the guest is prepa=
red
>> or not.
>>=20
>> Add the minimal required handling for it:
>>=20
>>  - Check guest state whether CR0.AM is enabled and EFLAGS.AC is set.  If
>>    so, then the #AC originated from CPL3 and the guest has is prepared t=
o
>>    handle it. In this case it does not matter whether the #AC is due to =
a
>>    split lock or a regular unaligned check.
>>=20
>> - Invoke a minimal split lock detection handler. If the host SLD mode is
>>   sld_warn, then handle it in the same way as user space handling works:
>>   Emit a warning, disable SLD and mark the current task with TIF_SLD.
>>   With that resume the guest without injecting #AC.
>>=20
>>   If the host mode is sld_fatal or sld_off, emit a warning and deliver
>>   the exception to user space which can crash and burn itself.
>>=20
>> Mark the module with MOD_INFO(sld_safe, "Y") so the module loader does n=
ot
>> force SLD off.
>=20
> Some comments below.  But, any objection to taking Xiaoyao's patches that
> do effectively the same things, minus the MOD_INFO()?  I'll repost them i=
n
> reply to this thread.

IIUC they also deal with emulated split-lock accesses in the host, during
instruction emulation [1]. This seems also to be required, although I am no=
t
sure the approach that he took once emulation encounters a split-lock is
robust.

[1] https://lore.kernel.org/lkml/20200324151859.31068-5-xiaoyao.li@intel.co=
m/=
