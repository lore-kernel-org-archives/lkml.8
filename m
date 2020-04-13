Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C2AC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 06:24:41 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B533C206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 06:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JVOAUo8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B533C206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbgDMGYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 02:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbgDMGYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 02:24:37 -0400
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05519C0A3BE0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 23:24:37 -0700 (PDT)
X-UUID: 1ed2a9832fbc4cb880216c21a28074ed-20200413
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=34rlSUxTMlshzDSRi/mw46IKNke5K9TPavLiM4hQcoE=;
        b=JVOAUo8h8/FGkBRkAzwXOnzJHahn464WVDFq8E85uRE3/zFvBh/tbghCsH59qjfsh74V1iWJamIZ5NA9ABS8kSIkWkGq9llzUqi86cm2R4+0RYfL7d3hltJnTR4hHSjT5b3pCX/PPHWwDJJyKtGOedwAqI8y1xB2Vr3/4MXZVUg=;
X-UUID: 1ed2a9832fbc4cb880216c21a28074ed-20200413
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <frankie.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1615589860; Mon, 13 Apr 2020 14:24:33 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 13 Apr 2020 14:24:31 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 13 Apr 2020 14:24:30 +0800
Message-ID: <1586759071.9539.15.camel@mtkswgap22>
Subject: Re: [PATCH v1 1/1] binder: transaction latency tracking for user
 build
From:   Frankie Chang <Frankie.Chang@mediatek.com>
To:     Joel Fernandes <joel@joelfernandes.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        "Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?=" <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        <Jian-Min.Liu@mediatek.com>
Date:   Mon, 13 Apr 2020 14:24:31 +0800
In-Reply-To: <20200207132635.GB121785@google.com>
References: <1580885572-14272-1-git-send-email-Frankie.Chang@mediatek.com>
         <20200205093612.GA1167956@kroah.com> <20200205154943.GE142103@google.com>
         <1581045023.22229.46.camel@mtkswgap22> <20200207031759.GA121785@google.com>
         <1581056939.22229.55.camel@mtkswgap22> <20200207132635.GB121785@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: F139ADF625BA0CD6E58403A292981815779C4F37ACFDC969602B864F5B31798B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTAyLTA3IGF0IDA4OjI2IC0wNTAwLCBKb2VsIEZlcm5hbmRlcyB3cm90ZToN
Cj4gT24gRnJpLCBGZWIgMDcsIDIwMjAgYXQgMDI6Mjg6NTlQTSArMDgwMCwgRnJhbmtpZSBDaGFu
ZyB3cm90ZToNCj4gPiBPbiBUaHUsIDIwMjAtMDItMDYgYXQgMjI6MTcgLTA1MDAsIEpvZWwgRmVy
bmFuZGVzIHdyb3RlOg0KPiA+ID4gT24gRnJpLCBGZWIgMDcsIDIwMjAgYXQgMTE6MTA6MjNBTSAr
MDgwMCwgRnJhbmtpZSBDaGFuZyB3cm90ZToNCj4gPiA+ID4gT24gV2VkLCAyMDIwLTAyLTA1IGF0
IDEwOjQ5IC0wNTAwLCBKb2VsIEZlcm5hbmRlcyB3cm90ZToNCj4gPiA+ID4gPiBPbiBXZWQsIEZl
YiAwNSwgMjAyMCBhdCAwOTozNjoxMkFNICswMDAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3JvdGU6
DQo+ID4gPiA+ID4gPiBPbiBXZWQsIEZlYiAwNSwgMjAyMCBhdCAwMjo1Mjo1MlBNICswODAwLCBG
cmFua2llIENoYW5nIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBSZWNvcmQgc3RhcnQvZW5kIHRpbWVz
dGFtcCB0byBiaW5kZXIgdHJhbnNhY3Rpb24uDQo+ID4gPiA+ID4gPiA+IFdoZW4gdHJhbnNhY3Rp
b24gaXMgY29tcGxldGVkIG9yIHRyYW5zYWN0aW9uIGlzIGZyZWUsDQo+ID4gPiA+ID4gPiA+IGl0
IHdvdWxkIGJlIGNoZWNrZWQgaWYgdHJhbnNhY3Rpb24gbGF0ZW5jeSBvdmVyIHRocmVzaG9sZCAo
MiBzZWMpLA0KPiA+ID4gPiA+ID4gPiBpZiB5ZXMsIHByaW50aW5nIHJlbGF0ZWQgaW5mb3JtYXRp
b24gZm9yIHRyYWNpbmcuDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBGcmFua2llIENoYW5nIDxGcmFua2llLkNoYW5nQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4g
PiA+ID4gLS0tDQo+ID4gPiA+ID4gPiA+ICBkcml2ZXJzL2FuZHJvaWQvS2NvbmZpZyAgICAgICAg
ICAgfCAgICA4ICsrKw0KPiA+ID4gPiA+ID4gPiAgZHJpdmVycy9hbmRyb2lkL2JpbmRlci5jICAg
ICAgICAgIHwgIDEwNyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4g
PiA+ID4gPiA+ICBkcml2ZXJzL2FuZHJvaWQvYmluZGVyX2ludGVybmFsLmggfCAgICA0ICsrDQo+
ID4gPiA+ID4gPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDExOSBpbnNlcnRpb25zKCspDQo+ID4gPiA+
ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hbmRyb2lkL0tjb25m
aWcgYi9kcml2ZXJzL2FuZHJvaWQvS2NvbmZpZw0KPiA+ID4gPiA+ID4gPiBpbmRleCA2ZmRmMmFi
Li43YmE4MGViIDEwMDY0NA0KPiA+ID4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2FuZHJvaWQvS2Nv
bmZpZw0KPiA+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL2FuZHJvaWQvS2NvbmZpZw0KPiA+ID4g
PiA+ID4gPiBAQCAtNTQsNiArNTQsMTQgQEAgY29uZmlnIEFORFJPSURfQklOREVSX0lQQ19TRUxG
VEVTVA0KPiA+ID4gPiA+ID4gPiAgCSAgZXhoYXVzdGl2ZWx5IHdpdGggY29tYmluYXRpb25zIG9m
IHZhcmlvdXMgYnVmZmVyIHNpemVzIGFuZA0KPiA+ID4gPiA+ID4gPiAgCSAgYWxpZ25tZW50cy4N
Cj4gPiA+ID4gPiA+ID4gIA0KPiA+ID4gPiA+ID4gPiArY29uZmlnIEJJTkRFUl9VU0VSX1RSQUNL
SU5HDQo+ID4gPiA+ID4gPiA+ICsJYm9vbCAiQW5kcm9pZCBCaW5kZXIgdHJhbnNhY3Rpb24gdHJh
Y2tpbmciDQo+ID4gPiA+ID4gPiA+ICsJaGVscA0KPiA+ID4gPiA+ID4gPiArCSAgVXNlZCBmb3Ig
dHJhY2sgYWJub3JtYWwgYmluZGVyIHRyYW5zYWN0aW9uIHdoaWNoIGlzIG92ZXIgMiBzZWNvbmRz
LA0KPiA+ID4gPiA+ID4gPiArCSAgd2hlbiB0aGUgdHJhbnNhY3Rpb24gaXMgZG9uZSBvciBiZSBm
cmVlLCB0aGlzIHRyYW5zYWN0aW9uIHdvdWxkIGJlDQo+ID4gPiA+ID4gPiA+ICsJICBjaGVja2Vk
IHdoZXRoZXIgaXQgZXhlY3V0ZWQgb3ZlcnRpbWUuDQo+ID4gPiA+ID4gPiA+ICsJICBJZiB5ZXMs
IHByaW50aW5nIG91dCB0aGUgZGV0YWlsIGluZm8gYWJvdXQgaXQuDQo+ID4gPiA+ID4gPiA+ICsN
Cj4gPiA+ID4gPiA+ID4gIGVuZGlmICMgaWYgQU5EUk9JRA0KPiA+ID4gPiA+ID4gPiAgDQo+ID4g
PiA+ID4gPiA+ICBlbmRtZW51DQo+ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Fu
ZHJvaWQvYmluZGVyLmMgYi9kcml2ZXJzL2FuZHJvaWQvYmluZGVyLmMNCj4gPiA+ID4gPiA+ID4g
aW5kZXggZTliYzlmYy4uNWEzNTJlZSAxMDA2NDQNCj4gPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVy
cy9hbmRyb2lkL2JpbmRlci5jDQo+ID4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvYW5kcm9pZC9i
aW5kZXIuYw0KPiA+ID4gPiA+ID4gPiBAQCAtNzYsNiArNzYsMTEgQEANCj4gPiA+ID4gPiA+ID4g
ICNpbmNsdWRlICJiaW5kZXJfaW50ZXJuYWwuaCINCj4gPiA+ID4gPiA+ID4gICNpbmNsdWRlICJi
aW5kZXJfdHJhY2UuaCINCj4gPiA+ID4gPiA+ID4gIA0KPiA+ID4gPiA+ID4gPiArI2lmZGVmIENP
TkZJR19CSU5ERVJfVVNFUl9UUkFDS0lORw0KPiA+ID4gPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4
L3J0Yy5oPg0KPiA+ID4gPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4L3RpbWUuaD4NCj4gPiA+ID4g
PiA+ID4gKyNlbmRpZg0KPiA+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiA+ICBzdGF0aWMgSExJ
U1RfSEVBRChiaW5kZXJfZGVmZXJyZWRfbGlzdCk7DQo+ID4gPiA+ID4gPiA+ICBzdGF0aWMgREVG
SU5FX01VVEVYKGJpbmRlcl9kZWZlcnJlZF9sb2NrKTsNCj4gPiA+ID4gPiA+ID4gIA0KPiA+ID4g
PiA+ID4gPiBAQCAtNTkxLDggKzU5NiwxMDQgQEAgc3RydWN0IGJpbmRlcl90cmFuc2FjdGlvbiB7
DQo+ID4gPiA+ID4gPiA+ICAJICogZHVyaW5nIHRocmVhZCB0ZWFyZG93bg0KPiA+ID4gPiA+ID4g
PiAgCSAqLw0KPiA+ID4gPiA+ID4gPiAgCXNwaW5sb2NrX3QgbG9jazsNCj4gPiA+ID4gPiA+ID4g
KyNpZmRlZiBDT05GSUdfQklOREVSX1VTRVJfVFJBQ0tJTkcNCj4gPiA+ID4gPiA+ID4gKwlzdHJ1
Y3QgdGltZXNwZWMgdGltZXN0YW1wOw0KPiA+ID4gPiA+ID4gPiArCXN0cnVjdCB0aW1ldmFsIHR2
Ow0KPiA+ID4gPiA+ID4gPiArI2VuZGlmDQo+ID4gPiA+ID4gPiA+ICB9Ow0KPiA+ID4gPiA+ID4g
PiAgDQo+ID4gPiA+ID4gPiA+ICsjaWZkZWYgQ09ORklHX0JJTkRFUl9VU0VSX1RSQUNLSU5HDQo+
ID4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ID4gKy8qDQo+ID4gPiA+ID4gPiA+ICsgKiBiaW5k
ZXJfcHJpbnRfZGVsYXkgLSBPdXRwdXQgaW5mbyBvZiBhIGRlbGF5IHRyYW5zYWN0aW9uDQo+ID4g
PiA+ID4gPiA+ICsgKiBAdDogICAgICAgICAgcG9pbnRlciB0byB0aGUgb3Zlci10aW1lIHRyYW5z
YWN0aW9uDQo+ID4gPiA+ID4gPiA+ICsgKi8NCj4gPiA+ID4gPiA+ID4gK3N0YXRpYyB2b2lkIGJp
bmRlcl9wcmludF9kZWxheShzdHJ1Y3QgYmluZGVyX3RyYW5zYWN0aW9uICp0KQ0KPiA+ID4gPiA+
ID4gPiArew0KPiA+ID4gPiA+ID4gPiArCXN0cnVjdCBydGNfdGltZSB0bTsNCj4gPiA+ID4gPiA+
ID4gKwlzdHJ1Y3QgdGltZXNwZWMgKnN0YXJ0aW1lOw0KPiA+ID4gPiA+ID4gPiArCXN0cnVjdCB0
aW1lc3BlYyBjdXIsIHN1Yl90Ow0KPiA+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiA+ICsJa3Rp
bWVfZ2V0X3RzKCZjdXIpOw0KPiA+ID4gPiA+ID4gPiArCXN0YXJ0aW1lID0gJnQtPnRpbWVzdGFt
cDsNCj4gPiA+ID4gPiA+ID4gKwlzdWJfdCA9IHRpbWVzcGVjX3N1YihjdXIsICpzdGFydGltZSk7
DQo+ID4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ID4gKwkvKiBpZiB0cmFuc2FjdGlvbiB0aW1l
IGlzIG92ZXIgdGhhbiAyIHNlYywNCj4gPiA+ID4gPiA+ID4gKwkgKiBzaG93IHRpbWVvdXQgd2Fy
bmluZyBsb2cuDQo+ID4gPiA+ID4gPiA+ICsJICovDQo+ID4gPiA+ID4gPiA+ICsJaWYgKHN1Yl90
LnR2X3NlYyA8IDIpDQo+ID4gPiA+ID4gPiA+ICsJCXJldHVybjsNCj4gPiA+ID4gPiA+ID4gKw0K
PiA+ID4gPiA+ID4gPiArCXJ0Y190aW1lX3RvX3RtKHQtPnR2LnR2X3NlYywgJnRtKTsNCj4gPiA+
ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gPiArCXNwaW5fbG9jaygmdC0+bG9jayk7DQo+ID4gPiA+
ID4gPiA+ICsJcHJfaW5mb19yYXRlbGltaXRlZCgiJWQ6IGZyb20gJWQ6JWQgdG8gJWQ6JWQiLA0K
PiA+ID4gPiA+ID4gPiArCQkJICAgIHQtPmRlYnVnX2lkLA0KPiA+ID4gPiA+ID4gPiArCQkJICAg
IHQtPmZyb20gPyB0LT5mcm9tLT5wcm9jLT5waWQgOiAwLA0KPiA+ID4gPiA+ID4gPiArCQkJICAg
IHQtPmZyb20gPyB0LT5mcm9tLT5waWQgOiAwLA0KPiA+ID4gPiA+ID4gPiArCQkJICAgIHQtPnRv
X3Byb2MgPyB0LT50b19wcm9jLT5waWQgOiAwLA0KPiA+ID4gPiA+ID4gPiArCQkJICAgIHQtPnRv
X3RocmVhZCA/IHQtPnRvX3RocmVhZC0+cGlkIDogMCk7DQo+ID4gPiA+ID4gPiA+ICsJc3Bpbl91
bmxvY2soJnQtPmxvY2spOw0KPiA+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiA+ICsJcHJfaW5m
b19yYXRlbGltaXRlZCgiIHRvdGFsICV1LiUwM2xkIHMgY29kZSAldSBzdGFydCAlbHUuJTAzbGQg
YW5kcm9pZCAlZC0lMDJkLSUwMmQgJTAyZDolMDJkOiUwMmQuJTAzbHVcbiIsDQo+ID4gPiA+ID4g
PiA+ICsJCQkgICAgKHVuc2lnbmVkIGludClzdWJfdC50dl9zZWMsDQo+ID4gPiA+ID4gPiA+ICsJ
CQkgICAgKHN1Yl90LnR2X25zZWMgLyBOU0VDX1BFUl9NU0VDKSwNCj4gPiA+ID4gPiA+ID4gKwkJ
CSAgICB0LT5jb2RlLA0KPiA+ID4gPiA+ID4gPiArCQkJICAgICh1bnNpZ25lZCBsb25nKXN0YXJ0
aW1lLT50dl9zZWMsDQo+ID4gPiA+ID4gPiA+ICsJCQkgICAgKHN0YXJ0aW1lLT50dl9uc2VjIC8g
TlNFQ19QRVJfTVNFQyksDQo+ID4gPiA+ID4gPiA+ICsJCQkgICAgKHRtLnRtX3llYXIgKyAxOTAw
KSwgKHRtLnRtX21vbiArIDEpLCB0bS50bV9tZGF5LA0KPiA+ID4gPiA+ID4gPiArCQkJICAgIHRt
LnRtX2hvdXIsIHRtLnRtX21pbiwgdG0udG1fc2VjLA0KPiA+ID4gPiA+ID4gPiArCQkJICAgICh1
bnNpZ25lZCBsb25nKSh0LT50di50dl91c2VjIC8gVVNFQ19QRVJfTVNFQykpOw0KPiA+ID4gPiA+
ID4gPiArfQ0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBJY2ssIHdoeSBub3QgdXNlIGEgdHJh
Y2Vwb2ludCBmb3IgdGhpcyBpbnN0ZWFkPw0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBBbmQg
d2hhdCBpcyB1c2Vyc3BhY2Ugc3VwcG9zZWQgdG8gZG8gd2l0aCB0aGlzIGlmIHRoZXkgc2VlIGl0
Pw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IE9yIGFub3RoZXIgb3B0aW9uIGlzIHRvIGltcGxlbWVu
dCB0aGlzIHNlcGFyYXRlbHkgb3V0c2lkZSBvZiBiaW5kZXIuYyB1c2luZw0KPiA+ID4gPiA+IHJl
Z2lzdGVyX3RyYWNlXyogb24gdGhlIGV4aXN0aW5nIGJpbmRlciB0cmFjZXBvaW50cywgc2ltaWxh
ciB0byB3aGF0IHNheSB0aGUNCj4gPiA+ID4gPiBibG9jayB0cmFjZXIgb3IgcHJlZW1wdC1vZmYg
dHJhY2VycyBkby4gQ2FsbCBpdCwgc2F5LCAiYmluZGVyLWxhdGVuY3kgdHJhY2VyIi4NCj4gPiA+
ID4gPiANCj4gPiA+ID4gPiBUaGF0IHdheSBhbGwgb2YgdGhpcyB0cmFjaW5nIGNvZGUgaXMgaW4t
a2VybmVsIGJ1dCBvdXRzaWRlIG9mIGJpbmRlci5jLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IHRo
YW5rcywNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAgLSBKb2VsDQo+ID4gPiA+ID4gDQo+ID4gPiA+
IFRpbWUgbGltaXRhdGlvbiBvZiByZWNvcmRpbmcgaXMgdGhlIHJlYXNvbiB3aHkgd2UgZG9uJ3Qg
dXNlIHRyYWNlcG9pbnQuDQo+ID4gPiA+IEluIHNvbWUgc2l0dWF0aW9ucywgdGhlIGV4Y2VwdGlv
biBpcyBjYXVzZWQgYnkgYSBzZXJpZXMgb2YgdHJhbnNhY3Rpb25zDQo+ID4gPiA+IGludGVyYWN0
aW9uLg0KPiA+ID4gPiBTb21lIGFibm9ybWFsIHRyYW5zYWN0aW9ucyBtYXkgYmUgcGVuZGluZyBm
b3IgYSBsb25nIHRpbWUgYWdvLCB0aGV5DQo+ID4gPiA+IGNvdWxkIG5vdCBiZSByZWNvcmRlZCBk
dWUgdG8gYnVmZmVyIGxpbWl0ZWQuDQo+ID4gPiANCj4gPiA+IHJlZ2lzdGVyX3RyYWNlXyogZG9l
cyBub3QgdXNlIHRoZSB0cmFjZSBidWZmZXIgc28gSSBhbSBub3Qgc3VyZSB3aGF0IHlvdQ0KPiA+
ID4gbWVhbi4gSSBhbSBhc2tpbmcgeW91IHRvIHVzZSB0cmFjZXBvaW50cywgbm90IGZ0cmFjZSBl
dmVudHMuDQo+ID4gPiANCj4gPiA+IHRoYW5rcywNCj4gPiA+IA0KPiA+ID4gIC0gSm9lbA0KPiA+
ID4gDQo+ID4gVGhlIGV4aXN0aW5nIGJpbmRlciB0cmFjZXBvaW50IG1heSBub3QgYmUgcHJlY2lz
ZSBlbm91Z2ggYmVjYXVzZSB0aGVyZQ0KPiA+IGlzIG5vIHByb3BlciB0cmFjZXBvaW50IHdoaWNo
IGNhbiByZXByZXNlbnQgdGhlIHJlYWwgZmluaXNoZWQgdGltZSBvZg0KPiA+IHRyYW5zYWN0aW9u
Lg0KPiANCj4gTWF5IGJlIHlvdSBjYW4gYWRkIHN1Y2ggVFAgdGhlbj8NCj4gDQpZZXMsIHdlIHdp
bGwgYWRkIFRQIGF0IHRoZSByZWFsIGZpbmlzaGVkIHRpbWUgb2YgdHJhbnNhY3Rpb24uDQoNCj4g
PiBUaGUgcmVhc29uIHdoeSB3ZSBkb24ndCBwdXQgdGhlIGNvZGUgb3V0c2lkZSBiaW5kZXIuYyBp
cyB0aGF0IHN0cnVjdHVyZQ0KPiA+IG9mIGJpbmRlcl90cmFuc2FjdGlvbiBkaWRuJ3QgcHV0IGlu
IGhlYWRlciBmaWxlLg0KPiA+IElmIGl0IGNvdWxkIGJlIG1vdmVkIHRvIGJpbmRlcl9pbnRlcm5h
bC5oLCB0aGVuIHdlIGNhbiBhZGQNCj4gPiAiYmluZGVyLWxhdGVuY3kgdHJhY2VyIiBhcyB5b3Ug
bWVudGlvbmVkIGVhcmxpZXIuDQo+IA0KPiBUaGF0IHNob3VsZCBiZSBkb2FibGUuDQo+IA0KPiBU
aGUgcmVhc29uIEkgZG9uJ3QgbGlrZSBjdXN0b20gdHJhY2luZyBsb2dpYyBpbiBjb3JlIGZpbGVz
IGFzIHlvdXIgcGF0Y2ggaXMNCj4gZG9pbmcsIGlzIHRoYXQgaXQgaXMgZG91YnRmdWwgaWYgYSBs
b3Qgb2YgcGVvcGxlIHdvdWxkIHVzZSBpdCB0byB3YXJyYW50DQo+IGFkZGluZyBpbnRvIGEgY29y
ZSBmaWxlLiBJbiB0aGlzIGNhc2UsIHByb2JhYmx5IGEgc2VwYXJhdGUgdHJhY2VyIChvdXRzaWRl
IG9mDQo+IGJpbmRlci5jKSBpcyBhIGJldHRlciBvcHRpb24gc28gYXMgdG8gbm90IHBvbGx1dGUg
dGhlIGNvcmUgZmlsZXMuDQo+IA0KPiB0aGFua3MsDQo+IA0KPiAgLSBKb2VsDQo+IA0KVGhhbmtz
IGZvciB5b3VyIGFkdmljZSwgc2luY2VyZWx5Lg0KDQpXZSB3aWxsIG1vdmUgdHJhY2luZyBsb2dp
YyBvdXQgb2YgY29yZSBmaWxlcyBhbmQgaW1wbGVtZW50IGEgc2VwYXJhdGUNCmxhdGVuY3kgdHJh
Y2VyLiBBbmQgYWxzbyBtb3ZlIHNvbWUgc3RydWN0dXJlcyBuZWVkZWQgYnkgdHJhY2VyIG1vZHVs
ZQ0KZnJvbSBjb3JlIGZpbGUgdG8gaGVhZGVyIGZpbGUgKGJpbmRlcl9pbnRlcm5hbC5oKSBpbiBu
ZXh0IHZlcnNpb24uDQoNCk1hbnkgdGhhbmtzLA0KDQogLSBGcmFua2llDQoNCg==

