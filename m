Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAF0C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 11:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2277F206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 11:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgDFLgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 07:36:21 -0400
Received: from elvis.franken.de ([193.175.24.41]:55913 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbgDFLgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 07:36:20 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jLQ39-0007W1-00; Mon, 06 Apr 2020 13:36:19 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 2E474C0206; Mon,  6 Apr 2020 13:03:33 +0200 (CEST)
Date:   Mon, 6 Apr 2020 13:03:33 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-mips@linux-mips.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>, linux-mips@vger.kernel.org
Subject: Re: [PATCH] MIPS: fw: arc: add __weak to prom_meminit and
 prom_free_prom_memory
Message-ID: <20200406110333.GA6266@alpha.franken.de>
References: <20200405163052.18942-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200405163052.18942-1-masahiroy@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 01:30:52AM +0900, Masahiro Yamada wrote:
> As far as I understood, prom_meminit() in arch/mips/fw/arc/memory.c
> is overridden by the one in arch/mips/sgi-ip32/ip32-memory.c if
> CONFIG_SGI_IP32 is enabled.
> 
> The use of EXPORT_SYMBOL in static libraries potentially causes a
> problem for the llvm linker [1]. So, I want to forcibly link lib-y
> objects to vmlinux when CONFIG_MODULES=y.
> 
> As a groundwork, we must fix multiple definitions that have previously
> been hidden by lib-y.
> 
> The prom_cleanup() in this file is already marked as __weak (because
> it is overridden by the one in arch/mips/sgi-ip22/ip22-mc.c).
> I think it should be OK to do the same for these two.
> 
> [1]: https://github.com/ClangBuiltLinux/linux/issues/515
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> If MIPS maintainers ack this patch,
> I want to inser it before the following patch:


Acked-By: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
