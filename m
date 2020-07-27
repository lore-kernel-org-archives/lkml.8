Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC37EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86A3E20759
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CSaEj9xs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgG0Gmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 02:42:55 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:46325 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726122AbgG0Gmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 02:42:55 -0400
X-UUID: 7eb9876217be47ceb8d12aa6fa423a50-20200727
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=sPmuXHpH9XNlFgouHZYOVCVUIZrXlxeu/KMhxKhqoFc=;
        b=CSaEj9xsdVGsTTGzjZNP6nk77KrP83X/JIeZRPFPAz4jC4GMhQt0kGDv8d/7pYyDSKqkOU4BZlJtjP7Qhr0L6cCkZCtIJvApQtTTbxSdmqH5GoZZdNn+u2vI/E5dFIqzN2tUR23p79URFq2gj807/goi7Fii5lZ5VVUz9OKW2+I=;
X-UUID: 7eb9876217be47ceb8d12aa6fa423a50-20200727
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 967003377; Mon, 27 Jul 2020 14:42:41 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 27 Jul
 2020 14:42:38 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 27 Jul 2020 14:42:35 +0800
Message-ID: <1595832080.16172.88.camel@mhfsdcap03>
Subject: Re: [PATCH 18/21] iommu/mediatek: Add support for multi domain
From:   Yong Wu <yong.wu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <cui.zhang@mediatek.com>,
        <chao.hao@mediatek.com>, <ming-fan.chen@mediatek.com>
Date:   Mon, 27 Jul 2020 14:41:20 +0800
In-Reply-To: <20200723204729.GA823856@bogus>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
         <20200711064846.16007-19-yong.wu@mediatek.com>
         <20200723204729.GA823856@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: AAEEA5DEDA078252AF7983EB2F3959E34D7A075A7A10B725C05A35A5BB0517B82000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA3LTIzIGF0IDE0OjQ3IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gU2F0LCBKdWwgMTEsIDIwMjAgYXQgMDI6NDg6NDNQTSArMDgwMCwgWW9uZyBXdSB3cm90ZToN
Cj4gPiBTb21lIEhXIElQKGV4OiBDQ1UpIHJlcXVpcmUgdGhlIHNwZWNpYWwgaW92YSByYW5nZS4g
VGhhdCBtZWFucyB0aGUNCj4gPiBpb3ZhIGdvdCBmcm9tIGRtYV9hbGxvY19hdHRycyBmb3IgdGhh
dCBkZXZpY2VzIG11c3QgbG9jYXRlIGluIGhpcw0KPiA+IHNwZWNpYWwgcmFuZ2UuIEluIHRoaXMg
cGF0Y2gsIHdlIGFsbG9jYXRlIGEgc3BlY2lhbCBpb3ZhX3JhbmdlIGZvcg0KPiA+IGVhY2ggYSBz
cGVjaWFsIHJlcXVpcmVtZW50IGFuZCBjcmVhdGUgZWFjaCBhIGlvbW11IGRvbWFpbiBmb3IgZWFj
aA0KPiA+IGEgaW92YV9yYW5nZS4NCj4gPiANCj4gPiBtZWFud2hpbGUgd2Ugc3RpbGwgdXNlIG9u
ZSBwYWdldGFibGUgd2hpY2ggc3VwcG9ydCAxNkdCIGlvdmEuDQo+ID4gDQo+ID4gQWZ0ZXIgdGhp
cyBwYXRjaCwgSWYgdGhlIGlvdmEgcmFuZ2Ugb2YgYSBtYXN0ZXIgaXMgb3ZlciA0RywgdGhlIG1h
c3Rlcg0KPiA+IHNob3VsZDoNCj4gPiBhKSBEZWNsYXJlIGl0cyBzcGVjaWFsIGRtYV9yYW5nZXMg
aW4gaXRzIGR0c2kgbm9kZS4gRm9yIGV4YW1wbGUsIElmIHdlDQo+ID4gcHJlYXNzaWduIHRoZSBp
b3ZhIDRHLThHIGZvciB2Y29kZWMsIHRoZW4gdGhlIHZjb2RlYyBkdHNpIG5vZGUgc2hvdWxkOg0K
PiA+IAlkbWEtcmFuZ2VzID0gPDB4MSAweDAgMHgxIDB4MCAweDEgMHgwPjsgIC8qIDRHIH4gOEcg
Ki8NCj4gDQo+IEJUVywgZG1hLXJhbmdlcyBzaG91bGQgYmUgaW4gdGhlIHBhcmVudCBub2RlIG9m
IHRoZSB2Y29kZWMuDQoNCkJ1dCB0aGUgdmNvZGVjIGRvZXNuJ3QgaGF2ZSBpdHMgc3BlY2lhbCBw
YXJlbnQgbm9kZS4gQ3VycmVudGx5IHRoZQ0KdmNvZGVjL2Rpc3BsYXkgZHRzaSBsaWtlIHRoaXM6
DQoNCnNvYyB7DQoNCiAgICBvdmw6eyAgLyogZGlzcGxheSAqLw0KICAgIC8qTm8gZG1hLXJhbmdl
cyBwcm9wZXJ0eS4gZGVmYXVsdGx5IGl0IGlzIDAtNEcgaW92YSByYW5nZS4gKi8NCiAgICB9DQoN
CiAgICB2Y29kZWNfZGVjOiB7IC8qIGRlY29kZSAqLw0KICAgIGRtYS1yYW5nZXMgPSA8MHgxIDB4
MCAweDEgMHgwIDB4MSAweDA+OyAvKiA0RyB+IDhHKi8NCiAgICB9Ow0KDQogICAgdmNvZGVjX2Vu
YzogeyAgLyogZW5jb2RlICovDQogICAgZG1hLXJhbmdlcyA9IDwweDEgMHgwIDB4MSAweDAgMHgx
IDB4MD47IC8qIDRHIH4gOEcqLw0KICAgIH07DQoNCiAgICBjYW1lcmE6IHsNCiAgICBkbWEtcmFu
Z2VzID0gPDB4MiAweDAgMHgyIDB4MCAweDEgMHgwPjsgLyogOEcgfiAxMkcgKi8NCiAgICB9Ow0K
DQp9DQoNCklmIHdlIGFkZCB0aGUgcGFyZW50IG5vZGUgZm9yIHZjb2RlYywgdGhlIHZjb2RlYyBk
cml2ZXIgZmxvdyB3aWxsIGJlDQpjaGFuZ2VkLCBhbmQgaXQgbWF5IGJlIGluY29tcGF0aWJsZSB3
aXRoIHRoZSBwcmV2aW91cyBkdGIuDQoNCkhlcmUgd2UgZG9uJ3QgaGF2ZSB0aGUgYWN0dWFsIGJ1
cyBjb25jZXB0LiBjdXJyZW50bHkgd2Ugc3VwcG9ydCAxNkdCDQpkbWFfYWRkcihpb3ZhKSByYW5n
ZXMuIHdlIG9ubHkgcHJlYXNzaWduIDQtOEcgZm9yIHZjb2RlYywgOEctMTJHIGZvcg0KY2FtZXJh
Lg0KDQpJZiB0aGUgdXNhZ2Ugb2YgZG1hLXJhbmdlcyBoZXJlIGlzIGRpZmZlcmVudCBmcm9tIHRo
ZSBjb21tb24gb25lLiB0aGVuDQpob3cgc2hvdWxkIEkgZG8gaGVyZT8NCg0KVGhhbmtzLg0KPiAN
Cj4gPiBiKSBVcGRhdGUgdGhlIGRtYV9tYXNrOg0KPiA+ICBkbWFfc2V0X21hc2tfYW5kX2NvaGVy
ZW50KGRldiwgRE1BX0JJVF9NQVNLKDMzKSk7DQo+IA0KPiBUaGlzIHNob3VsZCBoYXBwZW4gZm9y
IHlvdSBhdXRvbWF0aWNhbGx5LiBUaGUgRE1BIFBGTiBvZmZzZXQgDQo+IHNob3VsZCBhbHNvIGJl
IDRHQiBoZXJlLg0KDQpJIG1heSBub3QgZm9sbG93IGhlcmUuDQoNCklmIHRoZSBpb3ZhIHN0YXJ0
IGF0IDB4MV8wMDAwXzAwMDAsIHBoeXMgYWRkcmVzcyBzdGFydCBhdCAweDQwMDBfMDAwMC4NCkRv
IHlvdSBtZWFucyB0aGUgZG1hLXJhbmdlcyBzaG91bGQgYmUgPDB4MSAwIDB4MCAweDQwMDAwMDAw
IDB4MSAweDA+Pw0KdGhlbiBkbWFfcGZuX29mZnNldCA9IFBGTl9ET1dOKHBhZGRyIC0gZG1hX2Fk
ZHIpID0gMHhmZmZmZmZmZjQwMDAwLiB0aGlzDQppcyBhbHNvIG9rIGZvciB1cy4gd2UgZG9uJ3Qg
Y2FsbCB0aGUgbWFjcm8gcmVnYXJkaW5nIHRoaXMNCiJkZXYtPmRtYV9wZm5fb2Zmc2V0Ig0KDQpU
aGUgcHVycG9zZSB0aGF0IEkgY2FsbCBpdCBoZXJlIGlzIGZvciB1cGRhdGluZyB0aGUNCmRldi0+
Y29oZXJlbnRfZG1hX21hc2tbMV0sIHRoZW4gd2UgY291bGQgZ2V0IHRoZSBpb3ZhIG92ZXIgNEdC
Lg0KDQpbMV0NCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y1LjgtcmMxL3NvdXJj
ZS9kcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jI0w2MTkNCg0KPiANCj4gPiANCj4gPiBTaWduZWQt
b2ZmLWJ5OiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJp
dmVycy9pb21tdS9tdGtfaW9tbXUuYyB8IDQ5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLQ0KPiA+ICBkcml2ZXJzL2lvbW11L210a19pb21tdS5oIHwgIDMgKystDQo+ID4g
IDIgZmlsZXMgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQoNCg==

