Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D8AC3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 06:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C293206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 06:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QqKpIGph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgBLGIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 01:08:46 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:59215 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725887AbgBLGIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 01:08:46 -0500
X-UUID: 84c92f6bafd04e06bc906fd0e676de58-20200212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=SWD5TohyT5cMPrdmmo17mXTsqaC7XRDeHZDf6wxl7cY=;
        b=QqKpIGphIjGohnCyD8IAS+Rvhp6QiGtoKfw21hkpiSgyk0/ISqf3VfrZaZ0I6USNo/u1GDfCNekz+hx3EDXSorL0F2XISXUewfRUb/mRQ2mdNoeFC+kjaX+gkfWQVISej/+WmlJL94L75bGKmyFJ+VvlCm/JQ42qz88verQ3d2c=;
X-UUID: 84c92f6bafd04e06bc906fd0e676de58-20200212
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <wen.su@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 208193523; Wed, 12 Feb 2020 14:08:42 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 12 Feb 2020 14:07:53 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 12 Feb 2020 14:08:49 +0800
Message-ID: <1581487721.16783.9.camel@mtkswgap22>
Subject: Re: [PATCH v2 1/4] dt-bindings: regulator: Add document for MT6359
 regulator
From:   Wen Su <Wen.Su@mediatek.com>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Mark Rutland <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 12 Feb 2020 14:08:41 +0800
In-Reply-To: <8398188f-820a-5abf-f52e-b79c0c583704@gmail.com>
References: <1580958411-2478-1-git-send-email-Wen.Su@mediatek.com>
         <1580958411-2478-2-git-send-email-Wen.Su@mediatek.com>
         <20200206114927.GN3897@sirena.org.uk> <1581335854.16783.1.camel@mtkswgap22>
         <8398188f-820a-5abf-f52e-b79c0c583704@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIA0KDQpPbiBUdWUsIDIwMjAtMDItMTEgYXQgMTc6MDYgKzAxMDAsIE1hdHRoaWFzIEJydWdn
ZXIgd3JvdGU6DQo+IA0KPiBPbiAxMC8wMi8yMDIwIDEyOjU3LCBXZW4gU3Ugd3JvdGU6DQo+ID4g
SGksIA0KPiA+IA0KPiA+IE9uIFRodSwgMjAyMC0wMi0wNiBhdCAxMTo0OSArMDAwMCwgTWFyayBC
cm93biB3cm90ZToNCj4gPj4gT24gVGh1LCBGZWIgMDYsIDIwMjAgYXQgMTE6MDY6NDhBTSArMDgw
MCwgV2VuIFN1IHdyb3RlOg0KPiA+Pg0KPiA+Pj4gK1JlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4+
PiArLSBjb21wYXRpYmxlOiAibWVkaWF0ZWssbXQ2MzU5LXJlZ3VsYXRvciINCj4gPj4NCj4gPj4g
V2h5IGRvZXMgdGhpcyBuZWVkIGEgY29tcGF0aWJsZSBzdHJpbmcgLSBpdCBsb29rcyBsaWtlIGl0
J3MganVzdA0KPiA+PiBlbmNvZGluZyB0aGUgd2F5IExpbnV4IHNwbGl0cyBkZXZpY2VzIHVwIGlu
dG8gdGhlIERULCBub3QNCj4gPj4gcHJvdmlkaW5nIHNvbWUgcmV1c2FibGUgSVAgYmxvY2suDQo+
ID4gDQo+ID4gVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KPiA+IEkgd2lsbCByZW1vdmUgaXQg
aW4gdGhlIG5leHQgcGF0Y2guDQo+ID4gDQo+IA0KPiBJZiB0aGlzIHRoZSB3YXkgdG8gZ28sIHRo
ZW4gcGxlYXNlIGZpeCBhbGwgdGhlIG90aGVyIE1lZGlhVGVrIGJpbmRpbmcNCj4gZGVzY3JpcHRp
b24gZm9yIHJlZ3VsYXRvcnMgKCsgdGhlIGR0cykgYXMgdGhpcyBpcyB0aGVuIHdyb25nLg0KPiBU
aGFua3MhDQo+IE1hdHRoaWFzDQoNClRoZSBtdDYzNTktcmVndWxhdG9yIGRyaXZlciBpcyBzdGls
bCBhIHJldXNhYmxlIElQIGJsb2NrLkl0IGNvdWxkIGJlDQphZGRpbmcgbW9yZSBvdGhlciBNZWRp
YVRlayBwbWljIG10NjM1OSBzaW1pbGFyIGNvbXBhdGlibGUgZGV2aWNlLiBCdXQNCmN1cnJlbnRs
eSB0aGlzIHBhdGNoIG9ubHkgdGVzdGluZyBvbiBwbWljIG10NjM1OS4NCklzIGl0IGFsbG93YWJs
ZSB0byBrZWVwIGNvbXBhdGlibGUgc3RyaW5nIGluIGJpbmRpbmcgZGVzY3JpcHRpb24gPw0KDQpU
aGFua3MNCg0K

