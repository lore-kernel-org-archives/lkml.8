Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E83C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD90220771
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="UDU/xe7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbgHKRYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 13:24:11 -0400
Received: from mail-eopbgr1410139.outbound.protection.outlook.com ([40.107.141.139]:32672
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729150AbgHKRYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 13:24:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gR/Y0EV2uyFDhsCyHfsYZCUwp6PJOkPlscFGVfDbXn/CD5PHRd/rt5BrdC0bJS3GnDWb7gKEGdBmN/KOQacbhS7KvgT+DC14KaP3le1yMGVdNUL3Yr+ZHd69nkpW/ipKzXNZHVYYvUAMMpWzOb8lq9BnkpuRb0uOsrdzw0AIO3BG10/ofbCOQEUE62cXngqyB7IC9rrhc/h8VXx2AEwNPOijldOq9V4gnOoYoPJ9NIj/LtZE/5Aeg/sEDJsKul9UTLLQ9JCjt0aoySW6OmqR/7mqZIlNrCWwj4IkG655rwrF2Of9QM59sJyFNgnDCgNDL78wtUsWKdEswsi1aV85gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0ys1t35BYfp9h9bmhMfSRGN2u4SSeV01D06e1mFTRk=;
 b=Do5pW9lzsf/g2V7lgyiQ5HS8ybPGkyT8Dtpa4DM4CFnaR+wIUSAuFi4L7Ba1gLOrabhh+xKLPmrszHTed2kGBovR2gQe9J7S+55rfUZT/SPcCzQkqRRhKjLmiwlWmorSCZBLKj2MsTx1df6mvF9r9/pLd9cmrfU0HRa/wWkLZXRRdyB5vjIHTElvHbkRf4mpkDIvv0ab/KduCz2O7EIqXn3JWAJUFSzTOq0qctk8AJzh3kzAcbPBhwXuzJOoQ49R9oQ/dj7mWoF2Yu66pRpt/xFdWiwM9D86S6wKefgdmGDYPM67gWdn3z9KzYzg5GyLc7dRNODC1dQBcGGq/y9AdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0ys1t35BYfp9h9bmhMfSRGN2u4SSeV01D06e1mFTRk=;
 b=UDU/xe7FWfnnl/wcEoSolIPDulgHxFmYUPChCmITq2BtMwqqAcNZlbjwc0hvcHAwMSGXTzSGRX1m3wxWgPMmR+LDQGkDLEL6FVyiiHZr/bUTBEW51DwfoxWQJbH1GK5eMbO+I3ouGiMKAXO10NitvW6NsG3UavBvDf1B9ZEpg6o=
Received: from TYAPR01MB2925.jpnprd01.prod.outlook.com (2603:1096:404:86::14)
 by TYAPR01MB1918.jpnprd01.prod.outlook.com (2603:1096:404:3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Tue, 11 Aug
 2020 17:24:06 +0000
Received: from TYAPR01MB2925.jpnprd01.prod.outlook.com
 ([fe80::b50b:3f48:66a3:83e2]) by TYAPR01MB2925.jpnprd01.prod.outlook.com
 ([fe80::b50b:3f48:66a3:83e2%4]) with mapi id 15.20.3283.015; Tue, 11 Aug 2020
 17:24:06 +0000
From:   Grant Peltier <grant.peltier.jg@renesas.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Grant Peltier <grantpeltier93@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Adam Vaughn <adam.vaughn.xh@renesas.com>
Subject: RE: [PATCH] hwmon: (pmbus/isl68137) remove READ_TEMPERATURE_1
 telemetry for RAA228228
Thread-Topic: [PATCH] hwmon: (pmbus/isl68137) remove READ_TEMPERATURE_1
 telemetry for RAA228228
Thread-Index: AQHWb0UrInAd5DxpBUq/xIm5yPiLwKkzJ/sAgAABEOA=
Date:   Tue, 11 Aug 2020 17:24:06 +0000
Message-ID: <TYAPR01MB2925D8052837B51F9D40639DD8450@TYAPR01MB2925.jpnprd01.prod.outlook.com>
References: <20200810183627.GA5457@raspberrypi>
 <47df1832-86f6-bb51-0488-d1d9ab0e0b6f@roeck-us.net>
In-Reply-To: <47df1832-86f6-bb51-0488-d1d9ab0e0b6f@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3BlbHRpZXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy03Mzg0NDhiYi1kYmY3LTExZWEtODUxZS1mODM0NDEyNmE2NGJcYW1lLXRlc3RcNzM4NDQ4YmQtZGJmNy0xMWVhLTg1MWUtZjgzNDQxMjZhNjRiYm9keS50eHQiIHN6PSIyMzMxIiB0PSIxMzI0MTY0MDI0NDAxMjU3MzUiIGg9Im5remdXdE1OTzF4YTU5KzFJSjNPblh4SXhBZz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
authentication-results: roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [72.48.120.28]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4c339152-0545-49ca-ab25-08d83e1b59f5
x-ms-traffictypediagnostic: TYAPR01MB1918:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB1918C4CA30EA46EF97475362D8450@TYAPR01MB1918.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uiP+NcvAM/3R+ZMgjwqBFJdfXjqXUhQEypVX9h21OfGr31cFM8jKnb3SEdah0Gl0PUOVPN3A3xCXGlyn7R3YJOaes+EPmol24mmNp7vVHI0VhPoEaoSq5MOhcE8nPcXkZ25dikf5u8u7ASX4hVFBWGoE77VgSHTELSeJJgIwOI1tQUFfeSp4vj5X7FkySviHfMj3UTxCR5oLQOP8zdruXmguL10QKQ/IY81euvT0CvsflDrHm0BtuoB5G8778hhm2yTfZA33GZM3OllgL/H1O+jrffWKVJOrBMOdm3VPPJMHf78S2iH3/a8I8bAqzXMlQZJ9xsa4+JC6Civhx3xJpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB2925.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39850400004)(136003)(376002)(396003)(366004)(8936002)(7696005)(52536014)(26005)(55016002)(478600001)(186003)(33656002)(86362001)(53546011)(6506007)(83380400001)(9686003)(66476007)(66556008)(71200400001)(2906002)(66446008)(64756008)(76116006)(5660300002)(4326008)(107886003)(54906003)(66946007)(8676002)(316002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Adl5m9S1UXksfNNsA9VoJ6rPRXxplrv30mQSDnsOC7f73Gm8/FH/WJDe2gXWTT95RmL8B0Oqwjp+fFv6BdcyqlnrETSlkVUwQa5vVNLpNQczgFaBfhFYrbBOeH8VDRV84gcu9ptMCAwmzKPGSXRk5mJ2ma7dVkDErZkgMbGh6w/sYJdO7tFvnSIWO1szPtHYn9tMI5AnO6PdLGVEYBUFBCYPLvYvg5MgDEV3gXgM/NVADIGT1f8SHEeiK9eoHULIRsrq2DMBfLARoqOMn+wcQvTpp5mzLqnpBWasJK/UClEf5XI0CPqwK0jySjpWuQY2EL0eB8dyTHHSdRAySGTFru1ltVXY3sYe9uMP5jwcXHtGmSzN4zOLMEjJZI2t3Ml+LwC7a+ZZQeQNQQOU3K9F7m75TINI86MYRrPtueVmdMWD6LuxD32/vYLMgfS7MTu55xPqY7itZT+VTIJ6L/TAZoSzuXn1dstJx+8cI+Z+zlnOdmdLvyxAyljuNbjSK6hfbLcwn6XOunH9gPmTowyRcmErHNDpYt4DvyFvrZxNOEOp20WHnAJytN1hwmIkZy5Jn0oLXjdWPdU/62uG6G4po9Mr2l0607K1JsvYMyK+O3d95aPztb+AvkHGwpMg3blYMcUloHOYtF4v2a7rewIlnw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB2925.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c339152-0545-49ca-ab25-08d83e1b59f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2020 17:24:06.6037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kxwmxVrJl7gKxR23hny0PPFU1COjMnmyQQyt93J1xqJECqtPQmfPTuKNYU8eIyTw5tQAUmEL3UuZBkI8mDa+ynJDW2IXKn8UWTBPfmvzFT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB1918
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWgsIG15IGFwb2xvZ2llcy4gRHVseSBub3RlZCBmb3IgdGhlIGZ1dHVyZS4gVGhhbmtzIGZvciBj
YXRjaGluZyBpdC4NCg0KR3JhbnQNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206
IEd1ZW50ZXIgUm9lY2sgPGdyb2VjazdAZ21haWwuY29tPiBPbiBCZWhhbGYgT2YgR3VlbnRlciBS
b2Vjaw0KU2VudDogVHVlc2RheSwgQXVndXN0IDExLCAyMDIwIDEyOjE3IFBNDQpUbzogR3JhbnQg
UGVsdGllciA8Z3JhbnRwZWx0aWVyOTNAZ21haWwuY29tPg0KQ2M6IEdyYW50IFBlbHRpZXIgPGdy
YW50LnBlbHRpZXIuamdAcmVuZXNhcy5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBBZGFtIFZhdWdobiA8YWRhbS52YXVnaG4ueGhAcmVuZXNhcy5jb20+DQpTdWJqZWN0OiBSZTog
W1BBVENIXSBod21vbjogKHBtYnVzL2lzbDY4MTM3KSByZW1vdmUgUkVBRF9URU1QRVJBVFVSRV8x
IHRlbGVtZXRyeSBmb3IgUkFBMjI4MjI4DQoNCk9uIDgvMTAvMjAgMTE6MzYgQU0sIEdyYW50IFBl
bHRpZXIgd3JvdGU6DQo+IFBlciB0aGUgUkFBMjI4MjI4IGRhdGFzaGVldCwgUkVBRF9URU1QRVJB
VFVSRV8xIGlzIG5vdCBhIHN1cHBvcnRlZCANCj4gUE1CdXMgY29tbWFuZC4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEdyYW50IFBlbHRpZXIgPGdyYW50cGVsdGllcjkzQGdtYWlsLmNvbT4NCg0KUGxl
YXNlIGNvcHkgbGludXgtaHdtb25Admdlci5rZXJuZWwub3JnIG9uIGh3bW9uIHBhdGNoZXMuIFRo
aXMgcGF0Y2ggaXMgbm90IGluIHRoZSBod21vbiBwYXRjaHdvcmssIHdoaWNoIGluIGdlbmVyYWwg
YWxtb3N0IGd1YXJhbnRlZXMgdGhhdCBpdCBnZXRzIGxvc3Qgc2luY2UgSSB1c3VhbGx5IHB1bGwg
cGF0Y2hlcyBmcm9tIHRoZXJlLiBBcyBpdCBoYXBwZW5zLCB5b3UgYXJlIGx1Y2t5IHRoYXQgSSBu
b3RpY2VkLiBQYXRjaCBhcHBsaWVkLg0KDQpHdWVudGVyDQoNCj4gLS0tDQo+ICBkcml2ZXJzL2h3
bW9uL3BtYnVzL2lzbDY4MTM3LmMgfCA3ICsrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2h3
bW9uL3BtYnVzL2lzbDY4MTM3LmMgDQo+IGIvZHJpdmVycy9od21vbi9wbWJ1cy9pc2w2ODEzNy5j
IGluZGV4IDBjNjIyNzExZWY3ZS4uNThhYTk1YTNjMDEwIA0KPiAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9od21vbi9wbWJ1cy9pc2w2ODEzNy5jDQo+ICsrKyBiL2RyaXZlcnMvaHdtb24vcG1idXMv
aXNsNjgxMzcuYw0KPiBAQCAtNjcsNiArNjcsNyBAQCBlbnVtIHZhcmlhbnRzIHsNCj4gIAlyYWFf
ZG1wdnIxXzJyYWlsLA0KPiAgCXJhYV9kbXB2cjJfMXJhaWwsDQo+ICAJcmFhX2RtcHZyMl8ycmFp
bCwNCj4gKwlyYWFfZG1wdnIyXzJyYWlsX25vbnRjLA0KPiAgCXJhYV9kbXB2cjJfM3JhaWwsDQo+
ICAJcmFhX2RtcHZyMl9odiwNCj4gIH07DQo+IEBAIC0yNDEsNiArMjQyLDEwIEBAIHN0YXRpYyBp
bnQgaXNsNjgxMzdfcHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwNCj4gIAkJaW5mby0+
cGFnZXMgPSAxOw0KPiAgCQlpbmZvLT5yZWFkX3dvcmRfZGF0YSA9IHJhYV9kbXB2cjJfcmVhZF93
b3JkX2RhdGE7DQo+ICAJCWJyZWFrOw0KPiArCWNhc2UgcmFhX2RtcHZyMl8ycmFpbF9ub250YzoN
Cj4gKwkJaW5mby0+ZnVuY1swXSAmPSB+UE1CVVNfSEFWRV9URU1QOw0KPiArCQlpbmZvLT5mdW5j
WzFdICY9IH5QTUJVU19IQVZFX1RFTVA7DQo+ICsJCWZhbGx0aHJvdWdoOw0KPiAgCWNhc2UgcmFh
X2RtcHZyMl8ycmFpbDoNCj4gIAkJaW5mby0+cGFnZXMgPSAyOw0KPiAgCQlpbmZvLT5yZWFkX3dv
cmRfZGF0YSA9IHJhYV9kbXB2cjJfcmVhZF93b3JkX2RhdGE7IEBAIC0zMDQsNyArMzA5LDcgDQo+
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaTJjX2RldmljZV9pZCByYWFfZG1wdnJfaWRbXSA9IHsN
Cj4gIAl7InJhYTIyODAwMCIsIHJhYV9kbXB2cjJfaHZ9LA0KPiAgCXsicmFhMjI4MDA0IiwgcmFh
X2RtcHZyMl9odn0sDQo+ICAJeyJyYWEyMjgwMDYiLCByYWFfZG1wdnIyX2h2fSwNCj4gLQl7InJh
YTIyODIyOCIsIHJhYV9kbXB2cjJfMnJhaWx9LA0KPiArCXsicmFhMjI4MjI4IiwgcmFhX2RtcHZy
Ml8ycmFpbF9ub250Y30sDQo+ICAJeyJyYWEyMjkwMDEiLCByYWFfZG1wdnIyXzJyYWlsfSwNCj4g
IAl7InJhYTIyOTAwNCIsIHJhYV9kbXB2cjJfMnJhaWx9LA0KPiAgCXt9DQo+IA0KDQo=
