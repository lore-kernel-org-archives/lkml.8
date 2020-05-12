Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B165FCA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83501206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Umq2q31Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbgELRFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 13:05:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48396 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725851AbgELRFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 13:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589303102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8BYkXZcxPOd2yTvf9Qjqq0ZnoCiXEYq259rDmKdkiRg=;
        b=Umq2q31YZOq+kkpJYr51l2jP5foMJp1q2wlICG1xIAI4IvndsMOmL0q1tmxr3ua3PAQqaR
        s5iJZ4+m3b/Afuphbh4GXJJmXrc3QuvN/CGZ4j0qZgs9nl7N2bSzDcI7TRJUHBEHid3yYo
        IVK7AEQKG9dIyW4tCEp0E8F0+JvPmGk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-Z-VKokshOImbw7mRtCMmMw-1; Tue, 12 May 2020 13:05:00 -0400
X-MC-Unique: Z-VKokshOImbw7mRtCMmMw-1
Received: by mail-wm1-f69.google.com with SMTP id o141so385879wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 10:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8BYkXZcxPOd2yTvf9Qjqq0ZnoCiXEYq259rDmKdkiRg=;
        b=e4CMRhLrnEjMnIuMPd/tCcKsqNnMo8PrVwIZjEmDQnPFZy0u31xGK/plQyM14MGeh9
         sAYKBqaaVeNISK+cbP+Jt8azHvkt7QBwpZj+TK+mYhyu9ZLRmsCD0qir8zFZqEFFF0v9
         A0mVnlk3nr5lGzdo/Dft7eYcD7du9C0OkL7SvVWqR4dFdhNhXX4n47ej8ZI7URojGrjK
         /KMhdwmyDwM/LW0F1Dcc82ad7q9xhjnrWKcXbW6C8ifH9VhyLYZq+chB40xACJt3+2uQ
         LQhaFzdmFB5S0Efl3ZuVimQEHXn57W0i92vXiTN87ZSHf8B67n8VYxHBB0JKJAtoo3z3
         wGxg==
X-Gm-Message-State: AGi0PuZGR3WeFMjndaxR0440TUDPwHUDUquqWiciSeDdWemGxHYNRMwJ
        7BU3AFxCnMWbE0tutZT+JTZNH2K0uJ9tWPXsad/oAcHB9DrD0t6jJ8Y6k7fBiQ2horF9ZuPXv2n
        B8fElDl0U4gCzozlgF9LkPfI0
X-Received: by 2002:a5d:6605:: with SMTP id n5mr23231387wru.198.1589303098873;
        Tue, 12 May 2020 10:04:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypJdOPs/M77A+0Gokag6SWgv3Neh+Af2Gp2SIW67yLHdK2is03oPF/YShW15FFPZ22G3Z845bA==
X-Received: by 2002:a5d:6605:: with SMTP id n5mr23231360wru.198.1589303098570;
        Tue, 12 May 2020 10:04:58 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id p8sm27898155wma.45.2020.05.12.10.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 10:04:57 -0700 (PDT)
Subject: Re: [RFC][PATCH 4/5] objtool: Enable compilation of objtool for all
 architectures
To:     Matt Helsley <mhelsley@vmware.com>, linux-kernel@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1588888003.git.mhelsley@vmware.com>
 <9f709ea2ae66cc03b3ff3329baa8f670ccd0e368.1588888003.git.mhelsley@vmware.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <f9eedb02-54fe-fb96-fbcc-5f40f41e571a@redhat.com>
Date:   Tue, 12 May 2020 18:04:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <9f709ea2ae66cc03b3ff3329baa8f670ccd0e368.1588888003.git.mhelsley@vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

On 5/11/20 6:35 PM, Matt Helsley wrote:
> objtool currently only compiles for x86 architectures. This is
> fine as it presently does not support tooling for other
> architectures. However, we would like to be able to convert other
> kernel tools to run as objtool sub commands because they too
> process ELF object files. This will allow us to convert tools
> such as recordmcount to use objtool's ELF code.
> 
> Since much of recordmcount's ELF code is copy-paste code to/from
> a variety of other kernel tools (look at modpost for example) this
> means that if we can convert recordmcount we can convert more.
> 
> We define a "missing" architecture which contains weak definitions
> for tools that do not exist on all architectures. In this case the
> "check" and "orc" tools do not exist on all architectures.
> 
> To test building for other architectures ($arch below):
> 
> 	cd tools/objtool/arch
> 	ln -s missing $arch
> 	make O=build-$arch ARCH=$arch tools/objtool
> 

Since the stuff under arch/missing is only weak symbols to make up for 
missing subcmd implementations, can we put everything in a file 
subcmd_defaults.c (name up for debate!) that would be always be compiled 
an linked. And some SUBCMD_XXX is set to "y", the corresponding object 
file gets compiled and overrides the weak symbols from subcmd_defaults.c .

> This uses the weak, no-op definitions of the "check" and "orc"
> commands for the newly-supported architecture. Presently these
> exit with 127 to indicate that the subcommands are missing.
> Subsequent patches can then be made to determine if the weak
> definitions are used and explicitly report a missing command,
> and even to list which subcommands are supported (perhaps if
> no subcommand is specified it can list the supported subcommands).
> 
> objtool is not currently wired in to KConfig to be built for other
> architectures because it's not needed for those architectures and
> there are no commands it supports other than those for x86.
> 
> This commit allows us to demonstrate the pattern of adding
> architecture support and isolates moving the various files from
> adding support for more objtool subcommands.
> 
> Signed-off-by: Matt Helsley <mhelsley@vmware.com>
> ---
>   tools/objtool/Build                    |  9 +++---
>   tools/objtool/Makefile                 | 11 ++++++-
>   tools/objtool/arch.h                   | 40 ++++++++++++++++++++++++++
>   tools/objtool/arch/missing/Build       |  3 ++
>   tools/objtool/arch/missing/check.c     | 14 +++++++++
>   tools/objtool/arch/missing/orc_dump.c  | 11 +++++++
>   tools/objtool/arch/missing/orc_gen.c   | 16 +++++++++++
>   tools/objtool/arch/x86/Build           |  1 +
>   tools/objtool/{ => arch/x86}/special.c |  4 +--
>   tools/objtool/{ => arch/x86}/special.h |  2 +-
>   tools/objtool/builtin-orc.c            |  2 +-
>   tools/objtool/check.c                  |  5 ++--
>   tools/objtool/check.h                  | 37 ------------------------
>   tools/objtool/objtool.h                |  2 +-
>   tools/objtool/orc.h                    |  2 --
>   tools/objtool/orc_dump.c               |  1 +
>   tools/objtool/orc_gen.c                |  3 ++
>   17 files changed, 112 insertions(+), 51 deletions(-)
>   create mode 100644 tools/objtool/arch/missing/Build
>   create mode 100644 tools/objtool/arch/missing/check.c
>   create mode 100644 tools/objtool/arch/missing/orc_dump.c
>   create mode 100644 tools/objtool/arch/missing/orc_gen.c
>   rename tools/objtool/{ => arch/x86}/special.c (98%)
>   rename tools/objtool/{ => arch/x86}/special.h (95%)
> 
> diff --git a/tools/objtool/Build b/tools/objtool/Build
> index 66f44f5cd2a6..fb6e6faf6f10 100644
> --- a/tools/objtool/Build
> +++ b/tools/objtool/Build
> @@ -1,11 +1,12 @@
>   objtool-y += arch/$(SRCARCH)/
> +
> +objtool-$(SUBCMD_CHECK) += check.o
> +objtool-$(SUBCMD_ORC) += orc_gen.o
> +objtool-$(SUBCMD_ORC) += orc_dump.o
> +
>   objtool-y += builtin-check.o
>   objtool-y += builtin-orc.o
> -objtool-y += check.o
> -objtool-y += orc_gen.o
> -objtool-y += orc_dump.o
>   objtool-y += elf.o
> -objtool-y += special.o

I'm not convinced by the moving of special under arch/x86 and I didn't 
understand it at first.

I guess you did it because it is only used by the check subcmd, which is 
currently only implemented by x86. Is that the reason?

I feel that the proper way to do it would be to leave special.c/h where 
they are and have "objtool-$(SUBCMD_CHECK) += special.o". Unless there 
was some other motivation for it.

>   objtool-y += objtool.o
>   
>   objtool-y += libstring.o
> diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> index f591c4d1b6fe..8aac9e133188 100644
> --- a/tools/objtool/Makefile
> +++ b/tools/objtool/Makefile
> @@ -45,7 +45,16 @@ elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(CC) $(CFLAGS) -x c -E -
>   CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
>   
>   AWK = awk
> -export srctree OUTPUT CFLAGS SRCARCH AWK
> +
> +ifeq ($(SRCARCH),x86)
> +	SUBCMD_CHECK := y
> +	SUBCMD_ORC := y
> +else
> +	SUBCMD_CHECK := n
> +	SUBCMD_ORC := n
> +endif
> +

Nit: Can we default all SUBCMD_* variables to 'n' outside a branch and 
then individual arches override the relevant variables to 'y' in their 
"ifeq ($SRCARCH, <arch>)" branch?

> +export srctree OUTPUT CFLAGS SRCARCH AWK SUBCMD_CHECK SUBCMD_ORC
>   include $(srctree)/tools/build/Makefile.include
>   
>   $(OBJTOOL_IN): fixdep FORCE
> diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
> index ced3765c4f44..4ec9686f4898 100644
> --- a/tools/objtool/arch.h
> +++ b/tools/objtool/arch.h
> @@ -11,6 +11,9 @@
>   #include "elf.h"
>   #include "cfi.h"
>   
> +#include <asm/orc_types.h>
> +#include "orc.h"
> +
>   enum insn_type {
>   	INSN_JUMP_CONDITIONAL,
>   	INSN_JUMP_UNCONDITIONAL,
> @@ -66,6 +69,43 @@ struct stack_op {
>   	struct op_src src;
>   };
>   
> +struct insn_state {
> +	struct cfi_reg cfa;
> +	struct cfi_reg regs[CFI_NUM_REGS];
> +	int stack_size;
> +	unsigned char type;
> +	bool bp_scratch;
> +	bool drap, end, uaccess, df;
> +	bool noinstr;
> +	s8 instr;
> +	unsigned int uaccess_stack;
> +	int drap_reg, drap_offset;
> +	struct cfi_reg vals[CFI_NUM_REGS];
> +};
> +
> +struct instruction {
> +	struct list_head list;
> +	struct hlist_node hash;
> +	struct section *sec;
> +	unsigned long offset;
> +	unsigned int len;
> +	enum insn_type type;
> +	unsigned long immediate;
> +	bool alt_group, dead_end, ignore, hint, save, restore, ignore_alts;
> +	bool retpoline_safe;
> +	s8 instr;
> +	u8 visited;
> +	struct symbol *call_dest;
> +	struct instruction *jump_dest;
> +	struct instruction *first_jump_src;
> +	struct rela *jump_table;
> +	struct list_head alts;
> +	struct symbol *func;
> +	struct stack_op stack_op;
> +	struct insn_state state;
> +	struct orc_entry orc;
> +};
> +
>   void arch_initial_func_cfi_state(struct cfi_state *state);
>   
>   int arch_decode_instruction(struct elf *elf, struct section *sec,
> diff --git a/tools/objtool/arch/missing/Build b/tools/objtool/arch/missing/Build
> new file mode 100644
> index 000000000000..a2478db59484
> --- /dev/null
> +++ b/tools/objtool/arch/missing/Build
> @@ -0,0 +1,3 @@
> +objtool-y += check.o
> +objtool-y += orc_gen.o
> +objtool-y += orc_dump.o
> diff --git a/tools/objtool/arch/missing/check.c b/tools/objtool/arch/missing/check.c
> new file mode 100644
> index 000000000000..5eac14c8c6a5
> --- /dev/null
> +++ b/tools/objtool/arch/missing/check.c
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2020 Matt Helsley <mhelsley@vmware.com>
> + */
> +
> +#include <stdbool.h>
> +#include "../../check.h"
> +
> +const char *objname;
> +
> +int __attribute__ ((weak)) check(const char *_objname, bool orc)
> +{
> +	return 127;
> +}
> diff --git a/tools/objtool/arch/missing/orc_dump.c b/tools/objtool/arch/missing/orc_dump.c
> new file mode 100644
> index 000000000000..f7ebb3a2ce9e
> --- /dev/null
> +++ b/tools/objtool/arch/missing/orc_dump.c
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2017 Josh Poimboeuf <jpoimboe@redhat.com>
> + */
> +
> +#include "../../orc.h"
> +
> +int __attribute__ ((weak)) orc_dump(const char *_objname)
> +{
> +	return 127;
> +}
> diff --git a/tools/objtool/arch/missing/orc_gen.c b/tools/objtool/arch/missing/orc_gen.c
> new file mode 100644
> index 000000000000..4bf62ddf58a4
> --- /dev/null
> +++ b/tools/objtool/arch/missing/orc_gen.c
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2017 Josh Poimboeuf <jpoimboe@redhat.com>
> + */
> +
> +#include "../../orc.h"
> +
> +int __attribute__ ((weak)) create_orc(struct objtool_file *file)
> +{
> +	return 127;
> +}
> +
> +int __attribute__ ((weak)) create_orc_sections(struct objtool_file *file)
> +{
> +	return 127;
> +}
> diff --git a/tools/objtool/arch/x86/Build b/tools/objtool/arch/x86/Build
> index 7c5004008e97..de01c67dea14 100644
> --- a/tools/objtool/arch/x86/Build
> +++ b/tools/objtool/arch/x86/Build
> @@ -1,4 +1,5 @@
>   objtool-y += decode.o
> +objtool-y += special.o
>   
>   inat_tables_script = ../arch/x86/tools/gen-insn-attr-x86.awk
>   inat_tables_maps = ../arch/x86/lib/x86-opcode-map.txt
> diff --git a/tools/objtool/special.c b/tools/objtool/arch/x86/special.c
> similarity index 98%
> rename from tools/objtool/special.c
> rename to tools/objtool/arch/x86/special.c
> index e74e0189de22..677b6efe1446 100644
> --- a/tools/objtool/special.c
> +++ b/tools/objtool/arch/x86/special.c
> @@ -11,9 +11,9 @@
>   #include <stdlib.h>
>   #include <string.h>
>   
> -#include "builtin.h"
> +#include "../../builtin.h"
>   #include "special.h"
> -#include "warn.h"
> +#include "../../warn.h"
>   
>   #define EX_ENTRY_SIZE		12
>   #define EX_ORIG_OFFSET		0
> diff --git a/tools/objtool/special.h b/tools/objtool/arch/x86/special.h
> similarity index 95%
> rename from tools/objtool/special.h
> rename to tools/objtool/arch/x86/special.h
> index 35061530e46e..beba41950725 100644
> --- a/tools/objtool/special.h
> +++ b/tools/objtool/arch/x86/special.h
> @@ -7,7 +7,7 @@
>   #define _SPECIAL_H
>   
>   #include <stdbool.h>
> -#include "elf.h"
> +#include "../../elf.h"
>   
>   struct special_alt {
>   	struct list_head list;
> diff --git a/tools/objtool/builtin-orc.c b/tools/objtool/builtin-orc.c
> index 5f7cc6157edd..e6e54ae4ab75 100644
> --- a/tools/objtool/builtin-orc.c
> +++ b/tools/objtool/builtin-orc.c
> @@ -15,7 +15,7 @@
>   #include <string.h>
>   #include "builtin.h"
>   #include "check.h"
> -
> +#include "orc.h"
>   
>   static const char *orc_usage[] = {
>   	"objtool orc generate [<options>] file.o",
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 4b170fd08a28..d8a10961fe2c 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -7,10 +7,11 @@
>   #include <stdlib.h>
>   
>   #include "builtin.h"
> +#include "cfi.h"
> +#include "arch.h"
>   #include "check.h"
>   #include "elf.h"
> -#include "special.h"
> -#include "arch.h"
> +#include "arch/x86/special.h"
>   #include "warn.h"
>   
>   #include <linux/hashtable.h>
> diff --git a/tools/objtool/check.h b/tools/objtool/check.h
> index ec6ff7f0970c..4d34bfc84dc7 100644
> --- a/tools/objtool/check.h
> +++ b/tools/objtool/check.h
> @@ -8,43 +8,6 @@
>   
>   #include <stdbool.h>
>   #include "objtool.h"
> -#include "cfi.h"
> -#include "arch.h"
> -#include "orc.h"
> -
> -struct insn_state {
> -	struct cfi_reg cfa;
> -	struct cfi_reg regs[CFI_NUM_REGS];
> -	int stack_size;
> -	unsigned char type;
> -	bool bp_scratch;
> -	bool drap, end, uaccess, df;
> -	unsigned int uaccess_stack;
> -	int drap_reg, drap_offset;
> -	struct cfi_reg vals[CFI_NUM_REGS];
> -};
> -
> -struct instruction {
> -	struct list_head list;
> -	struct hlist_node hash;
> -	struct section *sec;
> -	unsigned long offset;
> -	unsigned int len;
> -	enum insn_type type;
> -	unsigned long immediate;
> -	bool alt_group, dead_end, ignore, hint, save, restore, ignore_alts;
> -	bool retpoline_safe;
> -	u8 visited;
> -	struct symbol *call_dest;
> -	struct instruction *jump_dest;
> -	struct instruction *first_jump_src;
> -	struct rela *jump_table;
> -	struct list_head alts;
> -	struct symbol *func;
> -	struct stack_op stack_op;
> -	struct insn_state state;
> -	struct orc_entry orc;
> -};
>   
>   int check(const char *objname, bool orc);
>   
> diff --git a/tools/objtool/objtool.h b/tools/objtool/objtool.h
> index afa52fe6f644..5ff352083056 100644
> --- a/tools/objtool/objtool.h
> +++ b/tools/objtool/objtool.h
> @@ -17,4 +17,4 @@ struct objtool_file {
>   	DECLARE_HASHTABLE(insn_hash, 20);
>   	bool ignore_unreachables, c_file, hints, rodata;
>   };
> -#endif
> +#endif /* _OBJTOOL_H */
> diff --git a/tools/objtool/orc.h b/tools/objtool/orc.h
> index ee2832221e62..c67f451d7610 100644
> --- a/tools/objtool/orc.h
> +++ b/tools/objtool/orc.h
> @@ -6,8 +6,6 @@
>   #ifndef _ORC_H
>   #define _ORC_H
>   
> -#include <asm/orc_types.h>
> -
>   struct objtool_file;
>   
>   int create_orc(struct objtool_file *file);
> diff --git a/tools/objtool/orc_dump.c b/tools/objtool/orc_dump.c
> index ba4cbb1cdd63..73c8beb6e402 100644
> --- a/tools/objtool/orc_dump.c
> +++ b/tools/objtool/orc_dump.c
> @@ -4,6 +4,7 @@
>    */
>   
>   #include <unistd.h>
> +#include <asm/orc_types.h>
>   #include "orc.h"
>   #include "warn.h"
>   
> diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
> index 4c0dabd28000..7693f7f31293 100644
> --- a/tools/objtool/orc_gen.c
> +++ b/tools/objtool/orc_gen.c
> @@ -5,8 +5,11 @@
>   
>   #include <stdlib.h>
>   #include <string.h>
> +#include <asm/orc_types.h>
>   
>   #include "orc.h"
> +#include "cfi.h"
> +#include "arch.h"
>   #include "check.h"
>   #include "warn.h"
>   
> 

-- 
Julien Thierry

