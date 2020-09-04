Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E568C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 507F520791
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IN3m1r89"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbgIDK3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 06:29:04 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:15347 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730034AbgIDK2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:28:53 -0400
X-UUID: 07771bdf2c1c4ee1ab180633629baa0e-20200904
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=W6qNdgT4XBpxvM+qKDnHlTrV/BrFHcflzIbO8Gjk/jY=;
        b=IN3m1r89KoswFu3G3q/WjUwnve/HdkYvnt5t2G/75yVvGKnofYrpPUnyXkRaUTzN5ImRXXV9D6MlKN/DeygL95MarB5Awr6OZ9PXCVy0QYOdwTf4B8aHDzb59k7o+7QncEepnOw6xVuReZ1ttVelAKamGzp++oZhReYg/u+kYcY=;
X-UUID: 07771bdf2c1c4ee1ab180633629baa0e-20200904
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1434882807; Fri, 04 Sep 2020 18:28:46 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 4 Sep 2020 18:28:41 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Sep 2020 18:28:42 +0800
Message-ID: <1599215324.29997.1.camel@mtkswgap22>
Subject: Re: [PATCH v5] iommu/mediatek: check 4GB mode by reading infracfg
From:   Miles Chen <miles.chen@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        "Christoph Hellwig" <hch@lst.de>
Date:   Fri, 4 Sep 2020 18:28:44 +0800
In-Reply-To: <20200904094233.GP6714@8bytes.org>
References: <20200831105639.2856-1-miles.chen@mediatek.com>
         <20200904094233.GP6714@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 8CBC2E51C5EDEC8111200CFC22B3DC832000455B5036BDE4B17C4427343DBDC82000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTA5LTA0IGF0IDExOjQyICswMjAwLCBKb2VyZyBSb2VkZWwgd3JvdGU6DQo+
IE9uIE1vbiwgQXVnIDMxLCAyMDIwIGF0IDA2OjU2OjM5UE0gKzA4MDAsIE1pbGVzIENoZW4gd3Jv
dGU6DQo+ID4gSW4gcHJldmlvdXMgZGlzY3Vzc2lvbiBbMV0gYW5kIFsyXSwgd2UgZm91bmQgdGhh
dCBpdCBpcyByaXNreSB0bw0KPiA+IHVzZSBtYXhfcGZuIG9yIHRvdGFscmFtX3BhZ2VzIHRvIHRl
bGwgaWYgNEdCIG1vZGUgaXMgZW5hYmxlZC4NCj4gPiANCj4gPiBDaGVjayA0R0IgbW9kZSBieSBy
ZWFkaW5nIGluZnJhY2ZnIHJlZ2lzdGVyLCByZW1vdmUgdGhlIHVzYWdlDQo+ID4gb2YgdGhlIHVu
LWV4cG9ydGVkIHN5bWJvbCBtYXhfcGZuLg0KPiA+IA0KPiA+IFRoaXMgaXMgYSBzdGVwIHRvd2Fy
ZHMgYnVpbGRpbmcgbXRrX2lvbW11IGFzIGEga2VybmVsIG1vZHVsZS4NCj4gPiANCj4gPiBbMV0g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIwMDYwMzE2MTEzMi4yNDQxLTEtbWlsZXMu
Y2hlbkBtZWRpYXRlay5jb20vDQo+ID4gWzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwv
MjAyMDA2MDQwODAxMjAuMjYyOC0xLW1pbGVzLmNoZW5AbWVkaWF0ZWsuY29tLw0KPiA+IFszXSBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjAwNzE1MjA1MTIwLkdBNzc4ODc2QGJvZ3Vz
Lw0KPiA+IA0KPiA+IENjOiBNaWtlIFJhcG9wb3J0IDxycHB0QGxpbnV4LmlibS5jb20+DQo+ID4g
Q2M6IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPg0KPiA+IENjOiBZb25nIFd1
IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiBDYzogWWluZ2pvZSBDaGVuIDx5aW5nam9lLmNo
ZW5AbWVkaWF0ZWsuY29tPg0KPiA+IENjOiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4N
Cj4gPiBDYzogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gPiBDYzogTWF0dGhpYXMg
QnJ1Z2dlciA8bWF0dGhpYXMuYmdnQGdtYWlsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaWxl
cyBDaGVuIDxtaWxlcy5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gDQo+IFlvdSBmb3Jnb3QgdG8gYWRk
IHRoZSB0YWdzIGhlcmUgZnJvbSB2NCwgYXQgbGVhc3QgTWF0dGhpYXMnIFJldmlld2VkLWJ5DQo+
IGlzIG1pc3NpbmcuIFBsZWFzZSBhZGQgdGhlIG1pc3NpbmcgdGFncyBhbmQgcmVzZW5kLg0KDQpU
aGFua3MgZm9yIHJlbWluZGluZy4gSSdsbCBhZGQgdGhlIHRhZyBhbmQgcmVzZW5kIHRoaXMgcGF0
Y2ggQVNBUC4NCg0KTWlsZXMNCj4gDQo+IA0KPiAJSm9lcmcNCg0K

