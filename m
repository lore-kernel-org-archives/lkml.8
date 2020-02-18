Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759DBC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455112465D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgBRSUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:20:40 -0500
Received: from mga03.intel.com ([134.134.136.65]:28738 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbgBRSUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:20:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 10:20:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,456,1574150400"; 
   d="scan'208";a="228362150"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga007.fm.intel.com with ESMTP; 18 Feb 2020 10:20:38 -0800
Received: from orsmsx152.amr.corp.intel.com (10.22.226.39) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 18 Feb 2020 10:20:38 -0800
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.100]) by
 ORSMSX152.amr.corp.intel.com ([169.254.8.38]) with mapi id 14.03.0439.000;
 Tue, 18 Feb 2020 10:20:38 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@kernel.org>
CC:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] #MC mess
Thread-Topic: [RFC] #MC mess
Thread-Index: AQHV5oFaNSfU2AXDXU6dRUAZO7v/0KghQszg
Date:   Tue, 18 Feb 2020 18:20:38 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F57B937@ORSMSX115.amr.corp.intel.com>
References: <20200218173150.GK14449@zn.tnic>
In-Reply-To: <20200218173150.GK14449@zn.tnic>
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

PiBBbnl0aGluZyBlbHNlIEknbSBtaXNzaW5nPyBJdCBpcyBsaWtlbHkuLi4NCg0KKwlod19icmVh
a3BvaW50X2Rpc2FibGUoKTsNCisJc3RhdGljX2tleV9kaXNhYmxlKCZfX3RyYWNlcG9pbnRfcmVh
ZF9tc3Iua2V5KTsNCisJdHJhY2luZ19vZmYoKTsNCisNCiAJaXN0X2VudGVyKHJlZ3MpOw0KDQpI
b3cgYWJvdXQgc29tZSBjb2RlIHRvIHR1cm4gYWxsIHRob3NlIGJhY2sgb24gZm9yIGEgcmVjb3Zl
cmFibGUgKHdoZXJlIHdlIGFjdHVhbGx5IHJlY292ZXJlZCkgI01DPw0KDQotVG9ueQ0K
