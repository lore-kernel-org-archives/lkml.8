Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78E1C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 16:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2DEB20661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 16:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgA3Q7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 11:59:10 -0500
Received: from mx1.unisoc.com ([222.66.158.135]:19740 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727158AbgA3Q7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 11:59:09 -0500
Received: from ig2.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 00UGwVFL011384
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 31 Jan 2020 00:58:31 +0800 (CST)
        (envelope-from Orson.Zhai@unisoc.com)
Received: from BJMBX01.spreadtrum.com (10.0.64.7) by BJMBX01.spreadtrum.com
 (10.0.64.7) with Microsoft SMTP Server (TLS) id 15.0.847.32; Fri, 31 Jan 2020
 00:58:27 +0800
Received: from BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7]) by
 BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7%16]) with mapi id
 15.00.0847.030; Fri, 31 Jan 2020 00:58:15 +0800
From:   =?gb2312?B?tdS+qSAoT3Jzb24gWmhhaSk=?= <Orson.Zhai@unisoc.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBtZmQ6IHN5c2NvbjogRml4IHN5c2Nvbl9yZWdtYXBf?=
 =?gb2312?B?bG9va3VwX2J5X3BoYW5kbGVfYXJncygpIGR1bW15?=
Thread-Topic: [PATCH] mfd: syscon: Fix
 syscon_regmap_lookup_by_phandle_args() dummy
Thread-Index: AQHV12yd7Q9Jzc8F1Ei2zz/NcLY8rKgDbXq7
Date:   Thu, 30 Jan 2020 16:58:14 +0000
Message-ID: <db72832dc08f48f6a337352b6eb5ac3c@BJMBX01.spreadtrum.com>
References: <20200130125529.2304-1-geert+renesas@glider.be>
In-Reply-To: <20200130125529.2304-1-geert+renesas@glider.be>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.1.248]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: SHSQR01.spreadtrum.com 00UGwVFL011384
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnksIEkgbWlzc2VkIGl0Lg0KDQpUaGFuayB5b3UgR2VlcnQhDQoNCkJlc3QsDQotT3Jzb24N
Cg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQq3orz+yMs6IEdl
ZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+DQq3osvNyrG85DogMjAy
MMTqMdTCMzDI1SAyMDo1NQ0KytW8/sjLOiC11L6pIChPcnNvbiBaaGFpKTsgTGVlIEpvbmVzDQqz
rcvNOiBBcm5kIEJlcmdtYW5uOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBHZWVydCBV
eXR0ZXJob2V2ZW4NCtb3zOI6IFtQQVRDSF0gbWZkOiBzeXNjb246IEZpeCBzeXNjb25fcmVnbWFw
X2xvb2t1cF9ieV9waGFuZGxlX2FyZ3MoKSBkdW1teQ0KDQpJZiBDT05GSUdfTUZEX1NZU0NPTj1u
Og0KDQogICAgaW5jbHVkZS9saW51eC9tZmQvc3lzY29uLmg6NTQ6MjM6IHdhcm5pbmc6IKGuc3lz
Y29uX3JlZ21hcF9sb29rdXBfYnlfcGhhbmRsZV9hcmdzoa8gZGVmaW5lZCBidXQgbm90IHVzZWQg
Wy1XdW51c2VkLWZ1bmN0aW9uXQ0KDQpGaXggdGhpcyBieSBhZGRpbmcgdGhlIG1pc3NpbmcgaW5s
aW5lIGtleXdvcmQuDQoNCkZpeGVzOiA2YTI0ZjU2N2FmNGFjY2VmICgibWZkOiBzeXNjb246IEFk
ZCBhcmd1bWVudHMgc3VwcG9ydCBmb3Igc3lzY29uIHJlZmVyZW5jZSIpDQpTaWduZWQtb2ZmLWJ5
OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg0KLS0tDQogaW5j
bHVkZS9saW51eC9tZmQvc3lzY29uLmggfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21mZC9z
eXNjb24uaCBiL2luY2x1ZGUvbGludXgvbWZkL3N5c2Nvbi5oDQppbmRleCA3MTRjYWIxZTA5ZDNj
MWZkLi43ZjIwZTliNTAyYTViZDQ4IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9tZmQvc3lz
Y29uLmgNCisrKyBiL2luY2x1ZGUvbGludXgvbWZkL3N5c2Nvbi5oDQpAQCAtNTEsNyArNTEsNyBA
QCBzdGF0aWMgaW5saW5lIHN0cnVjdCByZWdtYXAgKnN5c2Nvbl9yZWdtYXBfbG9va3VwX2J5X3Bo
YW5kbGUoDQogICAgICAgIHJldHVybiBFUlJfUFRSKC1FTk9UU1VQUCk7DQogfQ0KDQotc3RhdGlj
IHN0cnVjdCByZWdtYXAgKnN5c2Nvbl9yZWdtYXBfbG9va3VwX2J5X3BoYW5kbGVfYXJncygNCitz
dGF0aWMgaW5saW5lIHN0cnVjdCByZWdtYXAgKnN5c2Nvbl9yZWdtYXBfbG9va3VwX2J5X3BoYW5k
bGVfYXJncygNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qg
ZGV2aWNlX25vZGUgKm5wLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGNvbnN0IGNoYXIgKnByb3BlcnR5LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGludCBhcmdfY291bnQsDQotLQ0KMi4xNy4xDQoNCl9fX19fX19fX19fX19fX19fX19f
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
