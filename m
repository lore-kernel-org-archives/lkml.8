Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9739C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7447F2065F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="T2OkHGAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgETGzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 02:55:06 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:52006 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725998AbgETGzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 02:55:06 -0400
X-UUID: e6a65228779542d19db0772b649840c4-20200520
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=5Lcz411vQymr8LOv9ZOMpOR7TAY9qOG8MgWx5t4pG8Q=;
        b=T2OkHGAlv6ueJo8PsNx2m2Vp9/AsNBJDkeqfsiVA4uXl0ez3QpMSJkvg/sVOjhfwLvK23KXAtAEDExQyW+I8g4matGeloAbQzhSDtgGRuf9pVtmPuNrn7hD6DyH+tIhqHnyipjxtKTg4DW0cm3smSvu0xxwyne01HOsw1U4BIpE=;
X-UUID: e6a65228779542d19db0772b649840c4-20200520
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 166912837; Wed, 20 May 2020 14:54:57 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 20 May
 2020 14:54:53 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 20 May 2020 14:54:54 +0800
Message-ID: <1589957603.13912.2.camel@mhfsdcap03>
Subject: Re: [PATCH] iommu: Don't call .probe_finalize() under group->mutex
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>
CC:     <iommu@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Wed, 20 May 2020 14:53:23 +0800
In-Reply-To: <20200519132824.15163-1-joro@8bytes.org>
References: <20200519132824.15163-1-joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 255D14E269C30CBAC837F7C42790D730FB5613A0BD2417CC0B32DAEB4E59CBDF2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA1LTE5IGF0IDE1OjI4ICswMjAwLCBKb2VyZyBSb2VkZWwgd3JvdGU6DQo+
IEZyb206IEpvZXJnIFJvZWRlbCA8anJvZWRlbEBzdXNlLmRlPg0KPiANCj4gVGhlIC5wcm9iZV9m
aW5hbGl6ZSgpIGNhbGwtYmFjayBvZiBzb21lIElPTU1VIGRyaXZlcnMgY2FsbHMgaW50bw0KPiBh
cm1faW9tbXVfYXR0YWNoX2RldmljZSgpLiBUaGlzIGZ1bmN0aW9uIHdpbGwgY2FsbCBiYWNrIGlu
dG8gdGhlDQo+IElPTU1VIGNvcmUgY29kZSwgd2hlcmUgaXQgdHJpZXMgdG8gdGFrZSBncm91cC0+
bXV0ZXggYWdhaW4sIHJlc3VsdGluZw0KPiBpbiBhIGRlYWRsb2NrLg0KPiANCj4gQXMgdGhlcmUg
aXMgbm8gcmVhc29uIHdoeSAucHJvYmVfZmluYWxpemUoKSBuZWVkcyB0byBiZSBjYWxsZWQgdW5k
ZXINCj4gdGhhdCBtdXRleCwgbW92ZSBpdCBhZnRlciB0aGUgbG9jayBoYXMgYmVlbiByZWxlYXNl
ZCB0byBmaXggdGhlDQo+IGRlYWRsb2NrLg0KPiANCj4gQ2M6IFlvbmcgV3UgPHlvbmcud3VAbWVk
aWF0ZWsuY29tPg0KPiBSZXBvcnRlZC1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+
DQo+IEZpeGVzOiBkZWFjMGIzYmVkMjYgKCJpb21tdTogU3BsaXQgb2ZmIGRlZmF1bHQgZG9tYWlu
IGFsbG9jYXRpb24gZnJvbSBncm91cCBhc3NpZ25tZW50IikNCj4gU2lnbmVkLW9mZi1ieTogSm9l
cmcgUm9lZGVsIDxqcm9lZGVsQHN1c2UuZGU+DQoNClRlc3RlZC1ieTogWW9uZyBXdSA8eW9uZy53
dUBtZWRpYXRlay5jb20+DQoNClRlc3RlZCBvbiBNZWRpYVRlay12MSBtdDI3MDEgZXZiIGJvYXJk
Lg0K

