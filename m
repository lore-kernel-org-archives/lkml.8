Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E04C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 05:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47EC124656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 05:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kK6Upe17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgAOFpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 00:45:15 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:24311 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725962AbgAOFpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 00:45:15 -0500
X-UUID: af08cae34b5344989e0ea1f9bb71e9e4-20200115
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=8HQMlldpfzphe6qDYQf4mrwDoRiBfm5R7hxsF+yJmA4=;
        b=kK6Upe17zxY6wWyy9So/d2R+fPk1Uv6p8do16Gx+FZCDZGKUWkkrXgnFNCoTiyqOSRD6o0l4vI51z5vWOph8ARie6wSSxQgDMTeftcTRREvpF7RorFULXaR7ypf5DhlLE4TovyYlMu+x8JPsc77kPX6Jc5GQ3ZS8mjScqoOAzbQ=;
X-UUID: af08cae34b5344989e0ea1f9bb71e9e4-20200115
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1503722145; Wed, 15 Jan 2020 13:45:08 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 15 Jan 2020 13:44:03 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 15 Jan 2020 13:45:15 +0800
Message-ID: <1579067107.32486.6.camel@mtksdaap41>
Subject: Re: [PATCH v11 01/10] dt-bindings: mediatek: Add property to mt8183
 smi-common
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Date:   Wed, 15 Jan 2020 13:45:07 +0800
In-Reply-To: <1576813564-23927-2-git-send-email-weiyi.lu@mediatek.com>
References: <1576813564-23927-1-git-send-email-weiyi.lu@mediatek.com>
         <1576813564-23927-2-git-send-email-weiyi.lu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTEyLTIwIGF0IDExOjQ1ICswODAwLCBXZWl5aSBMdSB3cm90ZToNCj4gRm9y
IHNjcHN5cyBkcml2ZXIgdXNpbmcgcmVnbWFwIGJhc2VkIHN5c2NvbiBkcml2ZXIgQVBJLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogV2VpeWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCj4gLS0t
DQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tZW1vcnktY29udHJvbGxlcnMvbWVkaWF0ZWss
c21pLWNvbW1vbi50eHQgICAgICB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9tZW1vcnktY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWNvbW1vbi50
eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJz
L21lZGlhdGVrLHNtaS1jb21tb24udHh0DQo+IGluZGV4IGI0NzhhZGUuLjAxNzQ0ZWMgMTAwNjQ0
DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZW1vcnktY29udHJv
bGxlcnMvbWVkaWF0ZWssc21pLWNvbW1vbi50eHQNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktY29tbW9uLnR4
dA0KPiBAQCAtMjAsNyArMjAsNyBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiAgCSJtZWRpYXRl
ayxtdDI3MTItc21pLWNvbW1vbiINCj4gIAkibWVkaWF0ZWssbXQ3NjIzLXNtaS1jb21tb24iLCAi
bWVkaWF0ZWssbXQyNzAxLXNtaS1jb21tb24iDQo+ICAJIm1lZGlhdGVrLG10ODE3My1zbWktY29t
bW9uIg0KPiAtCSJtZWRpYXRlayxtdDgxODMtc21pLWNvbW1vbiINCj4gKwkibWVkaWF0ZWssbXQ4
MTgzLXNtaS1jb21tb24iLCAic3lzY29uIg0KPiAgLSByZWcgOiB0aGUgcmVnaXN0ZXIgYW5kIHNp
emUgb2YgdGhlIFNNSSBibG9jay4NCj4gIC0gcG93ZXItZG9tYWlucyA6IGEgcGhhbmRsZSB0byB0
aGUgcG93ZXIgZG9tYWluIG9mIHRoaXMgbG9jYWwgYXJiaXRlci4NCj4gIC0gY2xvY2tzIDogTXVz
dCBjb250YWluIGFuIGVudHJ5IGZvciBlYWNoIGVudHJ5IGluIGNsb2NrLW5hbWVzLg0KDQpIaSBN
YXR0aGlhcywNCg0KRm9yIHRoZSBwcmVwYXJhdGlvbiBvZiB2MTIsIG1heSBJIGhhdmUgeW91ciBj
b21tZW50cyBvbiB0aGlzIHYxMQ0Kc2VyaWVzID8NCk1hbnkgdGhhbmtzLg0K

