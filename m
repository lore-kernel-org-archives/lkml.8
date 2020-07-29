Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B86C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 02:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB22A2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 02:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BUJ/wa/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbgG2COz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 22:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbgG2COy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 22:14:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85363C061794;
        Tue, 28 Jul 2020 19:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=1u/cfoScfk1XVAU6hS/7yiR8e3+dFZhylfwJt1KFn1s=; b=BUJ/wa/S/lOBuQvHgI3H+W6K6m
        paDdu6QwBxIb7AXbnae7nhinRbGMqv5Vu9wCsdr3bNcZaTnLTXyY/e2kA4ykVYNBJ+2gqcP2zIJaI
        EQEUsOGPDwRu08jULNCfkUTkMoR4U3zRxyz1qLKld8+zLtgFAk4u0eu4KPdJGHKGTPETPcAGT9YNG
        2j9D/80XpoqGXNMEfkUEh1B8BXMT+Td+uqSS+B7mrUgvAzjq0pWBgg1r+ZlfXGXDgwpJzqxkzad5F
        FzsT/f9cxVm8ckAe9svcghtGp2rwG5aIxXAnjd7KKvaCTPKcvcG3HEUAEAoaL5i5I9pbTCt3phDNk
        U/23RGHw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0bcK-0001ev-7q; Wed, 29 Jul 2020 02:14:52 +0000
Subject: Re: [PATCH] doc: remove stray HTML entity in '<slash>'
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200729021120.35901-1-luc.vanoostenryck@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1faef34e-053a-121f-1dc5-333c6b6539cc@infradead.org>
Date:   Tue, 28 Jul 2020 19:14:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729021120.35901-1-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/20 7:11 PM, Luc Van Oostenryck wrote:
> An excerpt from POSIX contains three occurrences of '<slash>' but
> the first two are spelled starting with an HTML entity: '&lt;slash>'
> 
> Fix this by replacing the stray HTML entity by a '<'.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Hi Luc,
One day late.
Fixed and merged yesterday.

https://lore.kernel.org/linux-doc/20200727114527.23944-1-vegard.nossum@oracle.com/


> ---
>  Documentation/filesystems/path-lookup.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
> index e2ba15146365..d46688d6770d 100644
> --- a/Documentation/filesystems/path-lookup.rst
> +++ b/Documentation/filesystems/path-lookup.rst
> @@ -78,8 +78,8 @@ particular, ``mkdir()`` and ``rmdir()`` each create or remove a directory named
>  by the final component, and they are required to work with pathnames
>  ending in "``/``".  According to POSIX_
>  
> -  A pathname that contains at least one non- &lt;slash> character and
> -  that ends with one or more trailing &lt;slash> characters shall not
> +  A pathname that contains at least one non-<slash> character and
> +  that ends with one or more trailing <slash> characters shall not
>    be resolved successfully unless the last pathname component before
>    the trailing <slash> characters names an existing directory or a
>    directory entry that is to be created for a directory immediately
> 

cheers.
-- 
~Randy

