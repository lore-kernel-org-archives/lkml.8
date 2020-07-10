Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CAFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 21:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB349206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 21:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgGJVqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 17:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgGJVqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 17:46:31 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE31C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 14:46:31 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 113C52D7;
        Fri, 10 Jul 2020 21:46:31 +0000 (UTC)
Date:   Fri, 10 Jul 2020 15:46:30 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     torvalds@linux-foundation.org, davej@codemonkey.org.uk,
        kvalo@codeaurora.org, luis.f.correia@gmail.com, cyphar@cyphar.com,
        paulburton@kernel.org, ribalda@kernel.org, martink@posteo.de,
        geert+renesas@glider.be, mchehab+samsung@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CREDITS: replace HTTP links with HTTPS ones and add
 myself
Message-ID: <20200710154630.31521104@lwn.net>
In-Reply-To: <20200710194342.33107-1-grandmaster@al2klimov.de>
References: <20200710194342.33107-1-grandmaster@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jul 2020 21:43:42 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

> Regarding the links:
> 
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.
> 
> Regarding the addition of myself:

A couple of things here...

> Rationale:
> * 93431e0607e5

This is ... not particularly self-explanatory.  Is that meant to be a
commit reference?  If so, you would want to use the normal format.

> * the replaced links in this patch

If you are going to do something like make an addition to the file, you
need to do that separately from a cleanup patch.

But somebody has to say this: I don't think we have any sort of laid-down
policy for what it takes to be mentioned in CREDITS, but I don't think that
your work thus far clears whatever bar we might set.  We don't immortalize
every person who submits some cleanup patches, or this file would be a long
one indeed.  If you would like to be remembered for your kernel work, I
would respectfully suggest that you move beyond mechanical cleanups into
higher-level work.

One other little thing that jumped out at me:

>  N: Alan Cox
> -W: http://www.linux.org.uk/diary/
> +W: https://www.linux.org.uk/diary/
>  D: Linux Networking (0.99.10->2.0.29)
>  D: Original Appletalk, AX.25, and IPX code
>  D: 3c501 hacker

That link just redirects to linux.com, which is probably not what Alan had
in mind.  Replacing the link with one into the wayback machine (or perhaps
just removing it entirely) would seem like a more useful change than adding
HTTPS to a link that clearly does not reach the intended destination.

Thanks,

jon
