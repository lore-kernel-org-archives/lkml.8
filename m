Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D518C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34016206EF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LjfOI6ky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbgIDDTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 23:19:19 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:59147 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729528AbgIDDTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 23:19:17 -0400
X-UUID: 2165b6289a7540eab6a08a50e1a2c698-20200904
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=81j54tuoiKV3uK8sKV8TMOkBCYp/9eQY2ZBo8fSyYog=;
        b=LjfOI6kypqLNZxiIZyol+4fjhvpGl8Y6+jlS1qBeFfioqww6ht3LMcW6FAoVjoTLy4UfGpeSXRGgXqJHpICjIpCTNKyyP8ZC/mOxC6/PNKQencmPY/RQgdyRTeX6exLWZV7RSMkV2EDPRO/ZbhEgJ0XS8zqSZCW4b7gpcTfOvI0=;
X-UUID: 2165b6289a7540eab6a08a50e1a2c698-20200904
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1556347710; Fri, 04 Sep 2020 11:19:11 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 4 Sep
 2020 11:19:09 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Sep 2020 11:19:08 +0800
Message-ID: <1599189448.11403.33.camel@mhfsdcap03>
Subject: Re: [PATCH v2 01/11] usb: gadget: bdc: fix improper SPDX comment
 style for header file
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Sasi Kumar <sasi.kumar@broadcom.com>,
        Peter Chen <peter.chen@nxp.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 4 Sep 2020 11:17:28 +0800
In-Reply-To: <1597923046-12535-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1597923046-12535-1-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 6437F811FE63FA34E3E573D3346DC7F53866220D91CCF2E752ABCF714B765FAD2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmxvcmlhbiwgDQoNCk9uIFRodSwgMjAyMC0wOC0yMCBhdCAxOTozMCArMDgwMCwgQ2h1bmZl
bmcgWXVuIHdyb3RlOg0KPiBGb3IgQyBoZWFkZXIgZmlsZXMgRG9jdW1lbnRhdGlvbi9wcm9jZXNz
L2xpY2Vuc2UtcnVsZXMucnN0DQo+IG1hbmRhdGVzIEMtbGlrZSBjb21tZW50cyAob3Bwb3NlZCB0
byBDIHNvdXJjZSBmaWxlcyB3aGVyZQ0KPiBDKysgc3R5bGUgc2hvdWxkIGJlIHVzZWQpLg0KPiAN
Cj4gQ2M6IEZsb3JpYW4gRmFpbmVsbGkgPGYuZmFpbmVsbGlAZ21haWwuY29tPg0KPiBTaWduZWQt
b2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+IC0tLQ0K
PiB2MjogYWRkIENjIEZsb3JpYW4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2Jk
Yy9iZGMuaCAgICAgfCAyICstDQo+ICBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfY21k
LmggfCAyICstDQo+ICBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZGJnLmggfCAyICst
DQo+ICBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZXAuaCAgfCAyICstDQo+ICA0IGZp
bGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGMuaCBiL2RyaXZlcnMvdXNiL2dh
ZGdldC91ZGMvYmRjL2JkYy5oDQo+IGluZGV4IGFjNzVlMjUuLmZjYmE3N2UgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkYy5oDQo+ICsrKyBiL2RyaXZlcnMvdXNi
L2dhZGdldC91ZGMvYmRjL2JkYy5oDQo+IEBAIC0xLDQgKzEsNCBAQA0KPiAtLy8gU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IEdQTC0yLjArDQo+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMCsgKi8NCj4gIC8qDQo+ICAgKiBiZGMuaCAtIGhlYWRlciBmb3IgdGhlIEJSQ00gQkRD
IFVTQjMuMCBkZXZpY2UgY29udHJvbGxlcg0KPiAgICoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dXNiL2dhZGdldC91ZGMvYmRjL2JkY19jbWQuaCBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRj
L2JkY19jbWQuaA0KPiBpbmRleCAyOWNjOTg4Li4zNzNlNjc0IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfY21kLmgNCj4gKysrIGIvZHJpdmVycy91c2IvZ2Fk
Z2V0L3VkYy9iZGMvYmRjX2NtZC5oDQo+IEBAIC0xLDQgKzEsNCBAQA0KPiAtLy8gU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IEdQTC0yLjArDQo+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMCsgKi8NCj4gIC8qDQo+ICAgKiBiZGNfY21kLmggLSBoZWFkZXIgZm9yIHRoZSBCREMg
ZGVidWcgZnVuY3Rpb25zDQo+ICAgKg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0
L3VkYy9iZGMvYmRjX2RiZy5oIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2RiZy5o
DQo+IGluZGV4IDM3M2Q1YWIuLjg1OWQ1ODggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2dh
ZGdldC91ZGMvYmRjL2JkY19kYmcuaA0KPiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2Jk
Yy9iZGNfZGJnLmgNCj4gQEAgLTEsNCArMSw0IEBADQo+IC0vLyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMCsNCj4gKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKyAq
Lw0KPiAgLyoNCj4gICAqIGJkY19kYmcuaCAtIGhlYWRlciBmb3IgdGhlIEJEQyBkZWJ1ZyBmdW5j
dGlvbnMNCj4gICAqDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9i
ZGNfZXAuaCBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19lcC5oDQo+IGluZGV4IGEz
N2ZmODAzLi41YmJkNzNmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2Jk
Yy9iZGNfZXAuaA0KPiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZXAuaA0K
PiBAQCAtMSw0ICsxLDQgQEANCj4gLS8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
Kw0KPiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArICovDQo+ICAvKg0KPiAg
ICogYmRjX2VwLmggLSBoZWFkZXIgZm9yIHRoZSBCREMgZGVidWcgZnVuY3Rpb25zDQo+ICAgKg0K
V291bGQgeW91IHBsZWFzZSB0YWtlIGEgbG9vayBhdCB0aGlzIHNlcmllcz8NCkknbGwgZHJvcCB0
aGUgcGF0Y2hlcyB0aGF0IG5vdCBmaW5lIHdpdGggeW91Lg0KVGhhbmtzDQoNCg0K

