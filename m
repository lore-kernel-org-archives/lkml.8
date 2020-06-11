Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED66CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAEF720747
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgFKMkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgFKMkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 08:40:12 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DC0C08C5C1;
        Thu, 11 Jun 2020 05:40:11 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6A791869; Thu, 11 Jun 2020 14:40:09 +0200 (CEST)
Date:   Thu, 11 Jun 2020 14:40:08 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        David Rientjes <rientjes@google.com>,
        Cfir Cohen <cfir@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Stunes <mstunes@vmware.com>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v3 51/75] x86/sev-es: Handle MMIO events
Message-ID: <20200611124008.GC11924@8bytes.org>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-52-joro@8bytes.org>
 <20200520063202.GB17090@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520063202.GB17090@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 11:32:02PM -0700, Sean Christopherson wrote:
> '0' is a valid physical address.  It happens to be reserved in the kernel
> thanks to L1TF, but using '0' as an error code is ugly.  Not to mention
> none of the callers actually check the result.

Right, I changed the function to better handle error cases and added
checks to the call-sites. It looks like below now:

static bool vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
                                 unsigned long vaddr, phys_addr_t *paddr)
{
        unsigned long va = (unsigned long)vaddr;
        unsigned int level;
        phys_addr_t pa;
        pgd_t *pgd;
        pte_t *pte;

        pgd = pgd_offset(current->active_mm, va);
        pte = lookup_address_in_pgd(pgd, va, &level);
        if (!pte) {
                ctxt->fi.vector     = X86_TRAP_PF;
                ctxt->fi.cr2        = vaddr;
                ctxt->fi.error_code = 0;

                if (user_mode(ctxt->regs))
                        ctxt->fi.error_code |= X86_PF_USER;

                return false;
        }

        pa = (phys_addr_t)pte_pfn(*pte) << PAGE_SHIFT;
        pa |= va & ~page_level_mask(level);

        *paddr = pa;

        return true;
}

