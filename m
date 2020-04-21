Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB1BC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF0A8206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="ljK8Pg2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgDURPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 13:15:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:54347 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbgDURPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 13:15:37 -0400
IronPort-SDR: eVDJAzK1UR7RnPNTb/qFe61uxefJ6/7J+/k1p8xleSUr/nmnVNlX9FaCnvf0ISLFCGI2U/yw7D
 Qcl/baPHS25Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 10:15:37 -0700
IronPort-SDR: EJUNZim+4nPNU9ome3pGAeDT1A6iDsg+LY5MkKANkDKnCDy4zVO299RSIuOOKYfuRnunCKFB38
 Jw3O7jp2pLmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,411,1580803200"; 
   d="scan'208";a="402256159"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga004.jf.intel.com with ESMTP; 21 Apr 2020 10:15:37 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 21 Apr 2020 10:15:36 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 21 Apr 2020 10:15:36 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 21 Apr 2020 10:15:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 21 Apr 2020 10:15:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8qF97F71OaKYj0sRMxDHgVbYGRvVNaMRayt91tg09nyEJlzWXneDo9Yk9b3Xjdv4+JDRfyqdie/DVDaLbISvaH6+L614RkJhQrq5GtsFG0VNgTn2Dm0qK95Rgpv1h6/j6OJ2GS1QHjToeqBufxyAx3klI1UPRblZqrOxgy6Z19FVUBdU4jXbnycMHv7TQPtbtKnt2XzJkeK/eND0Xwb5bX4FIjVyZVE4yfysMQO5RlpyNkLEFmMwe/52J2DIrF2i0kuf944pei1ARZtaoXw5W7AQA3aLnMpK4JHqTou/YXEF5OvifRoI0hR4eEr7OE5Q+I3N4MhQYC+hDgU8AT2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUU2ydLHL1oSHfiabpSGVix+pK4RL3Qm79hgqTi7Ndk=;
 b=demCc2QRhUBdGfz+asVO/MUlSu95qsCk3k+lZEOGN6xMWqqXJXLqMRHkraxwkVsBX1FQ58luFLJO2N810jyyunY0niRbszuYP5DhbwmCrKMcw0vVIyBABvZBowNyXAcGTDV5noOW0g9D+Y5pVUEEFsFV8MsYjlPmF1tcjuX/KepiP0A2mSRNZYPiEmRv4PeoDNPu71KjyawxKBUa/tr5PBTLZ8HW/o5ANOsTc8JcwJLRy67FqawQvr4KSgD1KdgX7I5VDXRhG3y/Z038NqSLKbgyTziTRtxrDUT1FRSQxChY5FJ1zWUpnxFCH5GrHl3tWXLUENHKvKxjONPPdvd7lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUU2ydLHL1oSHfiabpSGVix+pK4RL3Qm79hgqTi7Ndk=;
 b=ljK8Pg2OK3IfCZBKFSXyJCM/0dljcDjOqDBQd7GYfn/iNNoPQ2F39xYgJMZqMLFAO0OON244DOthn+bUC9ApybSFaXC89KY5cE/DXcnRbibsiBESMl8+udeVWFuQ1qnYJaB7KbKXkchh42Yz6HSYBe2MBvFTfYSTJ9DevshCPmU=
Received: from BY5PR11MB4056.namprd11.prod.outlook.com (2603:10b6:a03:18c::17)
 by BY5PR11MB4305.namprd11.prod.outlook.com (2603:10b6:a03:1bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 17:15:34 +0000
Received: from BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::34fb:3d67:65f8:d0b3]) by BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::34fb:3d67:65f8:d0b3%2]) with mapi id 15.20.2921.030; Tue, 21 Apr 2020
 17:15:34 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Sasha Levin <sashal@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Pedro Alves <palves@redhat.com>,
        Simon Marchi <simark@simark.ca>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 00/17] Enable FSGSBASE instructions
Thread-Topic: [PATCH v9 00/17] Enable FSGSBASE instructions
Thread-Index: AQHVet/uukAR+D18mEydsD8sMzHMMqeNNAKAgAAL8ACAFbkggIAAIFiAgAQpEQCAA+z5AICAuHaAgEy/kQCAAEsDgIAFkHGAgAAnmwCABJtmAIAAMrEAgAF/OACAABNVgA==
Date:   Tue, 21 Apr 2020 17:15:34 +0000
Message-ID: <4764C01A-D225-46FF-A9AF-BAA9CD3EB41C@intel.com>
References: <CALCETrXc=-k3fQyxjBok0npjTMr6-Ho7+pkvzDUdG=b52Qz=9g@mail.gmail.com>
 <A78C989F6D9628469189715575E55B236B508C1A@IRSMSX104.ger.corp.intel.com>
 <CALCETrWb9jvwOPuupet4n5=JytbS-x37bnn=THniv_d8cNvf_Q@mail.gmail.com>
 <29FD6626-4347-4B79-A027-52E44C7FDE55@intel.com>
 <20200413200336.GA11216@sasha-vm>
 <20200414003205.GF397326@tassilo.jf.intel.com>
 <20200417133021.GT1068@sasha-vm>
 <CALCETrW6LLmFR5Y6tmH=nPThCHefysf_nNwxHOFp4tAY4Spunw@mail.gmail.com>
 <20200420141320.GC608746@tassilo.jf.intel.com>
 <87y2qqaxkp.fsf@nanos.tec.linutronix.de> <20200421160622.GJ1809@sasha-vm>
In-Reply-To: <20200421160622.GJ1809@sasha-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chang.seok.bae@intel.com; 
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32b95397-c78c-4e6d-ab1e-08d7e6179a4d
x-ms-traffictypediagnostic: BY5PR11MB4305:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB43054B1DFBFAE128EE5AB11BD8D50@BY5PR11MB4305.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 038002787A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4056.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(136003)(346002)(396003)(376002)(39860400002)(366004)(5660300002)(966005)(53546011)(81156014)(6506007)(26005)(71200400001)(2616005)(6916009)(36756003)(8676002)(8936002)(316002)(4326008)(6512007)(76116006)(6486002)(66446008)(64756008)(66556008)(66476007)(66946007)(2906002)(478600001)(86362001)(54906003)(33656002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CvIvzwMzOF7SU2XIS8Stg9DDX6WUaNxzKlWdjB+9wV3YYqwZcC/Jv45bO9ebbg4BX4Bj4SEq7ozCc1CeXXLgni2oE1JQ8Tpm9A48nAw+GF0QlrCYNTa4U5RMT/ilVV+Yn4h49HyKfDwCjoZV1vzEbsh0102BS4Rd35ZZsqt/WVnsIe1VMYhrv3vWQtmLdIBxx1hOdmREb5+8owG9A/amWZFsOP0WkHygxUt5ghC1l297UUghg5Ch3apqDO8YNeOXT0YJEBmeFtdi9TFog1CgBFZhMtwI/B+CPYTQ6o4BBOc7nvl4gVNS//BB6qp7haP3sbLKQ5TlgGOaE4B/QdH51ebH2bSsGXJ+Bd6osfmgvBXITcn8ZQZVeJpdEXoeb7nb4heNvro4MQcQcts1ImjUzJUrJQJlWjSac6lWsp+WBjoBVswjuCpXRXq+hWFmt6Q7fA8OgRgkdhezwVZQ7P9/dc2qhQw6iC3zPH6+rAI/5ZSpzyvO9eBl7hpENKYMwK3O9twFfhEok3jgULYg6tBtVg==
x-ms-exchange-antispam-messagedata: GH/tIg9Fbp26phA/xmUzdEknkq2sc/Yv1LmWEPBIUmjlR9zOD9HiN7A+pAxvzaW4gChrxT7jXHXNvjuSns9aQ+uivCHjJZK5WklAawF6yO9qoCqUEHD3lxuwFS9/1d+J5iOA3HNUZrcp83KcCGyeFkDCBsXPbu83SZclKU/DelF7KssYaGCYOiRoSE2dReQWGcyjUUB8IhlFqEMMVoos8wfwgRAd/diJ/gY4tKlsfY5BiyW7O0pydY/kIxRuO44PvVipH+HmnJ//Fqftvkct4suJGt217rINMkvvowqyLc82V8yMqyc5XEkFrY+ScwllvbNcNIeR4MdVu4SDOu49x60cULZx6WUm1JYiVFeHKe/mwcUeJFgSXyusbOJmVs5CzBU/E1fsiL9HkxoC967xWFyYzpAZngyg9UDgcv9VQEWHv3Pi2IfzprY5LvAsVTuA1JB6CFW8n5BcMYnBDgRrKRJCP2AlA/JMiHtLeGTSybukao/ySTp4kB4Ur4wyzN2VumsBt86Tl4ag9C/o/JNv4HQuQ9veWPCWr5ze2m+PNSC3ecAyHXG1S/jRo0sVAsmalSZp9gKIv2Aed6GiFDd8osavBRH4GZbW8J6Pbr6Xyq+L7Y0QSE4bgryY2XrARoPbhBOu2uy/wEGa5xXorT6VHJ3T/Wcq3iVOeaw7B1SZ0SeuDn9NOyZ//PJOnvCxNh8JCb3LTP8AEytHkdJLEqVF6S1mU0o08tiZUA39os3YB3E0VbE9DRrVuWcZCED8zQVTi8FZ6owzZwwRqnvcYVtlLtI4mUrRh1/qB1ORBg7FXh0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D0E9B576BAEAF4E89C90CA9D41C99D1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b95397-c78c-4e6d-ab1e-08d7e6179a4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2020 17:15:34.1683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D5e1OARdnOXib7QvkcKlr3aNanwMt+RhbLHmGeYFKgHeWAqePizS1yZCs7uJQmFW44FmGlr5P5Q599EC3UCzHpFOzMXFVT9urpGM66GNn5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4305
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIEFwciAyMSwgMjAyMCwgYXQgMDk6MDYsIFNhc2hhIExldmluIDxzYXNoYWxAa2VybmVs
Lm9yZz4gd3JvdGU6DQo+IA0KPiBBbmRpJ3MgcG9pbnQgaXMgdGhhdCB0aGVyZSBpcyBubyBrbm93
biB1c2VyIGl0IGJyZWFrcywgYW5kIHRoZSBJbnRlbA0KPiBmb2xrcyBkaWQgc29tZSBkaWdnaW5n
IGludG8gcG90ZW50aWFsIHVzZXJzIHdobyBtaWdodCBiZSBhZmZlY3RlZCBieQ0KPiB0aGlzLCBp
bmNsdWRpbmcgJ3JyJyBicm91Z2h0IHVwIGJ5IEFuZHksIGFuZCBjb25jbHVkZWQgdGhhdCB0aGVy
ZSB3b24ndA0KPiBiZSBicmVha2FnZSBhcyBhIHJlc3VsdCBvZiB0aGlzIHBhdGNoc2V0Og0KDQpG
V0lXLCB3ZSBzdXJ2ZXllZCB0b29scyBsaWtlIHJyIGFuZCBDUklVIGJlZm9yZS4gVGhlaXIgY29t
bWVudHMgYXJlIFsqLCoqXToNCg0KICAgIkFueXdheSBJIHRoaW5rIHJyIHdpbGwgYmUgZmluZSB3
aXRoIHRoZSBuZXcgYmVoYXZpb3IuIE91ciBtb2RpZmljYXRpb25zDQogICAgdG8gZnMvZ3MvZnNf
YmFzZS9nc19iYXNlIGFyZSBhbHdheXMgZWl0aGVyIGEpIHNldHRpbmcgdmFsdWVzIHRoYXQgdGhl
DQogICAga2VybmVsIHNldCBkdXJpbmcgcmVjb3JkaW5nIHRvIG1ha2UgdGhlbSBoYXBwZW4gZHVy
aW5nIHJlcGxheSBvciBiKQ0KICAgIGVtdWxhdGluZyBQVFJBQ0VfU0VUX1JFR1MgdGhhdCBhIHRy
YWNlZSBwdHJhY2VyIHRyaWVkIHRvIHNldCBvbiBhbm90aGVyDQogICAgdHJhY2VlLiBFaXRoZXIg
d2F5IEkgdGhpbmsgdGhlIGVmZmVjdHMgYXJlIGdvaW5nIHRvIGJlIHRoZSBzYW1lIGFzIHdoYXQN
CiAgICB3b3VsZCBoYXBwZW4gaWYgdGhlIHByb2dyYW0gd2VyZSBydW4gd2l0aG91dCByci7igJ0N
Cg0KICAgIkludGVybmFsbHkgaW4gY3JpdSB3ZSBmZXRjaCB0aGUgcmVnc2V0IHZpYSBwdHJhY2Ug
YW5kIGtlZXAgdGhlbSBpbg0KICAgIGltYWdlcyBhcyB0aGV5IHdlcmUgYXQgbW9tZW50IG9mIGR1
bXAgKGlmIGxkdCBpcyBiZWluZyB1c2VkIHdlIGRvbid0DQogICAgc3VwcG9ydCBzdWNoIHRhc2tz
KSBzbyBJIHRoaW5rIHRoZSBjaGFuZ2VzIHNob3VsZCBub3QgYnJlYWsgY3JpdS4iDQoNCldoYXQg
d2UgdG9vayBhd2F5IHdhcyB0aGF0IHRob3NlIHRvb2xzIHJlYWN0aXZlbHkgZm9sbG93IHRoZSB1
bmRlcmx5aW5nDQprZXJuZWwncyBiZWhhdmlvcjsgc28sIHRoZXkgc2hvdWxkIGJlIGZpbmUgd2l0
aCB0aGUgRlNHU0JBU0UtYnJvdWdodCBuZXcNCmJlaGF2aW9ycy4NCg0KWypdIGh0dHBzOi8vbWFp
bC5tb3ppbGxhLm9yZy9waXBlcm1haWwvcnItZGV2LzIwMTgtTWFyY2gvMDAwNjE1Lmh0bWwNClsq
Kl0gaHR0cHM6Ly9saXN0cy5vcGVudnoub3JnL3BpcGVybWFpbC9jcml1LzIwMTgtTWFyY2gvMDQw
NjU0Lmh0bWwNCg0KVGhhbmtzLA0KQ2hhbmc=
