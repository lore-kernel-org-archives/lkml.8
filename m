Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0372C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 08:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2C022078D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 08:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZsAh8yRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgFIIyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 04:54:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53264 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728243AbgFIIym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 04:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591692880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eLblsTqKUjq9s36ScyyJ5e0rwCHkqC/nIIt9NNzbhvM=;
        b=ZsAh8yRoJ4LaRx0Po/jxsM1MEQPza6eMcybwpqsb1dEBLLTYKB/Wj70VH/lw6DfrH4OaRt
        6D8ftfx/efE7imdWwV3dRjyy+Aeiinmq159BFF1Q8WLHYzmpVzrCSJH2kTuarNCKl8xcZF
        IcmO/vzBy+mYNs2WRdgvMyYSPO5dK8c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-sbCYSFYpNIuV7naGCe-jug-1; Tue, 09 Jun 2020 04:54:36 -0400
X-MC-Unique: sbCYSFYpNIuV7naGCe-jug-1
Received: by mail-wr1-f72.google.com with SMTP id r5so8340833wrt.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 01:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eLblsTqKUjq9s36ScyyJ5e0rwCHkqC/nIIt9NNzbhvM=;
        b=B+vxad2WBVjMUsuFqZVFUfmEYzbfN5wU2vrKX81Zro/4zz2dD0McT6nMkMUh4Hof22
         V51xkHfQ88D2w+WllZ+kwrhRTR4V9/UeYq6gIsPrUt3G7RCZCzlb/yUPwjoJhmY8/Ja1
         zb/xUwBddUMV/MmBXSZc5NsvCjNawbC/vG/a4/hdEE3/oRwhzzhC50MTbYHetPiTXGtu
         cYnPwro8H5LOfnEUuDaIN0XQQmFoL9ije59ZUMDnW2RF+SZBiv9T4UVqjsemxMoSotPN
         Dmfpdv3TfvrU1ahdwVePA8umiZFgRensQblKEffCPdK646VZ+R4dVijbdQq7q7U3xCLy
         lUpg==
X-Gm-Message-State: AOAM532BaoieHuJGhTHRyzjc19xEEwvBhB2m/rcu1Ua4jDgT74og4xFd
        I7wbNuZ7IJOaSTXUtw9Y5tsGjY42aTyTeKHvsjIviYOEwETmFM+UtAtI4/NruaXvH6qI03UHXkF
        1GFmLS/84TnIEsup/6w2AwrLv
X-Received: by 2002:a1c:a403:: with SMTP id n3mr2869970wme.2.1591692875662;
        Tue, 09 Jun 2020 01:54:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyk64DUIN2AMFcBfNkspM6xbGkxn8iVwgRRfLpEaDpf6XV5Ei2C8wWXXvmjDinm5JkdkQF20w==
X-Received: by 2002:a1c:a403:: with SMTP id n3mr2869949wme.2.1591692875327;
        Tue, 09 Jun 2020 01:54:35 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id o20sm2605541wra.29.2020.06.09.01.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 01:54:34 -0700 (PDT)
Subject: Re: [RFC][PATCH v4 01/32] objtool: Prepare to merge recordmcount
To:     Matt Helsley <mhelsley@vmware.com>, linux-kernel@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
References: <cover.1591125127.git.mhelsley@vmware.com>
 <4a71852d8ca0a245588159a6bbdc064619de91d9.1591125127.git.mhelsley@vmware.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <1e2783f2-6b52-d750-ecc5-4e3d6d7dba4f@redhat.com>
Date:   Tue, 9 Jun 2020 09:54:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4a71852d8ca0a245588159a6bbdc064619de91d9.1591125127.git.mhelsley@vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

On 6/2/20 8:49 PM, Matt Helsley wrote:
> Move recordmcount into the objtool directory. We keep this step separate
> so changes which turn recordmcount into a subcommand of objtool don't
> get obscured.
> 
> Signed-off-by: Matt Helsley <mhelsley@vmware.com>
> ---
>   Documentation/trace/ftrace-design.rst      |  4 ++--
>   Documentation/trace/ftrace.rst             |  2 +-
>   Makefile                                   | 15 +++++++++------
>   scripts/.gitignore                         |  1 -
>   scripts/Makefile                           |  1 -
>   scripts/Makefile.build                     | 11 ++++++-----
>   tools/objtool/.gitignore                   |  1 +
>   tools/objtool/Build                        |  2 ++
>   tools/objtool/Makefile                     | 13 ++++++++++++-
>   {scripts => tools/objtool}/recordmcount.c  |  0
>   {scripts => tools/objtool}/recordmcount.h  |  0
>   {scripts => tools/objtool}/recordmcount.pl |  0
>   12 files changed, 33 insertions(+), 17 deletions(-)
>   rename {scripts => tools/objtool}/recordmcount.c (100%)
>   rename {scripts => tools/objtool}/recordmcount.h (100%)
>   rename {scripts => tools/objtool}/recordmcount.pl (100%)
> 
> diff --git a/Documentation/trace/ftrace-design.rst b/Documentation/trace/ftrace-design.rst
> index a8e22e0db63c..dea8db5e79d0 100644
> --- a/Documentation/trace/ftrace-design.rst
> +++ b/Documentation/trace/ftrace-design.rst
> @@ -261,7 +261,7 @@ You need very few things to get the syscalls tracing in an arch.
>   HAVE_FTRACE_MCOUNT_RECORD
>   -------------------------
>   
> -See scripts/recordmcount.pl for more info.  Just fill in the arch-specific
> +See tools/objtool/recordmcount.pl for more info.  Just fill in the arch-specific
>   details for how to locate the addresses of mcount call sites via objdump.
>   This option doesn't make much sense without also implementing dynamic ftrace.
>   
> @@ -379,7 +379,7 @@ linux/ftrace.h for the functions::
>   	ftrace_make_call()
>   
>   The rec->ip value is the address of the mcount call site that was collected
> -by the scripts/recordmcount.pl during build time.
> +by the tools/objtool/recordmcount.pl during build time.
>   
>   The last function is used to do runtime patching of the active tracer.  This
>   will be modifying the assembly code at the location of the ftrace_call symbol
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index 3b5614b1d1a5..9adefcc3c7a8 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -2685,7 +2685,7 @@ starts of pointing to a simple return. (Enabling FTRACE will
>   include the -pg switch in the compiling of the kernel.)
>   
>   At compile time every C file object is run through the
> -recordmcount program (located in the scripts directory). This
> +recordmcount program (located in the tools/objtool directory). This
>   program will parse the ELF headers in the C object to find all
>   the locations in the .text section that call mcount. Starting
>   with gcc version 4.6, the -mfentry has been added for x86, which
> diff --git a/Makefile b/Makefile
> index 04f5662ae61a..d353a0a65a71 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -844,6 +844,7 @@ ifdef CONFIG_DYNAMIC_FTRACE
>   	ifdef CONFIG_HAVE_C_RECORDMCOUNT
>   		BUILD_C_RECORDMCOUNT := y
>   		export BUILD_C_RECORDMCOUNT
> +		objtool_target := tools/objtool FORCE
>   	endif
>   endif
>   endif
> @@ -1023,10 +1024,10 @@ endif
>   export mod_sign_cmd
>   
>   HOST_LIBELF_LIBS = $(shell pkg-config libelf --libs 2>/dev/null || echo -lelf)
> +has_libelf := $(call try-run,\
> +		echo "int main() {}" | $(HOSTCC) -xc -o /dev/null $(HOST_LIBELF_LIBS) -,1,0)
>   

Maybe there could be some build dependency, e.g. CONFIG_OBJTOOL_SUBCMDS 
that sets the "objtool_target" and "has_libelf" when selected.

Then the CONFIG_UNWINDER_ORC, RECORD_MCOUNT and STACK_VALIDATION would 
just had to select that config option.

>   ifdef CONFIG_STACK_VALIDATION
> -  has_libelf := $(call try-run,\
> -		echo "int main() {}" | $(HOSTCC) -xc -o /dev/null $(HOST_LIBELF_LIBS) -,1,0)
>     ifeq ($(has_libelf),1)
>       objtool_target := tools/objtool FORCE
>     else
> @@ -1163,13 +1164,15 @@ uapi-asm-generic:
>   
>   PHONY += prepare-objtool
>   prepare-objtool: $(objtool_target)
> -ifeq ($(SKIP_STACK_VALIDATION),1)
> -ifdef CONFIG_UNWINDER_ORC
> +ifneq ($(has_libelf),1)
> +  ifdef CONFIG_UNWINDER_ORC
>   	@echo "error: Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel" >&2
>   	@false
> -else
> +  else
> +    ifeq ($(SKIP_STACK_VALIDATION),1)
>   	@echo "warning: Cannot use CONFIG_STACK_VALIDATION=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel" >&2


I think this would be more readable without the else branch:

	ifneq ($(has_libelf),1)
		ifdef <some objtool command config>
			<warn about unavailability>
		endif
		ifdef <another objtool command config>
			<warn ...>
		endif
		<...>
	endif


Cheers,

-- 
Julien Thierry

