Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C010C4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38B972072D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgD0UOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:14:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:40490 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgD0UOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:14:54 -0400
IronPort-SDR: 2tI4Oi6oIwWQxfcHsi4pG7mnOpH0z17RXnFf0APwjr6EOY/u4yEGozpMerBr9dXHUA6KT1gdhW
 z357f45VHSXw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 13:14:54 -0700
IronPort-SDR: oSH1QzudxMhvrNKYYa85wCPYgn+CzdEisFQatM2S+MaevgrPdVt+tmmUWR2NSoLtOYQv8SqrGt
 31V5QV9sFD6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; 
   d="scan'208";a="404431741"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga004.jf.intel.com with ESMTP; 27 Apr 2020 13:14:53 -0700
Date:   Mon, 27 Apr 2020 13:13:57 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org
Subject: Re: [PATCH 1/7] docs: x86: Add a documentation for ENQCMD
Message-ID: <20200427201357.GB242333@romley-ivt3.sc.intel.com>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
 <1585596788-193989-2-git-send-email-fenghua.yu@intel.com>
 <87368qtsqz.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87368qtsqz.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 01:02:12PM +0200, Thomas Gleixner wrote:
> Fenghua Yu <fenghua.yu@intel.com> writes:
> 
> s/Add a documentation/Add documentation/
> 
> > From: Ashok Raj <ashok.raj@intel.com>
> >
> > ENQCMD and Data Streaming Accelerator (DSA) and all of their associated
> > features are a complicated stack with lots of interconnected pieces.
> > This documentation provides a big picture overview for all of the
> > features.
> >
> > Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> > Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > ---
> >  Documentation/x86/enqcmd.rst | 185 +++++++++++++++++++++++++++++++++++
> 
> How is that hooked up into the Documentation index?
> 
>  Documentation/x86/enqcmd.rst: WARNING: document isn't included in any toctree
> 
> > +++ b/Documentation/x86/enqcmd.rst
> > @@ -0,0 +1,185 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +Improved Device Interaction Overview
> 
> So the document is about ENQCMD, right? Can you please make that in some
> way consistently named?
> 
> > +
> > +== Background ==
> 
> This lacks any docbook formatting.... The resulting HTML looks like ...
> 
> > +
> > +Shared Virtual Addressing (SVA) allows the processor and device to use the
> > +same virtual addresses avoiding the need for software to translate virtual
> > +addresses to physical addresses. ENQCMD is a new instruction on Intel
> > +platforms that allows user applications to directly notify hardware of new
> > +work, much like doorbells are used in some hardware, but carries a payload
> > +that carries the PASID and some additional device specific commands
> > +along with it.
> 
> Sorry that's not background information, that's an agglomeration of
> words.
> 
> Can you please explain properly what's the background of SVA, how it
> differs from regular device addressing and what kind of requirements it
> has?
> 
> ENQCMD is not related to background. It's part of the new technology.
> 
> > +== Address Space Tagging ==
> > +
> > +A new MSR (MSR_IA32_PASID) allows an application address space to be
> > +associated with what the PCIe spec calls a Process Address Space ID
> > +(PASID). This PASID tag is carried along with all requests between
> > +applications and devices and allows devices to interact with the process
> > +address space.
> 
> Sigh. The important part here is not the MSR. The important part is to
> explain what PASID is and where it comes from. Documentation has similar
> rules as changelogs:
> 
>       1) Provide context
> 
>       2) Explain requirements
>       
>       3) Explain implementation
> 
> The pile you provided is completely backwards and unstructured.

Ok. Will address all of the comments.

Thanks.

-Fenghua
