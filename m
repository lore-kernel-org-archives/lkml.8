Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910F9C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBFEE21531
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=meinberg.de header.i=@meinberg.de header.b="ZuxWG/gS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgIGKDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:03:40 -0400
Received: from server1a.meinberg.de ([176.9.44.212]:58330 "EHLO
        server1a.meinberg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728317AbgIGKDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:03:35 -0400
Received: from srv-kerioconnect.py.meinberg.de (unknown [193.158.22.2])
        (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by server1a.meinberg.de (Postfix) with ESMTPSA id 86F7371C174F;
        Mon,  7 Sep 2020 12:03:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meinberg.de; s=dkim;
        t=1599473011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=AXtai1c1dGrkNbut3r0H+r9NTe7qBA7OINpO02oYtvc=;
        b=ZuxWG/gSIQ5bJT9vnxWaI4M4OcM07eJt2CO9bFT2B6KmW9mKIr1QqQTmbteQM5BZSXb17z
        Wt1MkjtwIqmy5rqQrgjozUWBFUdZ92Tvondxje3hMvrGeqxWuv0CSUR8c/zjszWx75YOu/
        OQC89ZcrU79u2XwVD2WsxN5XmkOkFjRAcENOMLEkf60msFqjYhI6xtUNIrldvy03eZL9b6
        S8sFr0TUxbIcsLpO9AmBotyVbeM/xDVhKGqdihiUg5tAd3CVKEVX9kAaQ+DE3RIK8jLL2w
        IjOSFhgdp5xjkxvYMtvzoqD0fNDDGNsS5hXvzGMw9ReG5rcyLokjqM/VCQsVDA==
X-Footer: bWVpbmJlcmcuZGU=
Received: from localhost ([127.0.0.1])
        by srv-kerioconnect.py.meinberg.de with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Mon, 7 Sep 2020 12:03:27 +0200
From:   Martin Burnicki <martin.burnicki@meinberg.de>
Subject: Re: Kernel build system broken in 5.8?
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
References: <1c4d1da4-36a9-c83b-1a8a-95334aa62ce3@meinberg.de>
 <CAK7LNARpC4GHnXoWM=JU=cYxMdamg5iUWGoXt5o6mhf81QkjLw@mail.gmail.com>
 <092a70e9-12c1-29fd-1fb0-fd851024de39@meinberg.de>
 <CAK7LNAS6nddyJh-mzZbY1NTRK6oT+0OZf9FiqTXmAqhvf869Mw@mail.gmail.com>
Autocrypt: addr=martin.burnicki@meinberg.de; keydata=
 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
 fPTIMcWxGmfGPw==
Organization: Meinberg Funkuhren GmbH & Co. KG, Bad Pyrmont, Germany
Message-ID: <633acdb0-a29a-c24d-b99f-56ea7ba173e9@meinberg.de>
Date:   Mon, 7 Sep 2020 12:03:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAS6nddyJh-mzZbY1NTRK6oT+0OZf9FiqTXmAqhvf869Mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sorry for the late reply. I neede some time figure out what was going
wrong, beside some other tasks.

My driver can be used with all kernels from 2.6 up to the current versions.

In early 2.6 kernels you had to run "make ... modules_add"
to install a module that had been built out-of-tree.

If you ran "make ... modules_install" then *only* the current
out-of-tree module was installed, but *all other* kernel modules were
deleted, leaving the system unusable after the next reboot.

So since many years, my Makefile includes a test to determine if the
make target "modules_add" exists:

make -n ... modules_add

Please note the '-n' in the make command. If this "make" call exited
successfully, "make modules_add" was used to install the module, and
"modules_install" was called otherwise, e.g. for current kernels.

This has been working for many years, up to kernel 5.7.

With kernel 5.8.0-1-default shipped by openSUSE for their Tumbleweed
distro, this test corrupts the pre-configured kernel sources. This
becomes obvious if I run the command "make modules_add" as non-root:

---------------------------------------------------------------------
mbgclock> make -C /lib/modules/`uname -r`/build/ -n modules_add V=1
make: Entering directory '/usr/src/linux-5.8.0-1-obj/x86_64/default'
make -C /usr/src/linux-5.8.0-1-obj/x86_64/default -f
/usr/src/linux-5.8.0-1/Makefile modules_add
mkdir: cannot create directory '.tmp_25862': Permission denied
... ('cannot create' repeated 21 times)
arch/x86/Makefile:147: CONFIG_X86_X32 enabled but no binutils support
mkdir: cannot create directory '.tmp_25907': Permission denied
... ('cannot create' repeated 35 times)
make -f /usr/src/linux-5.8.0-1/Makefile syncconfig
mkdir: cannot create directory '.tmp_26006': Permission denied
... ('cannot create' repeated 13 times)
if [ -f /usr/src/linux-5.8.0-1/.config -o \
         -d /usr/src/linux-5.8.0-1/include/config -o \
         -d /usr/src/linux-5.8.0-1/arch/x86/include/generated ]; then \
        echo >&2 "***"; \
        echo >&2 "*** The source tree is not clean, please run\
                 'make mrproper'"; \
        echo >&2 "*** in /usr/src/linux-5.8.0-1";\
        echo >&2 "***"; \
        false; \
fi
ln -fsn /usr/src/linux-5.8.0-1 source
ln: failed to create symbolic link 'source': Permission denied
make[2]: *** [/usr/src/linux-5.8.0-1/Makefile:557: outputmakefile] Error 1
make[1]: *** [/usr/src/linux-5.8.0-1/Makefile:716:
include/config/auto.conf.cmd] Error 2
make[1]: *** [include/config/auto.conf.cmd] Deleting file
'include/generated/autoconf.h'
make[1]: unlink: include/generated/autoconf.h: Permission denied
make: *** [../../../linux-5.8.0-1/Makefile:185: __sub-make] Error 2
make: Leaving directory '/usr/src/linux-5.8.0-1-obj/x86_64/default'
---------------------------------------------------------------------

One of the last line shows that 'include/generated/autoconf.h' is going
to be deleted, but this just didn't happen because I ran the command
without root permissions.

Of course, autoconf.h *is* deleted if I run the command with root
permission, as required if you really want to install the kernel module.

This happens even though "make" has been called with '-n', even though
the target "modules_add" is invalid, and even worse, it happens if I
call make with *any* invalid target, e.g. "make -C ... M=... xyz".

This is really, really ugly, IMO, and the same problem occurs with a 5.8
kernel for Ubuntu.


Fortunately this doesn't happen if I call the kernel build system
against a vanilla kernel. I've specifically cloned and prepared the
kernel git repo as root to see any "permission denied" errors when I
call the kernel build system as non-root user:

sudo git clone <...>/linux-stable
cd linux-stable
sudo git checkout v5.8
sudo make defconfig
sudo make modules_prepare

---------------------------------------------------------------------
mbgclock> make -C /data-1/projects/linux-stable -n modules_add V=1
make: Entering directory '/data-1/projects/linux-stable'
mkdir: cannot create directory ‘.tmp_20352’: Permission denied
... ('cannot create' repeated ~50 times)
make: *** No rule to make target 'modules_add'.  Stop.
make: Leaving directory '/data-1/projects/linux-stable'
---------------------------------------------------------------------

So this returns with error, as expected because the make target is
invalid, and it tries to create temporary files inside the kernel source
tree, but at least it doesn't try to delete any files like autoconf.h.

If I repeat the test above with linux-stable v5.7, I just get the
expected error, but there is no single "permission denied" error due to
the fact that tmp files/dirs can't be created.


Anyway, for my own project I've implemented a workaround that the test
with make target "modules_add" is only made if the kernel major version
is < 3, which fixes these problems for me.


Thanks,

Martin


Masahiro Yamada wrote:
> On Wed, Aug 19, 2020 at 5:50 AM Martin Burnicki
> <martin.burnicki@meinberg.de> wrote:
>> Hello Masahiro,
>>
>> Masahiro Yamada wrote:
>
> Can you reproduce the issue in the linux-stable source tree
> instead of the ubuntu kernel?
>
> You can get the stable kernel repository, like follows:
>
> $ git clone
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
> $ cd linux-stable
> $ git checkout v5.8.1

OK, but this shouldn't work without further steps, should it?

If I clone the repo from the root account, the files are "read-only" for
a normal user, and if I try to build the driver as normal user, I get an
error, which is expected in this case:

-----------------------------------------------------------------------
$ BUILD_DIR=../linux-stable-tmp make
make -C ../linux-stable-tmp M=/data-1/projects/hello-drvr
make[1]: Entering directory '/data-1/projects/linux-stable-tmp'

  ERROR: Kernel configuration is invalid.
         include/generated/autoconf.h or include/config/auto.conf are
missing.
         Run 'make oldconfig && make prepare' on kernel src to fix it.

Makefile:648: include/config/auto.conf: No such file or directory
make[1]: *** [Makefile:719: include/config/auto.conf] Error 1
make[1]: Leaving directory '/data-1/projects/linux-stable-tmp'
make: *** [Makefile:8: __default] Error 2
-----------------------------------------------------------------------


'make defconfig' (run as root):

-----------------------------------------------------------------------
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/confdata.o
  HOSTCC  scripts/kconfig/expr.o
  LEX     scripts/kconfig/lexer.lex.c
  YACC    scripts/kconfig/parser.tab.[ch]
  HOSTCC  scripts/kconfig/lexer.lex.o
  HOSTCC  scripts/kconfig/parser.tab.o
  HOSTCC  scripts/kconfig/preprocess.o
  HOSTCC  scripts/kconfig/symbol.o
  HOSTCC  scripts/kconfig/util.o
  HOSTLD  scripts/kconfig/conf
*** Default configuration is based on 'x86_64_defconfig'
#
# configuration written to .config
#
-----------------------------------------------------------------------

Unlike mentioned in the output quoted above, this command generates lots
of files below include/config, the file include/generated/autoconf.h,
and a number of files below kconfig/.

pc-martin:/data-1/projects/linux-stable-tmp # make modules_prepare
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  SYSHDR  arch/x86/include/generated/asm/unistd_32_ia32.h
  SYSHDR  arch/x86/include/generated/asm/unistd_64_x32.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
  HOSTCC  scripts/selinux/genheaders/genheaders
  HOSTCC  scripts/selinux/mdp/mdp
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/sorttable
  HOSTCC  scripts/asn1_compiler
  HOSTCC  scripts/extract-cert
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/x86/include/generated/uapi/asm/errno.h
  WRAP    arch/x86/include/generated/uapi/asm/fcntl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctls.h
  WRAP    arch/x86/include/generated/uapi/asm/ipcbuf.h
  WRAP    arch/x86/include/generated/uapi/asm/param.h
  WRAP    arch/x86/include/generated/uapi/asm/poll.h
  WRAP    arch/x86/include/generated/uapi/asm/resource.h
  WRAP    arch/x86/include/generated/uapi/asm/socket.h
  WRAP    arch/x86/include/generated/uapi/asm/sockios.h
  WRAP    arch/x86/include/generated/uapi/asm/termbits.h
  WRAP    arch/x86/include/generated/uapi/asm/termios.h
  WRAP    arch/x86/include/generated/uapi/asm/types.h
  WRAP    arch/x86/include/generated/asm/early_ioremap.h
  WRAP    arch/x86/include/generated/asm/export.h
  WRAP    arch/x86/include/generated/asm/mcs_spinlock.h
  WRAP    arch/x86/include/generated/asm/dma-contiguous.h
  WRAP    arch/x86/include/generated/asm/irq_regs.h
  WRAP    arch/x86/include/generated/asm/mm-arch-hooks.h
  WRAP    arch/x86/include/generated/asm/mmiowb.h
  UPD     include/config/kernel.release
  UPD     include/generated/uapi/linux/version.h
  UPD     include/generated/utsrelease.h
  CC      scripts/mod/empty.o
  HOSTCC  scripts/mod/mk_elfconfig
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/modpost.o
  CC      scripts/mod/devicetable-offsets.s
  UPD     scripts/mod/devicetable-offsets.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  CC      kernel/bounds.s
  UPD     include/generated/bounds.h
  UPD     include/generated/timeconst.h
  CC      arch/x86/kernel/asm-offsets.s
  UPD     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND  objtool
  HOSTCC   /data-1/projects/linux-stable-tmp/tools/objtool/fixdep.o
  HOSTLD   /data-1/projects/linux-stable-tmp/tools/objtool/fixdep-in.o
  LINK     /data-1/projects/linux-stable-tmp/tools/objtool/fixdep
  CC       /data-1/projects/linux-stable-tmp/tools/objtool/exec-cmd.o
  CC       /data-1/projects/linux-stable-tmp/tools/objtool/help.o
  CC       /data-1/projects/linux-stable-tmp/tools/objtool/pager.o
  CC       /data-1/projects/linux-stable-tmp/tools/objtool/parse-options.o
  CC       /data-1/projects/linux-stable-tmp/tools/objtool/run-command.o
  CC       /data-1/projects/linux-stable-tmp/tools/objtool/sigchain.o
  CC       /data-1/projects/linux-stable-tmp/tools/objtool/subcmd-config.o
  LD       /data-1/projects/linux-stable-tmp/tools/objtool/libsubcmd-in.o
  AR       /data-1/projects/linux-stable-tmp/tools/objtool/libsubcmd.a
  MKDIR    /data-1/projects/linux-stable-tmp/tools/objtool/arch/x86/lib/
  GEN
/data-1/projects/linux-stable-tmp/tools/objtool/arch/x86/lib/inat-tables.c
  CC       /data-1/projects/linux-stable-tmp/tools/objtool/arch/x86/decode.o
  LD
/data-1/projects/linux-stable-tmp/tools/objtool/arch/x86/objtool-in.o
  CC       /data-1/projects/linux-stable-tmp/tools/objtool/weak.o
  CC       /data-1/projects/linux-stable-tmp/tools/objtool/check.o
  CC       /data-1/projects/linux-stable-tmp/tools/objtool/special.o
  CC       /data-1/projects/linux-stable-tmp/tools/objtool/orc_gen.o
  CC       /data-1/projects/linux-stable-tmp/tools/objtool/orc_dump.o
  CC       /data-1/projects/linux-stable-tmp/tools/objtool/builtin-check.o
  CC       /data-1/projects/linux-stable-tmp/tools/objtool/builtin-orc.o
  CC       /data-1/projects/linux-stable-tmp/tools/objtool/elf.o
  CC       /data-1/projects/linux-stable-tmp/tools/objtool/objtool.o
  CC       /data-1/projects/linux-stable-tmp/tools/objtool/libstring.o
  CC       /data-1/projects/linux-stable-tmp/tools/objtool/libctype.o
  CC       /data-1/projects/linux-stable-tmp/tools/objtool/str_error_r.o
  CC       /data-1/projects/linux-stable-tmp/tools/objtool/librbtree.o
  LD       /data-1/projects/linux-stable-tmp/tools/objtool/objtool-in.o
  LINK     /data-1/projects/linux-stable-tmp/tools/objtool/objtool


>>
>>> On Wed, Aug 19, 2020 at 1:14 AM Martin Burnicki
>>> <martin.burnicki@meinberg.de> wrote:
>> [...]
>>>> I usually build the kernel module as standard user, and only install the
>>>> new module as root, e.g.:
>>>>
>>>>   git checkout devel   # The 'devel' branch is appropriate for testing
>>>>   cd mbgclock          # the subdirectory of the kernel module
>>>>   git clean -fd; make  # or make V=1 for verbose output
>>>>   sudo make install
>>>
>>>
>>> This is a bad way for reporting a bug
>>> because your project is too big.
>>
>> Sorry for this. I wasn't sure which was the best way to get a contact to
>> folks who are more familiar with details of the kernel build system, and
>> what may have been changed.
> 
> Sorry, if my response was too harsh.
> 
>> A possibility could have
>>
>>> mbgclock/Makefile include the top Makefile,
>>> which is more than 1000 lines.
>>
>> If you run 'make' in the mbgclock subdirectory then the kernel build
>> system is just called as usual, i.e.
>>
>>   make -C <path-to-the-kernel-build-system> M=$PWD <some EXTRA_CFLAGS>
> 
> 
> I know.
> 
> I tried this, and then
> "sudo make modules_install -C <path-to-the-kernel-build-system> M=$PWD"
> but I did not see the issue.
> 
> So, I have no idea what the root-cause is
> at this point.
> 
> 
>> This has been working without problems for many years, for many popular
>> distros, and all kernels from 2.6 up to 5.7 (except that for older
>> kernels SUBDIRS=$PWD was used instead of M=$PWD).
>>
>>> Please provide steps to reproduce it
>>> with a tiny test module.
>>
>> I was just hoping that someone had an idea like "Oh, this is because xyz
>> has changed in kernel 5.18" when he read what I've observed.
>>
>> In the past I've seen cases where folks e.g. from RedHat or SuSE had
>> backported patches from newer kernels to older ones, causing build
>> errors in my driver code, and I was able to apply workarounds to my
>> source code.
>>
>> However, this case is different because obviously the kernel source tree
>> is modified under certain circumstances. Is my assumption correct that
>> this should not happen if I install Linux header packages for a distro,
>> that have been pre-configured according to the running kernel?
> 
> Right.
> External modules should never ever attempt
> to modify the kernel tree since it is often read-only.
> 
> I did not change that behavior
> (unless I was doing a horrible mistake)
> 
> 
> 
>>
>> Anyway, I'm going to try to set up an example which makes it easier to
>> duplicate the problem.
>>
>>> You state 5.7.15 was fine.
>>
>> Yes.
>>
>>> So, could you also run git-bisect, please?
>>
>> Sorry, I've just recently started using git, and yet I'm not too
>> familiar with some of the commands. How could git-bisect help in this case?
> 
> 
> 
> "git bisect" is really useful to find the first bad commit.
> If you have not tried it yet,
> it is worth learning the usage.
> 
> 
> 
> Can you reproduce the issue in the linux-stable source tree
> instead of the ubuntu kernel?
> 
> 
> You can get the stable kernel repository, like follows:
> 
> $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
> $ cd linux-stable
> $ git checkout v5.8.1
> 
> 
> Once you find how to reproduce the bug
> in the git repository,
> it is pretty easy to start bisecting
> with "git bisect start <bad> <good>"
> 
> For example,
> 
> git bisect start v5.8.1  v5.7.15
> 
> Then, repeat "git bisect good" or "git bisect bad",
> depending on whether the bug happens.
> 
> 
> 
> 
> 
> 
>>>> Also, I was under the impression that the kernel source tree should be
>>>> read-only, and kept clean, but this doesn't seem to be the case anymore.
>>>>
>>>>
>>>> For example:
>>>>
>>>> On Ubuntu 19.10 with kernel 5.8.1-050801-generic from
>>>> https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.8.1/
>>>
>>>
>>> I cannot try it since that is not what
>>> I install on my machine, sorry.
>>
>> What distro are you using? Or do you only run kernels you have compiled
>> yourself? ;-)
> 
> 
> I also use Ubuntu, but my one is 5.4.0-42-generic.
> 
> 
> I am not sure if 5.8.1-050801-generic
> is exactly the same as v5.8.1, though.
> 
> 
> 
> 
>>
>>> Please provide steps to reproduce it
>>> for a person using a different environment.
>>
>> I'm going to try to do this. Do you have any hints what this should look
>> like?
> 
> 
> I'd like to know the steps to reproduce the bug
> in the kernel source tree instead of the distro's one.
> (See above to get the stable kernel tree)
> 
> 
> 
> We could use your project to debug this, but
> if this is purely a problem of the kernel build system,
> it is easier and faster to use a small hello-world module.
> 
> 
> For example, the minimal Makefile
> of an external module will look like follows:
> 
> 
> 
> ------------------------>8---------------------------
> KERNEL=$(HOME)/workspace/linux-stable
> 
> .PHONY: __default
> __default:
>         $(MAKE) -C $(KERNEL) M=$(CURDIR)
> 
> .PHONY: $(MAKECMDGOALS)
> $(MAKECMDGOALS):
>         $(MAKE) -C $(KERNEL) M=$(CURDIR) $@
> 
> obj-m := helloworld.o
> ------------------------>8---------------------------
> 
> 
> 
> 
> 
> 
>>
>> Should this topic be continued on linux-kernel@, or better on
>> linux-kbuild@, or elsewhere?
> 
> 
> Please include both lists in To or Cc.
> 
> linux-kernel@ is a large amount.
> 
> I often miss mails if they are only
> sent to linux-kernel@.
> 
> 
> 
> 
> Thanks.
> 
> 
> 
> 
>>
>>
>> Thanks,
>>
>> Martin
>> --
>> Martin Burnicki
>>
>> Senior Software Engineer
>>
>> MEINBERG Funkuhren GmbH & Co. KG
>> Email: martin.burnicki@meinberg.de
>> Phone: +49 5281 9309-414
>> Linkedin: https://www.linkedin.com/in/martinburnicki/
>>
>> Lange Wand 9, 31812 Bad Pyrmont, Germany
>> Amtsgericht Hannover 17HRA 100322
>> Geschäftsführer/Managing Directors: Günter Meinberg, Werner Meinberg,
>> Andre Hartmann, Heiko Gerstung
>> Websites: https://www.meinberg.de  https://www.meinbergglobal.com
>> Training: https://www.meinberg.academy
>>
> 
> 


-- 
Martin Burnicki

Senior Software Engineer

MEINBERG Funkuhren GmbH & Co. KG
Email: martin.burnicki@meinberg.de
Phone: +49 5281 9309-414
Linkedin: https://www.linkedin.com/in/martinburnicki/

Lange Wand 9, 31812 Bad Pyrmont, Germany
Amtsgericht Hannover 17HRA 100322
Geschäftsführer/Managing Directors: Günter Meinberg, Werner Meinberg,
Andre Hartmann, Heiko Gerstung
Websites: https://www.meinberg.de  https://www.meinbergglobal.com
Training: https://www.meinberg.academy





