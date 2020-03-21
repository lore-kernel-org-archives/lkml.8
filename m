Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4730AC4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1931820757
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgCUPkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:40:36 -0400
Received: from 8bytes.org ([81.169.241.247]:54940 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbgCUPkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:40:35 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id B99B33D3; Sat, 21 Mar 2020 16:40:33 +0100 (CET)
Date:   Sat, 21 Mar 2020 16:40:31 +0100
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
Message-ID: <20200321154031.GN5122@8bytes.org>
References: <20200319091407.1481-1-joro@8bytes.org>
 <20200319091407.1481-22-joro@8bytes.org>
 <alpine.DEB.2.21.2003201350300.205664@chino.kir.corp.google.com>
 <8a50c19f-aaf8-90bd-a415-0e3b71e5a010@intel.com>
 <20200320221213.GK5122@8bytes.org>
 <9b69d49f-969c-5720-5723-f89ff0e000c0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b69d49f-969c-5720-5723-f89ff0e000c0@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 03:26:09PM -0700, Dave Hansen wrote:
> In any case, I thought this all came through initialize_identity_maps(),
> which does, for instance:
> 
>         mapping_info.page_flag = __PAGE_KERNEL_LARGE_EXEC | sme_me_mask;
> 
> Where:
> 
> #define __PAGE_KERNEL_LARGE_EXEC (__PP|__RW|   0|___A|   0|___D|_PSE|___G)
> 
> That looks like it has the Global bit set.  Does that not apply here
> somehow?

No, as the value of %cr4 at boot is 0x00000020, so PGE is not set and
global pages are not enabled. It wouldn't make sense anyhow, as global
pages only make sense when there are more than one address space, which
is not the case that early in boot.

Regards,

	Joerg
