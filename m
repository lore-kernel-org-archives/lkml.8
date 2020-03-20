Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA2CC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A527D20714
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgCTXn6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 19:43:58 -0400
Received: from mga04.intel.com ([192.55.52.120]:4270 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgCTXn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 19:43:58 -0400
IronPort-SDR: ux2AVVpx+1OHYfT1MTMN4V66Qit4fcmMByOMCj5NUQcXY2nRi/PTpDv/liwK5tohwLN2RNIqY9
 e4BJHMEhiZnw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 16:43:57 -0700
IronPort-SDR: TuxU30KvSjaF7//l3pktlwxoaMjzB1UrjLcpQoSS7zZ1pXlvrVUGB3SX70/csEGniNzUMVDh3x
 pv0GbcnD435Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,286,1580803200"; 
   d="scan'208";a="249032861"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga006.jf.intel.com with ESMTP; 20 Mar 2020 16:43:57 -0700
Received: from orsmsx155.amr.corp.intel.com (10.22.240.21) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 20 Mar 2020 16:43:57 -0700
Received: from orsmsx102.amr.corp.intel.com ([169.254.3.165]) by
 ORSMSX155.amr.corp.intel.com ([169.254.7.107]) with mapi id 14.03.0439.000;
 Fri, 20 Mar 2020 16:43:56 -0700
From:   "Park, Kyung Min" <kyung.min.park@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
Subject: RE: [PATCH v2 0/2] x86/delay: Introduce TPAUSE instruction
Thread-Topic: [PATCH v2 0/2] x86/delay: Introduce TPAUSE instruction
Thread-Index: AQHV/p370RFgN+BwjkuNNhbDrbt3qKhSJS6g
Date:   Fri, 20 Mar 2020 23:43:56 +0000
Message-ID: <3658BA65DD26AF4BA909BEB2C6DF6181A2A622FA@ORSMSX102.amr.corp.intel.com>
References: <1584677604-32707-1-git-send-email-kyung.min.park@intel.com>
 <87a74b4ad2.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87a74b4ad2.fsf@nanos.tec.linutronix.de>
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

Hi Thomas,

> -----Original Message-----
> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Friday, March 20, 2020 2:57 AM
> To: Park, Kyung Min <kyung.min.park@intel.com>; x86@kernel.org; linux-
> kernel@vger.kernel.org
> Cc: mingo@redhat.com; hpa@zytor.com; gregkh@linuxfoundation.org;
> ak@linux.intel.com; Luck, Tony <tony.luck@intel.com>; Raj, Ashok
> <ashok.raj@intel.com>; Shankar, Ravi V <ravi.v.shankar@intel.com>; Yu,
> Fenghua <fenghua.yu@intel.com>; Park, Kyung Min
> <kyung.min.park@intel.com>
> Subject: Re: [PATCH v2 0/2] x86/delay: Introduce TPAUSE instruction
> 
> Hi!
> 
> Kyung Min Park <kyung.min.park@intel.com> writes:
> 
> > Intel processors that support the WAITPKG feature implement the TPAUSE
> > instruction that suspends execution in a lower power state until the
> > TSC (Time Stamp Counter) exceeds a certain value.
> >
> > Update the udelay() function to use TPAUSE on systems where it is
> > available. Note that we hard code the deeper (C0.2) sleep state
> > because exit latency is small compared to the "microseconds"
> > that usleep() will delay.
> >
> > ChangeLog:
> > - Change from v1 to v2:
> >   1. The patchset applies after Thomas's cleanup patch as below:
> >      https://lkml.org/lkml/diff/2020/3/18/893/1
> 
> lkml.org is horrible. Please use lore.kernel.org if at all.

Let me change in the next patch.

> Also please just add the patch to the series when posting so that people don't
> have to go through loops and hoops to grab that dependency.

Sure, Let me add this patch to the series.

> Thanks,
> 
>         tglx
> 

