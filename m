Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61767C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A6520715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgERHij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 03:38:39 -0400
Received: from mailgate1.rohmeurope.com ([87.129.152.131]:64872 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgERHii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 03:38:38 -0400
X-AuditID: c0a8fbf4-489ff70000004419-ae-5ec23b7d4f1e
Received: from smtp.reu.rohmeu.com (will-cas001.reu.rohmeu.com [192.168.251.177])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 92.08.17433.D7B32CE5; Mon, 18 May 2020 09:38:37 +0200 (CEST)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS001.REu.RohmEu.com ([fe80::d57e:33d0:7a5d:f0a6%16]) with mapi id
 14.03.0487.000; Mon, 18 May 2020 09:38:26 +0200
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>
CC:     "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: [not urgent] ROHM PMIC/Charger IC driver maintenance.
Thread-Topic: [not urgent] ROHM PMIC/Charger IC driver maintenance.
Thread-Index: AQHWLOdQMdOSpxREeE+Cws0ySbgdVA==
Date:   Mon, 18 May 2020 07:38:25 +0000
Message-ID: <18838efd9341c953fb6aabe9536786de3f1150ae.camel@fi.rohmeurope.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.78.225.252]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2CF97FD7B3A6648AC74FC53903AD49C@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUwTQRiGnd1tdwsuLKXYEY/E9cRElETjoIZ4BF3v65cH4CIrJULbbIsR
        jVgRRCAxGEGgglECgthAaAQBAXW9EK80Kh7xQggRo/gDEI2K7rIK/Jl5873zfO9M5qNwfZk2
        kIoz2wXRzMezWi/ievnP6jmHFkuR84pP+aISzzMSpfdcIFFfUSuBcts7tehd/22Avj09jqGc
        X2UYetJQqEWd5x9gqLC0hUCe1nCU1nSLRINt1QS6f9WOOroH8aW+3NcXaSR31nWQq3e+ITl3
        RYaWe93WqOUuulwarn7AQXJ5Z39gXK978ibddu8l0bx939a4WPPcsF3epr7cJGtz0P7K/ArS
        AS7PygQ6CjLz4bGWGo2i9UwbgDXX9qm6BcC0emsmoCgtswRmviQVaWBCYbXHLxN4UTgjaWB/
        YQGpHPdnwmBOb9eQNjAr4M9HnzFVB8PvPf24oglmOsy7+3KoTjMb4KWH5UPnATMJZjh6huo4
        Y4TurgGNejUGljQ+xlUdALs7Bv/Vp8ArA5WEch+cCYJVDXNVdCn8eMRFqnoKzMlqJ9UoP3iv
        oJPIBgbnqATnCO0cRTtH0c5R9DmgqQAwgY+Lj+XtQkiwKCQGixZTgrzttiS4gfrlfXXgj7Ra
        AhgFJDCewtgAOqj4RqTeJ9oSk2TibaYoMTFesEkAUjhroLf1Nkfq6Rg+6YAgWv5bEyiCNdIz
        209G6Bkla68gWAXxvzuRolhIV4VKkXo/UYgV9u+Ji7eP2BilU5p7BRpsgjlGEPlEuylKmYEo
        mzwEijVWzv2i4LTNyifIVRVtBSFUdndRMU7dKiqV1+dfm0pxPWG2mIVAI71zkQwwCmBKNA/H
        fQJGCrD+9GbFHStP/3C3T3IQJgeFe5QH2uz8iBXoADXPbpSLtcfSXy1aMA35z8zSGdY2ljlc
        YJnuRMl6qfawY5VXuu+aZlSyMnWtVGqqNSzk3UeTA7avizqds6XucWHBB+dH49R89o93SJg1
        GUm5KZUXlme82ZE6o9lTZe54NK2rIev877TfTTfzNkbcCe1lz1zWvx+32SdodvTb5G9jUljC
        ZuJDZuOijf8LY2Ur2LoDAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gQWxsLA0KDQpJbiBzaG9ydCAtIEkgY29uc2lkZXIgYWRkaW5nIG15c2VsZiBpbiBNQUlO
VEFJTkVScyBmb3IgdGhlIFJPSE0gSUMNCmRyaXZlcnMgSSd2ZSBhdXRob3JlZC4gSSB3b3VsZCBs
aWtlIHRvIGdldCB5b3VyIG9waW5pb24gYXMgc3Vic3lzdGVtDQptYWludGFpbmVycyBvbiB0aGUg
YXJlYSB3aGVyZSB0aGVzZSBkcml2ZXIgYmVsb25nLiBJZiB5b3UgZG9uJ3QgY2FyZSAtDQp0aGVu
IG5vIG5lZWQgdG8gcmVhZCBmdXJ0aGVyIDopIElmIHlvdSBkbyByZWFkLCB0aGVuIEkgd291bGQg
YXBwcmVjaWF0ZQ0KaGVhcmluZyBhYm91dCB5b3VyIGV4cGVjdGF0aW9ucyByZWdhcmRpbmcgcmV2
aWV3cywgQUNLcyBldGMuDQoNCg0KDQpMb25nZXIgc3RvcnksIEkgaGF2ZSBjb250cmlidXRlZCBk
cml2ZXJzIGZvciBST0hNIFBNSUNzDQpCRDcxODM3L0JENzE4NDcvQkQ3MTg1MCwgQkQ3MDUyOCwg
QkQ3MTgyOC9CRDcxODc4IGFuZCBST0hNIGNoYXJnZXIgSUMNCkJEOTk5NTQuIEkgZGlkIGFsc28g
cmVmYWN0b3IgdGhlIGxpbmVhcl9yYW5nZXMgY29kZSBvdXQgb2YgdGhlDQpyZWd1bGF0b3IgZnJh
bWV3b3JrLiBOb3cgSSBhbSB3b3JraW5nIG9uIHdpdGggYW5vdGhlciBQTUlDIGRyaXZlcg0KKHJl
Z3VsYXRvcnMvd2F0Y2hkb2cpIHdoaWNoIEkgaG9wZSB0byBlbmQgdXAgaW4gdXBzdHJlYW0gYXQg
YXV0dW1uDQphZnRlciB0aGUgcHJvcGVyIHRlc3RpbmcuIFRoZXJlIGlzIGFsc28gc29tZSBwaWVj
ZXMgaW4gcmVnbWFwLWlycSB3aGljaA0KSSBoYXZlIGFkZGVkLg0KDQpJIHdvdWxkIGxpa2UgdG8g
cGFydGljaXBhdGUgaW4gcmV2aWV3aW5nIHdvcmsgZm9yIHBhdGNoZXMgdG8gdGhlc2UNCmRyaXZl
cnMgKGFuZCBwZXJoYXBzIHRoZSBsaW5lYXJfcmFuZ2VzKSBhbmQgcG9zc2libHkgc2V0IHVwIHNv
bWUgdGVzdA0Kam9icyB3aGVyZSBJIGNhbiBydW4gc29tZSB0ZXN0cyBpbnZvbHZpbmcgc29tZSBv
ZiB0aGUgUE1JQ3MuIEkgaG9wZQ0KdGhpcyBoZWxwcyB0aGUgY29tbXVuaXR5IHRvby4NCg0KSSB3
b3VsZCBhbHNvIGJlbmVmaXQgZnJvbSBiZWluZyBpbmZvcm1lZCB3aGVuIGEgZml4IGlzIHNlbnQg
dG8gb25lIG9mDQp0aGVzZSBhcmVhcyBhcyBJIGFtIGFueXdheXMgcGFpZCB0byBiZSBob3N0aW5n
IHNvbWUgb3V0LW9mLXRyZWUNCmFkZGl0aW9ucyB0byB0aGVzZSBkcml2ZXJzLiBTbyBteSBnaXQg
dHJlZSB3b3VsZCBiZW5lZml0IGZyb20gZ2V0dGluZw0KdGhlIG9kZCBmaXhlcyB1cHN0cmVhbSBp
cyBnZXR0aW5nLiBSZXZpZXdpbmcgbWFpbHMgd291bGQgc2VydmUgYXMgYQ0KaGVhZHMgdXAgZm9y
IG1lLg0KDQpUaHVzIEkgY29uc2lkZXIgYWRkaW5nIGZldyBlbnRyaWVzIHRvIE1BSU5UQUlORVJz
IGluIG9yZGVyIHRvIGJlDQpnZXR0aW5nIHRoZSBwYXRjaGVzIGZvciByZXZpZXcvdGVzdC4gV2hh
dCBJIGRvbid0IGNvbnNpZGVyIGRvaW5nIGlzDQppbnRlZ3JhdGluZyB0aGUgcGF0Y2hlcyBpbiAi
b2ZmaWNpYWwgTGludXgiIC0gRWcuIGFsbCBwYXRjaGVzIHNob3VsZA0Kc3RpbGwgZ28gdXBzdHJl
YW0gdmlhIHlvdXIgdHJlZXMuDQoNCldoYXQga2luZCBvZiBwYXJ0aWNpcGF0aW9uIHdvdWxkIHlv
dSBleHBlY3QvYXBwcmVjaWF0ZSBmcm9tIG1lIGlmIEkNCmFkZGVkIG15c2VsZiBpbiBNQUlOVEFJ
TkVSUyBmb3IgdGhlc2UgZHJpdmVycyBJIGF1dGhvcmVkPyBBbnkNCm9iamVjdGlvbnMgdG8gdGhh
dD8gKEkgZG9uJ3QgcmVhbGx5IGtub3cgaG93IE1BSU5UQUlORVJzIGVudHJpZXMgc2hvdWxkDQpi
ZSBhZGRlZCAtIGFuZCBJIGRpZG4ndCBbZWFzaWx5XSBmaW5kIHVwLXRvLWRhdGUgZXhwbGFuYXRp
b24gdG8gdGhhdCkuDQpGb3Igd2hlcmUgSSBjYW4gYmUgb2YgaGVscCAtIEkgYmVsaWV2ZSBJIGFt
IHRlY2huaWNhbGx5IGNvbXBldGVudCBmb3INCnJldmlld2luZyBDLWNvZGUuIEkgYW0gbm90IGNv
bXBldGVudCBmb3IgcmV2aWV3aW5nIGFsbCBzdHlsaW5nIGRldGFpbHMNCi0gYW5kIEkgYW0gbm90
IHRvbyB1c2VmdWwgd2hhdCBjb21lcyB0byBZQU1MIC0gdGhpcyBzeW50YXggaXMgc3RpbGwNCnJl
YWxseSBhbGllbiB0byBtZS4gWWV0IEkgdGhpbmsgSSBoYXZlIHNvbWUgaW5zaWdodCB0byB0aGlu
Z3MgdGhlIERUDQp5YW1sIGlzIGRlc2NyaWJpbmcgKG1lYW5pbmcgUk9ITSBIVykgOikNCg0KSSBh
ZGQgYmVsb3cgdGhlIGxpc3Qgb2YgZmlsZXMgLyBzdWJzeXN0ZW0uDQoNClJlZ3VsYXRvcjoNCmJk
NzA1MjgtcmVndWxhdG9yLmMNCmJkNzE4MjgtcmVndWxhdG9yLmMNCmJkNzE4eDctcmVndWxhdG9y
LmMNCnJvaG0tcmVndWxhdG9yLmMNCihsaWIvbGluZWFyX3Jhbmdlcy5jDQpsaWIvdGVzdF9saW5l
YXJfcmFuZ2VzLmM/DQppbmNsdWRlL2xpbnV4L2xpbmVhcl9yYW5nZS5oIC0gV2hvIHNob3VsZCBt
YWludGFpbiB0aGVzZT8pDQoNClBvd2VyLXN1cHBseToNCmJkNzA1MjgtY2hhcmdlci5jDQpiZDcx
ODI3LXBvd2VyLmMNCmJkOTk5NTQtY2hhcmdlci5jDQpiZDk5OTU0LWNoYXJnZXIuaA0KDQpNRkQ6
DQpyb2htLWJkNzA1MjguYw0Kcm9obS1iZDcxODI4LmMNCnJvaG0tYmQ3MTh4Ny5jDQppbmNsdWRl
L2xpbnV4L21mZC9yb2htLXNoYXJlZC5oDQppbmNsdWRlL2xpbnV4L21mZC9yb2htLWJkNzE4Mjgu
aA0KaW5jbHVkZS9saW51eC9tZmQvcm9obS1iZDcwNTI4LmgNCmluY2x1ZGUvbGludXgvbWZkL3Jv
aG0tZ2VuZXJpYy5oDQppbmNsdWRlL2xpbnV4L21mZC9yb2htLWJkNzE4eDcuaA0KDQpHUElPOg0K
Z3Bpby1iZDcwNTI4LmMNCmdwaW8tYmQ3MTgyOC5jDQoNClJUQzoNCnJ0Yy1iZDcwNTI4LmMNCg0K
V2F0Y2hkb2c6DQpiZDcwNTI4X3dkdC5jDQoNCkNsazoNCmNsay1iZDcxOHg3LmMNCg0KRFQ6DQpE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXIvc3VwcGx5L3JvaG0sYmQ5OTk1
NC55YW1sDQpEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL3JvaG0sYmQ3MTgz
Ny1wbWljLnlhbWwNCkRvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvcm9obSxi
ZDcxODQ3LXBtaWMueWFtbA0KRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3JlZ3Vs
YXRvci9yb2htLGJkNzE4MzctcmVndWxhdG9yLnlhbWwNCkRvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9yZWd1bGF0b3Ivcm9obSxiZDcxODQ3LXJlZ3VsYXRvci55YW1sDQpEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL3JvaG0sYmQ3MTgyOC1wbWljLnlhbWwNCkRv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9sZWRzL3JvaG0sYmQ3MTgyOC1sZWRzLnlh
bWwNCkRvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZWd1bGF0b3Ivcm9obSxiZDcx
ODI4LXJlZ3VsYXRvci55YW1sDQpEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZk
L3JvaG0sYmQ3MDUyOC1wbWljLnR4dA0KRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3JlZ3VsYXRvci9yb2htLGJkNzA1MjgtcmVndWxhdG9yLnR4dA0KDQpCZXN0IFJlZ2FyZHMNCglN
YXR0aSBWYWl0dGluZW4NCg0KDQotLQ0KTWF0dGkgVmFpdHRpbmVuLCBMaW51eCBkZXZpY2UgZHJp
dmVycw0KUk9ITSBTZW1pY29uZHVjdG9ycywgRmlubGFuZCBTV0RDDQpLaXZpaGFyanVubGVua2tp
IDFFDQo5MDIyMCBPVUxVDQpGSU5MQU5EDQoNCn5+fiAiSSBkb24ndCB0aGluayBzbywiIHNhaWQg
UmVuZSBEZXNjYXJ0ZXMuIEp1c3QgdGhlbiBoZSB2YW5pc2hlZCB+fn4NCg0KU2ltb24gc2F5cyAt
IGluIExhdGluIHBsZWFzZS4NCiJub24gY29naXRvIG1lIiBkaXhpdCBSZW5lIERlc2NhcnRlLCBk
ZWluZGUgZXZhbmVzY2F2aXQNCg0KKFRoYW5rcyBmb3IgdGhlIHRyYW5zbGF0aW9uIFNpbW9uKQ0K
DQo=
