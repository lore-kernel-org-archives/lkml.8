Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CFFC3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0FA246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="SzTkesbD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbgB1Ako (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:40:44 -0500
Received: from mga12.intel.com ([192.55.52.136]:36526 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730223AbgB1Akn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:40:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 16:40:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,493,1574150400"; 
   d="scan'208";a="272440280"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga002.fm.intel.com with ESMTP; 27 Feb 2020 16:40:42 -0800
Received: from orsmsx115.amr.corp.intel.com (10.22.240.11) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 27 Feb 2020 16:40:42 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX115.amr.corp.intel.com (10.22.240.11) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 27 Feb 2020 16:40:42 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 27 Feb 2020 16:40:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cr23ZKw/4/ha3kjQIDyVRE0FcAV6OzgyAsR4uimm9esmCwq7rYmcFJzB36zXdAWX4GvjMc3L0elWd7LQylRw/ioZHUDZoMnxasVVAiKe1mWwEuEQ4KUwLpWsvbqB44fhZjfWVjTTHGgydJop9URfAd3F2EmZjKm7CPbsXEKzjuP9IFTF5+qXYlBB5fHHELBLd6y4wcxqZrmQQbyXSdzOgBl1VeidoTIkAiqNahHWiHWLtigfa/LsOJTHwuIg7TBSZjCuib7exB3O64/T+7oVPaL+LytRi3tks9lv3D3ouFc3YDydBiJOo+Iw/UIZ74aViuxHpf3/PUlFT0Pmnl/O/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03nybOm8RuaKNx8OI8BKeB74lZGL2KUUamnFE/O/K8E=;
 b=e5TVBLoy/ScPrDvMFjHHsYEt2CtbsZ9v6L8KnN0NwcYVJFQxhY+jE+F4RYmfoGnVD9sGY1vxmcTmgEI9tk88ZjWcQkmrjDV301aY4pOUykyJ4nsw9cQLlo3BQfzB71eA5d7gv8QUH+899nOGgdSBuQ9w/A8lMDivG+WkJgrmWzMo3zMY0Uvh2YzEi7pgXC3Q9yF88MXNXjxHypKK6yBPTgJNMrlZgxDqcbGqH2VHekB5NTfCTrqwjWbdagJQJJ2AEm+y1SI2w8M0KskkVsK3rc4cpVOZjPR2C1S6pauIlWY4Mds4fcyehazqIyD+FrniLlSuOZ6e4XkkOMBmvO+G/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03nybOm8RuaKNx8OI8BKeB74lZGL2KUUamnFE/O/K8E=;
 b=SzTkesbDcsJkrmWbcthZvvpDZt0XnOHryw2SUiuedsrDl7lxdpOP1OlWzOGOS9qwFTENrhHXKC+kiBz6rIxFUTJY+v8aTiGodECifyhO3XAfRbDGQZ8A7RJVXBpEiyf//lQ6B/qicdtzLnRrxDbHP/T12MywvSEih88ZSIXqK6s=
Received: from MN2PR11MB4509.namprd11.prod.outlook.com (2603:10b6:208:192::26)
 by MN2PR11MB3982.namprd11.prod.outlook.com (2603:10b6:208:13b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.16; Fri, 28 Feb
 2020 00:40:38 +0000
Received: from MN2PR11MB4509.namprd11.prod.outlook.com
 ([fe80::b53e:ca00:fb6e:4070]) by MN2PR11MB4509.namprd11.prod.outlook.com
 ([fe80::b53e:ca00:fb6e:4070%5]) with mapi id 15.20.2772.012; Fri, 28 Feb 2020
 00:40:37 +0000
From:   "Tan, Ley Foon" <ley.foon.tan@intel.com>
To:     Dinh Nguyen <dinguyen@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "See, Chin Liang" <chin.liang.see@intel.com>,
        "lftan.linux@gmail.com" <lftan.linux@gmail.com>
Subject: RE: [PATCH] arm64: dts: socfpga: agilex: Fix gmac compatible
Thread-Topic: [PATCH] arm64: dts: socfpga: agilex: Fix gmac compatible
Thread-Index: AQHV7Ux0UImxBVnTS0WSovlH54EGYqgvH3aAgAClQyA=
Date:   Fri, 28 Feb 2020 00:40:37 +0000
Message-ID: <MN2PR11MB4509EAC73D6A9D5EA9C34862CCE80@MN2PR11MB4509.namprd11.prod.outlook.com>
References: <20200226183518.64673-1-ley.foon.tan@intel.com>
 <b2747826-8685-37ab-4a12-939d3ea7ee94@kernel.org>
In-Reply-To: <b2747826-8685-37ab-4a12-939d3ea7ee94@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMWVjMWE3NzQtNWI4NS00ZDJkLWJkZGQtMmU5MTIyZDNhODAyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSGhpcVRPY1lpeDlaMVR0SUxsRjlVMUpvbzJnSzRYWU4zdGREMWVPY0I5amRwbFJ4cFhhbFlsQWVpenFNRnM3aiJ9
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ley.foon.tan@intel.com; 
x-originating-ip: [192.198.147.215]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 788a0b7c-b499-4293-c918-08d7bbe6d488
x-ms-traffictypediagnostic: MN2PR11MB3982:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3982D20B517FFF185596BD97CCE80@MN2PR11MB3982.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(366004)(136003)(346002)(199004)(189003)(2906002)(478600001)(9686003)(55016002)(8676002)(4326008)(81166006)(8936002)(81156014)(7696005)(6916009)(76116006)(66446008)(66476007)(66556008)(66946007)(86362001)(64756008)(6506007)(316002)(54906003)(53546011)(71200400001)(186003)(26005)(33656002)(52536014)(5660300002)(4744005);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR11MB3982;H:MN2PR11MB4509.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8eMQtMPVxkkAJVlwh+VPZs5YPzX6W74RcAvzI09wPGaieZyNuEhQGe/goWrdQaayz6GbQkBiUt+6MECZAXjr08yTrGFyfcgQk8URCiZgyUEy1h7/8+h7pnNWAKSjlgJIfS2LevUN/UzuNvTWbd/+1v/918LrSL13wdQSeZK2R5Ue23+SGDzTRBcXcEs/6Vu1WHwxRelU5ZSj0mcNXQGoo/nEU8pM/OEKzrHHYQqgK56VHOvCmI8rxYq4RuER2l9CcYar1tbOW6xGUF7P0qEyZIKkDdxXYGXe7c4E4WmXs49u1VohnkPA5F97Kh11DxcZQACBg33+My29UKnLpt2LCiTc/L1ksNMk41uYi1KRP+YvB+2wue/zwWMXC81n3mUa+7ti3LaZIEzhHJeSYX7JNqNmNlxtPKPRF/B0Md4dZIbWYhZUljfk83ID8+qlRcSa
x-ms-exchange-antispam-messagedata: IJ4QVDRTm0nn6VVtJIydjArByDVpDZJWF5qpd8jH0z8Qjh8zvNg+zRdJYRwROhAKAgLCIfb+CwhF5hnRwBjthfVG48G2KW5IjeilHsHOeKPTBMcF3U+WuLKHXegR9/Nj5/uXIcpyJaYf3QVQcVMLKw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 788a0b7c-b499-4293-c918-08d7bbe6d488
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 00:40:37.4133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p62ZXTBfDW2hhd5eWSufNso7QRmOE6Ao65Po27HGW7l188lSPX3N8ypyQtk61rNORyKb2lj67eCKhUjuRHT2aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3982
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGluaCBOZ3V5ZW4gPGRp
bmd1eWVuQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSAyNywgMjAyMCAx
MDo0OSBQTQ0KPiBUbzogVGFuLCBMZXkgRm9vbiA8bGV5LmZvb24udGFuQGludGVsLmNvbT4NCj4g
Q2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFNlZSwgQ2hpbiBMaWFuZw0KPiA8Y2hp
bi5saWFuZy5zZWVAaW50ZWwuY29tPjsgbGZ0YW4ubGludXhAZ21haWwuY29tDQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0hdIGFybTY0OiBkdHM6IHNvY2ZwZ2E6IGFnaWxleDogRml4IGdtYWMgY29tcGF0
aWJsZQ0KPiANCj4gSGkgTGV5IEZvb24sDQo+IA0KPiBUaGFua3MgZm9yIGNhdGNoaW5nIHRoaXMu
IENhbiB5b3UgcmVzZW5kIHdpdGggdGhlIEZpeGVzIHRhZyBhbmQgY2MgdGhlIHN0YWJsZQ0KPiBt
YWlsaW5nIGxpc3QgdG8gZ2V0IHRoaXMgYmFja3BvcnRlZCB0byB0aGUgc3RhYmxlIGtlcm5lbHMu
DQo+IA0KPiBUaGFua3MsDQo+IERpbmgNCg0KT2theS4NCg==
