Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F20C3F2CE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 14:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FCBA222C2
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 14:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="cpeQA+Gf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCAODx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 09:03:53 -0500
Received: from mail-eopbgr760042.outbound.protection.outlook.com ([40.107.76.42]:46147
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725874AbgCAODx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 09:03:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obbasbzIJhfn2IyBpvBL/2sHTuzY/OVE0xebX4N1FKmUmx4YRCadr5Bxjp5ldRV1adwVj000yk3N7U28e7+/OjuEFXCW2XdW2n5YRYpHbl6pY4IIfK/+Zp1eREzcUP516Ot0qrh6JeS263/N57Jkr/szfLkcuO49QWPBamtbZJGiZ/k9tYjVotI/Xbqh+JqJqyCA/g5Es8SdDuKS46BDRJi5fAQizrNt8Yp3bsyYRIHM+BZffsfQwJFqZuHR//WUxHfqsGah4DdRtxpLMEXgSMPO6/fp40KOv9I6npU7iX+98T8+WHFOvOdMqcirzI5B/cBuUQ9q3jC47ktrhEpt4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPsNVr1/VjhKUktG3+yVmkhO9AzXgVANPN9rZKgCHhE=;
 b=FX6Fo2OtS/8rW6RixaZcpPtlvUXPhUc4sutMwyYQRiVs0VTE2ySzKLMIRD1RKixHGJrrZXo1Ofx3/8qdyzthzDvfTv9Nmwt13ye3JbiIzUIekKiepYljziv6E9mKb3pZhq5Ad+hOPWQtqhLs6SoT0RM5S2Zi2IHwshuaM3JG46Nz5LoQhWgoJ7zgSpqG06YwvSAsq4N5oieN1GrH2esCm9URodcgK4eA8oGPoLECi36rCaVIcpRmsMMQJYi/yVC8L0Q6UEhHcX7n6LkHkNmPV9zbq7anEVmV2VeukDpglSRNNtw+vmYmux1RhWl0lZsFOoh6Q6Yokjg+KnHnVLfXCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPsNVr1/VjhKUktG3+yVmkhO9AzXgVANPN9rZKgCHhE=;
 b=cpeQA+GfmrbAeRmiwkk+CyXm2tbs0PU7l4Q6grg7QmLo4cO37RkSu0UjyRgiWQHHZRlqLQDBZ13ZxLD+uSrjj4iZGK3SLMQGFv323bQUzmh56LZF7Q3l4LXxbq0dUjH5uO7f2XzY++QBJs55kB6rHEjajk5QjM1aq4BM+ID962M=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (2603:10b6:208:c7::25)
 by MN2PR05MB6830.namprd05.prod.outlook.com (2603:10b6:208:1be::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.5; Sun, 1 Mar
 2020 14:03:46 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::b4a2:5c46:955a:2850]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::b4a2:5c46:955a:2850%7]) with mapi id 15.20.2793.011; Sun, 1 Mar 2020
 14:03:44 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     "hdanton@sina.com" <hdanton@sina.com>,
        "thomas_os@shipmail.org" <thomas_os@shipmail.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Pv-drivers <Pv-drivers@vmware.com>,
        "rcampbell@nvidia.com" <rcampbell@nvidia.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>
Subject: Re: [PATCH v4 5/9] drm/ttm, drm/vmwgfx: Support huge TTM pagefaults
Thread-Topic: [PATCH v4 5/9] drm/ttm, drm/vmwgfx: Support huge TTM pagefaults
Thread-Index: AQHV79BFTb9FxT47g0qreTe+xyrlNagzxMoA
Date:   Sun, 1 Mar 2020 14:03:44 +0000
Message-ID: <39b3614c5bc472981bd12419492af9f7764bf980.camel@vmware.com>
References: <20200220122719.4302-1-thomas_os@shipmail.org>
         <20200301134928.16128-1-hdanton@sina.com>
In-Reply-To: <20200301134928.16128-1-hdanton@sina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be41a3e1-098e-4472-d727-08d7bde95afc
x-ms-traffictypediagnostic: MN2PR05MB6830:|MN2PR05MB6830:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR05MB6830C65D936B99E64C3FE8DAA1E60@MN2PR05MB6830.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0329B15C8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(189003)(199004)(6486002)(2616005)(71200400001)(4326008)(54906003)(6506007)(107886003)(110136005)(5660300002)(316002)(66446008)(66556008)(8936002)(86362001)(478600001)(2906002)(81166006)(7416002)(186003)(8676002)(81156014)(64756008)(76116006)(26005)(66476007)(66946007)(91956017)(6512007)(36756003)(14583001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB6830;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2icZ/+La2jyJpeGh2Vx7d4LPLjQJ338Kgi12NusYfH8D2Kdarbutx847hv4f0cw+VmC7TVg1fW239nz8ZjasjC1kiz/M/l2CLdvAN0b05GXQPqh3wIYqzgF+JJxWPr8Q2XlwMLFnuK6PkOD95kRmGoETBctj1TeBMw8x8agatgENMfJu4DGQrMsymrIclMZ8Nik0wH02rm4tJ1S0QJGoDZbydY4DRDsHioKu9/AYie+yS2f2MIcNgTFF3Yg48HbT5YEex4B9l9x0jqLl7dvK2UFVR05NckxtFcHmjXlm7ZRz8dRMiERJooFVUwR1beeB3DpHqo92YruMusL4H45qjBgyu1GcXBiZf2jyOWuWqV6wd8SGeiR/QS+1P6bqUTZ3T/NL1AraDoaiWyZSQ61UAheuzyazdHff9k3MHCemE+G2DUk39NGpeFOGNVpvss1MbBiTmPynGyg75ahTEGExK4xauHJaU9W1xygWhTIozC6nkBlLZv3NPKN77nMtJ5Wf
x-ms-exchange-antispam-messagedata: 0Zt0oWAWa1iof2TzhvcNdDpdIymhLUgsYTBdvfixfQeMfywzPm1pHoL5Vr9plBz8HC7+1pZ+DWeZCJfcj+Xw8liXdmn6rLYLnOtQoqIdBOPPHMQrdOk2t9FgzyLp7KBod8M0/jLhoTPDLaCvkhHMgw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2ED34A6A6EF244A8B5FFE91EE786F5B@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be41a3e1-098e-4472-d727-08d7bde95afc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2020 14:03:44.5185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: al/DdpFSGxUhcUzP6ZKV+dWas8Z9X+XVxw23ELqpnfOFSddtCBH/lns2kpb2lgy+wwYr/1I1D1gNLeDKlwwsCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6830
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIwLTAzLTAxIGF0IDIxOjQ5ICswODAwLCBIaWxsZiBEYW50b24gd3JvdGU6DQo+
IE9uIFRodSwgMjAgRmViIDIwMjAgMTM6Mjc6MTUgKzAxMDAgVGhvbWFzIEhlbGxzdHJvbSB3cm90
ZToNCj4gPiArDQo+ID4gK3N0YXRpYyB2bV9mYXVsdF90IHR0bV9ib192bV9odWdlX2ZhdWx0KHN0
cnVjdCB2bV9mYXVsdCAqdm1mLA0KPiA+ICsJCQkJICAgICAgIGVudW0gcGFnZV9lbnRyeV9zaXpl
IHBlX3NpemUpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hID0gdm1m
LT52bWE7DQo+ID4gKwlwZ3Byb3RfdCBwcm90Ow0KPiA+ICsJc3RydWN0IHR0bV9idWZmZXJfb2Jq
ZWN0ICpibyA9IHZtYS0+dm1fcHJpdmF0ZV9kYXRhOw0KPiA+ICsJdm1fZmF1bHRfdCByZXQ7DQo+
ID4gKwlwZ29mZl90IGZhdWx0X3BhZ2Vfc2l6ZSA9IDA7DQo+ID4gKwlib29sIHdyaXRlID0gdm1m
LT5mbGFncyAmIEZBVUxUX0ZMQUdfV1JJVEU7DQo+ID4gKw0KPiA+ICsJc3dpdGNoIChwZV9zaXpl
KSB7DQo+ID4gKwljYXNlIFBFX1NJWkVfUE1EOg0KPiA+ICsJCWZhdWx0X3BhZ2Vfc2l6ZSA9IEhQ
QUdFX1BNRF9TSVpFID4+IFBBR0VfU0hJRlQ7DQo+ID4gKwkJYnJlYWs7DQo+ID4gKyNpZmRlZiBD
T05GSUdfSEFWRV9BUkNIX1RSQU5TUEFSRU5UX0hVR0VQQUdFX1BVRA0KPiA+ICsJY2FzZSBQRV9T
SVpFX1BVRDoNCj4gPiArCQlmYXVsdF9wYWdlX3NpemUgPSBIUEFHRV9QVURfU0laRSA+PiBQQUdF
X1NISUZUOw0KPiA+ICsJCWJyZWFrOw0KPiA+ICsjZW5kaWYNCj4gPiArCWRlZmF1bHQ6DQo+ID4g
KwkJV0FSTl9PTl9PTkNFKDEpOw0KPiA+ICsJCXJldHVybiBWTV9GQVVMVF9GQUxMQkFDSzsNCj4g
PiArCX0NCj4gPiArDQo+ID4gKwkvKiBGYWxsYmFjayBvbiB3cml0ZSBkaXJ0eS10cmFja2luZyBv
ciBDT1cgKi8NCj4gPiArCWlmICh3cml0ZSAmJiB0dG1fcGdwcm90X2lzX3dycHJvdGVjdGluZyh2
bWEtPnZtX3BhZ2VfcHJvdCkpDQo+ID4gKwkJcmV0dXJuIFZNX0ZBVUxUX0ZBTExCQUNLOw0KPiA+
ICsNCj4gPiArCXJldCA9IHR0bV9ib192bV9yZXNlcnZlKGJvLCB2bWYpOw0KPiA+ICsJaWYgKHJl
dCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiArCXByb3QgPSB2bV9nZXRfcGFnZV9w
cm90KHZtYS0+dm1fZmxhZ3MpOw0KPiA+ICsJcmV0ID0gdHRtX2JvX3ZtX2ZhdWx0X3Jlc2VydmVk
KHZtZiwgcHJvdCwgMSwgZmF1bHRfcGFnZV9zaXplKTsNCj4gPiArCWlmIChyZXQgPT0gVk1fRkFV
TFRfUkVUUlkgJiYgISh2bWYtPmZsYWdzICYNCj4gPiBGQVVMVF9GTEFHX1JFVFJZX05PV0FJVCkp
DQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gDQo+IFNlZW1zIGl0IGRvZXMgbm90IG1ha2UgbXVjaCBz
ZW5zZSB0byBjaGVjayBWTV9GQVVMVF9SRVRSWSBhbmQgcmV0dXJuDQo+IGFzDQo+IGF0IGxlYXN0
IHJlc3YgbG9jayBpcyBsZWZ0IGJlaGluZCB3aXRob3V0IGNhcmUuDQoNCldpdGggdGhpcyBwYXJ0
aWN1bGFyIGZsYWcgY29tYmluYXRpb24sIGJvdGggdGhlIG1tX3NlbSBhbmQgdGhlIGRtYV9yZXN2
DQpsb2NrIGhhdmUgYWxyZWFkeSBiZWVuIHJlbGVhc2VkIGJ5IFRUTS4NCg0KSXQncyBhIHNwZWNp
YWwgY2FzZSBhbGxvd2luZyBmb3IgZHJpdmVycyB0byByZWxlYXNlIHRoZSBtbWFwX3NlbSB3aGVu
DQp3YWl0aW5nIGZvciBJTy4NCg0KVGhhdCBzaG91bGQgcHJvYmFibHkgYmUgZG9jdW1lbnRlZCBi
ZXR0ZXIgaW4gVFRNLg0KDQovVGhvbWFzDQoNCg==
