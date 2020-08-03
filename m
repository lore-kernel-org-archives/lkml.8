Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04B6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 04:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CE672075A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 04:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LKG2P4md"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgHCEFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 00:05:54 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:58769 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725268AbgHCEFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 00:05:53 -0400
X-UUID: 7d0932c1e96b4d15a639ca4001679444-20200803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Zgi3EbJa/AeWx8xMnAPwVqIIwAidH8IpACy77bhI1VI=;
        b=LKG2P4mdp9x4iZWjhLakvUIF/fYH5wLLS2tk+IuIQyxA3lRAMQT0VXEb3EOdRKdD6m669uGwaE1VAXQiQl43h4VOV3Dh8u8MBe3EZQZfE0hH0DpNQ2/kQtACaD0BkqfUnA/lm8MHMRDqF9cZC2InJ2kn0apILyPbBfxf3Qg6VSQ=;
X-UUID: 7d0932c1e96b4d15a639ca4001679444-20200803
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1739982859; Mon, 03 Aug 2020 12:05:48 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 3 Aug 2020 12:05:45 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 3 Aug 2020 12:05:46 +0800
Message-ID: <1596427546.22971.23.camel@mtkswgap22>
Subject: Re: [PATCH v4 2/2] soc: mediatek: add mtk-devapc driver
From:   Neal Liu <neal.liu@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Neal Liu <neal.liu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 3 Aug 2020 12:05:46 +0800
In-Reply-To: <CAAOTY_-RMT-1+-5aPxqhgLbk74j0MH8U78mibBZppt_OPPQrJA@mail.gmail.com>
References: <1596010690-13178-1-git-send-email-neal.liu@mediatek.com>
         <1596010690-13178-3-git-send-email-neal.liu@mediatek.com>
         <CAAOTY_-RMT-1+-5aPxqhgLbk74j0MH8U78mibBZppt_OPPQrJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2h1bi1LdWFuZywNCg0KT24gU3VuLCAyMDIwLTA4LTAyIGF0IDA3OjUwICswODAwLCBDaHVu
LUt1YW5nIEh1IHdyb3RlOg0KPiBIaSwgTmVhbDoNCj4gDQo+IE5lYWwgTGl1IDxuZWFsLmxpdUBt
ZWRpYXRlay5jb20+IOaWvCAyMDIw5bm0N+aciDI55pelIOmAseS4iSDkuIvljYg0OjI55a+r6YGT
77yaDQo+ID4NCj4gPiBNZWRpYVRlayBidXMgZmFicmljIHByb3ZpZGVzIFRydXN0Wm9uZSBzZWN1
cml0eSBzdXBwb3J0IGFuZCBkYXRhDQo+ID4gcHJvdGVjdGlvbiB0byBwcmV2ZW50IHNsYXZlcyBm
cm9tIGJlaW5nIGFjY2Vzc2VkIGJ5IHVuZXhwZWN0ZWQNCj4gPiBtYXN0ZXJzLg0KPiA+IFRoZSBz
ZWN1cml0eSB2aW9sYXRpb24gaXMgbG9nZ2VkIGFuZCBzZW50IHRvIHRoZSBwcm9jZXNzb3IgZm9y
DQo+ID4gZnVydGhlciBhbmFseXNpcyBvciBjb3VudGVybWVhc3VyZXMuDQo+ID4NCj4gPiBBbnkg
b2NjdXJyZW5jZSBvZiBzZWN1cml0eSB2aW9sYXRpb24gd291bGQgcmFpc2UgYW4gaW50ZXJydXB0
LCBhbmQNCj4gPiBpdCB3aWxsIGJlIGhhbmRsZWQgYnkgbXRrLWRldmFwYyBkcml2ZXIuIFRoZSB2
aW9sYXRpb24NCj4gPiBpbmZvcm1hdGlvbiBpcyBwcmludGVkIGluIG9yZGVyIHRvIGZpbmQgdGhl
IG11cmRlcmVyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTmVhbCBMaXUgPG5lYWwubGl1QG1l
ZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gDQo+IFtzbmlwXQ0KPiANCj4gPiArDQo+ID4gK3N0cnVj
dCBtdGtfZGV2YXBjX2NvbnRleHQgew0KPiA+ICsgICAgICAgc3RydWN0IGRldmljZSAqZGV2Ow0K
PiA+ICsgICAgICAgdTMyIHZpb19pZHhfbnVtOw0KPiA+ICsgICAgICAgdm9pZCBfX2lvbWVtICpk
ZXZhcGNfcGRfYmFzZTsNCj4gDQo+IFRoaXMgaXMgZGV2YXBjIGNvbnRleHQsIHNvIHByZWZpeCAn
ZGV2YXBjJyBpcyByZWR1bmRhbnQuDQo+IEFuZCwgd2hhdCBkb2VzICdwZCcgbWVhbj8NCg0KJ3Bk
JyBtZWFucyBwb3dlciBkb3duLiBPZiBjb3Vyc2Ugd2Ugd291bGQgYWxzbyByZW1vdmUgaXQgYXMg
d2VsbC4NCkkgc3VnZ2VzdCB0byBjaGFuZ2UgaXQgYXMgJ2luZnJhX2Jhc2UnLg0KDQo+IA0KPiBS
ZWdhcmRzLA0KPiBDaHVuLUt1YW5nLg0KPiANCj4gPiArICAgICAgIHN0cnVjdCBtdGtfZGV2YXBj
X3Zpb19pbmZvICp2aW9faW5mbzsNCj4gPiArICAgICAgIGNvbnN0IHN0cnVjdCBtdGtfZGV2YXBj
X3BkX29mZnNldCAqb2Zmc2V0Ow0KPiA+ICsgICAgICAgY29uc3Qgc3RydWN0IG10a19kZXZhcGNf
dmlvX2RiZ3MgKnZpb19kYmdzOw0KPiA+ICt9Ow0KPiA+ICsNCg0K

