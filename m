Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D08AC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD462074D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mor93Vz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388929AbgDBRyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:54:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46955 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgDBRx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:53:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id k191so2157983pgc.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 10:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5SMpG0rss3w3oQ6D7WN4mOS98FtPFU0Jes6zebrYWHE=;
        b=Mor93Vz4MFfsNFsxePkYehMjJAMEY3CiU5HupagAWhMCO1/HlrYpcpnegsnNVZTY9o
         QLHQUC1Hkb93D7KekRI/c2HmA9Ba3+GgKJwkqqSulXr7YV5rn3IhEUuTRl+mvH2VKFZh
         hEJbt3yLwhHsaewvbpfqkgBZqYo9FIPhORdQz1y+EnSvTDtI89oP3M0Rdq6fQ0V8Uqy2
         m6EkxLJoWSsgM/3Vc63hkXgYUK/00SPIFluSMcuCQe5+YOEwGIj4NgRGIZudUP3yaPXs
         h3kYFaS56KTjd2XhcYldCdfcNzpydDPWhyQMLqb0EpcMcx0xwKa+F90S/9ldGlJZHUWl
         sL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5SMpG0rss3w3oQ6D7WN4mOS98FtPFU0Jes6zebrYWHE=;
        b=kuw3C6NvMhjgiYrfkT3T86luK/6cpUuhgNIJgTttU5sqAOokuGZcMPNQ/jNdfwOaIY
         XWbDC34aaIQctOF7XOVt+JiM2YIWFPeRTN2Zdvn3JdXgaNIsEZH/AiuDnQxUGyl7rwmZ
         1SXC0qAPKkg7pkySurwb/4Ppb6DzoSCFpP9YbCRnrGZaPxokw3MwtUfwfraq+nLC+S5k
         LGDJfIj3JplJSzLN5sU/fqv5FlTKRqpPGdooMa6gUV4Qn58Qg3daLMRI2rdIzEGtqn8O
         aAsxRopxrKRS463hqz7vZEQU4oyPDkR86obxJqcmNr9nKYvVDIhGjQtGkYgRaY2jlGmx
         sv3A==
X-Gm-Message-State: AGi0PuZSAQsVbYMMVigiHlawSw3bYHaNIrmmv46wcVqFkDZRyHM4SWL6
        0bxTqEeXRo34XqpY7ZyfxbqFPQ==
X-Google-Smtp-Source: APiQypLxalJ5ztobr0Ak5M39+9J7TCvFQHybLTNNuQAj3QTUO7FnBzSX4CVIeiSVpfeP3eovHPCsSA==
X-Received: by 2002:a63:2a97:: with SMTP id q145mr4325152pgq.22.1585850038165;
        Thu, 02 Apr 2020 10:53:58 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id q71sm4246591pfc.92.2020.04.02.10.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 10:53:57 -0700 (PDT)
Date:   Thu, 2 Apr 2020 10:53:54 -0700
From:   Fangrui Song <maskray@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>
Cc:     linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mao Han <han_mao@c-sky.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Jordan Rupprecht <rupprecht@google.com>
Subject: Re: [PATCH] riscv: fix vdso build with lld
Message-ID: <20200402175354.pzhzhumlqsjk66nu@google.com>
References: <20200402085559.24865-1-ilie.halip@gmail.com>
 <CAKwvOdnasXV2Uw1r4we_46oGD_0Ybjanm7T_-9J83bdf6jeOAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAKwvOdnasXV2Uw1r4we_46oGD_0Ybjanm7T_-9J83bdf6jeOAg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment of `With ld -R we can then ...` should be fixed as well.

On 2020-04-02, Nick Desaulniers wrote:
>+ Jordan, Fangrui
>
>On Thu, Apr 2, 2020 at 1:56 AM Ilie Halip <ilie.halip@gmail.com> wrote:
>>
>> When building with the LLVM linker this error occurrs:
>>     LD      arch/riscv/kernel/vdso/vdso-syms.o
>>   ld.lld: error: no input files
>>
>> This happens because the lld treats -R as an alias to -rpath, as opposed
>> to ld where -R means --just-symbols.
>>
>> Use the long option name for compatibility between the two.
>>
>> Link: https://github.com/ClangBuiltLinux/linux/issues/805
>> Reported-by: Dmitry Golovin <dima@golovin.in>
>> Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
>> ---
>>  arch/riscv/kernel/vdso/Makefile | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
>> index 33b16f4212f7..19f7b9ea10ab 100644
>> --- a/arch/riscv/kernel/vdso/Makefile
>> +++ b/arch/riscv/kernel/vdso/Makefile
>> @@ -41,7 +41,8 @@ SYSCFLAGS_vdso.so.dbg = -shared -s -Wl,-soname=linux-vdso.so.1 \
>>  $(obj)/vdso-dummy.o: $(src)/vdso.lds $(obj)/rt_sigreturn.o FORCE
>>         $(call if_changed,vdsold)
>>
>> -LDFLAGS_vdso-syms.o := -r -R
>> +# lld aliases -R to -rpath; use the longer option name
>
>Thanks for the patch.  Maybe the comment can be dropped? It doesn't
>make sense if there's no -R in the source file you're touching.  If
>someone cares about why `--just-symbols` is spelled out, that's what
>`git log` or vim fugitive is for.  Maybe the maintainer would be kind
>enough to just drop that line for you when merging?
>
>Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
>Jordan, Fangrui, thoughts on this? Sounds like something other users
>of LLD might run into porting their codebase to LLVM's linker.

Independently, I noticed this ~2 days ago.
https://reviews.llvm.org/D76885#1952860

GNU ld parses options with getopt_long and -j is recognized as
--just-symbols ('R') because there is no other long options prefixed with -j.

Now, the following comment applies. Basically, --just-symbols/-R is an
overloaded option. It can be used as an -rpath if the argument is a directory.
The best practice is to use either -rpath or --just-symbols, never -R.

// binutils-gdb/ld/lexsup.c
	case 'R':
	  /* The GNU linker traditionally uses -R to mean to include
	     only the symbols from a file.  The Solaris linker uses -R
	     to set the path used by the runtime linker to find
	     libraries.  This is the GNU linker -rpath argument.  We
	     try to support both simultaneously by checking the file
	     named.  If it is a directory, rather than a regular file,
	     we assume -rpath was meant.  */
	  {
	    struct stat s;

	    if (stat (optarg, &s) >= 0
		&& ! S_ISDIR (s.st_mode))
	      {
		lang_add_input_file (optarg,
				     lang_input_file_is_symbols_only_enum,
				     NULL);
		break;
	      }
	  }




>$ ld.lld --help | grep \\-R
>  -R <value>              Alias for --rpath
>$ ld.bfd --help | grep \\-R
>  -R FILE, --just-symbols FILE
>
>> +LDFLAGS_vdso-syms.o := -r --just-symbols
>>  $(obj)/vdso-syms.o: $(obj)/vdso-dummy.o FORCE
>>         $(call if_changed,ld)
>>
>> --
>> 2.17.1
>>
>
>
>-- 
>Thanks,
>~Nick Desaulniers
