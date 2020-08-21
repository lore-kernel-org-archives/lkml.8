Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A435C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10DF42075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="cLFCiRYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgHUNev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:34:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:9054 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbgHUNet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:34:49 -0400
IronPort-SDR: PNUFnS88e3q4lRBm8lWDZLtTVmTk76atqAH194rpyMCR/ZFWNb1q/ssd6k/cPAG5nuBBu+QtLZ
 wkyrVjyeFong==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="152942769"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="152942769"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 06:34:49 -0700
IronPort-SDR: VuqR3cwx47EskhQ2BZ1tMUJuQqJgIUcqY+dYnRuRvHXdUe5E4gGHBXyw3KnjRguniDhMw38m8J
 ZqbUgIkscGGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="321262198"
Received: from orsmsx602-2.jf.intel.com (HELO ORSMSX602.amr.corp.intel.com) ([10.22.229.82])
  by fmsmga004.fm.intel.com with ESMTP; 21 Aug 2020 06:34:48 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 21 Aug 2020 06:34:48 -0700
Received: from orsmsx104.amr.corp.intel.com (10.22.225.131) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 21 Aug 2020 06:34:48 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 21 Aug 2020 06:34:48 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 21 Aug 2020 06:34:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMQWGA97tTvuKPpICQa/KpxiWEyuZ8KdVh/1Nnzs/R68UQV6Qwmdio4pDCvOth3ADXhIXLtvyYg0FF1+3RmcTcPoyUweQoa/tqgyt7Jdm4GXJ8fmsQkZHmXYZ27UXPCblx8fQvK5kegjZlGfCdAzZZydC2zcKm8BawadqkMMW6OpZW+HwXvNZ8JhIWqdP8rM8SfDMdScHJ0ZhBfhN5nIuh+pa5wOUH305UAjC92BvbWdbUggfmyZbMa4/k8kr2vFwXXwe32b+/MoBtsz1VvVVZhgg3tlp+ksGMJgCUr4GUiLVsAowv/kw4PttHYD6OTAOTMItM2P1ysP9dyHLMpxtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpO2jAfqAZHQn/FDsHK/xSX68OzcyJBWfpB5jLtapg8=;
 b=ccHNQoTYxucDn4EMDPoZaA2/pl1Ly/rJJo0dLoNhkqaaz8W69oLZPC120rN/GI3h9P59Qt3AOoprjdEKHBOuXoiIZWaXZybrH6ASTdOW5jNSTUPXbF1s/9tY7Bo8VPTydUJqik/yuO86lT0YlU/ErxUKxnioGr2u+xW/T1QQmdDvznAOPRqIX6Ol7t30nZj9rmuMAlK9FHhdWmwolIIrlxvzj6kOWzKkC5HqDaXs00EZwMolqQAgtZPGZpI7mACZUuqr64xf5ZBPsd550+eIHp+CwS8bKBoeKdyY8vNfAtSCAIPhXvEgeoTWPQO+v5/tUBhINSV5kHpLaCrodRpcfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpO2jAfqAZHQn/FDsHK/xSX68OzcyJBWfpB5jLtapg8=;
 b=cLFCiRYXt44ERd9wdulv0mjfHokrDyCCTXa1zCU2QnfHEIxPgACHZP3c6vHsWFolKi23DLId+svhMTwtwJO3rs6cIrBwheMBIf3DYDo64l+f9Ubc94Y1ky7aMNol27NeEMnQ+Oj1eghjBOQKFiMMMLK5jGLHHhRl6WhJebdMYSs=
Received: from MWHPR11MB1518.namprd11.prod.outlook.com (2603:10b6:301:c::10)
 by MW3PR11MB4585.namprd11.prod.outlook.com (2603:10b6:303:52::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Fri, 21 Aug
 2020 13:34:47 +0000
Received: from MWHPR11MB1518.namprd11.prod.outlook.com
 ([fe80::581:de6d:ee8c:ef32]) by MWHPR11MB1518.namprd11.prod.outlook.com
 ([fe80::581:de6d:ee8c:ef32%10]) with mapi id 15.20.3305.024; Fri, 21 Aug 2020
 13:34:47 +0000
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
Subject: RE: [PATCH v4 0/3] TypeC Connector Class driver improvements
Thread-Topic: [PATCH v4 0/3] TypeC Connector Class driver improvements
Thread-Index: AQHWd0rtdzmV1+crrkuo5aS9b81TralCJnqAgABqa7A=
Date:   Fri, 21 Aug 2020 13:34:46 +0000
Message-ID: <MWHPR11MB1518972F760485B74C8BAB11915B0@MWHPR11MB1518.namprd11.prod.outlook.com>
References: <20200820233833.4551-1-azhar.shaikh@intel.com>
 <5010d4f3-ac59-2a06-051c-83c8a51c3f4b@collabora.com>
In-Reply-To: <5010d4f3-ac59-2a06-051c-83c8a51c3f4b@collabora.com>
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
x-ms-office365-filtering-correlation-id: 763bfa9b-13d4-4906-f726-08d845d6f8b2
x-ms-traffictypediagnostic: MW3PR11MB4585:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4585786FF353421E2C7F5D04915B0@MW3PR11MB4585.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:330;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /L4mcuPPZo290Q0ToB8Buu1EyIEgY0ryXrQHFSpBRqDWeaJJsoBON+x+Y3YoYuEdG4xxkuua8jpPN0ePetxpzq9bnEKjVqzNR1k0rsaLqYpdkfpUh2V2EPWIWeruQPC/fQ9tpY5e/nWs35Ps7sz7+otH3SHF56JqqzwKGh4wuJoEW6W4HG9Ndt4QpJb0Gzuw+/QjJlKVWVJACyGRtUnLJ0SJPYj50vesIY1PZAqs/AAfn0rzmkTJrD9KT027FZcSMSd9RdNOT3Lx15VodelQx/qZGxqDWqk5XbW4y1lWVIesIUVLNHr+cz1KjmQnpFdNIFD9AFxkQ4Qc0154V8xcADgY2UjTo9FI241VFsjsXXOCT9GaUDMaagkhv3T1eFhoBSt0yYboLKO/gG6OqSQ7tQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1518.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(76116006)(54906003)(8676002)(64756008)(52536014)(7696005)(66446008)(110136005)(66476007)(5660300002)(316002)(66946007)(53546011)(6506007)(83380400001)(66556008)(2906002)(9686003)(86362001)(26005)(33656002)(55016002)(186003)(966005)(4326008)(478600001)(8936002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: gWQC/qvDojA5I/M8VdbOfJMLB2zGJEgbR+p+lzueSvxSluiTG3pRJlj+8locGrgHjBtZBjL0iqOo4oF4KTTZI8gWalS0D5XSC7sIK9fmtzx1jDO0Hh9XCA0gFeB4aabzP2BDlLtCji+pWnqYLMyvYsuLc5u36wGnogaglJZz4KrkEmU4afNp27DUIQ2hiEH6lu22mUTttvsrz2yfVyhuxpEHWw9nBelAqq5ziC1+TGSdm+J3+HAVZyh4pMqPTEMSlTsWp9IaXE5FxHxxv6Q1iiUwicnt2sIAYpkWXMHGPqewiF0X/Mh27XGiJ3GjaQSeV1WHyxMQgBJTNqaZQl2zWO1tsTmWYL9a2ysJDg+B2G+iat2eiqinhu/BsTSzkfHrGI4lbjC1re5PPeDqr3EfB/3DYWIr1rHd2R8zExs8lpnUJyUdADEteBVLxE8V25JkXsX58ocN83i4jGtm8O2jx0H3UiM9kcM2aYxc9P3uJv946rtdF3ESa2khrD3CpPZO4MEhcxulFQ9shTQ8RfcUwqXXcXcSf3/uq2LzNsy0Tt8VLBAmTFeyGT7H5XaI41Te8U2bT77TjFIV3LR7tZ/PqUZhx8JOnIAqGM4BvbldIXfYhTbxXs5bmOi83qvLvK9r+hOteapS2p8SM9kcn7WKYQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1518.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763bfa9b-13d4-4906-f726-08d845d6f8b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2020 13:34:46.9721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0x+0Sp4cDK9TngF0HR7B6f4pvWDUx0TbF/3/JSRyqLIYP10QJTSb6Jml5gxKw1YkZf+DhNNKImcgATlbDqS7vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4585
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRW5yaWMsDQoNClN1cmUsIEkgd2lsbCByZWJhc2UsIHRlc3QgYW5kIHVwbG9hZCBhIG5ldyBy
ZXZpc2lvbi4NCg0KUmVnYXJkcywNCkF6aGFyIFNoYWlraA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IEVucmljIEJhbGxldGJvIGkgU2VycmEgPGVucmljLmJhbGxldGJv
QGNvbGxhYm9yYS5jb20+DQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDIxLCAyMDIwIDEyOjEzIEFN
DQo+IFRvOiBTaGFpa2gsIEF6aGFyIDxhemhhci5zaGFpa2hAaW50ZWwuY29tPjsgYmxldW5nQGNo
cm9taXVtLm9yZzsNCj4gZ3JvZWNrQGNocm9taXVtLm9yZzsgaGVpa2tpLmtyb2dlcnVzQGxpbnV4
LmludGVsLmNvbTsNCj4gcG1hbGFuaUBjaHJvbWl1bS5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IE1hbmksIFJham1vaGFuDQo+IDxyYWptb2hhbi5tYW5pQGludGVsLmNv
bT47IFBhdGVsLCBVdGthcnNoIEggPHV0a2Fyc2guaC5wYXRlbEBpbnRlbC5jb20+Ow0KPiBCb3dt
YW4sIENhc2V5IEcgPGNhc2V5LmcuYm93bWFuQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2NCAwLzNdIFR5cGVDIENvbm5lY3RvciBDbGFzcyBkcml2ZXIgaW1wcm92ZW1lbnRzDQo+
IA0KPiBIaSBBemhhciwNCj4gDQo+IEkgZ290IGEgbWVyZ2UgY29uZmxpY3QgYmVjYXVzZSBJIGFw
cGxpZWQgWzFdIGJlZm9yZSB0aGVzZSBwYXRjaGVzLCBmaXggdGhlDQo+IGNvbmZsaWN0IGlzIHRy
aXZpYWwgYnV0LCBhcyBJIGNhbid0IHRlc3QsIGNhbiB5b3UgcmViYXNlIHlvdXIgcGF0Y2hlcyBv
biB0b3Agb2YgWzFdDQo+IGFuZCB0ZXN0IGFuZCByZXNlbmQgdG8gbWFrZSBzdXJlIGV2ZXJ5dGhp
bmcgaXMgd29ya2luZz8NCj4gDQo+IFRoYW5rcywNCj4gIEVucmljDQo+IA0KPiBbMV0gaHR0cHM6
Ly9sa21sLm9yZy9sa21sLzIwMjAvNy8xMC8xMDYzDQo+IA0KPiANCj4gT24gMjEvOC8yMCAxOjM4
LCBBemhhciBTaGFpa2ggd3JvdGU6DQo+ID4gQ2hhbmdlcyBpbiB2NDoNCj4gPiAqIFBhdGNoIDE6
ICJwbGF0Zm9ybS9jaHJvbWU6IGNyb3NfZWNfdHlwZWM6IFNlbmQgZW51bSB2YWx1ZXMgdG8NCj4g
PiAgICAgICAgICAgICB1c2Jfcm9sZV9zd2l0Y2hfc2V0X3JvbGUoKSINCj4gPiAgIC0gUmVtb3Zl
IGV4dHJhIGxpbmUgYmV0d2VlbiBGaXhlcyBhbmQgU2lnbmVkLW9mZiB0YWcuDQo+ID4gICAtIEFk
ZGVkIFJldmlld2VkLWJ5IGFuZCBDYyB0YWdzIGZyb20gdjEgYW5kIHYyLg0KPiA+DQo+ID4gKiBQ
YXRjaCAyOiAicGxhdGZvcm0vY2hyb21lOiBjcm9zX2VjX3R5cGVjOiBBdm9pZCBzZXR0aW5nIHVz
YiByb2xlIHR3aWNlDQo+ID4gICAgICAgICAgICAgZHVyaW5nIGRpc2Nvbm5lY3QiDQo+ID4gICAt
IEFkZGVkIFN1Z2dlc3RlZC1ieSBmcm9tIHYyLg0KPiA+DQo+ID4gKiBQYXRjaCAzOiAicGxhdGZv
cm0vY2hyb21lOiBjcm9zX2VjX3R5cGVjOiBSZS1vcmRlciBjb25uZWN0b3INCj4gPiAgICAgICAg
ICAgICBjb25maWd1cmF0aW9uIHN0ZXBzIg0KPiA+ICAgLSBObyBjaGFuZ2UNCj4gPg0KPiA+IENo
YW5nZXMgaW4gdjM6DQo+ID4gKiBQYXRjaCAxOiAicGxhdGZvcm0vY2hyb21lOiBjcm9zX2VjX3R5
cGVjOiBTZW5kIGVudW0gdmFsdWVzIHRvDQo+ID4gICAgICAgICAgICAgdXNiX3JvbGVfc3dpdGNo
X3NldF9yb2xlKCkiDQo+ID4gIC0gTm8gY2hhbmdlDQo+ID4NCj4gPiAqIFBhdGNoIDI6ICJwbGF0
Zm9ybS9jaHJvbWU6IGNyb3NfZWNfdHlwZWM6IEF2b2lkIHNldHRpbmcgdXNiIHJvbGUgdHdpY2UN
Cj4gPiAgICAgICAgICAgICBkdXJpbmcgZGlzY29ubmVjdCINCj4gPiAgLSBNb3ZlIHRoZSBsb2Nh
dGlvbiBvZiBjYWxsaW5nIHVzYl9yb2xlX3N3aXRjaF9zZXRfcm9sZSgpIHRvDQo+ID4gICAgZW5k
IG9mIGZ1bmN0aW9uIGluIGNyb3NfdHlwZWNfY29uZmlndXJlX211eCgpIHRvIGF2b2lkIGFueSBj
aGFuZ2UNCj4gPiAgICBpbiBjb2RlIGZsb3cuDQo+ID4NCj4gPiAqIFBhdGNoIDM6ICJwbGF0Zm9y
bS9jaHJvbWU6IGNyb3NfZWNfdHlwZWM6IFJlLW9yZGVyIGNvbm5lY3Rvcg0KPiA+ICAgICAgICAg
ICAgIGNvbmZpZ3VyYXRpb24gc3RlcHMiDQo+ID4gIC0gTmV3IHBhdGNoIGFkZGVkDQo+ID4NCj4g
PiBDaGFuZ2VzIGluIHYyOg0KPiA+ICogUGF0Y2ggMTogInBsYXRmb3JtL2Nocm9tZTogY3Jvc19l
Y190eXBlYzogU2VuZCBlbnVtIHZhbHVlcyB0bw0KPiA+ICAgICAgICAgICAgIHVzYl9yb2xlX3N3
aXRjaF9zZXRfcm9sZSgpIg0KPiA+ICAgLSBVcGRhdGUgdGhlIGNvbW1pdCBtZXNzYWdlIHRvIGNo
YW5nZSAnVVNCX1JPTEVfSE9TVCBpbiBjYXNlIG9mDQo+ID4gICAgIFVGUC4nICB0byAnVVNCX1JP
TEVfSE9TVCBpbiBjYXNlIG9mIERGUC4nDQo+ID4NCj4gPiAqIFBhdGNoIDI6ICJwbGF0Zm9ybS9j
aHJvbWU6IGNyb3NfZWNfdHlwZWM6IEF2b2lkIHNldHRpbmcgdXNiIHJvbGUgdHdpY2UNCj4gPiAg
ICAgICAgICAgICBkdXJpbmcgZGlzY29ubmVjdCINCj4gPiAgIC0gTmV3IHBhdGNoIGFkZGVkLg0K
PiA+DQo+ID4gQXpoYXIgU2hhaWtoICgzKToNCj4gPiAgIHBsYXRmb3JtL2Nocm9tZTogY3Jvc19l
Y190eXBlYzogU2VuZCBlbnVtIHZhbHVlcyB0bw0KPiA+ICAgICB1c2Jfcm9sZV9zd2l0Y2hfc2V0
X3JvbGUoKQ0KPiA+ICAgcGxhdGZvcm0vY2hyb21lOiBjcm9zX2VjX3R5cGVjOiBBdm9pZCBzZXR0
aW5nIHVzYiByb2xlIHR3aWNlIGR1cmluZw0KPiA+ICAgICBkaXNjb25uZWN0DQo+ID4gICBwbGF0
Zm9ybS9jaHJvbWU6IGNyb3NfZWNfdHlwZWM6IFJlLW9yZGVyIGNvbm5lY3RvciBjb25maWd1cmF0
aW9uDQo+ID4gc3RlcHMNCj4gPg0KPiA+ICBkcml2ZXJzL3BsYXRmb3JtL2Nocm9tZS9jcm9zX2Vj
X3R5cGVjLmMgfCA5ICsrKysrKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo=
