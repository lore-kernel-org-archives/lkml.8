Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A9BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 16:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DE5220738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 16:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NChHWJY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgFCQLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 12:11:40 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42126 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725834AbgFCQLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 12:11:39 -0400
X-UUID: 7580392a69de49d38c447f71ce03f9f7-20200604
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=dcLz9a48qWis1A4C8qZ1IIJYb+koWT5X7xxpq9JWgPU=;
        b=NChHWJY8XfG9/EQKsn4lxUe19eQYv9kB+Boz1ySvE6Dxc1nQDvN4vfCEZZHhsESN8HWojhwltbEIx1Dau/nQ2QVSh39EZWwk8NuJEpByYdZqlNzA2Iv0tP+mul5nKEINcPW01/8iYuzy1z4PEIp02GxJCl9CJm2SdP5Xe5+pVVA=;
X-UUID: 7580392a69de49d38c447f71ce03f9f7-20200604
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1938197506; Thu, 04 Jun 2020 00:11:35 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 4 Jun 2020 00:11:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 4 Jun 2020 00:11:30 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH] mm/memblock: export max_pfn for kernel modules
Date:   Thu, 4 Jun 2020 00:11:32 +0800
Message-ID: <20200603161132.2441-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bWF4X3BmbiBpcyB1ZXNkIHRvIGdldCB0aGUgaGlnaGVzdCBwZm4gaW4gdGhlIHN5c3RlbS4gRHJp
dmVycyBsaWtlDQpkcml2ZXJzL2lvbW11L210a19pb21tdS5jIGNoZWNrcyBtYXhfcGZuIHRvIHNl
ZSBpZiBpdCBzaG91bGQgZW5hYmxlDQppdHMgIjRHQiBtb2RlIi4NCg0KVGhpcyBwYXRjaCBleHBv
cnRzIHRoZSBtYXhfcGZuIHN5bWJvbCwgc28gd2UgY2FuIGJ1aWxkIHRoZSBkcml2ZXIgYXMNCmEg
a2VybmVsIG1vZHVsZS4NCg0KU2lnbmVkLW9mZi1ieTogTWlsZXMgQ2hlbiA8bWlsZXMuY2hlbkBt
ZWRpYXRlay5jb20+DQotLS0NCiBtbS9tZW1ibG9jay5jIHwgMSArDQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9tbS9tZW1ibG9jay5jIGIvbW0vbWVtYmxv
Y2suYw0KaW5kZXggYzc5YmE2Zjk5MjBjLi4zYjJiMjFlY2ViYjYgMTAwNjQ0DQotLS0gYS9tbS9t
ZW1ibG9jay5jDQorKysgYi9tbS9tZW1ibG9jay5jDQpAQCAtOTksNiArOTksNyBAQCBFWFBPUlRf
U1lNQk9MKGNvbnRpZ19wYWdlX2RhdGEpOw0KIHVuc2lnbmVkIGxvbmcgbWF4X2xvd19wZm47DQog
dW5zaWduZWQgbG9uZyBtaW5fbG93X3BmbjsNCiB1bnNpZ25lZCBsb25nIG1heF9wZm47DQorRVhQ
T1JUX1NZTUJPTChtYXhfcGZuKTsNCiB1bnNpZ25lZCBsb25nIGxvbmcgbWF4X3Bvc3NpYmxlX3Bm
bjsNCiANCiBzdGF0aWMgc3RydWN0IG1lbWJsb2NrX3JlZ2lvbiBtZW1ibG9ja19tZW1vcnlfaW5p
dF9yZWdpb25zW0lOSVRfTUVNQkxPQ0tfUkVHSU9OU10gX19pbml0ZGF0YV9tZW1ibG9jazsNCi0t
IA0KMi4xOC4wDQo=

