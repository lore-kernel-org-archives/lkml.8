Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F074FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 09:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C343B206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 09:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bR8KKaZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgHLJRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 05:17:45 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:57456 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726255AbgHLJRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 05:17:45 -0400
X-UUID: 25e573d41ef8423a8439bfebe68ac62f-20200812
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=UqdzDWD86OrCp6wEU2YB9Bwu97TCSXyPz6lXG6Qwo4U=;
        b=bR8KKaZIG/GiDAYXoffnL7verGe3koQ8uq1m2yOEm9mD7Yx4TB6p5N/7qMHK/YkYtZN3ytIYzdBUgad8kH5JPBl7INF1U4C7FsI/EZ17Sgyo31ELFABOWS4BOx3gozDO8orgV/vAWBdaA9Av0FpP2/G0AR7DXmzMG/Ihvsg9U80=;
X-UUID: 25e573d41ef8423a8439bfebe68ac62f-20200812
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1663623647; Wed, 12 Aug 2020 17:17:38 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 12 Aug 2020 17:17:29 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 12 Aug 2020 17:17:29 +0800
Message-ID: <1597223851.5467.12.camel@mtkswgap22>
Subject: Re: [PATCH] net: untag pointer in sockptr_is_kernel
From:   Miles Chen <miles.chen@mediatek.com>
To:     kernel test robot <lkp@intel.com>
CC:     Christoph Hellwig <hch@lst.de>,
        "David S . Miller" <davem@davemloft.net>,
        <kbuild-all@lists.01.org>, <clang-built-linux@googlegroups.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Wed, 12 Aug 2020 17:17:31 +0800
In-Reply-To: <202008112018.fpLyWmTj%lkp@intel.com>
References: <20200811102704.17875-1-miles.chen@mediatek.com>
         <202008112018.fpLyWmTj%lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA4LTExIGF0IDIwOjI4ICswODAwLCBrZXJuZWwgdGVzdCByb2JvdCB3cm90
ZToNCj4gSGkgTWlsZXMsDQo+IA0KPiBUaGFuayB5b3UgZm9yIHRoZSBwYXRjaCEgWWV0IHNvbWV0
aGluZyB0byBpbXByb3ZlOg0KPiANCj4gW2F1dG8gYnVpbGQgdGVzdCBFUlJPUiBvbiBuZXQtbmV4
dC9tYXN0ZXJdDQo+IFthbHNvIGJ1aWxkIHRlc3QgRVJST1Igb24gbGludXMvbWFzdGVyXQ0KPiBb
Y2Fubm90IGFwcGx5IHRvIG5ldC9tYXN0ZXIgaGNoLWNvbmZpZ2ZzL2Zvci1uZXh0IHNwYXJjLW5l
eHQvbWFzdGVyIHY1LjggbmV4dC0yMDIwMDgxMV0NCj4gW0lmIHlvdXIgcGF0Y2ggaXMgYXBwbGll
ZCB0byB0aGUgd3JvbmcgZ2l0IHRyZWUsIGtpbmRseSBkcm9wIHVzIGEgbm90ZS4NCj4gQW5kIHdo
ZW4gc3VibWl0dGluZyBwYXRjaCwgd2Ugc3VnZ2VzdCB0byB1c2UgJy0tYmFzZScgYXMgZG9jdW1l
bnRlZCBpbg0KPiBodHRwczovL2dpdC1zY20uY29tL2RvY3MvZ2l0LWZvcm1hdC1wYXRjaF0NCg0K
aGkgdGVzdCByb2JvdCwNCg0KdGhhbmtzIGZvciB0aGUgcmVwb3J0Lg0KDQo2ZDA0ZmUxNWY3OGEg
KCJuZXQ6IG9wdGltaXplIHRoZSBzb2NrcHRyX3QgZm9yIHVuaWZpZWQga2VybmVsL3VzZXINCmFk
ZHJlc3Mgc3BhY2VzIikgaGFzIGJlZW4gcmV2ZXJ0ZWQsIHNvIEkgd2lsbCBub3Qgc2VudCBwYXRj
aCB2MiBmb3IgdGhpcw0KYnVpbGQgZXJyb3IuDQoNCk1pbGVzDQoNCj4gdXJsOiAgICBodHRwczov
L2dpdGh1Yi5jb20vMGRheS1jaS9saW51eC9jb21taXRzL01pbGVzLUNoZW4vbmV0LXVudGFnLXBv
aW50ZXItaW4tc29ja3B0cl9pc19rZXJuZWwvMjAyMDA4MTEtMTgzMDMNCj4gYmFzZTogICBodHRw
czovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9kYXZlbS9uZXQtbmV4
dC5naXQgYmZkZDVhYWE1NGIwYTQ0ZDlkZjU1MGZlNGM5ZGI3ZTE0NzBhMTFiOA0KPiBjb25maWc6
IHg4Nl82NC1yYW5kY29uZmlnLWEwMTMtMjAyMDA4MTEgKGF0dGFjaGVkIGFzIC5jb25maWcpDQo+
IGNvbXBpbGVyOiBjbGFuZyB2ZXJzaW9uIDEyLjAuMCAoaHR0cHM6Ly9naXRodWIuY29tL2xsdm0v
bGx2bS1wcm9qZWN0IDRmMmFkMTVkYjUzNTg3M2RkYTliZmUyNDhhMjc3MTAyM2I2NGE0M2MpDQo+
IHJlcHJvZHVjZSAodGhpcyBpcyBhIFc9MSBidWlsZCk6DQo+ICAgICAgICAgd2dldCBodHRwczov
L3Jhdy5naXRodWJ1c2VyY29udGVudC5jb20vaW50ZWwvbGtwLXRlc3RzL21hc3Rlci9zYmluL21h
a2UuY3Jvc3MgLU8gfi9iaW4vbWFrZS5jcm9zcw0KPiAgICAgICAgIGNobW9kICt4IH4vYmluL21h
a2UuY3Jvc3MNCj4gICAgICAgICAjIGluc3RhbGwgeDg2XzY0IGNyb3NzIGNvbXBpbGluZyB0b29s
IGZvciBjbGFuZyBidWlsZA0KPiAgICAgICAgICMgYXB0LWdldCBpbnN0YWxsIGJpbnV0aWxzLXg4
Ni02NC1saW51eC1nbnUNCj4gICAgICAgICAjIHNhdmUgdGhlIGF0dGFjaGVkIC5jb25maWcgdG8g
bGludXggYnVpbGQgdHJlZQ0KPiAgICAgICAgIENPTVBJTEVSX0lOU1RBTExfUEFUSD0kSE9NRS8w
ZGF5IENPTVBJTEVSPWNsYW5nIG1ha2UuY3Jvc3MgQVJDSD14ODZfNjQgDQo+IA0KPiBJZiB5b3Ug
Zml4IHRoZSBpc3N1ZSwga2luZGx5IGFkZCBmb2xsb3dpbmcgdGFnIGFzIGFwcHJvcHJpYXRlDQo+
IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gDQo+IEFs
bCBlcnJvcnMgKG5ldyBvbmVzIHByZWZpeGVkIGJ5ID4+KToNCj4gDQo+ICAgIEluIGZpbGUgaW5j
bHVkZWQgZnJvbSBuZXQvaXB2Ni9hZl9pbmV0Ni5jOjI5Og0KPiAgICBJbiBmaWxlIGluY2x1ZGVk
IGZyb20gaW5jbHVkZS9saW51eC9uZXQuaDoyNDoNCj4gPj4gaW5jbHVkZS9saW51eC9zb2NrcHRy
Lmg6MjM6MjQ6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAndW50YWdn
ZWRfYWRkcicgWy1XZXJyb3IsLVdpbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0NCj4gICAg
ICAgICAgICByZXR1cm4gKHVuc2lnbmVkIGxvbmcpdW50YWdnZWRfYWRkcihzb2NrcHRyLmtlcm5l
bCkgPj0gVEFTS19TSVpFOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeDQo+
ICAgIDEgZXJyb3IgZ2VuZXJhdGVkLg0KPiAtLQ0KPiAgICBJbiBmaWxlIGluY2x1ZGVkIGZyb20g
bmV0L2lwdjYvdWRwLmM6MjQ6DQo+ICAgIEluIGZpbGUgaW5jbHVkZWQgZnJvbSBpbmNsdWRlL2xp
bnV4L25ldC5oOjI0Og0KPiA+PiBpbmNsdWRlL2xpbnV4L3NvY2twdHIuaDoyMzoyNDogZXJyb3I6
IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICd1bnRhZ2dlZF9hZGRyJyBbLVdlcnJv
ciwtV2ltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQ0KPiAgICAgICAgICAgIHJldHVybiAo
dW5zaWduZWQgbG9uZyl1bnRhZ2dlZF9hZGRyKHNvY2twdHIua2VybmVsKSA+PSBUQVNLX1NJWkU7
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4NCj4gICAgbmV0L2lwdjYvdWRw
LmM6MTAyOTozMDogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciBmdW5jdGlvbiAn
dWRwX3Y2X2Vhcmx5X2RlbXV4JyBbLVdtaXNzaW5nLXByb3RvdHlwZXNdDQo+ICAgIElORElSRUNU
X0NBTExBQkxFX1NDT1BFIHZvaWQgdWRwX3Y2X2Vhcmx5X2RlbXV4KHN0cnVjdCBza19idWZmICpz
a2IpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiAgICBuZXQvaXB2Ni91
ZHAuYzoxMDI5OjI1OiBub3RlOiBkZWNsYXJlICdzdGF0aWMnIGlmIHRoZSBmdW5jdGlvbiBpcyBu
b3QgaW50ZW5kZWQgdG8gYmUgdXNlZCBvdXRzaWRlIG9mIHRoaXMgdHJhbnNsYXRpb24gdW5pdA0K
PiAgICBJTkRJUkVDVF9DQUxMQUJMRV9TQ09QRSB2b2lkIHVkcF92Nl9lYXJseV9kZW11eChzdHJ1
Y3Qgc2tfYnVmZiAqc2tiKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICBeDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHN0YXRpYyANCj4gICAgbmV0L2lwdjYvdWRwLmM6MTA3MDoy
OTogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciBmdW5jdGlvbiAndWRwdjZfcmN2
JyBbLVdtaXNzaW5nLXByb3RvdHlwZXNdDQo+ICAgIElORElSRUNUX0NBTExBQkxFX1NDT1BFIGlu
dCB1ZHB2Nl9yY3Yoc3RydWN0IHNrX2J1ZmYgKnNrYikNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIF4NCj4gICAgbmV0L2lwdjYvdWRwLmM6MTA3MDoyNTogbm90ZTogZGVjbGFyZSAn
c3RhdGljJyBpZiB0aGUgZnVuY3Rpb24gaXMgbm90IGludGVuZGVkIHRvIGJlIHVzZWQgb3V0c2lk
ZSBvZiB0aGlzIHRyYW5zbGF0aW9uIHVuaXQNCj4gICAgSU5ESVJFQ1RfQ0FMTEFCTEVfU0NPUEUg
aW50IHVkcHY2X3JjdihzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBeDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0YXRpYyANCj4gICAgMiB3
YXJuaW5ncyBhbmQgMSBlcnJvciBnZW5lcmF0ZWQuDQo+IA0KPiB2aW0gKy91bnRhZ2dlZF9hZGRy
ICsyMyBpbmNsdWRlL2xpbnV4L3NvY2twdHIuaA0KPiANCj4gICAgIDIwCQ0KPiAgICAgMjEJc3Rh
dGljIGlubGluZSBib29sIHNvY2twdHJfaXNfa2VybmVsKHNvY2twdHJfdCBzb2NrcHRyKQ0KPiAg
ICAgMjIJew0KPiAgID4gMjMJCXJldHVybiAodW5zaWduZWQgbG9uZyl1bnRhZ2dlZF9hZGRyKHNv
Y2twdHIua2VybmVsKSA+PSBUQVNLX1NJWkU7DQo+ICAgICAyNAl9DQo+ICAgICAyNQkNCj4gDQo+
IC0tLQ0KPiAwLURBWSBDSSBLZXJuZWwgVGVzdCBTZXJ2aWNlLCBJbnRlbCBDb3Jwb3JhdGlvbg0K
PiBodHRwczovL2xpc3RzLjAxLm9yZy9oeXBlcmtpdHR5L2xpc3Qva2J1aWxkLWFsbEBsaXN0cy4w
MS5vcmcNCg0K

