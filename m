Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF833C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4DF8206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="I5v627nq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgD1IP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:15:58 -0400
Received: from mail-eopbgr80055.outbound.protection.outlook.com ([40.107.8.55]:12672
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726515AbgD1IP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:15:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9h/RVczCr4AX5L0UMnHhgS4yoWNI7IMSF6GU4JgRxS/2EdQjMeWjRu4+K28bGjrv0YVpoGFm2WFd9xokAQdHARfcVoDMPQwRWHXBsib+FD0ZmQXg6NUcxsLMaIIHOBdTP+zVLUJIBwDEvxX9Cw+5u/FowRNu/CR33TqFkBu5I3FkMg9NGgGFoQvncf/N/SDd/9vZaNBNMIQEcXPyRDglRKZ8iBWrFA994J+K/gHus9nrjl9v+XiOVDUHc65kuSOOgpGQmhHax0Yz04Imt5u9MoLQeZ+gfmZI5p/ges1SazNUKmKr7dmUOiNz1hxck1Y+GxpvxxGUQ+oYpfORf1BYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cets+4zYkj7zEWx/JJCY/GYxLX+PWqdNIOHeKWVD1xE=;
 b=PVnNpR6r8I6Edcp27KwHDm9snu8XA0U76QeImWN3nnktx/X8LfxZ/NxpWaaMzvZYPO2kEQkNCwRdRpVNdIDaXcb6cQ5A3xwd60WokZXABJ+RfInels+DGlJm3DbdiioJ6J3qWG9GfuSqgt1cCjCWbHKNnz1l0TcPiYtPaM9Xbk3k84kSzcy8/u+TGOdrHlkWCTSPaNjnQeJ4/hp5JYHwZLRLG9NFzMyvhA+/0TGVmR75md3Z0/V6vE7Uq/PJcS+TjCCup3Hm8pQ78l90bKjgdEHJN8eoREBv/rII6fdL9tP3PKZUlof9cDyswBTN4bq94V1WBV9EqOxhMfFso+EmOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cets+4zYkj7zEWx/JJCY/GYxLX+PWqdNIOHeKWVD1xE=;
 b=I5v627nqArd6ekJ8k9ljCMYEy9ykE05q0YlOoBD66JBNq2lEZXDz2F1fL/3QnbQJtk64165D5ZJHQyNIE/dig7g1sbwygYVPTC4oxB5iLRI9gJrGWmZR4QrBLWefYOiMu4R7D03uj0p9YJA9Na/4EGobRjfw5KH6cjhZ+0t1ONg=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5573.eurprd04.prod.outlook.com (2603:10a6:20b:94::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Tue, 28 Apr
 2020 08:15:51 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3%7]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 08:15:51 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: RE: [PATCH] clk: imx8mp: Set the correct parent for audio_root_clk
Thread-Topic: [PATCH] clk: imx8mp: Set the correct parent for audio_root_clk
Thread-Index: AQHWHKYh3Me+nRhH7UyIwPCZLBjcm6iOLDKA
Date:   Tue, 28 Apr 2020 08:15:51 +0000
Message-ID: <AM6PR04MB49663A072F56397BE55FF3C480AC0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1588000281-6594-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1588000281-6594-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [218.82.155.143]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0370aed9-6379-46d7-86fe-08d7eb4c5d7d
x-ms-traffictypediagnostic: AM6PR04MB5573:|AM6PR04MB5573:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB55730415004C571AFBDEE6E480AC0@AM6PR04MB5573.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0387D64A71
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(8936002)(71200400001)(66556008)(81156014)(66476007)(478600001)(66446008)(8676002)(76116006)(54906003)(52536014)(316002)(110136005)(5660300002)(64756008)(66946007)(4326008)(7696005)(2906002)(186003)(44832011)(86362001)(33656002)(6506007)(55016002)(9686003)(26005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 27fMUXCvH7ubqY6qGuHz3/uGPFOvJBJNYrA9qMkBbV/Jp6uLVg+Wi6dxoE8KleATV87C8wZB5j25620jZgB0AU9nDvV9CSsXlOj8dLkq+LxNAVL5SmRYNjeuHFRjdElxKSuctVom9y89Bprm2TR3q0uAItLBBEkFAX85Xmwx1aTG/6/UzisBl9f74P/kDHRmZiBjQ03SPe8cuwoUXk6ZVIaU+VcjoALtopi3bsB9lsRV6jyEejItSIJ1Ce9eojUSZmHOlLmnwA5JhAeNF0KpRZOGdfxnL4qe9e9FnTfFXdcnaBuvuWzUxQebeeXpDGsaztukdsKRRM4did+3Iyx6jXmt7kieiRynaPDC1sj03eugvHCzyg0PYi8b7fZZ2CgA91J+qNG/412HVDdLXcDuvttt+/YV94ITpPdwfj5FFQXzuMfmpFmjtJ0hsPwL3lvujT5SiKm8QTg/OF0/3ZlosqtJafRH4CmlUpl/uXIv6wJSavW4P/lE0rI7bgTTCpJs
x-ms-exchange-antispam-messagedata: TaqxIVYW/5UVHVPAijbF+WGndx+Y9aI69M7fx8LAe2zH+eBHaT0qT+BLaNHukv9xg7ok7qT7coTTniGe38bCWewQ/1JD5UZRVJxPilqGkhD270Rzk1S33DcKgqOMmB6biUf0ZG/AoO3+kAaB36vFofldvx8gKSJfoO5FHNLEnyO1COzboK7RlTlaLRvdVlhm2x7Ycew64KKT64TN+T3K0bacNRxWRkSNsUckb7IeFl/o3l+FCHCidzQchg9g+11fVnu5miwffVaHXM9WHk5AT5FxO77+K9GiKi4BpT1Y8/ShJuz7qZ/8gFatzcQ21/12urifBEhfGoU/RMz4e4ZUAaAmx9cE8V69kbLLtv0C0VcBkcOcPOCCfqYm2SsQRF31h67XZ502NfoHYxr+tmVQMhXEESbl8e9b6El9d0P4ZdohgGM2R+Y1U7eRHZSoneZdSySbF9pO7Fv4P3Wlz3sjSmEadeanpLhl+QcfWiZmlN2vF9hMNXQq+YBfl3Q28Wsf395NtKboGAt+5cRJiwRXnWJ3BumqI8X3eG8lnocPURvY/PlhnEULEA8hyXz2ww9Ed34vCXlaERuNBYlRKu9e/FUkjOtqWExU4W0fQeAbRapxqKlZGd/gkvta9r5svE2BT7uAgsdUZ8pUoZcE4QnrGpnxUI45X/oVhLZkRKY12E37vLymkYg/btqOXvHUiXUwxWRpbqWjrg4chLlDWCbihv+5WD/Pk0V3iCzy7qjU1aFpSsoY3m/iQCTEG42L6v1bcGZPU6qaMiEVEiwZMfudd0EEIXyZHVyobi/oBRGwOH8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0370aed9-6379-46d7-86fe-08d7eb4c5d7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2020 08:15:51.4374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QzgIg8OdcNGRDe8spIzJ/Im50v79OxmXSFsKPLaWaAB2QzmatilulkJgpgjIGdYlIUTQ0Ep8HqNC7cZA8prHDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5573
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBYmVsIFZlc2EgPGFiZWwudmVzYUBueHAuY29tPg0KPiBTZW50OiBNb25kYXksIEFw
cmlsIDI3LCAyMDIwIDExOjExIFBNDQo+IA0KPiBJbnN0ZWFkIG9mIGlwZ19yb290LCB0aGUgcGFy
ZW50IG5lZWRzIHRvIGJlIGlwZ19hdWRpb19yb290Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWJl
bCBWZXNhIDxhYmVsLnZlc2FAbnhwLmNvbT4NCg0KSSBoYXZlIGEgZmV3IGRvdWJ0cyBhYm91dCB0
aGlzIHBhdGNoOg0KMS4gRnJvbSBsYXRlc3QgUk0sIGl0IHNlZW1zIENDR1IxMDEgKDB4NDY1MCkg
aXMgYSBzaGFyZWQgZ2F0ZSBmb3IgbWFueSBhdWRpbyBpbnN0YW5jZXMuDQoyLiBJZiB0aGlzIHBh
dGNoIGlzIGFib3V0IEFVRElPX0FIQl9DTEtfUk9PVCwgdGhlbiBpdCdzIHBhcmVudCBpcyBBSEJb
UE9TVF9QT0RGXSBmcm9tIHRoZSBjbG9jayB0cmVlIGluIFJNLg0KTm90IHF1aXRlIHVuZGVyc3Rh
bmQgd2h5IHRoaXMgcGF0Y2ggY2hhbmdlcyB0byBJUEdbUE9TVF9QT0RGXS4gSXMgdGhpcyBSTSBp
bmNvcnJlY3QgaXNzdWU/DQoNCkJUVywgaWYgdGhpcyBwYXRjaCBpcyB0YWtlbiBmcm9tIHNvbWVv
bmUgZWxzZSwgd2UgdXN1YWxseSBiZXR0ZXIga2VlcCB0aGUgb3JpZ2luYWwgYXV0aG9yIGlmIG5v
dCBmdW5kYW1lbnRhbCBjaGFuZ2VzLg0KDQpSZWdhcmRzDQpBaXNoZW5nDQoNCj4gLS0tDQo+ICBk
cml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtcC5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9j
bGsvaW14L2Nsay1pbXg4bXAuYyBiL2RyaXZlcnMvY2xrL2lteC9jbGstaW14OG1wLmMgaW5kZXgN
Cj4gNDE0NjllMi4uZGNkZmM5ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jbGsvaW14L2Nsay1p
bXg4bXAuYw0KPiArKysgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtcC5jDQo+IEBAIC03Mjcs
NyArNzI3LDcgQEAgc3RhdGljIGludCBpbXg4bXBfY2xvY2tzX3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UNCj4gKnBkZXYpDQo+ICAJaHdzW0lNWDhNUF9DTEtfSERNSV9ST09UXSA9IGlteF9j
bGtfaHdfZ2F0ZTQoImhkbWlfcm9vdF9jbGsiLA0KPiAiaGRtaV9heGkiLCBjY21fYmFzZSArIDB4
NDVmMCwgMCk7DQo+ICAJaHdzW0lNWDhNUF9DTEtfVFNFTlNPUl9ST09UXSA9DQo+IGlteF9jbGtf
aHdfZ2F0ZTQoInRzZW5zb3Jfcm9vdF9jbGsiLCAiaXBnX3Jvb3QiLCBjY21fYmFzZSArIDB4NDYy
MCwgMCk7DQo+ICAJaHdzW0lNWDhNUF9DTEtfVlBVX1JPT1RdID0gaW14X2Nsa19od19nYXRlNCgi
dnB1X3Jvb3RfY2xrIiwNCj4gInZwdV9idXMiLCBjY21fYmFzZSArIDB4NDYzMCwgMCk7DQo+IC0J
aHdzW0lNWDhNUF9DTEtfQVVESU9fUk9PVF0gPSBpbXhfY2xrX2h3X2dhdGU0KCJhdWRpb19yb290
X2NsayIsDQo+ICJpcGdfcm9vdCIsIGNjbV9iYXNlICsgMHg0NjUwLCAwKTsNCj4gKwlod3NbSU1Y
OE1QX0NMS19BVURJT19ST09UXSA9IGlteF9jbGtfaHdfZ2F0ZTQoImF1ZGlvX3Jvb3RfY2xrIiwN
Cj4gKyJpcGdfYXVkaW9fcm9vdCIsIGNjbV9iYXNlICsgMHg0NjUwLCAwKTsNCj4gDQo+ICAJaHdz
W0lNWDhNUF9DTEtfQVJNXSA9IGlteF9jbGtfaHdfY3B1KCJhcm0iLCAiYXJtX2E1M19jb3JlIiwN
Cj4gIAkJCQkJICAgICBod3NbSU1YOE1QX0NMS19BNTNfQ09SRV0tPmNsaywNCj4gLS0NCj4gMi43
LjQNCg0K
