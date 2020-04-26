Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85968C55191
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 07:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67DAA2070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 07:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgDZHkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 03:40:43 -0400
Received: from verein.lst.de ([213.95.11.211]:42174 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgDZHkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 03:40:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0E93D68C65; Sun, 26 Apr 2020 09:40:40 +0200 (CEST)
Date:   Sun, 26 Apr 2020 09:40:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/7] signal: factor copy_siginfo_to_external32 from
 copy_siginfo_to_user32
Message-ID: <20200426074039.GA31501@lst.de>
References: <20200421154204.252921-1-hch@lst.de> <20200421154204.252921-3-hch@lst.de> <20200425214724.a9a00c76edceff7296df7874@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200425214724.a9a00c76edceff7296df7874@linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 09:47:24PM -0700, Andrew Morton wrote:
> I looked at fixing it but surely this sort of thing:
> 
> 
> int copy_siginfo_to_user32(struct compat_siginfo __user *to,
> 			   const struct kernel_siginfo *from)
> #if defined(CONFIG_X86_X32_ABI) || defined(CONFIG_IA32_EMULATION)
> {
> 	return __copy_siginfo_to_user32(to, from, in_x32_syscall());
> }
> int __copy_siginfo_to_user32(struct compat_siginfo __user *to,
> 			     const struct kernel_siginfo *from, bool x32_ABI)
> #endif
> {
> 	...
> 
> 
> is too ugly to live?

I fixed it up in my earlier versions, but Eric insisted to keep it,
which is why I switched to his version given that he is the defacto
signal.c maintainer.

Here is what I would have preferred:

https://www.spinics.net/lists/kernel/msg3473847.html
https://www.spinics.net/lists/kernel/msg3473840.html
https://www.spinics.net/lists/kernel/msg3473843.html
