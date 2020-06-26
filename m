Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296E8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F32AE207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593195442;
	bh=6cO14MahD2eqoTeBaK7We6L4gJrj2k+b/ftJFyuTMmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bc6R+3xI7tmu+T6SZnP0o+89/DljVEIf+XTJg5+Ky6fsO2Uu9aaV6xjlmEX/T0ln3
	 jlFUZXHAuC6SuGBZ/7z6AvVqGl6f+9HhyKRRS4sizFuVfJF9iIa/Aoimvv6ye0JGJh
	 3cxtjHkeyMpnjWdX9cLKe9h3+RTuPxOcxqvcK0YA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgFZSRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:17:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgFZSRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:17:19 -0400
Received: from kernel.org (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC37B207D8;
        Fri, 26 Jun 2020 18:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593195439;
        bh=6cO14MahD2eqoTeBaK7We6L4gJrj2k+b/ftJFyuTMmM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jhr6fkibh+hp57t83vdQu2PSEEfVz2VsqS8Ffs1G0+2Kb2hGIZovYf+KpPD7blVjH
         xMrpEboqbKgaCucHmEksLcAIUJvEbDePA15oWs/L//aJoUMmg4HBPVJ4jJjCewjYR9
         SQov2Tb6PmGKynLwadAV2ktVQqo3ePRESlUwZgOY=
Date:   Fri, 26 Jun 2020 21:17:13 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 0/2] sparc32: srmmu: improve type safety of
 __nocache_fix()
Message-ID: <20200626181713.GA3547368@kernel.org>
References: <20200524162151.3493-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524162151.3493-1-rppt@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any comments on this?

On Sun, May 24, 2020 at 07:21:49PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,
> 
> As discussed at [1] the __nocache_fix() macro in sparc's SRMMU can be made
> type safe and so the compiler will yell anout misuse of pXd pointers for
> which the __nocache_fix() is primarily used.
> 
> The first patch is an fix of such misuse that I've discovered after adding
> type cast to __nocache_fix(), but to avoid breaking bisection I've made it
> the first commit.
> 
> --
> Sincerely yours,
> Mike.
> 
> [1] https://lkml.kernel.org/r/CAHk-=wisORTa7QVPnFqNw9pFs62UiwgsD4C4d=MtYy1o4JPyGQ@mail.gmail.com
> 
> Mike Rapoport (2):
>   sparc32: use PUD rather than PGD to get PMD in srmmu_inherit_prom_mappings()
>   sparc32: srmmu: improve type safety of __nocache_fix()
> 
>  arch/sparc/include/asm/pgtsrmmu.h |  2 +-
>  arch/sparc/mm/srmmu.c             | 18 +++++++++---------
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> -- 
> 2.26.2
> 

-- 
Sincerely yours,
Mike.
