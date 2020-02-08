Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C10C35242
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 04:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2D620715
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 04:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgBHEWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 23:22:36 -0500
Received: from mga04.intel.com ([192.55.52.120]:10473 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbgBHEWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 23:22:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 20:22:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,416,1574150400"; 
   d="scan'208";a="255641221"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga004.fm.intel.com with ESMTP; 07 Feb 2020 20:22:35 -0800
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.4]) by
 ORSMSX101.amr.corp.intel.com ([169.254.8.100]) with mapi id 14.03.0439.000;
 Fri, 7 Feb 2020 20:22:35 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/mce: /dev/mcelog: Dynamically allocate space for
 machine check records
Thread-Topic: [PATCH] x86/mce: /dev/mcelog: Dynamically allocate space for
 machine check records
Thread-Index: AQHV3hOHz4vkK03Af0yIb+ecp/K5sKgROLoA
Date:   Sat, 8 Feb 2020 04:22:34 +0000
Message-ID: <E10F764B-C5B8-4E35-ADAB-8E8E3D511426@intel.com>
References: <20200208000551.11364-1-tony.luck@intel.com>
In-Reply-To: <20200208000551.11364-1-tony.luck@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECC15F3FEF9569438B157C2928441D11@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIEZlYiA3LCAyMDIwLCBhdCAxNjowNiwgVG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwu
Y29tPiB3cm90ZToNCj4gDQo+IO+7v1dlIGhhdmUgaGFkIGEgaGFyZCBjb2RlZCBsaW1pdCBvZiAz
MiBtYWNoaW5lIGNoZWNrIHJlY29yZHMgc2luY2UgdGhlDQo+IGRhd24gb2YgdGltZS4gIEJ1dCBh
cyBudW1iZXJzIG9mIGNvcmVzIGluY3JlYXNlLCBpdCBpcyBwb3NzaWJsZSBmb3INCj4gbW9yZSB0
aGFuIDMyIGVycm9ycyB0byBiZSByZXBvcnRlZCANCg0KTm90ZSB0aGF0IHRoaXMgaXMgbm90IGEg
dGhlb3JldGljYWwgaXNzdWUuIFZhbGlkYXRpb24NCnRlYW0gaXMgaGl0dGluZyB0aGlzIGluIGEg
Y2FzZSB0aGF0IGRvZXNu4oCZdCBsb29rDQpjb21wbGV0ZWx5IGltcGxhdXNpYmxlLg0KDQotVG9u
eQ==
