Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAF2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F037208A9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JO9DJDNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgHDODG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:03:06 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:7851 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728535AbgHDN7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 09:59:40 -0400
X-UUID: 53fd66bb83934f9fbd9fba567c87a300-20200804
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=WfJqxF9cONOh9ISapZhRAcSdB5lxjyrlgdtXWgEHlC4=;
        b=JO9DJDNSHo/RpYPUg+ey0QI29Qtq1SPQBZKxv7DmPKI16nBdBIm9o4U2Jvy6cDFaptCRgrPJGl4K5z5ijGZqASC+krrGZYwswhp11g0kR8wjARGDMEBZfdvFUtiGIGrClSvcpva9H+D2yDortAWxlNBd+zg2a1pqGR+22vOsoAA=;
X-UUID: 53fd66bb83934f9fbd9fba567c87a300-20200804
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <frankie.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 897201809; Tue, 04 Aug 2020 21:59:16 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 4 Aug 2020 21:59:12 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 4 Aug 2020 21:59:13 +0800
From:   Frankie Chang <Frankie.Chang@mediatek.com>
To:     Todd Kjos <tkjos@google.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>,
        Frankie Chang <Frankie.Chang@mediatek.com>
Subject: [PATCH v7] binder: transaction latency tracking for user build
Date:   Tue, 4 Aug 2020 21:59:09 +0800
Message-ID: <1596549552-5466-1-git-send-email-Frankie.Chang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1596509145.5207.21.camel@mtkswgap22>
References: <1596509145.5207.21.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3E93D052AFF41D3ADDCCD18A75EC749C115769084484D43C1F80304E3455ED712000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpGcmFua2llLkNoYW5nICgzKToNCiAgYmluZGVyOiBtb3ZlIHN0cnVjdHMgZnJvbSBjb3JlIGZp
bGUgdG8gaGVhZGVyIGZpbGUNCiAgYmluZGVyOiBhZGQgdHJhY2UgYXQgZnJlZSB0cmFuc2FjdGlv
bi4NCiAgYmluZGVyOiBhZGQgdHJhbnNhY3Rpb24gbGF0ZW5jeSB0cmFjZXINCg0KIGRyaXZlcnMv
YW5kcm9pZC9LY29uZmlnICAgICAgICAgICAgICAgICB8ICAgIDggKw0KIGRyaXZlcnMvYW5kcm9p
ZC9NYWtlZmlsZSAgICAgICAgICAgICAgICB8ICAgIDEgKw0KIGRyaXZlcnMvYW5kcm9pZC9iaW5k
ZXIuYyAgICAgICAgICAgICAgICB8ICA0MjUgKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KIGRyaXZlcnMvYW5kcm9pZC9iaW5kZXJfaW50ZXJuYWwuaCAgICAgICB8ICA0MTcgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQogZHJpdmVycy9hbmRyb2lkL2JpbmRlcl9sYXRlbmN5
X3RyYWNlci5jIHwgIDExMiArKysrKysrKw0KIGRyaXZlcnMvYW5kcm9pZC9iaW5kZXJfdHJhY2Uu
aCAgICAgICAgICB8ICAgNDkgKysrKw0KIDYgZmlsZXMgY2hhbmdlZCwgNjA3IGluc2VydGlvbnMo
KyksIDQwNSBkZWxldGlvbnMoLSkgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2FuZHJvaWQv
YmluZGVyX2xhdGVuY3lfdHJhY2VyLmMNCg0KQ2hhbmdlIGZyb20gdjc6DQogIC0gVXNlIHRoZSBw
YXNzZWQtaW4gdmFsdWVzIGluc3RlYWQgb2YgYWNjZXNzaW5nIHZpYSB0LT5mcm9tL3RvX3Byb2Mv
dG9fdGhyZWFkDQogICAgZm9yIHRyYWNlX2JpbmRlcl90eG5fbGF0ZW5jeV9mcmVlLCB3aGVuIHRy
YWNlX2JpbmRlcl90eG5fbGF0ZW5jeV9mcmVlX2VuYWJsZSgpIHJldHVybiB0cnVlLg0KICAtIG1h
a2UgYSBoZWxwZXIgZnVuY3Rpb24gdG8gZG8gdGhlIGFib3ZlLg0KDQpDaGFuZ2UgZnJvbSB2NjoN
CiAgLSBjaGFuZ2UgQ09ORklHX0JJTkRFUl9UUkFOU0FDVElPTl9MQVRFTkNZX1RSQUNLSU5HIHR5
cGUgZnJvbSBib29sIHRvIHRyaXN0YXRlDQogIC0gYWRkIGNvbW1lbnRzIHRvIEB0aW1lc3RhbXAg
YW5kIEB0diB1bmRlciBzdHJ1Y3QgYmluZGVyX3RyYW5zYWN0aW9uDQogIC0gbWFrZSBiaW5kZXJf
dHhuX2xhdGVuY3kgdGhyZXNob2xkIGNvbmZpZ3VyYWJsZQ0KICAtIGVuaGFuY2UgbG9jayBwcm90
ZWN0aW9uDQoNCkNoYW5nZSBmcm9tIHY1Og0KICAtIGNoYW5nZSBjb25maWcgbmFtZSB0byB0aGUg
cHJvcGVyIG9uZSwgQ09ORklHX0JJTkRFUl9UUkFOU0FDVElPTl9MQVRFTkNZX1RSQUNLSU5HLg0K
ICAtIGNoYW5nZSB0cmFjZXBvaW50IG5hbWUgdG8gbW9yZSBkZXNjcmlwdGl2ZSBvbmUsIHRyYWNl
X2JpbmRlcl90eG5fbGF0ZW5jeV8oYWxsb2N8aW5mb3xmcmVlKQ0KICAtIGVuaGFuY2Ugc29tZSBs
b2NrIHByb3RlY3Rpb24uDQoNCkNoYW5nZSBmcm9tIHY0Og0KICAtIHNwbGl0IHVwIGludG8gcGF0
Y2ggc2VyaWVzLg0KDQpDaGFuZ2UgZnJvbSB2MzoNCiAgLSB1c2UgdHJhY2Vwb2ludHMgZm9yIGJp
bmRlcl91cGRhdGVfaW5mbyBhbmQgcHJpbnRfYmluZGVyX3RyYW5zYWN0aW9uX2V4dCwNCiAgICBp
bnN0ZWFkIG9mIGN1c3RvbSByZWdpc3RyYXRpb24gZnVuY3Rpb25zLg0KDQpDaGFuZ2UgZnJvbSB2
MjoNCiAgLSBjcmVhdGUgdHJhbnNhY3Rpb24gbGF0ZW5jeSBtb2R1bGUgdG8gbW9uaXRvciBzbG93
IHRyYW5zYWN0aW9uLg0KDQpDaGFuZ2UgZnJvbSB2MToNCiAgLSBmaXJzdCBwYXRjaHNldC4NCg==

