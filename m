Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BA9C1975A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 23:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 356DC2072D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 23:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SHq/JyC7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgCVXRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 19:17:36 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:6584 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgCVXRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 19:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584919055; x=1616455055;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=NWWujVvKBsYuQnE25EfOxyG+Ag9go0PlW2vd+guccGQ=;
  b=SHq/JyC7z1WlpAxNupO0z2e+ODlBTEzMLpi4VvhpxfowgqqiO6BF6x20
   sa2S7rIvN7S5YimJHFE/qBr8dFh6LAE7oVaa9tybP/S0/5OIsxxajleC0
   fj8S2Cw2brt27hGqNWn+HRwHFFyogvP0g550lNaBs162LMF93kFs0Hclv
   k=;
IronPort-SDR: psMJdEHhn9HE1lORvN+HIndleyDmvT/ccFO2oqeZqIozXUfBQIrCSR+fnREZ83khQfsIJ6Dkbe
 Om2lC4pQDTHw==
X-IronPort-AV: E=Sophos;i="5.72,294,1580774400"; 
   d="scan'208";a="22240729"
Subject: Re: [RFC PATCH] arch/x86: Optionally flush L1D on context switch
Thread-Topic: [RFC PATCH] arch/x86: Optionally flush L1D on context switch
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 22 Mar 2020 23:17:22 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com (Postfix) with ESMTPS id 1827EA2808;
        Sun, 22 Mar 2020 23:17:22 +0000 (UTC)
Received: from EX13D01UWB003.ant.amazon.com (10.43.161.94) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 22 Mar 2020 23:17:21 +0000
Received: from EX13D21UWB003.ant.amazon.com (10.43.161.212) by
 EX13d01UWB003.ant.amazon.com (10.43.161.94) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 22 Mar 2020 23:17:21 +0000
Received: from EX13D21UWB003.ant.amazon.com ([10.43.161.212]) by
 EX13D21UWB003.ant.amazon.com ([10.43.161.212]) with mapi id 15.00.1497.006;
 Sun, 22 Mar 2020 23:17:21 +0000
From:   "Herrenschmidt, Benjamin" <benh@amazon.com>
To:     "luto@amacapital.net" <luto@amacapital.net>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Singh, Balbir" <sblbir@amazon.com>,
        "x86@kernel.org" <x86@kernel.org>
Thread-Index: AQHWAAfn6i+PyJUPFk+FYFtSBQE7c6hUt/uAgACIBoA=
Date:   Sun, 22 Mar 2020 23:17:21 +0000
Message-ID: <0eb0804b3061ddd52fe7736b0ae124234581a9dc.camel@amazon.com>
References: <99ef5eec8502a7b53eee362063b9b2252a5a47da.camel@amazon.com>
         <A38682A4-62B2-4849-ADEA-196DFF4D36C9@amacapital.net>
In-Reply-To: <A38682A4-62B2-4849-ADEA-196DFF4D36C9@amacapital.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.173]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C87D9847FB6ABD4889534C0AFCA3A766@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIwLTAzLTIyIGF0IDA4OjEwIC0wNzAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6
DQo+IA0KPiBMZXQgbWUgdHJ5IHRvIHVuZGVyc3RhbmQgdGhlIGlzc3VlLiBUaGVyZSBpcyBzb21l
IGhpZ2gtdmFsdWUgZGF0YSwNCj4gYW5kIHRoYXQgZGF0YSBpcyBvd25lZCBieSBhIGhpZ2gtdmFs
dWUgcHJvY2Vzcy4gQXQgc29tZSBwb2ludCwgdGhlDQo+IGRhdGEgZW5kcyB1cCBpbiBMMUQuICBM
YXRlciBpbiwgZXZpbCBjb2RlIHJ1bnMgYW5kIG1heSBhdHRlbXB0IHRvDQo+IGV4ZmlsdHJhdGUg
IHRoYXQgZGF0YSBmcm9tIEwxRCB1c2luZyBhIHNpZGUgY2hhbm5lbC4gKFRoZSBldmlsIGNvZGUN
Cj4gaXMgbm90IG5lY2Vzc2FyaWx5IGluIGEgbWFsaWNpb3VzIHByb2Nlc3MgY29udGV4dC4gSXQg
Y291bGQgYmUga2VybmVsDQo+IGNvZGUgdGFyZ2V0ZWQgYnkgTFZJIG9yIHNpbWlsYXIuIEl0IGNv
dWxkIGJlIG9yZGluYXJ5IGNvZGUgdGhhdA0KPiBoYXBwZW5zIHRvIGNvbnRhaW4gYSBzaWRlIGNo
YW5uZWwgZ2FkZ2V0IGJ5IGFjY2lkZW50LikNCg0KV2UgYXJlbid0IHRyeWluZyB0byBwcm90ZWN0
IHByb2Nlc3NlcyBhZ2FpbnN0IHRoZSBrZXJuZWwuIEkgdGhpbmsNCnRoYXQncyBiZXlvbmQgd2hh
dCBjYW4gcmVhc29uYWJseSBiZSBkb25lIGlmIHRoZSBrZXJuZWwgaXMNCmNvbXByb21pc2VkLi4u
IElmIHlvdSBhcmUgd29ycmllZCBhYm91dCB0aGF0IGNhc2UsIHVzZSBWTXMuDQoNCldlIGFyZSBt
b3N0bHkgdHJ5aW5nIHRvIHByb3RlY3QgcHJvY2VzcyB2cy4gcHJvY2Vzcy4gZWl0aGVyIGxhbmd1
YWdlDQpydW50aW1lcyBwb3RlbnRpYWxseSBydW5uaW5nIGRpZmZlcmVudCAidXNlciIgY29kZSwg
b3IgY29udGFpbmVycw0KcGVydGFpbmluZyB0byBkaWZmZXJlbnQgInVzZXJzIiBldGMuLi4uDQoN
Cj4gU28gdGhlIGlkZWEgaXMgdG8gZmx1c2ggTDFEIGFmdGVyIG1hbmlwdWxhdGluZyBoaWdoLXZh
bHVlIGRhdGEgYW5kDQo+IGJlZm9yZSBydW5uaW5nIGV2aWwgY29kZS4NCj4NCj4gVGhlIG5hc3R5
IHBhcnQgaGVyZSBpcyB0aGF0IHdlIGRvbuKAmXQgaGF2ZSBhIGdvb2QgaGFuZGxlIG9uIHdoZW4g
TDFEDQo+IGlzIGZpbGxlZCBhbmQgd2hlbiB0aGUgZXZpbCBjb2RlIHJ1bnMuIElmIHRoZSBldmls
IGNvZGUgaXMgdW50cnVzdGVkDQo+IHByb2Nlc3MgdXNlcnNwYWNlIGFuZCB0aGUgZmlsbCBpcyBh
biBpbnRlcnJ1cHQsIHRoZW4gc3dpdGNoX21tIGlzDQo+IHVzZWxlc3MgYW5kIHdlIHdhbnQgdG8g
Zmx1c2ggb24ga2VybmVsIGV4aXQgaW5zdGVhZC4gSWYgdGhlIGZpbGwgYW5kDQo+IGV2aWwgY29k
ZSBhcmUgYm90aCB1c2Vyc3BhY2UsIHRoZW4gc3dpdGNoX21tIGlzIHByb2JhYmx5IHRoZSByaWdo
dA0KPiBjaG9pY2UsIGJ1dCBwcmVwYXJlX2V4aXRfZnJvbV91c2VybW9kZSB3b3JrcyB0b28uIElm
IFNNVCBpcyBvbiwgd2UNCj4gbG9zZSBubyBtYXR0ZXIgd2hhdC4gIElmIHRoZSBldmlsIGNvZGUg
aXMgaW4ga2VybmVsIGNvbnRleHQsIHRoZW4NCj4gaXTigJlzIG5vdCBjbGVhciB3aGF0IHRvIGRv
LiBJZiB0aGUgZmlsbCBhbmQgdGhlIGV2aWwgY29kZSBhcmUgYm90aCBpbg0KPiBrZXJuZWwgdGhy
ZWFkcyAoaGksIGlvX3VyaW5nKSwgdGhlbiBJ4oCZbSBub3QgYXQgYWxsIHN1cmUgd2hhdCB0byBk
by4NCj4gDQo+IEluIHN1bW1hcnksIGtlcm5lbCBleGl0IHNlZW1zIHN0cm9uZ2VyLCBidXQgdGhl
IHJpZ2h0IGFuc3dlciBpc27igJl0IHNvDQo+IGNsZWFyLg0KDQpSaWdodC4gV2hpY2ggaXMgd2h5
IHdlIGFyZSBoYXBweSB0byBsaW1pdCB0aGUgc2NvcGUgb2YgdGhpcyB0bw0KcHJvY2Vzc2VzLiBJ
IHRoaW5rIGlmIHRoZSBrZXJuZWwgY2Fubm90IGJlIHRydXN0ZWQgaW4gYSBnaXZlbiBzeXN0ZW0s
DQp0aGUgcmFuZ2Ugb2YgcG9zc2libGUgZXhwbG9pdHMgZHdhcmZzIHRoaXMgb25lLCBJIGRvbid0
IHRoaW5rIGl0J3Mgd2hhdA0Kd2UgcmVhc29uYWJseSB3YW50IHRvIGFkZHJlc3MgaGVyZS4NCg0K
VGhhdCBzYWlkLCBJIGFtIG5vdCBtYXJyaWVkIHRvIHRoZSBzd2l0Y2hfbW0oKSBzb2x1dGlvbiwg
aWYgdGhlcmUgaXMNCmNvbnNlbnN1cyB0aGF0IHRoZXNlIHRoaW5ncyBhcmUgYmV0dGVyIGRvbmUg
aW4gdGhlIGtlcm5lbCBlbnRyeS9leGl0DQpwYXRoLCB0aGVuIHNvIGJlIGl0LiBCdXQgbXkgZ3V0
IGZlZWxpbmcgaW4gdGhhdCBzcGVjaWZpYyBjYXNlIGlzIHRoYXQNCnRoZSBvdmVyaGVhZCB3aWxs
IGJlIGxvd2VyIGFuZCB0aGUgY29kZSBwb3RlbnRpYWxseSBzaW1wbGVyIGluDQpzd2l0Y2hfbW0u
DQoNCj4gV2UgY291bGQgZG8gYW4gb3B0aW1pemVkIHZhcmlhbnQgd2hlcmUgd2UgZmx1c2ggYXQg
a2VybmVsIGV4aXQgYnV0IHdlDQo+ICpkZWNpZGUqIHRvIGZsdXNoIGluIHN3aXRjaF9tbS4NCg0K
Q2hlZXJzLA0KQmVuLg0KDQo=
