Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E99C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9BF20767
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="eBIPzQBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgCTRft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:35:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:36534 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgCTRft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 13:35:49 -0400
IronPort-SDR: X0R5gOlw7j8jQ2EG0BTNQ8hCG9EixxqlCTXqNFbLQy5lefFDgPfdHEcvrtL8fxC9V0sZFye6rU
 JBcYdudbiDrg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 10:35:48 -0700
IronPort-SDR: HZosXjaFqS/OzCKaxO824qfmj31wFShGMP2GUK4lvhk0q/7bGRMU0F77/vwZSeVlJezv4wVx7Q
 GlKWGJK4Zbgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,285,1580803200"; 
   d="scan'208";a="446721571"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga006.fm.intel.com with ESMTP; 20 Mar 2020 10:35:48 -0700
Received: from fmsmsx117.amr.corp.intel.com (10.18.116.17) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 20 Mar 2020 10:34:23 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx117.amr.corp.intel.com (10.18.116.17) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 20 Mar 2020 10:34:23 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 20 Mar 2020 10:34:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TckLHqIxryc4sFbL14G3r2mX8u/680N9MQOA7XoBrpI7HGZeIaL0uhVUo3K9pPnZIFgrvQm+a+ErKec7ZPhPm9uqxXtXs24mQSlbk4uqxsYLDo4QokYq4Vd+h/DcvGFVKM/xi4Bsl/Pu/LpFhqHi5JxidUluVLUdYyrWuGZP2qgMtbx9pazTpYOuUyOOUFHs59PvqG+C9FlTsR1Z/1MSaXEmFikkc19ILxuL01QQkn3CfqEWHCksdaEiVV/psRIWgINb8Dy4TZqYNiO+/P3d14v7j+bEARyr9jebcsjTNXId4UmGY1XgIgVtWA63yCxqLG8pgRXvewRD42uqJbY/Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUwPX1QlUHZGRNKutmY5NjMXmUS50qsbxq9+Yn7aKCg=;
 b=nx4LrmzHx58DQPcf6BfQvAbr+fl7FnpvMaAuyKMaApPVQjqaOeHG67EyWcTzri8gta5ESq9OGFbGbYTxYujZakq4nLmEjkGPOoHt/4uK0jFtaSmRElv4zIToVSOtsUAuZcCKQ0zZ+zgasu6gN3S8l4oaWo/AlnX3vRsU2PZxM6Ueaz2N4/6f3MNMFkYtejxl0AzUruveyvl3g4UNFuHxqjyYJwxyHCX3nGPM0xo3mALu++Srwug1ZrDXeAMxs5V5DoTSU/kiAQydL0cNR9fjHQDaFjrF00qIcY7qfrRWHNqf7c1scAc+g4lGzkDsFZikemtdLVAfTQ5Pdxnt4Io5Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUwPX1QlUHZGRNKutmY5NjMXmUS50qsbxq9+Yn7aKCg=;
 b=eBIPzQBAHnL1LA8v+MqLMeXWnZgHv9+Dc9FeG4A12CKpy3KGMCss4cMBSGYgKrGVZgqSWtAsssDu+50fhoXcET5VgCiRSupw9hswLipBS/gWUeitmlwh5Dl1EvyuHeNq0HowNfkQleaWc2edNJf0SqQgVmAIdhrj8mE+qBaH3A4=
Received: from BYAPR11MB3624.namprd11.prod.outlook.com (2603:10b6:a03:b1::33)
 by BYAPR11MB3782.namprd11.prod.outlook.com (2603:10b6:a03:fd::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Fri, 20 Mar
 2020 17:34:21 +0000
Received: from BYAPR11MB3624.namprd11.prod.outlook.com
 ([fe80::d17e:dcc4:4196:87ab]) by BYAPR11MB3624.namprd11.prod.outlook.com
 ([fe80::d17e:dcc4:4196:87ab%7]) with mapi id 15.20.2835.017; Fri, 20 Mar 2020
 17:34:21 +0000
From:   "Kammela, Gayatri" <gayatri.kammela@intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Somayaji, Vishwanath" <vishwanath.somayaji@intel.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "Westerberg, Mika" <mika.westerberg@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Prestopine, Charles D" <charles.d.prestopine@intel.com>,
        Chen Zhou <chenzhou10@huawei.com>,
        "Box, David E" <david.e.box@intel.com>
Subject: RE: [PATCH v3 0/5] platform/x86: intel_pmc_core: Add bug fixes or
 code
Thread-Topic: [PATCH v3 0/5] platform/x86: intel_pmc_core: Add bug fixes or
 code
Thread-Index: AQHV8ArQghD0dS6yzkaNkpM4RGGi9qg1Q1OAgABJMxCAGsE28IAABFsAgAACN3CAAUiFgIAAPOxQ
Date:   Fri, 20 Mar 2020 17:34:21 +0000
Message-ID: <BYAPR11MB362495E980501C91DD6A8C1DF2F50@BYAPR11MB3624.namprd11.prod.outlook.com>
References: <cover.1583093898.git.gayatri.kammela@intel.com>
 <20200302125427.GV1224808@smile.fi.intel.com>
 <BYAPR11MB362421570806431752364CD3F2E70@BYAPR11MB3624.namprd11.prod.outlook.com>
 <BYAPR11MB3624F3CB24817BB8C5AE6C10F2F40@BYAPR11MB3624.namprd11.prod.outlook.com>
 <20200319180618.GN1922688@smile.fi.intel.com>
 <BYAPR11MB3624FFB1B25DD743F473AFFEF2F40@BYAPR11MB3624.namprd11.prod.outlook.com>
 <CAHp75VcnE11pTyB2wPPe596+vRf_B1monV8NDHF_TBuGv9h64Q@mail.gmail.com>
In-Reply-To: <CAHp75VcnE11pTyB2wPPe596+vRf_B1monV8NDHF_TBuGv9h64Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gayatri.kammela@intel.com; 
x-originating-ip: [192.55.52.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5121d170-3cd7-4968-dd2a-08d7ccf4ece0
x-ms-traffictypediagnostic: BYAPR11MB3782:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB378295450C2A13E63E7D3C3AF2F50@BYAPR11MB3782.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 03484C0ABF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(396003)(376002)(366004)(136003)(199004)(66476007)(76116006)(316002)(26005)(2906002)(54906003)(7696005)(64756008)(5660300002)(52536014)(53546011)(6506007)(66556008)(66946007)(186003)(55016002)(33656002)(66446008)(9686003)(4744005)(81156014)(81166006)(8676002)(71200400001)(4326008)(6916009)(478600001)(86362001)(966005)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR11MB3782;H:BYAPR11MB3624.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lvd3JCPj+EJx4TRXkKNnbC5zLgBAKfKVM5qkr9iml1AuruUta22Amec9doLrZg/xOPvbHu910oFhO40nteEBKliRPC8YZ+midtyfDAUoGsmisfCUS0WLn/J9fchuYEXKFQAiepifUZBGcWHHXiAVosR/gnCsyiMsG0T8HmcZoUDtybY1k8ravYcAQP/EG7bENertmogTCiJIcUHPpmccd3M6o65xGOw+izLjXkY0dsyv1U+nHmMsjeZWL5LxHhtqJoaIKkIM7J5Vm3c4E4LM4iTW7Pb9WOu5MfmTEklmRC3WtphiZ5Xnune44MfGj/nKrbZUyRThpt68Y+uk5WGxo+dtNFkPcArfzPpV8PsyzpNhuo+oUHTSEY/wtfJrDo0UU4cReJvdwTfpjd4/fCFUxd4O3Rb351LSiQY5IhBeDgZxmtwccJnUeXuKZ03O/6HDn0oLMZY9BU/o2yJlKu1b6Dabwxae2F5sBv1SJ3Wm2JvPprJhZP/bw3ffxFilCauEuooMdf9MU818eEZ5R1CEyA==
x-ms-exchange-antispam-messagedata: kAoEjD4cGE/Su9mKBzsz3l/4i0Jg2x8mVhVRkd/dWoVKyXJ8VYyBtn7BABkzyTwFHNmsbihm2OPjDTm9Tx5RfsJUoedAYjjmfRfuwP5Lnp+hajrVEbxt0JrGuK4xK6pQPYlAzvQWo6vZzZCOSLCrKA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5121d170-3cd7-4968-dd2a-08d7ccf4ece0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2020 17:34:21.2611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0k+FwbW/H0R2bFN6+P47ICqo+EWK8szFJXtZ3d/KxeurRpRLgJZFMeUXYpa8hxDZmydnlwgXrmR0OUtFS1g+dWUglXKMbCJUbs0J7GbClAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3782
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFu
ZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMjAsIDIwMjAg
Njo1MCBBTQ0KPiBUbzogS2FtbWVsYSwgR2F5YXRyaSA8Z2F5YXRyaS5rYW1tZWxhQGludGVsLmNv
bT4NCj4gQ2M6IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwu
Y29tPjsgcGxhdGZvcm0tDQo+IGRyaXZlci14ODZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBTb21heWFqaSwNCj4gVmlzaHdhbmF0aCA8dmlzaHdhbmF0aC5z
b21heWFqaUBpbnRlbC5jb20+OyBkdmhhcnRAaW5mcmFkZWFkLm9yZzsNCj4gV2VzdGVyYmVyZywg
TWlrYSA8bWlrYS53ZXN0ZXJiZXJnQGludGVsLmNvbT47IHBldGVyekBpbmZyYWRlYWQub3JnOw0K
PiBQcmVzdG9waW5lLCBDaGFybGVzIEQgPGNoYXJsZXMuZC5wcmVzdG9waW5lQGludGVsLmNvbT47
IENoZW4gWmhvdQ0KPiA8Y2hlbnpob3UxMEBodWF3ZWkuY29tPjsgQm94LCBEYXZpZCBFIDxkYXZp
ZC5lLmJveEBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMC81XSBwbGF0Zm9y
bS94ODY6IGludGVsX3BtY19jb3JlOiBBZGQgYnVnIGZpeGVzIG9yDQo+IGNvZGUNCj4gDQo+IE9u
IFRodSwgTWFyIDE5LCAyMDIwIGF0IDg6MTYgUE0gS2FtbWVsYSwgR2F5YXRyaQ0KPiA8Z2F5YXRy
aS5rYW1tZWxhQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiA+IElzIGl0IGluIG15IHJldmll
dyBhbmQgdGVzdGluZyBxdWV1ZT8NCj4gPg0KPiA+IEkgdGhpbmsgaXQgaXMgYXJjaGl2ZWQgYW5k
IHN1cGVyc2VkZWQNCj4gPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExNDE0
Mzc5Lw0KPiANCj4gTm93IGV2ZXJ5dGhpbmcgaW4gZm9yLW5leHQsIGNoZWNrIGlmIHNvbWV0aGlu
ZyBpcyBtaXNzZWQgYW5kIHJlc2VuZC4NClRoYW5rcyBBbmR5ISBJIGp1c3Qgbm90aWNlZCA1dGgg
cGF0Y2ggaW4gdGhpcyB2ZXJzaW9uIGlzIGFjY2VwdGVkIGJ1dCA0dGggaXMgc3RpbGwgc2hvd2lu
ZyBzdXBlcnNlZGVkLiBUbyBhdm9pZCBjb25mdXNpb24sIEkgd2lsbCByZXNlbmQgdGhlIDR0aCBw
YXRjaCBhbG9uZS4NCj4gDQo+IC0tDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNoZXZj
aGVua28NCg==
