Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0109FC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 09:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0FA2084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 09:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZbUNAVMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgBDJPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 04:15:22 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:31020 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726189AbgBDJPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 04:15:22 -0500
X-UUID: 5302254f2b0f48a19fd958104aab8149-20200204
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=fQaXdeVDrEL7G0OipbsvUZ4eyfT2E7gO3ttXrpO3g5M=;
        b=ZbUNAVMKpShRXgd1DB04GDSBN0perqckMQS3VOq2yExytRJZxTMrfmoxjufegpQxUiinUdLV0AW4f2xt3BlQhvPiRZiF7omV0rUfiKwSCPme7F2eDXhSAiG3tXSsTJgtPB//GezGt8+niPCD9TV2vax9dE01+crllpu1udejkhk=;
X-UUID: 5302254f2b0f48a19fd958104aab8149-20200204
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <frankie.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 512517626; Tue, 04 Feb 2020 17:15:19 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 4 Feb 2020 17:14:13 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 4 Feb 2020 17:12:46 +0800
From:   Frankie Chang <Frankie.Chang@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        <Jian-Min.Liu@mediatek.com>
Subject: [PATCH v1] binder: transaction latency tracking for user build
Date:   Tue, 4 Feb 2020 17:15:14 +0800
Message-ID: <1580807715-26609-1-git-send-email-Frankie.Chang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 888C6AE8C31F60CE5AC86D6652174CD78C707B853BA9C90257CA6842ED7EF1AE2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmVjb3JkIHN0YXJ0L2VuZCB0aW1lc3RhbXAgdG8gYmluZGVyIHRyYW5zYWN0aW9uLg0KV2hlbiB0
cmFuc2FjdGlvbiBpcyBjb21wbGV0ZWQgb3IgdHJhbnNhY3Rpb24gaXMgZnJlZSwNCml0IHdvdWxk
IGJlIGNoZWNrZWQgaWYgdHJhbnNhY3Rpb24gbGF0ZW5jeSBvdmVyIHRocmVzaG9sZCAoMiBzZWMp
LA0KaWYgeWVzLCBwcmludGluZyByZWxhdGVkIGluZm9ybWF0aW9uIGZvciB0cmFjaW5nLg0KDQoN
CkZyYW5raWUgQ2hhbmcgKDEpOg0KICBiaW5kZXI6IHRyYW5zYWN0aW9uIGxhdGVuY3kgdHJhY2tp
bmcgZm9yIHVzZXIgYnVpbGQNCg0KIGRyaXZlcnMvYW5kcm9pZC9LY29uZmlnICAgICAgICAgICB8
ICAgIDggKysrDQogZHJpdmVycy9hbmRyb2lkL2JpbmRlci5jICAgICAgICAgIHwgIDEwNyArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogZHJpdmVycy9hbmRyb2lkL2JpbmRl
cl9pbnRlcm5hbC5oIHwgICAgNCArKw0KIDMgZmlsZXMgY2hhbmdlZCwgMTE5IGluc2VydGlvbnMo
KykNCg==

