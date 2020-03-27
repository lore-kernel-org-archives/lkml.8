Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38466C2D0ED
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16132206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgC0RYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:24:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59792 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbgC0RYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:24:15 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHsiF-0048yr-K9; Fri, 27 Mar 2020 17:24:07 +0000
Date:   Fri, 27 Mar 2020 17:24:07 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        richard -rw- weinberger <richard.weinberger@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Mar 27
Message-ID: <20200327172407.GV23230@ZenIV.linux.org.uk>
References: <20200327190740.7385d4ff@canb.auug.org.au>
 <425b6d83-53da-15bb-8e7a-158f7c44ffad@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425b6d83-53da-15bb-8e7a-158f7c44ffad@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 08:52:47AM -0700, Randy Dunlap wrote:
> On 3/27/20 1:07 AM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20200326:
> > 
> 
> on i386, UML defconfig build fails with: (mostly get_user() variants)

Buggered-by: 1a908babcb144 (x86: replace arch macros from compiler with CONFIG_X86_{32,64})

    If the intention is to check i386/x86_64 excluding UML, testing
    CONFIG_X86_{32,64} is simpler.

Which is not true, since uml/x86 configs bloody well *do* have CONFIG_X86_{32,64}
defined.  See arch/x86/um/Kconfig; and yes, it does need those, as well as
arch/x86/Kconfig.cpu.
