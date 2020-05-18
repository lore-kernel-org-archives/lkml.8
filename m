Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD4EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF4B7207E8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgERLyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 07:54:20 -0400
Received: from mailgate1.rohmeurope.com ([87.129.152.131]:47292 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbgERLyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:54:19 -0400
X-AuditID: c0a8fbf4-489ff70000004419-51-5ec2776a3e1b
Received: from smtp.reu.rohmeu.com (will-cas001.reu.rohmeu.com [192.168.251.177])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 41.19.17433.A6772CE5; Mon, 18 May 2020 13:54:18 +0200 (CEST)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS001.REu.RohmEu.com ([fe80::d57e:33d0:7a5d:f0a6%16]) with mapi id
 14.03.0487.000; Mon, 18 May 2020 13:54:05 +0200
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "sre@kernel.org" <sre@kernel.org>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>
Subject: Re: [not urgent] ROHM PMIC/Charger IC driver maintenance.
Thread-Topic: [not urgent] ROHM PMIC/Charger IC driver maintenance.
Thread-Index: AQHWLOdQMdOSpxREeE+Cws0ySbgdVKiti8KAgAAO/IA=
Date:   Mon, 18 May 2020 11:54:04 +0000
Message-ID: <cf26647cc55c411cefb4d46e0ecabf9df3cf02ef.camel@fi.rohmeurope.com>
References: <18838efd9341c953fb6aabe9536786de3f1150ae.camel@fi.rohmeurope.com>
         <20200518110031.tthams2r7tkcytie@earth.universe>
In-Reply-To: <20200518110031.tthams2r7tkcytie@earth.universe>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.78.225.252]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0D6327BDF8A1F4E85D2B5DE72E1D790@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02TaUzTYBjH87Zd1yHFMkFe58miElE5xA+NosEDrYkxGkw8omCVSqdsw67D
        68tQUcEjM3hkCyAeiAce7IMo4jUhGRMQFIhGjFkADcSICrIoBmypCJ/67/t/fs//eZPnJVDt
        I1xHGEwiJ5jYdD0egD273l82d9ded3JMc1YwfbWxWU0f+3pNTfcWeDH6nK8dpz/+rAZ0X9Nx
        hD77pwSh31Tk43T7pVqEzi/2YHSjN5HOflylpgdayjD65SORbuscQBPGMt1vs9VMYelB5qHz
        g5px3czBmdaWSpy5UVqqYh76bWrmQuEvhOlxTVmr2TwmfjsrZiYZ0kzRi7eN4Qv652U0xe8r
        qhZs4OTCXKAhIDUffn/jRXJBAKGlWgCsLisGyo8HQEd+n+QQBE7Fw9x3ahkIoWbAPu97VK5B
        qbcqeKv8nko2xlFLoae1DlWKlsH++i+IohfAulPfhmBMgnNd13BZk9Qa+MPnH6rXUocAtF/k
        Za2hFsHntkFM1oCaDHNsX4f6oFQYdH3yq5SpKXi18hWq6FDY2Tbw7zwclvvvYPLMKDUL3q2I
        VtAEmFXxACg6HJ494VMrIwTDGkc7ZgfjnaMSnCO0cxTtHEU7R9FFQHUTQCNrSE9jRS42SuCs
        UYKZN0qfHWajCyjL0PsADLpXuQFCADeYQCD6UHKD6E7WBm03p+7nWQufIljTOYsbQALVh5Cb
        ep4ka8lUdv8BTjAPWxMJTB9GRvjObNVSctZujsvghGF3EkHoISlkSk2DBS6N27fTkC6O2Aih
        kZsH6EIsnCmVE1iryKfI25FikdZDtgKl3ASrhJOWDNYonSqoF8wm7J0Fl1GiqqD4MqrFTGYT
        pwsjD8tJlFzKW03/g7pAGAH048gSuVGg9CL+9+mSIhApIrFRvppFZEcsnQ2sr13RYI+9fevG
        uWeRc+7X1OZE1df02sy/13yuPL0rYs+fcv9T3fS+bR1Tp0V6yzyhhit5F6dt7AlybeCf8KKt
        XoMf6ciYeQo6Tp7vfoF4uu2xDSbxRVxmERrxui3aGBiXtzJkCZeVUOeIWe59PrdqC540vsE3
        e93RFTHrVjtmGKr1mIVnYyNRwcL+BeoE5jvOAwAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gU2ViYXN0aWFuLA0KDQpPbiBNb24sIDIwMjAtMDUtMTggYXQgMTM6MDAgKzAyMDAsIFNl
YmFzdGlhbiBSZWljaGVsIHdyb3RlOg0KPiBIaSwNCj4gDQo+IE9uIE1vbiwgTWF5IDE4LCAyMDIw
IGF0IDA3OjM4OjI1QU0gKzAwMDAsIFZhaXR0aW5lbiwgTWF0dGkgd3JvdGU6DQo+ID4gSGVsbG8g
QWxsLA0KPiA+IA0KPiA+IEluIHNob3J0IC0gSSBjb25zaWRlciBhZGRpbmcgbXlzZWxmIGluIE1B
SU5UQUlORVJzIGZvciB0aGUgUk9ITSBJQw0KPiA+IGRyaXZlcnMgSSd2ZSBhdXRob3JlZC4gSSB3
b3VsZCBsaWtlIHRvIGdldCB5b3VyIG9waW5pb24gYXMNCj4gPiBzdWJzeXN0ZW0NCj4gPiBtYWlu
dGFpbmVycyBvbiB0aGUgYXJlYSB3aGVyZSB0aGVzZSBkcml2ZXIgYmVsb25nLiBJZiB5b3UgZG9u
J3QNCj4gPiBjYXJlIC0NCj4gPiB0aGVuIG5vIG5lZWQgdG8gcmVhZCBmdXJ0aGVyIDopIElmIHlv
dSBkbyByZWFkLCB0aGVuIEkgd291bGQNCj4gPiBhcHByZWNpYXRlDQo+ID4gaGVhcmluZyBhYm91
dCB5b3VyIGV4cGVjdGF0aW9ucyByZWdhcmRpbmcgcmV2aWV3cywgQUNLcyBldGMuDQo+ID4gDQo+
ID4gTG9uZ2VyIHN0b3J5LCBJIGhhdmUgY29udHJpYnV0ZWQgZHJpdmVycyBmb3IgUk9ITSBQTUlD
cw0KPiA+IEJENzE4MzcvQkQ3MTg0Ny9CRDcxODUwLCBCRDcwNTI4LCBCRDcxODI4L0JENzE4Nzgg
YW5kIFJPSE0gY2hhcmdlcg0KPiA+IElDDQo+ID4gQkQ5OTk1NC4gSSBkaWQgYWxzbyByZWZhY3Rv
ciB0aGUgbGluZWFyX3JhbmdlcyBjb2RlIG91dCBvZiB0aGUNCj4gPiByZWd1bGF0b3IgZnJhbWV3
b3JrLiBOb3cgSSBhbSB3b3JraW5nIG9uIHdpdGggYW5vdGhlciBQTUlDIGRyaXZlcg0KPiA+IChy
ZWd1bGF0b3JzL3dhdGNoZG9nKSB3aGljaCBJIGhvcGUgdG8gZW5kIHVwIGluIHVwc3RyZWFtIGF0
IGF1dHVtbg0KPiA+IGFmdGVyIHRoZSBwcm9wZXIgdGVzdGluZy4gVGhlcmUgaXMgYWxzbyBzb21l
IHBpZWNlcyBpbiByZWdtYXAtaXJxDQo+ID4gd2hpY2gNCj4gPiBJIGhhdmUgYWRkZWQuDQo+ID4g
DQo+ID4gSSB3b3VsZCBsaWtlIHRvIHBhcnRpY2lwYXRlIGluIHJldmlld2luZyB3b3JrIGZvciBw
YXRjaGVzIHRvIHRoZXNlDQo+ID4gZHJpdmVycyAoYW5kIHBlcmhhcHMgdGhlIGxpbmVhcl9yYW5n
ZXMpIGFuZCBwb3NzaWJseSBzZXQgdXAgc29tZQ0KPiA+IHRlc3QNCj4gPiBqb2JzIHdoZXJlIEkg
Y2FuIHJ1biBzb21lIHRlc3RzIGludm9sdmluZyBzb21lIG9mIHRoZSBQTUlDcy4gSSBob3BlDQo+
ID4gdGhpcyBoZWxwcyB0aGUgY29tbXVuaXR5IHRvby4NCj4gPiANCj4gPiBJIHdvdWxkIGFsc28g
YmVuZWZpdCBmcm9tIGJlaW5nIGluZm9ybWVkIHdoZW4gYSBmaXggaXMgc2VudCB0byBvbmUNCj4g
PiBvZg0KPiA+IHRoZXNlIGFyZWFzIGFzIEkgYW0gYW55d2F5cyBwYWlkIHRvIGJlIGhvc3Rpbmcg
c29tZSBvdXQtb2YtdHJlZQ0KPiA+IGFkZGl0aW9ucyB0byB0aGVzZSBkcml2ZXJzLiBTbyBteSBn
aXQgdHJlZSB3b3VsZCBiZW5lZml0IGZyb20NCj4gPiBnZXR0aW5nDQo+ID4gdGhlIG9kZCBmaXhl
cyB1cHN0cmVhbSBpcyBnZXR0aW5nLiBSZXZpZXdpbmcgbWFpbHMgd291bGQgc2VydmUgYXMgYQ0K
PiA+IGhlYWRzIHVwIGZvciBtZS4NCj4gPiANCj4gPiBUaHVzIEkgY29uc2lkZXIgYWRkaW5nIGZl
dyBlbnRyaWVzIHRvIE1BSU5UQUlORVJzIGluIG9yZGVyIHRvIGJlDQo+ID4gZ2V0dGluZyB0aGUg
cGF0Y2hlcyBmb3IgcmV2aWV3L3Rlc3QuIFdoYXQgSSBkb24ndCBjb25zaWRlciBkb2luZyBpcw0K
PiA+IGludGVncmF0aW5nIHRoZSBwYXRjaGVzIGluICJvZmZpY2lhbCBMaW51eCIgLSBFZy4gYWxs
IHBhdGNoZXMNCj4gPiBzaG91bGQNCj4gPiBzdGlsbCBnbyB1cHN0cmVhbSB2aWEgeW91ciB0cmVl
cy4NCj4gPiANCj4gPiBXaGF0IGtpbmQgb2YgcGFydGljaXBhdGlvbiB3b3VsZCB5b3UgZXhwZWN0
L2FwcHJlY2lhdGUgZnJvbSBtZSBpZiBJDQo+ID4gYWRkZWQgbXlzZWxmIGluIE1BSU5UQUlORVJT
IGZvciB0aGVzZSBkcml2ZXJzIEkgYXV0aG9yZWQ/IEFueQ0KPiA+IG9iamVjdGlvbnMgdG8gdGhh
dD8gKEkgZG9uJ3QgcmVhbGx5IGtub3cgaG93IE1BSU5UQUlORVJzIGVudHJpZXMNCj4gPiBzaG91
bGQNCj4gPiBiZSBhZGRlZCAtIGFuZCBJIGRpZG4ndCBbZWFzaWx5XSBmaW5kIHVwLXRvLWRhdGUg
ZXhwbGFuYXRpb24gdG8NCj4gPiB0aGF0KS4NCj4gPiBGb3Igd2hlcmUgSSBjYW4gYmUgb2YgaGVs
cCAtIEkgYmVsaWV2ZSBJIGFtIHRlY2huaWNhbGx5IGNvbXBldGVudA0KPiA+IGZvcg0KPiA+IHJl
dmlld2luZyBDLWNvZGUuIEkgYW0gbm90IGNvbXBldGVudCBmb3IgcmV2aWV3aW5nIGFsbCBzdHls
aW5nDQo+ID4gZGV0YWlscw0KPiA+IC0gYW5kIEkgYW0gbm90IHRvbyB1c2VmdWwgd2hhdCBjb21l
cyB0byBZQU1MIC0gdGhpcyBzeW50YXggaXMgc3RpbGwNCj4gPiByZWFsbHkgYWxpZW4gdG8gbWUu
IFlldCBJIHRoaW5rIEkgaGF2ZSBzb21lIGluc2lnaHQgdG8gdGhpbmdzIHRoZQ0KPiA+IERUDQo+
ID4geWFtbCBpcyBkZXNjcmliaW5nIChtZWFuaW5nIFJPSE0gSFcpIDopDQo+ID4gDQo+ID4gSSBh
ZGQgYmVsb3cgdGhlIGxpc3Qgb2YgZmlsZXMgLyBzdWJzeXN0ZW0uDQo+ID4gDQo+ID4gUmVndWxh
dG9yOg0KPiA+IGJkNzA1MjgtcmVndWxhdG9yLmMNCj4gPiBiZDcxODI4LXJlZ3VsYXRvci5jDQo+
ID4gYmQ3MTh4Ny1yZWd1bGF0b3IuYw0KPiA+IHJvaG0tcmVndWxhdG9yLmMNCj4gPiAobGliL2xp
bmVhcl9yYW5nZXMuYw0KPiA+IGxpYi90ZXN0X2xpbmVhcl9yYW5nZXMuYz8NCj4gPiBpbmNsdWRl
L2xpbnV4L2xpbmVhcl9yYW5nZS5oIC0gV2hvIHNob3VsZCBtYWludGFpbiB0aGVzZT8pDQo+ID4g
DQo+ID4gUG93ZXItc3VwcGx5Og0KPiA+IGJkNzA1MjgtY2hhcmdlci5jDQo+ID4gYmQ3MTgyNy1w
b3dlci5jDQo+ID4gYmQ5OTk1NC1jaGFyZ2VyLmMNCj4gPiBiZDk5OTU0LWNoYXJnZXIuaA0KPiA+
IA0KPiA+IE1GRDoNCj4gPiByb2htLWJkNzA1MjguYw0KPiA+IHJvaG0tYmQ3MTgyOC5jDQo+ID4g
cm9obS1iZDcxOHg3LmMNCj4gPiBpbmNsdWRlL2xpbnV4L21mZC9yb2htLXNoYXJlZC5oDQo+ID4g
aW5jbHVkZS9saW51eC9tZmQvcm9obS1iZDcxODI4LmgNCj4gPiBpbmNsdWRlL2xpbnV4L21mZC9y
b2htLWJkNzA1MjguaA0KPiA+IGluY2x1ZGUvbGludXgvbWZkL3JvaG0tZ2VuZXJpYy5oDQo+ID4g
aW5jbHVkZS9saW51eC9tZmQvcm9obS1iZDcxOHg3LmgNCj4gPiANCj4gPiBHUElPOg0KPiA+IGdw
aW8tYmQ3MDUyOC5jDQo+ID4gZ3Bpby1iZDcxODI4LmMNCj4gPiANCj4gPiBSVEM6DQo+ID4gcnRj
LWJkNzA1MjguYw0KPiA+IA0KPiA+IFdhdGNoZG9nOg0KPiA+IGJkNzA1Mjhfd2R0LmMNCj4gPiAN
Cj4gPiBDbGs6DQo+ID4gY2xrLWJkNzE4eDcuYw0KPiA+IA0KPiA+IERUOg0KPiA+IERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlci9zdXBwbHkvcm9obSxiZDk5OTU0LnlhbWwN
Cj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL3JvaG0sYmQ3MTgzNy1w
bWljLnlhbWwNCj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL3JvaG0s
YmQ3MTg0Ny1wbWljLnlhbWwNCj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cmVndWxhdG9yL3JvaG0sYmQ3MTgzNy0NCj4gPiByZWd1bGF0b3IueWFtbA0KPiA+IERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZWd1bGF0b3Ivcm9obSxiZDcxODQ3LQ0KPiA+IHJl
Z3VsYXRvci55YW1sDQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9y
b2htLGJkNzE4MjgtcG1pYy55YW1sDQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2xlZHMvcm9obSxiZDcxODI4LWxlZHMueWFtbA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9yZWd1bGF0b3Ivcm9obSxiZDcxODI4LQ0KPiA+IHJlZ3VsYXRvci55YW1s
DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9yb2htLGJkNzA1Mjgt
cG1pYy50eHQNCj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVndWxhdG9y
L3JvaG0sYmQ3MDUyOC0NCj4gPiByZWd1bGF0b3IudHh0DQo+ID4gDQo+ID4gQmVzdCBSZWdhcmRz
DQo+ID4gCU1hdHRpIFZhaXR0aW5lbg0KPiANCj4gSSBzdWdnZXN0IHRvIGp1c3Qgc2VuZCBzb21l
dGhpbmcgbGlrZSB0aGlzIGVudHJ5IGFkYXB0ZWQgdG8gdGhlIFJPSE0NCj4gZHJpdmVyczoNCj4g
DQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPiBUSSBCUTI3WFhYIFBPV0VSIFNVUFBMWSBEUklWRVINCj4gUjogICAgICBBbmRy
ZXcgRi4gRGF2aXMgPGFmZEB0aS5jb20+DQo+IEY6ICAgICAgZHJpdmVycy9wb3dlci9zdXBwbHkv
YnEyN3h4eF9iYXR0ZXJ5LmMNCj4gRjogICAgICBkcml2ZXJzL3Bvd2VyL3N1cHBseS9icTI3eHh4
X2JhdHRlcnlfaTJjLmMNCj4gRjogICAgICBpbmNsdWRlL2xpbnV4L3Bvd2VyL2JxMjd4eHhfYmF0
dGVyeS5oDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiANCj4gSXQgd2lsbCByZXN1bHQgaW4gZ2V0X21haW50YWluZXIucGwg
dG8gb3V0cHV0IHRoaXM6DQo+IA0KPiAkIC4vc2NyaXB0cy9nZXRfbWFpbnRhaW5lci5wbCAtZg0K
PiBkcml2ZXJzL3Bvd2VyL3N1cHBseS9icTI3eHh4X2JhdHRlcnkuYw0KPiAiQW5kcmV3IEYuIERh
dmlzIiA8YWZkQHRpLmNvbT4gKHJldmlld2VyOlRJIEJRMjdYWFggUE9XRVIgU1VQUExZDQo+IERS
SVZFUikNCj4gIlBhbGkgUm9ow6FyIiA8cGFsaUBrZXJuZWwub3JnPiAocmV2aWV3ZXI6Tk9LSUEg
TjkwMCBQT1dFUiBTVVBQTFkNCj4gRFJJVkVSUykNCj4gU2ViYXN0aWFuIFJlaWNoZWwgPHNyZUBr
ZXJuZWwub3JnPiAobWFpbnRhaW5lcjpQT1dFUiBTVVBQTFkNCj4gQ0xBU1MvU1VCU1lTVEVNIGFu
ZCBEUklWRVJTKQ0KPiBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmcgKG9wZW4gbGlzdDpQT1dFUiBT
VVBQTFkgQ0xBU1MvU1VCU1lTVEVNIGFuZA0KPiBEUklWRVJTKQ0KPiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnIChvcGVuIGxpc3QpDQo+IA0KPiBGb3IgZHJpdmVycyB3aXRoIGEgZGVkaWNh
dGVkIHJldmlld2VyIEkgd2FpdCBzb21lIHRpbWUgZm9yIHRoZWlyDQo+IGZlZWRiYWNrLg0KDQpU
aGFua3MgZm9yIHlvdXIga2luZCByZXNwb25zZSA6KSBJIGRvIGFwcHJlY2lhdGUgeW91ciBoZWxw
IQ0KDQo+IEZvciB0aGUgRFQgWUFNTCBiaW5kaW5ncyB5b3UgZG9uJ3QgbmVlZCB0byBkbyBhbnl0
aGluZzoNCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvZTg1MDA2NDU2ZDlkYmFl
NTUyODZjNjdhYzUyNjM2NjhhNzJmNWI1OC4xNTg4MDIyMjI4LmdpdC5qb2VAcGVyY2hlcy5jb20v
DQoNCk9oLCB0aGlzIG1ha2VzIGZpbGUtbGlzdCBtdWNoIHNob3J0ZXIgOikgVGhhbmtzIGZvciBw
b2ludGluZyBpdCBvdXQhIEl0DQpsZWF2ZXMgbWUgdG8ganVzdCBsaXN0IHRoZSB0d28gb2xkIGJk
NzA1MjggYmluZGluZyB0eHQgZG9jdW1lbnRzIHVudGlsDQp0aGV5J2xsIGJlIHlhbWxpZmllZC4N
Cg0KQmVzdCByZWdhcmRzOg0KCU1hdHRpDQoNCg0K
