Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981C3C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 02:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7858020781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 02:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sch7VqGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387717AbgGWCEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 22:04:53 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:55301 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731394AbgGWCEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 22:04:53 -0400
X-UUID: 641367f7ea784b4dae7bdea4b1a5d0f8-20200723
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=f9uHD6HYy4iSiAP99WQJ87QL/uY1LbOKvqvjNzR8NBw=;
        b=sch7VqGl0W4baD3IEPwq+Eb64gtKhyNYHqEvnVX3MmeFdLJq8Nlu3x/Qn9SDWgXohiNzxFfulN2qqbt5rEN52ZDnGF6D6YWCV8v29qV4k6DOOtGiO2ZU+LuMNDN86Yuj+6IFBJEczlDui+5TXrsnIF+WP/H7h6q9hzzXF7TypGo=;
X-UUID: 641367f7ea784b4dae7bdea4b1a5d0f8-20200723
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1360072356; Thu, 23 Jul 2020 10:04:51 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Jul 2020 10:04:50 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Jul 2020 10:04:46 +0800
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
Subject: [v7, PATCH 4/7] dt-bindings: mediatek: add rdma_fifo_size description for mt8183 display
Date:   Thu, 23 Jul 2020 10:03:15 +0800
Message-ID: <1595469798-3824-5-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1595469798-3824-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1595469798-3824-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXBkYXRlIGRldmljZSB0cmVlIGJpbmRpbmcgZG9jdW1lbnQgZm9yIHJkbWFfZmlmb19zaXplDQoN
ClNpZ25lZC1vZmYtYnk6IFlvbmdxaWFuZyBOaXUgPHlvbmdxaWFuZy5uaXVAbWVkaWF0ZWsuY29t
Pg0KLS0tDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRl
ayxkaXNwLnR4dCB8IDE0ICsrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDE0IGluc2Vy
dGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRpc3AudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZGlzcC50eHQNCmluZGV4
IGI5MWU3MDkuLmU2YmJlMzIgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkaXNwLnR4dA0KKysrIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZGlz
cC50eHQNCkBAIC02Niw2ICs2NiwxMSBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzIChETUEgZnVuY3Rp
b24gYmxvY2tzKToNCiAgIGFyZ3VtZW50LCBzZWUgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2lvbW11L21lZGlhdGVrLGlvbW11LnR4dA0KICAgZm9yIGRldGFpbHMuDQogDQorT3B0
aW9uYWwgcHJvcGVydGllcyAoUkRNQSBmdW5jdGlvbiBibG9ja3MpOg0KKy0gbWVkaWF0ZWsscmRt
YV9maWZvX3NpemU6IHJkbWEgZmlmbyBzaXplIG1heSBiZSBkaWZmZXJlbnQgZXZlbiBpbiBzYW1l
IFNPQywgYWRkIHRoaXMNCisgIHByb3BlcnR5IHRvIHRoZSBjb3JyZXNwb25kaW5nIHJkbWENCisg
IHRoZSB2YWx1ZSBpcyB0aGUgTWF4IHZhbHVlIHdoaWNoIGRlZmluZWQgaW4gaGFyZHdhcmUgZGF0
YSBzaGVldC4NCisNCiBFeGFtcGxlczoNCiANCiBtbXN5czogY2xvY2stY29udHJvbGxlckAxNDAw
MDAwMCB7DQpAQCAtMjA3LDMgKzIxMiwxMiBAQCBvZEAxNDAyMzAwMCB7DQogCXBvd2VyLWRvbWFp
bnMgPSA8JnNjcHN5cyBNVDgxNzNfUE9XRVJfRE9NQUlOX01NPjsNCiAJY2xvY2tzID0gPCZtbXN5
cyBDTEtfTU1fRElTUF9PRD47DQogfTsNCisNCityZG1hMTogcmRtYUAxNDAwYzAwMCB7DQorCWNv
bXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLWRpc3AtcmRtYSI7DQorCXJlZyA9IDwwIDB4MTQw
MGMwMDAgMCAweDEwMDA+Ow0KKwlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMjI5IElSUV9UWVBFX0xF
VkVMX0xPVz47DQorCXBvd2VyLWRvbWFpbnMgPSA8JnNjcHN5cyBNVDgxODNfUE9XRVJfRE9NQUlO
X0RJU1A+Ow0KKwljbG9ja3MgPSA8Jm1tc3lzIENMS19NTV9ESVNQX1JETUExPjsNCisJbWVkaWF0
ZWsscmRtYV9maWZvX3NpemUgPSA8MjA0OD47DQorfTsNCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

