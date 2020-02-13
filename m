Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB708C3B18C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B771217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgBMSwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:52:41 -0500
Received: from ms.lwn.net ([45.79.88.28]:47028 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbgBMSwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:52:40 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DD999740;
        Thu, 13 Feb 2020 18:52:39 +0000 (UTC)
Date:   Thu, 13 Feb 2020 11:52:38 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] docs: pretty up sysctl/kernel.rst
Message-ID: <20200213115238.1cce0534@lwn.net>
In-Reply-To: <20200213174701.3200366-2-steve@sk2.org>
References: <20200213174701.3200366-1-steve@sk2.org>
        <20200213174701.3200366-2-steve@sk2.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2020 18:46:56 +0100
Stephen Kitt <steve@sk2.org> wrote:

> This updates sysctl/kernel.rst to use ReStructured Text more fully:
> * the list of files is now the table of contents (old entries with no
>   corresponding sections are added as empty sections for now);
> * code references and commands are formatted as code, except for
>   function names which end up linked to the appropriate documentation;
> * links are used to point to other documentation and other sections;
> * tables are used to make lists of values more readable (as already
>   done for some sections);
> * in heavily-reworked paragraphs, sentences are wrapped individually,
>   to make future diffs easier to read.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 987 ++++++++++----------
>  1 file changed, 493 insertions(+), 494 deletions(-)

So this looks generally good, but...

> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index def074807cee..1de8f0b199b1 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -2,262 +2,188 @@
>  Documentation for /proc/sys/kernel/
>  ===================================
>  
> -kernel version 2.2.10
> +Kernel version 2.2.10

I honestly can't see the value of fixing up a line like that.  When I
encounter a kernel document that references something like 2.2.10, I assume
it's full of dust and cobwebs.  I'd just take that out.

>  Copyright (c) 1998, 1999,  Rik van Riel <riel@nl.linux.org>
>  
> -Copyright (c) 2009,        Shen Feng<shen@cn.fujitsu.com>
> +Copyright (c) 2009,        Shen Feng <shen@cn.fujitsu.com>
>  
> -For general info and legal blurb, please look in index.rst.
> +For general info and legal blurb, please look in :doc:`index`.
>  
>  ------------------------------------------------------------------------------
>  
>  This file contains documentation for the sysctl files in
> -/proc/sys/kernel/ and is valid for Linux kernel version 2.2.
> +``/proc/sys/kernel/`` and is valid for Linux kernel version 2.2.

This could be tweaked as well.  If, after your work, you think it's still
not current, a warning to that effect should be put in instead.

There's some other dated stuff below that can go as well.  Probably this is
best done in a separate patch.

Thanks,

jon
