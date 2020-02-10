Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0AEC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 11:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6B520733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 11:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kb3gKJZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgBJL5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 06:57:41 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:54610 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726950AbgBJL5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 06:57:41 -0500
X-UUID: 915e6ba8374342e6b6f48b9375edab1d-20200210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=sYoKY2Ak/uSkSw4Bm97gJwImBKKIl01gw2RaEsy53FM=;
        b=kb3gKJZrjCW/QU1S67/47XGSuE75rkFuod9821Fpb514ooZCzamn1tPY+uziPT9SanAPdy7k/hkOUj1sfTYWctqUTnFevq7Coo1cXQVUlASnVbg+DH/OfKOJV95EQiYFEyD9uiODmQNxSZVnXjvl4Xxya5qN47/K+KG3qLbFGcg=;
X-UUID: 915e6ba8374342e6b6f48b9375edab1d-20200210
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <wen.su@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 512373413; Mon, 10 Feb 2020 19:57:36 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 10 Feb 2020 19:56:47 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 10 Feb 2020 19:56:44 +0800
Message-ID: <1581335854.16783.1.camel@mtkswgap22>
Subject: Re: [PATCH v2 1/4] dt-bindings: regulator: Add document for MT6359
 regulator
From:   Wen Su <Wen.Su@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 10 Feb 2020 19:57:34 +0800
In-Reply-To: <20200206114927.GN3897@sirena.org.uk>
References: <1580958411-2478-1-git-send-email-Wen.Su@mediatek.com>
         <1580958411-2478-2-git-send-email-Wen.Su@mediatek.com>
         <20200206114927.GN3897@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIA0KDQpPbiBUaHUsIDIwMjAtMDItMDYgYXQgMTE6NDkgKzAwMDAsIE1hcmsgQnJvd24gd3Jv
dGU6DQo+IE9uIFRodSwgRmViIDA2LCAyMDIwIGF0IDExOjA2OjQ4QU0gKzA4MDAsIFdlbiBTdSB3
cm90ZToNCj4gDQo+ID4gK1JlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4gKy0gY29tcGF0aWJsZTog
Im1lZGlhdGVrLG10NjM1OS1yZWd1bGF0b3IiDQo+IA0KPiBXaHkgZG9lcyB0aGlzIG5lZWQgYSBj
b21wYXRpYmxlIHN0cmluZyAtIGl0IGxvb2tzIGxpa2UgaXQncyBqdXN0DQo+IGVuY29kaW5nIHRo
ZSB3YXkgTGludXggc3BsaXRzIGRldmljZXMgdXAgaW50byB0aGUgRFQsIG5vdA0KPiBwcm92aWRp
bmcgc29tZSByZXVzYWJsZSBJUCBibG9jay4NCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0K
SSB3aWxsIHJlbW92ZSBpdCBpbiB0aGUgbmV4dCBwYXRjaC4NCg0KPiBfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBMaW51eC1tZWRpYXRlayBtYWlsaW5n
IGxpc3QNCj4gTGludXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW1lZGlhdGVrDQoNCg==

