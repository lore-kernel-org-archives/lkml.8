Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84683C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520F020828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583750383;
	bh=4hZ7LzSOxNhnpmjZEoR0vpKqBEn1z0JS5CERMj6GJVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l6O+TsQt8VpSEpxbdaqNDhCImSV83PZA0rYXuYd9Ayt7OZBvApaP7QMECECJqz41r
	 ouEDflQTsJxLWk1Z9aOtBcase+Hox8eALjVVb7Bu+5dXvjpWFDLfnyP9wH8RoiLYio
	 g63VouiCZ3PwOdoSDPb2q2kVouKQ/Js7uSv0Wsyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgCIKjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 06:39:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbgCIKjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 06:39:41 -0400
Received: from linux-8ccs.fritz.box (p5B2812F9.dip0.t-ipconnect.de [91.40.18.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAC1920674;
        Mon,  9 Mar 2020 10:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583750380;
        bh=4hZ7LzSOxNhnpmjZEoR0vpKqBEn1z0JS5CERMj6GJVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=po+B19xQpl0s8xqmzRzMQ60D90VZKQ22bvGK/FvE+WSB8ZtUOcpS4uHjHQ07UW0HR
         UxhHwKTvK9m2u0glNfzW5U1P8noaFQT2MVn3WRM95YxqF4fM2uaS4bZ2mpd25encgI
         x1f4WznpZXolshiskjsfbr3aeiIeMq6/S0s4fGY0=
Date:   Mon, 9 Mar 2020 11:39:36 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Matthias Maennich <maennich@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] modpost: rework and consolidate logging interface
Message-ID: <20200309103935.GB18870@linux-8ccs.fritz.box>
References: <20200306160206.5609-1-jeyu@kernel.org>
 <CAK7LNARZ4VgaCa_TiDBG-99amBGTTXTQMs9LsK3nO4k+y-5KDQ@mail.gmail.com>
 <20200309095914.GA18870@linux-8ccs.fritz.box>
 <CAK7LNARf9CzZ8dcK5O5vxUoncpDdpzSZctd0YuKeWyfDG_cdwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNARf9CzZ8dcK5O5vxUoncpDdpzSZctd0YuKeWyfDG_cdwA@mail.gmail.com>
X-OS:   Linux linux-8ccs 5.5.0-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Masahiro Yamada [09/03/20 19:20 +0900]:
>On Mon, Mar 9, 2020 at 6:59 PM Jessica Yu <jeyu@kernel.org> wrote:
>>
>> +++ Masahiro Yamada [09/03/20 09:40 +0900]:
>> >Hi Jessica,
>> >
>> >
>> >
>> >On Sat, Mar 7, 2020 at 1:02 AM Jessica Yu <jeyu@kernel.org> wrote:
>> >>
>> >> Rework modpost's logging interface by consolidating merror(), warn(), and
>> >> fatal() to use a single function, modpost_log(). Introduce different
>> >> logging levels (WARN, ERROR, FATAL) as well. The purpose of this cleanup is
>> >> to reduce code duplication when deciding whether or not to warn or error
>> >> out based on a condition.
>> >>
>> >> Signed-off-by: Jessica Yu <jeyu@kernel.org>
>> >> ---
>> >> v3:
>> >>         - remove level variable from modpost_log and just call fprintf in each
>> >>           case
>> >>         - remove warn_unless and just call modpost_log() directly
>> >>         - fix checkpatch error:
>> >>                 ERROR: space required before the open parenthesis '('
>> >>         #102: FILE: scripts/mod/modpost.c:61:
>> >>         + switch(loglevel) {
>> >>
>> >>  scripts/mod/modpost.c | 68 ++++++++++++++++++++++-----------------------------
>> >>  scripts/mod/modpost.h | 14 ++++++++---
>> >>  2 files changed, 40 insertions(+), 42 deletions(-)
>> >>
>> >> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
>> >> index 7edfdb2f4497..a2329235a6db 100644
>> >> --- a/scripts/mod/modpost.c
>> >> +++ b/scripts/mod/modpost.c
>> >> @@ -51,41 +51,34 @@ enum export {
>> >>
>> >>  #define MODULE_NAME_LEN (64 - sizeof(Elf_Addr))
>> >>
>> >> -#define PRINTF __attribute__ ((format (printf, 1, 2)))
>> >> +#define PRINTF __attribute__ ((format (printf, 2, 3)))
>> >>
>> >> -PRINTF void fatal(const char *fmt, ...)
>> >> +PRINTF void modpost_log(enum loglevel loglevel, const char *fmt, ...)
>> >>  {
>> >
>> >
>> >This series looks good to me.
>> >
>> >I can queue it up to kbuild tree
>> >if there is no objection.
>> >
>> >
>> >I just noticed one nit.
>> >
>> >Now that modpost_log() is the only user of PRINTF,
>> >we can delete PRITNF, and directly add the attribute
>> >to modpost_log(), like this:
>> >
>> >
>> >void __attribute__((format(printf, 2, 3)))
>> >modpost_log(enum loglevel loglevel, const char *fmt, ...)
>> >{
>> >       ...
>> >}
>> >
>> >
>> >If you agree, I can modify it when I apply it.
>>
>> Yes, I agree with this change. Thank you!
>>
>> One more thing, it's not immediately obvious to me why the first patch
>> would cause those kbuild warnings :-/ I'll see if I have any luck
>> reproducing them locally..
>>
>
>
>Hmm, this warning option is not so new.
>
>
>At least, commit 7c0d35a339db6 (4 years ago)
>fixed a similar one.

Ah, sorry, I mean the kbuild 0-day bot errors. I am just realizing
the 0-day bot emails are not CC'd to lkml. Here is the error I got
from the bot:

---

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.6-rc4 next-20200306]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Jessica-Yu/modpost-rework-and-consolidate-logging-interface/20200307-052346
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 30fe0d07fd7b27d41d9b31a224052cc4e910947a
config: sh-randconfig-a001-20200306 (attached as .config)
compiler: sh4-linux-gcc (GCC) 7.5.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.5.0 make.cross ARCH=sh 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ERROR: modpost: "adc_single" [arch/sh/boards/mach-hp6xx/hp6xx_apm.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

>
>I use GCC 7.4
>
>If I apply your previous version,
>I see build log like follows:
>
>
>
>
>$ gcc --version
>gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
>Copyright (C) 2017 Free Software Foundation, Inc.
>This is free software; see the source for copying conditions.  There is NO
>warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>
>masahiro@pug:~/ref/linux$ make defconfig all
>  HOSTCC  scripts/kconfig/conf.o
>  HOSTCC  scripts/kconfig/confdata.o
>  HOSTCC  scripts/kconfig/expr.o
>  LEX     scripts/kconfig/lexer.lex.c
>  YACC    scripts/kconfig/parser.tab.[ch]
>  HOSTCC  scripts/kconfig/lexer.lex.o
>  HOSTCC  scripts/kconfig/parser.tab.o
>  HOSTCC  scripts/kconfig/preprocess.o
>  HOSTCC  scripts/kconfig/symbol.o
>  HOSTCC  scripts/kconfig/util.o
>  HOSTLD  scripts/kconfig/conf
>*** Default configuration is based on 'x86_64_defconfig'
>#
># configuration written to .config
>#
>  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
>  SYSHDR  arch/x86/include/generated/asm/unistd_32_ia32.h
>  SYSHDR  arch/x86/include/generated/asm/unistd_64_x32.h
>  SYSTBL  arch/x86/include/generated/asm/syscalls_64.h
>  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
>  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
>  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
>  HOSTCC  arch/x86/tools/relocs_32.o
>  HOSTCC  arch/x86/tools/relocs_64.o
>  HOSTCC  arch/x86/tools/relocs_common.o
>  HOSTLD  arch/x86/tools/relocs
>  HOSTCC  scripts/selinux/genheaders/genheaders
>  HOSTCC  scripts/selinux/mdp/mdp
>  HOSTCC  scripts/kallsyms
>  HOSTCC  scripts/sorttable
>  HOSTCC  scripts/asn1_compiler
>  HOSTCC  scripts/extract-cert
>  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
>  WRAP    arch/x86/include/generated/uapi/asm/errno.h
>  WRAP    arch/x86/include/generated/uapi/asm/fcntl.h
>  WRAP    arch/x86/include/generated/uapi/asm/ioctl.h
>  WRAP    arch/x86/include/generated/uapi/asm/ioctls.h
>  WRAP    arch/x86/include/generated/uapi/asm/ipcbuf.h
>  WRAP    arch/x86/include/generated/uapi/asm/param.h
>  WRAP    arch/x86/include/generated/uapi/asm/poll.h
>  WRAP    arch/x86/include/generated/uapi/asm/resource.h
>  WRAP    arch/x86/include/generated/uapi/asm/socket.h
>  WRAP    arch/x86/include/generated/uapi/asm/sockios.h
>  WRAP    arch/x86/include/generated/uapi/asm/termbits.h
>  WRAP    arch/x86/include/generated/uapi/asm/termios.h
>  WRAP    arch/x86/include/generated/uapi/asm/types.h
>  WRAP    arch/x86/include/generated/asm/early_ioremap.h
>  WRAP    arch/x86/include/generated/asm/export.h
>  WRAP    arch/x86/include/generated/asm/mcs_spinlock.h
>  WRAP    arch/x86/include/generated/asm/mm-arch-hooks.h
>  WRAP    arch/x86/include/generated/asm/mmiowb.h
>  WRAP    arch/x86/include/generated/asm/dma-contiguous.h
>  UPD     include/config/kernel.release
>  UPD     include/generated/uapi/linux/version.h
>  UPD     include/generated/utsrelease.h
>  CC      scripts/mod/empty.o
>  HOSTCC  scripts/mod/mk_elfconfig
>  MKELF   scripts/mod/elfconfig.h
>  HOSTCC  scripts/mod/modpost.o
>scripts/mod/modpost.c: In function ‘modpost_log’:
>scripts/mod/modpost.c:75:2: warning: format not a string literal and
>no format arguments [-Wformat-security]
>  fprintf(stderr, level);
>  ^~~~~~~
>  CC      scripts/mod/devicetable-offsets.s
>  UPD     scripts/mod/devicetable-offsets.h
>  HOSTCC  scripts/mod/file2alias.o
>  HOSTCC  scripts/mod/sumversion.o
>  HOSTLD  scripts/mod/modpost
>  CC      kernel/bounds.s
>  UPD     include/generated/bounds.h
>  UPD     include/generated/timeconst.h
>  CC      arch/x86/kernel/asm-offsets.s
>
>
>-- 
>Best Regards
>Masahiro Yamada
