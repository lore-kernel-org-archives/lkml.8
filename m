Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC25EC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9252921D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgBRTyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:54:55 -0500
Received: from mga17.intel.com ([192.55.52.151]:33124 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgBRTyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:54:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 11:54:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,457,1574150400"; 
   d="scan'208";a="258667177"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga004.fm.intel.com with ESMTP; 18 Feb 2020 11:54:54 -0800
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.100]) by
 ORSMSX101.amr.corp.intel.com ([169.254.8.110]) with mapi id 14.03.0439.000;
 Tue, 18 Feb 2020 11:54:54 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] #MC mess
Thread-Topic: [RFC] #MC mess
Thread-Index: AQHV5oFaNSfU2AXDXU6dRUAZO7v/0KghQszggACf7QD//3pjMA==
Date:   Tue, 18 Feb 2020 19:54:54 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F57BD54@ORSMSX115.amr.corp.intel.com>
References: <20200218173150.GK14449@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F57B937@ORSMSX115.amr.corp.intel.com>
 <20200218195130.GO14449@zn.tnic>
In-Reply-To: <20200218195130.GO14449@zn.tnic>
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

Pj4gSG93IGFib3V0IHNvbWUgY29kZSB0byB0dXJuIGFsbCB0aG9zZSBiYWNrIG9uIGZvciBhIHJl
Y292ZXJhYmxlICh3aGVyZQ0KPj4gd2UgYWN0dWFsbHkgcmVjb3ZlcmVkKSAjTUM/DQo+DQo+IFRo
ZSB1c2UgY2FzZSBiZWluZz8NCg0KUmVjb3ZlcmFibGUgbWFjaGluZSBjaGVja3MgYXJlIGEgbm9y
bWFsIChob3BlZnVsbHkgcmFyZSkgZXZlbnQgb24gYSBzZXJ2ZXIuICBCdXQgeW91IHdvdWxkbid0
DQp3YW50IHRvIGxvc2UgdHJhY2luZyBjYXBhYmlsaXR5IGp1c3QgYmVjYXVzZSB3ZSB0b29rIGEg
cGFnZSBvZmZsaW5lIGFuZCBraWxsZWQgYSBwcm9jZXNzIHRvIHJlY292ZXIuDQoNCi1Ub255DQo=
