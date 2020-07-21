Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB980C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C62982073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgGUMuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 08:50:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:59146 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbgGUMuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 08:50:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4EEBDAC22;
        Tue, 21 Jul 2020 12:50:07 +0000 (UTC)
Date:   Tue, 21 Jul 2020 14:49:57 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Erdem Aktas <erdemaktas@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        David Rientjes <rientjes@google.com>,
        Cfir Cohen <cfir@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Stunes <mstunes@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Martin Radev <martin.b.radev@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v4 00/75] x86: SEV-ES Guest Support
Message-ID: <20200721124957.GD6132@suse.de>
References: <20200714120917.11253-1-joro@8bytes.org>
 <20200715092456.GE10769@hirez.programming.kicks-ass.net>
 <20200715093426.GK16200@suse.de>
 <20200715095556.GI10769@hirez.programming.kicks-ass.net>
 <20200715101034.GM16200@suse.de>
 <CAAYXXYxJf8sr6fvbZK=t6o_to4Ov_yvZ91Hf6ZqQ-_i-HKO2VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAYXXYxJf8sr6fvbZK=t6o_to4Ov_yvZ91Hf6ZqQ-_i-HKO2VA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 20, 2020 at 06:09:19PM -0700, Erdem Aktas wrote:
> It looks like there is an expectation that the bootloader will start
> from the 64bit entry point in header_64.S. With the current patch
> series, it will not boot up if the bootloader jumps to the startup_32
> entry, which might break some default distro images.
> What are supported bootloaders and configurations?
> I am using grub ( 2.02-2ubuntu8.15) and it fails to boot because of
> this reason. I am not a grub expert, so I would appreciate any
> pointers on this.

This is right, the only supported boot path is via the 64bit EFI entry
point. The reason is that SEV-ES requires support in the firmware too,
and currently only OVMF is supported in that regard. The firmware needs
to setup the AP jump-table, for example.

Other boot-paths have not been implemented. Booting via startup_32 would
require exception handling in the 32bit-part of the boot-strap code,
because verify_cpu is called there. Also an AMD specific MSR can't be
accessed there because this would #GP on non-AMD/SEV-ES machines and,
as I said, there is no way yet to handle them.

How did you get into the startup_32 entry-point, do you have an SEV-ES
BIOS supporting this? If it is really needed it could be implemented at
a later point.

Regards,

	Joerg

