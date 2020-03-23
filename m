Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC77C10F26
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 05:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFAC120409
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 05:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgCWFSj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 01:18:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:60909 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgCWFSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 01:18:39 -0400
IronPort-SDR: STbwYfMLrHKV0pI/X1HDn2OQoIuCM+ENUnWcAHpYaI/m3dpjlb88twFzb7QNTvoafu/CCgBiT0
 Tfj9xvU87YZg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2020 22:18:38 -0700
IronPort-SDR: fts42I0y1TuKNVMM2x1NrRG1/XQgMfJPU8+xcVHSzopzA/cWRcLZx3o4YeiOAwWiCq3bkJp6+H
 cgD1/N6jlhJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,295,1580803200"; 
   d="scan'208";a="292471725"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Mar 2020 22:18:37 -0700
Received: from orsmsx155.amr.corp.intel.com (10.22.240.21) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 22 Mar 2020 22:18:37 -0700
Received: from orsmsx102.amr.corp.intel.com ([169.254.3.165]) by
 ORSMSX155.amr.corp.intel.com ([169.254.7.107]) with mapi id 14.03.0439.000;
 Sun, 22 Mar 2020 22:18:36 -0700
From:   "Park, Kyung Min" <kyung.min.park@intel.com>
To:     Joe Perches <joe@perches.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
Subject: RE: [PATCH v2 2/2] x86/delay: Introduce TPAUSE delay
Thread-Topic: [PATCH v2 2/2] x86/delay: Introduce TPAUSE delay
Thread-Index: AQHV/m3yCORYmsI3CkqI0RgzexuEG6hRtyAAgAPw2LA=
Date:   Mon, 23 Mar 2020 05:18:36 +0000
Message-ID: <3658BA65DD26AF4BA909BEB2C6DF6181A2A624C9@ORSMSX102.amr.corp.intel.com>
References: <1584677604-32707-1-git-send-email-kyung.min.park@intel.com>
         <1584677604-32707-3-git-send-email-kyung.min.park@intel.com>
 <b771dfc7409a99b35575c14cd4dd55d24f81ca98.camel@perches.com>
In-Reply-To: <b771dfc7409a99b35575c14cd4dd55d24f81ca98.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

> -----Original Message-----
> From: Joe Perches <joe@perches.com>
> Sent: Friday, March 20, 2020 3:07 AM
> To: Park, Kyung Min <kyung.min.park@intel.com>; x86@kernel.org; linux-
> kernel@vger.kernel.org
> Cc: tglx@linutronix.de; mingo@redhat.com; hpa@zytor.com;
> gregkh@linuxfoundation.org; ak@linux.intel.com; Luck, Tony
> <tony.luck@intel.com>; Raj, Ashok <ashok.raj@intel.com>; Shankar, Ravi V
> <ravi.v.shankar@intel.com>; Yu, Fenghua <fenghua.yu@intel.com>
> Subject: Re: [PATCH v2 2/2] x86/delay: Introduce TPAUSE delay
> 
> On Thu, 2020-03-19 at 21:13 -0700, Kyung Min Park wrote:
> > TPAUSE instructs the processor to enter an implementation-dependent
> > optimized state. The instruction execution wakes up when the
> > time-stamp counter reaches or exceeds the implicit EDX:EAX 64-bit input value.
> > The instruction execution also wakes up due to the expiration of the
> > operating system time-limit or by an external interrupt or exceptions
> > such as a debug exception or a machine check exception.
> []
> > diff --git a/arch/x86/lib/delay.c b/arch/x86/lib/delay.c
> []
> > @@ -97,6 +97,27 @@ static void delay_tsc(u64 cycles)  }
> >
> >  /*
> > + * On Intel the TPAUSE instruction waits until any of:
> > + * 1) the TSC counter exceeds the value provided in EAX:EDX
> > + * 2) global timeout in IA32_UMWAIT_CONTROL is exceeded
> > + * 3) an external interrupt occurs
> > + */
> > +static void delay_halt_tpause(u64 start, u64 cycles) {
> > +	u64 until = start + cycles;
> > +	unsigned int eax, edx;
> > +
> > +	eax = (unsigned int)(until & 0xffffffff);
> > +	edx = (unsigned int)(until >> 32);
> 
> trivia:
> 
> perhaps lower_32_bits and upper_32_bits

Thank you for your comment. I'll update in the next patch.

