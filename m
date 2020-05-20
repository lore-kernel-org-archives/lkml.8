Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E5DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62E3F206BE
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgETHH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 03:07:28 -0400
Received: from mailgate1.rohmeurope.com ([87.129.152.131]:46378 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgETHH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 03:07:28 -0400
X-AuditID: c0a8fbf4-473ff70000004419-c8-5ec4d72d7791
Received: from smtp.reu.rohmeu.com (will-cas001.reu.rohmeu.com [192.168.251.177])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 8B.0E.17433.D27D4CE5; Wed, 20 May 2020 09:07:25 +0200 (CEST)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS001.REu.RohmEu.com ([fe80::d57e:33d0:7a5d:f0a6%16]) with mapi id
 14.03.0487.000; Wed, 20 May 2020 09:07:21 +0200
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] MAINTAINERS: Add entry for ROHM power management ICs
Thread-Topic: [PATCH 1/2] MAINTAINERS: Add entry for ROHM power management
 ICs
Thread-Index: AQHWLm2V7GI94XY5hUC0pKqqx57b4qiwY2CAgAAI3IA=
Date:   Wed, 20 May 2020 07:07:20 +0000
Message-ID: <e50cbe739c3394bfc0bba77b3ea4b522b6011dd0.camel@fi.rohmeurope.com>
References: <cover.1589866137.git.matti.vaittinen@fi.rohmeurope.com>
         <e11366fd280736844ae63791b6193bb84d6205bf.1589866138.git.matti.vaittinen@fi.rohmeurope.com>
         <20200520063541.GY271301@dell>
In-Reply-To: <20200520063541.GY271301@dell>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.78.225.252]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B50C619DF3A12C4987E9BF102D4BE30A@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02TW0wTQRSGnd3tdoqsjgVkqIKheEeEqgkbY7SJUddEjIk+4A1cZaWNtMVt
        a0SN1gBRqkY0EKVIFeUipGrExAti1AoGkQRRipdIkAAqxsuDKIoG3XVVeJk5c/7znX8mOQNJ
        rZ/WQbPVIYhWPkNPB1F3zv+4HBf3tD4loSMngS1rDajZAx8r1Gx/SRPFFnb10GznlwbAfm07
        SLAFPysJ9kntKZrtKW0m2FPljRTb2rSEzb1Vr2aH2i9T7MObDra7b4g0juU+PctVc17fbu6G
        p0PN1VTn0dzL9jqaq/L5VNyNAZeaO+H9TnCfa6JWadaNXrCZd+xYbU63xi/cNNrU5T0JMj2x
        OxvPG1zg8Ew30ECM5uFC3xfaDYKgFrUDXFqbQyqHRoCP5p5WuQGENFqA3c/VMhCKDLissZeS
        a0jUrMLvWytoWQhBSbi6s5VSilbhwtJXf9hQNB/fvRAmpyk0BQ++Lf5TwqCV+NybIULxagD4
        4KdKlSxoUCy+P3iWlGOAInGe6yMhxyQKxzWvB1TKrREuq2shlTgM93UP/c1H42sDFynZl0Qz
        8KXaeAU14sDtx0CJo3HBoS61codx+EFRD5UPxntGOHiGac8I2jOC9oygzwBVNcAW3pyRzjsE
        w2xRcM4WbSaLtG2xWWqAMg3918Ev/3I/ICDwgwhI6MOYe776FO2Yzba0LBNvN6WKzgzB7gcY
        kvpQJv+tP0XLpPFZuwTR9k+aACl9ODOt69hGLZK9tglCpiD+UydCqMdMTEBqOk4U0oWdW80Z
        jmGZgBq5eZAu1C5Y0wSRdzpMqfJ4pNql+ZClYMn3Z5uEM/ZM3iJlFbQJGGB+X8lZEl4pKZfW
        ennVUlabVdCFMyVQApAMmJzW/3bvQDgE+hAmqV1Sg6WP8b/bO8mIkIwm3JcfaHfww5LOBYx7
        jxi9Sw4Ui5ucxhbd5MiI6H0vvsV/uNZ9eLl5w9q2m97IovSq7OtU7KXEvl3ZZR/y8mfErS/u
        Te6feCLBE7w0MGve4v0vsrpX0GsGs8WIZI2zJyfu6txJ611aXZRvzqjj05Meo40rti9bdK4g
        0VJEPe2Mwo+4uj2v13jdCYGYxKl6ym7iDTNJ0c7/BoI4HO7VAwAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TW9ybmluZyBMZWUsDQoNCk9uIFdlZCwgMjAyMC0wNS0yMCBhdCAwNzozNSArMDEwMCwgTGVlIEpv
bmVzIHdyb3RlOg0KPiBPbiBXZWQsIDIwIE1heSAyMDIwLCBNYXR0aSBWYWl0dGluZW4gd3JvdGU6
DQo+IA0KPiA+IEFkZCBlbnRyeSBmb3IgbWFpbnRhaW5pbmcgcG93ZXIgbWFuYWdlbWVudCBJQyBk
cml2ZXJzIGZvciBST0hNDQo+ID4gQkQ3MTgzNywgQkQ3MTg0NywgQkQ3MTg1MCwgQkQ3MTgyOCwg
QkQ3MTg3OCwgQkQ3MDUyOCBhbmQgQkQ5OTk1NC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBN
YXR0aSBWYWl0dGluZW4gPG1hdHRpLnZhaXR0aW5lbkBmaS5yb2htZXVyb3BlLmNvbT4NCj4gPiAt
LS0NCj4gPiAgTUFJTlRBSU5FUlMgfCAzMCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0t
Z2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KPiA+IGluZGV4IGVjYzA3NDk4MTBiMC4u
NjNhMmNhNzA1NDBlIDEwMDY0NA0KPiA+IC0tLSBhL01BSU5UQUlORVJTDQo+ID4gKysrIGIvTUFJ
TlRBSU5FUlMNCj4gPiBAQCAtMTQ0OTAsNiArMTQ0OTAsMTIgQEAgTDoJbGludXgtc2VyaWFsQHZn
ZXIua2VybmVsLm9yZw0KPiA+ICBTOglPZGQgRml4ZXMNCj4gPiAgRjoJZHJpdmVycy90dHkvc2Vy
aWFsL3JwMi4qDQo+ID4gIA0KPiA+ICtST0hNIEJEOTk5NTQgQ0hBUkdFUiBJQw0KPiA+ICtSOglN
YXR0aSBWYWl0dGluZW4gPG1hdHRpLnZhaXR0aW5lbkBmaS5yb2htZXVyb3BlLmNvbT4NCj4gPiAr
UzoJU3VwcG9ydGVkDQo+ID4gK0Y6CWRyaXZlcnMvcG93ZXIvc3VwcGx5L2JkOTk5NTQtY2hhcmdl
ci5jDQo+ID4gK0Y6CWRyaXZlcnMvcG93ZXIvc3VwcGx5L2JkOTk5NTQtY2hhcmdlci5oDQo+ID4g
Kw0KPiA+ICBST0hNIEJIMTc1MCBBTUJJRU5UIExJR0hUIFNFTlNPUiBEUklWRVINCj4gPiAgTToJ
VG9tYXN6IER1c3p5bnNraSA8dGR1c3p5bnNAZ21haWwuY29tPg0KPiA+ICBTOglNYWludGFpbmVk
DQo+ID4gQEAgLTE0NTA3LDYgKzE0NTEzLDMwIEBAIEY6CWRyaXZlcnMvbWZkL2JkOTU3MW13di5j
DQo+ID4gIEY6CWRyaXZlcnMvcmVndWxhdG9yL2JkOTU3MW13di1yZWd1bGF0b3IuYw0KPiA+ICBG
OglpbmNsdWRlL2xpbnV4L21mZC9iZDk1NzFtd3YuaA0KPiA+ICANCj4gPiArUk9ITSBQT1dFUiBN
QU5BR0VNRU5UIElDIERFVklDRSBEUklWRVJTDQo+ID4gK1I6CU1hdHRpIFZhaXR0aW5lbiA8bWF0
dGkudmFpdHRpbmVuQGZpLnJvaG1ldXJvcGUuY29tPg0KPiA+ICtTOglTdXBwb3J0ZWQNCj4gPiAr
RjoJRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9yb2htLGJkNzA1MjgtcG1p
Yy50eHQNCj4gPiArRjoJRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3JlZ3VsYXRv
ci9yb2htLGJkNzA1MjgtDQo+ID4gcmVndWxhdG9yLnR4dA0KPiA+ICtGOglkcml2ZXJzL2Nsay9j
bGstYmQ3MTh4Ny5jDQo+ID4gK0Y6CWRyaXZlcnMvZ3Bpby9ncGlvLWJkNzA1MjguYw0KPiA+ICtG
Oglkcml2ZXJzL2dwaW8vZ3Bpby1iZDcxODI4LmMNCj4gPiArRjoJZHJpdmVycy9tZmQvcm9obS1i
ZDcwNTI4LmMNCj4gPiArRjoJZHJpdmVycy9tZmQvcm9obS1iZDcxODI4LmMNCj4gPiArRjoJZHJp
dmVycy9tZmQvcm9obS1iZDcxOHg3LmMNCj4gPiArRjoJZHJpdmVycy9wb3dlci9zdXBwbHkvYmQ3
MDUyOC1jaGFyZ2VyLmMNCj4gPiArRjoJZHJpdmVycy9yZWd1bGF0b3IvYmQ3MDUyOC1yZWd1bGF0
b3IuYw0KPiA+ICtGOglkcml2ZXJzL3JlZ3VsYXRvci9iZDcxODI4LXJlZ3VsYXRvci5jDQo+ID4g
K0Y6CWRyaXZlcnMvcmVndWxhdG9yL2JkNzE4eDctcmVndWxhdG9yLmMNCj4gPiArRjoJZHJpdmVy
cy9yZWd1bGF0b3Ivcm9obS1yZWd1bGF0b3IuYw0KPiA+ICtGOglkcml2ZXJzL3J0Yy9ydGMtYmQ3
MDUyOC5jDQo+ID4gK0Y6CWRyaXZlcnMvd2F0Y2hkb2cvYmQ3MDUyOF93ZHQuYw0KPiA+ICtGOglp
bmNsdWRlL2xpbnV4L21mZC9yb2htLXNoYXJlZC5oDQo+ID4gK0Y6CWluY2x1ZGUvbGludXgvbWZk
L3JvaG0tYmQ3MTgyOC5oDQo+ID4gK0Y6CWluY2x1ZGUvbGludXgvbWZkL3JvaG0tYmQ3MDUyOC5o
DQo+ID4gK0Y6CWluY2x1ZGUvbGludXgvbWZkL3JvaG0tZ2VuZXJpYy5oDQo+ID4gK0Y6CWluY2x1
ZGUvbGludXgvbWZkL3JvaG0tYmQ3MTh4Ny5oDQo+IA0KPiBIb3cgc21hbGwgY2FuIHlvdSBnZXQg
dGhpcyBsaXN0IHVzaW5nIHdpbGRjYXJkcz8NCkkgd2FzIGNvbnNpZGVyaW5nIHRoaXMgYnV0IHdp
bGRjYXJkcyBhcmUgc29tZXdoYXQgZXJyb3IgcHJvbmUuIEkgY2FuJ3QNCmd1YXJhbnRlZSB0aGV5
IGRvbid0IG1hdGNoIHRvIGRyaXZlcnMgd2hpY2ggSSBhbSBub3Qgd29ya2luZyB3aXRoIDooDQpU
aGUgQkR4eHh4eCBpcyBjb21tb24gZm9yIHByZXR0eSBtdWNoIGFsbCBST0hNIElDcyAod2VsbCwg
dGhlcmVzIGZldw0Kb3RoZXIgbGlrZSBCVXh4eHh4IGFuZCBCSHh4eHh4KSAtIGFuZCB0aGVyZSBp
cyBodWdlIGFtb3VudCBvZiBJQ3MuDQpIZW5jZSBJIHRoaW5rIGl0IGlzIGxpa2VseSB0aGUgd2ls
ZGNhcmRzICh3aWxsKSBtYXRjaCB0byBkcml2ZXJzDQptYWludGFpbmVkIGJ5IG90aGVycy4NCg0K
T25lIGFscmVhZHkgZXhpc3RpbmcgZXhhbXBsZSBpczoNClJPSE0gTVVMVElGVU5DVElPTiBCRDk1
NzFNV1YtTSBQTUlDIERFVklDRSBEUklWRVJTDQpNOiAgICAgIE1hcmVrIFZhc3V0IDxtYXJlay52
YXN1dCtyZW5lc2FzQGdtYWlsLmNvbT4NCkw6ICAgICAgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KTDogICAgICBsaW51eC1yZW5lc2FzLXNvY0B2Z2VyLmtlcm5lbC5vcmcNClM6ICAgICAg
U3VwcG9ydGVkICAgICAgICAgIA0KRjogICAgICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbWZkL2JkOTU3MW13di50eHQgICAgICAgICAgDQpGOiAgICAgIGRyaXZlcnMvZ3Bpby9n
cGlvLWJkOTU3MW13di5jDQpGOiAgICAgIGRyaXZlcnMvbWZkL2JkOTU3MW13di5jICAgICAgICAg
IA0KRjogICAgICBkcml2ZXJzL3JlZ3VsYXRvci9iZDk1NzFtd3YtcmVndWxhdG9yLmMNCkY6ICAg
ICAgaW5jbHVkZS9saW51eC9tZmQvYmQ5NTcxbXd2LmgNCg0KYWxzbyBMRURzIGhhdmUgc29tZSBS
T0hNIElDIGRyaXZlcnMgd2hpY2ggSSBhbSBub3QgZmFtaWxpYXIgd2l0aC4NCg0KPiANCj4gK0Y6
CWRyaXZlcnMvY2xrL2Nsay1iZDcxOHg3LmMNCj4gK0Y6CWRyaXZlcnMvZ3Bpby9ncGlvLWJkNyoN
Cj4gK0Y6CWRyaXZlcnMvbWZkL3JvaG0tYmQ3Kg0KPiArRjoJZHJpdmVycy9wb3dlci9zdXBwbHkv
YmQ3Kg0KPiArRjoJZHJpdmVycy9yZWd1bGF0b3IvYmQ3Kg0KPiArRjoJZHJpdmVycy9yZWd1bGF0
b3Ivcm9obS1yZWd1bGF0b3IuYw0KPiArRjoJZHJpdmVycy9ydGMvcnRjLWJkNyoNCj4gK0Y6CWRy
aXZlcnMvd2F0Y2hkb2cvYmQ3Kg0KPiArRjoJaW5jbHVkZS9saW51eC9tZmQvcm9obS0qDQo+IA0K
PiBPcg0KPiANCj4gK0Y6CWRyaXZlcnMvKi9iZDcqDQo+ICtGOglkcml2ZXJzLyovKi1iZDcqDQo+
ICtGOglkcml2ZXJzLyovcm9obS0qDQo+ICtGOglkcml2ZXJzLyovKnJvaG0tKg0KPiArRjoJaW5j
bHVkZS9saW51eC8qL3JvaG0tKg0KPiArRjoJaW5jbHVkZS9saW51eC8qLypyb2htLSoNCj4gDQo+
IE5vdCBjaGVja2VkIGVpdGhlciBvZiB0aGVzZS4gIFRoZXkgYXJlIGp1c3QgYW4gZXhhbXBsZS4N
Cg0KU28sIEkgYW0gc3VyZSBJIGNhbiBmaW5kIGEgd29ya2luZyBtYXRjaCBwYXR0ZXJuIGZvciBh
IGZldyBvZiB0aGUgZmlsZXMNCi0gYnV0IGlmIHVzaW5nIHdpbGRjYXJkcyBpcyBub3QgY29tcHVs
c29yeSBJJ2QgcmF0aGVyIG5vdCBkbyB0aGF0IGFzIEkNCmhhdmUgYSBmZWVsaW5nIHRoaXMgd2ls
bCBjYXVzZSB3cm9uZyBtYXRjaGVzLi4uDQoNCj4gDQo+ID4gIFJPU0UgTkVUV09SSyBMQVlFUg0K
PiA+ICBNOglSYWxmIEJhZWNobGUgPHJhbGZAbGludXgtbWlwcy5vcmc+DQo+ID4gIEw6CWxpbnV4
LWhhbXNAdmdlci5rZXJuZWwub3JnDQoNCkJyLA0KCU1hdHRpIFZhaXR0aW5lbg0KDQo=
