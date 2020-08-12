Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B07C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 01:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 692B02076C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 01:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fNwu8mbE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgHLB2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 21:28:39 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:1655 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726143AbgHLB2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 21:28:37 -0400
X-UUID: 33676643d9964419b8fabf34a501bbcb-20200812
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=PSmyy6RB68QIlyE2RdAZ/dLjGNAiqe5NS8RADOChyZA=;
        b=fNwu8mbEg/qvYXZ5W4yLrDB3JRk9UrylJwK4a2Ndk1tRRyy9vc1TilzsGdfOo/yEDL+Mw/FcfViBbsvb5syxTUFTlvhrujiZ98cZDHXUFFpG0uv+b8vxp3kDp/oUrnAaxl/VzCqrO1Znws+4rLUtIpOuuC7gixIbH633iqgRVnU=;
X-UUID: 33676643d9964419b8fabf34a501bbcb-20200812
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1445121796; Wed, 12 Aug 2020 09:28:26 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 12 Aug
 2020 09:28:19 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 12 Aug 2020 09:28:14 +0800
Message-ID: <1597195610.21478.10.camel@mhfsdcap03>
Subject: Re: [PATCH] usb: xhci-mtk: Fix typo
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Frank Wunderlich <linux@fw-web.de>
CC:     <linux-mediatek@lists.infradead.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Wed, 12 Aug 2020 09:26:50 +0800
In-Reply-To: <20200808124906.89976-1-linux@fw-web.de>
References: <20200808124906.89976-1-linux@fw-web.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 0D2B0029EF119CD7EB5464ABFEF244164C84DA1B3C0330CEACF56DF3E90248D72000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIwLTA4LTA4IGF0IDE0OjQ5ICswMjAwLCBGcmFuayBXdW5kZXJsaWNoIHdyb3Rl
Og0KPiBGcm9tOiBGcmFuayBXdW5kZXJsaWNoIDxmcmFuay13QHB1YmxpYy1maWxlcy5kZT4NCj4g
DQo+IGZpeCB0aGlzIHNtYWxsIHR5cG8gdTNfcG9ydHNfZGlzYWJlZCA9PiB1M19wb3J0c19kaXNh
YmxlZA0KPiANCj4gRml4ZXM6IDU1YmE2ZTllMjVhNiAodXNiOiB4aGNpLW10azogc3VwcG9ydCBv
cHRpb24gdG8gZGlzYWJsZSB1c2IzIHBvcnRzKQ0KPiBTaWduZWQtb2ZmLWJ5OiBGcmFuayBXdW5k
ZXJsaWNoIDxmcmFuay13QHB1YmxpYy1maWxlcy5kZT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9o
b3N0L3hoY2ktbXRrLmMgfCA2ICsrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0
L3hoY2ktbXRrLmMgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMNCj4gaW5kZXggNDMxMWQ0
YzliNjhkLi44ZjMyMWYzOWFiOTYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2hvc3QveGhj
aS1tdGsuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMNCj4gQEAgLTc3LDcg
Kzc3LDcgQEAgc3RhdGljIGludCB4aGNpX210a19ob3N0X2VuYWJsZShzdHJ1Y3QgeGhjaV9oY2Rf
bXRrICptdGspDQo+ICB7DQo+ICAJc3RydWN0IG11M2NfaXBwY19yZWdzIF9faW9tZW0gKmlwcGMg
PSBtdGstPmlwcGNfcmVnczsNCj4gIAl1MzIgdmFsdWUsIGNoZWNrX3ZhbDsNCj4gLQlpbnQgdTNf
cG9ydHNfZGlzYWJlZCA9IDA7DQo+ICsJaW50IHUzX3BvcnRzX2Rpc2FibGVkID0gMDsNCj4gIAlp
bnQgcmV0Ow0KPiAgCWludCBpOw0KPiAgDQo+IEBAIC05Miw3ICs5Miw3IEBAIHN0YXRpYyBpbnQg
eGhjaV9tdGtfaG9zdF9lbmFibGUoc3RydWN0IHhoY2lfaGNkX210ayAqbXRrKQ0KPiAgCS8qIHBv
d2VyIG9uIGFuZCBlbmFibGUgdTMgcG9ydHMgZXhjZXB0IHNraXBwZWQgb25lcyAqLw0KPiAgCWZv
ciAoaSA9IDA7IGkgPCBtdGstPm51bV91M19wb3J0czsgaSsrKSB7DQo+ICAJCWlmICgoMHgxIDw8
IGkpICYgbXRrLT51M3BfZGlzX21zaykgew0KPiAtCQkJdTNfcG9ydHNfZGlzYWJlZCsrOw0KPiAr
CQkJdTNfcG9ydHNfZGlzYWJsZWQrKzsNCj4gIAkJCWNvbnRpbnVlOw0KPiAgCQl9DQo+ICANCj4g
QEAgLTExNyw3ICsxMTcsNyBAQCBzdGF0aWMgaW50IHhoY2lfbXRrX2hvc3RfZW5hYmxlKHN0cnVj
dCB4aGNpX2hjZF9tdGsgKm10aykNCj4gIAljaGVja192YWwgPSBTVFMxX1NZU1BMTF9TVEFCTEUg
fCBTVFMxX1JFRl9SU1QgfA0KPiAgCQkJU1RTMV9TWVMxMjVfUlNUIHwgU1RTMV9YSENJX1JTVDsN
Cj4gIA0KPiAtCWlmIChtdGstPm51bV91M19wb3J0cyA+IHUzX3BvcnRzX2Rpc2FiZWQpDQo+ICsJ
aWYgKG10ay0+bnVtX3UzX3BvcnRzID4gdTNfcG9ydHNfZGlzYWJsZWQpDQo+ICAJCWNoZWNrX3Zh
bCB8PSBTVFMxX1UzX01BQ19SU1Q7DQo+ICANCj4gIAlyZXQgPSByZWFkbF9wb2xsX3RpbWVvdXQo
JmlwcGMtPmlwX3B3X3N0czEsIHZhbHVlLA0KDQpSZXZpZXdlZC1ieTogQ2h1bmZlbmcgWXVuIDxj
aHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KDQpUaGFua3MNCg0KDQo=

