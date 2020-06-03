Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E5FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 22:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AD60205CB
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 22:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="t9SF+hFG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgFCWPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 18:15:06 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:35126 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgFCWPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 18:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591222505; x=1622758505;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=5CLSuOEl6kp/m5zDZRq2EDb6vpTaiAn/I7znqlFCqRY=;
  b=t9SF+hFGwzTfoiCbxLHf2EDQheZlL+qoNjZASafbJW5q8OQV2WpjORJz
   tMCX5+KQbdHvOUSnmCbstcm916ssJlpnXfDSZAKFFXqTJhKQvacS3gwIU
   ncqpduhgI5/j+2Ukn1Zrs0RdOuJkIAxZJeh0tG0rlN0rSuSEKS/9yCg7+
   M=;
IronPort-SDR: 7hvDfCXNo8Vr7FgXXyGQZNr75iNAVfSbjODKi+Nx9uHtlKKxhu1o9kNG4QhtvP3RxxpPGjN+i0
 TO8KiY5N0iCA==
X-IronPort-AV: E=Sophos;i="5.73,470,1583193600"; 
   d="scan'208";a="35664223"
Subject: Re: [PATCH] irqchip/gic-v3-its: Don't try to move a disabled irq
Thread-Topic: [PATCH] irqchip/gic-v3-its: Don't try to move a disabled irq
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-baacba05.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 03 Jun 2020 22:14:52 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-baacba05.us-west-2.amazon.com (Postfix) with ESMTPS id 16D47A17E3;
        Wed,  3 Jun 2020 22:14:51 +0000 (UTC)
Received: from EX13D02UWB003.ant.amazon.com (10.43.161.48) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Jun 2020 22:14:50 +0000
Received: from EX13D21UWB003.ant.amazon.com (10.43.161.212) by
 EX13D02UWB003.ant.amazon.com (10.43.161.48) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Jun 2020 22:14:50 +0000
Received: from EX13D21UWB003.ant.amazon.com ([10.43.161.212]) by
 EX13D21UWB003.ant.amazon.com ([10.43.161.212]) with mapi id 15.00.1497.006;
 Wed, 3 Jun 2020 22:14:50 +0000
From:   "Herrenschmidt, Benjamin" <benh@amazon.com>
To:     "maz@kernel.org" <maz@kernel.org>,
        "Saidi, Ali" <alisaidi@amazon.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Zilberman, Zeev" <zeev@amazon.com>,
        "Machulsky, Zorik" <zorik@amazon.com>
Thread-Index: AQHWOQ5TND6+7PCCIEqxmbZ5Z514UqjHAeMAgAB0yQA=
Date:   Wed, 3 Jun 2020 22:14:50 +0000
Message-ID: <f9e9d8c37eb92e4b9576bfcb4386ff6ef00eddce.camel@amazon.com>
References: <AE04B507-C5E2-44D2-9190-41E9BE720F9D@amazon.com>
         <622fb6be108e894ee365d6b213535c8b@kernel.org>
In-Reply-To: <622fb6be108e894ee365d6b213535c8b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.100]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C15F2A7576D9BC408321F94A140F8E8E@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA2LTAzIGF0IDE2OjE2ICswMTAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
ID4gTXkgb3JpZ2luYWwgcGF0Y2ggc2hvdWxkIGNlcnRhaW4gY2hlY2sgYWN0aXZhdGVkIGFuZCBu
b3QgZGlzYWJsZWQuDQo+ID4gV2l0aCB0aGF0IGRvIHlvdSBzdGlsbCBoYXZlIHJlc2VydmF0aW9u
cyBNYXJjPw0KPiANCj4gSSdkIHN0aWxsIHByZWZlciBpdCBpZiB3ZSBjb3VsZCBkbyBzb21ldGhp
bmcgaW4gY29yZSBjb2RlLCByYXRoZXINCj4gdGhhbiBzcHJlYWRpbmcgdGhlc2UgY2hlY2tzIGlu
IHRoZSBpbmRpdmlkdWFsIGRyaXZlcnMuIElmIHdlIGNhbid0LA0KPiBmYWlyIGVub3VnaC4gQnV0
IGl0IGZlZWxzIGxpa2UgdGhlIGNvcmUgc2V0X2FmZmluaXR5IGZ1bmN0aW9uIGNvdWxkDQo+IGp1
c3QgZG8gdGhlIHNhbWUgdGhpbmcgaW4gYSBzaW5nbGUgcGxhY2UgKGFsdGhvdWdoIHRoZSBzdGFy
dGVkIHZzDQo+IGFjdGl2YXRlZCBpcyB5ZXQgYW5vdGhlciBwaWVjZSBvZiB0aGUgcHV6emxlIEkg
ZGlkbid0IGNvbnNpZGVyLA0KPiBhbmQgdGhlIElUUyBkb2Vzbid0IG5lZWQgdGhlICJjYW5fcmVz
ZXJ2ZSIgdGhpbmcpLg0KDQpGb3IgdGhlIHNha2Ugb2YgZml4aW5nIHRoZSBwcm9ibGVtIGluIGEg
dGltZWx5IGFuZCBiYWNrcG9ydGFibGUgd2F5IEkNCndvdWxkIHN1Z2dlc3QgZmlyc3QgbWVyZ2lu
ZyB0aGUgZml4LCAqdGhlbiogZml4aW5nIHRoZSBjb3JlIGNvcmUuDQoNCkNoZWVycywNCkJlbi4N
Cg==
