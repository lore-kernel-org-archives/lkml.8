Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF63C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5E520678
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DfcbS0Ec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388164AbgDBUfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 16:35:54 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:24686 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbgDBUfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 16:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585859753; x=1617395753;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=/AMe5jtWvL4jnCf4DQWrkvz+agPOIGzaDNZ89UTBJo0=;
  b=DfcbS0Ec3Z/c1TxDJ49bfczSgFsABQzp6es9c3Yp8cWhmjmtVn5lrawx
   ahgB6vqe7Y4OvQ6yirOVkoP2U52lUQTXaQt/stfHjfHHDByPHL/cVdeHY
   GeNUdrraGoJc3IP1o3sf70VoUBhbnCR+NXdvvaadGBGYiswlvmdvpqqfF
   Y=;
IronPort-SDR: kpS8uj1f1Ls8HuyFfoJ0Bw2Di3PD7hbv2msHR46lCFkUsSmlEqmo7Dtnz7RPkorXNxRasyuiWL
 Xx0HmnUjbe0A==
X-IronPort-AV: E=Sophos;i="5.72,336,1580774400"; 
   d="scan'208";a="36371078"
Subject: Re: [PATCH 0/3] arch/x86: Optionally flush L1D on context switch
Thread-Topic: [PATCH 0/3] arch/x86: Optionally flush L1D on context switch
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 02 Apr 2020 20:35:50 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id 6A282A30EB;
        Thu,  2 Apr 2020 20:35:47 +0000 (UTC)
Received: from EX13D01UWB004.ant.amazon.com (10.43.161.157) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 2 Apr 2020 20:35:46 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB004.ant.amazon.com (10.43.161.157) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 2 Apr 2020 20:35:46 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Thu, 2 Apr 2020 20:35:46 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "jpoimboe@redhat.com" <jpoimboe@redhat.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
Thread-Index: AQHWCLef4bwaosvK0kiEVSQik6PTPKhmROgAgAAGOQA=
Date:   Thu, 2 Apr 2020 20:35:46 +0000
Message-ID: <31c9720eff18ce167378e9a0017dcd73e0552164.camel@amazon.com>
References: <20200402062401.29856-1-sblbir@amazon.com>
         <20200402201328.zqnxwaetpk4ubg56@treble>
In-Reply-To: <20200402201328.zqnxwaetpk4ubg56@treble>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.65]
Content-Type: text/plain; charset="utf-8"
Content-ID: <686FB9B2CCB0D6428F002ABED8171883@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA0LTAyIGF0IDE1OjEzIC0wNTAwLCBKb3NoIFBvaW1ib2V1ZiB3cm90ZToN
Cj4gQ0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3Jn
YW5pemF0aW9uLiBEbyBub3QNCj4gY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxl
c3MgeW91IGNhbiBjb25maXJtIHRoZSBzZW5kZXIgYW5kIGtub3cNCj4gdGhlIGNvbnRlbnQgaXMg
c2FmZS4NCj4gDQo+IA0KPiANCj4gT24gVGh1LCBBcHIgMDIsIDIwMjAgYXQgMDU6MjM6NThQTSAr
MTEwMCwgQmFsYmlyIFNpbmdoIHdyb3RlOg0KPiA+IFByb3ZpZGUgYSBtZWNoYW5pc24gdG8gZmx1
c2ggdGhlIEwxRCBjYWNoZSBvbiBjb250ZXh0IHN3aXRjaC4gIFRoZSBnb2FsDQo+ID4gaXMgdG8g
YWxsb3cgdGFza3MgdGhhdCBhcmUgcGFyYW5vaWQgZHVlIHRvIHRoZSByZWNlbnQgc25vb3AgYXNz
aXN0ZWQgZGF0YQ0KPiA+IHNhbXBsaW5nIHZ1bG5lcmFiaWxpdGVzLCB0byBmbHVzaCB0aGVpciBM
MUQgb24gYmVpbmcgc3dpdGNoZWQgb3V0Lg0KPiANCj4gSGkgQmFsYmlyLA0KPiANCj4gSnVzdCBj
dXJpb3VzLCBpcyBpdCByZWFsbHkgdnVsbmVyYWJpbGl0aWVzLCBwbHVyYWw/ICBJIHRob3VnaHQg
dGhlcmUgd2FzDQo+IG9ubHkgb25lOiBDVkUtMjAyMC0wNTUwIChTbm9vcC1hc3Npc3RlZCBMMSBE
YXRhIFNhbXBsaW5nKS4NCj4gDQo+IChUaGVyZSB3YXMgYSBzaW1pbGFyIG9uZSB3aXRob3V0IHRo
ZSAic25vb3AiOiBMMUQgRXZpY3Rpb24gU2FtcGxpbmcsIGJ1dA0KPiBpdCdzIHN1cHBvc2VkIHRv
IGdldCBmaXhlZCBpbiBtaWNyb2NvZGUpLg0KPiANCg0KSGksIEpvc2gNCg0KWWVzLCB0aGF0IENW
RSB0aGUgbW90aXZhdGlvbiwgdGhlIG1pdGlnYXRpb24gZm9yIENWRS0yMDIwLTA1NTAgZG9lcyBz
dWdnZXN0DQpmbHVzaGluZyB0aGUgY2FjaGUgb24gY29udGV4dCBzd2l0Y2guIEJ1dCBpbiBnZW5l
cmFsLCBhcyB3ZSBiZWdpbiB0byBmaW5kIG1vcmUNCndheXMgb2YgZXZpY3RpbmcgZGF0YSBvciBz
bm9wcGluZyBkYXRhLCBhIGdlbmVyaWMgbWVjaGFuaXNtIGlzIG1vcmUgdXNlZnVsIGFuZA0KdGhh
dCBpcyB3aHkgSSBhbSBtYWtpbmcgaXQgYW4gb3B0LWluLg0KDQpCYWxiaXIgU2luZ2guDQo=
