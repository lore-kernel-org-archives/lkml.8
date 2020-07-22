Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987B5C433F2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63867207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dPOjE8IF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgGVHxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:53:05 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:23115 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726821AbgGVHws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:52:48 -0400
X-UUID: bd70cc3ec72941578030385d60c997ba-20200722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=cfYm60Altq9Wqji4CsoqqXRvsmV3rfZV2KW7eN4V7sM=;
        b=dPOjE8IFfuE30mdLcjqGG+DjwiaOmJciHFltBQiqd3tRO4zzkOrYVYu1fFbJD+iTYeKRFoZ0BO6Nm6cXvz9oqIyAEDrCoKRSgD9yl2wqXsgWfTJCq9eyMBwZtv0LZ+AZaXZssC11sc7uIWhj1leU+Uj9Eb33/K1RGbVXfT3nUIw=;
X-UUID: bd70cc3ec72941578030385d60c997ba-20200722
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 305168531; Wed, 22 Jul 2020 15:52:40 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Jul 2020 15:52:38 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 22 Jul 2020 15:52:37 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Patrice Chotard <patrice.chotard@st.com>
Subject: [PATCH 4/7] usb: dwc3: convert to devm_platform_ioremap_resource_byname
Date:   Wed, 22 Jul 2020 15:51:12 +0800
Message-ID: <1595404275-8449-4-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1595404275-8449-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1595404275-8449-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 476947B2B4033799B8766523F97A3126D70D8C4018667E0F265131D97B0086FE2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZV9ieW5hbWUoKSB0byBzaW1wbGlmeSBj
b2RlDQoNCkNjOiBQYXRyaWNlIENob3RhcmQgPHBhdHJpY2UuY2hvdGFyZEBzdC5jb20+DQpTaWdu
ZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQotLS0N
CiBkcml2ZXJzL3VzYi9kd2MzL2R3YzMtc3QuYyB8IDQgKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Vz
Yi9kd2MzL2R3YzMtc3QuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1zdC5jDQppbmRleCBjNjgy
NDIwLi5lNzMzYmU4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLXN0LmMNCisr
KyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1zdC5jDQpAQCAtMjA2LDggKzIwNiw4IEBAIHN0YXRp
YyBpbnQgc3RfZHdjM19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAlpZiAo
IWR3YzNfZGF0YSkNCiAJCXJldHVybiAtRU5PTUVNOw0KIA0KLQlyZXMgPSBwbGF0Zm9ybV9nZXRf
cmVzb3VyY2VfYnluYW1lKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAicmVnLWdsdWUiKTsNCi0JZHdj
M19kYXRhLT5nbHVlX2Jhc2UgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2LCByZXMpOw0KKwlk
d2MzX2RhdGEtPmdsdWVfYmFzZSA9DQorCQlkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2Vf
YnluYW1lKHBkZXYsICJyZWctZ2x1ZSIpOw0KIAlpZiAoSVNfRVJSKGR3YzNfZGF0YS0+Z2x1ZV9i
YXNlKSkNCiAJCXJldHVybiBQVFJfRVJSKGR3YzNfZGF0YS0+Z2x1ZV9iYXNlKTsNCiANCi0tIA0K
MS45LjENCg==

