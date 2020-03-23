Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED9BC4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 00:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7068E20714
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 00:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CgoYaLWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgCWAMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 20:12:22 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:7237 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgCWAMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 20:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584922341; x=1616458341;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=wkLzgaemTYtdnyKrfE6L47vGd0PmufiVQnmzzOdR9m0=;
  b=CgoYaLWptdMycQV2VM4+z8RxD/9DiFMI65ZIn0HTGX12Aq/QF9lPOqF0
   Gn8TZ1ukrN8igN6D0eyFkRzhrCYPwpJtPsOW2o1qt8/qp6HN/I69yTpQw
   uCvECUfY+quXEM8TIg+O+x1EnKE/GXtypSInyueSzfenbS4fkpC7z/WnZ
   Q=;
IronPort-SDR: 30NsRcnARozR/Uc6WsKhPAFuJyxy+t/RSpGuBL644DYcwN95dwD2oleBbREdwozQROzaDzkK6r
 17gBenfr+dNA==
X-IronPort-AV: E=Sophos;i="5.72,294,1580774400"; 
   d="scan'208";a="34177979"
Subject: Re: [RFC PATCH] arch/x86: Optionally flush L1D on context switch
Thread-Topic: [RFC PATCH] arch/x86: Optionally flush L1D on context switch
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 23 Mar 2020 00:12:19 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS id DA0411A2690;
        Mon, 23 Mar 2020 00:12:18 +0000 (UTC)
Received: from EX13D21UWB001.ant.amazon.com (10.43.161.108) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 23 Mar 2020 00:12:18 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13D21UWB001.ant.amazon.com (10.43.161.108) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 23 Mar 2020 00:12:18 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Mon, 23 Mar 2020 00:12:18 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "Herrenschmidt, Benjamin" <benh@amazon.com>,
        "luto@amacapital.net" <luto@amacapital.net>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>
Thread-Index: AQHWAAfovHet9Ckh+EOPVKUzEeayuKhUt/uAgACXYAA=
Date:   Mon, 23 Mar 2020 00:12:18 +0000
Message-ID: <f5f6bca2ccbbd3d5a82209a02ebf64834d1fe8fb.camel@amazon.com>
References: <99ef5eec8502a7b53eee362063b9b2252a5a47da.camel@amazon.com>
         <A38682A4-62B2-4849-ADEA-196DFF4D36C9@amacapital.net>
In-Reply-To: <A38682A4-62B2-4849-ADEA-196DFF4D36C9@amacapital.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B36C9B7CFB3A4A4AB5261D767F7ADAF2@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIwLTAzLTIyIGF0IDA4OjEwIC0wNzAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6
DQo+IA0KPiA+IEkgc3RpbGwgdGhpbmsgZmx1c2hpbmcgdGhlICJoaWdoIHZhbHVlIiBwcm9jZXNz
IEwxRCBvbiBzd2l0Y2hfbW0gb3V0IGlzDQo+ID4gdGhlIHdheSB0byBnbyBoZXJlLi4uDQo+IA0K
PiBMZXQgbWUgdHJ5IHRvIHVuZGVyc3RhbmQgdGhlIGlzc3VlLiBUaGVyZSBpcyBzb21lIGhpZ2gt
dmFsdWUgZGF0YSwgYW5kIHRoYXQNCj4gZGF0YSBpcyBvd25lZCBieSBhIGhpZ2gtdmFsdWUgcHJv
Y2Vzcy4gQXQgc29tZSBwb2ludCwgdGhlIGRhdGEgZW5kcyB1cCBpbg0KPiBMMUQuICBMYXRlciBp
biwgZXZpbCBjb2RlIHJ1bnMgYW5kIG1heSBhdHRlbXB0IHRvIGV4ZmlsdHJhdGUgIHRoYXQgZGF0
YSBmcm9tDQo+IEwxRCB1c2luZyBhIHNpZGUgY2hhbm5lbC4gKFRoZSBldmlsIGNvZGUgaXMgbm90
IG5lY2Vzc2FyaWx5IGluIGEgbWFsaWNpb3VzDQo+IHByb2Nlc3MgY29udGV4dC4gSXQgY291bGQg
YmUga2VybmVsIGNvZGUgdGFyZ2V0ZWQgYnkgTFZJIG9yIHNpbWlsYXIuIEl0DQo+IGNvdWxkIGJl
IG9yZGluYXJ5IGNvZGUgdGhhdCBoYXBwZW5zIHRvIGNvbnRhaW4gYSBzaWRlIGNoYW5uZWwgZ2Fk
Z2V0IGJ5DQo+IGFjY2lkZW50LikNCj4gDQo+IFNvIHRoZSBpZGVhIGlzIHRvIGZsdXNoIEwxRCBh
ZnRlciBtYW5pcHVsYXRpbmcgaGlnaC12YWx1ZSBkYXRhIGFuZCBiZWZvcmUNCj4gcnVubmluZyBl
dmlsIGNvZGUuDQo+IA0KPiBUaGUgbmFzdHkgcGFydCBoZXJlIGlzIHRoYXQgd2UgZG9u4oCZdCBo
YXZlIGEgZ29vZCBoYW5kbGUgb24gd2hlbiBMMUQgaXMNCj4gZmlsbGVkIGFuZCB3aGVuIHRoZSBl
dmlsIGNvZGUgcnVucy4gSWYgdGhlIGV2aWwgY29kZSBpcyB1bnRydXN0ZWQgcHJvY2Vzcw0KPiB1
c2Vyc3BhY2UgYW5kIHRoZSBmaWxsIGlzIGFuIGludGVycnVwdCwgdGhlbiBzd2l0Y2hfbW0gaXMg
dXNlbGVzcyBhbmQgd2UNCj4gd2FudCB0byBmbHVzaCBvbiBrZXJuZWwgZXhpdCBpbnN0ZWFkLiBJ
ZiB0aGUgZmlsbCBhbmQgZXZpbCBjb2RlIGFyZSBib3RoDQo+IHVzZXJzcGFjZSwgdGhlbiBzd2l0
Y2hfbW0gaXMgcHJvYmFibHkgdGhlIHJpZ2h0IGNob2ljZSwgYnV0DQo+IHByZXBhcmVfZXhpdF9m
cm9tX3VzZXJtb2RlIHdvcmtzIHRvby4gSWYgU01UIGlzIG9uLCB3ZSBsb3NlIG5vIG1hdHRlcg0K
PiB3aGF0LiAgSWYgdGhlIGV2aWwgY29kZSBpcyBpbiBrZXJuZWwgY29udGV4dCwgdGhlbiBpdOKA
mXMgbm90IGNsZWFyIHdoYXQgdG8NCj4gZG8uIElmIHRoZSBmaWxsIGFuZCB0aGUgZXZpbCBjb2Rl
IGFyZSBib3RoIGluIGtlcm5lbCB0aHJlYWRzIChoaSwgaW9fdXJpbmcpLA0KPiB0aGVuIEnigJlt
IG5vdCBhdCBhbGwgc3VyZSB3aGF0IHRvIGRvLg0KPiANCj4gSW4gc3VtbWFyeSwga2VybmVsIGV4
aXQgc2VlbXMgc3Ryb25nZXIsIGJ1dCB0aGUgcmlnaHQgYW5zd2VyIGlzbuKAmXQgc28gY2xlYXIu
DQo+IA0KPiBXZSBjb3VsZCBkbyBhbiBvcHRpbWl6ZWQgdmFyaWFudCB3aGVyZSB3ZSBmbHVzaCBh
dCBrZXJuZWwgZXhpdCBidXQgd2UNCj4gKmRlY2lkZSogdG8gZmx1c2ggaW4gc3dpdGNoX21tLg0K
DQpJIHRoaW5rIHRoZSBrZXkgcXVlc3Rpb24gaW4gdGhlIExWSSBjYXNlIHdvdWxkIGJlLCBpcyBp
dCBwb3NzaWJsZSB0byBkbyBhbiBMVkkNCmluIGEga2VybmVsIGNvbnRleHQ/IElmIHRoZSBhbnN3
ZXIgaXMgbm8sIHN3aXRjaF9tbSgpIGlzIHN1ZmZpY2llbnQsIGJ1dCBmb3INCm5vdyB0aGVzZSBw
YXRjaGVzIGZvY3VzIG9uIGZsdXNoaW5nIEwxRCBvbiB0YXNrIGV4aXQsIHdlIGNvdWxkIGFkZCB0
aGUgdXNlDQpjYXNlIGZvciBMVkkgKHdoaWNoIGlzIGNhbGxlZCBvdXQpDQoNCkJhbGJpciBTaW5n
aC4NCg==
