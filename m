Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D843C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1924520826
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dYwznZ8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbgF3JaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 05:30:16 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:65283 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730256AbgF3JaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 05:30:15 -0400
X-UUID: 7b295ccc4bdc413da5e5e47488a17a45-20200630
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=qWezObeQUl2l9qNQFUNHf2rax4BUh9tFvDVgI6m22bM=;
        b=dYwznZ8YP/LHBxn1267ZqK5zW70isCJDsHqF26+mzHhAKp6HxunfsocMGiwcws++SXhyuMW0Qn7cdm1GCLN/c87mrP7KCp3TLQ1rBAWBf6RL8kyd9767HuXNAeP2tAdZsmHtssr9umUcA4DHSEvUqdnMPiD01rQYSDq01ld/i1Q=;
X-UUID: 7b295ccc4bdc413da5e5e47488a17a45-20200630
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1659440202; Tue, 30 Jun 2020 17:30:10 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 30 Jun 2020 17:29:59 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Jun 2020 17:30:00 +0800
Message-ID: <1593509401.4597.2.camel@mtkswgap22>
Subject: Re: [PATCH v2 1/2] dt-bindings: devapc: add bindings for
 devapc-mt6873
From:   Neal Liu <neal.liu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Neal Liu <neal.liu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <wsd_upstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Rob Herring" <robh+dt@kernel.org>
Date:   Tue, 30 Jun 2020 17:30:01 +0800
In-Reply-To: <20200629215606.GA3000557@bogus>
References: <1592559720-8482-1-git-send-email-neal.liu@mediatek.com>
         <1592559720-8482-2-git-send-email-neal.liu@mediatek.com>
         <20200629215606.GA3000557@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 3175C1BF43F1CAF0F6007F915B1493F2B7BBFB5C28F83E2A1A19B3F75235C5422000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA2LTI5IGF0IDE1OjU2IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gRnJpLCAxOSBKdW4gMjAyMCAxNzo0MTo1OSArMDgwMCwgTmVhbCBMaXUgd3JvdGU6DQo+ID4g
QWRkIGJpbmRpbmdzIGZvciBNVDY4NzMgZGV2YXBjLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IE5lYWwgTGl1IDxuZWFsLmxpdUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9zb2Mv
bWVkaWF0ZWsvZGV2YXBjL2RldmFwYy1tdDY4NzMueWFtbCAgICAgICAgIHwgICA2MSArKysrKysr
KysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNjEgaW5zZXJ0aW9ucygrKQ0KPiA+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Nv
Yy9tZWRpYXRlay9kZXZhcGMvZGV2YXBjLW10Njg3My55YW1sDQo+ID4gDQo+IA0KPiANCj4gTXkg
Ym90IGZvdW5kIGVycm9ycyBydW5uaW5nICdtYWtlIGR0X2JpbmRpbmdfY2hlY2snIG9uIHlvdXIg
cGF0Y2g6DQo+IA0KPiAvYnVpbGRzL3JvYmhlcnJpbmcvbGludXgtZHQtcmV2aWV3L0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvZGV2YXBjL2RldmFwYy1tdDY4
NzMuZXhhbXBsZS5kdC55YW1sOiBleGFtcGxlLTA6IGRldmFwY0AxMDIwNzAwMDpyZWc6MDogWzAs
IDI3MDU2MTI4MCwgMCwgNDA5Nl0gaXMgdG9vIGxvbmcNCj4gL2J1aWxkcy9yb2JoZXJyaW5nL2xp
bnV4LWR0LXJldmlldy9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21lZGlh
dGVrL2RldmFwYy9kZXZhcGMtbXQ2ODczLmV4YW1wbGUuZHQueWFtbDogZXhhbXBsZS0wOiBkZXZh
cGNAMTAyMDcwMDA6cmVnOjE6IFswLCAyNzEwMDc3NDQsIDAsIDQwOTZdIGlzIHRvbyBsb25nDQo+
IC9idWlsZHMvcm9iaGVycmluZy9saW51eC1kdC1yZXZpZXcvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9kZXZhcGMvZGV2YXBjLW10Njg3My5leGFtcGxlLmR0
LnlhbWw6IGV4YW1wbGUtMDogZGV2YXBjQDEwMjA3MDAwOnJlZzoyOiBbMCwgMjcxMDExODQwLCAw
LCA0MDk2XSBpcyB0b28gbG9uZw0KPiAvYnVpbGRzL3JvYmhlcnJpbmcvbGludXgtZHQtcmV2aWV3
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvZGV2YXBjL2Rl
dmFwYy1tdDY4NzMuZXhhbXBsZS5kdC55YW1sOiBleGFtcGxlLTA6IGRldmFwY0AxMDIwNzAwMDpy
ZWc6MzogWzAsIDI4NTM0Mzc0NCwgMCwgNDA5Nl0gaXMgdG9vIGxvbmcNCj4gL2J1aWxkcy9yb2Jo
ZXJyaW5nL2xpbnV4LWR0LXJldmlldy9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
c29jL21lZGlhdGVrL2RldmFwYy9kZXZhcGMtbXQ2ODczLmV4YW1wbGUuZHQueWFtbDogZXhhbXBs
ZS0wOiBkZXZhcGNAMTAyMDcwMDA6cmVnOjQ6IFswLCAyNzA1ODk5NTIsIDAsIDQwOTZdIGlzIHRv
byBsb25nDQo+IA0KPiANCj4gU2VlIGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcGF0Y2gv
MTMxMjc0MQ0KPiANCj4gSWYgeW91IGFscmVhZHkgcmFuICdtYWtlIGR0X2JpbmRpbmdfY2hlY2sn
IGFuZCBkaWRuJ3Qgc2VlIHRoZSBhYm92ZQ0KPiBlcnJvcihzKSwgdGhlbiBtYWtlIHN1cmUgZHQt
c2NoZW1hIGlzIHVwIHRvIGRhdGU6DQo+IA0KPiBwaXAzIGluc3RhbGwgZ2l0K2h0dHBzOi8vZ2l0
aHViLmNvbS9kZXZpY2V0cmVlLW9yZy9kdC1zY2hlbWEuZ2l0QG1hc3RlciAtLXVwZ3JhZGUNCj4g
DQo+IFBsZWFzZSBjaGVjayBhbmQgcmUtc3VibWl0Lg0KPiANCg0KSSBqdXN0IHB1bGwgdGhlIGxh
dGVzdCBkdC1zY2hlbWEgZnJvbSBnaXRodWIsIGFuZCBpdCdzIHN0aWxsIHN1Y2Nlc3NmdWwuDQpJ
cyB0aGVyZSBhbnkgb3RoZXIgY2x1ZSBmb3IgdGhpcyBkaWZmZXJlbmNlPw0KDQokIFBBVEg9fi92
aXJ0X3Rlc3QvcHl0aG9uMzYvYmluOiRQQVRIIEFSQ0g9YXJtNjQgbWFrZSBkdF9iaW5kaW5nX2No
ZWNrDQpEVF9TQ0hFTUFfRklMRVM9RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Nv
Yy9tZWRpYXRlay9kZXZhcGMvZGV2YXBjLW10Njg3My55YW1sDQogIENIS0RUDQpEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21lZGlhdGVrL2RldmFwYy9kZXZhcGMtbXQ2ODcz
LnlhbWwNCiAgRFRDDQpEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21lZGlh
dGVrL2RldmFwYy9kZXZhcGMtbXQ2ODczLmV4YW1wbGUuZHQueWFtbA0KICBDSEVDSw0KRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9kZXZhcGMvZGV2YXBjLW10
Njg3My5leGFtcGxlLmR0LnlhbWwNCg0K

