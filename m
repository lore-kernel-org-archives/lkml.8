Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E61C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3058120B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgDTR41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:56:27 -0400
Received: from mga17.intel.com ([192.55.52.151]:20456 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgDTR40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:56:26 -0400
IronPort-SDR: 0qm2UkN0tbfuVFkTsbivH8GEtJvW5l/36IttlTP8HCGcz82F/RHSQg0I7OMl7pRz9BhRPabuHT
 buUXDG5OmsSQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 10:56:26 -0700
IronPort-SDR: nKw3ceibSZJUMOm4ZuRPjRHO0z/8piR3eVE2HD1FINajmcJS+v144uUxPRdwC6jdItY9GFY8Zm
 YIfHoccIvxZA==
X-IronPort-AV: E=Sophos;i="5.72,407,1580803200"; 
   d="scan'208";a="258427602"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.212.34.135])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 10:56:24 -0700
Message-ID: <57fcb4a823003e955b63e81085b7d18a2ac0c139.camel@linux.intel.com>
Subject: Re: [PATCH 9/9] module: Reorder functions
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, Jessica Yu <jeyu@kernel.org>, arjan@linux.intel.com,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com, rick.p.edgecombe@intel.com
Date:   Mon, 20 Apr 2020 10:56:22 -0700
In-Reply-To: <CAMj1kXGbh=0nC_6SGTWjKeDPdwBrEW0_vRbjDzWyqqjY_88S7Q@mail.gmail.com>
References: <20200415210452.27436-1-kristen@linux.intel.com>
         <20200415210452.27436-10-kristen@linux.intel.com>
         <CAMj1kXGbh=0nC_6SGTWjKeDPdwBrEW0_vRbjDzWyqqjY_88S7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-20 at 14:01 +0200, Ard Biesheuvel wrote:
> On Wed, 15 Apr 2020 at 23:07, Kristen Carlson Accardi
> <kristen@linux.intel.com> wrote:
> > If a module has functions split out into separate text sections
> > (i.e. compiled with the -ffunction-sections flag), reorder the
> > functions to provide some code diversification to modules.
> > 
> 
> Is that the only prerequisite? I.e., is it sufficient for another
> architecture to add -ffunction-sections to the module CFLAGS to get
> this functionality? (assuming it defines CONFIG_FG_KASLR=y)

I think it would work for modules. I've not tested this of course. It
might not make sense for some architectures (like 32 bit), but it would
probably work.

> 
> > Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > ---
> >  kernel/module.c | 82
> > +++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 82 insertions(+)
> > 
> > diff --git a/kernel/module.c b/kernel/module.c
> > index 646f1e2330d2..e432ec5f6df4 100644
> > --- a/kernel/module.c
> > +++ b/kernel/module.c
> > @@ -53,6 +53,8 @@
> >  #include <linux/bsearch.h>
> >  #include <linux/dynamic_debug.h>
> >  #include <linux/audit.h>
> > +#include <linux/random.h>
> > +#include <asm/setup.h>
> >  #include <uapi/linux/module.h>
> >  #include "module-internal.h"
> > 
> > @@ -2370,6 +2372,83 @@ static long get_offset(struct module *mod,
> > unsigned int *size,
> >         return ret;
> >  }
> > 
> > +/*
> > + * shuffle_text_list()
> > + * Use a Fisher Yates algorithm to shuffle a list of text
> > sections.
> > + */
> > +static void shuffle_text_list(Elf_Shdr **list, int size)
> > +{
> > +       int i;
> > +       unsigned int j;
> > +       Elf_Shdr *temp;
> > +
> > +       for (i = size - 1; i > 0; i--) {
> > +               /*
> > +                * pick a random index from 0 to i
> > +                */
> > +               get_random_bytes(&j, sizeof(j));
> > +               j = j % (i + 1);
> > +
> > +               temp = list[i];
> > +               list[i] = list[j];
> > +               list[j] = temp;
> > +       }
> > +}
> > +
> > +/*
> > + * randomize_text()
> > + * Look through the core section looking for executable code
> > sections.
> > + * Store sections in an array and then shuffle the sections
> > + * to reorder the functions.
> > + */
> > +static void randomize_text(struct module *mod, struct load_info
> > *info)
> > +{
> > +       int i;
> > +       int num_text_sections = 0;
> > +       Elf_Shdr **text_list;
> > +       int size = 0;
> > +       int max_sections = info->hdr->e_shnum;
> > +       unsigned int sec = find_sec(info, ".text");
> > +
> > +       if (sec == 0)
> > +               return;
> > +
> > +       text_list = kmalloc_array(max_sections, sizeof(*text_list),
> > GFP_KERNEL);
> > +       if (text_list == NULL)
> > +               return;
> > +
> > +       for (i = 0; i < max_sections; i++) {
> > +               Elf_Shdr *shdr = &info->sechdrs[i];
> > +               const char *sname = info->secstrings + shdr-
> > >sh_name;
> > +
> > +               if (!(shdr->sh_flags & SHF_ALLOC) ||
> > +                   !(shdr->sh_flags & SHF_EXECINSTR) ||
> > +                   strstarts(sname, ".init"))
> > +                       continue;
> > +
> > +               text_list[num_text_sections] = shdr;
> > +               num_text_sections++;
> > +       }
> > +
> > +       shuffle_text_list(text_list, num_text_sections);
> > +
> > +       for (i = 0; i < num_text_sections; i++) {
> > +               Elf_Shdr *shdr = text_list[i];
> > +
> > +               /*
> > +                * get_offset has a section index for it's last
> > +                * argument, that is only used by
> > arch_mod_section_prepend(),
> > +                * which is only defined by parisc. Since this this
> > type
> > +                * of randomization isn't supported on parisc, we
> > can
> > +                * safely pass in zero as the last argument, as it
> > is
> > +                * ignored.
> > +                */
> > +               shdr->sh_entsize = get_offset(mod, &size, shdr, 0);
> > +       }
> > +
> > +       kfree(text_list);
> > +}
> > +
> >  /* Lay out the SHF_ALLOC sections in a way not dissimilar to how
> > ld
> >     might -- code, read-only data, read-write data, small
> > data.  Tally
> >     sizes, and place the offsets into sh_entsize fields: high bit
> > means it
> > @@ -2460,6 +2539,9 @@ static void layout_sections(struct module
> > *mod, struct load_info *info)
> >                         break;
> >                 }
> >         }
> > +
> > +       if (IS_ENABLED(CONFIG_FG_KASLR) && kaslr_enabled())
> 
> kaslr_enabled() only exists [as a function] on x86

CONFIG_FG_KASLR is dependant on x86_64. If people really think there is
value in having the module randomization not dependent on the kernel
randomization it can be changed to a different config option - but I am
not sure that there is a ton of value in the module randomization on
it's own.

> 
> 
> > +               randomize_text(mod, info);
> >  }
> > 
> >  static void set_license(struct module *mod, const char *license)
> > --
> > 2.20.1
> > 

