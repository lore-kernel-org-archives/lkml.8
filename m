Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06DAC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7275B217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ilg1zLb7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgBEPwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:52:06 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36103 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbgBEPwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:52:02 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so3418994wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 07:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ovooem6EE3pO4Zmr2fzr4JJnM14zzl70OFaFVMHpX4U=;
        b=Ilg1zLb77T4Dipd8iNIpGwdhS5Utm7wzGHfUaU4Gpg+DJ5UoSyoy6tb1bSxwlNKkYE
         kgZsr3e7PMl0Hg7gyzxfluQTuK36BnIp4Gwx868fByX7XTqXzO3MYzPqWUHjx8hja368
         CDwt21EC7zCkn28CZZWRBHe3MVql/OL9ueVp7aBZeWsMIAXI+L3DOYepAPbqmH0SD4VO
         wEirlmdnBwZcv8FdnWM/kxqzOTq49MNAkkqucRp0YF/jT8eDBbX8RgVFygLp8M9a4mzB
         mjequmxIiXl5y39fgsXaQr4OY7V4bPgV8yolVUJnCj8d0/rBZ7FOh+ytDgyvlPKh6QFO
         fSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ovooem6EE3pO4Zmr2fzr4JJnM14zzl70OFaFVMHpX4U=;
        b=OpeUkrtZRJD4lzysLsWZDUrL8Nvex2fFC4BO/dZGMsoNZ3+oFicGGUIbn5N3+YCyC/
         l7hQdfA51Sc6oK2X4s2EMAeMI7kpGy47L7dnikIJm62AIvjwKtBQ+WiHqdE00SWveYRO
         CbHL+TDvGCXffsPjnUvFAOvjGYqKBSn5i2Si3X+CEwoGkpGkYU/TP8spCPEqe50RiXvp
         fmoGgdwqmxUXsz9KGn9VnrupDt4D2yAb2ISCj87TJ03bpMFhEpa9arxK3R8h+5AviK3O
         cFk9xvfGJquzFSyK709G5babqVm0C09842WCTJ5xXqujSup+XS7UXM4T5qqCQ+udJKpG
         FufQ==
X-Gm-Message-State: APjAAAV391CFdOKoxg1K1s/6gTMIVgp8ZgxgLmmpXk0Sdwfy15mXwSst
        HjKRFdKc+pmjranl61ocf9KIKA==
X-Google-Smtp-Source: APXvYqzeFgSgGcSiteM4gBLJnXCK4ZvrT3BdNbG9vo3y2rWwyIDpNsDyIxybyOARxC7fJO968iRkzQ==
X-Received: by 2002:a1c:cc06:: with SMTP id h6mr6617655wmb.118.1580917918391;
        Wed, 05 Feb 2020 07:51:58 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id g128sm8432861wme.47.2020.02.05.07.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 07:51:57 -0800 (PST)
Date:   Wed, 5 Feb 2020 15:51:56 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [sparc64] unable to build kernel after bbfceba15f8 / "kdb: Get
 rid of confusing diag msg from "rd" if current task has no regs"
Message-ID: <20200205155156.5bxbitf3u4tiaxkh@holly.lan>
References: <CADxRZqyB_g3S0OHkNcyDiS8PX-vGwrtH+3Cp-YNJ7SGj3x6bDg@mail.gmail.com>
 <CAD=FV=UYbMMr+obKqCvKpfpsJ-T5n6p9cZZsjFwF4kfTKM0Jqw@mail.gmail.com>
 <CADxRZqwxjqo7h_L0v+9n9nuSqrgCMj5uqKf4kZjekEz8=EMgmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADxRZqwxjqo7h_L0v+9n9nuSqrgCMj5uqKf4kZjekEz8=EMgmQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 12:41:46PM +0300, Anatoly Pugachev wrote:
> On Wed, Feb 5, 2020 at 1:13 AM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Tue, Feb 4, 2020 at 1:14 PM Anatoly Pugachev <matorola@gmail.com> wrote:
> > >
> > > Hello!
> > >
> > > After (bisected) bbfceba15f8d1260c328a254efc2b3f2deae4904 got
> > > mainline, i'm unable to build kernel with the following messages:
> > >
> > > ~/linux-2.6$ make -j olddefconfig; make kernel/debug/kdb/
> > > scripts/kconfig/conf  --olddefconfig Kconfig
> > > #
> > > # No change to .config
> > > #
> > >   CALL    scripts/atomic/check-atomics.sh
> > >   CALL    scripts/checksyscalls.sh
> > > <stdin>:1511:2: warning: #warning syscall clone3 not implemented [-Wcpp]
> > >   CC      kernel/debug/kdb/kdb_main.o
> > > kernel/debug/kdb/kdb_main.c: In function ‘kdb_rd’:
> > > kernel/debug/kdb/kdb_main.c:1857:11: error: ‘dbg_reg_def’ undeclared
> > > (first use in this function); did you mean ‘dbg_reg_def_t’?
> > >  1857 |   rsize = dbg_reg_def[i].size * 2;
> > >       |           ^~~~~~~~~~~
> > >       |           dbg_reg_def_t
> > > kernel/debug/kdb/kdb_main.c:1857:11: note: each undeclared identifier
> > > is reported only once for each function it appears in
> > > kernel/debug/kdb/kdb_main.c:1868:12: error: implicit declaration of
> > > function ‘dbg_get_reg’ [-Werror=implicit-function-declaration]
> > >  1868 |    rname = dbg_get_reg(i, &reg8, kdb_current_regs);
> > >       |            ^~~~~~~~~~~
> > > kernel/debug/kdb/kdb_main.c:1868:10: warning: assignment to ‘char *’
> > > from ‘int’ makes pointer from integer without a cast
> > > [-Wint-conversion]
> > >  1868 |    rname = dbg_get_reg(i, &reg8, kdb_current_regs);
> > >       |          ^
> > > kernel/debug/kdb/kdb_main.c:1874:10: warning: assignment to ‘char *’
> > > from ‘int’ makes pointer from integer without a cast
> > > [-Wint-conversion]
> > >  1874 |    rname = dbg_get_reg(i, &reg16, kdb_current_regs);
> > >       |          ^
> > > kernel/debug/kdb/kdb_main.c:1880:10: warning: assignment to ‘char *’
> > > from ‘int’ makes pointer from integer without a cast
> > > [-Wint-conversion]
> > >  1880 |    rname = dbg_get_reg(i, &reg32, kdb_current_regs);
> > >       |          ^
> > > kernel/debug/kdb/kdb_main.c:1886:10: warning: assignment to ‘char *’
> > > from ‘int’ makes pointer from integer without a cast
> > > [-Wint-conversion]
> > >  1886 |    rname = dbg_get_reg(i, &reg64, kdb_current_regs);
> > >       |          ^
> > > cc1: some warnings being treated as errors
> > > make[3]: *** [scripts/Makefile.build:266: kernel/debug/kdb/kdb_main.o] Error 1
> > > make[2]: *** [scripts/Makefile.build:503: kernel/debug/kdb] Error 2
> > > make[1]: *** [scripts/Makefile.build:503: kernel/debug] Error 2
> > > make: *** [Makefile:1681: kernel] Error 2
> > >
> > >
> > > reversing bbfceba15f8d with current git master branch - makes kernel
> > > compilable again.
> > >
> > > kernel config attached
> >
> > Argh.  Sorry about this.  :(  I'm not setup with a sparc compiler, but
> > I've simulated your results on arm64 by just commenting out the
> > definition of "DBG_MAX_REG_NUM" in "arch/arm64/include/asm/kgdb.h".
> > Hopefully:
> >
> > https://lore.kernel.org/r/20200204141219.1.Ief3f3a7edbbd76165901b14813e90381c290786d@changeid
> >
> > ...will fix you?
> 
> Fixes issue for me. Thank you.

Thanks for the update. I'll pass it along shortly.

Somewhat ironically I don't think I ever enabled pre-release sparc
build testing because of conflicts between the way the sparc kernel
adds -Werror to some of the architecture specific files and the tools I
use to detect new warnings. I might have to look at that as well!


Daniel.
