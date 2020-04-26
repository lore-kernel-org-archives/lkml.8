Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E066C55191
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 11:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FAA920706
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 11:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgDZLCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 07:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726119AbgDZLC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 07:02:29 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9B5C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 04:02:29 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jSf37-0002WT-Ej; Sun, 26 Apr 2020 13:02:13 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id D4334100605; Sun, 26 Apr 2020 13:02:12 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        iommu@lists.linux-foundation.org, Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH 1/7] docs: x86: Add a documentation for ENQCMD
In-Reply-To: <1585596788-193989-2-git-send-email-fenghua.yu@intel.com>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com> <1585596788-193989-2-git-send-email-fenghua.yu@intel.com>
Date:   Sun, 26 Apr 2020 13:02:12 +0200
Message-ID: <87368qtsqz.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fenghua Yu <fenghua.yu@intel.com> writes:

s/Add a documentation/Add documentation/

> From: Ashok Raj <ashok.raj@intel.com>
>
> ENQCMD and Data Streaming Accelerator (DSA) and all of their associated
> features are a complicated stack with lots of interconnected pieces.
> This documentation provides a big picture overview for all of the
> features.
>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  Documentation/x86/enqcmd.rst | 185 +++++++++++++++++++++++++++++++++++

How is that hooked up into the Documentation index?

 Documentation/x86/enqcmd.rst: WARNING: document isn't included in any toctree

> +++ b/Documentation/x86/enqcmd.rst
> @@ -0,0 +1,185 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Improved Device Interaction Overview

So the document is about ENQCMD, right? Can you please make that in some
way consistently named?

> +
> +== Background ==

This lacks any docbook formatting.... The resulting HTML looks like ...

> +
> +Shared Virtual Addressing (SVA) allows the processor and device to use the
> +same virtual addresses avoiding the need for software to translate virtual
> +addresses to physical addresses. ENQCMD is a new instruction on Intel
> +platforms that allows user applications to directly notify hardware of new
> +work, much like doorbells are used in some hardware, but carries a payload
> +that carries the PASID and some additional device specific commands
> +along with it.

Sorry that's not background information, that's an agglomeration of
words.

Can you please explain properly what's the background of SVA, how it
differs from regular device addressing and what kind of requirements it
has?

ENQCMD is not related to background. It's part of the new technology.

> +== Address Space Tagging ==
> +
> +A new MSR (MSR_IA32_PASID) allows an application address space to be
> +associated with what the PCIe spec calls a Process Address Space ID
> +(PASID). This PASID tag is carried along with all requests between
> +applications and devices and allows devices to interact with the process
> +address space.

Sigh. The important part here is not the MSR. The important part is to
explain what PASID is and where it comes from. Documentation has similar
rules as changelogs:

      1) Provide context

      2) Explain requirements
      
      3) Explain implementation

The pile you provided is completely backwards and unstructured.

Thanks,

        tglx
