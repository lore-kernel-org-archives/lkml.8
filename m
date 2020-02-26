Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1A6C4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2619420732
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgBZT0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 14:26:09 -0500
Received: from mga14.intel.com ([192.55.52.115]:46134 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgBZT0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 14:26:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 11:26:09 -0800
X-IronPort-AV: E=Sophos;i="5.70,489,1574150400"; 
   d="scan'208";a="256437340"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.24.11.14])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 11:26:08 -0800
Message-ID: <fc82a40dbc269bf1b4f9c9ca1b56e8115783edbb.camel@linux.intel.com>
Subject: Re: [RFC PATCH 08/11] x86: Add support for finer grained KASLR
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, keescook@chromium.org,
        rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Date:   Wed, 26 Feb 2020 11:26:08 -0800
In-Reply-To: <20200225174951.GA1373392@rani.riverdale.lan>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
         <20200205223950.1212394-9-kristen@linux.intel.com>
         <20200225174951.GA1373392@rani.riverdale.lan>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-25 at 12:49 -0500, Arvind Sankar wrote:
> On Wed, Feb 05, 2020 at 02:39:47PM -0800, Kristen Carlson Accardi
> wrote:
> > At boot time, find all the function sections that have separate
> > .text
> > sections, shuffle them, and then copy them to new locations. Adjust
> > any relocations accordingly.
> > 
> > Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> > ---
> >  arch/x86/boot/compressed/Makefile        |   1 +
> >  arch/x86/boot/compressed/fgkaslr.c       | 751
> > +++++++++++++++++++++++
> >  arch/x86/boot/compressed/misc.c          | 106 +++-
> >  arch/x86/boot/compressed/misc.h          |  26 +
> >  arch/x86/boot/compressed/vmlinux.symbols |  15 +
> >  arch/x86/include/asm/boot.h              |  15 +-
> >  arch/x86/include/asm/kaslr.h             |   1 +
> >  arch/x86/lib/kaslr.c                     |  15 +
> >  scripts/kallsyms.c                       |  14 +-
> >  scripts/link-vmlinux.sh                  |   4 +
> >  10 files changed, 939 insertions(+), 9 deletions(-)
> >  create mode 100644 arch/x86/boot/compressed/fgkaslr.c
> >  create mode 100644 arch/x86/boot/compressed/vmlinux.symbols
> > 
> > diff --git a/arch/x86/boot/compressed/Makefile
> > b/arch/x86/boot/compressed/Makefile
> > index b7e5ea757ef4..60d4c4e59c05 100644
> > --- a/arch/x86/boot/compressed/Makefile
> > +++ b/arch/x86/boot/compressed/Makefile
> > @@ -122,6 +122,7 @@ OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
> >  
> >  ifdef CONFIG_FG_KASLR
> >  	RELOCS_ARGS += --fg-kaslr
> > +	OBJCOPYFLAGS += --keep-symbols=$(obj)/vmlinux.symbols
> 
> I think this should be $(srctree)/$(src) rather than $(obj)? Using a
> separate build directory fails currently.

Thanks, I'll add this to my test plan for v1.


