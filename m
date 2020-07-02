Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127E6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBDBC2088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ebeCUJBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbgGBN0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:26:05 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:6530 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729257AbgGBN0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 09:26:02 -0400
X-UUID: 16f36d4dca634598a9d7327811550bca-20200702
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=eBTJcCYdyu4P7SpqfiES4jVryEeGPF+hpxQ4vbDiblk=;
        b=ebeCUJByPXUHpVEyQYy6YNtLe5UC86pOz6pMNkJq/j4XRrnf9M0iWf7R6abpywx5l7zn8/f2UwviCTicfXSRGVFDSqzcA+Ig2cXKpDw5R+igxEI+aQxuNQPhwePPcE0yRKuh9bYVYUXXoCEhGQGA04arEngxbkTf2O2CaBgi8Qs=;
X-UUID: 16f36d4dca634598a9d7327811550bca-20200702
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <frankie.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1849546426; Thu, 02 Jul 2020 21:25:59 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 2 Jul 2020 21:25:54 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Jul 2020 21:25:56 +0800
Message-ID: <1593696357.5899.3.camel@mtkswgap22>
Subject: Re: [PATCH v5] binder: transaction latency tracking for user build
From:   Frankie Chang <Frankie.Chang@mediatek.com>
To:     Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Date:   Thu, 2 Jul 2020 21:25:57 +0800
In-Reply-To: <1591791827-23871-1-git-send-email-Frankie.Chang@mediatek.com>
References: <20200507085544.GB1097552@kroah.com>
         <1591791827-23871-1-git-send-email-Frankie.Chang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 3BBB8660D72F636611F30F1FF60E1224D241F7EABAAF37F1121E045B93560BF32000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywgVG9kZCBhbmQgYWxsDQoNCkdlbnRsZSByZW1pbmQgb2YgdGhpcyBwYXRjaCBzZXQN
Cg0KVGhhbmtzLg0KRnJhbmtpZQ0KDQpPbiBXZWQsIDIwMjAtMDYtMTAgYXQgMjA6MjMgKzA4MDAs
IEZyYW5raWUgQ2hhbmcgd3JvdGU6DQo+IEZyYW5raWUuQ2hhbmcgKDMpOg0KPiAgIGJpbmRlcjog
bW92ZSBzdHJ1Y3RzIGZyb20gY29yZSBmaWxlIHRvIGhlYWRlciBmaWxlDQo+ICAgYmluZGVyOiBh
ZGQgdHJhY2UgYXQgZnJlZSB0cmFuc2FjdGlvbi4NCj4gICBiaW5kZXI6IGFkZCB0cmFuc2FjdGlv
biBsYXRlbmN5IHRyYWNlcg0KPiANCj4gIGRyaXZlcnMvYW5kcm9pZC9LY29uZmlnICAgICAgICAg
ICAgICAgICB8ICAgOCArDQo+ICBkcml2ZXJzL2FuZHJvaWQvTWFrZWZpbGUgICAgICAgICAgICAg
ICAgfCAgIDEgKw0KPiAgZHJpdmVycy9hbmRyb2lkL2JpbmRlci5jICAgICAgICAgICAgICAgIHwg
NDA4ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICBkcml2ZXJzL2FuZHJvaWQvYmluZGVyX2lu
dGVybmFsLmggICAgICAgfCA0MTYgKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICBkcml2ZXJz
L2FuZHJvaWQvYmluZGVyX2xhdGVuY3lfdHJhY2VyLmMgfCAxMDggKysrKysrDQo+ICBkcml2ZXJz
L2FuZHJvaWQvYmluZGVyX3RyYWNlLmggICAgICAgICAgfCAgNDkgKysrDQo+ICA2IGZpbGVzIGNo
YW5nZWQsIDU4NiBpbnNlcnRpb25zKCspLCA0MDQgZGVsZXRpb25zKC0pICBjcmVhdGUgbW9kZSAx
MDA2NDQgZHJpdmVycy9hbmRyb2lkL2JpbmRlcl9sYXRlbmN5X3RyYWNlci5jDQo+IA0KPiBDaGFu
Z2UgZnJvbSB2NToNCj4gICAtIGNoYW5nZSBjb25maWcgbmFtZSB0byB0aGUgcHJvcGVyIG9uZSwg
Q09ORklHX0JJTkRFUl9UUkFOU0FDVElPTl9MQVRFTkNZX1RSQUNLSU5HLg0KPiAgIC0gY2hhbmdl
IHRyYWNlcG9pbnQgbmFtZSB0byBtb3JlIGRlc2NyaXB0aXZlIG9uZSwgdHJhY2VfYmluZGVyX3R4
bl9sYXRlbmN5XyhhbGxvY3xpbmZvfGZyZWUpDQo+ICAgLSBlbmhhbmNlIHNvbWUgbG9jayBwcm90
ZWN0aW9uLg0KPiANCj4gQ2hhbmdlIGZyb20gdjQ6DQo+ICAgLSBzcGxpdCB1cCBpbnRvIHBhdGNo
IHNlcmllcy4NCj4gDQo+IENoYW5nZSBmcm9tIHYzOg0KPiAgIC0gdXNlIHRyYWNlcG9pbnRzIGZv
ciBiaW5kZXJfdXBkYXRlX2luZm8gYW5kIHByaW50X2JpbmRlcl90cmFuc2FjdGlvbl9leHQsDQo+
ICAgICBpbnN0ZWFkIG9mIGN1c3RvbSByZWdpc3RyYXRpb24gZnVuY3Rpb25zLg0KPiANCj4gQ2hh
bmdlIGZyb20gdjI6DQo+ICAgLSBjcmVhdGUgdHJhbnNhY3Rpb24gbGF0ZW5jeSBtb2R1bGUgdG8g
bW9uaXRvciBzbG93IHRyYW5zYWN0aW9uLg0KPiANCj4gQ2hhbmdlIGZyb20gdjE6DQo+ICAgLSBm
aXJzdCBwYXRjaHNldC4NCg0K

