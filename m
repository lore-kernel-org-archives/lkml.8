Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39C5C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 08:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E392072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 08:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgAQIGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 03:06:42 -0500
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:60536 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbgAQIGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 03:06:42 -0500
X-AuditID: c0a8fbf4-199ff70000001fa6-66-5e216b10fa32
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 90.F9.08102.01B612E5; Fri, 17 Jan 2020 09:06:41 +0100 (CET)
Received: from WILL-MAIL002.REu.RohmEu.com ([fe80::e0c3:e88c:5f22:d174]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0439.000; Fri, 17 Jan 2020 09:06:36 +0100
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] mfd: bd70528: Fix hour register mask
Thread-Topic: [PATCH] mfd: bd70528: Fix hour register mask
Thread-Index: AQHVy33u6ExLp0ReyUCqWPc5BSkWM6fubBCAgAADpgCAAAKhgA==
Date:   Fri, 17 Jan 2020 08:06:35 +0000
Message-ID: <b5835b0fe842a01888d66c07281e13fc64c2c9ef.camel@fi.rohmeurope.com>
References: <20200115082933.GA29117@localhost.localdomain>
         <83e8e1ecc40a58e2e6d1960bbb41c8dcfe730ce1.camel@fi.rohmeurope.com>
         <20200117075714.GA1822218@kroah.com>
In-Reply-To: <20200117075714.GA1822218@kroah.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <922C4D85FA8E4D4B8EBD588186E541A9@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42I5sOL3Jl3BbMU4g0VhFu3vlrFbNC9ez2Zx
        /+tRRovLu+awWcxZeoLFYtOaa2wObB7z1lR77Jx1l91j06pONo871/aweeyfu4bd4/MmuQC2
        KG6bpMSSsuDM9Dx9uwTujGVHJ7EWbOGtOHzkOWMDYwdvFyMnh4SAicST5efYuxi5OIQErjJK
        rFr8jxXCOcEocePeYcYuRg4ONgEbia6b7CANIgK2EhOXdTOD1DALzGSS+LT4BzNIQljAUmLz
        v71MEEVWErfePWCBsJ0kdt94BFbDIqAqsfLVbrA4r4CfxMzbC9kglq1glGi43AlWxClgKNHw
        6RFYEaOArERnwzuwocwC4hKbnn1nhThbQGLJnvPMELaoxMvH/6DiShJ7fz5kATmaWUBTYv0u
        fYhWB4l1P+ewQtiKElO6H7JD3CAocXLmE5YJjGKzkGyYhdA9C0n3LCTds5B0L2BkXcUokZuY
        mZOeWJJqqFeUWqpXlJ+RC6SS83M3MUIi9csOxv+HPA8xMnEwHmKU5GBSEuUV2SMbJ8SXlJ9S
        mZFYnBFfVJqTWnyIUYKDWUmE9+QMoBxvSmJlVWpRPkxKmoNFSZxX/eHEWCEBkF3ZqakFqUUw
        WRkODiUJXussxTghwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFACiS8GphCQFA/Q
        3vxMoHbe4oLEXKAoROspRm2OCS/nLmLmODJ36SJmIZa8/LxUKXFePZBNAiClGaV5cIteMYpz
        MCoJ89qDZHmAKRtuziugFUxAKyY4y4GsKElESEk1MBqdq3txkofT3/7Q79Uhkiu+XdDlDVxy
        QKhGT4Rfplma/UBT4vzlm96t38L+yrF5+fmlB/9sts6tZnO7cGB/M8dz9Y28X/T5uQvibVtP
        zr+nZmmSeafApTsqYfr2vV1Nfze7FtgFcx95EJOf8HjqgzcGQc+iEkMSBK4fP7zy45TCo1fr
        TPoOzlViKc5INNRiLipOBACD+vPrlgMAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBGcmksIDIwMjAtMDEtMTcgYXQgMDg6NTcgKzAxMDAsIGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnIHdyb3RlOg0KPiBPbiBGcmksIEphbiAxNywgMjAyMCBhdCAwNzo0NDowN0FNICswMDAw
LCBWYWl0dGluZW4sIE1hdHRpIHdyb3RlOg0KPiA+IA0KPiA+IElzIGl0IHBvc3NpYmxlIHRvIGdl
dCB0aGlzIGluIDUuNCBzdGFibGUgLSB3aGlsZSBsZWF2aW5nIHRoaXMgb3V0DQo+ID4gb2YNCj4g
PiBjdXJyZW50IE1GRCB0cmVlIGFuZCBhcHBseWluZyB0aGUgQkQ3MTgyOCBzZXJpZXMgdG8gTUZE
Pw0KPiANCj4gV2Ugb25seSB0YWtlIHBhdGNoZXMgdGhhdCBhcmUgaW4gTGludXMncyB0cmVlIGZv
ciB0aGUgc3RhYmxlIHRyZWUsDQo+IHVubGVzcyB0aGVyZSBhcmUgdmVyeSBiaWcgcmVhc29ucyBu
b3QgdG8gZG8gc28gKGkuZS4gaXQgaXMgdG90YWxseQ0KPiByZXdyaXR0ZW4gaW4gYSBkaWZmZXJl
bnQgd2F5IHRoZXJlLikNCj4gDQo+IE9uY2UgdGhlIGNoYW5nZS9maXggaXMgaW4gTGludXMncyB0
cmVlLCB0aGVuIHlvdSBjYW4gYmFja3BvcnQgaXQgdG8NCj4gc3RhYmxlIGluIGEgZGlmZmVyZW50
IHdheSBpZiB5b3Ugd2FudCwgYnV0IHlvdSBuZWVkIHRvIGdpdmUgbG90cyBvZg0KPiByZWFzb25z
IHdoeSBpdCBpcyBkb25lIHRoYXQgd2F5Lg0KDQpSaWdodC4gVGhhbmtzIGZvciB0aGUgZXhwbGFu
YXRpb24gR3JlZy4gSSBoYXZlIG5vIF9zdHJvbmdfIHJlYXNvbnMgLQ0Kd2hpY2ggbWVhbnMgSSds
bCBzcGxpdCB0aGUgUlRDIHN1cHBvcnQgcGF0Y2ggaW4gQkQ3MTgyOCBzZXJpZXMgaW50byB0d28N
Ci0gZmlyc3Qgb2YgdGhlIHBhdGNoZXMgYmVpbmcgdGhpcyBmaXgsIHNlY29uZCBiZWluZyB0aGUg
QkQ3MTgyOA0Kc3VwcG9ydC4gVGhlbiB0aGlzIGZpeCBjYW4gYmUgdGFrZW4gaW4gNS40IGFmdGVy
IGl0IGhhcyBiZWVuIG1lcmdlZCB0bw0KTGludXMnIHRyZWUgLSB0aGUgQkQ3MTgyOCBzdXBwb3J0
IGNhbiBiZSBvbWl0dGVkIGZyb20gNS40DQoNCkkgaG9wZSB0aGUgQkQ3MTgyOCBzZXJpZXMgY291
bGQgc3RpbGwgbWFrZSBpdCB0byBuZXh0IHJlbGVhc2UgLSBidXQgaWYNCml0IHdvbnQsIHRoZW4g
aXQgbWlnaHQgYmUgaW4gbmV4dCBhZnRlciB0aGF0IDpdDQoNCkxlZSwgcGxlYXNlIHNraXAgdGhp
cyBvbmUsIEknbGwgZG8gdjEwIG9mIHRoZSBCRDcxODI4IHNlcmllcyB3aGVyZSB0aGlzDQpmaXgg
aXMgaW5jbHVkZWQgYXMgc2VwYXJhdGUgZml4LXBhdGNoLg0KDQpSZWdhcmRzDQoJTWF0dGkNCg==
