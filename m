Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CBEC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3941820663
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="P6yD1jK/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgGMGxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:53:01 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:54985 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725804AbgGMGxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 02:53:01 -0400
X-UUID: 582f5c57478b4a80bcb48956f6a3a476-20200713
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=/O8b95ILqstFIgFUi/t1yv/IWDQZ/y0hmoi2/61jPNE=;
        b=P6yD1jK/2TDrIjPFxMR0YTBlV+IWP8ekI2X4Si87kWwy8oy/33u2LEzKrj7pedVwr5n1XENvFYUtYyOwil+PyKKeAatWnY20L8vmIKwdUe6NTvxiFh4hx6TwfJy1LJnOjPJCrn+I4cH8PfpQEDJQCid/yI0FPuZAbsI75MnT1sk=;
X-UUID: 582f5c57478b4a80bcb48956f6a3a476-20200713
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1774102177; Mon, 13 Jul 2020 14:52:56 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 13 Jul
 2020 14:52:55 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 13 Jul 2020 14:52:54 +0800
Message-ID: <1594623128.16172.27.camel@mhfsdcap03>
Subject: Re: [PATCH 06/21] iommu/io-pgtable-arm-v7s: Use ias to check the
 valid iova in unmap
From:   Yong Wu <yong.wu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>, <cui.zhang@mediatek.com>,
        <chao.hao@mediatek.com>, <ming-fan.chen@mediatek.com>
Date:   Mon, 13 Jul 2020 14:52:08 +0800
In-Reply-To: <CANMq1KAhFCWfywV=OiHgW00pof8K8TdwC6Hzgyj=QWSiWBf1ag@mail.gmail.com>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
         <20200711064846.16007-7-yong.wu@mediatek.com>
         <CANMq1KAhFCWfywV=OiHgW00pof8K8TdwC6Hzgyj=QWSiWBf1ag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: F3CF35EF42678060759801117619B4C940E2D810BF19205DF4368001F842ACB22000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA3LTEzIGF0IDA4OjM4ICswODAwLCBOaWNvbGFzIEJvaWNoYXQgd3JvdGU6
DQo+IE9uIFNhdCwgSnVsIDExLCAyMDIwIGF0IDI6NTAgUE0gWW9uZyBXdSA8eW9uZy53dUBtZWRp
YXRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gQXMgdGl0bGUuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVy
cy9pb21tdS9pby1wZ3RhYmxlLWFybS12N3MuYyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9pb21tdS9pby1wZ3RhYmxlLWFybS12N3MuYyBiL2RyaXZlcnMvaW9tbXUvaW8tcGd0YWJs
ZS1hcm0tdjdzLmMNCj4gPiBpbmRleCA0MjcyZmU0ZTE3ZjQuLjAxZjJhODg3NjgwOCAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJtLXY3cy5jDQo+ID4gKysrIGIv
ZHJpdmVycy9pb21tdS9pby1wZ3RhYmxlLWFybS12N3MuYw0KPiA+IEBAIC03MTcsNyArNzE3LDcg
QEAgc3RhdGljIHNpemVfdCBhcm1fdjdzX3VubWFwKHN0cnVjdCBpb19wZ3RhYmxlX29wcyAqb3Bz
LCB1bnNpZ25lZCBsb25nIGlvdmEsDQo+ID4gIHsNCj4gPiAgICAgICAgIHN0cnVjdCBhcm1fdjdz
X2lvX3BndGFibGUgKmRhdGEgPSBpb19wZ3RhYmxlX29wc190b19kYXRhKG9wcyk7DQo+ID4NCj4g
PiAtICAgICAgIGlmIChXQVJOX09OKHVwcGVyXzMyX2JpdHMoaW92YSkpKQ0KPiA+ICsgICAgICAg
aWYgKFdBUk5fT04oaW92YSA+PSAoMVVMTCA8PCBkYXRhLT5pb3AuY2ZnLmlhcykpKQ0KPiANCj4g
VGhpcyBpcyBhIGxpdHRsZSBvZGQgYXMgaW92YSBpcyB1bnNpZ25lZCBsb25nIGFuZCAxVUxMIGlz
IHVuc2lnbmVkIGxvbmcgbG9uZy4NCj4gDQo+IFdvdWxkIGl0IGJlIGJldHRlciB0byBrZWVwIHRo
ZSBzcGlyaXQgb2YgdGhlIHByZXZpb3VzIHRlc3QgYW5kIGRvDQo+IHNvbWV0aGluZyBsaWtlOg0K
PiAgaWYgKFdBUk5fT04oaW92YSA+PiBkYXRhLT5pb3AuY2ZnLmlhcykpID8NCg0KWWVzLiBUaGFu
a3MuIEkgd2lsbCBjaGFuZ2UgaXQgbGlrZSB0aGlzIGluIG5leHQgdmVyc2lvbi4NCg0KQWxzbyBj
aGFuZ2UgdGhpcyBpbiBhcm1fdjdzX21hcCBieSB0aGUgd2F5Lg0KDQo+IA0KPiA+ICAgICAgICAg
ICAgICAgICByZXR1cm4gMDsNCj4gPg0KPiA+ICAgICAgICAgcmV0dXJuIF9fYXJtX3Y3c191bm1h
cChkYXRhLCBnYXRoZXIsIGlvdmEsIHNpemUsIDEsIGRhdGEtPnBnZCk7DQo+ID4gLS0NCj4gPiAy
LjE4LjANCg0K

