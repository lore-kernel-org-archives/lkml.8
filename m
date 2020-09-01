Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D829C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2619204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="BF2DRL/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbgIAQFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:05:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:48077 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731512AbgIAPlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:41:24 -0400
IronPort-SDR: btrEFABoZMt+53Q0OdXOTQ67DZyZ2cg5iKgSLRC8MjU6LI5Jir62yfU7P+aymwTncwW4Fl4k0x
 APicClWvqLpw==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="154701690"
X-IronPort-AV: E=Sophos;i="5.76,379,1592895600"; 
   d="scan'208";a="154701690"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 08:41:19 -0700
IronPort-SDR: yeg5q/Jd/yN1skTEGYu5ABEMR/A16CdguYp+Vm9zWZzYBjJBIwPKJNDjQc2PAv1KJIMiDME8TE
 Ezd3ZnP/AYNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,379,1592895600"; 
   d="scan'208";a="446179747"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 01 Sep 2020 08:41:16 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 1 Sep 2020 08:41:15 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 1 Sep 2020 08:41:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 1 Sep 2020 08:41:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgw1e6ckrqrElH0QjhFoTPrcgi9HQFdiAhxClzm78wbIfd+jON4lseNnjkyjFbxILd4UTHs9K5+gHREbQY9o0Vab/1qN2bGK6K8at/8n6MSCw9FQsG7zK8MruBSqIzjjZ2VoXPdZEky00nkQ8thkb40T1IwwdfocygUXp6MUlSSp2pMOFFtmGR7Tm/E5WNiKBGJu0Z5+3M1FcO+gEhm4NsWODk3qI9a4RfGQsjwTnRSRj149SlPRCjaCBtwIYpLVvBb9ew5YOrcCO78iV5O6cS+B2bM22nBessjQlrEIobtm0t1n2nH9PFM6mynLL5uRsGz+nA1NFg7wNFaLkeKX5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ea/jw4YReQfoSAZ4JVfb7MNsW93wWwEdknMMx8Khod0=;
 b=Exa11nDAKJSixwk+MO8yATrmJv6bK+VnOAVpLX33r0Xg5RVdMsiy/XyhuOE07wJ14/cFjzubqQ56+L6UM/DEODuuTKgfjDU0sAOY8/O9P2aJogmhsgLAE206VdyHqqhPaQ9GUg1tpQA4/AjZ+9GZL2cc/680vau7hj/miBdgBcdCywkFQUsa6xV8wdqLWYyJHrhoYiOVydqJNMu54vOmVEfeskzp4r3ANvvp3LZQ0YdU0nHN9x9VF4RmaPAibDZSZhJuf/KWfp/gU1PheNoACdVLvEAHifmYm8Wg4yXAzHgpteSU1Fi4cra6ps+oNCR8G1Q6spWmmSIw17kXnZHcxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ea/jw4YReQfoSAZ4JVfb7MNsW93wWwEdknMMx8Khod0=;
 b=BF2DRL/gx6mDpwPfDDoA3Rvy9x845HDL5W3O9qLWkIps0v4QUltEWQJmOFvGUzIzxpzTylEBFAsZeU0i0gCFWaQMrG5tyUU3yR6qM/0HCdV9gU9y65Z6E1OLLfyPkq1J+3Vs/cp2M2edOUpHRLGqLy/POjU26EMg97N/htSPwJY=
Received: from MWHPR11MB1518.namprd11.prod.outlook.com (2603:10b6:301:c::10)
 by MWHPR11MB1615.namprd11.prod.outlook.com (2603:10b6:301:c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 1 Sep
 2020 15:41:12 +0000
Received: from MWHPR11MB1518.namprd11.prod.outlook.com
 ([fe80::581:de6d:ee8c:ef32]) by MWHPR11MB1518.namprd11.prod.outlook.com
 ([fe80::581:de6d:ee8c:ef32%10]) with mapi id 15.20.3348.015; Tue, 1 Sep 2020
 15:41:12 +0000
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
Subject: RE: [PATCH v5 0/3] TypeC Connector Class driver improvements
Thread-Topic: [PATCH v5 0/3] TypeC Connector Class driver improvements
Thread-Index: AQHWeASOXwG1EL0WtUei6D1S2qUYialTjnyAgABuDOA=
Date:   Tue, 1 Sep 2020 15:41:11 +0000
Message-ID: <MWHPR11MB1518B748A3712AB0B31329F8912E0@MWHPR11MB1518.namprd11.prod.outlook.com>
References: <20200821214724.20056-1-azhar.shaikh@intel.com>
 <94a80152-a5d5-79d9-dfee-b7ea0ba20ad4@collabora.com>
In-Reply-To: <94a80152-a5d5-79d9-dfee-b7ea0ba20ad4@collabora.com>
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
x-ms-office365-filtering-correlation-id: ba30a790-0dcd-4a7e-7d33-08d84e8d7460
x-ms-traffictypediagnostic: MWHPR11MB1615:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB16155338B42A5FFEE0BAC5F2912E0@MWHPR11MB1615.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:773;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9N722iMYpsxISZhET8DD/pinNjr2/7U5aMx2pFE4uu3oCFA36N9mIHDUrnqUjML20r2huUaZDZgi/oFUejKRERcuV2ogMELprBXy/7X7d86sVPfpWYlfvkcxgS/7ynX+MUUSTM6BwSVVlPp5Q9KZwjgRmXGp219X3S15YkvxWd3o2ZMSJs2wDUl+yjqCtUZx+zyBF74ZcDNvDj0HYXtqXrJstZR8q06U3IjsqtR4EIw3N2+wM5wpjVsISP3ggbRuWlISAQaFWw0DvwAmtgQisdXnBgd8CiZ7VCiRaTeLeh0yXYtYyre1LYMgW64sw+WViE2UdkTt4wdK90knvEZVyvMbF/GGhJD+nCJT/OkKv2SjvdSthO+zT47XdyYO19FoboTZ2J3WxXtcJYrn+20Z9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1518.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(110136005)(54906003)(316002)(7696005)(76116006)(55016002)(53546011)(6506007)(83380400001)(2906002)(966005)(26005)(9686003)(66476007)(186003)(33656002)(8676002)(4326008)(8936002)(5660300002)(66446008)(86362001)(66946007)(64756008)(66556008)(478600001)(52536014)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: BiKaHv241lFOUbCDUcwXWxsQPDgxFvEDOXt+BH5IiEA3DGQxP/R2sWcRQgJvalpKPg5C0GSUre13SOxT/UVs6uTE9rD9CoQADrEoMC2V3QfVUlD/O9MLCg9W5SyOI8/tjswuTm7JtDHYm49gYKvM6FgNRLxaIBwLQM2PvtoFjZ5EzUyguQL0k60/WTJS3+ptTzHOS9tpfbq/LOugRp3qaXz0BhhaVlWoMnmYb7tZYLIb/iFKRhqk4PHZSml83gCfm+O2zRs6RFxwrcgc7Hb+1FygqHn2IlvsLIOwaPzGnwJARgTV8ODnqBU3n04PKnXyTXlMytYPfAtEubZFo6GtLQSPdI532LiMp6JauqubcKI1uuciTTH5fmtTA78/MjqCGm08hPm5tJ9YUEHPWN2/Sq3e/gjP9QRvu60tixowsbCuHordRGIr9y23LaryUnWtSECuft2zgtyxQpz7qOranYwfw8ahIcmDVagH7LhaWJuLx/sjWe8pMzbTu2RsTgHlZ76zRjz6s2GNeYwsChJQgUYEgxQjrXZTdwJtU5ftX6JxjmOIh3KCj8r/pZG9b5MAIKhHOzcysnNf++kfafMqTcDArCHICnJsxTTx2AseEz1Vk5IJom6DBkZnCnW65Qb+PaT2NDZc/C/VZFU2WXqyug==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1518.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba30a790-0dcd-4a7e-7d33-08d84e8d7460
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2020 15:41:12.0082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WYiodMFXarlhivjV1KaZoqsvP0HiqQcID3+o9lHjaxRJxqhNLU4m8WLIUTDm+6jkQfRX+EswdfLS9HrdwxDX9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1615
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmsgeW91IEVucmljIQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IEVucmljIEJhbGxldGJvIGkgU2VycmEgPGVucmljLmJhbGxldGJvQGNvbGxhYm9yYS5jb20+DQo+
IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAxLCAyMDIwIDI6MDcgQU0NCj4gVG86IFNoYWlraCwg
QXpoYXIgPGF6aGFyLnNoYWlraEBpbnRlbC5jb20+OyBibGV1bmdAY2hyb21pdW0ub3JnOw0KPiBn
cm9lY2tAY2hyb21pdW0ub3JnOyBoZWlra2kua3JvZ2VydXNAbGludXguaW50ZWwuY29tOw0KPiBw
bWFsYW5pQGNocm9taXVtLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
TWFuaSwgUmFqbW9oYW4NCj4gPHJham1vaGFuLm1hbmlAaW50ZWwuY29tPjsgUGF0ZWwsIFV0a2Fy
c2ggSCA8dXRrYXJzaC5oLnBhdGVsQGludGVsLmNvbT47DQo+IEJvd21hbiwgQ2FzZXkgRyA8Y2Fz
ZXkuZy5ib3dtYW5AaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDAvM10gVHlw
ZUMgQ29ubmVjdG9yIENsYXNzIGRyaXZlciBpbXByb3ZlbWVudHMNCj4gDQo+IEhpIEF6aGFyLA0K
PiANCj4gT24gMjEvOC8yMCAyMzo0NywgQXpoYXIgU2hhaWtoIHdyb3RlOg0KPiA+IENoYW5nZXMg
aW4gdjU6DQo+ID4NCj4gPiAqIFBhdGNoIDE6ICJwbGF0Zm9ybS9jaHJvbWU6IGNyb3NfZWNfdHlw
ZWM6IFNlbmQgZW51bSB2YWx1ZXMgdG8NCj4gPiAgICAgICAgICAgICB1c2Jfcm9sZV9zd2l0Y2hf
c2V0X3JvbGUoKSINCj4gPiAgIC0gUmViYXNlZCBvbiB0b3Agb2YgaHR0cHM6Ly9sa21sLm9yZy9s
a21sLzIwMjAvNy8xMC8xMDYzDQo+ID4NCj4gPiAqIFBhdGNoIDI6ICJwbGF0Zm9ybS9jaHJvbWU6
IGNyb3NfZWNfdHlwZWM6IEF2b2lkIHNldHRpbmcgdXNiIHJvbGUgdHdpY2UNCj4gPiAgICAgICAg
ICAgICBkdXJpbmcgZGlzY29ubmVjdCINCj4gPiAgIC0gUmViYXNlZCBvbiB0b3Agb2YgaHR0cHM6
Ly9sa21sLm9yZy9sa21sLzIwMjAvNy8xMC8xMDYzDQo+ID4gICAtIEFkZGVkIFJldmlld2VkLWJ5
IGZyb20gdjQNCj4gPg0KPiA+ICogUGF0Y2ggMzogInBsYXRmb3JtL2Nocm9tZTogY3Jvc19lY190
eXBlYzogUmUtb3JkZXIgY29ubmVjdG9yDQo+ID4gICAgICAgICAgICAgY29uZmlndXJhdGlvbiBz
dGVwcyINCj4gPiAgIC0gUmViYXNlZCBvbiB0b3Agb2YgaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIw
MjAvNy8xMC8xMDYzDQo+ID4gICAtIEFkZGVkIFJldmlld2VkLWJ5IGZyb20gdjQNCj4gPg0KPiA+
IENoYW5nZXMgaW4gdjQ6DQo+ID4gKiBQYXRjaCAxOiAicGxhdGZvcm0vY2hyb21lOiBjcm9zX2Vj
X3R5cGVjOiBTZW5kIGVudW0gdmFsdWVzIHRvDQo+ID4gICAgICAgICAgICAgdXNiX3JvbGVfc3dp
dGNoX3NldF9yb2xlKCkiDQo+ID4gICAtIFJlbW92ZSBleHRyYSBsaW5lIGJldHdlZW4gRml4ZXMg
YW5kIFNpZ25lZC1vZmYgdGFnLg0KPiA+ICAgLSBBZGRlZCBSZXZpZXdlZC1ieSBhbmQgQ2MgdGFn
cyBmcm9tIHYxIGFuZCB2Mi4NCj4gPg0KPiA+ICogUGF0Y2ggMjogInBsYXRmb3JtL2Nocm9tZTog
Y3Jvc19lY190eXBlYzogQXZvaWQgc2V0dGluZyB1c2Igcm9sZSB0d2ljZQ0KPiA+ICAgICAgICAg
ICAgIGR1cmluZyBkaXNjb25uZWN0Ig0KPiA+ICAgLSBBZGRlZCBTdWdnZXN0ZWQtYnkgZnJvbSB2
Mi4NCj4gPg0KPiA+ICogUGF0Y2ggMzogInBsYXRmb3JtL2Nocm9tZTogY3Jvc19lY190eXBlYzog
UmUtb3JkZXIgY29ubmVjdG9yDQo+ID4gICAgICAgICAgICAgY29uZmlndXJhdGlvbiBzdGVwcyIN
Cj4gPiAgIC0gTm8gY2hhbmdlDQo+ID4NCj4gPiBDaGFuZ2VzIGluIHYzOg0KPiA+ICogUGF0Y2gg
MTogInBsYXRmb3JtL2Nocm9tZTogY3Jvc19lY190eXBlYzogU2VuZCBlbnVtIHZhbHVlcyB0bw0K
PiA+ICAgICAgICAgICAgIHVzYl9yb2xlX3N3aXRjaF9zZXRfcm9sZSgpIg0KPiA+ICAtIE5vIGNo
YW5nZQ0KPiA+DQo+ID4gKiBQYXRjaCAyOiAicGxhdGZvcm0vY2hyb21lOiBjcm9zX2VjX3R5cGVj
OiBBdm9pZCBzZXR0aW5nIHVzYiByb2xlIHR3aWNlDQo+ID4gICAgICAgICAgICAgZHVyaW5nIGRp
c2Nvbm5lY3QiDQo+ID4gIC0gTW92ZSB0aGUgbG9jYXRpb24gb2YgY2FsbGluZyB1c2Jfcm9sZV9z
d2l0Y2hfc2V0X3JvbGUoKSB0bw0KPiA+ICAgIGVuZCBvZiBmdW5jdGlvbiBpbiBjcm9zX3R5cGVj
X2NvbmZpZ3VyZV9tdXgoKSB0byBhdm9pZCBhbnkgY2hhbmdlDQo+ID4gICAgaW4gY29kZSBmbG93
Lg0KPiA+DQo+ID4gKiBQYXRjaCAzOiAicGxhdGZvcm0vY2hyb21lOiBjcm9zX2VjX3R5cGVjOiBS
ZS1vcmRlciBjb25uZWN0b3INCj4gPiAgICAgICAgICAgICBjb25maWd1cmF0aW9uIHN0ZXBzIg0K
PiA+ICAtIE5ldyBwYXRjaCBhZGRlZA0KPiA+DQo+ID4gQ2hhbmdlcyBpbiB2MjoNCj4gPiAqIFBh
dGNoIDE6ICJwbGF0Zm9ybS9jaHJvbWU6IGNyb3NfZWNfdHlwZWM6IFNlbmQgZW51bSB2YWx1ZXMg
dG8NCj4gPiAgICAgICAgICAgICB1c2Jfcm9sZV9zd2l0Y2hfc2V0X3JvbGUoKSINCj4gPiAgIC0g
VXBkYXRlIHRoZSBjb21taXQgbWVzc2FnZSB0byBjaGFuZ2UgJ1VTQl9ST0xFX0hPU1QgaW4gY2Fz
ZSBvZg0KPiA+ICAgICBVRlAuJyAgdG8gJ1VTQl9ST0xFX0hPU1QgaW4gY2FzZSBvZiBERlAuJw0K
PiA+DQo+ID4gKiBQYXRjaCAyOiAicGxhdGZvcm0vY2hyb21lOiBjcm9zX2VjX3R5cGVjOiBBdm9p
ZCBzZXR0aW5nIHVzYiByb2xlIHR3aWNlDQo+ID4gICAgICAgICAgICAgZHVyaW5nIGRpc2Nvbm5l
Y3QiDQo+ID4gICAtIE5ldyBwYXRjaCBhZGRlZC4NCj4gPg0KPiA+IEF6aGFyIFNoYWlraCAoMyk6
DQo+ID4gICBwbGF0Zm9ybS9jaHJvbWU6IGNyb3NfZWNfdHlwZWM6IFNlbmQgZW51bSB2YWx1ZXMg
dG8NCj4gPiAgICAgdXNiX3JvbGVfc3dpdGNoX3NldF9yb2xlKCkNCj4gPiAgIHBsYXRmb3JtL2No
cm9tZTogY3Jvc19lY190eXBlYzogQXZvaWQgc2V0dGluZyB1c2Igcm9sZSB0d2ljZSBkdXJpbmcN
Cj4gPiAgICAgZGlzY29ubmVjdA0KPiA+ICAgcGxhdGZvcm0vY2hyb21lOiBjcm9zX2VjX3R5cGVj
OiBSZS1vcmRlciBjb25uZWN0b3IgY29uZmlndXJhdGlvbiBzdGVwcw0KPiA+DQo+ID4gIGRyaXZl
cnMvcGxhdGZvcm0vY2hyb21lL2Nyb3NfZWNfdHlwZWMuYyB8IDkgKysrKysrKy0tDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gDQo+
IA0KPiBUaGUgdGhyZWUgcGF0Y2hlcyBvZiB0aGlzIHNlcmllcyBoYXZlIGJlZW4gcXVldWVkIGZv
ciA1LjEwLg0KPiANCj4gVGhhbmtzLA0KPiAgRW5yaWMNCg==
