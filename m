Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EB9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17CE02087C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="YFJpAY2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgH0QTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:19:31 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:47841 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726217AbgH0QT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:19:28 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 24913820D7;
        Thu, 27 Aug 2020 19:19:26 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1598545166;
        bh=X/T+Mz5v6jaNxnfLQ/Q8wj/6YGrVbgvxEaIwU+lQOOA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=YFJpAY2MGSB4G/znDotKzkGOpPvr8zvm9sz0lBwHZeIRBlXB37w5FsD8tppBcLsNi
         x7hv1FW6UPb/zZHAqbYheEHXDnQ8WfPU04Dqd8qINOptX2VbVWsZOIjEPFrRVV8dZi
         Bu/kbyCKtKhy8KDLg1W4dX5q4Pq5syAuBicWbgSA=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 27 Aug 2020 19:19:25 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Thu, 27 Aug 2020 19:19:25 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH v2 04/10] fs/ntfs3: Add file operations and implementation
Thread-Topic: [PATCH v2 04/10] fs/ntfs3: Add file operations and
 implementation
Thread-Index: AdZ30xLVoDYYB7UKQnicP7vQuyMYSgBRlu6AANz7mJA=
Date:   Thu, 27 Aug 2020 16:19:25 +0000
Message-ID: <0471292fb5af4a59bcc1f5b155894621@paragon-software.com>
References: <f8b5a938664e43c3b81df41f5c430c68@paragon-software.com>
 <20200823094839.nb2kchfbvwvynorq@pali>
In-Reply-To: <20200823094839.nb2kchfbvwvynorq@pali>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.8.36]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUGFsaSBSb2jDoXIgPHBhbGlAa2VybmVsLm9yZz4NClNlbnQ6IFN1bmRheSwgQXVndXN0
IDIzLCAyMDIwIDEyOjQ5IFBNDQo+IA0KPiBIZWxsbyBLb25zdGFudGluIQ0KPiANCj4gT24gRnJp
ZGF5IDIxIEF1Z3VzdCAyMDIwIDE2OjI1OjE1IEtvbnN0YW50aW4gS29tYXJvdiB3cm90ZToNCj4g
PiBkaWZmIC0tZ2l0IGEvZnMvbnRmczMvZGlyLmMgYi9mcy9udGZzMy9kaXIuYw0KPiA+IG5ldyBm
aWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi41ZjExMDVmMTI4M2MNCj4g
PiAtLS0gL2Rldi9udWxsDQpbXQ0KPiA+ICsjaW5jbHVkZSA8bGludXgvaXZlcnNpb24uaD4NCj4g
PiArI2luY2x1ZGUgPGxpbnV4L25scy5oPg0KPiA+ICsNCj4gPiArI2luY2x1ZGUgImRlYnVnLmgi
DQo+ID4gKyNpbmNsdWRlICJudGZzLmgiDQo+ID4gKyNpbmNsdWRlICJudGZzX2ZzLmgiDQo+ID4g
Kw0KPiA+ICsvKg0KPiA+ICsgKiBDb252ZXJ0IGxpdHRsZSBlbmRpYW4gVW5pY29kZSAxNiB0byBV
VEYtOC4NCj4gDQo+IEkgZ3Vlc3MgdGhhdCBieSAiVW5pY29kZSAxNiIgeW91IG1lYW4gVVRGLTE2
LCByaWdodD8NCj4gDQo+IEFueXdheSwgY29tbWVudCBpcyBpbmNvcnJlY3QgYXMgZnVuY3Rpb24g
ZG9lcyBub3Qgc3VwcG9ydCBVVEYtMTYgbm9yDQo+IFVURi04LiBUaGlzIGZ1bmN0aW9uIHdvcmtz
IG9ubHkgd2l0aCBVQ1MtMiBlbmNvZGluZyAobm90IGZ1bGwgVVRELTE2KQ0KPiBhbmQgY29udmVy
dHMgaW5wdXQgYnVmZmVyIHRvIE5MUyBlbmNvZGluZywgbm90IFVURi04LiBNb3Jlb3ZlciBrZXJu
ZWwncw0KPiBOTFMgQVBJIGRvZXMgbm90IHN1cHBvcnQgZnVsbCBVVEYtOCBhbmQgTkxTJ3MgVVRG
LTggZW5jb2RpbmcgaXMgc2VtaQ0KPiBicm9rZW4gYW5kIGxpbWl0ZWQgdG8ganVzdCAzLWJ5dGUg
c2VxdWVuY2VzLiBXaGljaCBtZWFucyBpdCBkb2VzIG5vdA0KPiBhbGxvdyB0byBhY2Nlc3MgYWxs
IFVOSUNPREUgZmlsZW5hbWVzLg0KPiANCj4gU28gcmVzdWx0IGlzIHRoYXQgY29tbWVudCBmb3Ig
dW5pX3RvX3g4IGZ1bmN0aW9uIGlzIGluY29ycmVjdC4NCj4gDQo+IEkgd291bGQgc3VnZ2VzdCB0
byBub3QgdXNlIE5MUyBBUEkgZm9yIGVuY29kaW5nIGZyb20vdG8gVVRGLTgsIGJ1dA0KPiByYXRo
ZXIgdXNlIHV0ZjE2c190b191dGY4cygpIGFuZCB1dGY4c190b191dGYxNnMoKSBmdW5jdGlvbnMu
DQo+IA0KPiBTZWUgZm9yIGV4YW1wbGUgaG93IGl0IGlzIGltcGxlbWVudGVkIGluIGV4ZmF0IGRy
aXZlcjoNCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQv
dG9ydmFsZHMvbGludXguZ2l0L3RyZWUvZnMvZXhmYXQvbmxzLmMNCj4gTG9vayBmb3IgZnVuY3Rp
b25zIGV4ZmF0X3V0ZjE2X3RvX25scygpIGFuZCBleGZhdF9ubHNfdG9fdXRmMTYoKS4NCj4gDQoN
CkhpIFBhbGkhIFRoYW5rIHlvdS4gSW4gVjMgd2UnbGwgcmV3cml0ZSB0aGlzIHBhcnQgYWxpa2Ug
dG8gaG93IGl0cyBkb25lIGluIGV4ZmF0LiBXZSBhbHNvIGZhY2VkIGFuIGlzc3VlIGluIG91ciBl
bmNvZGluZ3Mgc3VwcG9ydCB0ZXN0cyBvbmNlIG1vdmVkIHRvIHV0ZjhzX3RvX3V0ZjE2cygpLiBI
YWQgdG8gY29weSB0aGUgdXRmOHNfdG9fdXRmMTZzKCkgaW1wbGVtZW50YXRpb24gZnJvbSB0aGUg
a2VybmVsIGludG8gb3VyIGNvZGUsIGZpeCB0aGUgaXNzdWVzIGZvciB0aGUgcHJvYmxlbSBwYXJ0
IChhbHNvLCBmaXhlZCBudW1lcm91cyBzcGFyc2Ugd2FybmluZ3MgZm9yIHRoYXQgY29kZSkgYW5k
IHVzZSB0aGUgbW9kaWZpZWQgdmVyc2lvbi4gQ291bGQgeW91IHBsZWFzZSB0YWtlIGEgbG9vayB0
aGVyZSBpbiBWMyBvbmNlIHBvc3RlZCwgYW5kIHNoYXJlIHRoZSBmZWVkYmFjayBvbiBkbyB0aGVz
ZSBjaGFuZ2VzIHRvIHV0ZjhzX3RvX3V0ZjE2cygpIHdvcnRoIHRvIGJlIHByZXBhcmVkIHNlcGFy
YXRlbHkgYXMgdGhlIHBhdGNoIHRvIGFkYXB0IGluIGtlcm5lbD8NCg0KPiBJZGVhbGx5IGNoZWNr
IGlmIHlvdSBjYW4gc3RvcmUgY2hhcmFjdGVyIPCfkqkgKFBpbGUgb2YgUG9vLCBVKzFGNEE5LCBk
b2VzDQo+IG5vdCBmaXQgaW50byAzYnl0ZSBVVEYtOCBzZXF1ZW5jZSkgaW50byBmaWxlbmFtZSBh
bmQgaWYgdGhlcmUgaXMgY29ycmVjdA0KPiBpbnRlcm9wZXJhYmlsaXR5IGJldHdlZW4gV2luZG93
cyBhbmQgdGhpcyBuZXcgbnRmczMgaW1wbGVtZW50YXRpb24uDQo+IA0KDQpUaGlzIGlzIGdyZWF0
IHRlc3QgY2FzZS4gV2UgYXJlIHBsYWNpbmcgaXQgaW50byBvdXIgc2V0IG9mIGNvbXBhdGliaWxp
dHkgdGVzdHMuDQoNCg==
