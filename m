Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C378C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 040CA20707
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731259AbgFOSbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 14:31:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:61123 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729354AbgFOSbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 14:31:53 -0400
IronPort-SDR: 6wWtUj3M5wNE3U2gipg4n+tYsDF7jvaGfelmgmtWBZrfUmWnIAKxlZrNguqHZmdbFbm71hQYjk
 75csbxwBY8Sg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 11:31:52 -0700
IronPort-SDR: joXV1sSu0sZFkD4oHAh3xnZighPwZFPsGZZaZQQdIrQ7QFvt2lXqOLaudtJdb7kYgg95ZSUvsl
 4aJyYOd12xKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,515,1583222400"; 
   d="scan'208";a="308824121"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jun 2020 11:31:51 -0700
Received: from orsmsx163.amr.corp.intel.com (10.22.240.88) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 15 Jun 2020 11:31:51 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.56]) by
 ORSMSX163.amr.corp.intel.com ([169.254.9.139]) with mapi id 14.03.0439.000;
 Mon, 15 Jun 2020 11:31:51 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        "Park, Kyung Min" <kyung.min.park@intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: RE: [RFC PATCH 1/3] Documentation/x86: Add documentation for
 /proc/cpuinfo feature flags
Thread-Topic: [RFC PATCH 1/3] Documentation/x86: Add documentation for
 /proc/cpuinfo feature flags
Thread-Index: AQHWP2TFcCB7etr3HkSrzMhI8DNK7KjaeHOA//+OLkA=
Date:   Mon, 15 Jun 2020 18:31:50 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F66C552@ORSMSX115.amr.corp.intel.com>
References: <20200610200701.16757-1-kyung.min.park@intel.com>
 <20200610200701.16757-2-kyung.min.park@intel.com>
 <20200615181527.GM14668@zn.tnic>
In-Reply-To: <20200615181527.GM14668@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJbiBnZW5lcmFsLCB0aGlzIHNob3VsZCBzYXkgc29tZXRoaW5nIGFsb25nIHRoZSBsaW5lcyB0
aGF0IC9wcm9jL2NwdWluZm8NCj4gc2hvd3MgZmVhdHVyZXMgd2hpY2ggdGhlIGtlcm5lbCBzdXBw
b3J0cy4NCj4NCj4gIkZvciBhIGZ1bGwgbGlzdCBvZiBDUFVJRCBmbGFncyB3aGljaCB0aGUgQ1BV
IHN1cHBvcnRzLCB1c2UNCj4gdG9vbHMvYXJjaC94ODYvdG9vbHMvY3B1aWQvY3B1aWQiDQo+DQo+
IDotKQ0KDQpEYXZlIEhhbnNlbiBoYWQgc3VnZ2VzdGVkIChvZmZsaW5lKSB0aGF0IHdlIGFkZCBh
IGNwdWlkIHRvb2wgdG8gdGhlIGtlcm5lbCBzb3VyY2VzLg0KDQpJIHRoaW5rIHRoYXQncyBhIGxv
dCBvZiAoZHVwbGljYXRlZCkgd29yayBmb3Igc29tZW9uZSB0byBtYWludGFpbi4gIFRoZSB2ZXJz
aW9uIG9mIHRoaXMNCnRvb2wgYXQgaHR0cDovL3d3dy5ldGFsbGVuLmNvbS9jcHVpZC5odG1sIGlz
IGNsb3NlIHRvIDEwSyBsaW5lcyBvZiBjb2RlLg0KDQotVG9ueQ0K
