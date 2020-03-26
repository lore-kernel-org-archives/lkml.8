Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DC4C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3CA2077D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgCZOTO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:19:14 -0400
Received: from mga03.intel.com ([134.134.136.65]:50598 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbgCZOTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:19:13 -0400
IronPort-SDR: H7N3W0DwLWj9N+wkYSjSF4pOTnxmFvJe94eRYX0PVcXFouTs2onLI109dnNjL5y49jmy+vAfu0
 x+KAPomQ4jNQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 07:19:13 -0700
IronPort-SDR: 8epfGZ80D72BQJCR2DI3poWT2+ZDzO18AfKjAN91uMZwJIeD2hycw4bdD+kJQZfbIK0uS3XCan
 vQUdw/bJJkMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,308,1580803200"; 
   d="scan'208";a="448641976"
Received: from irsmsx110.ger.corp.intel.com ([163.33.3.25])
  by fmsmga006.fm.intel.com with ESMTP; 26 Mar 2020 07:19:09 -0700
Received: from irsmsx106.ger.corp.intel.com ([169.254.8.159]) by
 irsmsx110.ger.corp.intel.com ([169.254.15.208]) with mapi id 14.03.0439.000;
 Thu, 26 Mar 2020 14:19:08 +0000
From:   "Hunter, Adrian" <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
CC:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mingbo Zhang <whensungoes@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86: perf: insn: Tweak opcode map for Intel CET
 instructions
Thread-Topic: [PATCH] x86: perf: insn: Tweak opcode map for Intel CET
 instructions
Thread-Index: AQHV8RdZnJl7srk+20GWxk75DLFbbahaOnmAgAA834CAAJL5gIAABeQg
Date:   Thu, 26 Mar 2020 14:19:07 +0000
Message-ID: <363DA0ED52042842948283D2FC38E4649C72EFF3@IRSMSX106.ger.corp.intel.com>
References: <20200303045033.6137-1-whensungoes@gmail.com>
 <20200326103153.de709903f26fee0918414bd2@kernel.org>
 <bac567dd-9810-4919-365e-b3dfb54a6c4b@intel.com>
 <20200326135547.GA20397@redhat.com>
In-Reply-To: <20200326135547.GA20397@redhat.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [163.33.239.180]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Sent: Thursday, March 26, 2020 3:56 PM
> To: Hunter, Adrian <adrian.hunter@intel.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>; Mingbo Zhang
> <whensungoes@gmail.com>; Arnaldo Carvalho de Melo
> <acme@kernel.org>; x86@kernel.org; Thomas Gleixner
> <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>; Borislav Petkov
> <bp@alien8.de>; H. Peter Anvin <hpa@zytor.com>; Andi Kleen
> <ak@linux.intel.com>; Josh Poimboeuf <jpoimboe@redhat.com>; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] x86: perf: insn: Tweak opcode map for Intel CET
> instructions
> 
> Em Thu, Mar 26, 2020 at 07:09:45AM +0200, Adrian Hunter escreveu:
> > On 26/03/20 3:31 am, Masami Hiramatsu wrote:
> > > Hi,
> > >
> > > On Mon,  2 Mar 2020 23:50:30 -0500
> > > Mingbo Zhang <whensungoes@gmail.com> wrote:
> > >
> > >> Intel CET instructions are not described in the Intel SDM. When
> > >> trying to get the instruction length, the following instructions
> > >> get wrong (missing ModR/M byte).
> > >>
> > >> RDSSPD r32
> > >> RSDDPQ r64
> > >> ENDBR32
> > >> ENDBR64
> > >> WRSSD r/m32, r32
> > >> WRSSQ r/m64, r64
> > >>
> > >> RDSSPD/Q and ENDBR32/64 use the same opcode (f3 0f 1e) slot, which
> > >> is described in SDM as Reserved-NOP with no encoding characters,
> > >> and got an empty slot in the opcode map. WRSSD/Q (0f 38 f6) also got
> an empty slot.
> > >>
> > >
> > > This looks good to me. BTW, wouldn't we need to add decode test cases
> to perf?
> > >
> > > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > >
> > > Thank you,
> > >
> >
> > We have correct patches that you ack'ed for CET here:
> >
> >
> > https://lore.kernel.org/lkml/20200204171425.28073-1-yu-cheng.yu@intel.
> > com/
> >
> > But they have not yet been applied.
> >
> > Sorry for the confusion.
> 
> I'll collect them, thanks for pointing this out.

The patches are in tip courtesy of Borislav Petkov thank you!

