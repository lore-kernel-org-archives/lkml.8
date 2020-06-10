Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33478C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 12:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAE6A20734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 12:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="I4wK+ZGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgFJMXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 08:23:55 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:64875 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728571AbgFJMXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 08:23:53 -0400
X-UUID: e647361f7ba84d05b22da8c38c58befb-20200610
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=y0+ea5iXlIKqU9Ug7NsEdYKcsxBs8n5iuhNmG0dnYwY=;
        b=I4wK+ZGm8EZ3imeXkdaiDZ+qha+BHuj/HRo1KKASZmyxDC4XO6bCDhKR1wH7fvWUSlNj3TvlqIGRhL5tdsKSCMj6ScvEtou/dDRAZ17paPyOuYb+TiUWXZYeV3BExE5slAUnNm+meiTaMG1/PtjRqK+sfJoCcEP+5buHDmkvoi0=;
X-UUID: e647361f7ba84d05b22da8c38c58befb-20200610
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <frankie.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2120119367; Wed, 10 Jun 2020 20:23:50 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 10 Jun 2020 20:23:47 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 10 Jun 2020 20:23:47 +0800
From:   Frankie Chang <Frankie.Chang@mediatek.com>
To:     Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Subject: [PATCH v5] binder: transaction latency tracking for user build
Date:   Wed, 10 Jun 2020 20:23:44 +0800
Message-ID: <1591791827-23871-1-git-send-email-Frankie.Chang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <20200507085544.GB1097552@kroah.com>
References: <20200507085544.GB1097552@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpGcmFua2llLkNoYW5nICgzKToNCiAgYmluZGVyOiBtb3ZlIHN0cnVjdHMgZnJvbSBjb3JlIGZp
bGUgdG8gaGVhZGVyIGZpbGUNCiAgYmluZGVyOiBhZGQgdHJhY2UgYXQgZnJlZSB0cmFuc2FjdGlv
bi4NCiAgYmluZGVyOiBhZGQgdHJhbnNhY3Rpb24gbGF0ZW5jeSB0cmFjZXINCg0KIGRyaXZlcnMv
YW5kcm9pZC9LY29uZmlnICAgICAgICAgICAgICAgICB8ICAgOCArDQogZHJpdmVycy9hbmRyb2lk
L01ha2VmaWxlICAgICAgICAgICAgICAgIHwgICAxICsNCiBkcml2ZXJzL2FuZHJvaWQvYmluZGVy
LmMgICAgICAgICAgICAgICAgfCA0MDggKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiBkcml2ZXJz
L2FuZHJvaWQvYmluZGVyX2ludGVybmFsLmggICAgICAgfCA0MTYgKysrKysrKysrKysrKysrKysr
KysrKysrDQogZHJpdmVycy9hbmRyb2lkL2JpbmRlcl9sYXRlbmN5X3RyYWNlci5jIHwgMTA4ICsr
KysrKw0KIGRyaXZlcnMvYW5kcm9pZC9iaW5kZXJfdHJhY2UuaCAgICAgICAgICB8ICA0OSArKysN
CiA2IGZpbGVzIGNoYW5nZWQsIDU4NiBpbnNlcnRpb25zKCspLCA0MDQgZGVsZXRpb25zKC0pICBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9hbmRyb2lkL2JpbmRlcl9sYXRlbmN5X3RyYWNlci5j
DQoNCkNoYW5nZSBmcm9tIHY1Og0KICAtIGNoYW5nZSBjb25maWcgbmFtZSB0byB0aGUgcHJvcGVy
IG9uZSwgQ09ORklHX0JJTkRFUl9UUkFOU0FDVElPTl9MQVRFTkNZX1RSQUNLSU5HLg0KICAtIGNo
YW5nZSB0cmFjZXBvaW50IG5hbWUgdG8gbW9yZSBkZXNjcmlwdGl2ZSBvbmUsIHRyYWNlX2JpbmRl
cl90eG5fbGF0ZW5jeV8oYWxsb2N8aW5mb3xmcmVlKQ0KICAtIGVuaGFuY2Ugc29tZSBsb2NrIHBy
b3RlY3Rpb24uDQoNCkNoYW5nZSBmcm9tIHY0Og0KICAtIHNwbGl0IHVwIGludG8gcGF0Y2ggc2Vy
aWVzLg0KDQpDaGFuZ2UgZnJvbSB2MzoNCiAgLSB1c2UgdHJhY2Vwb2ludHMgZm9yIGJpbmRlcl91
cGRhdGVfaW5mbyBhbmQgcHJpbnRfYmluZGVyX3RyYW5zYWN0aW9uX2V4dCwNCiAgICBpbnN0ZWFk
IG9mIGN1c3RvbSByZWdpc3RyYXRpb24gZnVuY3Rpb25zLg0KDQpDaGFuZ2UgZnJvbSB2MjoNCiAg
LSBjcmVhdGUgdHJhbnNhY3Rpb24gbGF0ZW5jeSBtb2R1bGUgdG8gbW9uaXRvciBzbG93IHRyYW5z
YWN0aW9uLg0KDQpDaGFuZ2UgZnJvbSB2MToNCiAgLSBmaXJzdCBwYXRjaHNldC4NCg==

