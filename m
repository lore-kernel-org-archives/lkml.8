Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF930C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B92CF2078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="D7Nkcj7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgHTGFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 02:05:52 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44885 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725780AbgHTGFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 02:05:40 -0400
X-UUID: 9218daac27ca48c2947f155bbf14cf68-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=QLvmhk/7LpbICAGpkbfWVn3/Wuqwv5iyOTD2cZ1uZTw=;
        b=D7Nkcj7pSQeVlQqcAOuRXhPAfL9ZYecXk2CrPytSx5qUPlXrIlDGXupPEi/2Kr8ryrwENEvrOGE5u4tabnppSFe1BqAB9UddZBfDjdcYLhLtP9e4OZQ4tDisRbNwGH5Qayn2vjvw4sn9XKaN22vwxs/u6408QAd6W3eNB0yuaJs=;
X-UUID: 9218daac27ca48c2947f155bbf14cf68-20200820
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 978653150; Thu, 20 Aug 2020 14:05:36 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 14:05:34 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 14:05:33 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v1 03/21] drm/mediatek: add component RDMA4
Date:   Thu, 20 Aug 2020 14:04:00 +0800
Message-ID: <1597903458-8055-4-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGQgY29tcG9uZW50IFJETUE0DQoNClNpZ25lZC1vZmYtYnk6IFlvbmdxaWFu
ZyBOaXUgPHlvbmdxaWFuZy5uaXVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYyB8IDEgKw0KIGluY2x1ZGUvbGludXgvc29jL21l
ZGlhdGVrL210ay1tbXN5cy5oICAgICAgfCAxICsNCiAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
ZGRwX2NvbXAuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMN
CmluZGV4IDhiOWZiNWUuLmM5MGQyZWUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RybV9kZHBfY29tcC5jDQpAQCAtNDM5LDYgKzQzOSw3IEBAIHN0cnVjdCBtdGtfZGRwX2Nv
bXBfbWF0Y2ggew0KIAlbRERQX0NPTVBPTkVOVF9SRE1BMF0JPSB7IE1US19ESVNQX1JETUEsCTAs
IE5VTEwgfSwNCiAJW0REUF9DT01QT05FTlRfUkRNQTFdCT0geyBNVEtfRElTUF9SRE1BLAkxLCBO
VUxMIH0sDQogCVtERFBfQ09NUE9ORU5UX1JETUEyXQk9IHsgTVRLX0RJU1BfUkRNQSwJMiwgTlVM
TCB9LA0KKwlbRERQX0NPTVBPTkVOVF9SRE1BNF0JPSB7IE1US19ESVNQX1JETUEsCTQsIE5VTEwg
fSwNCiAJW0REUF9DT01QT05FTlRfVUZPRV0JPSB7IE1US19ESVNQX1VGT0UsCTAsICZkZHBfdWZv
ZSB9LA0KIAlbRERQX0NPTVBPTkVOVF9XRE1BMF0JPSB7IE1US19ESVNQX1dETUEsCTAsIE5VTEwg
fSwNCiAJW0REUF9DT01QT05FTlRfV0RNQTFdCT0geyBNVEtfRElTUF9XRE1BLAkxLCBOVUxMIH0s
DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmggYi9p
bmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstbW1zeXMuaA0KaW5kZXggY2MyMmMzZS4uOGVm
M2VhYSAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1tbXN5cy5o
DQorKysgYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstbW1zeXMuaA0KQEAgLTM4LDYg
KzM4LDcgQEAgZW51bSBtdGtfZGRwX2NvbXBfaWQgew0KIAlERFBfQ09NUE9ORU5UX1JETUEwLA0K
IAlERFBfQ09NUE9ORU5UX1JETUExLA0KIAlERFBfQ09NUE9ORU5UX1JETUEyLA0KKwlERFBfQ09N
UE9ORU5UX1JETUE0LA0KIAlERFBfQ09NUE9ORU5UX1VGT0UsDQogCUREUF9DT01QT05FTlRfV0RN
QTAsDQogCUREUF9DT01QT05FTlRfV0RNQTEsDQotLSANCjEuOC4xLjEuZGlydHkNCg==

