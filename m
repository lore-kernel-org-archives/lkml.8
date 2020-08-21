Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210DFC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 20:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE0E920748
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 20:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="vFmo67nA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgHUUJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 16:09:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:43725 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgHUUJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 16:09:00 -0400
IronPort-SDR: Bz8uLQTqP8GW4WdIxwndjsS2KY1bA7l0jXj4hU7Wufz7tbmvk+VZCAk/e7aR7DwlheiQZFrfIE
 oDwhjJP0REPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9720"; a="173659967"
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="173659967"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 13:08:58 -0700
IronPort-SDR: nxzhOp7TGVOsSfS2yM4Wz73SqQjVpVUkzMs4S2jTXyYgLJG1Pp4CkVUxsySkq2xYNBEgxRgOb9
 TwQJAuY7vAWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="442455675"
Received: from unknown (HELO fmsmsx604.amr.corp.intel.com) ([10.18.84.214])
  by orsmga004.jf.intel.com with ESMTP; 21 Aug 2020 13:08:57 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 21 Aug 2020 13:08:56 -0700
Received: from fmsmsx103.amr.corp.intel.com (10.18.124.201) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 21 Aug 2020 13:08:56 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 21 Aug 2020 13:08:56 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 21 Aug 2020 13:08:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEBtmFFNJ/ykVSM9A5NGdvNR0IQ2Ixp7HLWIgTEWhbUwWiLkNWHNOGFNnMsKk9QJJiHvQIOdfUIvNjeL7zmkHvE09LyVUV5QNbKvZ5oZOhq1Wwn0rZ6bZJwKEVvrCuQPGLtRKlnP74rc/RPqvJh2JuB1UWXHhe8+VHFFEaBU0CJbXZ38e+rHSvpYI8KrQocqUJPGP6jdSkojCpjgCt1aokGoirEvRO/WydyMJRTUPjDYMtvf/w3Qk8bxKlG0TpwIP1NIo9r5Az56OlzEmVdI7FHSeWYujH9ijOi1z6xVy9gGy4zTHUm+bJqnP/lrEpTLOgf9UDSmnYxx3H+QRLWoPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtr+xAkVAh9YddknJ26eApRBymSoB+ttHIUfbdyPU1o=;
 b=NNN0a+hxI++F/9/AL54wHaYoNKIC7du0jOXRiptSKldncznfO92qm5gDCDFdtxfZaF+3Y+1nmedRTs5+WELyzWRCOB7bkzTpu6/zJ7w5x4ziDBjKuIe5N6yxYHVMLYcaF4jSrYSHSvMO0MvFVIiLcLLF7O8mkZO/fcvI3fdZL4lzB6jYXkKR8HpoHwl9oqOBL6SCApjTNtsPB4A3l01+YgyStuimhXMsopyrhB+uELTlqVSbH2MYGUeEfTGNOk1ay/ePkvlCOK46mbPnYxGQun7rcgVepXKPEcY649emm9Bxh9P0kVw3hEhm6Pf5KUgjJHkl4QyWx+Nk96sxZlmh5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtr+xAkVAh9YddknJ26eApRBymSoB+ttHIUfbdyPU1o=;
 b=vFmo67nA2pbY1licoKzcC9RY/rYHH+ZO5QXqah4P6s/raVtcFBCsZZ6KFFITJy866cyI9AhMfjZQWExQ+0ccdlWBUKdOdZbiXyM7yTJABgq3Kwm5w/XxWp3biSaVmrS77EB130MPeYz5JAHYEFVv21wGWnGd8Cx832MKozzamL0=
Received: from BY5PR11MB4056.namprd11.prod.outlook.com (2603:10b6:a03:18c::17)
 by BYAPR11MB2613.namprd11.prod.outlook.com (2603:10b6:a02:cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Fri, 21 Aug
 2020 20:08:55 +0000
Received: from BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::b8cb:b59f:8cbb:75a7]) by BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::b8cb:b59f:8cbb:75a7%6]) with mapi id 15.20.3283.027; Fri, 21 Aug 2020
 20:08:55 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Kyle Huey <me@kylehuey.com>,
        Robert O'Callahan <rocallahan@gmail.com>
CC:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [REGRESSION] x86/cpu fsgsbase breaks TLS in 32 bit rr tracees on
 a 64 bit system
Thread-Topic: [REGRESSION] x86/cpu fsgsbase breaks TLS in 32 bit rr tracees on
 a 64 bit system
Thread-Index: AQHWd3V5K8M4bUeg6Em80I1SKO69L6lC/t2A
Date:   Fri, 21 Aug 2020 20:08:54 +0000
Message-ID: <29FD0DDA-3093-46A3-BCF4-85DEC229E30D@intel.com>
References: <CAP045Aq8+h6Y6t7W2GR_jJER5ghaHTH0wP81V-iYHxrR0Lk2vw@mail.gmail.com>
In-Reply-To: <CAP045Aq8+h6Y6t7W2GR_jJER5ghaHTH0wP81V-iYHxrR0Lk2vw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.1)
authentication-results: kylehuey.com; dkim=none (message not signed)
 header.d=none;kylehuey.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6dae102-49a0-4a04-9980-08d8460e0817
x-ms-traffictypediagnostic: BYAPR11MB2613:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2613E011E1E8F716CC028092D85B0@BYAPR11MB2613.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9cvShJFTGFsXtTZyehgNRlsTwF2zzHnmzNHHtgguahy1g9qEkuMdIusuJrs5Wr12DbdWlowJB4CNIFsz+nUqj5eixINs0u0TgAlSSbOIeexNHoOIy74uJy4QPD0rh2QHZjZuKWp73h2wSgK4F77EusXYJASiogDUthzHDuv/L15Pac+L84chNziDEp1FuKz5+AIJ/BmSQrKSI9wIOo7TvdckbT90P9rHdDTYOVS14sd3kWugP3cPV+GpAQYT1rVMd0+NTplAqhw+nUc2fCDnbSkc7rKJ9OIV4bSmeBr0pTqE6tNa1VVVNTUL2i+o95bpXyTpzdR2MIooYxHbL6t1EJX6kfk5I5KetBHY13DvjX/4NIr8Kmlu4KO9ofTIf9IZf3pGH7QYAGunczsc1C/skQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4056.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(478600001)(110136005)(6506007)(186003)(316002)(66556008)(36756003)(86362001)(64756008)(54906003)(6486002)(5660300002)(53546011)(76116006)(66946007)(6512007)(66476007)(83380400001)(66446008)(8936002)(33656002)(966005)(71200400001)(2616005)(26005)(8676002)(4326008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 3CjrOR+PRGz+ATSiArkQtrkqobfGxxLQK8ZxFt/6YnzW7tXN2Du1fkArvCQPm4hsVZ42f2sB6b6wVtSXLLgYLnSH/ogtSFcvL3Gi76Ira+2Yq71IMyye1qDtesfrjSnSwQ5vsdpgSs/kQbCpA+6ob7kRdprMqofpOtxDE7/7Nk+htRK7lWeMg4h608Y8opuPCnlz46D36NvluzTQt513gwe+cupwh2bpThLayKsTt0FrxHZ5YGsduEnIzSJPTEof0CoXgrWZCuCYgDtbF005i4LOSqTosETkFMZCuHgnH6xdfEOvYwcqnRi0FFpdfyoXsaTJ8KbbXf85TV7ZETBJkI5ZXU1N9t3Y5TPFZNce95MuKVrQk2ieibssVObfDTf8uU7fQeUBJaUJQzyHdl6p1wQm2czuNjVXgctIM4bhjDxk8pTnVIB9Ewfg3xF5HQhRUal9OhTQduIJBNeHrVclrH0h/Jx9hEft/9d5khaEQycyvlxzr3JWKpDVMN6FBq2SZJjot+mcx3j99tw27ig5IlimbkAw9Q6lkQsZqnayHgL/vjaLs/vkj4XlykrVhEzVgJAmtMlK6mzufqAU+18UYSQLuzJopODOHb4MaLjJmRc5ePdX/TJNfkrFdsSGLlB7ac4tCweUXfHpqHQ0ZrzFXA==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <395123A85D5DAD419CC345E57D6E34A0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4056.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6dae102-49a0-4a04-9980-08d8460e0817
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2020 20:08:54.9847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XCh4GKODkaRJ76nb4triUYQs5LE2X/R9PYXzdp9H09dJmwDihsEwapb5Byt4883lfd5h0t4hX55voVQpYjKn94qSOfLwxzWuSSU0clpNqC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2613
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Aug 20, 2020, at 21:41, Kyle Huey <me@kylehuey.com> wrote:
>=20
> On the x86-64 5.9-rc1 TLS is completely broken in 32 bit tracees when
> running under rr[0]. Booting the kernel with `nofsgsbase` fixes it and
> I bisected to https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git/commit/?h=3Dv5.8&id=3D673903495c85137791d5820d690229efe09c8f7b.
>=20
> STR:
> 1. Build rr from source by
>  a. git clone https://github.com/mozilla/rr
>  b. mkdir rr/obj
>  c. cd rr/obj
>  d. cmake ..
>  e. make -j16
> 2. Run the simple 32 bit tracee outside of rr with `./bin/simple_32`.
> It should print a message and exit cleanly.
> 3. Run it under rr with `./bin/rr ./bin/simple_32`.
>=20
> It should behave the same way, but with fsgsbase enabled it will
> segfault. The `simple_32` binary is a simple "hello world" type
> program but it does link to pthreads, so pre-main code attempts to
> access TLS variables.
>=20
> The interplay between 32 bit and 64 bit TLS is dark magic to me
> unfortunately so this is all the useful information I have.

As I run it and collect the ptrace logs, it starts to set FSBASE with
some numbers, e.g. 140632147826496, and then later attempts to set GS
with 99 through putreg(), not putreg32().

With FSGSBASE, the FS/GS base is decoupled from the selector. Andy
made putreg32() to retain the old behavior, fetching FS/GS base
according to the index, but the putreg() does not do. So, rr probably
relies on the old behavior as observed to setting the GS index only.
But it was previously considered to be okay with this comment [1]:

   "Our modifications to fs/gs/fs_base/gs_base are always either a)
    setting values that the kernel set during recording to make them
    happen during replay or b) emulating PTRACE_SET_REGS that a tracee
    ptracer tried to set on another tracee. Either way I think the
    effects are going to be the same as what would happen if the
    program were run without rr."

It is not straightforward to go into the rr internal to me. Robert,=20
any thought?

[1] https://mail.mozilla.org/pipermail/rr-dev/2018-March/000615.html

> - Kyle
>=20
> [0] https://rr-project.org/



