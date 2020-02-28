Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943C8C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 05:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF50246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 05:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="plqhrdHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgB1FV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 00:21:58 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:22461 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725785AbgB1FV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 00:21:57 -0500
X-UUID: 7dea9d78de0c44a4a679dba45f8287d5-20200228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Tbydff45iGovy+Y4pjIMl85obrLQehvyczoepJ8vfGk=;
        b=plqhrdHk0wNYCJ7e7lMByDtUwspI8woWGvL5GQnmMrcAOrLqkK4Q9BOuYtXsvdcCG6+C1YvvH6k2W1dhPaBzxDcVryK9KIAq5cRmwqFu0iQTXJxFc2Qk7ekPDGlZ3naKrOdvYVgrzB+v13f6pdFUz/qanMasE344iW/rD+manPQ=;
X-UUID: 7dea9d78de0c44a4a679dba45f8287d5-20200228
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 167959928; Fri, 28 Feb 2020 13:21:40 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 28 Feb
 2020 13:17:27 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Fri, 28 Feb 2020 13:22:02 +0800
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
Subject: [PATCH v10 1/5] dt-bindings: media: add pclk-sample dual edge property
Date:   Fri, 28 Feb 2020 13:21:24 +0800
Message-ID: <20200228052128.82136-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200228052128.82136-1-jitao.shi@mediatek.com>
References: <20200228052128.82136-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A22871F805E5B4F57ABE6549F19DF64BCE1F8012165BDF6DC318108B736C6F092000:8
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

