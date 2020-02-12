Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15F9C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C56E20714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="B2xAR/Ja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgBLOzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 09:55:12 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.1]:62668 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727231AbgBLOzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:55:12 -0500
Received: from [100.112.193.253] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-west-1.aws.symcld.net id 4A/AB-61435-DC1144E5; Wed, 12 Feb 2020 14:55:09 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCJsWRWlGSWpSXmKPExsWSoc9mqntW0CX
  O4M9KKYupD5+wWWzdo2rx7UoHk8XlXXPYHFg81h1U9dg56y67x6ZVnWwenzfJBbBEsWbmJeVX
  JLBmNPybyFzQKl3x5vYWpgbGG1JdjFwcjAJLmSU6Ox4zQTjHWCS+Xu1ngXA2M0r87v3JBuKwC
  Jxglni24BsriCMkMIlJ4v2B51DOXUaJSTN/AQ3g5GATsJCYfOIBWIuIwBNGib0XzoIlmAUcJW
  7vfQtmCwvESjQ1P2cGsUUE4iQm33zGCmE7Sdy62MrexcgBtE9VoqPDDCTMC1S+5EYPC4gtJLC
  DUeLm3jIQmxOo/PyVSWBxRgFZiS+Nq5khVolL3HoyH2yVhICAxJI955khbFGJl4//sULUp0qc
  bLrBCBHXkTh7/QmUrSix59xCqF5ZiUvzu6HivhLNTa/ZIWwtif7jz6FqLCSWdLeygJwsIaAi8
  e9QJUQ4R+LfxCNQ5WoS5xuvs0HYMhKrZ64Dh5uEwCIWifdH1rJMYDSYheTsWUCjmAU0Jdbv0o
  cIK0pM6X7IPgscEoISJ2c+YVnAyLKK0SKpKDM9oyQ3MTNH19DAQNfQ0EjX0NJU18jAQC+xSjd
  RL7VUtzy1uETXUC+xvFivuDI3OSdFLy+1ZBMjMCmlFBw+sYPx6PL3eocYJTmYlER5p/x2jhPi
  S8pPqcxILM6ILyrNSS0+xCjDwaEkwWvO7xInJFiUmp5akZaZA0yQMGkJDh4lEd4HIGne4oLE3
  OLMdIjUKUZjjgkv5y5i5jgyd+kiZiGWvPy8VClxXm8BoFIBkNKM0jy4QbDEfYlRVkqYl5GBgU
  GIpyC1KDezBFX+FaM4B6OSMK8AyBSezLwSuH2vgE5hAjrluokDyCkliQgpqQYmlonSxXG3nz5
  1kHuikcF9JevEzfXZu1iUVonO3ZTZzJom6vwlfM00kdvMdqHBwrODXyWfZzHcG7N7p9uK8Fum
  ypYP367v/Wsx5UxP4I/JcysPZAZsejv5yJQE9l/bwvI3mz7NDvL6ciTkUL1l4f0Z7mUbudvKl
  szpM5zbYvL5l9IDj4ytK6qDtk9ICrp7MecZ/+yc6WvrZTa845LMS99l99qMu87tjOUBae5di6
  yFUq9edRCu0xSOXLHda8ZOYaG3ezddOzrF7K1b10vWSb+tTfdYax4tMD38yC/xeueWMxMY5r3
  J//xeu2A325LzKo16B79YP3T66fFK7PVbzeP/nhx/dPKI3fbWkDkvL7g/36/EUpyRaKjFXFSc
  CACwhUZ3VwQAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-34.tower-268.messagelabs.com!1581519308!2357625!1
X-Originating-IP: [104.47.6.53]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.25; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14251 invoked from network); 12 Feb 2020 14:55:09 -0000
Received: from mail-ve1eur02lp2053.outbound.protection.outlook.com (HELO EUR02-VE1-obe.outbound.protection.outlook.com) (104.47.6.53)
  by server-34.tower-268.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 12 Feb 2020 14:55:09 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ig6Ue8s/ci4dkH7uRW7Od0e+1O8ywJnfrP4ZIvNcQGWP9em8VF7Os9vCALDf2poTYNYwKkbUT9iGvV8YxA+/KcKkeLnieQMQF2ik0UdxBvYrp4LN/d2hwBrZ0gQZfEgYgDJrjLv7RNc5VMZDLiyRiKHCrHJVFigm+Hv6JaIfmlCNo2iIYNdObWkFdWnQDbAUd/X/mJgMJ0MUscuuiVMFAHHLgwlbz9DyHFe3k1qP2+eZpz3HyxZF8iOgfF3CADZZ0yC+m3yaXsD9XTsR+HX+SZ1wOda1MFqBD/lP1zS0jAXHo2bO4ZI8j2VRcv6c+YuiH08T9OisIAjheo0q0DuOEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwQeRyCo0BUVUFak/rinZ2bRnzoaJIKIl0Gta01BDbM=;
 b=fKPnlAMAn8ODqseYGbNOfMQqjKIoYZ18uctscj5GY2xC6yi9cmyVgvG56yJxLsPM1BQdgwlm7dxm+LIwcopxmidG99kUHIbHazZxFzHjKEwthmy3XMBEIIKd0WLtr6GAiGSZBWIICXf3bBn5c88TNbjNLwbtP4OXnmJSaxCmtZKTG0NVaKw1W6ty4VoTXbW1N7W2PQZv3v1Fc2UxW7/nW53tNS1zMpH21nz+A8qKCWVh/cAxY1H6+3KadXf79U/WvSnbchmL4CNvxN+9lR/7/Cc6p+Y4d4zhnmzNr10DyfFAKNT1r0XGCL4VCH8m3YmNRrFvDxy6ZuKMbY/MC/TQqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwQeRyCo0BUVUFak/rinZ2bRnzoaJIKIl0Gta01BDbM=;
 b=B2xAR/Ja1RTwpiyDCTPWQrrRBH1uJXwJEc02QALIC4G7EKWZfDJDDCN42U2kErHe4UJWTgtFqOwPshexWNf/JEqATi+wL96Y9VCRrFKdBP29cRvP4LptHf84qriAp4PG9bbSLFhdyrNhIgsKlgK+sKjjbJcf3Ehj4ga1NFCFzuI=
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM (20.177.116.141) by
 AM6PR10MB1959.EURPRD10.PROD.OUTLOOK.COM (52.134.113.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 12 Feb 2020 14:55:07 +0000
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01]) by AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::993f:cdb5:bb05:b01%7]) with mapi id 15.20.2729.021; Wed, 12 Feb 2020
 14:55:07 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] regulator: da9062: Replace zero-length array with
 flexible-array member
Thread-Topic: [PATCH] regulator: da9062: Replace zero-length array with
 flexible-array member
Thread-Index: AQHV4TUreejcs7A9gECFZGoa0zFcsagXZ9LQgAA3LoCAAAapsA==
Date:   Wed, 12 Feb 2020 14:55:07 +0000
Message-ID: <AM6PR10MB2263140BCCAEDB6BC0D258E8801B0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
References: <20200211234612.GA28682@embeddedor>
 <AM6PR10MB22630DDD54D581091C3C99A9801B0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
 <b5270b23-45aa-9830-7249-272e82454280@embeddedor.com>
In-Reply-To: <b5270b23-45aa-9830-7249-272e82454280@embeddedor.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.85]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af9de6e1-51db-4307-1f7b-08d7afcb8d29
x-ms-traffictypediagnostic: AM6PR10MB1959:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR10MB1959010921828A1D40EAA442A71B0@AM6PR10MB1959.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(199004)(189003)(4326008)(66556008)(64756008)(76116006)(66446008)(66476007)(5660300002)(33656002)(52536014)(8676002)(81166006)(9686003)(66946007)(8936002)(81156014)(71200400001)(55236004)(316002)(55016002)(966005)(110136005)(86362001)(53546011)(478600001)(2906002)(26005)(6506007)(186003)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR10MB1959;H:AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QJw2OxwmalKwKaaMaPMSi/dmb0SyT370yYunLug2ju1hkIvUIw1lunpzxMf0u8R/pgAQPiif2pSjjl2lXeWicYyl93cBCMJ8BAhawXJKsPe6Sq1wlp5BRFNyyeYkuYPkFBNiotfgVFwxBVev9DNXzMWyehDEbwbhUvKgpEYFnQvGBS4r5+jbv/NdGpPJEdOwPuKljcP76MzeAWimE1ayDLY2APLArvu0sfWZXUFkkXHd2LUmioAeuJ0qqchvFX0rQoqEZ4BC2LHYO12uXOhC/rsUG5j+7l/jRIVqIUqnsw9kKq5Gz+zRO3b7IVXGGzpR5Vdx1H8+SofydmSnBqfKvAGdivz6as7SCl8IMmIB1Jq3vxmxuWX4tqHDH3p1HhpY2qjn5yvtab6q5wZpp8eOPx3f87up6/zySiZxczFWxEvaUBSrIqRHOYn4wu/ohFbXUDyh5EeA+2jQCNsYDjoERYHUC5VWh5KCA8SfghtLYlgOk32ahuZCRGTrhx5mSfqam9+c14RzxFuJZvCdnu7gnQ==
x-ms-exchange-antispam-messagedata: twxN5qDHLPKje2LN98nWU8xvE2vii8qcPxr7b9NUkjo5tm6LpT3QZaakDWy64e1nnhuSp95999d8W0VzBd9hEYQXRFJ9iVaY1h9Po3CVW3zD/nRbVBeHr94lsIdZ8HaEb7ZK7EwkDWounNycUHc+EQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9de6e1-51db-4307-1f7b-08d7afcb8d29
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 14:55:07.6559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k+fm7OX+sx2YGa4xYBgeQartWMRWKk48fH4nXtrcv+CpUIBoegJasXLlMVe/vUdxCFuZ4iF+pSJCFP41mReLHx7Ydxfcm/wqTixYM0k7YsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB1959
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIgRmVicnVhcnkgMjAyMCAxNDoyOSwgR3VzdGF2byBBLiBSLiBTaWx2YSB3cm90ZToNCg0K
PiBPbiAyLzEyLzIwIDA1OjEyLCBBZGFtIFRob21zb24gd3JvdGU6DQo+ID4gT24gMTEgRmVicnVh
cnkgMjAyMCAyMzo0NiwgR3VzdGF2byBBLiBSLiBTaWx2YSB3cm90ZToNCj4gPg0KPiA+PiBUaGUg
Y3VycmVudCBjb2RlYmFzZSBtYWtlcyB1c2Ugb2YgdGhlIHplcm8tbGVuZ3RoIGFycmF5IGxhbmd1
YWdlDQo+ID4+IGV4dGVuc2lvbiB0byB0aGUgQzkwIHN0YW5kYXJkLCBidXQgdGhlIHByZWZlcnJl
ZCBtZWNoYW5pc20gdG8gZGVjbGFyZQ0KPiA+PiB2YXJpYWJsZS1sZW5ndGggdHlwZXMgc3VjaCBh
cyB0aGVzZSBvbmVzIGlzIGEgZmxleGlibGUgYXJyYXkgbWVtYmVyWzFdWzJdLA0KPiA+PiBpbnRy
b2R1Y2VkIGluIEM5OToNCj4gPj4NCj4gPj4gc3RydWN0IGZvbyB7DQo+ID4+ICAgICAgICAgaW50
IHN0dWZmOw0KPiA+PiAgICAgICAgIHN0cnVjdCBib28gYXJyYXlbXTsNCj4gPj4gfTsNCj4gPj4N
Cj4gPj4gQnkgbWFraW5nIHVzZSBvZiB0aGUgbWVjaGFuaXNtIGFib3ZlLCB3ZSB3aWxsIGdldCBh
IGNvbXBpbGVyIHdhcm5pbmcNCj4gPj4gaW4gY2FzZSB0aGUgZmxleGlibGUgYXJyYXkgZG9lcyBu
b3Qgb2NjdXIgbGFzdCBpbiB0aGUgc3RydWN0dXJlLCB3aGljaA0KPiA+PiB3aWxsIGhlbHAgdXMg
cHJldmVudCBzb21lIGtpbmQgb2YgdW5kZWZpbmVkIGJlaGF2aW9yIGJ1Z3MgZnJvbSBiZWluZw0K
PiA+PiBpbmFkdmVydGVubHkgaW50cm9kdWNlZFszXSB0byB0aGUgY29kZWJhc2UgZnJvbSBub3cg
b24uDQo+ID4+DQo+ID4+IFRoaXMgaXNzdWUgd2FzIGZvdW5kIHdpdGggdGhlIGhlbHAgb2YgQ29j
Y2luZWxsZS4NCj4gPj4NCj4gPj4gWzFdIGh0dHBzOi8vZ2NjLmdudS5vcmcvb25saW5lZG9jcy9n
Y2MvWmVyby1MZW5ndGguaHRtbA0KPiA+PiBbMl0gaHR0cHM6Ly9naXRodWIuY29tL0tTUFAvbGlu
dXgvaXNzdWVzLzIxDQo+ID4+IFszXSBjb21taXQgNzY0OTc3MzI5MzJmICgiY3hnYjMvbDJ0OiBG
aXggdW5kZWZpbmVkIGJlaGF2aW91ciIpDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEd1c3Rh
dm8gQS4gUi4gU2lsdmEgPGd1c3Rhdm9AZW1iZWRkZWRvci5jb20+DQo+ID4+IC0tLQ0KPiA+PiAg
ZHJpdmVycy9yZWd1bGF0b3IvZGE5MDYyLXJlZ3VsYXRvci5jIHwgMiArLQ0KPiA+PiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4+DQo+ID4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3JlZ3VsYXRvci9kYTkwNjItcmVndWxhdG9yLmMgYi9kcml2ZXJzL3Jl
Z3VsYXRvci9kYTkwNjItDQo+ID4+IHJlZ3VsYXRvci5jDQo+ID4+IGluZGV4IGIwNjRkOGExOWQ0
Yy4uYzNiNmJhOWJhZmRmIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL3JlZ3VsYXRvci9kYTkw
NjItcmVndWxhdG9yLmMNCj4gPj4gKysrIGIvZHJpdmVycy9yZWd1bGF0b3IvZGE5MDYyLXJlZ3Vs
YXRvci5jDQo+ID4+IEBAIC04Niw3ICs4Niw3IEBAIHN0cnVjdCBkYTkwNjJfcmVndWxhdG9ycyB7
DQo+ID4+ICAJaW50CQkJCQlpcnFfbGRvX2xpbTsNCj4gPj4gIAl1bnNpZ25lZAkJCQluX3JlZ3Vs
YXRvcnM7DQo+ID4+ICAJLyogQXJyYXkgc2l6ZSB0byBiZSBkZWZpbmVkIGR1cmluZyBpbml0LiBL
ZWVwIGF0IGVuZC4gKi8NCj4gPj4gLQlzdHJ1Y3QgZGE5MDYyX3JlZ3VsYXRvcgkJCXJlZ3VsYXRv
clswXTsNCj4gPj4gKwlzdHJ1Y3QgZGE5MDYyX3JlZ3VsYXRvcgkJCXJlZ3VsYXRvcltdOw0KPiA+
DQo+ID4gSSBkb24ndCB0aGluayBpcyB0aGUgY29ycmVjdCBjaGFuZ2UgaGVyZSBmb3IgdGhpcyBk
cml2ZXIuIEluIHRoZSBwcm9iZQ0KPiA+ICdzdHJ1Y3Rfc2l6ZSgpJyBpcyB1c2VkIHRvIGRldGVy
bWluZSB0aGUgYWN0dWFsIHNpemUgcmVxdWVzdGVkIGZyb20gJ21hbGxvYygpJw0KPiA+IHdoZW4g
YWxsb2NhdGluZyBtZW1vcnkgZm9yIHRoaXMgc3RydWN0dXJlLiBJdCdzIG5vdCBzdGF0aWNhbGx5
IGluaXRpYWxpc2VkLg0KPiA+IFlvdXIgY2hhbmdlIHdpbGwgYnJlYWsgdGhhdCBjb2RlIEkgYmVs
aWV2ZS4NCj4gPg0KPiANCj4gRHluYW1pYyBtZW1vcnkgYWxsb2NhdGlvbnMgd29uJ3QgYmUgYWZm
ZWN0ZWQgYnkgdGhpcyBjaGFuZ2U6DQo+IA0KPiAiRmxleGlibGUgYXJyYXkgbWVtYmVycyBoYXZl
IGluY29tcGxldGUgdHlwZSwgYW5kIHNvIHRoZSBzaXplb2Ygb3BlcmF0b3INCj4gbWF5IG5vdCBi
ZSBhcHBsaWVkLiBBcyBhIHF1aXJrIG9mIHRoZSBvcmlnaW5hbCBpbXBsZW1lbnRhdGlvbiBvZg0K
PiB6ZXJvLWxlbmd0aCBhcnJheXMsIHNpemVvZiBldmFsdWF0ZXMgdG8gemVyby4iWzFdDQo+IA0K
PiBbMV0gaHR0cHM6Ly9nY2MuZ251Lm9yZy9vbmxpbmVkb2NzL2djYy9aZXJvLUxlbmd0aC5odG1s
DQoNClllYWgsIG9rIG1pc2ludGVycHJldGVkIHRoZSBkZXNjcmlwdGlvbnMgaW4gdGhlcmUuIElu
IHdoaWNoIGNhc2U6DQoNCkFja2VkLWJ5OiBBZGFtIFRob21zb24gPEFkYW0uVGhvbXNvbi5PcGVu
c291cmNlQGRpYXNlbWkuY29tPg0KDQo+IA0KPiBUaGFua3MNCj4gLS0NCj4gR3VzdGF2bw0K
