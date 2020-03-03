Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3CCC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 05:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6422080C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 05:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Zx8QN+Cw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbgCCF3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 00:29:18 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:26569 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725554AbgCCF3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 00:29:17 -0500
X-UUID: 19b6b49e71e148768e38cd6b6c7f098e-20200303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Tbydff45iGovy+Y4pjIMl85obrLQehvyczoepJ8vfGk=;
        b=Zx8QN+CwmUu4Q3U5t/tkxsqWpjiRfNFnrYFQbckjAJv2AjGj6Xe4F8LNbg4eqU3fGg6a8kr6oIoItKZzay2LQ9koaZEi1VWy8qV5bPUiFnZLT6oRM/jx63oU5nK5NEb1/fl40n20QCpbOMGMDDihnxQbvVg2FFcHbt8UDQzceGw=;
X-UUID: 19b6b49e71e148768e38cd6b6c7f098e-20200303
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 284516448; Tue, 03 Mar 2020 13:27:54 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 3 Mar
 2020 13:28:12 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 3 Mar 2020 13:28:13 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, <huijuan.xie@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v12 1/6] dt-bindings: media: add pclk-sample dual edge property
Date:   Tue, 3 Mar 2020 13:27:17 +0800
Message-ID: <20200303052722.94795-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200303052722.94795-1-jitao.shi@mediatek.com>
References: <20200303052722.94795-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 92A6DFEB79979C0D84A620945EE2BC62DE25972615F16215D7CE08A88AB02D022000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29tZSBjaGlwcydzIHNhbXBsZSBtb2RlIGFyZSByaXNpbmcsIGZhbGxpbmcgYW5kIGR1YWwgZWRn
ZSAoYm90aA0KZmFsbGluZyBhbmQgcmlzaW5nIGVkZ2UpLg0KRXh0ZXJuIHRoZSBwY2xrLXNhbXBs
ZSBwcm9wZXJ0eSB0byBzdXBwb3J0IGR1YWwgZWRnZS4NCg0KQWNrZWQtYnk6IFJvYiBIZXJyaW5n
IDxyb2JoQGtlcm5lbC5vcmc+DQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNv
bT4NClNpZ25lZC1vZmYtYnk6IEppdGFvIFNoaSA8aml0YW8uc2hpQG1lZGlhdGVrLmNvbT4NCi0t
LQ0KIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS92aWRlby1pbnRlcmZh
Y2VzLnR4dCB8IDQgKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbWVkaWEvdmlkZW8taW50ZXJmYWNlcy50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbWVkaWEvdmlkZW8taW50ZXJmYWNlcy50eHQNCmluZGV4IGY4ODRhZGEwYmZmYy4u
ZGE5YWQyNDkzNWRiIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL21lZGlhL3ZpZGVvLWludGVyZmFjZXMudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbWVkaWEvdmlkZW8taW50ZXJmYWNlcy50eHQNCkBAIC0xMTgsOCArMTE4
LDggQEAgT3B0aW9uYWwgZW5kcG9pbnQgcHJvcGVydGllcw0KIC0gZGF0YS1lbmFibGUtYWN0aXZl
OiBzaW1pbGFyIHRvIEhTWU5DIGFuZCBWU1lOQywgc3BlY2lmaWVzIHRoZSBkYXRhIGVuYWJsZQ0K
ICAgc2lnbmFsIHBvbGFyaXR5Lg0KIC0gZmllbGQtZXZlbi1hY3RpdmU6IGZpZWxkIHNpZ25hbCBs
ZXZlbCBkdXJpbmcgdGhlIGV2ZW4gZmllbGQgZGF0YSB0cmFuc21pc3Npb24uDQotLSBwY2xrLXNh
bXBsZTogc2FtcGxlIGRhdGEgb24gcmlzaW5nICgxKSBvciBmYWxsaW5nICgwKSBlZGdlIG9mIHRo
ZSBwaXhlbCBjbG9jaw0KLSAgc2lnbmFsLg0KKy0gcGNsay1zYW1wbGU6IHNhbXBsZSBkYXRhIG9u
IHJpc2luZyAoMSksIGZhbGxpbmcgKDApIG9yIGJvdGggcmlzaW5nIGFuZA0KKyAgZmFsbGluZyAo
MikgZWRnZSBvZiB0aGUgcGl4ZWwgY2xvY2sgc2lnbmFsLg0KIC0gc3luYy1vbi1ncmVlbi1hY3Rp
dmU6IGFjdGl2ZSBzdGF0ZSBvZiBTeW5jLW9uLWdyZWVuIChTb0cpIHNpZ25hbCwgMC8xIGZvcg0K
ICAgTE9XL0hJR0ggcmVzcGVjdGl2ZWx5Lg0KIC0gZGF0YS1sYW5lczogYW4gYXJyYXkgb2YgcGh5
c2ljYWwgZGF0YSBsYW5lIGluZGV4ZXMuIFBvc2l0aW9uIG9mIGFuIGVudHJ5DQotLSANCjIuMjEu
MA0K

