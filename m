Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4A3C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F18F1206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TRrLOpkA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393350AbgDOFiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 01:38:12 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:15211 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390387AbgDOFiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 01:38:07 -0400
X-UUID: 5eef096cf8e6424b98f5a9633cf4ff72-20200415
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=rFdJukqMuiVvbS0r8hyuDecUDe2evDV8QeEr8RT3h0Q=;
        b=TRrLOpkAoduvtnqjlBfPwHAblb5Dt5M/fslX4D6CWV/7V6ESh8JRsWJ9KREZtNhNTgK/O9NcDNVkTa2pNY3bl7Lc72g0G1LSeTw7P0cNsr9vpLHJJ4Qr8122HrKYgdeFNzdeMhTp+SbIKNby98ywvKo2Xsl9UjsYb5rkN6ZlSN4=;
X-UUID: 5eef096cf8e6424b98f5a9633cf4ff72-20200415
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <frankie.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 328312385; Wed, 15 Apr 2020 13:38:02 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 15 Apr 2020 13:37:57 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Apr 2020 13:37:58 +0800
From:   Frankie Chang <Frankie.Chang@mediatek.com>
To:     Joel Fernandes <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Subject: [PATCH v2] binder: transaction latency tracking for user build
Date:   Wed, 15 Apr 2020 13:37:23 +0800
Message-ID: <1586929044-12708-1-git-send-email-Frankie.Chang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1586759071.9539.15.camel@mtkswgap22>
References: <1586759071.9539.15.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C5AE700466C623C56760133233788485E16B151CBF877C57B456D6F564DA69D72000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpGcmFua2llIENoYW5nICgxKToNCiAgYmluZGVyOiB0cmFuc2FjdGlvbiBsYXRlbmN5IHRyYWNr
aW5nIGZvciB1c2VyIGJ1aWxkDQoNCiBkcml2ZXJzL2FuZHJvaWQvS2NvbmZpZyAgICAgICAgICAg
ICAgICAgfCAgICA4ICsrDQogZHJpdmVycy9hbmRyb2lkL01ha2VmaWxlICAgICAgICAgICAgICAg
IHwgICAgMSArDQogZHJpdmVycy9hbmRyb2lkL2JpbmRlci5jICAgICAgICAgICAgICAgIHwgIDIz
NyArKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogZHJpdmVycy9hbmRyb2lkL2JpbmRl
cl9pbnRlcm5hbC5oICAgICAgIHwgIDIyNyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
IGRyaXZlcnMvYW5kcm9pZC9iaW5kZXJfbGF0ZW5jeV90cmFjZXIuYyB8ICAxMDAgKysrKysrKysr
KysrKw0KIGRyaXZlcnMvYW5kcm9pZC9iaW5kZXJfdHJhY2UuaCAgICAgICAgICB8ICAgMzYgKysr
KysNCiA2IGZpbGVzIGNoYW5nZWQsIDQwMCBpbnNlcnRpb25zKCspLCAyMDkgZGVsZXRpb25zKC0p
DQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvYW5kcm9pZC9iaW5kZXJfbGF0ZW5jeV90cmFj
ZXIuYw==

