Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18CFC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 980362064A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ozCRrozu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgD1IZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:25:56 -0400
Received: from mail-eopbgr70089.outbound.protection.outlook.com ([40.107.7.89]:63643
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726377AbgD1IZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:25:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaPwuwp+LNVMO5sbHRRKw3zb1MbyMhefKPIvpfsY81hJeyvrUJsyuYVNgES2f4tTeJr94vNzFR9oApFmMjHfxMvJvR3DFuwEhNXc2hUIbU9E7Wf8A+LZlsig11tU4A60lyZooGAYL4PajcGYy/8jXgn82D/Xt4YgUCQDGu90sdg5BJOHosyUYWW8Ta6fB35nAn099Qr4G75TgHdqKxuOSOdm8oaELB4SWQDPF21rgBxsYs8ylgj4TiaCeWPbSYPnp391lOG9Hk8+pHMbFUGQOvnWN3YhHzgqhObrDa3h1ZGV/gQNWEBE9UayT2ux1gaOJQKUtmN0ToAvOesmSJ4ozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dlw8bIFYxUY28tZAnQDAnDvvkdqtZ78OGLsv81bSHCc=;
 b=hznfmm4daLQax9hlivpBd2uwMCSzEqdrnWvIJtq8X7OM33i8/lBdzdGbXxorK4suAWi4XeMa+CUV4VoaMbgFqOyJ081ZHqZl7e4nSib9GV0ab9jzEEBFX3TZznn/l2kSduqqv/maxzHppnd2kwm0UMY2ljPnIjAcku6odIg62n7RxZRcDMNP/YuijgRJdJUxXaYJeor1PxqUHnFILRXiaUO1mF5sWWS18sswKpUfy9fk8SYmDqpdrKa0OG4KrLphoGh5IyY9j2QQToSPU45BMvfK3qhmyeesLqNISAGwcFSYNha+TsoJV0DLlz5ajhfvsAbkFtwYtcq9Hui4ds6MCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dlw8bIFYxUY28tZAnQDAnDvvkdqtZ78OGLsv81bSHCc=;
 b=ozCRrozuW7lhxMex/g5kIxsJKEN5W9AnVlaI/l+N2UXjY2PjiLT4kmdxlvwk9LBFGQ/dXri0YKkkcBDGbkQZ5ubwBEKXmbYW16Yg1ew3igACX6uvj+dL94N2g1AzQLuqaxkwFGj8uz5g3tsp5aMB73LNNQTkmWahbsDPsGG3Vhc=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2774.eurprd04.prod.outlook.com (2603:10a6:4:96::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Tue, 28 Apr
 2020 08:25:51 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 08:25:51 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>
CC:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] xen/swiotlb: correct the check for
 xen_destroy_contiguous_region
Thread-Topic: [PATCH] xen/swiotlb: correct the check for
 xen_destroy_contiguous_region
Thread-Index: AQHWHTCUGLGxU19LnkuMxSfwKxPy/aiOLjMAgAAEXoA=
Date:   Tue, 28 Apr 2020 08:25:51 +0000
Message-ID: <DB6PR0402MB2760A05135338B0CBB28123488AC0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1588059225-11245-1-git-send-email-peng.fan@nxp.com>
 <1c01e97a-adcd-a703-55b5-8975b4ce4d2c@suse.com>
In-Reply-To: <1c01e97a-adcd-a703-55b5-8975b4ce4d2c@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3c952341-0a09-49f0-1c35-08d7eb4dc2fa
x-ms-traffictypediagnostic: DB6PR0402MB2774:|DB6PR0402MB2774:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB2774DAE2ED2273FB88D0E18488AC0@DB6PR0402MB2774.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0387D64A71
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(52536014)(186003)(33656002)(81156014)(8676002)(5660300002)(44832011)(6506007)(53546011)(66556008)(64756008)(66476007)(26005)(7696005)(66446008)(76116006)(66946007)(86362001)(71200400001)(45080400002)(2906002)(316002)(4326008)(9686003)(8936002)(54906003)(478600001)(110136005)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wp5M9pRkZTNfLrbzQWLN5xAF4qPHU2zhrJC2H9zEZx6TdtZ+MqwgC/bWFSjXVv6/rC34FM4Co8KucAkwII+8CeUgRRjlgHDz9uL8ZDT4IvRT5iaGMKNa2IiOC0oxvGH6wvj0Yo9fivLxN4dRce36dnAFgPzKB77vq9hARJyWYgz5Ie+yqUbLZe09bqKLR8PjhEhYb7tbQUOwrDdC6S0RtoyGsUxgpZComiFqOVOjJ4RTkKsCy1WdJghuc4br8cGoP8IGuZDvW69kUJF3GL3FU2kcMYeLmU4uDJLU1twH1S6bBplJRxtvbHjw2DWbYNRzN93yQn9SbdsjVtaeeKsRmnIVMggmDEsZk0iAYiOfTs5ToTSTFcXkLMsHNPnY2smmd8hlAnVthUUxwsTF6f3FeCSEOAozBEXYlZ2ljSsMFQfKS7KWPybYLS1Wa/CLoUYy
x-ms-exchange-antispam-messagedata: 9DTbD4fEBCogK3eME4Bq825PLA2tr3PbNEFE5q7ldawQmCTD2tBgamLD6UdnddwH29bQN8O8/RKIxRYemi63lCC6zLoVC+Z4dZOTWF72GDzuRZ6OvnX45MnmRDx2wVmhoZvPA1WBssbA8b3WBM1r4YcrWp0Op/Aisu1zdBUOwGYmFXU1gKlxnHMVv+3/O15dVpVx5rdiYqQughkgD8QZMQIx70fyGw4nSlRC3qhDEGk9NHOYLrTXGsRfeOl52lA3268bAMSdTUQKb7qb01+IE/b/6sX8RQFkpusJdXeiNJDWE3TNpxMxa1MMhVQi/yMEmUaP2vU7uCRhKHF7eYPZ9YADWsqp+q8BkTKeuaU7JxVg3jv1h3phLuDXiEO2JuDHs9E91vp8wNge+4fWm4Lr7rkQgO6XFSSxs7n0jrapQDwWBMoEigN7nWdPn5CJ1s0WcsU4up/fYM8xBG5WFm7+ve6GyL4SnpkMv5FqpWnVaYsr3+n0FlBH0JeURVHpVtGVBVyUwT2McSHNFjWQVBrwWFdPNooXZ4AZN7VZ+QV6i2hH90YGIVf+27dgaJIxwO9J21IZsnI18gGCWJ28CKFyJaa8pZxPII6blawP4NBdTVv6ReGpcVGK49WyNotHH9YQxPmv6d/CXaJGROJlz4E0E9QptTNVD0sJd+8jrl6SooTGrgaRn1keBYeZkEUCRilzcbKzoqXfCanYe9cYmOkHi/+lTF8Aid6ivKJVU0ijaihseqwsHx7JGvHddUnzBLcQGKGnm0nNBgaFLBpo6TuEBVIqUIR6Jl/W0OgmCq3YSVU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c952341-0a09-49f0-1c35-08d7eb4dc2fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2020 08:25:51.0895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J7dODyBu4e4WcytpCWJycYreIF9rtxjPzZXKF59BrTxzikPu8cwCgPkE7S1s9RDlQmREveKlk/PO3GYuaRRTmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2774
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIXSB4ZW4vc3dpb3RsYjogY29ycmVjdCB0aGUgY2hlY2sgZm9y
DQo+IHhlbl9kZXN0cm95X2NvbnRpZ3VvdXNfcmVnaW9uDQo+IA0KPiBPbiAyOC4wNC4yMCAwOToz
MywgcGVuZy5mYW5AbnhwLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5A
bnhwLmNvbT4NCj4gPg0KPiA+IFdoZW4gYm9vdGluZyB4ZW4gb24gaS5NWDhRTSwgbWV0Og0KPiA+
ICINCj4gPiBbICAgIDMuNjAyMTI4XSBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBwYWdpbmcgcmVx
dWVzdCBhdCB2aXJ0dWFsIGFkZHJlc3MNCj4gMDAwMDAwMDAwMDI3MmQ0MA0KPiA+IFsgICAgMy42
MTA4MDRdIE1lbSBhYm9ydCBpbmZvOg0KPiA+IFsgICAgMy42MTM5MDVdICAgRVNSID0gMHg5NjAw
MDAwNA0KPiA+IFsgICAgMy42MTczMzJdICAgRUMgPSAweDI1OiBEQUJUIChjdXJyZW50IEVMKSwg
SUwgPSAzMiBiaXRzDQo+ID4gWyAgICAzLjYyMzIxMV0gICBTRVQgPSAwLCBGblYgPSAwDQo+ID4g
WyAgICAzLjYyNjYyOF0gICBFQSA9IDAsIFMxUFRXID0gMA0KPiA+IFsgICAgMy42MzAxMjhdIERh
dGEgYWJvcnQgaW5mbzoNCj4gPiBbICAgIDMuNjMzMzYyXSAgIElTViA9IDAsIElTUyA9IDB4MDAw
MDAwMDQNCj4gPiBbICAgIDMuNjM3NjMwXSAgIENNID0gMCwgV25SID0gMA0KPiA+IFsgICAgMy42
NDA5NTVdIFswMDAwMDAwMDAwMjcyZDQwXSB1c2VyIGFkZHJlc3MgYnV0IGFjdGl2ZV9tbSBpcw0K
PiBzd2FwcGVyDQo+ID4gWyAgICAzLjY0Nzk4M10gSW50ZXJuYWwgZXJyb3I6IE9vcHM6IDk2MDAw
MDA0IFsjMV0gUFJFRU1QVCBTTVANCj4gPiBbICAgIDMuNjU0MTM3XSBNb2R1bGVzIGxpbmtlZCBp
bjoNCj4gPiBbICAgIDMuNjc3Mjg1XSBIYXJkd2FyZSBuYW1lOiBGcmVlc2NhbGUgaS5NWDhRTSBN
RUsgKERUKQ0KPiA+IFsgICAgMy42NzczMDJdIFdvcmtxdWV1ZTogZXZlbnRzIGRlZmVycmVkX3By
b2JlX3dvcmtfZnVuYw0KPiA+IFsgICAgMy42ODQyNTNdIGlteDZxLXBjaWUgNWYwMDAwMDAucGNp
ZTogUENJIGhvc3QgYnJpZGdlIHRvIGJ1cyAwMDAwOjAwDQo+ID4gWyAgICAzLjY4ODI5N10gcHN0
YXRlOiA2MDAwMDAwNSAoblpDdiBkYWlmIC1QQU4gLVVBTykNCj4gPiBbICAgIDMuNjg4MzEwXSBw
YyA6IHhlbl9zd2lvdGxiX2ZyZWVfY29oZXJlbnQrMHgxODAvMHgxYzANCj4gPiBbICAgIDMuNjkz
OTkzXSBwY2lfYnVzIDAwMDA6MDA6IHJvb3QgYnVzIHJlc291cmNlIFtidXMgMDAtZmZdDQo+ID4g
WyAgICAzLjcwMTAwMl0gbHIgOiB4ZW5fc3dpb3RsYl9mcmVlX2NvaGVyZW50KzB4NDQvMHgxYzAN
Cj4gPiAiDQo+ID4NCj4gPiBJbiB4ZW5fc3dpb3RsYl9hbGxvY19jb2hlcmVudCwgaWYgIShkZXZf
YWRkciArIHNpemUgLSAxIDw9IGRtYV9tYXNrKQ0KPiA+IG9yIHJhbmdlX3N0cmFkZGxlc19wYWdl
X2JvdW5kYXJ5KHBoeXMsIHNpemUpIGFyZSB0cnVlLCBpdCB3aWxsIGNyZWF0ZQ0KPiA+IGNvbnRp
Z3VvdXMgcmVnaW9uLiBTbyB3aGVuIGZyZWUsIHdlIG5lZWQgdG8gZnJlZSBjb250aWd1b3VzIHJl
Z2lvbiB1c2UNCj4gPiB1cHBlciBjaGVjayBjb25kaXRpb24uDQo+IA0KPiBObywgdGhpcyB3aWxs
IGJyZWFrIFBWIGd1ZXN0cyBvbiB4ODYuDQoNCkNvdWxkIHlvdSBzaGFyZSBtb3JlIGRldGFpbHMg
d2h5IGFsbG9jIGFuZCBmcmVlIG5vdCBtYXRjaGluZyBmb3IgdGhlIGNoZWNrPw0KDQpUaGFua3Ms
DQpQZW5nLg0KDQo+IA0KPiBJIHRoaW5rIHRoZXJlIGlzIHNvbWV0aGluZyB3cm9uZyB3aXRoIHlv
dXIgc2V0dXAgaW4gY29tYmluYXRpb24gd2l0aCB0aGUgQVJNDQo+IHhlbl9jcmVhdGVfY29udGln
dW91c19yZWdpb24oKSBpbXBsZW1lbnRhdGlvbi4NCj4gDQo+IFN0ZWZhbm8/DQo+IA0KPiANCj4g
SnVlcmdlbg0KPiANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBu
eHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy94ZW4vc3dpb3RsYi14ZW4uYyB8IDQgKyst
LQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3hlbi9zd2lvdGxiLXhlbi5jIGIvZHJpdmVy
cy94ZW4vc3dpb3RsYi14ZW4uYw0KPiA+IGluZGV4IGI2ZDI3NzYyYzZmOC4uYWI5NmU0Njg1ODRm
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMveGVuL3N3aW90bGIteGVuLmMNCj4gPiArKysgYi9k
cml2ZXJzL3hlbi9zd2lvdGxiLXhlbi5jDQo+ID4gQEAgLTM0Niw4ICszNDYsOCBAQCB4ZW5fc3dp
b3RsYl9mcmVlX2NvaGVyZW50KHN0cnVjdCBkZXZpY2UgKmh3ZGV2LA0KPiBzaXplX3Qgc2l6ZSwg
dm9pZCAqdmFkZHIsDQo+ID4gICAJLyogQ29udmVydCB0aGUgc2l6ZSB0byBhY3R1YWxseSBhbGxv
Y2F0ZWQuICovDQo+ID4gICAJc2l6ZSA9IDFVTCA8PCAob3JkZXIgKyBYRU5fUEFHRV9TSElGVCk7
DQo+ID4NCj4gPiAtCWlmICghV0FSTl9PTigoZGV2X2FkZHIgKyBzaXplIC0gMSA+IGRtYV9tYXNr
KSB8fA0KPiA+IC0JCSAgICAgcmFuZ2Vfc3RyYWRkbGVzX3BhZ2VfYm91bmRhcnkocGh5cywgc2l6
ZSkpICYmDQo+ID4gKwlpZiAoKChkZXZfYWRkciArIHNpemUgLSAxID4gZG1hX21hc2spIHx8DQo+
ID4gKwkgICAgcmFuZ2Vfc3RyYWRkbGVzX3BhZ2VfYm91bmRhcnkocGh5cywgc2l6ZSkpICYmDQo+
ID4gICAJICAgIFRlc3RDbGVhclBhZ2VYZW5SZW1hcHBlZCh2aXJ0X3RvX3BhZ2UodmFkZHIpKSkN
Cj4gPiAgIAkJeGVuX2Rlc3Ryb3lfY29udGlndW91c19yZWdpb24ocGh5cywgb3JkZXIpOw0KPiA+
DQo+ID4NCg0K
