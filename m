Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C467CC3B1BF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 01:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E21208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 01:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oHYR04Ik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgBQBMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 20:12:53 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:60170 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726222AbgBQBMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 20:12:53 -0500
X-UUID: d35a437375f34227be253cbce3ef7a7e-20200217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Lh9SuXsoXIgCQPtOtQVyKQ6x8dYZMPou02hW1h58oYs=;
        b=oHYR04IkSyewp9FFoyzqZnZmCjk3Bsylf1M2/rA3Y5/TLHVqd+Oh/jxmkTG5n6XppS4qECGD9XNe0o1cExS5bqbJbFOwkTRq+XcCWeD60iHfsBpoMm7FkV0xUmC5ZKpiPvmBRUtINHszvofS0AUOhO+S3hAjeK4tAuKGL32ECU0=;
X-UUID: d35a437375f34227be253cbce3ef7a7e-20200217
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1948028291; Mon, 17 Feb 2020 09:12:41 +0800
Received: from mtkmbs05n1.mediatek.inc (172.21.101.15) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 17 Feb 2020 09:11:29 +0800
Received: from mtkmbs05n1.mediatek.inc ([fe80::f180:c10f:28d5:1124]) by
 mtkmbs05n1.mediatek.inc ([fe80::f180:c10f:28d5:1124%12]) with mapi id
 15.00.1395.000; Mon, 17 Feb 2020 09:11:42 +0800
From:   =?gb2312?B?Q0sgSHUgKLr6v6G54ik=?= <ck.hu@mediatek.com>
To:     Fabien Parent <fparent@baylibre.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?gb2312?B?WW9uZyBXdSAozuLTwik=?= <Yong.Wu@mediatek.com>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: RE: [PATCH 2/2] iommu/mediatek: add support for MT8167
Thread-Topic: [PATCH 2/2] iommu/mediatek: add support for MT8167
Thread-Index: AQHVwlKhjAe75oxeWkCtHzZhijevaKge2YNg
Date:   Mon, 17 Feb 2020 01:11:42 +0000
Message-ID: <2efe52ea8483414f8da5633e50570a3c@mtkmbs05n1.mediatek.inc>
References: <20200103162632.109553-1-fparent@baylibre.com>
 <20200103162632.109553-2-fparent@baylibre.com>
In-Reply-To: <20200103162632.109553-2-fparent@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbXRrMDA4NDlcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy03NDlhMmYyMC01MTIyLTExZWEtYjYyNi0wODYyNjZhMmNhNzZcYW1lLXRlc3RcNzQ5YTJmMjItNTEyMi0xMWVhLWI2MjYtMDg2MjY2YTJjYTc2Ym9keS50eHQiIHN6PSIyODc0IiB0PSIxMzIyNjM3NTUwMjU0NzYyMTciIGg9IjM3ZzJ3Q0J4NDQxQngwcm9kY1BUb1RKZjRTbz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: =?gb2312?B?P52glLI/6MOUn6tBnZ0/NA==?=
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.21.101.239]
x-tm-snts-smtp: 16327EE50A6E057B967BE65E83974CAD3A3C2CA9CB8AD3DB7CCC521CC5D247132000:8
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

K1lvbmcuV3UNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExpbnV4LW1lZGlh
dGVrIFttYWlsdG86bGludXgtbWVkaWF0ZWstYm91bmNlc0BsaXN0cy5pbmZyYWRlYWQub3JnXSBP
biBCZWhhbGYgT2YgRmFiaWVuIFBhcmVudA0KU2VudDogU2F0dXJkYXksIEphbnVhcnkgNCwgMjAy
MCAxMjoyNyBBTQ0KVG86IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1tZWRpYXRla0BsaXN0cy5pbmZy
YWRlYWQub3JnDQpDYzogbWFyay5ydXRsYW5kQGFybS5jb207IG1hdHRoaWFzLmJnZ0BnbWFpbC5j
b207IGpvcm9AOGJ5dGVzLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOyBGYWJpZW4gUGFyZW50IDxm
cGFyZW50QGJheWxpYnJlLmNvbT4NClN1YmplY3Q6IFtQQVRDSCAyLzJdIGlvbW11L21lZGlhdGVr
OiBhZGQgc3VwcG9ydCBmb3IgTVQ4MTY3DQoNCkFkZCBzdXBwb3J0IGZvciB0aGUgSU9NTVUgb24g
TVQ4MTY3DQoNClNpZ25lZC1vZmYtYnk6IEZhYmllbiBQYXJlbnQgPGZwYXJlbnRAYmF5bGlicmUu
Y29tPg0KLS0tDQogZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyB8IDExICsrKysrKysrKystICBk
cml2ZXJzL2lvbW11L210a19pb21tdS5oIHwgIDEgKw0KIDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9t
dGtfaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgaW5kZXggNmZjMWY1ZWNmOTFl
Li41ZmM2MTc4YTgyZGMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQor
KysgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQpAQCAtNTY5LDcgKzU2OSw4IEBAIHN0YXRp
YyBpbnQgbXRrX2lvbW11X2h3X2luaXQoY29uc3Qgc3RydWN0IG10a19pb21tdV9kYXRhICpkYXRh
KQ0KIAkJRl9JTlRfUFJFVEVUQ0hfVFJBTlNBVElPTl9GSUZPX0ZBVUxUOw0KIAl3cml0ZWxfcmVs
YXhlZChyZWd2YWwsIGRhdGEtPmJhc2UgKyBSRUdfTU1VX0lOVF9NQUlOX0NPTlRST0wpOw0KIA0K
LQlpZiAoZGF0YS0+cGxhdF9kYXRhLT5tNHVfcGxhdCA9PSBNNFVfTVQ4MTczKQ0KKwlpZiAoZGF0
YS0+cGxhdF9kYXRhLT5tNHVfcGxhdCA9PSBNNFVfTVQ4MTczIHx8DQorCSAgICBkYXRhLT5wbGF0
X2RhdGEtPm00dV9wbGF0ID09IE00VV9NVDgxNjcpDQogCQlyZWd2YWwgPSAoZGF0YS0+cHJvdGVj
dF9iYXNlID4+IDEpIHwgKGRhdGEtPmVuYWJsZV80R0IgPDwgMzEpOw0KIAllbHNlDQogCQlyZWd2
YWwgPSBsb3dlcl8zMl9iaXRzKGRhdGEtPnByb3RlY3RfYmFzZSkgfCBAQCAtNzgyLDYgKzc4Mywx
MyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19pb21tdV9wbGF0X2RhdGEgbXQyNzEyX2RhdGEg
PSB7DQogCS5sYXJiaWRfcmVtYXAgPSB7MCwgMSwgMiwgMywgNCwgNSwgNiwgNywgOCwgOX0sICB9
Ow0KIA0KK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBtdDgxNjdfZGF0
YSA9IHsNCisJLm00dV9wbGF0ICAgICA9IE00VV9NVDgxNjcsDQorCS5oYXNfNGdiX21vZGUgPSB0
cnVlLA0KKwkucmVzZXRfYXhpICAgID0gdHJ1ZSwNCisJLmxhcmJpZF9yZW1hcCA9IHswLCAxLCAy
LCAzLCA0LCA1fSwgLyogTGluZWFyIG1hcHBpbmcuICovIH07DQorDQogc3RhdGljIGNvbnN0IHN0
cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10ODE3M19kYXRhID0gew0KIAkubTR1X3BsYXQgICAg
ID0gTTRVX01UODE3MywNCiAJLmhhc180Z2JfbW9kZSA9IHRydWUsDQpAQCAtNzk4LDYgKzgwNiw3
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBtdDgxODNfZGF0YSA9
IHsNCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdGtfaW9tbXVfb2ZfaWRz
W10gPSB7DQogCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQyNzEyLW00dSIsIC5kYXRhID0g
Jm10MjcxMl9kYXRhfSwNCisJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNjctbTR1Iiwg
LmRhdGEgPSAmbXQ4MTY3X2RhdGF9LA0KIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE3
My1tNHUiLCAuZGF0YSA9ICZtdDgxNzNfZGF0YX0sDQogCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0
ZWssbXQ4MTgzLW00dSIsIC5kYXRhID0gJm10ODE4M19kYXRhfSwNCiAJe30NCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2lvbW11L210a19pb21tdS5oIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaCBp
bmRleCBlYTk0OWEzMjRlMzMuLmNiOGZkNTk3MGNkNCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9t
bXUvbXRrX2lvbW11LmgNCisrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCkBAIC0zMCw2
ICszMCw3IEBAIHN0cnVjdCBtdGtfaW9tbXVfc3VzcGVuZF9yZWcgeyAgZW51bSBtdGtfaW9tbXVf
cGxhdCB7DQogCU00VV9NVDI3MDEsDQogCU00VV9NVDI3MTIsDQorCU00VV9NVDgxNjcsDQogCU00
VV9NVDgxNzMsDQogCU00VV9NVDgxODMsDQogfTsNCi0tDQoyLjI1LjAucmMwDQoNCg0KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCkxpbnV4LW1lZGlhdGVr
IG1haWxpbmcgbGlzdA0KTGludXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZw0KaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1tZWRpYXRlaw0K
