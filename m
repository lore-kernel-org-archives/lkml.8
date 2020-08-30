Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B787C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 16:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A21920714
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 16:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgH3QmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 12:42:13 -0400
Received: from mx1.unisoc.com ([222.66.158.135]:26039 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726155AbgH3QmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 12:42:10 -0400
Received: from ig2.spreadtrum.com (shmbx02.spreadtrum.com [10.0.1.204])
        by SHSQR01.spreadtrum.com with ESMTPS id 07UGalxD024044
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 31 Aug 2020 00:36:47 +0800 (CST)
        (envelope-from Leon.He@unisoc.com)
Received: from SHMBX04.spreadtrum.com (10.0.1.214) by SHMBX02.spreadtrum.com
 (10.0.1.204) with Microsoft SMTP Server (TLS) id 15.0.847.32; Mon, 31 Aug
 2020 00:36:43 +0800
Received: from SHMBX04.spreadtrum.com ([fe80::8532:ef18:9217:26f5]) by
 shmbx04.spreadtrum.com ([fe80::8532:ef18:9217:26f5%13]) with mapi id
 15.00.0847.030; Mon, 31 Aug 2020 00:36:43 +0800
From:   =?gb2312?B?us7QocH6IChMZW9uIEhlKQ==?= <Leon.He@unisoc.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Noralf Tronnes <noralf@tronnes.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "od@zcrc.me" <od@zcrc.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIHYyIDYvNl0gZHJtL3BhbmVsOiBBZGQgSWxpdGVrIElM?=
 =?gb2312?Q?I9341_DBI_panel_driver?=
Thread-Topic: [PATCH v2 6/6] drm/panel: Add Ilitek ILI9341 DBI panel driver
Thread-Index: AQHWeePNyyv5zmRbwEG1Gp1RC5T8uKlQ281x
Date:   Sun, 30 Aug 2020 16:36:42 +0000
Message-ID: <edf38d68214247f486db3cc1f81ec404@shmbx04.spreadtrum.com>
References: <20200822163250.63664-1-paul@crapouillou.net>,<20200822163250.63664-7-paul@crapouillou.net>
In-Reply-To: <20200822163250.63664-7-paul@crapouillou.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.1.253]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: SHSQR01.spreadtrum.com 07UGalxD024044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiArc3RydWN0IGlsaTkzNDEgew0KPiArICAgICAgIHN0cnVjdCBkcm1fcGFuZWwgcGFuZWw7DQo+
ICsgICAgICAgc3RydWN0IG1pcGlfZHNpX2RldmljZSAqZHNpOw0KPiArICAgICAgIGNvbnN0IHN0
cnVjdCBpbGk5MzQxX3BkYXRhICpwZGF0YTsNCj4gKw0KPiArICAgICAgIHN0cnVjdCBncGlvX2Rl
c2MgICAgICAgICpyZXNldF9ncGlvZDsNCj4gKyAgICAgICB1MzIgcm90YXRpb247DQo+ICt9Ow0K
PiArDQoNCkhpIFBhdWwsIHlvdSBwdXQgdGhlIG1pcGlfZHNpX2RldmljZSBpbnNpZGUgdGhlIHN0
cnVjdC4gSSB0aGluayBpdCBtYXliZSBub3QNCmEgZ29vZCBpZGVhLiBUaGF0IG1lYW5zIHRoZSBw
YW5lbCBoYXMgYSBNSVBJLURTSSBpbnRlcmZhY2UgYnV0IGl0IGRvZXNuJ3QNCmhhdmUgYWN0dWFs
bHkuDQoNCj4gK3N0YXRpYyBpbnQgaWxpOTM0MV9wcm9iZShzdHJ1Y3QgbWlwaV9kc2lfZGV2aWNl
ICpkc2kpDQo+ICt7DQo+ICsgICAgICAgc3RydWN0IGRldmljZSAqZGV2ID0gJmRzaS0+ZGV2Ow0K
PiArICAgICAgIHN0cnVjdCBpbGk5MzQxICpwcml2Ow0KPiArICAgICAgIGludCByZXQ7DQo+ICsN
Cj4gKyAgICAgICAvKiBTZWUgY29tbWVudCBmb3IgbWlwaV9kYmlfc3BpX2luaXQoKSAqLw0KPiAr
ICAgICAgIGlmICghZGV2LT5jb2hlcmVudF9kbWFfbWFzaykgew0KPiArICAgICAgICAgICAgICAg
cmV0ID0gZG1hX2NvZXJjZV9tYXNrX2FuZF9jb2hlcmVudChkZXYsIERNQV9CSVRfTUFTSygzMikp
Ow0KPiArICAgICAgICAgICAgICAgaWYgKHJldCkgew0KPiArICAgICAgICAgICAgICAgICAgICAg
ICBkZXZfd2FybihkZXYsICJGYWlsZWQgdG8gc2V0IGRtYSBtYXNrICVkXG4iLCByZXQpOw0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiArICAgICAgICAgICAgICAgfQ0K
PiArICAgICAgIH0NCj4gKw0KPiArICAgICAgIHByaXYgPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXpl
b2YoKnByaXYpLCBHRlBfS0VSTkVMKTsNCj4gKyAgICAgICBpZiAoIXByaXYpDQo+ICsgICAgICAg
ICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gKw0KPiArICAgICAgIG1pcGlfZHNpX3NldF9kcnZk
YXRhKGRzaSwgcHJpdik7DQo+ICsgICAgICAgcHJpdi0+ZHNpID0gZHNpOw0KPiArDQo+ICsgICAg
ICAgZGV2aWNlX3Byb3BlcnR5X3JlYWRfdTMyKGRldiwgInJvdGF0aW9uIiwgJnByaXYtPnJvdGF0
aW9uKTsNCj4gKw0KPiArICAgICAgIHByaXYtPnBkYXRhID0gZGV2aWNlX2dldF9tYXRjaF9kYXRh
KGRldik7DQo+ICsgICAgICAgaWYgKCFwcml2LT5wZGF0YSkNCj4gKyAgICAgICAgICAgICAgIHJl
dHVybiAtRUlOVkFMOw0KPiArDQo+ICsgICAgICAgZHJtX3BhbmVsX2luaXQoJnByaXYtPnBhbmVs
LCBkZXYsICZpbGk5MzQxX2Z1bmNzLA0KPiArICAgICAgICAgICAgICAgICAgICAgIERSTV9NT0RF
X0NPTk5FQ1RPUl9EUEkpOw0KPiArDQo+ICsgICAgICAgcHJpdi0+cmVzZXRfZ3Bpb2QgPSBkZXZt
X2dwaW9kX2dldChkZXYsICJyZXNldCIsIEdQSU9EX09VVF9ISUdIKTsNCj4gKyAgICAgICBpZiAo
SVNfRVJSKHByaXYtPnJlc2V0X2dwaW9kKSkgew0KPiArICAgICAgICAgICAgICAgZGV2X2Vycihk
ZXYsICJDb3VsZG4ndCBnZXQgb3VyIHJlc2V0IEdQSU9cbiIpOw0KPiArICAgICAgICAgICAgICAg
cmV0dXJuIFBUUl9FUlIocHJpdi0+cmVzZXRfZ3Bpb2QpOw0KPiArICAgICAgIH0NCj4gKw0KPiAr
ICAgICAgIHJldCA9IGRybV9wYW5lbF9vZl9iYWNrbGlnaHQoJnByaXYtPnBhbmVsKTsNCj4gKyAg
ICAgICBpZiAocmV0IDwgMCkgew0KPiArICAgICAgICAgICAgICAgaWYgKHJldCAhPSAtRVBST0JF
X0RFRkVSKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgIkZhaWxlZCB0
byBnZXQgYmFja2xpZ2h0IGhhbmRsZVxuIik7DQo+ICsgICAgICAgICAgICAgICByZXR1cm4gcmV0
Ow0KPiArICAgICAgIH0NCj4gKw0KPiArICAgICAgIGRybV9wYW5lbF9hZGQoJnByaXYtPnBhbmVs
KTsNCj4gKw0KPiArICAgICAgIGRzaS0+YnVzX3R5cGUgPSBwcml2LT5wZGF0YS0+YnVzX3R5cGU7
DQo+ICsgICAgICAgZHNpLT5sYW5lcyA9IHByaXYtPnBkYXRhLT5sYW5lczsNCj4gKyAgICAgICBk
c2ktPmZvcm1hdCA9IE1JUElfRFNJX0ZNVF9SR0I1NjU7DQo+ICsNCj4gKyAgICAgICByZXQgPSBt
aXBpX2RzaV9hdHRhY2goZHNpKTsNCj4gKyAgICAgICBpZiAocmV0KSB7DQo+ICsgICAgICAgICAg
ICAgICBkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBhdHRhY2ggRFNJIHBhbmVsXG4iKTsNCj4gKyAg
ICAgICAgICAgICAgIGdvdG8gZXJyX3BhbmVsX3JlbW92ZTsNCj4gKyAgICAgICB9DQo+ICsNCj4g
KyAgICAgICByZXQgPSBtaXBpX2RzaV9tYXliZV9yZWdpc3Rlcl90aW55X2RyaXZlcihkc2kpOw0K
PiArICAgICAgIGlmIChyZXQpIHsNCj4gKyAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiRmFp
bGVkIHRvIGluaXQgVGlueURSTSBkcml2ZXJcbiIpOw0KPiArICAgICAgICAgICAgICAgZ290byBl
cnJfbWlwaV9kc2lfZGV0YWNoOw0KPiArICAgICAgIH0NCj4gKw0KPiArICAgICAgIHJldHVybiAw
Ow0KPiArDQo+ICtlcnJfbWlwaV9kc2lfZGV0YWNoOg0KPiArICAgICAgIG1pcGlfZHNpX2RldGFj
aChkc2kpOw0KPiArZXJyX3BhbmVsX3JlbW92ZToNCj4gKyAgICAgICBkcm1fcGFuZWxfcmVtb3Zl
KCZwcml2LT5wYW5lbCk7DQo+ICsgICAgICAgcmV0dXJuIHJldDsNCj4gK30NCj4gKw0KPiArc3Rh
dGljIGludCBpbGk5MzQxX3JlbW92ZShzdHJ1Y3QgbWlwaV9kc2lfZGV2aWNlICpkc2kpDQo+ICt7
DQo+ICsgICAgICAgc3RydWN0IGlsaTkzNDEgKnByaXYgPSBtaXBpX2RzaV9nZXRfZHJ2ZGF0YShk
c2kpOw0KPiArDQo+ICsgICAgICAgbWlwaV9kc2lfZGV0YWNoKGRzaSk7DQo+ICsgICAgICAgZHJt
X3BhbmVsX3JlbW92ZSgmcHJpdi0+cGFuZWwpOw0KPiArDQo+ICsgICAgICAgZHJtX3BhbmVsX2Rp
c2FibGUoJnByaXYtPnBhbmVsKTsNCj4gKyAgICAgICBkcm1fcGFuZWxfdW5wcmVwYXJlKCZwcml2
LT5wYW5lbCk7DQo+ICsNCj4gKyAgICAgICByZXR1cm4gMDsNCj4gK30NCj4gKw0KPiArc3RhdGlj
IGNvbnN0IHN0cnVjdCBpbGk5MzQxX3BkYXRhIHl4MjQwcXYyOV9wZGF0YSA9IHsNCj4gKyAgICAg
ICAubW9kZSA9IHsgRFJNX1NJTVBMRV9NT0RFKDI0MCwgMzIwLCAzNywgNDkpIH0sDQo+ICsgICAg
ICAgLndpZHRoX21tID0gMCwgLy8gVE9ETw0KPiArICAgICAgIC5oZWlnaHRfbW0gPSAwLCAvLyBU
T0RPDQo+ICsgICAgICAgLmJ1c190eXBlID0gTUlQSV9EQ1NfQlVTX1RZUEVfREJJX1NQSV9DMywN
Cj4gKyAgICAgICAubGFuZXMgPSAxLA0KPiArfTsNCj4gKw0KPiArc3RhdGljIGNvbnN0IHN0cnVj
dCBvZl9kZXZpY2VfaWQgaWxpOTM0MV9vZl9tYXRjaFtdID0gew0KPiArICAgICAgIHsgLmNvbXBh
dGlibGUgPSAiYWRhZnJ1aXQseXgyNDBxdjI5IiwgLmRhdGEgPSAmeXgyNDBxdjI5X3BkYXRhIH0s
DQo+ICsgICAgICAgeyB9DQo+ICt9Ow0KPiArTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgaWxpOTM0
MV9vZl9tYXRjaCk7DQo+ICsNCj4gK3N0YXRpYyBzdHJ1Y3QgbWlwaV9kc2lfZHJpdmVyIGlsaTkz
NDFfZHNpX2RyaXZlciA9IHsNCj4gKyAgICAgICAucHJvYmUgICAgICAgICAgPSBpbGk5MzQxX3By
b2JlLA0KPiArICAgICAgIC5yZW1vdmUgICAgICAgICA9IGlsaTkzNDFfcmVtb3ZlLA0KPiArICAg
ICAgIC5kcml2ZXIgPSB7DQo+ICsgICAgICAgICAgICAgICAubmFtZSAgICAgICAgICAgPSAiaWxp
OTM0MS1kc2kiLA0KPiArICAgICAgICAgICAgICAgLm9mX21hdGNoX3RhYmxlID0gaWxpOTM0MV9v
Zl9tYXRjaCwNCj4gKyAgICAgICB9LA0KPiArfTsNCj4gK21vZHVsZV9taXBpX2RzaV9kcml2ZXIo
aWxpOTM0MV9kc2lfZHJpdmVyKTsNCg0KQWdhaW4sIHlvdSB0cmVhdCB0aGlzIGRyaXZlciBhcyBh
IG1pcGkgZHNpIGRyaXZlciBidXQgZm9yIGEgTUlQSS1EQkkgKEk4MDgwL1NQSSkNCnBhbmVsIGRl
dmljZS4gVGhhdCB3aWxsIG1ha2UgZGV2ZWxvcGVycyBjb25mdXNlZC4NCg0KSXMgaXQgcG9zc2li
bGUgdG8ganVzdCBhZGQgYSBtaXBpX2RiaV9kcml2ZXIgZm9yIEk4MDgwL1NQSSBpbnRlcmZhY2Ug
cGFuZWw/DQpUaGFua3MhDQoNCg0KQmVzdCByZWdhcmRzDQoNCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fDQogVGhpcyBlbWFpbCAoaW5jbHVkaW5nIGl0cyBhdHRhY2htZW50cykgaXMg
aW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNvbiBvciBlbnRpdHkgdG8gd2hpY2ggaXQgaXMgYWRk
cmVzc2VkIGFuZCBtYXkgY29udGFpbiBpbmZvcm1hdGlvbiB0aGF0IGlzIHByaXZpbGVnZWQsIGNv
bmZpZGVudGlhbCBvciBvdGhlcndpc2UgcHJvdGVjdGVkIGZyb20gZGlzY2xvc3VyZS4gVW5hdXRo
b3JpemVkIHVzZSwgZGlzc2VtaW5hdGlvbiwgZGlzdHJpYnV0aW9uIG9yIGNvcHlpbmcgb2YgdGhp
cyBlbWFpbCBvciB0aGUgaW5mb3JtYXRpb24gaGVyZWluIG9yIHRha2luZyBhbnkgYWN0aW9uIGlu
IHJlbGlhbmNlIG9uIHRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIG9yIHRoZSBpbmZvcm1hdGlv
biBoZXJlaW4sIGJ5IGFueW9uZSBvdGhlciB0aGFuIHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIG9y
IGFuIGVtcGxveWVlIG9yIGFnZW50IHJlc3BvbnNpYmxlIGZvciBkZWxpdmVyaW5nIHRoZSBtZXNz
YWdlIHRvIHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuIElm
IHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBkbyBub3QgcmVhZCwg
Y29weSwgdXNlIG9yIGRpc2Nsb3NlIGFueSBwYXJ0IG9mIHRoaXMgZS1tYWlsIHRvIG90aGVycy4g
UGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBwZXJtYW5lbnRseSBkZWxl
dGUgdGhpcyBlLW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBpZiB5b3UgcmVjZWl2ZWQgaXQgaW4g
ZXJyb3IuIEludGVybmV0IGNvbW11bmljYXRpb25zIGNhbm5vdCBiZSBndWFyYW50ZWVkIHRvIGJl
IHRpbWVseSwgc2VjdXJlLCBlcnJvci1mcmVlIG9yIHZpcnVzLWZyZWUuIFRoZSBzZW5kZXIgZG9l
cyBub3QgYWNjZXB0IGxpYWJpbGl0eSBmb3IgYW55IGVycm9ycyBvciBvbWlzc2lvbnMuDQqxvtPK
vP68sMbkuL28/r7f09Cxo8Pc0NTWyqOsyty3qMLJsaO7pLK7tcPQucK2o6y99reiy824+LG+08q8
/sv51rjM2LaoytW8/sjLoaPRz737t8e+rcrayKjKudPDoaLQ+7SroaK3orK8u/K4tNbGsb7Tyrz+
u/LG5MTayN2ho8j0t8e4w8zYtqjK1bz+yMujrMfrzvDUxLbBoaK4tNbGoaIgyrnTw7vyxfvCtrG+
08q8/rXEyM66zsTayN2ho8j0zvPK1bG+08q8/qOsx+u008+1zbPW0NPAvsPQ1Mm+s/2xvtPKvP68
sMv509C4vbz+o6yyotLUu9i4tNPKvP61xLe9yr28tL/MuObWqreivP7Iy6Gjzt63qLGj1qS7pcGq
zfjNqNDFvLDKsaGisLLIq6Gizt7O87vyt8C2vqGjt6K8/sjLttTIzrrOtO3Cqb75sruz0LWj1PDI
zqGjDQo=
