Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B041EC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 23:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8277D20848
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 23:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aQIWpoMk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388494AbgCDXEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 18:04:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42718 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388371AbgCDXEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 18:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=KBopAHgFDixzDq6Ax+SWWuSfKv62JIccBqFFr2DrJjk=; b=aQIWpoMkR+D7S+hbnVCV2OK3o7
        pyXLsB0DwzNJjTjcOk1toIYJEcw6Ouih/Uutx9qZGBZK6/MMadq9u48qcc6XIaClhhar0A/KTUqal
        JvcOk2lWo2azi1eWwFPUBVPDUqGdbLbB7WU1Ljm77VXIEt2e1dKZWvw11ne5e8Uo6mAUph3+oDlF/
        +VsQ2A9S61tV6UGyvxox85pRRi511MOPIEJefDUSyXZ//0Zu/dNQsbRcuHhzSfPfe+ztL0ol5m/zr
        Nt2ULIkHCk3MlN17tO+mMyFAlO6iUPEDj82AQaVJAeHpDHGtAYSMTvucQzAnpd5lT4gZJRHDj6f1J
        64sFwSVg==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9d4G-0002y6-Ui; Wed, 04 Mar 2020 23:04:45 +0000
Subject: Re: [PATCH 1/2] bootconfig: Support O=<builddir> option
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <158323467008.10560.4307464503748340855.stgit@devnote2>
 <158323468033.10560.14661631369326294355.stgit@devnote2>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <27ae25f5-29c6-62f3-5531-78fcc28b7d3c@infradead.org>
Date:   Wed, 4 Mar 2020 15:04:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158323468033.10560.14661631369326294355.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/20 3:24 AM, Masami Hiramatsu wrote:
> Support O=<builddir> option to build bootconfig tool in
> the other directory. As same as other tools, if you specify
> O=<builddir>, bootconfig command is build under <builddir>.

Hm.  If I use
$ make O=~/tmp -C tools/bootconfig

that works: it builds bootconfig in ~/tmp.

OTOH, if I sit at the top of the kernel source tree
and I enter
$ mkdir builddir
$ make O=builddir -C tools/bootconfig

I get this:
make: Entering directory '/home/rdunlap/lnx/next/linux-next-20200304/tools/bootconfig'
../scripts/Makefile.include:4: *** O=builddir does not exist.  Stop.
make: Leaving directory '/home/rdunlap/lnx/next/linux-next-20200304/tools/bootconfig'

so it looks like tools/scripts/Makefile.include doesn't handle this case correctly
(which is how I do all of my builds).


> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/bootconfig/Makefile           |   27 +++++++++++++++++----------
>  tools/bootconfig/test-bootconfig.sh |   14 ++++++++++----
>  2 files changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/bootconfig/Makefile b/tools/bootconfig/Makefile
> index a6146ac64458..da5975775337 100644
> --- a/tools/bootconfig/Makefile
> +++ b/tools/bootconfig/Makefile
> @@ -1,23 +1,30 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Makefile for bootconfig command
> +include ../scripts/Makefile.include
>  
>  bindir ?= /usr/bin
>  
> -HEADER = include/linux/bootconfig.h
> -CFLAGS = -Wall -g -I./include
> +ifeq ($(srctree),)
> +srctree := $(patsubst %/,%,$(dir $(CURDIR)))
> +srctree := $(patsubst %/,%,$(dir $(srctree)))
> +endif
>  
> -PROGS = bootconfig
> +LIBSRC = $(srctree)/lib/bootconfig.c $(srctree)/include/linux/bootconfig.h
> +CFLAGS = -Wall -g -I$(CURDIR)/include
>  
> -all: $(PROGS)
> +ALL_TARGETS := bootconfig
> +ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
>  
> -bootconfig: ../../lib/bootconfig.c main.c $(HEADER)
> +all: $(ALL_PROGRAMS)
> +
> +$(OUTPUT)bootconfig: main.c $(LIBSRC)
>  	$(CC) $(filter %.c,$^) $(CFLAGS) -o $@
>  
> -install: $(PROGS)
> -	install bootconfig $(DESTDIR)$(bindir)
> +test: $(ALL_PROGRAMS) test-bootconfig.sh
> +	./test-bootconfig.sh $(OUTPUT)
>  
> -test: bootconfig
> -	./test-bootconfig.sh
> +install: $(ALL_PROGRAMS)
> +	install $(OUTPUT)bootconfig $(DESTDIR)$(bindir)
>  
>  clean:
> -	$(RM) -f *.o bootconfig
> +	$(RM) -f $(OUTPUT)*.o $(ALL_PROGRAMS)
> diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
> index 1411f4c3454f..81b350ffd03f 100755
> --- a/tools/bootconfig/test-bootconfig.sh
> +++ b/tools/bootconfig/test-bootconfig.sh
> @@ -3,9 +3,16 @@
>  
>  echo "Boot config test script"
>  
> -BOOTCONF=./bootconfig
> -INITRD=`mktemp initrd-XXXX`
> -TEMPCONF=`mktemp temp-XXXX.bconf`
> +if [ -d "$1" ]; then
> +  TESTDIR=$1
> +else
> +  TESTDIR=.
> +fi
> +BOOTCONF=${TESTDIR}/bootconfig
> +
> +INITRD=`mktemp ${TESTDIR}/initrd-XXXX`
> +TEMPCONF=`mktemp ${TESTDIR}/temp-XXXX.bconf`
> +OUTFILE=`mktemp ${TESTDIR}/tempout-XXXX`
>  NG=0
>  
>  cleanup() {
> @@ -65,7 +72,6 @@ new_size=$(stat -c %s $INITRD)
>  xpass test $new_size -eq $initrd_size
>  
>  echo "No error messge while applying"
> -OUTFILE=`mktemp tempout-XXXX`
>  dd if=/dev/zero of=$INITRD bs=4096 count=1
>  printf " \0\0\0 \0\0\0" >> $INITRD
>  $BOOTCONF -a $TEMPCONF $INITRD > $OUTFILE 2>&1
> 


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
