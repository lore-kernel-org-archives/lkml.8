Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B07C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B68DF20760
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="gEl+rIFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgGPH6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:58:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:6378 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgGPH6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:58:19 -0400
IronPort-SDR: qagR/UgDqCXTBPpm35BMeQ7f0BSgXNDYqbQNKp3iIu1q4F7XDsDVbqC2ggC4pXpGambhTrqMqE
 UQIt7XadbIlQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="136787835"
X-IronPort-AV: E=Sophos;i="5.75,358,1589266800"; 
   d="scan'208";a="136787835"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 00:58:17 -0700
IronPort-SDR: ipXrGluRj1cXkChLlglCgSXMlU3mz4TM13gpqbF/j1sz7mbD5dZ292fCoDKdUGGZTY+ArARUZV
 VlfMtE2bhrOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,358,1589266800"; 
   d="scan'208";a="286397543"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga006.jf.intel.com with ESMTP; 16 Jul 2020 00:58:17 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 16 Jul 2020 00:58:16 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 16 Jul 2020 00:58:16 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 16 Jul 2020 00:58:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/0sGYITFNLUD+QrCRcsydJT6LwrcUJGsiMDkY7fKg7LxqScngOGoNuv6aj1vp8Jveh9etnAd3go0R7o9FZl5vZvhHrSJf2tuDUSa7OsBy0W8SOXmJc0VFKA4ZhsbY+yb5lDYT27lY3LBv/dErwaJPPcdxKIMZUG6e0nmTEUKQGNREmOZJwYEHKmiZvWMTsu289Q8hSBSCQUDnWhzJpYbYBRB2GC8+f9SX8ne6jHCdAt6hYiQxoZENj+vN198KsSnby4bPL5MUDL3bf1iymFthk4VhVEX0o7JWJjzQFDDjaU1PyaX5rYLvfizDFo0mm9B6dhgWWeelMuAW6mQK/4KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZQo+rkfhkl+Je/At0VEE3ZbhUuatCoRCLK8kepNPZ8=;
 b=M7EYw4dg3YS3BsCNU9JG7AmwpPAXzQbZAIxvHXHjOjqW0QrQc92gzerwWTQwVv+TCyAPGfts6VR1gXx3iMI2AvfffuyEkvFRLyLls2GSObVn/y9ZqKrA+XGZkcfnkvuJOZ1gyD001JCK8F8L+L2JlDNfnU2HzRGlTFIm/W4pzHAwI27aGdYG+ZCe29aLXp+GqCkg7s6SoGgQarBBTuKJR2KYe1yNxm94heBEZCID72rakIxkUBuf7KMqlAit8q+PUuGK57O9FNc+0G6dKf5RoMTm4BxJXLJIkxrgHFEggwZXzDaj8RvHeedkuZ0iGFq0xU7zTKIyp5dy0sRWOhHsVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZQo+rkfhkl+Je/At0VEE3ZbhUuatCoRCLK8kepNPZ8=;
 b=gEl+rIFWgNPoVe0UJiz0/KAR0d76IkAwwBnU58Yk9rGBS1eN7Yc5FQ0wla1UfBnTrvvGoO7ltBegBSWeO1sPotLdaxzRKOS82WmedkwcYcGJmmrK7nd1jzG1ASEu7mCMzI9OiEDe5+LVlY4KhWeMHunmYhMND50PbfqVDtLo5GA=
Received: from DM6PR11MB3721.namprd11.prod.outlook.com (2603:10b6:5:142::10)
 by DM6PR11MB4577.namprd11.prod.outlook.com (2603:10b6:5:2a1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Thu, 16 Jul
 2020 07:58:15 +0000
Received: from DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::b0cf:aaa:bc78:e0cc]) by DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::b0cf:aaa:bc78:e0cc%4]) with mapi id 15.20.3195.018; Thu, 16 Jul 2020
 07:58:15 +0000
From:   "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "kishon@ti.com" <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "MP, Sureshkumar" <sureshkumar.mp@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Subject: RE: [PATCH v6 2/2] phy: intel: Add Keem Bay eMMC PHY support
Thread-Topic: [PATCH v6 2/2] phy: intel: Add Keem Bay eMMC PHY support
Thread-Index: AQHWUAVkjqmtsEYomUu4VN6ud3IOm6kFECCAgAAM5RA=
Date:   Thu, 16 Jul 2020 07:58:15 +0000
Message-ID: <DM6PR11MB37212AA1A79526A55A90D812DD7F0@DM6PR11MB3721.namprd11.prod.outlook.com>
References: <20200702000934.3258-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200702000934.3258-3-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200713054015.GZ34333@vkoul-mobl>
In-Reply-To: <20200713054015.GZ34333@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.209]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d07f391b-d452-422c-7528-08d8295dfeb5
x-ms-traffictypediagnostic: DM6PR11MB4577:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4577932C769FFFD7A593D8B0DD7F0@DM6PR11MB4577.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CyXW89Zmg/YTKB6GdfJC4dNzlZDNqVeFLLWoHhucQh+7YKWI5TjejlIQDhIYVdV4MsjjizUmEo5lRYSwCxFbxDFAAJqqNgS/7NINPy8O+FxY58R7jKXBIXDWNlp/1VJHYIEtdIFJIMk3CRR/uKWkiPf4P8sXMmV8mg8EFlhzVXs/Kla+t4CLqzmYMbM9APHNZctU4lD/1bcKzCkqdrW4+OL7tXrxY6dfFy3JxjMIjhrvCadF6vFnOEdR0F1HCxZJ/NVRKmLc26g6PbXJC4YlC00r0PFsAQf17U9dM9vgivmSZ+Btwzdjq9CZR+yIOorI17aU+36IzyEaxzsr4wnKUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3721.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(54906003)(9686003)(55016002)(5660300002)(64756008)(66556008)(66446008)(478600001)(4326008)(71200400001)(6916009)(52536014)(107886003)(6506007)(7696005)(316002)(66946007)(76116006)(8676002)(26005)(86362001)(186003)(8936002)(2906002)(66476007)(33656002)(53546011)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: eruoWktCy9Rzj5VrJMwTEL8fk/hHl7OdFfckb7Q6jh+kkc5EbB8GE7iMam0WYb+Q6jvEnVBOD7e1IKzp63tU/+P+E3ceLeyxrpUuItGQ2t6yq9nIWT+XOt83cSGPz+MNPj+ejXHJBdqQDN0HQ/Jz4of6aVtL05v8lBYofF8FiNpKAF2r+yTiAt318fvVD+toPGH7YbolQQJ2vduILYqRWTSi6crpzrOhFWlkMthWP1Cpa8rV+i1OM3bIiGb19xR37yoPFhJD4KjLU3t1aOmzG3mULX/w6Xwky6RVjIavkPj32iWkmNzmj5vbfIJ1FmQo3dVDBHAlQYYd5NgufXUgd+w985vmNciU7rNmXAb999MKZaE/0M/HiuYm5Z00GTEkpTxsnoa6eeKszAQmeaDxVUoZUJPR6GqYzzir50H2m1bkkj31D3rIcp4u2QflvYhF4g/yqiNApZDjN4dkYN8AQjtlMySd1XP7r5i+mBR0lKWbogbvgPqNrO4N1dRm8HD3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3721.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d07f391b-d452-422c-7528-08d8295dfeb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2020 07:58:15.3068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nd43mcuQLNr6Tk4bkfribyFO3vdVkVdKmuyhcTXjiyuvG8wuLtpTaK+f9G02OqAJGx7BbgueAo7yWj0DF2qHSX81oleuMsGByTF4lMRZTMlUx6ex2aV70c9LSfwQYkwY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4577
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmlub2QuDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiBGcm9tOiBWaW5vZCBLb3VsIDx2a291bEBrZXJuZWwub3JnPg0KPiBTZW50
OiBNb25kYXksIEp1bHkgMTMsIDIwMjAgMTo0MCBQTQ0KPiBUbzogV2FuIE1vaGFtYWQsIFdhbiBB
aG1hZCBaYWluaWUNCj4gPHdhbi5haG1hZC56YWluaWUud2FuLm1vaGFtYWRAaW50ZWwuY29tPg0K
PiBDYzoga2lzaG9uQHRpLmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOyBTaGV2Y2hlbmtvLCBBbmRy
aXkNCj4gPGFuZHJpeS5zaGV2Y2hlbmtvQGludGVsLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBNUCwgU3VyZXNoa3VtYXIN
Cj4gPHN1cmVzaGt1bWFyLm1wQGludGVsLmNvbT47IFJhamEgU3VicmFtYW5pYW4sIExha3NobWkg
QmFpDQo+IDxsYWtzaG1pLmJhaS5yYWphLnN1YnJhbWFuaWFuQGludGVsLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2NiAyLzJdIHBoeTogaW50ZWw6IEFkZCBLZWVtIEJheSBlTU1DIFBIWSBz
dXBwb3J0DQo+IA0KPiBPbiAwMi0wNy0yMCwgMDg6MDksIFdhbiBBaG1hZCBaYWluaWUgd3JvdGU6
DQo+ID4gQWRkIHN1cHBvcnQgZm9yIGVNTUMgUEhZIG9uIEludGVsIEtlZW0gQmF5IFNvQy4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFdhbiBBaG1hZCBaYWluaWUNCj4gPiA8d2FuLmFobWFkLnph
aW5pZS53YW4ubW9oYW1hZEBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGh5L2lu
dGVsL0tjb25maWcgICAgICAgICAgICB8ICAxMiArDQo+ID4gIGRyaXZlcnMvcGh5L2ludGVsL01h
a2VmaWxlICAgICAgICAgICB8ICAgMSArDQo+ID4gIGRyaXZlcnMvcGh5L2ludGVsL3BoeS1rZWVt
YmF5LWVtbWMuYyB8IDMxNA0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAz
IGZpbGVzIGNoYW5nZWQsIDMyNyBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCBkcml2ZXJzL3BoeS9pbnRlbC9waHkta2VlbWJheS1lbW1jLmMNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3BoeS9pbnRlbC9LY29uZmlnIGIvZHJpdmVycy9waHkvaW50ZWwvS2NvbmZp
Zw0KPiA+IGluZGV4IDdiNDc2ODJhNGUwZS4uOGRkZGE0ZmI5NWQyIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvcGh5L2ludGVsL0tjb25maWcNCj4gPiArKysgYi9kcml2ZXJzL3BoeS9pbnRlbC9L
Y29uZmlnDQo+ID4gQEAgLTIyLDMgKzIyLDE1IEBAIGNvbmZpZyBQSFlfSU5URUxfRU1NQw0KPiA+
ICAJc2VsZWN0IEdFTkVSSUNfUEhZDQo+ID4gIAloZWxwDQo+ID4gIAkgIEVuYWJsZSB0aGlzIHRv
IHN1cHBvcnQgdGhlIEludGVsIEVNTUMgUEhZDQo+ID4gKw0KPiA+ICtjb25maWcgUEhZX0tFRU1C
QVlfRU1NQw0KPiANCj4gUGxzIGtlZXAgdGhpcyBpbiBhbHBoYWJldGljYWwgc29ydA0KDQpQSFlf
SU5URUxfIGZvbGxvd2VkIGJ5IFBIWV9LRUVNQkFZXyBpcyBhbHBoYWJldGljYWxseSBzb3J0ZWQu
DQpDb3VsZCB5b3UgcGxlYXNlIGhlbHAgdG8gY2xhcmlmeT8NCg0KPiANCj4gPiArCXRyaXN0YXRl
ICJJbnRlbCBLZWVtIEJheSBFTU1DIFBIWSBkcml2ZXIiDQo+ID4gKwlkZXBlbmRzIG9uIEFSTTY0
IHx8IENPTVBJTEVfVEVTVA0KPiANCj4gSW50ZWwgYW5kIEFSTTY0LCBhaGEsIGZ1biB0aW1lcyEN
Cg0K8J+Yig0KDQo+IA0KPiA+ICsJZGVwZW5kcyBvbiBPRiAmJiBIQVNfSU9NRU0NCj4gPiArCXNl
bGVjdCBHRU5FUklDX1BIWQ0KPiA+ICsJc2VsZWN0IFJFR01BUF9NTUlPDQo+ID4gKwloZWxwDQo+
ID4gKwkgIENob29zZSB0aGlzIG9wdGlvbiBpZiB5b3UgaGF2ZSBhbiBJbnRlbCBLZWVtIEJheSBT
b0MuDQo+ID4gKw0KPiA+ICsJICBUbyBjb21waWxlIHRoaXMgZHJpdmVyIGFzIGEgbW9kdWxlLCBj
aG9vc2UgTSBoZXJlOiB0aGUgbW9kdWxlDQo+ID4gKwkgIHdpbGwgYmUgY2FsbGVkIHBoeS1rZWVt
YmF5LWVtbWMuDQo+IA0KPiBwaHkta2VlbWJheS1lbW1jLmtvID8NCg0KSXMgaXQgYSBtdXN0PyBJ
IHNhdyBmZXcgS2NvbmZpZyBmaWxlcyBvbWl0IC5rby4NCkkgY2FuIGZpeCB0aGlzIGluIG5leHQg
dmVyc2lvbi4NCg0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waHkvaW50ZWwvTWFrZWZp
bGUgYi9kcml2ZXJzL3BoeS9pbnRlbC9NYWtlZmlsZQ0KPiA+IGluZGV4IDIzM2Q1MzBkYWRkZS4u
NjU2NjMzNGU3Yjc3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGh5L2ludGVsL01ha2VmaWxl
DQo+ID4gKysrIGIvZHJpdmVycy9waHkvaW50ZWwvTWFrZWZpbGUNCj4gPiBAQCAtMSwzICsxLDQg
QEANCj4gPiAgIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiA+ICBvYmotJChD
T05GSUdfUEhZX0lOVEVMX0NPTUJPKQkJKz0gcGh5LWludGVsLWNvbWJvLm8NCj4gPiAgb2JqLSQo
Q09ORklHX1BIWV9JTlRFTF9FTU1DKSAgICAgICAgICAgICs9IHBoeS1pbnRlbC1lbW1jLm8NCj4g
PiArb2JqLSQoQ09ORklHX1BIWV9LRUVNQkFZX0VNTUMpCQkrPSBwaHkta2VlbWJheS0NCj4gZW1t
Yy5vDQo+IA0KPiBoZXJlIGFzIHdlbGwNCj4gDQo+ID4gKy8qIGVNTUMvU0QvU0RJTyBjb3JlL3Bo
eSBjb25maWd1cmF0aW9uIHJlZ2lzdGVycyAqLw0KPiA+ICsjZGVmaW5lIFBIWV9DRkdfMAkJMHgy
NA0KPiA+ICsjZGVmaW5lICBTRUxfRExZX1RYQ0xLX01BU0sJQklUKDI5KQ0KPiA+ICsjZGVmaW5l
ICBTRUxfRExZX1RYQ0xLKHgpCSgoKHgpIDw8IDI5KSAmIFNFTF9ETFlfVFhDTEtfTUFTSykNCj4g
PiArI2RlZmluZSAgT1RBUF9ETFlfRU5BX01BU0sJQklUKDI3KQ0KPiA+ICsjZGVmaW5lICBPVEFQ
X0RMWV9FTkEoeCkJKCgoeCkgPDwgMjcpICYgT1RBUF9ETFlfRU5BX01BU0spDQo+ID4gKyNkZWZp
bmUgIE9UQVBfRExZX1NFTF9NQVNLCUdFTk1BU0soMjYsIDIzKQ0KPiA+ICsjZGVmaW5lICBPVEFQ
X0RMWV9TRUwoeCkJKCgoeCkgPDwgMjMpICYgT1RBUF9ETFlfU0VMX01BU0spDQo+IA0KPiB3aHkg
bm90IGEgZ2VuZXJpYyBoZWxwZXIgdG8gZG8gKHgpIDw8IGZmcyhyZWcgLSAxKSAmIHJlZyA/DQo+
IFlvdSBjYW4gc2tpcCBkZWZpbmluZyBmb3IgZWFjaCByZWdpc3RlciB0aGF0IHdheSENCg0KSXMg
aXQgc29tZXRoaW5nIGxpa2UgdGhpcyBmb2xsb3dpbmc/DQojZGVmaW5lIG1hc2t2YWwobWFzaywg
dmFsKSAgICAgKCgodmFsKSA8PCAoZmZzKG1hc2spIC0gMSkpICYgbWFzaykNCg0KPiANCj4gLS0N
Cj4gflZpbm9kDQo=
