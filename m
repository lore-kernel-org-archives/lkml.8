Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362B7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00EDC212CC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=elastisys.com header.i=@elastisys.com header.b="gVD+9kSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390251AbgFXIBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 04:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387650AbgFXIBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 04:01:51 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AACC061755
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:01:51 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i27so1504191ljb.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elastisys.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rvEDmmCkDmr2sv+i4rKqiz+/VceV2jQu8SKbuqtS5QA=;
        b=gVD+9kSb6d2bDiZdIimjWfchl/Jb1lw+nSC8+mHtOT8OxuNkMaobZXINYFDXGoIrI5
         zmlfBDt4spX85QpUcY1ByKfJntsVkMiPt9+jofLcEdYMhE4au6cCFfjLe5ALZeIVaAZ4
         s98Yl11j3Vi2O4QMuFSB22eyaTGyOIK+T8yIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rvEDmmCkDmr2sv+i4rKqiz+/VceV2jQu8SKbuqtS5QA=;
        b=gvhP9A6WZ00E13IjW7bOHrSC0tMv4n9Fta+r1jK86Cit0wmhBeXQhSmC8DIkvmKa98
         0BGSpwdPD7kiEZGDtBPddELU/062rwB5KjjsdiyZQ693V1cE64AjMhin9TKOPDUMsr7Z
         Km4QxC8PW7GJdaQzk+k9zbN48vyZaRrKVdZVYu+zfzAO/aDG3dap0nTTYBH3d9r9XxvH
         ATidtvxjtAGBgnAZcZZEgm4LKCPvWihGkAthmoocheO/mMUMtIG21Bc+gfVoTzljUitg
         Xhjo6I8vz6MDvzgfJ8b1KvhfWU+m5jdKpy2FzB8NeC74KIBz/ybcacBhfA/C9B+30Qvc
         +dnQ==
X-Gm-Message-State: AOAM532sDoD25+aHohReEG42oJt1X1MndqQKQoTLl8oPSYvhJwYXQ6x2
        qEr4eWTym03+f4LgcHmFjFIs+A==
X-Google-Smtp-Source: ABdhPJw5s+B0Ey6w2mRHbujd5H08dVn8viUmtvyCBNg9M0FKk842x/FnNBYgV5Tr/vgrzdoY62EzwA==
X-Received: by 2002:a2e:8545:: with SMTP id u5mr14382838ljj.141.1592985709699;
        Wed, 24 Jun 2020 01:01:49 -0700 (PDT)
Received: from minitrue (90-224-48-115-no56.tbcn.telia.com. [90.224.48.115])
        by smtp.gmail.com with ESMTPSA id l16sm4874586lfg.2.2020.06.24.01.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 01:01:48 -0700 (PDT)
Date:   Wed, 24 Jun 2020 10:01:47 +0200
From:   Cristian Klein <cristian.klein@elastisys.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: linux-next: build failures after merge of the hid tree
Message-ID: <20200624080147.GA3144@minitrue>
References: <20200621140421.7f4552df@canb.auug.org.au>
 <20200623103736.25f67de5@canb.auug.org.au>
 <nycvar.YFH.7.76.2006240012170.13242@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2006240930110.13242@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2006240930110.13242@cbobk.fhfr.pm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 24, 2020 at 09:30:23AM +0200, Jiri Kosina wrote:
> On Wed, 24 Jun 2020, Jiri Kosina wrote:
> 
> > > > I don't know what caused it, but commit
> > > > 
> > > >   470376737e88 ("HID: allow building hid.ko as an external module")
> > > > 
> > > > did not fix it.  BTW, I build with "make O=...".
> > 
> > That's actually the patch that almost certainly broke it.
> > 
> > CCing Cristian (author of that patch) and Nathan, who apparently sent a 
> > fixup patch for this, but I haven't seen it, as our corporate mailserver 
> > had severe issues yesterday.
> 
> I've now dropped the patch from hid.git
> 
> -- 
> Jiri Kosina
> SUSE Labs
> 

Hi,

I tried several times, but I cannot reproduce. Attached the full compile
log.

Any pointers of why compilation fails on 0day-ci?

--
Cristian Klein, PhD
Cloud-Native Expert
Elastisys AB

--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="compile.log"

cklein@minitrue:~/linux$ git log -3 | cat
commit 35f098c7cdba4e9ec2fcdf5e75411fb96bb8c289
Author: Cristian Klein <cristian.klein@elastisys.com>
Date:   Mon Jun 22 09:59:02 2020 +0200

    linux-next: Signed-off-by missing for commit in the hid tree
    
    On Sun, Jun 21, 2020 at 07:51:24AM +1000, Stephen Rothwell wrote:
    > Hi all,
    >
    > Commit
    >
    >   470376737e88 ("HID: allow building hid.ko as an external module")
    >
    > is missing a Signed-off-by from its author.
    >
    > --
    > Cheers,
    > Stephen Rothwell
    
    Hi,
    
    My bad. Please find attached the corrected patch.
    
    Cheers,
    Cristian
    
    From 8005724373d8cecb241c013d16b2242c7c1fb39e Mon Sep 17 00:00:00 2001
    From: Cristian Klein <cristian.klein@elastisys.com>
    Date: Mon, 22 Jun 2020 08:47:58 +0200
    Subject: [PATCH] Allow building hid.ko as an "external" module
    
    For quickly testing USB HID quirks with a larger community, it is useful
    to be able to build hid.ko as an external module, e.g., against the
    source code of the running kernel.
    
    Before this patch this failed as follows:
    ```
    $ make -C /lib/modules/$(uname -r)/build M=$PWD/drivers/hid
    make: Entering directory '/usr/src/linux-headers-5.3.0-51-generic'
      CC [M]  /home/cklein/linux/drivers/hid/i2c-hid/i2c-hid-core.o
      CC [M]  /home/cklein/linux/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.o
      LD [M]  /home/cklein/linux/drivers/hid/i2c-hid/i2c-hid.o
      CC [M]  /home/cklein/linux/drivers/hid/intel-ish-hid/ishtp/init.o
      CC [M]  /home/cklein/linux/drivers/hid/intel-ish-hid/ishtp/hbm.o
      CC [M]  /home/cklein/linux/drivers/hid/intel-ish-hid/ishtp/client.o
      CC [M]  /home/cklein/linux/drivers/hid/intel-ish-hid/ishtp/bus.o
      CC [M]  /home/cklein/linux/drivers/hid/intel-ish-hid/ishtp/dma-if.o
      CC [M]  /home/cklein/linux/drivers/hid/intel-ish-hid/ishtp/client-buffers.o
      LD [M]  /home/cklein/linux/drivers/hid/intel-ish-hid/intel-ishtp.o
      CC [M]  /home/cklein/linux/drivers/hid/intel-ish-hid/ipc/ipc.o
    /home/cklein/linux/drivers/hid/intel-ish-hid/ipc/ipc.c:12:10: fatal error: client.h: No such file or directory
       12 | #include "client.h"
          |          ^~~~~~~~~~
    compilation terminated.
    make[2]: *** [scripts/Makefile.build:290: /home/cklein/linux/drivers/hid/intel-ish-hid/ipc/ipc.o] Error 1
    make[1]: *** [scripts/Makefile.build:519: /home/cklein/linux/drivers/hid/intel-ish-hid] Error 2
    make: *** [Makefile:1656: _module_/home/cklein/linux/drivers/hid] Error 2
    make: Leaving directory '/usr/src/linux-headers-5.3.0-51-generic'
    ```
    
    Signed-off-by: Cristian Klein <cristian.klein@elastisys.com>

commit c1a371cf80fbc06280cc0064ca99a39d0428ded3
Author: Randy Dunlap <rdunlap@infradead.org>
Date:   Mon Apr 13 09:14:35 2020 -0700

    printk: fix global comment
    
    Fix typo/spello.
    
    Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
    Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
    Signed-off-by: Jiri Kosina <jkosina@suse.cz>

commit 20607434113b8f7d74cfc98e27a4199535c1d4fa
Author: Randy Dunlap <rdunlap@infradead.org>
Date:   Mon Mar 30 17:22:11 2020 -0700

    lib/bitmap.c: fix spello
    
    Fix typo/spello for whitespaces.
    
    Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
    Signed-off-by: Jiri Kosina <jkosina@suse.cz>
cklein@minitrue:~/linux$ cat drivers/hid/intel-ish-hid/Makefile 
# SPDX-License-Identifier: GPL-2.0
#
# Makefile - Intel ISH HID drivers
# Copyright (c) 2014-2016, Intel Corporation.
#
#
obj-$(CONFIG_INTEL_ISH_HID) += intel-ishtp.o
intel-ishtp-objs := ishtp/init.o
intel-ishtp-objs += ishtp/hbm.o
intel-ishtp-objs += ishtp/client.o
intel-ishtp-objs += ishtp/bus.o
intel-ishtp-objs += ishtp/dma-if.o
intel-ishtp-objs += ishtp/client-buffers.o

obj-$(CONFIG_INTEL_ISH_HID) += intel-ish-ipc.o
intel-ish-ipc-objs := ipc/ipc.o
intel-ish-ipc-objs += ipc/pci-ish.o

obj-$(CONFIG_INTEL_ISH_HID) += intel-ishtp-hid.o
intel-ishtp-hid-objs := ishtp-hid.o
intel-ishtp-hid-objs += ishtp-hid-client.o

obj-$(CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER) += intel-ishtp-loader.o
intel-ishtp-loader-objs += ishtp-fw-loader.o

ccflags-y += -I $(src)/ishtp
cklein@minitrue:~/linux$ make W=1 ARCH=x86_64 -j4
  DESCEND  objtool
  CALL    scripts/atomic/check-atomics.sh
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  TEST    posttest
  MODPOST 2315 modules
arch/x86/tools/insn_decoder_test: success: Decoded and checked 6276029 instructions
  TEST    posttest
arch/x86/tools/insn_sanity: Success: decoded and checked 1000000 random instructions with 0 errors (seed:0xbc0b57f0)
Kernel: arch/x86/boot/bzImage is ready  (#1)

--1yeeQ81UyVL57Vl7--
