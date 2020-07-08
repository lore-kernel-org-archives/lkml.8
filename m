Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B84C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A40272067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sG6bN2pE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbgGHH1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:27:48 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:64452 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729471AbgGHH1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:27:48 -0400
X-UUID: 940e5fced38c4a39a6114dc6aecae28e-20200708
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=eL3lgx8YILsDyHzj4UM7ymN5RgGxS7otNYsWxv/+afc=;
        b=sG6bN2pE8uNxnFmh9fBWTZAWITKicz+dLC5YND7/csf+FJVZWAxM41GizjkI2WkaYYrYMivN6YSr8o2UcFRzmzCq0rcrxHyKnxBAgMrqzCrV5Ko8hmm7zJvzsRuR9uOhgPWEnr6eBTYvIYNZBIFQngbNVAIfBKTD7UPdWA7gArw=;
X-UUID: 940e5fced38c4a39a6114dc6aecae28e-20200708
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1304503638; Wed, 08 Jul 2020 15:27:42 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Jul 2020 15:27:35 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 8 Jul 2020 15:27:36 +0800
Message-ID: <1594193257.21095.0.camel@mtksdaap41>
Subject: Re: [PATCH v3 1/9] soc: mediatek: cmdq: add address shift in jump
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>
Date:   Wed, 8 Jul 2020 15:27:37 +0800
In-Reply-To: <1594136714-11650-2-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1594136714-11650-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1594136714-11650-2-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: CB4E59DADC0BE1E85780C93DA1D761BB1D861C4286F724D519190AE4CC4AFEF22000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV2aWV3ZWQtYnk6IEJpYmJ5IEhzaWVoIDxiaWJieS5oc2llaEBtZWRpYXRlay5jb20+DQoNCg0K
T24gVHVlLCAyMDIwLTA3LTA3IGF0IDIzOjQ1ICswODAwLCBEZW5uaXMgWUMgSHNpZWggd3JvdGU6
DQo+IEFkZCBhZGRyZXNzIHNoaWZ0IHdoZW4gY29tcG9zZSBqdW1wIGluc3RydWN0aW9uDQo+IHRv
IGNvbXBhdGlibGUgd2l0aCAzNWJpdCBmb3JtYXQuDQo+IA0KPiBDaGFuZ2Ugc2luY2UgdjE6DQo+
IC0gUmVuYW1lIGNtZHFfbWJveF9zaGlmdCgpIHRvIGNtZHFfZ2V0X3NoaWZ0X3BhKCkuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRl
ay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMg
fCAgICAzICsrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhl
bHBlci5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gaW5kZXgg
ZGM2NDRjZmI2NDE5Li45ZmFmNzhmYmVkM2EgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc29jL21l
ZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210
ay1jbWRxLWhlbHBlci5jDQo+IEBAIC0zMjksNyArMzI5LDggQEAgaW50IGNtZHFfcGt0X2ZpbmFs
aXplKHN0cnVjdCBjbWRxX3BrdCAqcGt0KQ0KPiAgDQo+ICAJLyogSlVNUCB0byBlbmQgKi8NCj4g
IAlpbnN0Lm9wID0gQ01EUV9DT0RFX0pVTVA7DQo+IC0JaW5zdC52YWx1ZSA9IENNRFFfSlVNUF9Q
QVNTOw0KPiArCWluc3QudmFsdWUgPSBDTURRX0pVTVBfUEFTUyA+Pg0KPiArCQljbWRxX2dldF9z
aGlmdF9wYSgoKHN0cnVjdCBjbWRxX2NsaWVudCAqKXBrdC0+Y2wpLT5jaGFuKTsNCj4gIAllcnIg
PSBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KPiAgDQo+ICAJcmV0dXJuIGVy
cjsNCg0K

