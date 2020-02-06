Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A02BC33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D192D20838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgBFQ6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 11:58:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:35955 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbgBFQ6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 11:58:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 08:58:22 -0800
X-IronPort-AV: E=Sophos;i="5.70,410,1574150400"; 
   d="scan'208";a="220497571"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.24.10.96])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 08:58:22 -0800
Message-ID: <2da7c2370b1bd5474ce51a22b04d81e2734232b1.camel@linux.intel.com>
Subject: Re: [RFC PATCH 03/11] x86/boot: Allow a "silent" kaslr random byte
 fetch
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, keescook@chromium.org,
        rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Date:   Thu, 06 Feb 2020 08:58:22 -0800
In-Reply-To: <B173D69E-DC6C-4658-B5CB-391D3C6A6597@amacapital.net>
References: <20200205223950.1212394-4-kristen@linux.intel.com>
         <B173D69E-DC6C-4658-B5CB-391D3C6A6597@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-02-05 at 17:08 -0800, Andy Lutomirski wrote:
> > On Feb 5, 2020, at 2:39 PM, Kristen Carlson Accardi <
> > kristen@linux.intel.com> wrote:
> > 
> > ﻿From: Kees Cook <keescook@chromium.org>
> > 
> > Under earlyprintk, each RNG call produces a debug report line. When
> > shuffling hundreds of functions, this is not useful information
> > (each
> > line is identical and tells us nothing new). Instead, allow for a
> > NULL
> > "purpose" to suppress the debug reporting.
> 
> Have you counted how many RDRAND calls this causes?  RDRAND is
> exceedingly slow on all CPUs I’ve looked at. The whole “RDRAND has
> great bandwidth” marketing BS actually means that it has decent
> bandwidth if all CPUs hammer it at the same time. The latency is
> abysmal.  I have asked Intel to improve this, but the latency of that
> request will be quadrillions of cycles :)
> 
> It wouldn’t shock me if just the RDRAND calls account for a
> respectable fraction of total time. The RDTSC fallback, on the other
> hand, may be so predictable as to be useless.

I think at the moment the calls to rdrand are really not the largest
contributor to the latency. The relocations are the real bottleneck -
each address must be inspected to see if it is in the list of function
sections that have been randomized, and the value at that address must
also be inspected to see if it's in the list of function sections.
That's a lot of lookups. That said, I tried to measure the difference
between using Kees' prng vs. the rdrand calls and found little to no
measurable difference. I think at this point it's in the noise -
hopefully we will get to a point where this matters more.

> 
> I would suggest adding a little ChaCha20 DRBG or similar to the KASLR
> environment instead. What crypto primitives are available there?

I will read up on this.


