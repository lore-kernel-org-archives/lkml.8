Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494B4C2BA83
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 12:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216B72082F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 12:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgBOMcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 07:32:52 -0500
Received: from 8bytes.org ([81.169.241.247]:54312 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgBOMcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 07:32:52 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7A23E2C2; Sat, 15 Feb 2020 13:32:50 +0100 (CET)
Date:   Sat, 15 Feb 2020 13:32:48 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
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
Subject: Re: [PATCH 08/62] x86/boot/compressed/64: Add IDT Infrastructure
Message-ID: <20200215123248.GF22063@8bytes.org>
References: <20200211135256.24617-1-joro@8bytes.org>
 <20200211135256.24617-9-joro@8bytes.org>
 <87k14p5557.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k14p5557.fsf@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 11:40:36AM -0800, Andi Kleen wrote:
> Joerg Roedel <joro@8bytes.org> writes:
> > +	addq    $8, %rsp
> > +
> > +	/*
> > +	 * Make sure we return to __KERNEL_CS - the CS selector on
> > +	 * the IRET frame might still be from an old BIOS GDT
> > +	 */
> > +	movq	$__KERNEL_CS, 8(%rsp)
> 
> This doesn't make sense. Either it's running on the correct CS
> before the exception or not. Likely there's some other problem
> here that you patched over with this hack.

It is actually a well-known situation and not some other problem. The
boot-code loaded a new GDT and IDT, but did not reload CS with a far
jump/ret/call. The CS value loaded is undefined and comes from the UEFI
BIOS. When an exception is raised, this old CS value is stored in the
IRET frame, and when IRET is executed the processor loads an undefined
CS value, which causes a triple fault with the current IDT setup.

The hack in this patch just fixes the IRET frame up so that it will
return to the correct CS. The reason for this hack was actually to safe
some instructions in the boot-path, because the space is limited there
between the defined offsets of the various entry points.

I removed this hack meanwhile and added a separate function which
reloads CS, DS, SS and ES and which is called from the boot-path, so
that there is no problem with the offsets.

Regards,

	Joerg
