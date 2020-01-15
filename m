Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43686C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 05:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F5F24679
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 05:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iQkGiWWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgAOFcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 00:32:18 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:26786 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726018AbgAOFcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 00:32:18 -0500
X-UUID: bca4c1a18c4848ea821193af7309e867-20200115
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=TZNJZ9TKA1p3YIh669Tp1TrhqTZz02HNKGVqwfnRFw4=;
        b=iQkGiWWKXMn218uPxovDIHk9XXS7kUvH9orJArOCBaiFIBmoc7d11Ch3Yh3trJbC4wEEl+VzmW20DoHoxocblZpdmZRindgFZ7n7MgDg1QHEwSG4c+qisRl3Fw5jk60o7S+claF9n6pBn1KZvY8JRwVe2nePf8cI20RSS60il6M=;
X-UUID: bca4c1a18c4848ea821193af7309e867-20200115
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <jamesjj.liao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 860490587; Wed, 15 Jan 2020 13:32:08 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 15 Jan 2020 13:31:36 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 15 Jan 2020 13:30:13 +0800
Message-ID: <1579066321.30255.3.camel@mtksdaap41>
Subject: Re: [PATCH v2] arm64: dts: mt8183: Enable CPU idle-states
From:   James Liao <jamesjj.liao@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Date:   Wed, 15 Jan 2020 13:32:01 +0800
In-Reply-To: <e046d80c-07fb-7d45-309e-6f55dd8b0dc2@gmail.com>
References: <1578996673-8140-1-git-send-email-jamesjj.liao@mediatek.com>
         <e046d80c-07fb-7d45-309e-6f55dd8b0dc2@gmail.com>
Content-Type: text/plain; charset="us-ascii"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTAxLTE0IGF0IDEyOjE0ICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gPiArCQlpZGxlLXN0YXRlcyB7DQo+ID4gKwkJCWVudHJ5LW1ldGhvZCA9ICJhcm0s
cHNjaSI7DQo+IA0KPiByZWFkaW5nIGlkbGUtc3RhdGVzLnR4dCB0aGUgZW50cnktbWV0aG9kIHNo
b3VsZCBiZSAicHNjaSIuDQoNCkl0IHdpbGwgYmUgY29ycmVjdCBpbiBuZXh0IHBhdGNoLg0KDQo+
ID4gKw0KPiA+ICsJCQlNQ0RJX0NQVTogbWNkaS1jcHUgew0KPiANCj4gSSB3b25kZXIgd2hhdCBN
Q0RJIHN0YW5kcyBmb3IuIE5vcm1hbGx5IHdlIGhhdmUgQ1BVX1NMRUVQIGFuZCBDTFVTVEVSX1NM
RUVQIGhlcmUuDQoNCkl0IG1lYW5zIE1DVSBEZWVwIElkbGUuIEJ1dCB5b3UgYXJlIHJpZ2h0LCBD
UFUvQ0xVU1RFUl9TTEVFUCBpcyBtb3JlDQpyZWFkYWJsZS4gU28gSSdsbCBjaGFuZ2UgdGhlaXIg
bmFtZSBpbiBuZXh0IHBhdGNoLg0KDQoNCkJlc3QgcmVnYXJkcywNCg0KSmFtZXMNCg0K

