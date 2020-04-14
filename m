Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35525C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C4F220767
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503166AbgDNSAe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:00:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:8797 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503161AbgDNSAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:00:24 -0400
IronPort-SDR: 1X7DPwPJQiLnDsqXKS5iAizHQH4CxA/e2cg97tAXQxGk7O5jshKpvlB7wtGM2t2uxKrQWbDpqx
 aIc7vR4EqYKw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 11:00:23 -0700
IronPort-SDR: BJ8Yd0vwgZtKtR9gvTVC3zAxgOeegZUqINl7BRHh3C1dt6lIEcB2hhOSnbSevBceVDWfbh6CGp
 xQ1CKt1EY1+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,383,1580803200"; 
   d="scan'208";a="242066029"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga007.jf.intel.com with ESMTP; 14 Apr 2020 11:00:23 -0700
Received: from orsmsx122.amr.corp.intel.com (10.22.225.227) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Apr 2020 11:00:22 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.102]) by
 ORSMSX122.amr.corp.intel.com ([169.254.11.34]) with mapi id 14.03.0439.000;
 Tue, 14 Apr 2020 11:00:22 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Park, Kyung Min" <kyung.min.park@intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
Subject: RE: [PATCH v3 3/3] x86/delay: Introduce TPAUSE delay
Thread-Topic: [PATCH v3 3/3] x86/delay: Introduce TPAUSE delay
Thread-Index: AQHWD4/qMw0TcUxzb0+IsfW0PyjEy6h45dQAgAAGJzA=
Date:   Tue, 14 Apr 2020 18:00:21 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F5E3E80@ORSMSX115.amr.corp.intel.com>
References: <1586561395-50914-1-git-send-email-kyung.min.park@intel.com>
 <1586561395-50914-4-git-send-email-kyung.min.park@intel.com>
 <20200414103106.GK20713@hirez.programming.kicks-ass.net>
In-Reply-To: <20200414103106.GK20713@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +static inline void __tpause(u32 ecx, u32 edx, u32 eax)
>> +{
>> +	/* "tpause %ecx, %edx, %eax;" */
>> +	asm volatile(".byte 0x66, 0x0f, 0xae, 0xf1\t\n"
>> +		     :
>> +		     : "c"(ecx), "d"(edx), "a"(eax));
>> +}
>
> Can we please get a comment stating from what binutils version this
> opcode has a mnemonic? That way, when we raise the minimum binutils
> version we can easily grep and find such things.

Or maybe use arch/x86/Kconfig.assembler to set up a CONFIG_AS_TPAUSE?

Then the code can read something like (syntax may need fixing)

#ifdef CONFIG_AS_TPAUSE
		asm volatile("tpause %ecx\n", : : "c"(ecx), "d"(edx), "a"(eax));
#else
		asm volatile(".byte hex gibberish ...
#endif

-Tony
