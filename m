Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C2AC10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 07:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4302E2072A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 07:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TvTU+oyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgCIHzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 03:55:45 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:59946 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725942AbgCIHzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 03:55:45 -0400
X-UUID: 7119ba7b7a6e46bcb84bdaed4b5b366d-20200309
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=d0wnLlS3PKlRwicESnqS4F2qX7BxraxwO4F/6cuzvFM=;
        b=TvTU+oyqCuvB/dpVbfvu0kKeOdvaGuR0TXe4LK1eGwi+8IKZUxta4cn+iy/5g+zeKnkRjwu+zxKtOpDKhPOj8g83vj3cYLKgXzbFFMCAWt7WKoAAPWeeqSD4hxIZdJM8Dz8JxsMHj2HNr8FsY6UMor/pZY3sCobhsi8+7X0TdxI=;
X-UUID: 7119ba7b7a6e46bcb84bdaed4b5b366d-20200309
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <nick.fan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1475847732; Mon, 09 Mar 2020 15:55:40 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 9 Mar 2020 15:54:27 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 9 Mar 2020 15:55:55 +0800
Message-ID: <1583740539.3995.15.camel@mtksdaap41>
Subject: Re: [PATCH v4 1/7] dt-bindings: gpu: mali-bifrost: Add Mediatek
 MT8183
From:   Nick Fan <nick.fan@mediatek.com>
To:     Steven Price <steven.price@arm.com>
CC:     Rob Herring <robh@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Sj Huang <sj.huang@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 9 Mar 2020 15:55:39 +0800
In-Reply-To: <20200306144336.GA9234@arm.com>
References: <20200207052627.130118-1-drinkcat@chromium.org>
         <20200207052627.130118-2-drinkcat@chromium.org>
         <20200225171613.GA7063@bogus>
         <CANMq1KAVX4o5yC7c_88Wq_O=F+MaSN_V4uNcs1nzS3wBS6A5AA@mail.gmail.com>
         <1583462055.4947.6.camel@mtksdaap41>
         <CAL_JsqLoUnxfrJh0WCs0jgro1KHAjWaYMsaKkKfAKA2KJ252_g@mail.gmail.com>
         <20200306144336.GA9234@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTAzLTA2IGF0IDE0OjQzICswMDAwLCBTdGV2ZW4gUHJpY2Ugd3JvdGU6DQo+
IE9uIEZyaSwgTWFyIDA2LCAyMDIwIGF0IDAyOjEzOjA4UE0gKzAwMDAsIFJvYiBIZXJyaW5nIHdy
b3RlOg0KPiA+IE9uIFRodSwgTWFyIDUsIDIwMjAgYXQgODozNCBQTSBOaWNrIEZhbiA8bmljay5m
YW5AbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBTb3JyeSBmb3IgbXkgbGF0ZSBy
ZXBseS4NCj4gPiA+IEkgaGF2ZSBjaGVja2VkIGludGVybmFsbHkuDQo+ID4gPiBUaGUgTVQ4MTgz
X1BPV0VSX0RPTUFJTl9NRkdfMkQgaXMganVzdCBhIGxlZ2FjeSBuYW1lLCBub3QgcmVhbGx5IDJE
DQo+ID4gPiBkb21haW4uDQo+ID4gPg0KPiA+ID4gSWYgdGhlIG5hbWluZyB0b28gY29uZnVzaW5n
LCB3ZSBjYW4gY2hhbmdlIHRoaXMgbmFtZSB0bw0KPiA+ID4gTVQ4MTgzX1BPV0VSX0RPTUFJTl9N
RkdfQ09SRTIgZm9yIGNvbnNpc3RlbmN5Lg0KPiA+IA0KPiA+IENhbiB5b3UgY2xhcmlmeSB3aGF0
J3MgaW4gZWFjaCBkb21haW4/IEFyZSB0aGVyZSBhY3R1YWxseSAzIHNoYWRlcg0KPiA+IGNvcmVz
IChJSVJDLCB0aGF0IHNob3VsZCBiZSBkaXNjb3ZlcmFibGUpPw0KPiANCj4gVGhlIGNvdmVyIGxl
dHRlciBmcm9tIE5pY29sYXMgaW5jbHVkZXM6DQo+IA0KPiA+IFsgIDUwMS4zMjE3NTJdIHBhbmZy
b3N0IDEzMDQwMDAwLmdwdTogc2hhZGVyX3ByZXNlbnQ9MHg3IGwyX3ByZXNlbnQ9MHgxDQo+IA0K
PiAweDcgaXMgdGhyZWUgYml0cyBzZXQsIHNvIGl0IGNlcnRhaW5seSBsb29rcyBsaWtlIHRoZXJl
IGFyZSAzIHNoYWRlcg0KPiBjb3Jlcy4gT2YgY291cnNlIEkgd291bGRuJ3QgZ3VhcmFudGVlIHRo
YXQgaXQgaXMgYXMgc2ltcGxlIGFzIGVhY2ggcG93ZXINCj4gZG9tYWluIGhhcyBhIHNoYWRlciBj
b3JlIGluLiBUaGUgam9iIG1hbmFnZXIgYW5kIHRpbGVyIGFsc28gbmVlZCB0byBiZQ0KPiBwb3dl
cmVkIHNvbWVob3csIHNvIHRoZXkgYXJlIGVpdGhlciBzaGFyaW5nIHdpdGggYSBzaGFkZXIgY29y
ZSBvcg0KPiB0aGVyZSdzIHNvbWV0aGluZyBtb3JlIGNvbXBsZXggZ29pbmcgb24uDQo+IA0KPiBT
dGV2ZQ0KPiANClRoZXJlIGFyZSBhY3R1YWxseSBmaXZlIHBvd2VyIGRvbWFpbnMgaW4gdG90YWwg
Zm9yIE1UODE4MyBHUFUuDQoNClRoZXJlIGFyZSAzIHNoYWRlciBjb3JlcyBpbiBNVDgxODMuDQoN
ClRoZXkgY2FuIGJlIGxpc3RlZCBhcyBmb2xsb3dpbmcgZm9yIGVhY2ggcG93ZXIgZG9tYWluOg0K
MS5NVDgxODNfUE9XRVJfRE9NQUlOX01GR19BU1lOQyA6IFNPQyBidXMgbG9naWMNCjIuTVQ4MTgz
X1BPV0VSX0RPTUFJTl9NRkcgOiBHUFUgam9iIG1hbmFnZXIgJiB0aWxlcg0KMy5NVDgxODNfUE9X
RVJfRE9NQUlOX01GR19DT1JFMCA6IEdQVSBzaGFkZXIgY29yZSAwDQo0Lk1UODE4M19QT1dFUl9E
T01BSU5fTUZHX0NPUkUxIDogR1BVIHNoYWRlciBjb3JlIDENCjUuTVQ4MTgzX1BPV0VSX0RPTUFJ
Tl9NRkdfMkQgOiBHUFUgc2hhZGVyIGNvcmUgMg0KDQpUaGVyZSBhcmUgb3RoZXIgcG93ZXIgZG9t
YWluIGRlcGVuZGVuY3kgY2FuIGJlIHJlZmVyZW5jZSBpbiB0aGUNCmZvbGxvd2luZyBsaW5rLg0K
aHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTkvMi8xLzE2Ng0KDQpZb3UgY2FuIGNoZWNrIHRoZSBw
b3dlciBkb21haW4gZGVwZW5kZW5jaWVzIGFzIGZvbGxvd2luZw0KPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KK3N0YXRpYyBjb25zdCBz
dHJ1Y3Qgc2NwX3N1YmRvbWFpbiBzY3Bfc3ViZG9tYWluX210ODE4M1tdID0gew0KKwl7TVQ4MTgz
X1BPV0VSX0RPTUFJTl9NRkdfQVNZTkMsIE1UODE4M19QT1dFUl9ET01BSU5fTUZHfSwNCisJe01U
ODE4M19QT1dFUl9ET01BSU5fTUZHLCBNVDgxODNfUE9XRVJfRE9NQUlOX01GR18yRH0sDQorCXtN
VDgxODNfUE9XRVJfRE9NQUlOX01GRywgTVQ4MTgzX1BPV0VSX0RPTUFJTl9NRkdfQ09SRTB9LA0K
Kwl7TVQ4MTgzX1BPV0VSX0RPTUFJTl9NRkcsIE1UODE4M19QT1dFUl9ET01BSU5fTUZHX0NPUkUx
fSwNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0NCg0KVGhhbmtzDQoNCk5pY2sgRmFuDQoNCg==

