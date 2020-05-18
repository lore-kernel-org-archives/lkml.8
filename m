Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B607C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE7ED20756
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgERLhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 07:37:12 -0400
Received: from mailgate1.rohmeurope.com ([87.129.152.131]:46884 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgERLhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:37:11 -0400
X-AuditID: c0a8fbf4-489ff70000004419-01-5ec273653295
Received: from smtp.reu.rohmeu.com (will-cas001.reu.rohmeu.com [192.168.251.177])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id C2.09.17433.56372CE5; Mon, 18 May 2020 13:37:10 +0200 (CEST)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS001.REu.RohmEu.com ([fe80::d57e:33d0:7a5d:f0a6%16]) with mapi id
 14.03.0487.000; Mon, 18 May 2020 13:36:57 +0200
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
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
Thread-Index: AQHWLOdQMdOSpxREeE+Cws0ySbgdVKitgt4AgAATFoA=
Date:   Mon, 18 May 2020 11:36:56 +0000
Message-ID: <b08e5796b3d94b1add13e706f7acdc34c3a79e49.camel@fi.rohmeurope.com>
References: <18838efd9341c953fb6aabe9536786de3f1150ae.camel@fi.rohmeurope.com>
         <20200518102842.GB8699@sirena.org.uk>
In-Reply-To: <20200518102842.GB8699@sirena.org.uk>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.78.225.252]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB3A4F354C80124FBEE95FAFF2F15820@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDJsWRmVeSWpSXmKPExsVyYMXvjbppxYfiDKb0MlosuXiV3aL93TJ2
        iy9zT7FYTH34hM3i/tejjBbfrnQwWUz5s5zJ4vKuOWwWTxaeYbKYs/QEi8XFU64WrXuPsFv8
        u7aRxeL07hKLxy//MTvwe7y/0cruMW9NtcfOWXfZPTat6mTzuHNtD5vHyjVrWD12fm9g95g+
        7yeTx+dNcgGcUdw2SYklZcGZ6Xn6dgncGUdn3WcvaOKvuNdziqmB8QJfFyMnh4SAicS2Z43M
        XYxcHEIC1xglTt7eyg7hnGCUWPNzClMXIwcHm4CNRNdNdpAGEQFdiam/FrOB1DALXGCVOLul
        HSwhLOAkceLOWWaIImeJ3+fegPWKCFhJzHtcARJmEVCVWPfwHVg5r4CfxJeTfxlBbCGBcokz
        +/aBxTkFjCQeTrwANoZRQFais+EdE4jNLCAusenZd1aIowUkluw5zwxhi0q8fPwPKq4osf37
        OhaQtcwCmhLrd+lDtDpI3Jn5gA3CVpSY0v0Q6gRBiZMzn7BMYBSbhWTDLITuWUi6ZyHpnoWk
        ewEj6ypGidzEzJz0xJJUQ72i1FK9ovyMXCCVnJ+7iRGSGr7sYPx/yPMQIxMH4yFGSQ4mJVHe
        Xv9DcUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeCM/74sT4k1JrKxKLcqHSUlzsCiJ86o/nBgr
        JACyKzs1tSC1CCYrw8GhJMHbWwA0VLAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx6U
        POKLgekDJMUDtDexEKidt7ggMRcoCtF6ilGbY8LLuYuYOY7MXbqIWYglLz8vVUqct6MIqFQA
        pDSjNA9u0StGcQ5GJWHeDSCDeIBZAm7OK6AVTEArXC+CvFZckoiQkmpgjL6ZvvXyu8xjPyof
        dgkHfN7ZsXd/oMyWtjczH8cbrdaxYuWsaT7HkRatLSTx9sotsbyjb/qUD5bO3PSAPUfYqiXu
        QuRMDcu9cfsu3iyV4jZOPt7oozRDrWxz/I7UrqV3j34J9lsj8WJq5HwGvVl/PrwNldQL8pLZ
        oWJ9LXursZJui83CXUZqSizFGYmGWsxFxYkASQaGbs8DAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciByZXBseSBNYXJrLA0KDQpPbiBNb24sIDIwMjAtMDUtMTggYXQgMTE6MjggKzAx
MDAsIE1hcmsgQnJvd24gd3JvdGU6DQo+IE9uIE1vbiwgTWF5IDE4LCAyMDIwIGF0IDA3OjM4OjI1
QU0gKzAwMDAsIFZhaXR0aW5lbiwgTWF0dGkgd3JvdGU6DQo+IA0KPiA+IFdoYXQga2luZCBvZiBw
YXJ0aWNpcGF0aW9uIHdvdWxkIHlvdSBleHBlY3QvYXBwcmVjaWF0ZSBmcm9tIG1lIGlmIEkNCj4g
PiBhZGRlZCBteXNlbGYgaW4gTUFJTlRBSU5FUlMgZm9yIHRoZXNlIGRyaXZlcnMgSSBhdXRob3Jl
ZD8gQW55DQo+IA0KPiBNYWlubHkganVzdCByZXZpZXdpbmcgcGF0Y2hlcy4NCg0KSSBjYW4gZG8g
dGhhdCA6KQ0KDQo+IA0KPiA+IG9iamVjdGlvbnMgdG8gdGhhdD8gKEkgZG9uJ3QgcmVhbGx5IGtu
b3cgaG93IE1BSU5UQUlORVJzIGVudHJpZXMNCj4gPiBzaG91bGQNCj4gPiBiZSBhZGRlZCAtIGFu
ZCBJIGRpZG4ndCBbZWFzaWx5XSBmaW5kIHVwLXRvLWRhdGUgZXhwbGFuYXRpb24gdG8NCj4gPiB0
aGF0KS4NCj4gDQo+IFNlbmQgYSBwYXRjaCwgb2Z0ZW4gYWxvbmcgd2l0aCBvdGhlciBzdHVmZiB0
aGF0J3MgZ29pbmcgb24uICBJJ2QNCj4gZ3Vlc3MNCj4gTUZEIHdvdWxkIGJlIGFzIGdvb2QgYSB0
cmVlIGFzIGFueSBmb3IgaXQgdG8gZ28gdmlhLg0KDQpBaCwgeWVzIDpdIEkgd2FzIGd1ZXNzaW5n
IHRoaXMgaXMgdGhlIHRlY2huaWNhbCB3YXkgb2YgYWRkaW5nIHRoZQ0KZW50cnkuIEkgd2FzIG1v
cmUgd29uZGVyaW5nIHdoYXQgaXMgZXhwZWN0ZWQgZnJvbSBtYWludGFpbmVyICh5b3UNCmFuc3dl
cmVkIHRoYXQgYWJvdmUpIGFuZCB3aGV0aGVyIHRoZXJlIGlzIHNvbWUgY3JpdGVyaWEgYXMgdG8g
d2hvIGNhbg0KYmUgYSBtYWludGFpbmVyLg0KDQpXaGlsZSB3ZSBhcmUgYXQgaXQgLSBNYXJrLCB3
b3VsZCB5b3UgY29uc2lkZXIgZm9sbG93aW5nIHRvIGJlIGZ1bGx5DQppbmFwcHJvcHJpYXRlOg0K
DQpMSU5FQVIgUkFOR0VTIEhFTFBFUlMNCk06ICAgICAgTWFyayBCcm93biA8YnJvb25pZUBrZXJu
ZWwub3JnPg0KUjogICAgICBNYXR0aSBWYWl0dGluZW4gPG1hdHRpLnZhaXR0aW5lbkBmaS5yb2ht
ZXVyb3BlLmNvbT4NCkY6ICAgICAgbGliL2xpbmVhcl9yYW5nZXMuYw0KRjogICAgICBsaWIvdGVz
dF9saW5lYXJfcmFuZ2VzLmMNCkY6ICAgICAgaW5jbHVkZS9saW51eC9saW5lYXJfcmFuZ2UuaA0K
DQpJIHRoaW5rIHRoYXQgcmVndWxhdG9ycyBiZWluZyB0aGUgbWFpbiB1c2VyIGZvciBsaW5lYXJf
cmFuZ2VzIHRoZQ0KY2hhbmdlcyB0aGVyZSBzaG91bGQgZ28gaW4gdmlhIHlvdXIgdHJlZSAtIGFu
ZCB5b3Ugc2hvdWxkIHByb2JhYmx5IGJlDQp3YXRjaGluZyBvdmVyIHRoZW0gYW55d2F5cyA6KQ0K
DQpCZXN0IFJlZ2FyZHMNCglNYXR0aSBWYWl0dGluZW4NCg==
