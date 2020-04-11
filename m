Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AF7C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 19:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4CE20708
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 19:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgDKT4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 15:56:04 -0400
Received: from smtprelay0073.hostedemail.com ([216.40.44.73]:33056 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726182AbgDKT4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 15:56:04 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id A47C9180033FB;
        Sat, 11 Apr 2020 19:56:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: neck78_8c18d92872d09
X-Filterd-Recvd-Size: 2758
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sat, 11 Apr 2020 19:56:02 +0000 (UTC)
Message-ID: <aef59a0b1364b0058a183f0e913a828b1b80f1b8.camel@perches.com>
Subject: Re: [PATCH] Staging: kernel: user: fixed some coding style issues
From:   Joe Perches <joe@perches.com>
To:     carlosteniswarrior@gmail.com, gregkh@linuxfoundation.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Date:   Sat, 11 Apr 2020 12:53:57 -0700
In-Reply-To: <20200411194242.11336-1-carlosteniswarrior@gmail.com>
References: <20200411194242.11336-1-carlosteniswarrior@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-04-11 at 21:42 +0200, carlosteniswarrior@gmail.com wrote:
> From: porfavorde <carlosteniswarrior@gmail.com>

Hello.

> Fixed a coding style issue with a for loop and a trailing whitespace in
> the comments
> 
> Signed-off-by: Carlos Guerrero Álvarez <carlosteniswarrior@gmail.com>

A From: line is generally used when sending a patch authored
by someone else.

It would be better here not to use a From: line at all as you
are both the author and sender.

Also please make your first patch somewhere in drivers/staging
and not any other directory until you are familiar with the
kernel styles and tools.  kernel/ isn't really a good place
for a first patch to be accepted, though I don't see anything
wrong with this patch other than the From: line.

But whitespace only changes outside of drivers/staging and a
few other directories are generally not accepted unless sent
as a patch series along with some other change such as
refactoring or a logical change for a defect.

cheers, Joe
---
>  kernel/user.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/user.c b/kernel/user.c
> index 5235d7f49982..4228ec04678d 100644
> --- a/kernel/user.c
> +++ b/kernel/user.c
> @@ -6,7 +6,7 @@
>   *
>   * We have a per-user structure to keep track of how many
>   * processes, files etc the user has claimed, in order to be
> - * able to have per-user limits for system resources. 
> + * able to have per-user limits for system resources.
>   */
>  
>  #include <linux/init.h>
> @@ -216,7 +216,7 @@ static int __init uid_cache_init(void)
>  	uid_cachep = kmem_cache_create("uid_cache", sizeof(struct user_struct),
>  			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL);
>  
> -	for(n = 0; n < UIDHASH_SZ; ++n)
> +	for (n = 0; n < UIDHASH_SZ; ++n)
>  		INIT_HLIST_HEAD(uidhash_table + n);
>  
>  	/* Insert the root user immediately (init already runs as root) */

