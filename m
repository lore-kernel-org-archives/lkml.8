Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CA3C83006
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 08:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88B592073E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 08:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PNOC4qW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgD3IOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 04:14:10 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:31993 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726788AbgD3IOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 04:14:09 -0400
X-UUID: 51e75c5821d34784a7d35253cf61d5ff-20200430
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=w1PTlJUtkcNYITdH/xyYtODmgpFWIxh9hEEtJ7ibU00=;
        b=PNOC4qW2tjcXS4KLcyzvOCvdFfyKLj/PfuHbRxIA60TENxTDIZdF+jYdS7rdm7GhFSM2M5QUO/HvOML5q8NEvjJJoybbdMTuxGTUsge8/esDxsg2cNiKBA2VMXeKUZtxE0zDR0pt8Ad402LfUTQj9479yMtIc7nNb+RYpwrABrw=;
X-UUID: 51e75c5821d34784a7d35253cf61d5ff-20200430
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <frankie.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1400320780; Thu, 30 Apr 2020 16:14:05 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 30 Apr 2020 16:14:02 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 30 Apr 2020 16:14:03 +0800
From:   Frankie Chang <Frankie.Chang@mediatek.com>
To:     Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Subject: binder: transaction latency tracking for user build
Date:   Thu, 30 Apr 2020 16:13:58 +0800
Message-ID: <1588234439-7959-1-git-send-email-Frankie.Chang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1586929044-12708-2-git-send-email-Frankie.Chang@mediatek.com>
References: <1586929044-12708-2-git-send-email-Frankie.Chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 92DAC2B9F6833CF10572FD14EBE445516A5D9091CA5ADE0EAB2126F5D5D65D532000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpGcmFua2llIENoYW5nICgxKToNCiAgYmluZGVyOiB0cmFuc2FjdGlvbiBsYXRlbmN5IHRyYWNr
aW5nIGZvciB1c2VyIGJ1aWxkDQoNCiBkcml2ZXJzL2FuZHJvaWQvS2NvbmZpZyAgICAgICAgICAg
ICAgICAgfCAgICA4ICsNCiBkcml2ZXJzL2FuZHJvaWQvTWFrZWZpbGUgICAgICAgICAgICAgICAg
fCAgICAxICsNCiBkcml2ZXJzL2FuZHJvaWQvYmluZGVyLmMgICAgICAgICAgICAgICAgfCAgNDA4
ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIGRyaXZlcnMvYW5kcm9pZC9iaW5kZXJf
aW50ZXJuYWwuaCAgICAgICB8ICA0MTYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
IGRyaXZlcnMvYW5kcm9pZC9iaW5kZXJfbGF0ZW5jeV90cmFjZXIuYyB8ICAxMDUgKysrKysrKysN
CiBkcml2ZXJzL2FuZHJvaWQvYmluZGVyX3RyYWNlLmggICAgICAgICAgfCAgIDQ5ICsrKysNCiA2
IGZpbGVzIGNoYW5nZWQsIDU4MyBpbnNlcnRpb25zKCspLCA0MDQgZGVsZXRpb25zKC0pDQogY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvYW5kcm9pZC9iaW5kZXJfbGF0ZW5jeV90cmFjZXIuYw==

