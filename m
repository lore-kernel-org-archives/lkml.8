Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46BAC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 13:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D278206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 13:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="gS6G16eN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgHRNkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 09:40:35 -0400
Received: from mga02.intel.com ([134.134.136.20]:4672 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726745AbgHRNkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 09:40:18 -0400
IronPort-SDR: xNV67h9hnD5J5f0FtSCOVceNGl4u4aGlBNw7MkHsi6L7Uwd7e9hQN5kPDBh7OHykvLIncuw/pL
 Vka8aKRtQgdQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="142725160"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="142725160"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 06:40:16 -0700
IronPort-SDR: UgXDrvJVKVWvycTndws5MRm0DzqMqqriRQ6Dj2xtxCEQXjTrtpkhKo+rY+Y7JW1gnPbN7Tkrlp
 tQ3oQVIGFa5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="326730895"
Received: from unknown (HELO fmsmsx604.amr.corp.intel.com) ([10.18.84.214])
  by orsmga008.jf.intel.com with ESMTP; 18 Aug 2020 06:40:15 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 18 Aug 2020 06:40:15 -0700
Received: from fmsmsx158.amr.corp.intel.com (10.18.116.75) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 18 Aug 2020 06:40:15 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx158.amr.corp.intel.com (10.18.116.75) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 18 Aug 2020 06:40:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 18 Aug 2020 06:40:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpMuQwoehgu/ZAf8mh8tTPG8lalMKJiowrB8hsQPFDGS7AhN93eF7NSqXlvq9R8L3S6v5qnYTBjtr7N/os6a92X/ZcNOcYe04mIZReO2OpnLrgHtjzgUTNMuWJHvYgkcB+mwTFzgiSIwT+JhuqIQZJvYJln5pw/ST3UKMT+rGUtKwy8RYmxO+8n97mZ9TkP1qjwnkY+dmdnRZ4toEL5tX7w096g9e8go0V5CvVtiobEzHTmUmEFoNvizrgURSP3rq7INmVlIQWXDvUd3OCSv3JF0a3+CZ9MUSK5TypqGOUzzo+JgWhX61LtE9As3+BLtdL+dHBsTzz82FEH++Bo6cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vsHZ3+4PY/ATkS+mZ5tHgKhz2Lq6SgHTcUs2BxZsfk=;
 b=NCKPUl6chVsBcWgsg/C8Q+fJ7cz1vPvKaA7fKen8dOl4CGykY7LdGzvtQDRot77JZfrwmReEz9O4lqrZJcLx8bQ0fHnpj5MihGfUJx9kZclZnCS3PXy3OjYUIX2WNLg6K7ES9/FyQG1PgekRSySa367DT2FsAW9m3CqNJlGy+A5Pw6br6Tk69gJKDXGRirFooL1wBpNjC7Bz7XcRI/oCM3sTr6A0yxP/+JymR9h8O5Hkh49pAV52EJQOp+zWWWu4wP0rGafGL5Po1w4dlATFseveAvgFa0X4tOahStu49AaTJoxr43q2NcSQVDOh6tL+xTDPtHrRNI4fQGa0pPDIyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vsHZ3+4PY/ATkS+mZ5tHgKhz2Lq6SgHTcUs2BxZsfk=;
 b=gS6G16eNJ1CNwLu+b7u9OtFwc0Bb5efr35RZg4U1/Q5XxYTZG3Z2pfGuMHAOg/GewvVJyQrP2y//SPLNKfPIr6RAdfjrixvuZrYwUGItqD4hEMXCHmW8TEAWAbUX7VDi8UcrWOuvhT9L9zRYYn1dDyrH++piDPbOSujfnaJaJGo=
Received: from MWHPR11MB1518.namprd11.prod.outlook.com (2603:10b6:301:c::10)
 by MWHPR11MB1839.namprd11.prod.outlook.com (2603:10b6:300:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.23; Tue, 18 Aug
 2020 13:40:08 +0000
Received: from MWHPR11MB1518.namprd11.prod.outlook.com
 ([fe80::581:de6d:ee8c:ef32]) by MWHPR11MB1518.namprd11.prod.outlook.com
 ([fe80::581:de6d:ee8c:ef32%10]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 13:40:08 +0000
From:   "Shaikh, Azhar" <azhar.shaikh@intel.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "bleung@chromium.org" <bleung@chromium.org>,
        "groeck@chromium.org" <groeck@chromium.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "pmalani@chromium.org" <pmalani@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>,
        "Bowman, Casey G" <casey.g.bowman@intel.com>
Subject: RE: [PATCH v3 1/3] platform/chrome: cros_ec_typec: Send enum values
 to usb_role_switch_set_role()
Thread-Topic: [PATCH v3 1/3] platform/chrome: cros_ec_typec: Send enum values
 to usb_role_switch_set_role()
Thread-Index: AQHWcBbbmTsKeOPuZ0+53e11raUxJ6k96UQAgAAAd/A=
Date:   Tue, 18 Aug 2020 13:40:08 +0000
Message-ID: <MWHPR11MB1518F1055D8031D50E632809915C0@MWHPR11MB1518.namprd11.prod.outlook.com>
References: <20200811193757.45057-1-azhar.shaikh@intel.com>
 <20200811193757.45057-2-azhar.shaikh@intel.com>
 <da604f7b-04d6-5d1b-c794-28d3aee540e3@collabora.com>
In-Reply-To: <da604f7b-04d6-5d1b-c794-28d3aee540e3@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: collabora.com; dkim=none (message not signed)
 header.d=none;collabora.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [71.236.160.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25d13488-c8f6-4dc7-3a7d-08d8437c394e
x-ms-traffictypediagnostic: MWHPR11MB1839:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1839866B4AA02A07E6930612915C0@MWHPR11MB1839.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:605;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZITCYvTxwVGH+YApTWI1lgCF9Lzpg9rQlqAhpW/b2gWH2YvvwFWkx1ukll2CxIKOEMPN32FAGgEBMIeZN+uuI+vsbewrQQsmSP2YrO7RohtqhaVA/gOJCxQ7zZQCF+2GEOGiRLmOZXveOmLlLT3SiwUAqMsUhbAXgG5IQlxdRzHXErL9+gghZrgTyHH9iHqHyeJ84okKMfJCK6uCdnhaWAL+ikfi6gEZq7IoXadjLWBHrdEIa8XF1Ev7rlbHraGMexErFhBPYIBNwBnkaCatTECqbJG5MPj3QGoaBC6X2qaXoXhdM3fxf8bo4ZP1mYUG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1518.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(5660300002)(71200400001)(7696005)(110136005)(186003)(53546011)(9686003)(6506007)(26005)(316002)(8676002)(54906003)(2906002)(55016002)(64756008)(66946007)(478600001)(8936002)(33656002)(83380400001)(66476007)(66556008)(52536014)(66446008)(86362001)(76116006)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: gtblILBDF5iVkf38t/VmOYCTOEbVC+SgoIDdjGz7ZoBWgUNHybGy78Sl/0pdtaJS8FMLkmCYaAsAklZbt5U/xclFo6Aekao5Nu7CvOHVSWVEzHPem3NlZNE2ePl3GutioAK5wcP1yLJ2W13OZL2DwbdqT2eXASGaSXZjBI0UrX3+vM6DEQF4wyUh3OquipSAh39adUbEanGwgC7UiAf0JdZ4oo/ChnYlF37pt3CC+sSXGm2zEsjxH/gAU4zkHHHljTFL4fgUzeefBdPYIVCdZEye/G75Ae8CHusYIeleo8uZC/4FfjC0P1LcAvCFfOLSALqvtUJ/nODbHRViW0O7zYjjD04q+LUnlxxjTavZHVXWTyn+TVerhdw+iJjFK7IWJ10KPCAxIFIe/TEtQtp0fc2bmdymqbwvWg1YsnSyCiky6YikLuiJqyz4SOmHnSof2OlT/zfNh9CPrFdCGQLDFVHKvpnATSKTHKPzjgXV9mD27d/TthCUrFmugl2OGUl296VqXr8M/DCgIbcheni3zxQ+rjU6FlcNYiBpXnaRr9sosOKh6z4TpQotJdcQ4DK2a5S4TR5n9EoxFDthJ77lG9B56rhaHA+/W6bKAJmJYyQ7ZsLpXhMD+bvCI1GEEppmykoIkGBiNQphS4W5Hx5l0Q==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1518.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d13488-c8f6-4dc7-3a7d-08d8437c394e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2020 13:40:08.6050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5EtlbZYStrZhTxoOPLTkw+S1qBU/wv9nanHifENiH5cIZOgqXKbP1zmQcGtAerdjrv8uJvLn6lp7jKV4huweKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1839
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRW5yaWMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRW5yaWMg
QmFsbGV0Ym8gaSBTZXJyYSA8ZW5yaWMuYmFsbGV0Ym9AY29sbGFib3JhLmNvbT4NCj4gU2VudDog
VHVlc2RheSwgQXVndXN0IDE4LCAyMDIwIDY6MzggQU0NCj4gVG86IFNoYWlraCwgQXpoYXIgPGF6
aGFyLnNoYWlraEBpbnRlbC5jb20+OyBibGV1bmdAY2hyb21pdW0ub3JnOw0KPiBncm9lY2tAY2hy
b21pdW0ub3JnOyBoZWlra2kua3JvZ2VydXNAbGludXguaW50ZWwuY29tOw0KPiBwbWFsYW5pQGNo
cm9taXVtLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgTWFuaSwgUmFq
bW9oYW4NCj4gPHJham1vaGFuLm1hbmlAaW50ZWwuY29tPjsgUGF0ZWwsIFV0a2Fyc2ggSCA8dXRr
YXJzaC5oLnBhdGVsQGludGVsLmNvbT47DQo+IEJvd21hbiwgQ2FzZXkgRyA8Y2FzZXkuZy5ib3dt
YW5AaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvM10gcGxhdGZvcm0vY2hy
b21lOiBjcm9zX2VjX3R5cGVjOiBTZW5kIGVudW0NCj4gdmFsdWVzIHRvIHVzYl9yb2xlX3N3aXRj
aF9zZXRfcm9sZSgpDQo+IA0KPiBIaSBBemhhciwNCj4gDQo+IFRoYW5rIHlvdSBmb3IgeW91ciBw
YXRjaC4NCj4gDQo+IE9uIDExLzgvMjAgMjE6MzcsIEF6aGFyIFNoYWlraCB3cm90ZToNCj4gPiB1
c2Jfcm9sZV9zd2l0Y2hfc2V0X3JvbGUoKSBoYXMgdGhlIHNlY29uZCBhcmd1bWVudCBhcyBlbnVt
IGZvcg0KPiB1c2Jfcm9sZS4NCj4gPiBDdXJyZW50bHkgZGVwZW5kaW5nIHVwb24gdGhlIGRhdGEg
cm9sZSBpLmUuIFVGUCgwKSBvciBERlAoMSkgaXMgc2VudC4NCj4gPiBUaGlzIGV2ZW50dWFsbHkg
dHJhbnNsYXRlcyB0byBVU0JfUk9MRV9OT05FIGluIGNhc2Ugb2YgVUZQIGFuZA0KPiA+IFVTQl9S
T0xFX0RFVklDRSBpbiBjYXNlIG9mIERGUC4gQ29ycmVjdCB0aGlzIGJ5IHNlbmRpbmcgY29ycmVj
dCBlbnVtDQo+ID4gdmFsdWVzIGFzIFVTQl9ST0xFX0RFVklDRSBpbiBjYXNlIG9mIFVGUCBhbmQg
VVNCX1JPTEVfSE9TVCBpbiBjYXNlIG9mDQo+ID4gREZQLg0KPiA+DQo+ID4gRml4ZXM6IDdlN2Rl
ZjE1ZmE0YiAoInBsYXRmb3JtL2Nocm9tZTogY3Jvc19lY190eXBlYzogQWRkIFVTQiBtdXgNCj4g
PiBjb250cm9sIikNCj4gPg0KPiANCj4gTm8gZXh0cmEgbGluZSBoZXJlLg0KQWNrDQoNCj4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogQXpoYXIgU2hhaWtoIDxhemhhci5zaGFpa2hAaW50ZWwuY29tPg0K
PiANCj4gRGlkIHRoZSBQcmFzaGFudCByZXZpZXdlZCB0YWcgZGlzYXBwZWFyIGZvciBzb21lIHJl
YXNvbj8gQ2FuIHlvdSByZXNlbmQNCj4gdGhlIHBhdGNoZXMgd2l0aCBhbGwgdGhlIGNvbGxlY3Rl
ZCB0YWdzPyAobG9va3MgbGlrZSB0aGlzIHBhdGNoIGFuZCBvdGhlcnMgZnJvbQ0KPiB0aGlzIHNl
cmllcyBhbHJlYWR5IGhhdmUgYmVlbiByZXZpZXdlZCkNCj4gDQpTb3JyeSBhYm91dCB0aGF0LCB3
aWxsIGFkZCB0aGUgdGFncyBiYWNrLg0KDQo+IFRoYW5rcywNCj4gICBFbnJpYw0KPiANCj4gPiAt
LS0NCj4gPiBDaGFuZ2VzIGluIHYzOg0KPiA+ICAtIE5vIGNoYW5nZXMNCj4gPg0KPiA+IENoYW5n
ZXMgaW4gdjI6DQo+ID4gIC0gVXBkYXRlIHRoZSBjb21taXQgbWVzc2FnZSB0byBjaGFuZ2UgJ1VT
Ql9ST0xFX0hPU1QgaW4gY2FzZSBvZg0KPiA+ICAgICBVRlAuJyAgdG8gJ1VTQl9ST0xFX0hPU1Qg
aW4gY2FzZSBvZiBERlAuJw0KPiA+DQo+ID4gIGRyaXZlcnMvcGxhdGZvcm0vY2hyb21lL2Nyb3Nf
ZWNfdHlwZWMuYyB8IDMgKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRmb3JtL2No
cm9tZS9jcm9zX2VjX3R5cGVjLmMNCj4gPiBiL2RyaXZlcnMvcGxhdGZvcm0vY2hyb21lL2Nyb3Nf
ZWNfdHlwZWMuYw0KPiA+IGluZGV4IDNmY2QyN2VjOWFkOC4uMDYxMDgyMTJlZTk0IDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvcGxhdGZvcm0vY2hyb21lL2Nyb3NfZWNfdHlwZWMuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvcGxhdGZvcm0vY2hyb21lL2Nyb3NfZWNfdHlwZWMuYw0KPiA+IEBAIC01OTEs
NyArNTkxLDggQEAgc3RhdGljIGludCBjcm9zX3R5cGVjX3BvcnRfdXBkYXRlKHN0cnVjdA0KPiBj
cm9zX3R5cGVjX2RhdGEgKnR5cGVjLCBpbnQgcG9ydF9udW0pDQo+ID4gIAkJZGV2X3dhcm4odHlw
ZWMtPmRldiwgIkNvbmZpZ3VyZSBtdXhlcyBmYWlsZWQsIGVyciA9ICVkXG4iLA0KPiByZXQpOw0K
PiA+DQo+ID4gIAlyZXR1cm4gdXNiX3JvbGVfc3dpdGNoX3NldF9yb2xlKHR5cGVjLT5wb3J0c1tw
b3J0X251bV0tDQo+ID5yb2xlX3N3LA0KPiA+IC0JCQkJCSEhKHJlc3Aucm9sZSAmDQo+IFBEX0NU
UkxfUkVTUF9ST0xFX0RBVEEpKTsNCj4gPiArCQkJCSAgICAgICByZXNwLnJvbGUgJiBQRF9DVFJM
X1JFU1BfUk9MRV9EQVRBDQo+ID4gKwkJCQkgICAgICAgPyBVU0JfUk9MRV9IT1NUIDogVVNCX1JP
TEVfREVWSUNFKTsNCj4gPiAgfQ0KPiA+DQo+ID4gIHN0YXRpYyBpbnQgY3Jvc190eXBlY19nZXRf
Y21kX3ZlcnNpb24oc3RydWN0IGNyb3NfdHlwZWNfZGF0YSAqdHlwZWMpDQo+ID4NCg==
