Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0332AC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3DDA2073A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="X4V3OZn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgEGIdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 04:33:00 -0400
Received: from mail-eopbgr10113.outbound.protection.outlook.com ([40.107.1.113]:44679
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725834AbgEGIc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 04:32:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1CvFGBZ6B7i+iLSesS+nQaY/8HWnxIUL/oWKKkIQ0Lm/Ug+iI7w4e7ccbY9TLflXtFDpBv/D2VnLYZjnFv7xxHBEsbt/muBtIkEeeCxxwpbfupgzKt2bedSL7yeuDds+ZCwVXVfARIxxBU+Jw1NUS2dru5WBt20fTsb9GuXjpY7049gwouyYLt92+VgYv9GSR5IM7R40W7WELtbT2TRlLEfMkBOAyK76Vb6fR5AvGN135Upv8W8PJSaeKrWiBdw5MVcS+YWlm4WXpGVw0DuV19R/DooiOCn5S92WFjo7/4lxOxBow1yaMvKb7Ee2Uo66eSU893d7uifmYccxRaIbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=360hCYuc87dykWLw92gRf61NTq/KRmf1ElZCb6xXl24=;
 b=kxMqNpTc5fDwP2PUl7aVyJ3F0Yepn6vrURTzIuVtu+t9za6M3Ol/cU0T7ZUb6LQO/yhUOBgWlIPJK/sU2eNR08MXeXG6bWSDQQVcCat2YFQzzTaXdpxohmoPW4qLTLDtIl6wMFwckYI84QkR1o5UhP4zSB/5eZDUl5yVTtr6jikIr7d+PUonUhGM3QUnB7K83/9Hmqi8T2MmziW4vjAIXRpxWcE72peOSrLkxpmxDJSh1fSiB4idSH7BGty6fP7nJjy+HODwZk8QC9qnCxLf3ciDgiPaKsw7KVSA+SjBJpWZqRvQ5V1EKrZstta6G7fJGCvANi9e3XKrTb4eCSCsMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=360hCYuc87dykWLw92gRf61NTq/KRmf1ElZCb6xXl24=;
 b=X4V3OZn89dPmVPOEycHUM689s+z76fPwUXz0C23jK3YMstyvaPTbns/MKd/TMQV8aCGrpe5CWK8mDBynYZEbsS2BCpbBbPdMbmzzuY0Hd8dUvRBA68tl8mPap/Uw4U2ltE/lnKxLAgsbCzPOWwVE8uwhdhw19U7pYdSmBjVOUoE=
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (2603:10a6:20b:a8::25)
 by AM6PR05MB5173.eurprd05.prod.outlook.com (2603:10a6:20b:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Thu, 7 May
 2020 08:32:52 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::d8d3:ead7:9f42:4289]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::d8d3:ead7:9f42:4289%6]) with mapi id 15.20.2979.030; Thu, 7 May 2020
 08:32:52 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "dillon.minfei@gmail.com" <dillon.minfei@gmail.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>
CC:     "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] ARM: dts: stm32: enable stmpe811 on stm32429-disco
 board
Thread-Topic: [PATCH 3/4] ARM: dts: stm32: enable stmpe811 on stm32429-disco
 board
Thread-Index: AQHWJEPKaBJpLtb4AE67HBydWVVEYaicS6oA
Date:   Thu, 7 May 2020 08:32:52 +0000
Message-ID: <6e60c3494b7daea740b335fee9c5f5ce5ad7de45.camel@toradex.com>
References: <1588837654-14315-1-git-send-email-dillon.minfei@gmail.com>
In-Reply-To: <1588837654-14315-1-git-send-email-dillon.minfei@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.2 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=toradex.com;
x-originating-ip: [51.154.7.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64248d3f-0a77-4685-8459-08d7f2613c09
x-ms-traffictypediagnostic: AM6PR05MB5173:
x-microsoft-antispam-prvs: <AM6PR05MB517355A58E5F7F9D3F281F79F4A50@AM6PR05MB5173.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 03965EFC76
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M6SMSa9GbnikPzHDkTeYOrUZiYd03g/ykfdQkvLrqN8YXO/ib01N0C6aasiK4Es5PsCWuyQ+qYmBaL/7J/KXr8LbFJdFLVYrxfvQI6FAxkthqtF99qiJC7NnP/wPBWHLijRb/m3LqeUEWvqswu5ota1P+z22Uwv5yPE2/4zhTdQQTMe68HSp47yLPMpWa6jcqKB/0hyB7NtVTEPY6CQNQDoiVLVKPOozTt+kPQ1wR/Ht34HHBPfDZn/rh+fNzOWvd3zkuCBvMIpLGS2rvwWuiv4E4MKM7+La6r6WldsOPA5qiUppCWVT858SEg+VbJNd5xlrqdOMhWfSfH8E4f5xbabXLiDTnun/UWfMe68/+ObsFdpVFzSNNaqxnc/5R2UIaltodeMJvbsdEcaPppgCXM/jsKJRRmNqisfLWgOMVUiaHpBgoSYTCdsyFN7mqFyku6bGDWmF4yIyI4ZKniNkF+tz0KVBnCreMIoevVN02SnlFA1FLlZfq12ucrf3luEEtvOUEXvejRR41Dj+Ya2SEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6120.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(396003)(39850400004)(366004)(33430700001)(5660300002)(33440700001)(76116006)(36756003)(6506007)(4326008)(86362001)(91956017)(66446008)(8676002)(64756008)(478600001)(66946007)(66556008)(66476007)(6486002)(110136005)(8936002)(26005)(186003)(6512007)(2906002)(83320400001)(54906003)(71200400001)(83280400001)(2616005)(44832011)(83300400001)(83310400001)(83290400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 5nWZCU3rM22u8KHPO7y4ARIjiZOA/zzERmsiu7lzeNni1s6TJwoX4ni/px9fBptEPUTggbkHkn7s1m9rKq0hYsNRF1OeNZJ9yDM2w6Ds9S48K0StJqA9dGWyUnE/v/qKdF0nCYNmhG6m0KPivUz+4vzlYbTPyWgtIi/Q53GvPkK2d+KbNzZNEvbnf1LG1qWCTZiRd28V6ch1+mTNBE1hRkhBgfvtKgOs9SrljyLF95V5sVr+wqUUVn/qJGywaj7MY03GDtXVdmkNJTM7Hgnm9yPHktB0310ustaxx1mltlJmMVRFbH7xsFBhxw1U677j9r3r6RtQlXcISP7YjsHdutbbvKZnrCscehvAoN5AdhzyerGCr/YsBaogsALXPpQ6GEoDarV/jcNyUjbwnDvwXmodJPkaOHh3rwrAgBapFjQ+JQiV9TTN9mws8vHKyA8vjUGUufNxtFcgIgyf6cDb3K+ZeyDOy36KtZbc7VSidNzyq9xwwYtA/3tp7GaqEKRt5xINfnPe6TAAaCwCYC4tXa5GPtnHdBKmtZZQk+LwJK9hUiBpCAUnaiIUSE8AGNy0gN7Ozg7KJzh+oN+sT61Uh0FoCwmaerCBAkQcZUKc5XADbmymIfIqHehXqvtEZ7PVsPEgghOTUPqt027A267eTeDT+1OW15lmdY1afsHGDXWttGYZyugoWtgUyIP/L//eYh14KIX7dpXLsZVj15XYSPYU6tCqa4cYyTrD+n9px12p7roYdXTf700MkP+mUocTbtRm04C9O6e16nJ/Wtz+uONBGDkWn0HiziV49DGUmOA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <61811CE9DEE8BE4CBC417C36ED8DEF11@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64248d3f-0a77-4685-8459-08d7f2613c09
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2020 08:32:52.8571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ue4d67+PmIDtUSDojqHArQ2Stjzan3YPE/QZ93+f149FPxaGkC4awOjo83Qow3j8Nv0vsTIuK41RNd8Lg6YicQpj+oEhwxEPySC0UXJ/Cnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA1LTA3IGF0IDE1OjQ3ICswODAwLCBkaWxsb24ubWluZmVpQGdtYWlsLmNv
bSB3cm90ZToNCj4gRnJvbTogZGlsbG9uIG1pbiA8ZGlsbG9uLm1pbmZlaUBnbWFpbC5jb20+DQo+
IA0KPiBFbmFibGUgdGhlIHN0bXBlODExIHRvdWNoIHNjcmVlbiBvbiBzdG0zMjQyOS1kaXNjbyBi
b2FyZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IGRpbGxvbiBtaW4gPGRpbGxvbi5taW5mZWlAZ21h
aWwuY29tPg0KPiAtLS0NCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3N0bTMyZjQyOS1kaXNjby5kdHMg
fCA1MA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNo
YW5nZWQsIDUwIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290
L2R0cy9zdG0zMmY0MjktZGlzY28uZHRzDQo+IGIvYXJjaC9hcm0vYm9vdC9kdHMvc3RtMzJmNDI5
LWRpc2NvLmR0cw0KPiBpbmRleCAzMGMwZjY3Li5mOWYyMWM4IDEwMDY0NA0KPiAtLS0gYS9hcmNo
L2FybS9ib290L2R0cy9zdG0zMmY0MjktZGlzY28uZHRzDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3Qv
ZHRzL3N0bTMyZjQyOS1kaXNjby5kdHMNCj4gQEAgLTQ5LDYgKzQ5LDggQEANCj4gICNpbmNsdWRl
ICJzdG0zMmY0MjkuZHRzaSINCj4gICNpbmNsdWRlICJzdG0zMmY0MjktcGluY3RybC5kdHNpIg0K
PiAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2lucHV0L2lucHV0Lmg+DQo+ICsjaW5jbHVkZSA8ZHQt
YmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvaXJxLmg+DQo+ICsjaW5jbHVkZSA8ZHQtYmlu
ZGluZ3MvZ3Bpby9ncGlvLmg+DQo+ICANCj4gIC8gew0KPiAgCW1vZGVsID0gIlNUTWljcm9lbGVj
dHJvbmljcyBTVE0zMkY0MjlpLURJU0NPIGJvYXJkIjsNCj4gQEAgLTEyNywzICsxMjksNTEgQEAN
Cj4gIAlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiAgCXN0YXR1cyA9ICJva2F5IjsNCj4g
IH07DQo+ICsNCj4gKyZpMmMzIHsNCj4gKwlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiAr
CXBpbmN0cmwtMCA9IDwmaTJjM19waW5zPjsNCj4gKwljbG9jay1mcmVxdWVuY3kgPSA8MTAwMDAw
PjsNCj4gKwlzdGF0dXMgPSAib2theSI7DQo+ICsNCj4gKwlzdG1wZTgxMUA0MSB7DQo+ICsJCWNv
bXBhdGlibGUgPSAic3Qsc3RtcGU4MTEiOw0KPiArCQlyZWcgPSA8MHg0MT47DQo+ICsJCWludGVy
cnVwdHMgPSA8MTUgSVJRX1RZUEVfRURHRV9GQUxMSU5HPjsNCj4gKwkJaW50ZXJydXB0LXBhcmVu
dCA9IDwmZ3Bpb2E+Ow0KPiArCQlpZCA9IDwwPjsNCj4gKwkJYmxvY2tzID0gPDB4NT47DQo+ICsJ
CWlycS10cmlnZ2VyID0gPDB4MT47DQoNCkkgY2FuJ3QgZmluZCBpZCwgYmxvY2tzIGFuZCBpcnEt
dHJpZ2dlciBpbiB0aGUgYmluZGluZy4gV2hhdCBhcmUgdGhleQ0KZm9yPw0KDQpQaGlsaXBwZQ0K
DQo+ICsJCS8qIDMuMjUgTUh6IEFEQyBjbG9jayBzcGVlZCAqLw0KPiArCQlzdCxhZGMtZnJlcSA9
IDwxPjsNCj4gKwkJLyogMTItYml0IEFEQyAqLw0KPiArCQlzdCxtb2QtMTJiID0gPDE+Ow0KPiAr
CQkvKiBpbnRlcm5hbCBBREMgcmVmZXJlbmNlICovDQo+ICsJCXN0LHJlZi1zZWwgPSA8MD47DQo+
ICsJCS8qIEFEQyBjb252ZXJzdGlvbiB0aW1lOiA4MCBjbG9ja3MgKi8NCj4gKwkJc3Qsc2FtcGxl
LXRpbWUgPSA8ND47DQo+ICsNCj4gKwkJc3RtcGVfdG91Y2hzY3JlZW4gew0KPiArCQkJY29tcGF0
aWJsZSA9ICJzdCxzdG1wZS10cyI7DQo+ICsJCQkvKiA4IHNhbXBsZSBhdmVyYWdlIGNvbnRyb2wg
Ki8NCj4gKwkJCXN0LGF2ZS1jdHJsID0gPDM+Ow0KPiArCQkJLyogNyBsZW5ndGggZnJhY3Rpb25h
bCBwYXJ0IGluIHogKi8NCj4gKwkJCXN0LGZyYWN0aW9uLXogPSA8Nz47DQo+ICsJCQkvKg0KPiAr
CQkJICogNTAgbUEgdHlwaWNhbCA4MCBtQSBtYXggdG91Y2hzY3JlZW4gZHJpdmVycw0KPiArCQkJ
ICogY3VycmVudCBsaW1pdCB2YWx1ZQ0KPiArCQkJICovDQo+ICsJCQlzdCxpLWRyaXZlID0gPDE+
Ow0KPiArCQkJLyogMSBtcyBwYW5lbCBkcml2ZXIgc2V0dGxpbmcgdGltZSAqLw0KPiArCQkJc3Qs
c2V0dGxpbmcgPSA8Mz47DQo+ICsJCQkvKiA1IG1zIHRvdWNoIGRldGVjdCBpbnRlcnJ1cHQgZGVs
YXkgKi8NCj4gKwkJCXN0LHRvdWNoLWRldC1kZWxheSA9IDw1PjsNCj4gKwkJfTsNCj4gKw0KPiAr
CQlzdG1wZV9hZGMgew0KPiArCQkJY29tcGF0aWJsZSA9ICJzdCxzdG1wZS1hZGMiOw0KPiArCQkJ
LyogZm9yYmlkIHRvIHVzZSBBREMgY2hhbm5lbHMgMy0wICh0b3VjaCkgKi8NCj4gKwkJCXN0LG5v
cmVxdWVzdC1tYXNrID0gPDB4MEY+Ow0KPiArCQl9Ow0KPiArCX07DQo+ICt9Ow0K
