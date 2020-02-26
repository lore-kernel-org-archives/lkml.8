Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EDCC4BA0D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ABF6222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lYCSaNhh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgBZFdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 00:33:07 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:21238 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725890AbgBZFdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 00:33:06 -0500
X-UUID: d2cc2763c2084c39bdb4c2cbfe8f3902-20200226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Xnzgg9hwblSGYMaQvn753NnnXA3kXYThKJ7XCq2hMv8=;
        b=lYCSaNhhe0s9X7GQSLynY2rNPjRRGr+CPM4MStL0MWbziE4k4oKlRTLL4uDDhAOpPAOkbNCYFS6HrbMyatk4xHRajzevZ6firglwiFzsjMP6IB8YkHhHc58RF6Z8NiuMICxdD1VWYelxD3y+APjhBTZHbQsIhVdwMzP9PSXnCaY=;
X-UUID: d2cc2763c2084c39bdb4c2cbfe8f3902-20200226
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1737733946; Wed, 26 Feb 2020 13:32:48 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 26 Feb
 2020 13:31:26 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Wed, 26 Feb 2020 13:31:22 +0800
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
Subject: [PATCH v9 1/5] dt-bindings: media: add pclk-sample dual edge property
Date:   Wed, 26 Feb 2020 13:32:34 +0800
Message-ID: <20200226053238.31646-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200226053238.31646-1-jitao.shi@mediatek.com>
References: <20200226053238.31646-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 638BC656DBDFFE8591F7F8BF51D34995E8064A17874DBF4DBF63E097F235DEA62000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29tZSBjaGlwcydzIHNhbXBsZSBtb2RlIGFyZSByaXNpbmcsIGZhbGxpbmcgYW5kIGR1YWwgZWRn
ZSAoYm90aA0KZmFsbGluZyBhbmQgcmlzaW5nIGVkZ2UpLg0KRXh0ZXJuIHRoZSBwY2xrLXNhbXBs
ZSBwcm9wZXJ0eSB0byBzdXBwb3J0IGR1YWwgZWRnZS4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxj
ay5odUBtZWRpYXRlay5jb20+DQpTaWduZWQtb2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBt
ZWRpYXRlay5jb20+DQotLS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVk
aWEvdmlkZW8taW50ZXJmYWNlcy50eHQgfCA0ICsrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL3ZpZGVvLWludGVyZmFjZXMudHh0IGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL3ZpZGVvLWludGVyZmFjZXMudHh0DQppbmRl
eCBmODg0YWRhMGJmZmMuLmRhOWFkMjQ5MzVkYiAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS92aWRlby1pbnRlcmZhY2VzLnR4dA0KKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL3ZpZGVvLWludGVyZmFjZXMudHh0
DQpAQCAtMTE4LDggKzExOCw4IEBAIE9wdGlvbmFsIGVuZHBvaW50IHByb3BlcnRpZXMNCiAtIGRh
dGEtZW5hYmxlLWFjdGl2ZTogc2ltaWxhciB0byBIU1lOQyBhbmQgVlNZTkMsIHNwZWNpZmllcyB0
aGUgZGF0YSBlbmFibGUNCiAgIHNpZ25hbCBwb2xhcml0eS4NCiAtIGZpZWxkLWV2ZW4tYWN0aXZl
OiBmaWVsZCBzaWduYWwgbGV2ZWwgZHVyaW5nIHRoZSBldmVuIGZpZWxkIGRhdGEgdHJhbnNtaXNz
aW9uLg0KLS0gcGNsay1zYW1wbGU6IHNhbXBsZSBkYXRhIG9uIHJpc2luZyAoMSkgb3IgZmFsbGlu
ZyAoMCkgZWRnZSBvZiB0aGUgcGl4ZWwgY2xvY2sNCi0gIHNpZ25hbC4NCistIHBjbGstc2FtcGxl
OiBzYW1wbGUgZGF0YSBvbiByaXNpbmcgKDEpLCBmYWxsaW5nICgwKSBvciBib3RoIHJpc2luZyBh
bmQNCisgIGZhbGxpbmcgKDIpIGVkZ2Ugb2YgdGhlIHBpeGVsIGNsb2NrIHNpZ25hbC4NCiAtIHN5
bmMtb24tZ3JlZW4tYWN0aXZlOiBhY3RpdmUgc3RhdGUgb2YgU3luYy1vbi1ncmVlbiAoU29HKSBz
aWduYWwsIDAvMSBmb3INCiAgIExPVy9ISUdIIHJlc3BlY3RpdmVseS4NCiAtIGRhdGEtbGFuZXM6
IGFuIGFycmF5IG9mIHBoeXNpY2FsIGRhdGEgbGFuZSBpbmRleGVzLiBQb3NpdGlvbiBvZiBhbiBl
bnRyeQ0KLS0gDQoyLjIxLjANCg==

