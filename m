Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093EFC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD98920753
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rTqaBwSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgEGILK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 04:11:10 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:45115 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725858AbgEGILJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 04:11:09 -0400
X-UUID: 96b783be44ad45d88a94a8c51a866c07-20200507
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=U3rOHmbZkfyZYNk3QoGRcI8HUwADaDcQDbyBxnNmq/4=;
        b=rTqaBwSBnzuq0adkIykxKC1DinYI46SFK22FHeqc1aSi7nBSec6UGF8w5rF7399MUBvEP/GF2pg71EVTsOkEZ2lzoag75uBRaCvp6KjhW76OSTL7ayC/HaVfV7dzEBBimPl88/r1cszFnS03GuE1aJsahXukQx+YFp6Pvg0m4yU=;
X-UUID: 96b783be44ad45d88a94a8c51a866c07-20200507
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <frankie.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 424663272; Thu, 07 May 2020 16:11:06 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 7 May 2020 16:10:56 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 7 May 2020 16:10:55 +0800
From:   Frankie Chang <Frankie.Chang@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>
CC:     Martijn Coenen <maco@android.com>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Subject: binder: transaction latency tracking for user build
Date:   Thu, 7 May 2020 16:10:52 +0800
Message-ID: <1588839055-26677-1-git-send-email-Frankie.Chang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <20200430085105.GF2496467@kroah.com>
References: <20200430085105.GF2496467@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: BA4C6F361779C1B7134FD62D3A807F06C4F8C4209677814ABEA4A00D1DC073DE2000:8
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
KysrKysrDQogZHJpdmVycy9hbmRyb2lkL2JpbmRlcl9sYXRlbmN5X3RyYWNlci5jIHwgMTA1ICsr
KysrKw0KIGRyaXZlcnMvYW5kcm9pZC9iaW5kZXJfdHJhY2UuaCAgICAgICAgICB8ICA0NyArKysN
CiA2IGZpbGVzIGNoYW5nZWQsIDU4MSBpbnNlcnRpb25zKCspLCA0MDQgZGVsZXRpb25zKC0pDQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvYW5kcm9pZC9iaW5kZXJfbGF0ZW5jeV90cmFjZXIu
Yw==

