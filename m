Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CE7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3A6D206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="APoDLN1H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgENIYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 04:24:34 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:7167 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgENIYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 04:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589444671; x=1620980671;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Y+cXdg9Qo1H96MCRH7eYIOX2wOTvR23creB9YMwHzfU=;
  b=APoDLN1HHwGrOnYzqKOqTf7X4FeR2JjxaDvsznHQnGSkU0WXUzXeNeB0
   IkYiTn2hecW//v/22yA2KQ4PVXizu9Y60AS8zNc1E8P6g4EtHBB5bvtO2
   NTvxwXksf4Iqt5ITpTJ+mU86W4OhDW9J7XpsPQZoj0VG0ylnWgbcJQtaG
   c=;
IronPort-SDR: Xu+2oUY3Iw1hkCFXsh+6slLDlFF6J6naMpRbcGMolQd8boxqI+Gh7mDZwCfotKFfD0wJnNH1jQ
 8krGVkNqAv2A==
X-IronPort-AV: E=Sophos;i="5.73,390,1583193600"; 
   d="scan'208";a="30273858"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 14 May 2020 08:24:17 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS id 7D41E1A0BA0;
        Thu, 14 May 2020 08:24:16 +0000 (UTC)
Received: from EX13D01UWB003.ant.amazon.com (10.43.161.94) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 14 May 2020 08:23:55 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB003.ant.amazon.com (10.43.161.94) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 14 May 2020 08:23:55 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Thu, 14 May 2020 08:23:55 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
Subject: Re:  [PATCH v6 1/6] arch/x86/kvm: Refactor l1d flush lifecycle
 management
Thread-Topic: [PATCH v6 1/6] arch/x86/kvm: Refactor l1d flush lifecycle
 management
Thread-Index: AQHWKckBKZ/YfhdRx0ysPvoF1MaPYw==
Date:   Thu, 14 May 2020 08:23:54 +0000
Message-ID: <97582933b9df4cecc460a0d5af21e333f8149173.camel@amazon.com>
References: <20200510014803.12190-1-sblbir@amazon.com>
         <20200510014803.12190-2-sblbir@amazon.com>
         <87o8qs2c10.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87o8qs2c10.fsf@nanos.tec.linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.215]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B8C10832EE76247BF555B777AF9E72D@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA1LTEzIGF0IDE1OjM1ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9y
Z2FuaXphdGlvbi4gRG8NCj4gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSBjYW4gY29uZmlybSB0aGUgc2VuZGVyDQo+IGFuZCBrbm93IHRoZSBjb250ZW50IGlz
IHNhZmUuDQo+IA0KPiANCj4gDQo+IEJhbGJpciBTaW5naCA8c2JsYmlyQGFtYXpvbi5jb20+IHdy
aXRlczoNCj4gDQo+ID4gU3ViamVjdDogW1BBVENIIHY2IDEvNl0gYXJjaC94ODYva3ZtOiBSZWZh
Y3Rvci4uLi4NCj4gDQo+IGFyY2gveDg2L2t2bTogaXMgcmVhbGx5IG5vdCB0aGUgY29ycmVjdCBz
dWJzeXN0ZW0gcHJlZml4Li4uDQo+IA0KPiBJJ2xsIGZpeCBpdCB1cCB0aGlzIHRpbWUuDQoNClRo
YW5rcywgbm90ZWQhDQoNCkJhbGJpciBTaW5naC4NCg==
