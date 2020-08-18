Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FE6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ED42207DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=meinberg.de header.i=@meinberg.de header.b="oSoBdyyY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgHRQOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:14:35 -0400
Received: from server1a.meinberg.de ([176.9.44.212]:42186 "EHLO
        server1a.meinberg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbgHRQO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:14:29 -0400
X-Greylist: delayed 322 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Aug 2020 12:14:27 EDT
Received: from srv-kerioconnect.py.meinberg.de (unknown [193.158.22.2])
        (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by server1a.meinberg.de (Postfix) with ESMTPSA id D41C971C073F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 18:09:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meinberg.de; s=dkim;
        t=1597766942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
        bh=x3HrpYd46jqqJSdUmhB5V8ttVO7Y4FwgUGYNHOTzprc=;
        b=oSoBdyyYn1PzlvKHsIvcNUZOYr7NXZtgG+M8FiTZH7/lgrOwM9kQQyH22NNJOoYmS9h08a
        7b901t291AGvhKXpHmENi0XcfrNR/C6Q2VK9llzgAautj4QdrC1yi+3ECTX2EpGbMTzbbv
        WAKNQ8fkSlU51rvLJTWXVhRC9EhccluKphGnzbWflipiIM2k1ckin9Q2rABI2lIEnHgzbg
        b3H1lpACMbDOLYJSzOpYKLP3DKlH2hH50vzxIBwZ384cwFy3CEpWfeU/cJdFMSoTG2KiT5
        2+xNetpC+9OAnXG6y1vcI3NHWiFKkb+fuvoXC6+BBHQanoP9cAaxMW6AW33+kw==
X-Footer: bWVpbmJlcmcuZGU=
Received: from localhost ([127.0.0.1])
        by srv-kerioconnect.py.meinberg.de with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
        for linux-kernel@vger.kernel.org;
        Tue, 18 Aug 2020 18:09:00 +0200
To:     linux-kernel@vger.kernel.org
From:   Martin Burnicki <martin.burnicki@meinberg.de>
Subject: Kernel build system broken in 5.8?
Autocrypt: addr=martin.burnicki@meinberg.de; keydata=
 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
 fPTIMcWxGmfGPw==
Organization: Meinberg Funkuhren GmbH & Co. KG, Bad Pyrmont, Germany
Message-ID: <1c4d1da4-36a9-c83b-1a8a-95334aa62ce3@meinberg.de>
Date:   Tue, 18 Aug 2020 18:09:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm the maintainer of a driver package for some PCI cards (GPS receiver
cards, etc.). A read-only git repo of the driver package can be found here:
https://git.meinbergglobal.com/mbgtools-lx.git

The kernel driver from that package is compiled as out-of-tree module,
and runs fine on kernels 2.6, 3.x, 4.x, and 5.x up to 5.7, actually
5.7.15 on Ubuntu.

However, if I try this on kernel 5.8.1, I get strange errors related to
autoconf.h, which make it impossible to compile or install the kernel
module.

I usually build the kernel module as standard user, and only install the
new module as root, e.g.:

  git checkout devel   # The 'devel' branch is appropriate for testing
  cd mbgclock          # the subdirectory of the kernel module
  git clean -fd; make  # or make V=1 for verbose output
  sudo make install

Also, I was under the impression that the kernel source tree should be
read-only, and kept clean, but this doesn't seem to be the case anymore.


For example:

On Ubuntu 19.10 with kernel 5.8.1-050801-generic from
https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.8.1/

'make' completes without error, even if run as normal user without write
permissions in the kernel source tree.

'sudo insmod ./mbgclock.ko' loads the module successfully, and the PCI
card can be accessed as usually, e.g. using the 'mbgstatus' program, so
the compiled kernel module  is OK.

BUT: Once I run 'sudo make install', which calls the kernel build system
to make 'modules_install', I immediately get an error:

-------------------------------------------------------------------------
Calling kernel build system to make "modules_install"
make[1]: Entering directory '/usr/src/linux-headers-5.8.1-050801-generic'

  ERROR: Kernel configuration is invalid.
         include/generated/autoconf.h or include/config/auto.conf are
missing.
         Run 'make oldconfig && make prepare' on kernel src to fix it.

make[1]: *** [Makefile:719: include/config/auto.conf] Error 1
make[1]: Leaving directory '/usr/src/linux-headers-5.8.1-050801-generic'
make: *** [/home/martin/projects/mbgtools-lx/mbgclock/../Makefile:834:
install_module] Error 2
-------------------------------------------------------------------------

And once this has happened, this problem persists, i.e., if I run the
same commands

  git clean -fd; make

once more, as normal user as mentioned above, I get the error above
every time.

Also, If I initially try to build the kernel kernel module as root, with
'sudo':

  git clean -fd; sudo make

I immediately get this error, and the module is not built. Only after I
have re-installed the kernel headers package, I can compile the module
again.


A diff between the kernel header files before and after the kernel build
system has been messed up shows that the following files have changed:

include/generated/autoconf.h
scripts/basic/.fixdep.cmd
scripts/basic/fixdep
scripts/kconfig/.conf.o.cmd
scripts/kconfig/.confdata.o.cmd
scripts/kconfig/.expr.o.cmd
scripts/kconfig/.lexer.lex.c.cmd
scripts/kconfig/conf.o
scripts/kconfig/confdata.o
scripts/kconfig/expr.o
scripts/kconfig/lexer.lex.c
scripts/kconfig/parser.tab.c

Specifically, autoconf.h has been deleted even though some script
obviously still requires that the file is available.


With openSUSE Leap 15.2 and kernel 5.8.1 from
https://download.opensuse.org/repositories/Kernel:/stable/standard/

I've encountered similar problems because include/generated/autoconf.h
is not even available after installation of the kernel headers package.

Only on Arch Linux with kernel 5.8.1-arch1-1 I can build and install the
module as root or standard user, as it was possible with earlier kernel
versions.

Can someone please shed some light on what's going on here?


Thanks,

Martin
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

