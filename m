Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958FDC38A2A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 00:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 690F8207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 00:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Verisilicon.com header.i=@Verisilicon.com header.b="WTNna0XF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbgEKA6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 20:58:10 -0400
Received: from shasxm05.verisilicon.com ([101.89.135.45]:34365 "EHLO
        shasxm03.verisilicon.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729095AbgEKA6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 20:58:10 -0400
X-Greylist: delayed 326 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 May 2020 20:58:08 EDT
Content-Language: zh-CN
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; d=Verisilicon.com; s=default;
        c=simple/simple; t=1589158355; h=from:subject:to:date:message-id;
        bh=jQqN0tjyATSElgUnkv/SM87yAJ8KjjGobbNsJuAYA1M=;
        b=WTNna0XFC0LdImFoiUVplZnwAylA+A3rIK7dG9U4iwlrZigVGXuVpCi5QUIQY3GZvcZDRT/vLfW
        mntPW8Ur67reWI30P8K/naPjRAE3c0zb2es+JOC6x/2cov9CFK2K9o3yqmJTJNjJECJAK0mcqg8qm
        hiUr2yXPTVX7+yn9RMg=
Received: from SHASXM03.verisilicon.com ([fe80::938:4dda:a2f9:38aa]) by
 SHASXM06.verisilicon.com ([fe80::59a8:ce34:dc14:ddda%16]) with mapi id
 14.03.0123.003; Mon, 11 May 2020 08:52:34 +0800
From:   "Zhu, Joe" <Chunguang.Zhu@verisilicon.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIDEvMV0gZmlybXdhcmU6IGFybV9zY21pL21haWxib3g6?=
 =?gb2312?Q?_ignore_notification_for_tx_done_using_irq?=
Thread-Topic: [PATCH 1/1] firmware: arm_scmi/mailbox: ignore notification
 for tx done using irq
Thread-Index: AQHWJeM9tKTwOheOeEevYOsDCJbD8aifWMGAgAK3P4A=
Date:   Mon, 11 May 2020 00:52:33 +0000
Message-ID: <5564B50DC8FF8945812290C7B168B6C770141CDF@SHASXM03.verisilicon.com>
References: <20200509085457.31920-1-joe_zhuchg@126.com>
 <20200509152007.GA18877@bogus>
In-Reply-To: <20200509152007.GA18877@bogus>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.3.87]
x-tm-as-product-ver: SMEX-11.0.0.4179-8.100.1062-25412.001
x-tm-as-result: No--8.899200-0.000000-31
x-tm-as-user-approved-sender: Yes
x-tm-as-user-blocked-sender: No
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3VkZWVwLA0KICAgIFllcywgbWFpbGJveCBjbGllbnQgZG9lcyBub3QgbmVlZCB0byBrbm93
IGhvdyBjb250cm9sbGVyIGltcGxlbWVudGVkLiBJIHdpbGwgY2hlY2sgd2l0aCBtYWlsYm94IGRy
aXZlci4gVGhhbmtzIQ0KDQoNClJlZ2FyZHMsDQpKb2UNCg0KDQotLS0tLdPKvP7Urbz+LS0tLS0N
CreivP7IyzogU3VkZWVwIEhvbGxhIFttYWlsdG86c3VkZWVwLmhvbGxhQGFybS5jb21dIA0Kt6LL
zcqxvOQ6IDIwMjDE6jXUwjnI1SAyMzoyMA0KytW8/sjLOiBqb2Vfemh1Y2hnQDEyNi5jb20NCrOt
y806IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgU3VkZWVwIEhvbGxhOyBaaHUsIEpvZQ0K1vfM4jogUmU6IFtQQVRDSCAx
LzFdIGZpcm13YXJlOiBhcm1fc2NtaS9tYWlsYm94OiBpZ25vcmUgbm90aWZpY2F0aW9uIGZvciB0
eCBkb25lIHVzaW5nIGlycQ0KDQpPbiBTYXQsIE1heSAwOSwgMjAyMCBhdCAwNDo1NDo1N1BNICsw
ODAwLCBqb2Vfemh1Y2hnQDEyNi5jb20gd3JvdGU6DQo+IEZyb206IEpvZSBaaHUgPENodW5ndWFu
Zy5aaHVAdmVyaXNpbGljb24uY29tPg0KPiANCj4gSWYgbWFpbGJveCB1c2VzIElSUSBtZXRob2Qs
IGl0IGFscmVhZHkgbm90aWZpZWQgZnJhbWV3b3JrIHdpdGgNCj4gbWJveF9jaGFuX3R4ZG9uZSgp
IGluIElTUi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvZSBaaHUgPENodW5ndWFuZy5aaHVAdmVy
aXNpbGljb24uY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZmlybXdhcmUvYXJtX3NjbWkvbWFpbGJv
eC5jIHwgNCArKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS9hcm1fc2NtaS9tYWls
Ym94LmMgYi9kcml2ZXJzL2Zpcm13YXJlL2FybV9zY21pL21haWxib3guYw0KPiBpbmRleCA3MzA3
N2JiYzRhZDkuLjMwM2E1ZGM0MjQyOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9maXJtd2FyZS9h
cm1fc2NtaS9tYWlsYm94LmMNCj4gKysrIGIvZHJpdmVycy9maXJtd2FyZS9hcm1fc2NtaS9tYWls
Ym94LmMNCj4gQEAgLTksNiArOSw3IEBADQo+ICAjaW5jbHVkZSA8bGludXgvZXJyLmg+DQo+ICAj
aW5jbHVkZSA8bGludXgvZGV2aWNlLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvbWFpbGJveF9jbGll
bnQuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9tYWlsYm94X2NvbnRyb2xsZXIuaD4NCg0KVGhpcyBp
cyBhbiBpbmRpY2F0aW9uIHRoYXQgc29tZXRoaW5nIGlzIHdyb25nLiBUaGUgbWFpbGJveCBjb250
cm9sbGVyDQphbmQgY2xpZW50IGludGVyZmFjZXMgYXJlIHZlcnkgY2xlYXIuIFlvdSBuZWVkIHRv
IHVzZSBtYWlsYm94IGNvbnRyb2xsZXINCmludGVyZmFjZSB3aGVuIGltcGxlbWVudGluZyBhIG1h
aWxib3ggY29udHJvbGxlciBhbmQgdXNlIG9ubHkgY2xpZW50DQppbnRlcmZhY2Ugd2hlbiBpbXBs
ZW1lbnRpbmcgYSBtYWlsYm94IGNsaWVudC4NCg0KPiAgI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+
ICAjaW5jbHVkZSA8bGludXgvb2ZfYWRkcmVzcy5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3NsYWIu
aD4NCj4gQEAgLTE0Nyw3ICsxNDgsOCBAQCBzdGF0aWMgdm9pZCBtYWlsYm94X21hcmtfdHhkb25l
KHN0cnVjdCBzY21pX2NoYW5faW5mbyAqY2luZm8sIGludCByZXQpDQo+ICAJICogVW5mb3J0dW5h
dGVseSwgd2UgaGF2ZSB0byBraWNrIHRoZSBtYWlsYm94IGZyYW1ld29yayBhZnRlciB3ZSBoYXZl
DQo+ICAJICogcmVjZWl2ZWQgb3VyIG1lc3NhZ2UuDQo+ICAJICovDQo+IC0JbWJveF9jbGllbnRf
dHhkb25lKHNtYm94LT5jaGFuLCByZXQpOw0KPiArCWlmICghc21ib3gtPmNoYW4tPm1ib3gtPnR4
ZG9uZV9pcnEpDQo+ICsJCW1ib3hfY2xpZW50X3R4ZG9uZShzbWJveC0+Y2hhbiwgcmV0KTsNCg0K
SWYgdGhpcyBwYXRjaCBpcyB0byBhdm9pZCBnZXR0aW5nICJDbGllbnQgY2FuJ3QgcnVuIHRoZSBU
WCB0aWNrZXIiIGVycm9yDQptZXNzYWdlcywgdGhlbiB5b3UgbWFrZSBuZWVkIHRvIGZpeCB0aGF0
IHdpdGggc29tZXRoaW5nIGxpa2UgYmVsb3c6DQoNClJlZ2FyZHMsDQpTdWRlZXANCg0KLS0+OA0K
ZGlmZiAtLWdpdCBpL2RyaXZlcnMvbWFpbGJveC9tYWlsYm94LmMgdy9kcml2ZXJzL21haWxib3gv
bWFpbGJveC5jDQppbmRleCAwYjgyMWE1YjJkYjguLjVhNzhhMGFkY2NlNCAxMDA2NDQNCi0tLSBp
L2RyaXZlcnMvbWFpbGJveC9tYWlsYm94LmMNCisrKyB3L2RyaXZlcnMvbWFpbGJveC9tYWlsYm94
LmMNCkBAIC0xODksNyArMTg5LDkgQEAgRVhQT1JUX1NZTUJPTF9HUEwobWJveF9jaGFuX3R4ZG9u
ZSk7DQogdm9pZCBtYm94X2NsaWVudF90eGRvbmUoc3RydWN0IG1ib3hfY2hhbiAqY2hhbiwgaW50
IHIpDQogew0KICAgICAgICBpZiAodW5saWtlbHkoIShjaGFuLT50eGRvbmVfbWV0aG9kICYgVFhE
T05FX0JZX0FDSykpKSB7DQotICAgICAgICAgICAgICAgZGV2X2VycihjaGFuLT5tYm94LT5kZXYs
ICJDbGllbnQgY2FuJ3QgcnVuIHRoZSBUWCB0aWNrZXJcbiIpOw0KKyAgICAgICAgICAgICAgIGlm
ICh1bmxpa2VseSghKGNoYW4tPnR4ZG9uZV9tZXRob2QgJiBUWERPTkVfQllfSVJRKSkpDQorICAg
ICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKGNoYW4tPm1ib3gtPmRldiwNCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIkNsaWVudCBjYW4ndCBydW4gdGhlIFRYIHRpY2tlclxuIik7
DQogICAgICAgICAgICAgICAgcmV0dXJuOw0KICAgICAgICB9DQoNCg==
