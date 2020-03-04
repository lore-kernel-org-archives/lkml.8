Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50531C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2656F2166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PTg3iqb2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387972AbgCDLG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:06:27 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:51624 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387925AbgCDLG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 06:06:26 -0500
X-UUID: de92795c78f44d0abaa1953058caa7ee-20200304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=THhbz1tL3bdIddSTgCLGB9wEcIKzP7y2s4qGL9MX0uI=;
        b=PTg3iqb2eSyGq5qaCjAAHDvTZpmLncEqkJN827RDXfWG1jaNSuGGd+8JeyDjOEw/1Xt05EXJfxf+uWJT65ts6bu1RIIn5c/BgfSQ/aow+YlVkGdtTAkFSw1KwQ2I2+PkUkKiToKun1sFVB4TDolZIbM7OVgPqnYrVTa20CH+0AM=;
X-UUID: de92795c78f44d0abaa1953058caa7ee-20200304
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 417617908; Wed, 04 Mar 2020 19:06:19 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 4 Mar 2020 19:05:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 4 Mar 2020 19:06:17 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Sam Shih <sam.shih@mediatek.com>
Subject: [v3,1/2] dt-bindings: pwm: Update bindings for MT7629 SoC
Date:   Wed, 4 Mar 2020 19:06:12 +0800
Message-ID: <1583319973-20694-2-git-send-email-sam.shih@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1583319973-20694-1-git-send-email-sam.shih@mediatek.com>
References: <1583319973-20694-1-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyB1cGRhdGVzIGJpbmRpbmdzIGZvciBNVDc2MjkgcHdtIGNvbnRyb2xsZXIuDQoNClNpZ25l
ZC1vZmYtYnk6IFNhbSBTaGloIDxzYW0uc2hpaEBtZWRpYXRlay5jb20+DQotLS0NCiBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL3B3bS1tZWRpYXRlay50eHQgfCA1ICsrKysr
DQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9wd20tbWVkaWF0ZWsudHh0IGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9wd20tbWVkaWF0ZWsudHh0DQppbmRleCA5
NTUzNmQ4M2M1ZjIuLjI5YWRmZjU5YzQ3OSAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9wd20vcHdtLW1lZGlhdGVrLnR4dA0KKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9wd20tbWVkaWF0ZWsudHh0DQpAQCAtMTksMTAgKzE5
LDE1IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQogICAgLSAicHdtMS04IjogdGhlIGVpZ2h0IHBl
ciBQV00gY2xvY2tzIGZvciBtdDI3MTINCiAgICAtICJwd20xLTYiOiB0aGUgc2l4IHBlciBQV00g
Y2xvY2tzIGZvciBtdDc2MjINCiAgICAtICJwd20xLTUiOiB0aGUgZml2ZSBwZXIgUFdNIGNsb2Nr
cyBmb3IgbXQ3NjIzDQorICAgLSAicHdtMSIgIDogdGhlIFBXTTEgY2xvY2sgZm9yIG10NzYyOQ0K
ICAtIHBpbmN0cmwtbmFtZXM6IE11c3QgY29udGFpbiBhICJkZWZhdWx0IiBlbnRyeS4NCiAgLSBw
aW5jdHJsLTA6IE9uZSBwcm9wZXJ0eSBtdXN0IGV4aXN0IGZvciBlYWNoIGVudHJ5IGluIHBpbmN0
cmwtbmFtZXMuDQogICAgU2VlIHBpbmN0cmwvcGluY3RybC1iaW5kaW5ncy50eHQgZm9yIGRldGFp
bHMgb2YgdGhlIHByb3BlcnR5IHZhbHVlcy4NCiANCitPcHRpb25hbCBwcm9wZXJ0aWVzOg0KKy0g
YXNzaWduZWQtY2xvY2tzOiBSZWZlcmVuY2UgdG8gdGhlIFBXTSBjbG9jayBlbnRyaWVzLg0KKy0g
YXNzaWduZWQtY2xvY2stcGFyZW50czogVGhlIHBoYW5kbGUgb2YgdGhlIHBhcmVudCBjbG9jayBv
ZiBQV00gY2xvY2suDQorDQogRXhhbXBsZToNCiAJcHdtMDogcHdtQDExMDA2MDAwIHsNCiAJCWNv
bXBhdGlibGUgPSAibWVkaWF0ZWssbXQ3NjIzLXB3bSI7DQotLSANCjIuMTcuMQ0K

