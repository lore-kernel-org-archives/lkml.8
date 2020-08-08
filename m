Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73793C433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47C1A2177B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PdgSFw7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgHHCyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 22:54:51 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:31249 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726402AbgHHCyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 22:54:50 -0400
X-UUID: ddbac345f5e74a21981891c55e09fc18-20200808
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kWZieeEiWrI+QZxqM8iMJlo9waGC/mplSmKIIdhtLMI=;
        b=PdgSFw7vspKz17JdzFIEkma5RdcW3k+kTkWggYb+mTlFmeJaGYU7ME7rm+AluucggevyUCyMCYlJPEjeALEnG2OYS34lOqjJkAPdklg0qIWN9tedegs5HpN3tAss310WcTUHlHClWWk8VDM+BijQtxBRku3nW+dcLpzxBUneLNA=;
X-UUID: ddbac345f5e74a21981891c55e09fc18-20200808
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 8359250; Sat, 08 Aug 2020 10:54:41 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 8 Aug 2020 10:54:39 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 8 Aug 2020 10:54:39 +0800
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
Subject: [RESEND v7, PATCH 1/7] dt-bindings: mediatek: add rdma_fifo_size description for mt8183 display
Date:   Sat, 8 Aug 2020 10:53:45 +0800
Message-ID: <1596855231-5782-2-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1596855231-5782-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1596855231-5782-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cmRtYSBmaWZvIHNpemUgbWF5IGJlIGRpZmZlcmVudCBldmVuIGluIHNhbWUgU09DLCBhZGQgdGhp
cw0KcHJvcGVydHkgdG8gdGhlIGNvcnJlc3BvbmRpbmcgcmRtYQ0KDQpDaGFuZ2UtSWQ6IEk2NzYz
NWVjN2YzZjU5Y2Y0Y2JjNzczNzI4NWU1ZTI4ZmYwYWI3MWM5DQpTaWduZWQtb2ZmLWJ5OiBZb25n
cWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIC4uLi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZGlzcC50eHQgfCAxNCArKysr
KysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9t
ZWRpYXRlayxkaXNwLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNw
bGF5L21lZGlhdGVrL21lZGlhdGVrLGRpc3AudHh0DQppbmRleCBiOTFlNzA5Li5lNmJiZTMyIDEw
MDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVk
aWF0ZWsvbWVkaWF0ZWssZGlzcC50eHQNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRpc3AudHh0DQpAQCAtNjYsNiArNjYs
MTEgQEAgUmVxdWlyZWQgcHJvcGVydGllcyAoRE1BIGZ1bmN0aW9uIGJsb2Nrcyk6DQogICBhcmd1
bWVudCwgc2VlIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pb21tdS9tZWRpYXRl
ayxpb21tdS50eHQNCiAgIGZvciBkZXRhaWxzLg0KIA0KK09wdGlvbmFsIHByb3BlcnRpZXMgKFJE
TUEgZnVuY3Rpb24gYmxvY2tzKToNCistIG1lZGlhdGVrLHJkbWFfZmlmb19zaXplOiByZG1hIGZp
Zm8gc2l6ZSBtYXkgYmUgZGlmZmVyZW50IGV2ZW4gaW4gc2FtZSBTT0MsIGFkZCB0aGlzDQorICBw
cm9wZXJ0eSB0byB0aGUgY29ycmVzcG9uZGluZyByZG1hDQorICB0aGUgdmFsdWUgaXMgdGhlIE1h
eCB2YWx1ZSB3aGljaCBkZWZpbmVkIGluIGhhcmR3YXJlIGRhdGEgc2hlZXQuDQorDQogRXhhbXBs
ZXM6DQogDQogbW1zeXM6IGNsb2NrLWNvbnRyb2xsZXJAMTQwMDAwMDAgew0KQEAgLTIwNywzICsy
MTIsMTIgQEAgb2RAMTQwMjMwMDAgew0KIAlwb3dlci1kb21haW5zID0gPCZzY3BzeXMgTVQ4MTcz
X1BPV0VSX0RPTUFJTl9NTT47DQogCWNsb2NrcyA9IDwmbW1zeXMgQ0xLX01NX0RJU1BfT0Q+Ow0K
IH07DQorDQorcmRtYTE6IHJkbWFAMTQwMGMwMDAgew0KKwljb21wYXRpYmxlID0gIm1lZGlhdGVr
LG10ODE4My1kaXNwLXJkbWEiOw0KKwlyZWcgPSA8MCAweDE0MDBjMDAwIDAgMHgxMDAwPjsNCisJ
aW50ZXJydXB0cyA9IDxHSUNfU1BJIDIyOSBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KKwlwb3dlci1k
b21haW5zID0gPCZzY3BzeXMgTVQ4MTgzX1BPV0VSX0RPTUFJTl9ESVNQPjsNCisJY2xvY2tzID0g
PCZtbXN5cyBDTEtfTU1fRElTUF9SRE1BMT47DQorCW1lZGlhdGVrLHJkbWFfZmlmb19zaXplID0g
PDIwNDg+Ow0KK307DQotLSANCjEuOC4xLjEuZGlydHkNCg==

