Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B05C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 16:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E21220781
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 16:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgFZQiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 12:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgFZQiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 12:38:01 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86363C03E979;
        Fri, 26 Jun 2020 09:38:01 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 150A77DB;
        Fri, 26 Jun 2020 16:38:01 +0000 (UTC)
Date:   Fri, 26 Jun 2020 10:37:59 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones:
 Documentation/sphinx/parse-headers.pl
Message-ID: <20200626103759.75d92856@lwn.net>
In-Reply-To: <20200620075402.22347-1-grandmaster@al2klimov.de>
References: <20200620075402.22347-1-grandmaster@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jun 2020 09:54:02 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   For each line:
>     If doesn't contain `\bxmlns\b`:
>       For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>         If both the HTTP and HTTPS versions
>         return 200 OK and serve the same content:
>           Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Documentation/sphinx/parse-headers.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/sphinx/parse-headers.pl b/Documentation/sphinx/parse-headers.pl
> index c518050ffc3f..00a69aceff44 100755
> --- a/Documentation/sphinx/parse-headers.pl
> +++ b/Documentation/sphinx/parse-headers.pl
> @@ -393,7 +393,7 @@ Report bugs to Mauro Carvalho Chehab <mchehab@kernel.org>
>  
>  Copyright (c) 2016 by Mauro Carvalho Chehab <mchehab+samsung@kernel.org>.
>  
> -License GPLv2: GNU GPL version 2 <http://gnu.org/licenses/gpl.html>.
> +License GPLv2: GNU GPL version 2 <https://gnu.org/licenses/gpl.html>.
>  
>  This is free software: you are free to change and redistribute it.
>  There is NO WARRANTY, to the extent permitted by law.

I've applied this, but I think the correct fix is to replace that notice
with an SPDX header.

jon
