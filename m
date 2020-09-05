Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EB6C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5C3B20760
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tEuQ+ZFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgIEIMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 04:12:23 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:26014 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728302AbgIEIMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 04:12:18 -0400
X-UUID: bbd14b9a859c42618fb27a360a31021c-20200905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=axtHnh7qKvv1KMMgmnGRSN/KcSTs8AdXhfI9O+e7IvY=;
        b=tEuQ+ZFAXK1WULmRiculiMU8KEtyWnHlzcsCIikvDLZMSQJ1RjRat5c1yxM0nzBM1Ok0DlnjFROkjQ3W2cKd1wmd33UDUxmrCE5jb26r201qnFJUzj7sbM9Obqe+FNM8/qwWJ99AasbwOWtCitUtSJYYNi8o+GOXt2AMv9+YKkw=;
X-UUID: bbd14b9a859c42618fb27a360a31021c-20200905
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1364920411; Sat, 05 Sep 2020 16:12:15 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Sep 2020 16:12:12 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Sep 2020 16:12:12 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Will Deacon <will@kernel.org>, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>
Subject: [PATCH v2 05/23] dt-bindings: memory: mediatek: Add domain definition
Date:   Sat, 5 Sep 2020 16:09:02 +0800
Message-ID: <20200905080920.13396-6-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200905080920.13396-1-yong.wu@mediatek.com>
References: <20200905080920.13396-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 6BDB272421E35EDA65A7640FEC91A413578AB2B5B6E49F4A371C208976D97BA92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gdGhlIGxhdGVzdCBTb0MsIHRoZXJlIGFyZSBzZXZlcmFsIEhXIElQIHJlcXVpcmUgYSBzZXBl
Y2lhbCBpb3ZhDQpyYW5nZSwgbWFpbmx5IENDVSBhbmQgVlBVIGhhcyB0aGlzIHJlcXVpcmVtZW50
LiBUYWtlIENDVSBhcyBhIGV4YW1wbGUsDQpDQ1UgcmVxdWlyZSBpdHMgaW92YSBsb2NhdGUgaW4g
dGhlIHJhbmdlKDB4NDAwMF8wMDAwIH4gMHg0M2ZmX2ZmZmYpLg0KDQpJbiB0aGlzIHBhdGNoIHdl
IGFkZCBhIGRvbWFpbiBkZWZpbml0aW9uIGZvciB0aGUgc3BlY2lhbCBwb3J0LiBJbiB0aGUNCmV4
YW1wbGUgb2YgQ0NVLCBJZiB3ZSBwcmVhc3NpZ24gQ0NVIHBvcnQgaW4gZG9tYWluMSwgdGhlbiBp
b21tdSBkcml2ZXINCndpbGwgcHJlcGFyZSBhIGluZGVwZW5kZW50IGlvbW11IGRvbWFpbiBvZiB0
aGUgc3BlY2lhbCBpb3ZhIHJhbmdlIGZvciBpdCwNCnRoZW4gdGhlIGlvdmEgZ290IGZyb20gZG1h
X2FsbG9jX2F0dHJzKGNjdS1kZXYpIHdpbGwgbG9jYXRlIGluIGl0cyBzcGVjaWFsDQpyYW5nZS4N
Cg0KVGhpcyBpcyBhIHByZXBhcmluZyBwYXRjaCBmb3IgbXVsdGktZG9tYWluIHN1cHBvcnQuDQoN
ClNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KLS0tDQogaW5j
bHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXRrLXNtaS1sYXJiLXBvcnQuaCB8IDkgKysrKysrKyst
DQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXRrLXNtaS1sYXJiLXBvcnQuaCBi
L2luY2x1ZGUvZHQtYmluZGluZ3MvbWVtb3J5L210ay1zbWktbGFyYi1wb3J0LmgNCmluZGV4IGY0
ZDhlM2FlZDBiYy4uZDAwZjVkZTg0MzhiIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9kdC1iaW5kaW5n
cy9tZW1vcnkvbXRrLXNtaS1sYXJiLXBvcnQuaA0KKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9t
ZW1vcnkvbXRrLXNtaS1sYXJiLXBvcnQuaA0KQEAgLTcsOSArNywxNiBAQA0KICNkZWZpbmUgX19E
VFNfTVRLX0lPTU1VX1BPUlRfSF8NCiANCiAjZGVmaW5lIE1US19MQVJCX05SX01BWAkJCTMyDQor
I2RlZmluZSBNVEtfTTRVX0RPTV9OUl9NQVgJCTgNCisNCisjZGVmaW5lIE1US19NNFVfRE9NX0lE
KGRvbWlkLCBsYXJiLCBwb3J0KQlcDQorCSgoKGRvbWlkKSAmIDB4NykgPDwgMTYgfCAoKChsYXJi
KSAmIDB4MWYpIDw8IDUpIHwgKChwb3J0KSAmIDB4MWYpKQ0KKw0KKy8qIFRoZSBkZWZhdWx0IGRv
bSBpZCBpcyAwLiAqLw0KKyNkZWZpbmUgTVRLX000VV9JRChsYXJiLCBwb3J0KQkJTVRLX000VV9E
T01fSUQoMCwgbGFyYiwgcG9ydCkNCiANCi0jZGVmaW5lIE1US19NNFVfSUQobGFyYiwgcG9ydCkJ
CSgoKGxhcmIpIDw8IDUpIHwgKHBvcnQpKQ0KICNkZWZpbmUgTVRLX000VV9UT19MQVJCKGlkKQkJ
KCgoaWQpID4+IDUpICYgMHgxZikNCiAjZGVmaW5lIE1US19NNFVfVE9fUE9SVChpZCkJCSgoaWQp
ICYgMHgxZikNCisjZGVmaW5lIE1US19NNFVfVE9fRE9NKGlkKQkJKCgoaWQpID4+IDE2KSAmIDB4
NykNCiANCiAjZW5kaWYNCi0tIA0KMi4xOC4wDQo=

