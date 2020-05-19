Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774FDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 23:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ABC520674
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 23:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IcOQERvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgESXll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 19:41:41 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:18724 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgESXlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 19:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589931699; x=1621467699;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IbofWm/iMK1clAzyzSw2peC3VqkfUtxWdtzUMhauRHg=;
  b=IcOQERvZLpaLBjlINgQ/Ozi5CeP56g2auc46asNOtP2cgT1KuNzKoDo0
   GTF3aWELkyYXEODo8KYmZx1ROe3t+jfe94dByTU3GKwQ+paeFJTozKoz/
   WgCFvt6cDOa9ZB9G+joaQsGhkf3ZXFF5NidIC7y5GX9UV+H/3VD5HfeHr
   g=;
IronPort-SDR: T2gMicTsA/YT1+502F/BdDjy6yNGh0uOnQy64MbhC76QxzxW4whNhw+NBv0bmUGwIrqbQmDqwn
 7G6ahSvy7dpw==
X-IronPort-AV: E=Sophos;i="5.73,411,1583193600"; 
   d="scan'208";a="32498591"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 19 May 2020 23:41:27 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (Postfix) with ESMTPS id E6358A0360;
        Tue, 19 May 2020 23:41:24 +0000 (UTC)
Received: from EX13D01UWB003.ant.amazon.com (10.43.161.94) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 19 May 2020 23:41:24 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB003.ant.amazon.com (10.43.161.94) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 19 May 2020 23:41:23 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Tue, 19 May 2020 23:41:23 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "keescook@chromium.org" <keescook@chromium.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
Subject: Re:  [PATCH v2 3/4] arch/x86: Optionally flush L1D on context switch
Thread-Topic: [PATCH v2 3/4] arch/x86: Optionally flush L1D on context switch
Thread-Index: AQHWLjcBCjTHsBVi1Ear3DlyXwRTeA==
Date:   Tue, 19 May 2020 23:41:23 +0000
Message-ID: <1236b19be51d0d47ba73016b2bac352983107ce9.camel@amazon.com>
References: <20200406031946.11815-1-sblbir@amazon.com>
         <20200406031946.11815-4-sblbir@amazon.com> <202004071125.605F665@keescook>
In-Reply-To: <202004071125.605F665@keescook>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.26]
Content-Type: text/plain; charset="utf-8"
Content-ID: <00FAC354435987408F59F82E70E2817A@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA0LTA3IGF0IDExOjI2IC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IA0K
PiANCj4gT24gTW9uLCBBcHIgMDYsIDIwMjAgYXQgMDE6MTk6NDVQTSArMTAwMCwgQmFsYmlyIFNp
bmdoIHdyb3RlOg0KPiA+IEltcGxlbWVudCBhIG1lY2hhbmlzbSB0byBzZWxlY3RpdmVseSBmbHVz
aCB0aGUgTDFEIGNhY2hlLiBUaGUgZ29hbCBpcyB0bw0KPiA+IGFsbG93IHRhc2tzIHRoYXQgYXJl
IHBhcmFub2lkIGR1ZSB0byB0aGUgcmVjZW50IHNub29wIGFzc2lzdGVkIGRhdGEgc2FtcGxpbmcN
Cj4gPiB2dWxuZXJhYmlsaXRlcywgdG8gZmx1c2ggdGhlaXIgTDFEIG9uIGJlaW5nIHN3aXRjaGVk
IG91dC4gIFRoaXMgcHJvdGVjdHMNCj4gPiB0aGVpciBkYXRhIGZyb20gYmVpbmcgc25vb3BlZCBv
ciBsZWFrZWQgdmlhIHNpZGUgY2hhbm5lbHMgYWZ0ZXIgdGhlIHRhc2sNCj4gPiBoYXMgY29udGV4
dCBzd2l0Y2hlZCBvdXQuDQo+ID4gDQo+ID4gVGhlcmUgYXJlIHR3byBzY2VuYXJpb3Mgd2UgbWln
aHQgd2FudCB0byBwcm90ZWN0IGFnYWluc3QsIGEgdGFzayBsZWF2aW5nDQo+ID4gdGhlIENQVSB3
aXRoIGRhdGEgc3RpbGwgaW4gTDFEICh3aGljaCBpcyB0aGUgbWFpbiBjb25jZXJuIG9mIHRoaXMg
cGF0Y2gpLA0KPiA+IHRoZSBzZWNvbmQgc2NlbmFyaW8gaXMgYSBtYWxpY2lvdXMgdGFzayBjb21p
bmcgaW4gKG5vdCBzbyB3ZWxsIHRydXN0ZWQpDQo+ID4gZm9yIHdoaWNoIHdlIHdhbnQgdG8gY2xl
YW4gdXAgdGhlIGNhY2hlIGJlZm9yZSBpdCBzdGFydHMuIE9ubHkgdGhlIGNhc2UNCj4gPiBmb3Ig
dGhlIGZvcm1lciBpcyBhZGRyZXNzZWQuDQo+ID4gDQo+ID4gQWRkIGFyY2ggc3BlY2lmaWMgcHJj
dGwoKSdzIHRvIG9wdC1pbiB0byB0aGUgTDFEIGNhY2hlIG9uIGNvbnRleHQgc3dpdGNoDQo+ID4g
b3V0LCB0aGUgZXhpc3RpbmcgbWVjaGFuaXNtcyBvZiB0cmFja2luZyBwcmV2X21tIHZpYSBjcHVf
dGxic3RhdGUgaXMNCj4gPiByZXVzZWQuIGNvbmRfaWJwYigpIGlzIHJlZmFjdG9yZWQgYW5kIHJl
bmFtZWQgaW50byBjb25kX21pdGlnYXRpb24oKS4NCj4gDQo+IEkgc3RpbGwgdGhpbmsgdGhpcyBz
aG91bGQgYmUgYSBnZW5lcmljIHByY3RsKCkuIElmIHRoZXJlIGlzIGEgc3Ryb25nDQo+IHJlYXNv
biBub3QgdG8gZG8gdGhpcywgY2FuIGl0IGJlIGRlc2NyaWJlZCBpbiB0aGUgY29tbWl0IGxvZyBo
ZXJlPw0KDQpLZWVzLCB0aGUgY29udGV4dCBpbiB0aGUgY2hhbmdlbG9nIG1pZ2h0IGJlIG1pc2xl
YWRpbmcsIHRoZSBwcmN0bCBpcyBnZW5lcmljLA0KdGhlIGltcGxlbWVudGF0aW9uIGlzIGFyY2gg
c3BlY2lmaWMgYXMgeW91IGNhbiBzZWUgZnJvbSB0aGUgZm9sbG93aW5nIHBhdGNoZXMuDQpJIGNh
biByZXdvcmQgdGhlIGNoYW5nZSBsb2csIHNvcnJ5IGZvciB0aGUgY29uZnVzaW9uLg0KDQpCYWxi
aXIgU2luZ2guDQoNCg0K
