Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6CAC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 22:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68FCB20754
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 22:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgCTWMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 18:12:16 -0400
Received: from 8bytes.org ([81.169.241.247]:54690 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbgCTWMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 18:12:16 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C15F24CA; Fri, 20 Mar 2020 23:12:14 +0100 (CET)
Date:   Fri, 20 Mar 2020 23:12:13 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     David Rientjes <rientjes@google.com>, x86@kernel.org,
        hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 21/70] x86/boot/compressed/64: Add function to map a page
 unencrypted
Message-ID: <20200320221213.GK5122@8bytes.org>
References: <20200319091407.1481-1-joro@8bytes.org>
 <20200319091407.1481-22-joro@8bytes.org>
 <alpine.DEB.2.21.2003201350300.205664@chino.kir.corp.google.com>
 <8a50c19f-aaf8-90bd-a415-0e3b71e5a010@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a50c19f-aaf8-90bd-a415-0e3b71e5a010@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 02:02:13PM -0700, Dave Hansen wrote:
> It *never* flushes global pages.  For a generic function like this, that
> seems pretty dangerous because the PTEs it goes after could quite easily
> be Global.  It's also not _obviously_ correct if PCIDs are in play
> (which I don't think they are on AMD).
> 
> A flush_tlb_global() is probably more appropriate.  Better yet, is there
> a reason not to use flush_tlb_kernel_range()?  I don't think it's
> necessary to whack the entire TLB for one PTE set.

This code runs before the actual kernel image is decompressed, so there
is no PCID and no global pages (I think CR4.PGE is still 0). So a
cr3-write is enough to flush the TLB. Also the TLB-flush helpers of the
running kernel are not available here.

Regards,

	Joerg
