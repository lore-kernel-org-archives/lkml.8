Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D4AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2FA420709
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgERLmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 07:42:54 -0400
Received: from mailgate1.rohmeurope.com ([87.129.152.131]:47024 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgERLmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:42:53 -0400
X-AuditID: c0a8fbf4-473ff70000004419-1a-5ec274bbfea0
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 87.09.17433.BB472CE5; Mon, 18 May 2020 13:42:51 +0200 (CEST)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0487.000; Mon, 18 May 2020 13:42:39 +0200
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [not urgent] ROHM PMIC/Charger IC driver maintenance.
Thread-Topic: [not urgent] ROHM PMIC/Charger IC driver maintenance.
Thread-Index: AQHWLOdQMdOSpxREeE+Cws0ySbgdVKithlaAgAARMgA=
Date:   Mon, 18 May 2020 11:42:36 +0000
Message-ID: <184c1e6c17851c53683ce6fd27794bf279a5ab85.camel@fi.rohmeurope.com>
References: <18838efd9341c953fb6aabe9536786de3f1150ae.camel@fi.rohmeurope.com>
         <20200518104107.GS271301@dell>
In-Reply-To: <20200518104107.GS271301@dell>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.78.225.252]
Content-Type: text/plain; charset="utf-8"
Content-ID: <18EFCC55B10D8940B0BA1B93640F498C@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0gUURjtzszOjI+pcbX2tr1wKUotS4oYSiJ6wPingv70IG3Mmyu5D2bW
        aqsfFplvMNioliwz3dLVojUwH4UsRpv5pNISI3wUaO8yV1O0GafSX/fc73znnO/Cd2lcW0/q
        6RSzDYlmIdVABhINd8Y9a+ps3vh1fW2xXEnHK4rL/OKiuOHCJoK71DtAcu9+PQHcyMssjHNM
        3Ma4F7XXSG7gZjPGXSv1EVxH004u41EjxU123ie453U2rn9wEt86j//6OoPir1ec5mucbyne
        U55N8j2d9SRfVlGh4Wv86RR/+foYxv/0LN0TcCAoNlGwHd+bkmxeu+VwkPHClfMaa3HQyZqi
        YSIdTATmgAAashvg1JSLzAGBtJbtBLD9dzWlXnwAvnA3EjmApkk2Fua8oRRBGBsDS3zvCaUH
        Z5s1sLlsGFOIUHYb9PW04GrTdjje+glT8Sbo6evXKJhgV8CGbsd0D8Pugm1V30jFX8ta4fsW
        k1IOYKPgh47W6SzALoHZ6V+mbXBWBz0f/Bp1aBaW1LfhKp4PB/sn/9bDYbX/7vTIOBsB79Wu
        VaVbYbXPpVFxOHTk9lLqBCHw2dUBogAscM5KcM6onbPUzllq5yx1EdCUA2gSUlKTBRuKiRZR
        WrRoMZrk44jF5AHqNgw/BFPeOC/AaOAFC2nMMJ/J3+2N185NtCTZjYJkTBDTUpHkBZDGDWHM
        /p+P47VMkmA/hUTLP2oRTRh0zMrei4e0rJJ1DCErEv+xi2naAJk9kmwaIqJkdPJoSqpthsbo
        AMU8UB8mIXMSEoU0mzFBWY8ESd4PhQqWc0tFWc5IVsEkV1VpE4iiCwYLi3G6sbC0GNcSZosZ
        6XWMQ0lilVZjmvl/0BDQ0cAQyowoRsHyl/jvMyRHYHLEzg7laZJNmKH06cBVGTE6FdR1MCtz
        f+v6XCeqGjPhD+xdofq4s1K2bkB6t7f7R4Pn86h7h75tWXmGZqiMX24/0L2vz12FUEt43tyn
        47E9tXmrqdNnTjiy20tyxzOs688NuexP2+dBgz3+VtLHzds/6kwbV90YjKys8X+vnIPy/K4C
        0n3q6OGEfLeBkIxCTCQuSsIf1osRKM8DAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gTGVlLA0KDQpPbiBNb24sIDIwMjAtMDUtMTggYXQgMTE6NDEgKzAxMDAsIExlZSBKb25l
cyB3cm90ZToNCj4gT24gTW9uLCAxOCBNYXkgMjAyMCwgVmFpdHRpbmVuLCBNYXR0aSB3cm90ZToN
Cj4gDQo+ID4gSGVsbG8gQWxsLA0KPiA+IA0KPiA+IEluIHNob3J0IC0gSSBjb25zaWRlciBhZGRp
bmcgbXlzZWxmIGluIE1BSU5UQUlORVJzIGZvciB0aGUgUk9ITSBJQw0KPiA+IGRyaXZlcnMgSSd2
ZSBhdXRob3JlZC4gSSB3b3VsZCBsaWtlIHRvIGdldCB5b3VyIG9waW5pb24gYXMNCj4gPiBzdWJz
eXN0ZW0NCj4gPiBtYWludGFpbmVycyBvbiB0aGUgYXJlYSB3aGVyZSB0aGVzZSBkcml2ZXIgYmVs
b25nLiBJZiB5b3UgZG9uJ3QNCj4gPiBjYXJlIC0NCj4gPiB0aGVuIG5vIG5lZWQgdG8gcmVhZCBm
dXJ0aGVyIDopIElmIHlvdSBkbyByZWFkLCB0aGVuIEkgd291bGQNCj4gPiBhcHByZWNpYXRlDQo+
ID4gaGVhcmluZyBhYm91dCB5b3VyIGV4cGVjdGF0aW9ucyByZWdhcmRpbmcgcmV2aWV3cywgQUNL
cyBldGMuDQo+IA0KPiBJdCdzIGZpbmUgdG8gYWRkIHlvdXJzZWxmIHRvIE1BSU5UQUlORVJTIGZv
ciB0aGlzIHB1cnBvc2UuDQo+IA0KPiBFaXRoZXIgYXMgTSAobWFpbC10bykgb3IgUiAoZGVzaWdu
YXRlZCByZXZpZXdlcikgaXMgZmluZS4NCg0KVGhhbmtzISBBcHByZWNpYXRlIHlvdXIgaGVscC4g
U28sIGlmIEkgdW5kZXJzdGFuZCB0aGlzIGNvcnJlY3RseSB0aGUNCmRpZmZlcmVuY2UgYmV0d2Vl
biBNIGFuZCBSIGlzIHRoYXQgTSBpbXBsaWVzIHRoZSBwYXRjaGVzIGdvIHRvIHVwc3RyZWFtDQp2
aWEgcGVyc29uIGxpc3RlZCBpbiBNLiBTbyBpbiBteSBjYXNlIC0gYXMgSSBob3BlIHBhdGNoZXMg
dG8gdGhlc2UNCmRyaXZlcnMgYXJlIHN0aWxsIGdvaW5nIHRvIHlvdXIgdHJlZSAtIHRoZSBSIHdv
dWxkIGJlIG1vcmUgYXBwcm9wcmlhdGUsDQpyaWdodD8gTSBzb3VuZHMgbmljZSB0aG91Z2ggLSBp
dCdzIGEgZ29vZCBsZXR0ZXIgKHNheXMgc29tZW9uZSB3aG9zZQ0KbmFtZSBpcyBNYXR0aSA7XSAp
DQoNCkJyLA0KCU1hdHRpIFZhaXR0aW5lbg0K
