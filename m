Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26D5C47254
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 02:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A1932073B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 02:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dW0KNPrS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgEFCSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 22:18:30 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:26266 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727989AbgEFCS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 22:18:29 -0400
X-UUID: 4ca1649daef045499f1b75e07c81ce0b-20200506
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=4S4SLonUCeNW5fuMA+NMKxm1B76GCYdDl1j3L5SVHFc=;
        b=dW0KNPrSZhZM173NBSclYZ1tJTvc44e9LJrIEP270ljD0AA3YnvMy1bhrzbNZE6DQqpEV5fpGcsXftAjtA36mgqTZ0/smMm6xmizEK4uwLOrE5XOUzSlgyEOe9v10u569pZRB5hORt/M+2NjUFcrIunjVrk8pUVYCUDI5ywW0Is=;
X-UUID: 4ca1649daef045499f1b75e07c81ce0b-20200506
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1308487309; Wed, 06 May 2020 10:18:26 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 6 May 2020 10:18:23 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 6 May 2020 10:18:19 +0800
Message-ID: <1588731504.7745.3.camel@mtksdccf07>
Subject: Re: [PATCH v2] stacktrace: cleanup inconsistent variable type
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Date:   Wed, 6 May 2020 10:18:24 +0800
In-Reply-To: <d2a9f155-f309-0182-73c9-5c02d7014574@acm.org>
References: <20200421013511.5960-1-walter-zh.wu@mediatek.com>
         <d2a9f155-f309-0182-73c9-5c02d7014574@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B18FF41D50DAA5A8BBADA9C39DDC3D29DECCB526F72A79F9EBA7F71DB48F5D192000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA0LTIyIGF0IDE4OjIxIC0wNzAwLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6
DQo+IE9uIDQvMjAvMjAgNjozNSBQTSwgV2FsdGVyIFd1IHdyb3RlOg0KPiA+IE1vZGlmeSB0aGUg
dmFyaWFibGUgdHlwZSBvZiAnc2tpcCcgbWVtYmVyIG9mIHN0cnVjdCBzdGFja190cmFjZS4NCj4g
PiBJbiB0aGVvcnksIHRoZSAnc2tpcCcgdmFyaWFibGUgdHlwZSBzaG91bGQgYmUgdW5zaWduZWQg
aW50Lg0KPiA+IFRoZXJlIGFyZSB0d28gcmVhc29uczoNCj4gPiAtIFRoZSAnc2tpcCcgb25seSBo
YXMgdHdvIHNpdHVhdGlvbiwgMSlQb3NpdGl2ZSB2YWx1ZSwgMilaZXJvDQo+ID4gLSBUaGUgJ3Nr
aXAnIG9mIHN0cnVjdCBzdGFja190cmFjZSBoYXMgaW5jb25zaXN0ZW50IHR5cGUgd2l0aCBzdHJ1
Y3QNCj4gPiAgICBzdGFja190cmFjZV9kYXRhLCBpdCBtYWtlcyBhIGJpdCBjb25mdXNpb24gaW4g
dGhlIHJlbGF0aW9uc2hpcCBiZXR3ZWVuDQo+ID4gICAgc3RydWN0IHN0YWNrX3RyYWNlIGFuZCBz
dGFja190cmFjZV9kYXRhLg0KPiANCj4gUmV2aWV3ZWQtYnk6IEJhcnQgVmFuIEFzc2NoZSA8YnZh
bmFzc2NoZUBhY20ub3JnPg0KDQpIaSBBbmRyZXcsDQoNCldvdWxkIHlvdSBrbm93IHdoeSBub3Qg
dG8gYmUgcGlja2VkIHVwIHRoaXMgcGF0Y2ggeWV0Pw0KRG8gSSBtaXNzIHNvbWV0aGluZ3M/DQoN
Cg0KVGhhbmsgeW91IGZvciB5b3VyIGhlbHAuDQoNCldhbHRlcg0KDQo=

