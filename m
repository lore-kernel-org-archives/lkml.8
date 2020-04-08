Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BB6C2D0EC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 00:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC2A20747
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 00:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mrCcAyRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgDHAOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 20:14:11 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:15390 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgDHAOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 20:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1586304850; x=1617840850;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HldeFSSVUi4kbdiD8texuja1d//0E3JziItUIw9NKbU=;
  b=mrCcAyRvqeaT0FWIwpzEdeoFspcrYhzeF9eYe/AsK7QlmVGoCiSBuSWq
   xmJjk4eVnNYWN+xaIGIVZWzDBXmuvsIMRvN/IdZihdHwYta5xGinBhRFV
   Hdg7iSQ0CVkx+ugm0mIVrMjOQhEpJOv7zPkrkwqyz4j3lqGqbFkEaNCnX
   Y=;
IronPort-SDR: 07C6nRvRXabtPud/3zjaww/pOxYGPeR6gV0ZMU/NLunb3OqBFfqMpP3v9lID2H9euqX/VORd9/
 2OhhcO883Fzg==
X-IronPort-AV: E=Sophos;i="5.72,357,1580774400"; 
   d="scan'208";a="37263382"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 08 Apr 2020 00:14:08 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (Postfix) with ESMTPS id 5A68AA1F1A;
        Wed,  8 Apr 2020 00:14:08 +0000 (UTC)
Received: from EX13D01UWB004.ant.amazon.com (10.43.161.157) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 8 Apr 2020 00:14:04 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB004.ant.amazon.com (10.43.161.157) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 8 Apr 2020 00:14:04 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Wed, 8 Apr 2020 00:14:04 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
Subject: Re: [PATCH v2 3/4] arch/x86: Optionally flush L1D on context switch
Thread-Topic: [PATCH v2 3/4] arch/x86: Optionally flush L1D on context switch
Thread-Index: AQHWDTqcWcoKwxiYQkqA/bhLw4lsnQ==
Date:   Wed, 8 Apr 2020 00:14:04 +0000
Message-ID: <a20d9668aeb48e385fa6e6daf18d356bd087f11b.camel@amazon.com>
References: <20200406031946.11815-1-sblbir@amazon.com>
         <20200406031946.11815-4-sblbir@amazon.com>
         <87v9maj1kx.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87v9maj1kx.fsf@nanos.tec.linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.155]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A71A75E4CEEC7E4FAE373FCC81411526@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA0LTA4IGF0IDAxOjUyICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IA0KPiBCYWxiaXIsDQo+IA0KPiBCYWxiaXIgU2luZ2ggPHNibGJpckBhbWF6b24uY29tPiB3
cml0ZXM6DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RsYmZsdXNoLmgN
Cj4gPiBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RsYmZsdXNoLmgNCj4gPiBpbmRleCA2ZjY2ZDg0
MTI2MmQuLjY5ZTZlYTIwNjc5YyAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS90bGJmbHVzaC5oDQo+ID4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdGxiZmx1c2guaA0K
PiA+IEBAIC0xNzIsNyArMTcyLDcgQEAgc3RydWN0IHRsYl9zdGF0ZSB7DQo+ID4gICAgICAgLyog
TGFzdCB1c2VyIG1tIGZvciBvcHRpbWl6aW5nIElCUEIgKi8NCj4gPiAgICAgICB1bmlvbiB7DQo+
ID4gICAgICAgICAgICAgICBzdHJ1Y3QgbW1fc3RydWN0ICAgICAgICAqbGFzdF91c2VyX21tOw0K
PiA+IC0gICAgICAgICAgICAgdW5zaWduZWQgbG9uZyAgICAgICAgICAgbGFzdF91c2VyX21tX2li
cGI7DQo+ID4gKyAgICAgICAgICAgICB1bnNpZ25lZCBsb25nICAgICAgICAgICBsYXN0X3VzZXJf
bW1fc3BlYzsNCj4gPiAtc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIG1tX21hbmdsZV90aWZf
c3BlY19pYihzdHJ1Y3QgdGFza19zdHJ1Y3QNCj4gPiAqbmV4dCkNCj4gPiArc3RhdGljIGlubGlu
ZSB1bnNpZ25lZCBsb25nIG1tX21hbmdsZV90aWZfc3BlY19iaXRzKHN0cnVjdCB0YXNrX3N0cnVj
dA0KPiA+ICpuZXh0KQ0KPiA+IC1zdGF0aWMgdm9pZCBjb25kX2licGIoc3RydWN0IHRhc2tfc3Ry
dWN0ICpuZXh0KQ0KPiA+ICtzdGF0aWMgdm9pZCBjb25kX21pdGlnYXRpb24oc3RydWN0IHRhc2tf
c3RydWN0ICpuZXh0KQ0KPiA+ICB7DQo+ID4gKyAgICAgdW5zaWduZWQgbG9uZyBwcmV2X21tLCBu
ZXh0X21tOw0KPiA+ICsNCj4gPiAgICAgICBpZiAoIW5leHQgfHwgIW5leHQtPm1tKQ0KPiA+ICAg
ICAgICAgICAgICAgcmV0dXJuOw0KPiANCj4gY2FuIHlvdSBwbGVhc2Ugc3BsaXQgb3V0IHRoZXNl
IHByZXBhcmF0b3J5IGNoYW5nZXMgaW50byBhIHNlcGFyYXRlDQo+IHBhdGNoPw0KPiANCg0KV2ls
bCBkbyBhbmQgcmVwb3N0IGEgbmV3IGl0ZXJhdGlvbg0KDQpCYWxiaXIgU2luZ2gNCg0K
