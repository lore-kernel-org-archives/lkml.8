Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6144FC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 21:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33260207CD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 21:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="itnoQ8Tt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgHUVqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:46:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:45583 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgHUVqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 17:46:49 -0400
IronPort-SDR: RrWd3yksRbcGz8ppRe8XZkCme6EbUZMXi60brHfbWUlPjKIXd7vvULEwMPDolBkXpviaV3izXA
 xOf5x6CDTMJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9720"; a="153051842"
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="153051842"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 14:46:48 -0700
IronPort-SDR: 5s+//9EVGKULGg3VsA7er3WDONJiJ0bpUSc9y75ZV52ENCcJ3LbmQ5l+stpyzZLW38RvBF9WPA
 v954bjGj5nmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="401583587"
Received: from fmsmsx602-2.cps.intel.com (HELO fmsmsx602.amr.corp.intel.com) ([10.18.84.212])
  by fmsmga001.fm.intel.com with ESMTP; 21 Aug 2020 14:46:48 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 21 Aug 2020 14:46:48 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 21 Aug 2020 14:46:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 21 Aug 2020 14:46:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaLiBgsEf1Xx/07yIu/tScCDsDBm+xcyJLK4aehMjn+e+JJx1fjnEZ3EtO8t60w80PhgAZj34+ei37PLRXctcpB5eF2OEs5M09qmXeeQKDuO3x2Lwt2xrC9I3udpqNKF8Sogd4KV16+YvOYAqILyw+IKRqDFpzspCQJyqiIUE60Wm1SIqUdUSYVJhWk7odIISHQC9YM4A/WMN0w2WS66mv7e5DgRrNRg1n1Plcgl13gVVBiy7fRxELxpZ1aWkH9LW9kjcTIvI9oUWUVa1NzvtVu5xNyXsZuCOuO9xf14H7rZHIPacJd7ucEk7/3oV1AuvzH67jl7y7BDcF0iApQ/+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvNOA85b8bLdWkLzFnmuI1wfPF81NY+x3XRdwATzboM=;
 b=EB229S5Kj53Z1Sr6fyWQUptz2zshTvfHsSIdX/68vIsxS1v4VDlpbaHQkCxxvJxzdDpnj2VcISzio8fmbGTyecZxHqBunB42w2t0ofx3WWkOqW1dZK4s92un/setsMzX+P+kvm9DeApS5ayvlvZXz0IC8zZXahEsZ4TGA9IlaVRe4P2v8o7LBi9N0Nmg7L6fdsaTFqOKsi8tSxzQabBLC/+TEqDt7bMc9XpztQNCDBSAhfjmLzGEd0H160vZMzJgp+XL5v74sc/PsaNdypk0Zsn4lllV2eXmogbMwsjhAd+ngiX0aGB+uEfyXxu/ezXlrBm1mPqPcDniCV6qygiivw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvNOA85b8bLdWkLzFnmuI1wfPF81NY+x3XRdwATzboM=;
 b=itnoQ8Ttl4rPgHAnKJxrqKys1sJ+zm40yu+wCcr0PAahS8B8XMly1afTwMdL8ygUTHQ5HlMtztSoDocBQqtONvSR3KfHRhzhazNwg9sMhqO9xSl0zl3NS94N76SFgtp2HrEuFY8uI7OS/Nk75soX4E/pyxVDATeXNP9V5Zl16j4=
Received: from BY5PR11MB4056.namprd11.prod.outlook.com (2603:10b6:a03:18c::17)
 by BY5PR11MB4338.namprd11.prod.outlook.com (2603:10b6:a03:1c8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 21 Aug
 2020 21:46:46 +0000
Received: from BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::b8cb:b59f:8cbb:75a7]) by BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::b8cb:b59f:8cbb:75a7%6]) with mapi id 15.20.3283.027; Fri, 21 Aug 2020
 21:46:46 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Kyle Huey <me@kylehuey.com>
CC:     Robert O'Callahan <rocallahan@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
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
Thread-Index: AQHWd3V5K8M4bUeg6Em80I1SKO69L6lC/t2AgAAXcYCAAAPmAA==
Date:   Fri, 21 Aug 2020 21:46:46 +0000
Message-ID: <6758DBF1-D707-45B3-BA10-3621674DEBF8@intel.com>
References: <CAP045Aq8+h6Y6t7W2GR_jJER5ghaHTH0wP81V-iYHxrR0Lk2vw@mail.gmail.com>
 <29FD0DDA-3093-46A3-BCF4-85DEC229E30D@intel.com>
 <CAP045AqiT75B9o5OV+SJT8uTzo7A55Y1BxjNcaSuxtm5EoAxaQ@mail.gmail.com>
In-Reply-To: <CAP045AqiT75B9o5OV+SJT8uTzo7A55Y1BxjNcaSuxtm5EoAxaQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.1)
authentication-results: kylehuey.com; dkim=none (message not signed)
 header.d=none;kylehuey.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 421d940e-2e59-4a51-6531-08d8461bb3a7
x-ms-traffictypediagnostic: BY5PR11MB4338:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB43388A9880CD782C1243CA1DD85B0@BY5PR11MB4338.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YYeFUq3xsLhlrlm4WmNnN+dhGUfvBtFRdiGMIuKa++ogXYdUG3JiGZYQ6q0vZvY11RxgpvkmkPJtRHyCFkktySC2XsQv/9Zojz4EZAnsAkb6S7pX9jFS75XW2UIJYTP8H9fnbuor8fyVft2pG77fq29L9qTAI62CSlw02GTqkKUz5mwO8TmNaz0zRNEbJ0iac7WNe78YkARRNYCo3oVwsVFZVzMTY6krhB9xlVu8qX/4I8xchfUufhH76YOzvgxd12IAERWCLDUvWdVlqEgILG3myL3cviiKbq1HhxqzP6iLiopB5n5rMbhK7RQd22UhgZ9Sdc5PXNpHvQlWtJy1kw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4056.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(71200400001)(8936002)(36756003)(8676002)(54906003)(6916009)(478600001)(33656002)(4326008)(86362001)(4744005)(53546011)(6506007)(5660300002)(66446008)(186003)(76116006)(2616005)(26005)(6486002)(6512007)(316002)(64756008)(66946007)(2906002)(66556008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: CB/CAYQxOjrIFk1eaz6QkTyOBXikDUnxzipEEWsvvaxc4OeA6+71gqAJYZQF3ziMueZwVrpJhv8+KQ2KI3Fu/+LPfhIz51Zh46+2l+gm0l1TiqgZdrO1DOGtVfErlUkRqN5pxfhs4tqU9+bPQhFTK66IhxQxj44sN76DlEwNzQBAYIWTClZutcVgSy6huDSmNlNdhco1wcIo0GbxiotxXb6vgHpKsuTEez1rqaFC0iawXDn9QLtenRim5zVLoA6Mk0wU0roo09hhh3kTO4x4xl41pVUovPatsZBB6rk8QcYOKrGbpmp4wKQWDaASlZDw78DmWzXws6QSfMFW3dkI71MckYGRfDDs/10tngqxdRWwEfZ5CooFIkBsoelk1gS16KuELTKMFhG3qG2XtPeT0BaoginmvaDBo2zrm/EcIvc4JD8g0HlMIOykFRi5RL4rX8axfhT0Ntu9hBq9msLi44/atXiwL+Co+d+moWSA/Zw0SeK+wFBQ5WxSGig/y0q2yCohjyySd07sa0uOBkV4YL4hE0S3aXJRCYWhcZSDlbLSFFrb5PPkkKFlm8vJXptEpnc/KtnzVkKk0XzWeEsPuWiQNY8LzsyOsStUtQAOd1VQ9dqD+xcrUdDJkRIR5Uvbia3LPF81Vr0SAkvnCZs91A==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A3EE2BF901EDA34EADD737F16E347AA2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4056.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 421d940e-2e59-4a51-6531-08d8461bb3a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2020 21:46:46.4169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoe1/5eaNNSwr35SqwHlrxQLQCULrSuSJbcTx3UA4z3WV9H+O/yGph0/rDl/YIH4yzxN9dlQ9HwPdMtyz5cXtixetRLpbo8YVhSgPrX2tqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4338
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Aug 21, 2020, at 14:32, Kyle Huey <me@kylehuey.com> wrote:
>=20
> 40c45904f818c1f6555294ca27afc5fda4f09e68 added magic for a 32 bit
> tracer tracing a 32 bit tracee on a 64 bit kernel, but it looks like a
> 64 bit tracer tracing a 32 bit tracee on a 64 bit kernel *is* now
> expected to preserve the fs/gsbase values (or die, in our case).
>=20
> Is that correct?

Correct.

Thanks,
Chang
