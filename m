Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347C5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 23:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0080220771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 23:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgGGXQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 19:16:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:63741 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728253AbgGGXQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 19:16:18 -0400
IronPort-SDR: ZSs7rATjcMYpX5yWJcms3qg2CE7sMCHVIu03/vK9EzC7O3J1e93dfN2QcvFcPvE4NYYY076Uy0
 mr6/QxSGyPLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="127307938"
X-IronPort-AV: E=Sophos;i="5.75,325,1589266800"; 
   d="scan'208";a="127307938"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 16:16:16 -0700
IronPort-SDR: ijLCuaWKCRsIjWYnojOSUVQo9G3uGaETGna7yLAjc7XSk3ypwOFZs8gxavYIjgHddZRp6JegKf
 ipz+yeg+2V3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,325,1589266800"; 
   d="scan'208";a="315678575"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jul 2020 16:16:16 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 7 Jul 2020 16:16:15 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.56]) by
 ORSMSX111.amr.corp.intel.com ([169.254.12.75]) with mapi id 14.03.0439.000;
 Tue, 7 Jul 2020 16:16:15 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arjan van de Ven <arjan@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: RE: [PATCH v3 09/10] kallsyms: Hide layout
Thread-Topic: [PATCH v3 09/10] kallsyms: Hide layout
Thread-Index: AQHWSYM11GEyu/9l+ketSGcChG8StajoBLUAgABS94CAFO8JgP//jrPw
Date:   Tue, 7 Jul 2020 23:16:14 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F68AC3B@ORSMSX115.amr.corp.intel.com>
References: <20200623172327.5701-1-kristen@linux.intel.com>
         <20200623172327.5701-10-kristen@linux.intel.com>
         <CAG48ez3YHoPOTZvabsNUcr=GP-rX+OXhNT54KcZT9eSQ28Fb8Q@mail.gmail.com>
         <202006240815.45AAD55@keescook>
 <f34eb868e609a1a8a7f19b77fe5d00bf3555bb00.camel@linux.intel.com>
In-Reply-To: <f34eb868e609a1a8a7f19b77fe5d00bf3555bb00.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTaWduZWQtb2ZmLWJ5OiBLcmlzdGVuIENhcmxzb24gQWNjYXJkaSA8a3Jpc3RlbkBsaW51eC5p
bnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBUb255IEx1Y2sgPHRvbnkubHVja0BpbnRlbC5jb20+
DQo+IFRlc3RlZC1ieTogVG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KDQpJJ2xsIGhh
cHBpbHkgcmV2aWV3IGFuZCB0ZXN0IGFnYWluIC4uLiBidXQgc2luY2UgeW91J3ZlIG1hZGUgc3Vi
c3RhbnRpdmUNCmNoYW5nZXMsIHlvdSBzaG91bGQgZHJvcCB0aGVzZSB0YWdzIHVudGlsIEkgZG8u
DQoNCkZXSVcgSSB0aGluayByYW5kb20gb3JkZXIgaXMgYSBnb29kIGlkZWEuICBEbyB5b3Ugc2h1
ZmZsZSBvbmNlPw0KT3IgZXZlcnkgdGltZSBzb21lYm9keSBvcGVucyAvcHJvYy9rYWxsc3ltcz8N
Cg0KLVRvbnkNCg==
