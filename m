Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BDAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF50207FC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594327383;
	bh=s52lUYo3bCaqqtMG0EJGjLSYvwNj/90/L+8tCDOuFNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J1MFQKjPY3kKxrYhe483s/uiw/R26r50jpibRHaHBIWBiuEovpydGfy0C65gQQ86s
	 uBrWgUOxF7k2s3i1oZYFcnIXDtbgx4WE9UDptIQ9pVSVZ7LIG6wXf+m20Nomlsag29
	 HtLJwHUeuhr3BFUOb56jHK7KerxstGZSYBJccqSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgGIUnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 16:43:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgGIUnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 16:43:01 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97238207FC;
        Thu,  9 Jul 2020 20:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594327380;
        bh=s52lUYo3bCaqqtMG0EJGjLSYvwNj/90/L+8tCDOuFNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jS2Q2zf5qYaEgh1qOYNnQjxQsQ2D65LKJq6jiXtVuJ/wNM02+5ECrdscx+n5xLr8s
         acGssbXUqtql5ll6CJz3x78WoPYwIbTxEL7lq9QTGoL/4OJzSOZv8ngdfKK+jJyXO7
         SDHXemoPBo0s3Oib9WwDEwJoYSsEndDs7btr12kw=
Date:   Thu, 9 Jul 2020 21:42:56 +0100
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        security@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/security-bugs: Explain why plain text is
 preferred
Message-ID: <20200709204255.GA29288@willie-the-truck>
References: <202007091110.205DC6A9@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007091110.205DC6A9@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 11:11:30AM -0700, Kees Cook wrote:
> The security contact list gets regular reports contained in archive
> attachments. This tends to add some back-and-forth delay in dealing with
> security reports since we have to ask for plain text, etc.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  Documentation/admin-guide/security-bugs.rst | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/security-bugs.rst b/Documentation/admin-guide/security-bugs.rst
> index dcd6c93c7aac..c32eb786201c 100644
> --- a/Documentation/admin-guide/security-bugs.rst
> +++ b/Documentation/admin-guide/security-bugs.rst
> @@ -21,11 +21,18 @@ understand and fix the security vulnerability.
>  
>  As it is with any bug, the more information provided the easier it
>  will be to diagnose and fix.  Please review the procedure outlined in
> -admin-guide/reporting-bugs.rst if you are unclear about what
> +:doc:`reporting-bugs` if you are unclear about what
>  information is helpful.  Any exploit code is very helpful and will not
>  be released without consent from the reporter unless it has already been
>  made public.
>  
> +Please send plain text emails without attachments where possible.
> +It is much harder to have a context-quoted discussion about a complex
> +issue if all the details are hidden away in attachments.  Think of it like a
> +:doc:`regular patch submission <../process/submitting-patches>`
> +(even if you don't have a patch yet): describe the problem and impact, list
> +reproduction steps, and follow it with a proposed fix, all in plain text.
> +

Acked-by: Will Deacon <will@kernel.org>

Hopefully "plain text" implies unencrypted as much as it does "not html".

Will
