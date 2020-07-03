Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6A7C433EC
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 04:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFE3620760
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 04:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="g1LCJS5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgGCEnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 00:43:08 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:61942 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726356AbgGCEnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 00:43:05 -0400
X-UUID: 943d89eda33948a7b1818c5d62fca207-20200703
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=63JZsqC6w//8CgJm6fa1lmJ7QHbUUzma+Qf01H5Anv8=;
        b=g1LCJS5Hv65yo6qlxb3DZbY3KvRXZz7eG9No9UCo/gg0JdjjzSmTesHfoHBbNTcTa8vbpI0aM/u3qWzxxxbe+K+vmlZt45yKbiNLkP6HBCRGtUQJi2nNr+mMY1wBh1dOX+nEDDOIJTT8CWfWa+SnEdD//hhsznE8x5EJHCNhhmk=;
X-UUID: 943d89eda33948a7b1818c5d62fca207-20200703
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2087207907; Fri, 03 Jul 2020 12:43:01 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Jul 2020 12:42:53 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 3 Jul 2020 12:42:49 +0800
From:   Chao Hao <chao.hao@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>,
        FY Yang <fy.yang@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
        TH Yang <th.yang@mediatek.com>
Subject: [PATCH v6 09/10] iommu/mediatek: Modify MMU_CTRL register setting
Date:   Fri, 3 Jul 2020 12:41:26 +0800
Message-ID: <20200703044127.27438-10-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200703044127.27438-1-chao.hao@mediatek.com>
References: <20200703044127.27438-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIE1NVV9DVFJMIHJlZ2lzdGVyIG9mIE1UODE3MyBpcyBkaWZmZXJlbnQgZnJvbSBvdGhlciBT
b0NzLg0KVGhlIGluX29yZGVyX3dyX2VuIGlzIGJpdFs5XSB3aGljaCBpcyB6ZXJvIGJ5IGRlZmF1
bHQuDQpPdGhlciBTb0NzIGhhdmUgdGhlIHZpdGNpbV90bGJfZW4gZmVhdHVyZSBtYXBwZWQgdG8g
Yml0WzEyXS4NClRoaXMgYml0IGlzIHNldCB0byBvbmUgYnkgZGVmYXVsdC4gV2UgbmVlZCB0byBw
cmVzZXJ2ZSB0aGUgYml0DQp3aGVuIHNldHRpbmcgRl9NTVVfVEZfUFJPVF9UT19QUk9HUkFNX0FE
RFIgYXMgb3RoZXJ3aXNlIHRoZQ0KYml0IHdpbGwgYmUgY2xlYXJlZCBhbmQgSU9NTVUgcGVyZm9y
bWFuY2Ugd2lsbCBkcm9wLg0KDQpDYzogTWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhpYXMuYmdnQGdt
YWlsLmNvbT4NCkNjOiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NClNpZ25lZC1vZmYt
Ynk6IENoYW8gSGFvIDxjaGFvLmhhb0BtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2lvbW11
L210a19pb21tdS5jIHwgOCArKysrKy0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21t
dS5jIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KaW5kZXggZTcxMDAzMDM3ZmZhLi5hODE2
MDMwZDAwZjEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQorKysgYi9k
cml2ZXJzL2lvbW11L210a19pb21tdS5jDQpAQCAtNTU1LDExICs1NTUsMTMgQEAgc3RhdGljIGlu
dCBtdGtfaW9tbXVfaHdfaW5pdChjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X2RhdGEgKmRhdGEpDQog
CQlyZXR1cm4gcmV0Ow0KIAl9DQogDQotCWlmIChkYXRhLT5wbGF0X2RhdGEtPm00dV9wbGF0ID09
IE00VV9NVDgxNzMpDQorCWlmIChkYXRhLT5wbGF0X2RhdGEtPm00dV9wbGF0ID09IE00VV9NVDgx
NzMpIHsNCiAJCXJlZ3ZhbCA9IEZfTU1VX1BSRUZFVENIX1JUX1JFUExBQ0VfTU9EIHwNCiAJCQkg
Rl9NTVVfVEZfUFJPVF9UT19QUk9HUkFNX0FERFJfTVQ4MTczOw0KLQllbHNlDQotCQlyZWd2YWwg
PSBGX01NVV9URl9QUk9UX1RPX1BST0dSQU1fQUREUjsNCisJfSBlbHNlIHsNCisJCXJlZ3ZhbCA9
IHJlYWRsX3JlbGF4ZWQoZGF0YS0+YmFzZSArIFJFR19NTVVfQ1RSTF9SRUcpOw0KKwkJcmVndmFs
IHw9IEZfTU1VX1RGX1BST1RfVE9fUFJPR1JBTV9BRERSOw0KKwl9DQogCXdyaXRlbF9yZWxheGVk
KHJlZ3ZhbCwgZGF0YS0+YmFzZSArIFJFR19NTVVfQ1RSTF9SRUcpOw0KIA0KIAlyZWd2YWwgPSBG
X0wyX01VTElUX0hJVF9FTiB8DQotLSANCjIuMTguMA0K

