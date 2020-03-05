Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378C3C3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 19:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0674A20801
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 19:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ktKab+fi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgCETVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 14:21:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53596 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgCETVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 14:21:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RO5gvj1Liy8kmn7CzB4KrBoJkAWMSsWwG2gNJleeRn4=; b=ktKab+fi0a2dSiYwui7V18dNHO
        zdB8QStI67sqFG7m7lsaWAJakpXaF8ojYlz2BRmRewrH5m1zjwPnzTLELx5ALO8pgqfNXL4gvigVB
        28aZZ9STgDEhS+Uoi2wNpfKXQwqN+MzcIBXDmvHWTGV43vl33yrxrLtib9HxdXMCdmR8J1dtXcYIm
        uvJdeAzvp+3oVdLLCuaQ4rgZfT5XVd9GhaBNvx46gYskB2eKSIs+0ePVDOyqgcz8wJg8+O5Gl3Q1y
        wdJpGqpjL9U/AiDgejiMQOHlgW9r8hmjjTMjO8MNXpesrC3PmcLbSnPiwfQEHVLXvxsNkry1cPxG0
        3NHCqq0A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9w3f-0000R1-4G; Thu, 05 Mar 2020 19:21:23 +0000
Date:   Thu, 5 Mar 2020 11:21:23 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     torvalds@linux-foundation.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel,
        linux-doc@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] doc: code generation style
Message-ID: <20200305192123.GN29971@bombadil.infradead.org>
References: <20200305190253.GA28787@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305190253.GA28787@avx2>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 10:02:53PM +0300, Alexey Dobriyan wrote:
> I wonder if it would be useful to have something like this in tree.
> 
> It states trivial things for anyone who looked at disassembly few times
> but still...

It's a bit x86-specific, and it ignores things which matter more like
paying attention to cacheline boundaries in structures.  I'm also not
convinced that those who come after us in ten years and have to widen
everything from int to long will thank us for saving a few bytes of
Icache.

> +.. code-block:: c
> +
> +        int g(int, int, flag_t);
> +        int f(int a, int b)
> +        {
> +                return g(a, b, FLAG_C);
> +        }
> +
> +Appending an argument at the end adds minimum amount of code:
> +
> +.. code-block:: none
> +
> +        f:
> +                mov     edx, FLAG_C
> +                jmp     g
> +
> +Appending an argument in the middle or in the beginning will generate
> +reshuffle sequence:
> +
> +.. code-block:: none
> +
> +        f:
> +                mov     edx, esi
> +                mov     esi, edi
> +                mov     edi, FLAG_C
> +                jmp     g

But if f is static inline, then it makes no difference at all.

> +Constants which don't fit into 12-bit window on arm will be loaded from memory
> +or constructed with 2 loads:

The 12-bit window on ARM is 8 bits rotated by a power of 4.  So for example,
0xc000003f is a valid constant, but 0x000001f7 is not.  I don't know what
arm64 does for constants.

