Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3FAC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E740620B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pP9pT2d0";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="TftN0qAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgGTKeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 06:34:22 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:17764 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgGTKeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 06:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595241260; x=1626777260;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Kx5Osh/juLvKzsOz48waSWEqnOkFWndZeUDr2b1b/wk=;
  b=pP9pT2d0NpNKawmA7/ALpfWrvXxT4Usuitr2JyKkkvPwH5XeusPbKtT8
   ma82Tp0IVCi3ggEoKMqv6hx5ftbigUrLHvYWzqDoGiwxu2pCzqG+a0Z+0
   Ecgf7Ei7krJBNkXG4PMcuBq8YFKIQJhO7J+PFd/5dT6gRfPBtHnRkx4d8
   9EXDZx8jnE2Zq0ir9XdsdwDQduYEvQC5Qw01K4PAb0vgn4sONMBItTX3g
   ebCnFKhz7LUjnZlx5gTIa1a3X6kfJcZ/Qpgda8Af13jAhMNolQc4jwx+g
   6TUVXxsTpiHEmLTwkbfy+ExUYT9RKD9+ZSopoHBILl3aRQm3x8IbTpSMl
   w==;
IronPort-SDR: 1STA3FXydpc08F+CXiiRJEF/JGW5Uz4u/vcjdq6/3/qcvZtxZJsDWsoVhnuvowbPkLhORgQWEC
 PQwqhheiXQ3T+95hM4/WK7J+64su4mjush6tYThhinfUlmCCNSfVOHqP1I2c5+Se039q/oYcIV
 s/jBkeMistLfYMGW3PRGH1fKodocAp+IaICC+e6XlfoQ12NOmLY9a2iHYlbWAioiBi0e3qk/a0
 XmLJ+JidPFc+ppULc35QcyCJIzt0Qz5ynHpn7FrFWyWh00ckjZSAq+fngQMC9m0qCOcsN1ijSn
 2Ds=
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; 
   d="scan'208";a="82493679"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2020 03:34:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 20 Jul 2020 03:33:41 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Mon, 20 Jul 2020 03:34:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgvIPLlh4QSh/7+dhPQsJg2QKMEgwqy8Tcp6k5uvWsauvJGKwDrHVpwsMG7eLbXbBqs4/VAjr1jga/GerewIK3gH29gBo2PIy0/5nAcnahb3hmpddkb+Rt+07ybNJxGhnG8xFyL5xVrggeOiujALnkxltaA/QHMuCT817oRZ92haacGvnsf+rQyD/6c56VQ2sGkMXIzVpQPcYJ64ey9m7SnWf3xhdTUMNWm6i8bQyzv7fy1AcZ4mIcQv0+ta9u6W/p1dRUazPB6lrmdRL5mGxmdIjJHTwuXtot3FCmPBlr+oCk1gOTkFqq1ULp1tZ7vwXGQCeK2FK8FPgFdDHHGa/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kx5Osh/juLvKzsOz48waSWEqnOkFWndZeUDr2b1b/wk=;
 b=DlJSg8lSQ7V2hEFqnOCtpZ2gzqUrVFQitH/UFWWgKUNjKX90qsdSCqla/Nd0qqn/qsI4qqscjeIwEjFGoNTvtZzJykx2abGQ8szVCbY3Fw1WWIRTSzkc3HfPKCSWHGZEuXuDIf8kU6mVtrTWZTnkWilaaHjkCDO5IkhqYbc8i68SpdJa7z4KgPwgLPTFrSMKAD4bnwyjYfs+hr7yjezfQYW2jTxXpGr+kHL2zsoLTnxfNpxpXjRHSyYB/w0B5AruaA7oG+DYnbksHGhAc9Cxb1P1p2p7SlyHKqKXrpHb7uIYYESZoffrt9lXMLTfJfO+M+tiALXYX1oQe5cmQjHmXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kx5Osh/juLvKzsOz48waSWEqnOkFWndZeUDr2b1b/wk=;
 b=TftN0qAKBYO+oddMHibPE02uxwjjPgWbL6CCG7718itMWHaBtO5nQjJUhXKnV/qw+P/M34uIAyJmC4mhgzeEXyI9LMcx8/5UMOQ2HGgffk5e2xFof1g/KOheZ1xdzb0xnEHE5XvvJ/CRb2xXujIV/JiU3RZJ/JDgemw6LwUBGKw=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM5PR1101MB2105.namprd11.prod.outlook.com (2603:10b6:4:51::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.25; Mon, 20 Jul 2020 10:34:18 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::e8b2:1d82:49d9:f4b]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::e8b2:1d82:49d9:f4b%6]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 10:34:18 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 07/19] clk: at91: sam9x60-pll: use frac when setting
 frequency
Thread-Topic: [PATCH 07/19] clk: at91: sam9x60-pll: use frac when setting
 frequency
Thread-Index: AQHWXoFSXlCh1mtaPk2N/8h+NLHL3A==
Date:   Mon, 20 Jul 2020 10:34:18 +0000
Message-ID: <46ffd816-fff5-81af-f85d-61dcf7447029@microchip.com>
References: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
 <1594812267-6697-8-git-send-email-claudiu.beznea@microchip.com>
 <20200717091238.GL3428@piout.net>
In-Reply-To: <20200717091238.GL3428@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [82.76.227.81]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b1839d9-90eb-4f26-2cc3-08d82c987550
x-ms-traffictypediagnostic: DM5PR1101MB2105:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1101MB210559F73C71285B793843F5877B0@DM5PR1101MB2105.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GuUaqyRylV6YruAhx6MHf2WlqlnHNv6GtiNoxFSq71sD+0smwl/abRJl3MMrd1Pm0aI4lq/kPN/ZePaJRYLPLMzW8JS/JweEg2SWhjnNbwG6bOgF/L/+olCsJRa1osvIwbn7QrXynctIkcL7N3E4ngjoLmhEbtwJMkKmouw0JPJQFFj36Q6tM3TCNGnEFuedXKKnXPGFCQm2kF2JXdp2MckifTn1lkrfuVGv/MO26Ii01s7S6cmv9uSzuE/D4MisBqKRAyqFFyySgnb7HzH0WJB2sYwGANIwHg1JW4Qf2SLgkf3rJg6iRw7FN4mHXWv8KXwNtwszeBFHLy5dcuqD0kpx5J6J/tnlsaHdLnKkzN4+4u9de4WMK4AU3y+m25TnYbx2bOS/aSOKqGca/38QZ7zPbnUcTw5OfEB80/efrChrkfhZ9zUiki3lPSfv4C4oguFMoADio6CmQrx73AKZ6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39860400002)(346002)(376002)(136003)(396003)(66946007)(76116006)(91956017)(2616005)(66556008)(66476007)(53546011)(6506007)(64756008)(8676002)(86362001)(66446008)(6916009)(5660300002)(83380400001)(6512007)(2906002)(36756003)(26005)(316002)(8936002)(31686004)(71200400001)(31696002)(478600001)(4326008)(6486002)(186003)(966005)(54906003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: nLhAaN9rf5ZBzSEGfbJPLGDl4CV4TupFZmwoa/LKc6+W3iB08e6cPKF8a+ZgZp0sG6rMqc3MYq1dA0ibPHKcoBzhPhColQp/VIuRzPenv5+UgZxSoRyCkk3EN42v2FAYvFbHiZVMVoz4miEV2e7TwGjwMtX5QP9a0YJ/oIENBA6Y5yH6U/d3wkChA9biSWSKqyyOPh3cg8jlutJRQsg12pqliHGx3zRzm5TmIYMqr1HLmNpvIXhgnYBfvwfssAhn1oW1FSQ2243WLsYDMc4Z8iNy+nMXM8p0Fbl/aJhTzk40DwD0TIg4qTNl3eNtXbVoptHYOjbJAHwYA6mD5zX24TWTT7zCiV/0JUNgaxMIZqlNGT7c8vSt6hALLPJEucbL7sS9rxBo1hk6YJzqzITvV03zndhuhbh401JOhoa8JAPPnNYtvQjGSoMziR3uoQO97ogI8XTAObfVdkkpyzvdy8Ku8NGCTgehs5YHeBQkkHg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8987D5865C93F64887A4D4353EFEBDE7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1839d9-90eb-4f26-2cc3-08d82c987550
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 10:34:18.6775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +R+RQfTGZ2hXwQSKeWvXgw+ysH2k4Il1SqQZM02c3ZkpUgfEyUoqgvqXynh66USjEgfZmh2YFDkhlLzYJRABAPCpA/uROmg8XtrkJM/zRLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE3LjA3LjIwMjAgMTI6MTIsIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDE1LzA3LzIwMjAgMTQ6MjQ6
MTUrMDMwMCwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+PiBJbiBjb21taXQgYTQzNmMyYTQ0N2U1
OSAoImNsazogYXQ5MTogYWRkIHNhbTl4NjAgUExMIGRyaXZlciIpDQo+PiB0aGUgZnJhY3Rpb25h
bCBwYXJ0IG9mIFBMTCB3YXNuJ3Qgc2V0IG9uIHJlZ2lzdGVycyBidXQgaXQgd2FzDQo+PiBjYWxj
dWxhdGVkIGFuZCB0YWtlbiBpbnRvIGFjY291bnQgZm9yIGRldGVybWluaW5nIGRpdiBhbmQgbXVs
DQo+PiAoc2VlIHNhbTl4NjBfcGxsX2dldF9iZXN0X2Rpdl9tdWwoKSkuDQo+Pg0KPiANCj4gSSB0
aGluayB0aGlzIGJlY29tZXMgYW4gaXNzdWUgb25seSBvbmNlIDQvMTkgaXMgYXBwbGllZCBzbyB5
b3Ugc2hvdWxkDQo+IHByb2JhYmx5IHNxdWFzaCB0aG9zZSB0d28gdG9nZXRoZXIuDQoNCkkga2Vw
dCBpdCBzZXBhcmF0ZSBhcyBJIHdhcyB0aGlua2luZyBhYm91dCB0aGUgc2NlbmFyaW8gd2hlcmUN
CnRoZSBib290bG9hZGVycyBzZXQgdXAgdGhlIGZyZXF1ZW5jeSB1c2luZyBhbHNvIGZyYWN0aW9u
YWwgcGFydC4NCg0KQnV0IGF0IHRoZSBzYW1lIHRpbWUgSSB3YXMgdGhpbmtpbmcgYWJvdXQgc3F1
YXNoaW5nIHRoZW0gdG9nZXRoZXIuDQpOb3cgdGhhdCB0aGVyZSBpcyBhbHNvIHNvbWVvbmUgdGhp
bmtpbmcgYWJvdXQgaGF2aW5nIHRoZW0NCnRvZ2V0aGVyICh5b3UpIEkgd2lsbCBzcXVhc2ggdGhl
bS4NCg0KVGhhbmsgeW91LA0KQ2xhdWRpdSBCZXpuZWENCg0KPiANCj4+IEZpeGVzOiBhNDM2YzJh
NDQ3ZTU5ICgiY2xrOiBhdDkxOiBhZGQgc2FtOXg2MCBQTEwgZHJpdmVyIikNCj4+IFNpZ25lZC1v
ZmYtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPj4g
LS0tDQo+PiAgZHJpdmVycy9jbGsvYXQ5MS9jbGstc2FtOXg2MC1wbGwuYyB8IDkgKysrKysrLS0t
DQo+PiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+
DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvYXQ5MS9jbGstc2FtOXg2MC1wbGwuYyBiL2Ry
aXZlcnMvY2xrL2F0OTEvY2xrLXNhbTl4NjAtcGxsLmMNCj4+IGluZGV4IDAwZjJhZmQ2ZTliNi4u
MTNlMTViZDQ4NzcwIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9jbGsvYXQ5MS9jbGstc2FtOXg2
MC1wbGwuYw0KPj4gKysrIGIvZHJpdmVycy9jbGsvYXQ5MS9jbGstc2FtOXg2MC1wbGwuYw0KPj4g
QEAgLTE2LDYgKzE2LDcgQEANCj4+DQo+PiAgI2RlZmluZSAgICAgIFBNQ19QTExfQ1RSTDBfRElW
X01TSyAgIEdFTk1BU0soNywgMCkNCj4+ICAjZGVmaW5lICAgICAgUE1DX1BMTF9DVFJMMV9NVUxf
TVNLICAgR0VOTUFTSygzMSwgMjQpDQo+PiArI2RlZmluZSAgICAgIFBNQ19QTExfQ1RSTDFfRlJB
Q1JfTVNLIEdFTk1BU0soMjEsIDApDQo+Pg0KPj4gICNkZWZpbmUgUExMX0RJVl9NQVggICAgICAg
ICAgKEZJRUxEX0dFVChQTUNfUExMX0NUUkwwX0RJVl9NU0ssIFVJTlRfTUFYKSArIDEpDQo+PiAg
I2RlZmluZSBVUExMX0RJViAgICAgICAgICAgICAyDQo+PiBAQCAtNTUsNyArNTYsNyBAQCBzdGF0
aWMgaW50IHNhbTl4NjBfcGxsX3ByZXBhcmUoc3RydWN0IGNsa19odyAqaHcpDQo+PiAgICAgICB1
bnNpZ25lZCBsb25nIGZsYWdzOw0KPj4gICAgICAgdTggZGl2Ow0KPj4gICAgICAgdTE2IG11bDsN
Cj4+IC0gICAgIHUzMiB2YWw7DQo+PiArICAgICB1MzIgdmFsLCBmcmFjOw0KPj4NCj4+ICAgICAg
IHNwaW5fbG9ja19pcnFzYXZlKHBsbC0+bG9jaywgZmxhZ3MpOw0KPj4gICAgICAgcmVnbWFwX3dy
aXRlKHJlZ21hcCwgQVQ5MV9QTUNfUExMX1VQRFQsIHBsbC0+aWQpOw0KPj4gQEAgLTY1LDkgKzY2
LDEwIEBAIHN0YXRpYyBpbnQgc2FtOXg2MF9wbGxfcHJlcGFyZShzdHJ1Y3QgY2xrX2h3ICpodykN
Cj4+DQo+PiAgICAgICByZWdtYXBfcmVhZChyZWdtYXAsIEFUOTFfUE1DX1BMTF9DVFJMMSwgJnZh
bCk7DQo+PiAgICAgICBtdWwgPSBGSUVMRF9HRVQoUE1DX1BMTF9DVFJMMV9NVUxfTVNLLCB2YWwp
Ow0KPj4gKyAgICAgZnJhYyA9IEZJRUxEX0dFVChQTUNfUExMX0NUUkwxX0ZSQUNSX01TSywgdmFs
KTsNCj4+DQo+PiAgICAgICBpZiAoc2FtOXg2MF9wbGxfcmVhZHkocmVnbWFwLCBwbGwtPmlkKSAm
Jg0KPj4gLSAgICAgICAgIChkaXYgPT0gcGxsLT5kaXYgJiYgbXVsID09IHBsbC0+bXVsKSkgew0K
Pj4gKyAgICAgICAgIChkaXYgPT0gcGxsLT5kaXYgJiYgbXVsID09IHBsbC0+bXVsICYmIGZyYWMg
PT0gcGxsLT5mcmFjKSkgew0KPj4gICAgICAgICAgICAgICBzcGluX3VubG9ja19pcnFyZXN0b3Jl
KHBsbC0+bG9jaywgZmxhZ3MpOw0KPj4gICAgICAgICAgICAgICByZXR1cm4gMDsNCj4+ICAgICAg
IH0NCj4+IEBAIC04MCw3ICs4Miw4IEBAIHN0YXRpYyBpbnQgc2FtOXg2MF9wbGxfcHJlcGFyZShz
dHJ1Y3QgY2xrX2h3ICpodykNCj4+ICAgICAgIHJlZ21hcF93cml0ZShyZWdtYXAsIEFUOTFfUE1D
X1BMTF9BQ1IsIHZhbCk7DQo+Pg0KPj4gICAgICAgcmVnbWFwX3dyaXRlKHJlZ21hcCwgQVQ5MV9Q
TUNfUExMX0NUUkwxLA0KPj4gLSAgICAgICAgICAgICAgICAgIEZJRUxEX1BSRVAoUE1DX1BMTF9D
VFJMMV9NVUxfTVNLLCBwbGwtPm11bCkpOw0KPj4gKyAgICAgICAgICAgICAgICAgIEZJRUxEX1BS
RVAoUE1DX1BMTF9DVFJMMV9NVUxfTVNLLCBwbGwtPm11bCkgfA0KPj4gKyAgICAgICAgICAgICAg
ICAgIEZJRUxEX1BSRVAoUE1DX1BMTF9DVFJMMV9GUkFDUl9NU0ssIHBsbC0+ZnJhYykpOw0KPj4N
Cj4+ICAgICAgIGlmIChwbGwtPmNoYXJhY3RlcmlzdGljcy0+dXBsbCkgew0KPj4gICAgICAgICAg
ICAgICAvKiBFbmFibGUgdGhlIFVUTUkgaW50ZXJuYWwgYmFuZGdhcCAqLw0KPj4gLS0NCj4+IDIu
Ny40DQo+Pg0KPiANCj4gLS0NCj4gQWxleGFuZHJlIEJlbGxvbmksIEJvb3RsaW4NCj4gRW1iZWRk
ZWQgTGludXggYW5kIEtlcm5lbCBlbmdpbmVlcmluZw0KPiBodHRwczovL2Jvb3RsaW4uY29tDQo+
IA==
