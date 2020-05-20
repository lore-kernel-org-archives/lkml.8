Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36CEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 718FA206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHOv6fx6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgETIbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 04:31:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30385 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726224AbgETIbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 04:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589963511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VIXZDqOXFcihJ2bkHai3mXCdDvdUV50NdKrrdZHodZ8=;
        b=jHOv6fx6zKprG9a37xhEz84Q9ya5WyU6vLuWDLgZMO7CNrdglg73Sot2RIfBf4vceAyFEx
        zsWIgRM51JM+ZBTkw6+kJKPWth6/y7IK6sjjska5kuuR8vOxia7p2Ag8iqAIBxgRd5JWdY
        phKQJIBP0d1PtmOtvGla621+5UAQpTY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-4UOREkHQPpSWf8vRyQgz3Q-1; Wed, 20 May 2020 04:31:49 -0400
X-MC-Unique: 4UOREkHQPpSWf8vRyQgz3Q-1
Received: by mail-wr1-f70.google.com with SMTP id n9so1075562wru.20
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 01:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VIXZDqOXFcihJ2bkHai3mXCdDvdUV50NdKrrdZHodZ8=;
        b=mCP7kygJEkze6/MadtvB7+oTJjW3LkC0okRye5RtUjtMmujenFnu5/L0nYnbM1oVq4
         p7deWqFd6Z4T4o8gbNtO6Axs0rSOTg51jiO9MtPPucH8CxDEMyQzVdqRH/2X4J8E5R2s
         Ki/u2LH7Fbn26s5v8Lk15cmUblGJn7poGCCsNXu/RdU4++UAl+uluzNNo69OOqvy/GaY
         uhfF2TDKR7sz3j1/ek2V4IJ0uPxNMVMqUdAZIDd9bAQ+1WWGhs1HtwZAODoTrYKRQzxG
         9fr8zvnKGnO4AJWYmlt1TWnnXlaU0XfbRhDLFzuKdGxQPcUbF06q5M9Fe8JkznqBstN3
         XY/Q==
X-Gm-Message-State: AOAM532Xy8xWewHD7JywKg0WN+++wMHLCPflynURSEfq4QP/NnReJIiU
        ZZEScWtKHsM+p4qw95JsLNzf79fHRULEW3759QBebP3LDIBsnT06E/koOm2+X/5bYX6Yh/ny4+M
        V3j06CAG7+WaPH4HVlr3zDenN
X-Received: by 2002:adf:e582:: with SMTP id l2mr3359601wrm.392.1589963508419;
        Wed, 20 May 2020 01:31:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/wWhNbkFUbl52kCp+7p0x4VY2NFui6YdjuRHEScktqhonOudYQ/aReKxg9+b6j7L6s89s0Q==
X-Received: by 2002:adf:e582:: with SMTP id l2mr3359575wrm.392.1589963508152;
        Wed, 20 May 2020 01:31:48 -0700 (PDT)
Received: from [192.168.1.27] (lfbn-lyo-1-134-107.w86-202.abo.wanadoo.fr. [86.202.218.107])
        by smtp.gmail.com with ESMTPSA id z10sm2269453wmi.2.2020.05.20.01.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 01:31:47 -0700 (PDT)
Subject: Re: [PATCH 3/3] objtool: Enable compilation of objtool for all
 architectures
To:     Matt Helsley <mhelsley@vmware.com>, linux-kernel@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1589913349.git.mhelsley@vmware.com>
 <96252a8eee50710f4fe115ca516f0e6058b9f66b.1589913349.git.mhelsley@vmware.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <b27ee658-2886-107c-a367-632467ec6929@redhat.com>
Date:   Wed, 20 May 2020 09:31:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <96252a8eee50710f4fe115ca516f0e6058b9f66b.1589913349.git.mhelsley@vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/20 9:55 PM, Matt Helsley wrote:
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
> We define "missing" weak definitions for subcommand entry functions
> and other weak definitions for shared functions critical to
> building existing subcommands. These return 127 when the command is
> missing which signify tools that do not exist on all architectures.
> In this case the "check" and "orc" tools do not exist on all
> architectures so we only add them for x86. Future changes adding
> support for "check", to arm64 for example, can then modify the
> SUBCMD_CHECK variable when building for arm64.
> 
> objtool is not currently wired in to KConfig to be built for other
> architectures because it's not needed for those architectures and
> there are no commands it supports other than those for x86. As more
> command support is enabled on various architectures the necessary
> KConfig changes can be made (e.g. adding "STACK_VALIDATION") to
> trigger building objtool.
> 
> Signed-off-by: Matt Helsley <mhelsley@vmware.com>
> Cc: Julien Thierry <jthierry@redhat.com>
> ---
>   tools/objtool/Build           | 13 +++++++++----
>   tools/objtool/Makefile        | 11 ++++++++++-
>   tools/objtool/arch.h          |  4 +++-
>   tools/objtool/builtin-check.c |  2 +-
>   tools/objtool/builtin-orc.c   |  3 +--
>   tools/objtool/check.c         |  4 ++--
>   tools/objtool/check.h         |  4 ----
>   tools/objtool/objtool.h       | 14 ++++++++++++++
>   tools/objtool/orc.h           | 18 ------------------
>   tools/objtool/orc_dump.c      |  3 ++-
>   tools/objtool/orc_gen.c       |  1 -
>   tools/objtool/weak.c          | 35 +++++++++++++++++++++++++++++++++++
>   12 files changed, 77 insertions(+), 35 deletions(-)
>   delete mode 100644 tools/objtool/orc.h
>   create mode 100644 tools/objtool/weak.c
> 
> diff --git a/tools/objtool/Build b/tools/objtool/Build
> index 66f44f5cd2a6..b7222d5cc7bc 100644
> --- a/tools/objtool/Build
> +++ b/tools/objtool/Build
> @@ -1,11 +1,16 @@
>   objtool-y += arch/$(SRCARCH)/
> +
> +objtool-y += weak.o
> +
> +objtool-$(SUBCMD_CHECK) += check.o
> +objtool-$(SUBCMD_CHECK) += special.o
> +objtool-$(SUBCMD_ORC) += check.o
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
>   objtool-y += objtool.o
>   
>   objtool-y += libstring.o
> diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> index 6b91388aecbb..12686e2f1a56 100644
> --- a/tools/objtool/Makefile
> +++ b/tools/objtool/Makefile
> @@ -46,7 +46,16 @@ elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(CC) $(CFLAGS) -x c -E -
>   CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
>   
>   AWK = awk
> -export srctree OUTPUT CFLAGS SRCARCH AWK
> +
> +SUBCMD_CHECK := n
> +SUBCMD_ORC := n
> +
> +ifeq ($(SRCARCH),x86)
> +	SUBCMD_CHECK := y
> +	SUBCMD_ORC := y
> +endif
> +
> +export srctree OUTPUT CFLAGS SRCARCH AWK SUBCMD_CHECK SUBCMD_ORC

Nit: I was thinking, since the list of SUBCMD_* is only going to grow
maybe it would be nicer to have a single export line for the SUBCMD_* 
variables and leave the export line of [srctree..AWK] untouched.

Just a suggestion, and only in case you respin this taking into account 
Josh's comment.

Otherwise things look good to me.

Cheers,

-- 
Julien Thierry

