Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58660C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 06:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 230D52065D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 06:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=oppoglobal.onmicrosoft.com header.i=@oppoglobal.onmicrosoft.com header.b="y+7ZCw7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgGIGuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 02:50:25 -0400
Received: from mail-eopbgr1310059.outbound.protection.outlook.com ([40.107.131.59]:31244
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726193AbgGIGuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 02:50:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGom73Apgfp5kL7x+VhF3aCbUCcrjbL1XTROY5Vw8bl4XcMYNgbjhEiMdIigHv2jo6/xnNxYJcQ5763GvAYBHhiMJyVh2OVyo2PoZo3wKlOWIDTZtM94imUBcoJp2C6LfcOGSqtgr8zgB0jkyTqDti6Ef85YuVoOCIZ4QFd62neToG6WBJwQeuMOS/tn6iR0jHCDWTZ1mXTdr3f+RKlKe4PNk/g7j1GsjrHXt557c18gaLTcWzbfyEfChkGZB6vbKQgUat3oQutvvpjSrBKHZhzguVx/mVTZXPo2jSIv3Gf0+0qD7cTD3FnYXqnaXa33Be4lOdcQofCrWyPCbGORMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ptm4385sTAGSEghmi92tIifSw4Czl6yO3w72PMMVdk=;
 b=B0j6QsfchzrjR/lBG26NUpFH0Ah+6X1iU8K8Q4eb2Qa+E+h7doSF4n/zFHRcc4vp8uheUpKgc0VTGj6y+H+/ctxjzmOUUpvwHOSHWAjDeBrrY/uu/wkf/wvAQV0lTNvC5xzVR8M0lPmZfOq0pPkSnhxuLpC9rXAVUzb7/hS+oAHf9oIQrlposY6mJkeTxIAvJt3X8NF/i15z1acr8kYKlSVhP9J+GvVSEkLfhmy646xzhlCl+g9UijnYjd3EfK8uOqyI4M3fXfb+fOg9DsrB56CMgGo1j2s4w2a9u/j+ZhrueunulWA+SfnlyQNYfzLiRvN6N4UU5us+9RHAYTCjjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ptm4385sTAGSEghmi92tIifSw4Czl6yO3w72PMMVdk=;
 b=y+7ZCw7s3xz19G40MhJy+z0BwcXullpkhDUSUd17W+uZA9cvnlo9SWm669eUnELoYGiQks2uf0HJPbzAF5LMykqi7NLsnpxlD7nPhE2DKmeU2Pd/wZbF3CR3ZVpuszf5zX2xdHEJ7e/EVtZzHTSL4hmP39bR3Lxi8UhURZ0EHmA=
Received: from HKAPR02MB4291.apcprd02.prod.outlook.com (2603:1096:203:d3::12)
 by HKAPR02MB4385.apcprd02.prod.outlook.com (2603:1096:203:dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 9 Jul
 2020 06:50:19 +0000
Received: from HKAPR02MB4291.apcprd02.prod.outlook.com
 ([fe80::d4d8:820c:6e00:69d2]) by HKAPR02MB4291.apcprd02.prod.outlook.com
 ([fe80::d4d8:820c:6e00:69d2%8]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 06:50:19 +0000
From:   =?utf-8?B?5b2t5rWpKFJpY2hhcmQp?= <richard.peng@oppo.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Will Deacon <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re:[PATCH] arm64/module-plts: Consider the special case where
 plt_max_entries is 0
Thread-Topic: [PATCH] arm64/module-plts: Consider the special case where
 plt_max_entries is 0
Thread-Index: AdZVux2xeZHZhkZuS3KXfzL8ZpsgRA==
Date:   Thu, 9 Jul 2020 06:50:18 +0000
Message-ID: <HKAPR02MB42915BECBD71F5ABA0890533E0640@HKAPR02MB4291.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oppo.com;
x-originating-ip: [58.255.79.102]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c28d740d-7a4f-4ca8-da1b-08d823d45812
x-ms-traffictypediagnostic: HKAPR02MB4385:
x-microsoft-antispam-prvs: <HKAPR02MB4385C26B2587556B5DE61CF8E0640@HKAPR02MB4385.apcprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n6tGp/5/6D3K0bTl6ApuuK8Z10YSALTZyvPKqN2jA+7tehhNPNmvkGNuBGeEPGGVUnyywrgMnNSOsV5VFXDx1k1Qi5Tq60GH10gpFTIuMkgnXS4UAeF4DF5f2BnTAckHru8JLkw8985Q+4X6axfWS7/yayd3XUDuCfcH25pkUZr0yPansodHfTdVzAT4R/S+eHmsR8xx42/mcyuWIcu6y8SPBcQJb14xwA/MIvPp/AU9ibo9uD2qN/DpDIlg3koCA0oQtL3WDkiqmFdGF1rwvPV3xufyryN0mE9V0OoxT6ZUDKrRDOnca/2BZXxJFFk7LiLqfATRZ3chYGjPfp6btl6vYVbgdg8mtNNqs1Ervz+0AFZrSMD+B3fnrwgWidMB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HKAPR02MB4291.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(396003)(346002)(136003)(366004)(39860400002)(478600001)(8676002)(2906002)(66946007)(66476007)(66556008)(64756008)(66446008)(5660300002)(52536014)(6916009)(316002)(26005)(8936002)(6506007)(4326008)(7696005)(55016002)(54906003)(9686003)(186003)(85182001)(86362001)(71200400001)(83380400001)(76116006)(33656002)(11606004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: hSZ8KIGtj6k2VMhXwc8AB5JDbpdNX7QtKmDQWjdlqhnEadt2c2b1bmuJhgZGj6+PN7fUAi5/1BnxaePGKEUYn2G47fnyispNFBog6a8fabcQjc7e/1Ou17ReR/pg4ftg0Y4Voi+GgenH/nxPM6cXde4AWRmfGOioC+SIBN+fuyau6RmdESSXS6Wh9B196U1YLW7+8NxfMzVuY8iKuZxkalWFoJmoOtOQssuEugzG/Q0JTZ5lvzXon3SQnOe3Jcyrq5TjzOnPJ0XA9W7tPVheEV8BSoX2xbn3HLGxQO83PIq/QF0+RUK/i9OeZiqaCdFeJo52rvUO4j/hmNpKeKwHjEgsZAb4cdBWDWfQHCbuYsiqLzU3ZGiqjzHWyBhBl0Uh984iLIU9BiynOexHdhkX5pndB4VRbw7HTw579poMDpK7lZyNv0KF0WeQlnln9416bYymjJJCecuB+sipCywmTeWYApUVDSn6xkx3748pkas=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HKAPR02MB4291.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c28d740d-7a4f-4ca8-da1b-08d823d45812
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2020 06:50:18.8473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G9LsaCuM30meNYxaupKmTOlXxHDu1SewmkwQc9HcjOF9ixgrYiPOxfVAiw3VnFTGNRuLeukBRIXemPeMRDIqGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HKAPR02MB4385
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCA4IEp1bCAyMDIwIGF0IDEzOjAzLCDlva3mtakoUmljaGFyZCkgPHJpY2hhcmQucGVu
Z0BvcHBvLmNvbT4gd3JvdGU6DQo+Pg0KPj4NCj4+IE9uIFR1ZSwgSnVsIDA3LCAyMDIwIGF0IDA3
OjQ2OjA4QU0gLTA0MDAsIFBlbmcgSGFvIHdyb3RlOg0KPj4gPj4gSWYgcGx0X21heF9lbnRyaWVz
IGlzIDAsIGEgd2FybmluZyBpcyB0cmlnZ2VyZWQuDQo+PiA+PiBXQVJOSU5HOiBDUFU6IDIwMCBQ
SUQ6IDMwMDAgYXQgYXJjaC9hcm02NC9rZXJuZWwvbW9kdWxlLXBsdHMuYzo5NyBtb2R1bGVfZW1p
dF9wbHRfZW50cnkrMHhhNC8weDE1MA0KPj4gPg0KPj4gPiBXaGljaCBrZXJuZWwgYXJlIHlvdSBz
ZWVpbmcgdGhpcyB3aXRoPyBUaGVyZSBpcyBhIFBMVC1yZWxhdGVkIGNoYW5nZSBpbg0KPj4gPiBm
b3ItbmV4dC9jb3JlLCBhbmQgSSdkIGxpa2UgdG8gcnVsZSBpZiBvdXQgaWYgcG9zc2libGUuDQo+
PiA+DQo+PiA1LjYuMC1yYzMrDQo+PiA+PiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEhhbyA8cmljaGFy
ZC5wZW5nQG9wcG8uY29tPg0KPj4gPj4gLS0tDQo+PiA+PiAgYXJjaC9hcm02NC9rZXJuZWwvbW9k
dWxlLXBsdHMuYyB8IDMgKystDQo+PiA+PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPj4gPj4NCj4+ID4+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2tl
cm5lbC9tb2R1bGUtcGx0cy5jIGIvYXJjaC9hcm02NC9rZXJuZWwvbW9kdWxlLXBsdHMuYw0KPj4g
Pj4gaW5kZXggNjViMDhhNzRhZWM2Li4xODY4YzlhYzEzZjIgMTAwNjQ0DQo+PiA+PiAtLS0gYS9h
cmNoL2FybTY0L2tlcm5lbC9tb2R1bGUtcGx0cy5jDQo+PiA+PiArKysgYi9hcmNoL2FybTY0L2tl
cm5lbC9tb2R1bGUtcGx0cy5jDQo+PiA+PiBAQCAtNzksNyArNzksOCBAQCB1NjQgbW9kdWxlX2Vt
aXRfcGx0X2VudHJ5KHN0cnVjdCBtb2R1bGUgKm1vZCwgRWxmNjRfU2hkciAqc2VjaGRycywNCj4+
ID4+ICAgICAgaW50IGkgPSBwbHRzZWMtPnBsdF9udW1fZW50cmllczsNCj4+ID4+ICAgICAgaW50
IGogPSBpIC0gMTsNCj4+ID4+ICAgICAgdTY0IHZhbCA9IHN5bS0+c3RfdmFsdWUgKyByZWxhLT5y
X2FkZGVuZDsNCj4+ID4+IC0NCj4+ID4+ICsgICAgaWYgKHBsdHNlYy0+cGx0X21heF9lbnRyaWVz
ID09IDApDQo+PiA+PiArICAgICAgICAgICAgcmV0dXJuIDA7DQo+PiA+DQo+PiA+SG1tLCBidXQg
aWYgdGhlcmUgYXJlbid0IGFueSBQTFRzIHRoZW4gaG93IGRvIHdlIGVuZCB1cCBoZXJlPw0KPj4g
Pg0KPj4gV2UgYWxzbyByZXR1cm5lZCAwIHdoZW4gd2FybmluZyB3YXMgdHJpZ2dlcmVkLg0KPg0K
PlRoYXQgZG9lc24ndCByZWFsbHkgYW5zd2VyIHRoZSBxdWVzdGlvbi4NCj4NCj5BcHBhcmVudGx5
LCB5b3UgYXJlIGhpdHRpbmcgYSBSX0FBUkNINjRfSlVNUDI2IG9yIFJfQUFSQ0g2NF9DQUxMMjYN
Cj5yZWxvY2F0aW9uIHRoYXQgb3BlcmF0ZXMgb24gYSBiIG9yIGJsIGluc3RydWN0aW9uIHRoYXQg
aXMgbW9yZSB0aGFuDQo+MTI4IG1lZ2FieXRlcyBhd2F5IGZyb20gaXRzIHRhcmdldC4NCj4NCk15
IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCBhIG1vZHVsZSB0aGF0IGNhbGxzIGZ1bmN0aW9ucyB0aGF0
IGFyZSBub3QgcGFydCBvZiB0aGUgbW9kdWxlIHdpbGwgdXNlIFBMVC4NClBsdF9tYXhfZW50cmll
cyA9MCBNYXkgb2NjdXIgaWYgYSBtb2R1bGUgZG9lcyBub3QgZGVwZW5kIG9uIG90aGVyIG1vZHVs
ZSBmdW5jdGlvbnMuDQoNCj5JbiBtb2R1bGVfZnJvYl9hcmNoX3NlY3Rpb25zKCksIHdlIGNvdW50
IGFsbCBzdWNoIHJlbG9jYXRpb25zIHRoYXQNCj5wb2ludCB0byBvdGhlciBzZWN0aW9ucywgYW5k
IGFsbG9jYXRlIGEgUExUIHNsb3QgZm9yIGVhY2ggKGFuZCB1cGRhdGUNCj5wbHRfbWF4X2VudHJp
ZXMpIGFjY29yZGluZ2x5LiBTbyB0aGlzIG1lYW5zIHRoYXQgdGhlIHJlbG9jYXRpb24gaW4NCj5x
dWVzdGlvbiB3YXMgZGlzcmVnYXJkZWQsIGFuZCB0aGlzIGNvdWxkIGhhcHBlbiBmb3Igb25seSB0
d28gcmVhc29uczoNCj4tIHRoZSBicmFuY2ggaW5zdHJ1Y3Rpb24gYW5kIGl0cyB0YXJnZXQgYXJl
IGJvdGggaW4gdGhlIHNhbWUgc2VjdGlvbiwNCj5pbiB3aGljaCBjYXNlIHRoaXMgc2VjdGlvbiBp
cyAqcmVhbGx5KiBsYXJnZSwNCj4tIENPTkZJR19SQU5ET01JWkVfQkFTRSBpcyBkaXNhYmxlZCwg
YnV0IHlvdSBhcmUgc3RpbGwgZW5kaW5nIHVwIGluIGENCj5zaXR1YXRpb24gd2hlcmUgdGhlIG1v
ZHVsZXMgYXJlIHJlYWxseSBmYXIgYXdheSBmcm9tIHRoZSBjb3JlIGtlcm5lbA0KPm9yIGZyb20g
b3RoZXIgbW9kdWxlcy4NCj4NCj5EbyB5b3UgaGF2ZSBhIGxvdCBvZiBbbGFyZ2VdIG1vZHVsZXMg
bG9hZGVkIHdoZW4gdGhpcyBoYXBwZW5zPw0KSSBkb27igJl0IHRoaW5rIEkgaGF2ZSBbbGFyZ2Vd
IG1vZHVsZXMuICBJJ2xsIHRyYWNlIHdoaWNoIG1vZHVsZSBjYXVzZWQgdGhpcyB3YXJuaW5nLg0K
VGhhbmtzLg0K
