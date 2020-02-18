Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34847C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186622464E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgBRUF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:05:59 -0500
Received: from mga18.intel.com ([134.134.136.126]:1241 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728228AbgBRUF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:05:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 12:05:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,457,1574150400"; 
   d="scan'208";a="315170026"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga001.jf.intel.com with ESMTP; 18 Feb 2020 12:05:57 -0800
Received: from orsmsx125.amr.corp.intel.com (10.22.240.125) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 18 Feb 2020 12:05:57 -0800
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.100]) by
 ORSMSX125.amr.corp.intel.com ([169.254.3.208]) with mapi id 14.03.0439.000;
 Tue, 18 Feb 2020 12:05:57 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] #MC mess
Thread-Topic: [RFC] #MC mess
Thread-Index: AQHV5oFaNSfU2AXDXU6dRUAZO7v/0KghQszggACf7QD//3pjMIAAiAuA//96XnA=
Date:   Tue, 18 Feb 2020 20:05:57 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F57BDDB@ORSMSX115.amr.corp.intel.com>
References: <20200218173150.GK14449@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F57B937@ORSMSX115.amr.corp.intel.com>
 <20200218195130.GO14449@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F57BD54@ORSMSX115.amr.corp.intel.com>
 <20200218200011.GP14449@zn.tnic>
In-Reply-To: <20200218200011.GP14449@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBZZWFoLCBvay4gSG93IGRvIHlvdSB3YW50IHRvIHNlbGVjdCB3aGljaCBvbmVzPyBXaGF0IG1j
ZV9ub193YXlfb3V0KCkNCj4gc2F5cyBvciBzZXZlcml0eSBvci4uLj8NCg0KV2Ugb25seSByZXR1
cm4gZnJvbSBkb19tYWNoaW5lX2NoZWNrKCkgaW4gdGhlIHJlY292ZXJhYmxlIGNhc2UuICBTbyBk
b3duIGF0IHRoZQ0KZW5kIGp1c3QgaGVyZToNCg0Kb3V0X2lzdDoNCglpc3RfZXhpdChyZWdzKTsN
Cn0NCg0KDQpUaG91Z2ggdGhhdCBkb2VzIGluY2x1ZGUgY2FzZXMgd2hlcmUgd2UgcmV0dXJuZWQg
anVzdCBiZWNhdXNlIGNmZy0+dG9sZXJhbnQgd2FzDQpzZXQgdG8gc29tZSB2YWx1ZSBzYXlpbmcg
aWdub3JlIHRoaXMgI01DLg0KDQotVG9ueQ0K
