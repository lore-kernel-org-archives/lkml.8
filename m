Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28EBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEB3D207ED
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pmejnNdx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgFKRov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 13:44:51 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:54274 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbgFKRou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 13:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591897489; x=1623433489;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=hYy65WZWY0Gm1TUqJpFUNLrDmRSr18zMfrjQrVGpTrQ=;
  b=pmejnNdxuXm161oCsDgi65pp6w3lqgz/Hpl9GqRhIjS3uMe+6rhT6Tot
   fIcxF4krYNFmfJmZXo3763Pjpjcmtx+16sVkkOoCN8vJld1ZGdY+A8lmx
   RZWrhjbCyoqJ4BL1xLtitBRKL7hq7JQhN833fuzCRgBuhv2efuXPyBu4p
   0=;
IronPort-SDR: qOaW2ePJmsiii5oVjAcRlQ7W29PwfNE8RGXHhEta7Gh7D4RFYgjpFUyHuafo3Vfn3zqYBszQ26
 0rbq4H78+gxg==
X-IronPort-AV: E=Sophos;i="5.73,500,1583193600"; 
   d="scan'208";a="37125348"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 11 Jun 2020 17:44:48 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id 4F298240E4F;
        Thu, 11 Jun 2020 17:44:46 +0000 (UTC)
Received: from EX13D21UWB003.ant.amazon.com (10.43.161.212) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 11 Jun 2020 17:44:46 +0000
Received: from EX13D02UWC004.ant.amazon.com (10.43.162.236) by
 EX13D21UWB003.ant.amazon.com (10.43.161.212) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 11 Jun 2020 17:44:46 +0000
Received: from EX13D02UWC004.ant.amazon.com ([10.43.162.236]) by
 EX13D02UWC004.ant.amazon.com ([10.43.162.236]) with mapi id 15.00.1497.006;
 Thu, 11 Jun 2020 17:44:45 +0000
From:   "Saidi, Ali" <alisaidi@amazon.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Herrenschmidt, Benjamin" <benh@amazon.com>,
        "maz@kernel.org" <maz@kernel.org>
CC:     "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Zilberman, Zeev" <zeev@amazon.com>,
        "Machulsky, Zorik" <zorik@amazon.com>
Subject: Re: [PATCH] irqchip/gic-v3-its: Don't try to move a disabled irq
Thread-Topic: [PATCH] irqchip/gic-v3-its: Don't try to move a disabled irq
Thread-Index: AQHWQBf+D56KE2y9NkWmPnFhz9cMFg==
Date:   Thu, 11 Jun 2020 17:44:45 +0000
Message-ID: <24FB929B-CE0F-4B9D-8064-146A0CE0A15D@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.26]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A984A1D31FA44D438F9D433DE2F27473@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQrvu79PbiA2LzgvMjAsIDg6NDkgQU0sICJUaG9tYXMgR2xlaXhuZXIiIDx0Z2x4QGxpbnV0cm9u
aXguZGU+IHdyb3RlOg0KICAgIA0KICAgIA0KICAgICJIZXJyZW5zY2htaWR0LCBCZW5qYW1pbiIg
PGJlbmhAYW1hem9uLmNvbT4gd3JpdGVzOg0KICAgID4gT24gV2VkLCAyMDIwLTA2LTAzIGF0IDE2
OjE2ICswMTAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQogICAgPj4gPiBNeSBvcmlnaW5hbCBwYXRj
aCBzaG91bGQgY2VydGFpbiBjaGVjayBhY3RpdmF0ZWQgYW5kIG5vdCBkaXNhYmxlZC4NCiAgICA+
PiA+IFdpdGggdGhhdCBkbyB5b3Ugc3RpbGwgaGF2ZSByZXNlcnZhdGlvbnMgTWFyYz8NCiAgICA+
Pg0KICAgID4+IEknZCBzdGlsbCBwcmVmZXIgaXQgaWYgd2UgY291bGQgZG8gc29tZXRoaW5nIGlu
IGNvcmUgY29kZSwgcmF0aGVyDQogICAgPj4gdGhhbiBzcHJlYWRpbmcgdGhlc2UgY2hlY2tzIGlu
IHRoZSBpbmRpdmlkdWFsIGRyaXZlcnMuIElmIHdlIGNhbid0LA0KICAgID4+IGZhaXIgZW5vdWdo
LiBCdXQgaXQgZmVlbHMgbGlrZSB0aGUgY29yZSBzZXRfYWZmaW5pdHkgZnVuY3Rpb24gY291bGQN
CiAgICA+PiBqdXN0IGRvIHRoZSBzYW1lIHRoaW5nIGluIGEgc2luZ2xlIHBsYWNlIChhbHRob3Vn
aCB0aGUgc3RhcnRlZCB2cw0KICAgID4+IGFjdGl2YXRlZCBpcyB5ZXQgYW5vdGhlciBwaWVjZSBv
ZiB0aGUgcHV6emxlIEkgZGlkbid0IGNvbnNpZGVyLA0KICAgID4+IGFuZCB0aGUgSVRTIGRvZXNu
J3QgbmVlZCB0aGUgImNhbl9yZXNlcnZlIiB0aGluZykuDQogICAgPg0KICAgID4gRm9yIHRoZSBz
YWtlIG9mIGZpeGluZyB0aGUgcHJvYmxlbSBpbiBhIHRpbWVseSBhbmQgYmFja3BvcnRhYmxlIHdh
eSBJDQogICAgPiB3b3VsZCBzdWdnZXN0IGZpcnN0IG1lcmdpbmcgdGhlIGZpeCwgKnRoZW4qIGZp
eGluZyB0aGUgY29yZSBjb3JlLg0KICAgIA0KICAgIFRoZSAiZml4IiBpcyBqdXN0IHdyb25nDQog
ICAgDQogICAgPiAgICAgICBpZiAoY3B1ICE9IGl0c19kZXYtPmV2ZW50X21hcC5jb2xfbWFwW2lk
XSkgew0KICAgID4gICAgICAgICAgICAgICB0YXJnZXRfY29sID0gJml0c19kZXYtPml0cy0+Y29s
bGVjdGlvbnNbY3B1XTsNCiAgICA+IC0gICAgICAgICAgICAgaXRzX3NlbmRfbW92aShpdHNfZGV2
LCB0YXJnZXRfY29sLCBpZCk7DQogICAgPiArDQogICAgPiArICAgICAgICAgICAgIC8qIElmIHRo
ZSBJUlEgaXMgZGlzYWJsZWQgYSBkaXNjYXJkIHdhcyBzZW50IHNvIGRvbid0IG1vdmUgKi8NCiAg
ICA+ICsgICAgICAgICAgICAgaWYgKCFpcnFkX2lycV9kaXNhYmxlZChkKSkNCiAgICANCiAgICBU
aGF0IGNoZWNrIG5lZWRzIHRvIGJlICFpcnFkX2lzX2FjdGl2YXRlZCgpIGJlY2F1c2UgZW5hYmxl
X2lycSgpIGRvZXMNCiAgICBub3QgdG91Y2ggYW55dGhpbmcgYWZmaW5pdHkgcmVsYXRlZC4NCiAg
ICANCiAgICA+ICsgICAgICAgICAgICAgICAgICAgICBpdHNfc2VuZF9tb3ZpKGl0c19kZXYsIHRh
cmdldF9jb2wsIGlkKTsNCiAgICA+ICsNCiAgICA+ICAgICAgICAgICAgICAgaXRzX2Rldi0+ZXZl
bnRfbWFwLmNvbF9tYXBbaWRdID0gY3B1Ow0KICAgID4gICAgICAgICAgICAgICBpcnFfZGF0YV91
cGRhdGVfZWZmZWN0aXZlX2FmZmluaXR5KGQsIGNwdW1hc2tfb2YoY3B1KSk7DQogICAgDQogICAg
QW5kIHRoZW4gdGhlc2UgYXNzb2NpdGF0aW9ucyBhcmUgZGlzY29ubmVjdGVkIGZyb20gcmVhbGl0
eSBpbiBhbnkgY2FzZS4NCiAgICANCiAgICBTb21ldGhpbmcgbGlrZSB0aGUgY29tcGxldGVseSB1
bnRlc3RlZCBwYXRjaCBiZWxvdyBzaG91bGQgd29yay4NCg0KSSd2ZSBiZWVuIHVuYWJsZSB0byBy
ZXByb2R1Y2UgdGhlIHByb2JsZW0gd2l0aCB5b3VyIHBhdGNoIG9uIGFuIEFybSBzeXN0ZW0uDQoN
ClRoYW5rcywNCg0KQWxpDQoNCg0KDQo=
