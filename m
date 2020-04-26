Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7F8C55194
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 16:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6782020A8B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 16:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgDZQjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 12:39:40 -0400
Received: from elvis.franken.de ([193.175.24.41]:56014 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgDZQjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 12:39:40 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jSkJd-0001xo-00; Sun, 26 Apr 2020 18:39:37 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 7EA99C0301; Sun, 26 Apr 2020 18:27:37 +0200 (CEST)
Date:   Sun, 26 Apr 2020 18:27:37 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH v3 3/4] MIPS: VDSO: Use $(LD) instead of $(CC) to link
 VDSO
Message-ID: <20200426162737.GA9322@alpha.franken.de>
References: <20200419202128.20571-1-natechancellor@gmail.com>
 <20200423171807.29713-1-natechancellor@gmail.com>
 <20200423171807.29713-3-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423171807.29713-3-natechancellor@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 10:18:06AM -0700, Nathan Chancellor wrote:
> Currently, the VDSO is being linked through $(CC). This does not match
> how the rest of the kernel links objects, which is through the $(LD)
> variable.

this causes build errors for me when (cross) compiling a big endian target:

target is little endian
mips64-linux-gnu-ld: arch/mips/vdso/elf.o: endianness incompatible with that of the selected emulation
mips64-linux-gnu-ld: failed to merge target specific data of file arch/mips/vdso/elf.o

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
