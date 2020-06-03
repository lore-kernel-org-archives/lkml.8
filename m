Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9E3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 08:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B62FF20674
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 08:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EglGzROt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgFCIpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 04:45:32 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37350 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726243AbgFCIpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 04:45:32 -0400
X-UUID: f30f1bf5163c40d4b518c5f6d536a3c4-20200603
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=GqhgG6L1zGtST6u5yF493LQmjohmvvIpbn2zNdLG3lI=;
        b=EglGzROtLnjGP6UZ7vtLOLO5lL7jNEVYEoUCIoIuLfLHEOTqUvF9DjQG4pbPUSbhipRSvqUq/8y9yfbB3PixdysjiKhpCwP1Kc8RRtA3Om4bWvICDizKNaBk7433ramkhTVmPUezXbIx6d7GXgKnXMF0Pujhp2WqTGC92QMAMlc=;
X-UUID: f30f1bf5163c40d4b518c5f6d536a3c4-20200603
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1543401211; Wed, 03 Jun 2020 16:45:29 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs01n2.mediatek.inc
 (172.21.101.79) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Jun
 2020 16:45:26 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 3 Jun 2020 16:45:26 +0800
Message-ID: <1591173806.15527.1.camel@mhfsdcap03>
Subject: Re: [PATCH v2] usb: host: xhci-mtk: avoid runtime suspend when
 removing hcd
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Macpaul Lin <macpaul.lin@mediatek.com>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Date:   Wed, 3 Jun 2020 16:43:26 +0800
In-Reply-To: <1590726778-29065-1-git-send-email-macpaul.lin@mediatek.com>
References: <1590726569-28248-1-git-send-email-macpaul.lin@mediatek.com>
         <1590726778-29065-1-git-send-email-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: CA6D6B5CA1B57E8E80E8EA32F96818490747DA2EE90F21A39CF72B716572D3462000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTA1LTI5IGF0IDEyOjMyICswODAwLCBNYWNwYXVsIExpbiB3cm90ZToNCj4g
V2hlbiBydW50aW1lIHN1c3BlbmQgd2FzIGVuYWJsZWQsIHJ1bnRpbWUgc3VzcGVuZCBtaWdodCBo
YXBwZW5lZA0KPiB3aGVuIHhoY2kgaXMgcmVtb3ZpbmcgaGNkLiBUaGlzIG1pZ2h0IGNhdXNlIGtl
cm5lbCBwYW5pYyB3aGVuIGhjZA0KPiBoYXMgYmVlbiBmcmVlZCBidXQgcnVudGltZSBwbSBzdXNw
ZW5kIHJlbGF0ZWQgaGFuZGxlIG5lZWQgdG8NCj4gcmVmZXJlbmNlIGl0Lg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogTWFjcGF1bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMgfCAgICA1ICsrKy0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGsuYyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGsu
Yw0KPiBpbmRleCBiZmJkYjNjLi42NDFkMjRlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9o
b3N0L3hoY2ktbXRrLmMNCj4gKysrIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jDQo+IEBA
IC01ODcsNiArNTg3LDkgQEAgc3RhdGljIGludCB4aGNpX210a19yZW1vdmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqZGV2KQ0KPiAgCXN0cnVjdCB4aGNpX2hjZAkqeGhjaSA9IGhjZF90b194aGNp
KGhjZCk7DQo+ICAJc3RydWN0IHVzYl9oY2QgICpzaGFyZWRfaGNkID0geGhjaS0+c2hhcmVkX2hj
ZDsNCj4gIA0KPiArCXBtX3J1bnRpbWVfcHV0X3N5bmMoJmRldi0+ZGV2KTsNCj4gKwlwbV9ydW50
aW1lX2Rpc2FibGUoJmRldi0+ZGV2KTsNCj4gKw0KPiAgCXVzYl9yZW1vdmVfaGNkKHNoYXJlZF9o
Y2QpOw0KPiAgCXhoY2ktPnNoYXJlZF9oY2QgPSBOVUxMOw0KPiAgCWRldmljZV9pbml0X3dha2V1
cCgmZGV2LT5kZXYsIGZhbHNlKTsNCj4gQEAgLTU5Nyw4ICs2MDAsNiBAQCBzdGF0aWMgaW50IHho
Y2lfbXRrX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpkZXYpDQo+ICAJeGhjaV9tdGtf
c2NoX2V4aXQobXRrKTsNCj4gIAl4aGNpX210a19jbGtzX2Rpc2FibGUobXRrKTsNCj4gIAl4aGNp
X210a19sZG9zX2Rpc2FibGUobXRrKTsNCj4gLQlwbV9ydW50aW1lX3B1dF9zeW5jKCZkZXYtPmRl
dik7DQo+IC0JcG1fcnVudGltZV9kaXNhYmxlKCZkZXYtPmRldik7DQo+ICANCj4gIAlyZXR1cm4g
MDsNCj4gIH0NCg0KUmV2aWV3ZWQtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlh
dGVrLmNvbT4NCg0KVGhhbmtzDQoNCg0K

