Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E565C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E4924670
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="teZkIihn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbgBYJlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 04:41:25 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:58960 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729813AbgBYJlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 04:41:23 -0500
X-UUID: 721e411a3cc64084a78ff3760d139737-20200225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=+9UHoIzAdnK80c9BwL+nHRfyx1ClCc92Z6SatpYKDaQ=;
        b=teZkIihnvPFB9jPlSPdL3kEank0tpg+L3SYNHhbJ6HWme6ps1I8sufj3HqU3bUk8AsbHLL78YqrIlb9vGh4fTj+l+P8yd1FcT0dZvSg3ka7s1R6UUwIBgHW/soQixexPqjEBQ93ZjSgfPrH9TqlKdsvmaw1RoyiYAURgz07ysFQ=;
X-UUID: 721e411a3cc64084a78ff3760d139737-20200225
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1644798728; Tue, 25 Feb 2020 17:41:07 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 25 Feb
 2020 17:39:45 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 25 Feb 2020 17:39:45 +0800
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
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v8 1/7] dt-bindings: media: add pclk-sample dual edge property
Date:   Tue, 25 Feb 2020 17:40:51 +0800
Message-ID: <20200225094057.120144-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200225094057.120144-1-jitao.shi@mediatek.com>
References: <20200225094057.120144-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: CDB7FC69F9E163707809811DAF93E1FF2E6374A0B1821E44F670BB6E4DC42DE72000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29tZSBjaGlwcydzIHNhbXBsZSBtb2RlIGFyZSByaXNpbmcsIGZhbGxpbmcgYW5kIGR1YWwgZWRn
ZSAoYm90aA0KZmFsbGluZyBhbmQgcmlzaW5nIGVkZ2UpLg0KRXh0ZXJuIHRoZSBwY2xrLXNhbXBs
ZSBwcm9wZXJ0eSB0byBzdXBwb3J0IGR1YWwgZWRnZS4NCg0KU2lnbmVkLW9mZi1ieTogSml0YW8g
U2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KLS0tDQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL21lZGlhL3ZpZGVvLWludGVyZmFjZXMudHh0IHwgNCArKy0tDQogMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS92aWRlby1pbnRlcmZhY2Vz
LnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS92aWRlby1pbnRl
cmZhY2VzLnR4dA0KaW5kZXggZjg4NGFkYTBiZmZjLi5kYTlhZDI0OTM1ZGIgMTAwNjQ0DQotLS0g
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEvdmlkZW8taW50ZXJmYWNl
cy50eHQNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS92aWRl
by1pbnRlcmZhY2VzLnR4dA0KQEAgLTExOCw4ICsxMTgsOCBAQCBPcHRpb25hbCBlbmRwb2ludCBw
cm9wZXJ0aWVzDQogLSBkYXRhLWVuYWJsZS1hY3RpdmU6IHNpbWlsYXIgdG8gSFNZTkMgYW5kIFZT
WU5DLCBzcGVjaWZpZXMgdGhlIGRhdGEgZW5hYmxlDQogICBzaWduYWwgcG9sYXJpdHkuDQogLSBm
aWVsZC1ldmVuLWFjdGl2ZTogZmllbGQgc2lnbmFsIGxldmVsIGR1cmluZyB0aGUgZXZlbiBmaWVs
ZCBkYXRhIHRyYW5zbWlzc2lvbi4NCi0tIHBjbGstc2FtcGxlOiBzYW1wbGUgZGF0YSBvbiByaXNp
bmcgKDEpIG9yIGZhbGxpbmcgKDApIGVkZ2Ugb2YgdGhlIHBpeGVsIGNsb2NrDQotICBzaWduYWwu
DQorLSBwY2xrLXNhbXBsZTogc2FtcGxlIGRhdGEgb24gcmlzaW5nICgxKSwgZmFsbGluZyAoMCkg
b3IgYm90aCByaXNpbmcgYW5kDQorICBmYWxsaW5nICgyKSBlZGdlIG9mIHRoZSBwaXhlbCBjbG9j
ayBzaWduYWwuDQogLSBzeW5jLW9uLWdyZWVuLWFjdGl2ZTogYWN0aXZlIHN0YXRlIG9mIFN5bmMt
b24tZ3JlZW4gKFNvRykgc2lnbmFsLCAwLzEgZm9yDQogICBMT1cvSElHSCByZXNwZWN0aXZlbHku
DQogLSBkYXRhLWxhbmVzOiBhbiBhcnJheSBvZiBwaHlzaWNhbCBkYXRhIGxhbmUgaW5kZXhlcy4g
UG9zaXRpb24gb2YgYW4gZW50cnkNCi0tIA0KMi4yMS4wDQo=

