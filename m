Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69367C35246
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 00:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F71520707
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 00:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgBAAcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 19:32:31 -0500
Received: from fieldses.org ([173.255.197.46]:57216 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbgBAAcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 19:32:31 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id A22E12012; Fri, 31 Jan 2020 19:32:30 -0500 (EST)
Date:   Fri, 31 Jan 2020 19:32:30 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Roberto Bergantinos Corpas <rbergant@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20200201003230.GA32350@fieldses.org>
References: <20200131141309.367c9d8b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131141309.367c9d8b@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 02:13:09PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the akpm-current tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> net/sunrpc/auth_gss/svcauth_gss.c: In function 'gss_proxy_save_rsc':
> net/sunrpc/auth_gss/svcauth_gss.c:1251:19: error: storage size of 'boot' isn't known
>  1251 |   struct timespec boot;
>       |                   ^~~~
> net/sunrpc/auth_gss/svcauth_gss.c:1273:3: error: implicit declaration of function 'getboottime'; did you mean 'getboottime64'? [-Werror=implicit-function-declaration]
>  1273 |   getboottime(&boot);
>       |   ^~~~~~~~~~~
>       |   getboottime64
> net/sunrpc/auth_gss/svcauth_gss.c:1251:19: warning: unused variable 'boot' [-Wunused-variable]
>  1251 |   struct timespec boot;
>       |                   ^~~~
> 
> Caused by commit
> 
>   a415f20a18c9 ("sunrpc: expiry_time should be seconds not timeval")
> 
> from the nfsd tree interacting with commits
> 
>   de371b6c7b73 ("y2038: remove unused time32 interfaces")
>   aa7ff200a719 ("y2038: hide timeval/timespec/itimerval/itimerspec types")
> 
> from the akpm-current tree.
> 
> I have reverted the nfsd commit for today.  A better solution is requested.

Unfortunately that expiry time seems to be a signed 32-bit integer in
both the kernel<->gss-proxy and the gss-proxy<->krb5 interfaces.

I guess we'll have to come to an agreement with the krb5 developers.

Simplest might be to agree that the thing's unsigned.  The expiry
shouldn't ever need to be decades in the future, so unsigned mod 2^32
arithmetic should work forever.

--b.
