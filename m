Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11F7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B69FB20767
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IziCK73l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgGJKhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 06:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgGJKg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 06:36:57 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDE9C08C5CE;
        Fri, 10 Jul 2020 03:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gt5AA1t5mZ7DuneiV89fae4Kc4p9YfbYeLd50laQYXA=; b=IziCK73lUB0NWUEpFgo7ooCQKp
        RE+Izc00ii1X40e8EWpMHgxYEzku7awZs9JaNaPegBoD1Mda0Fo3JD61Gf7sAmwEN0EDQkezKqgM1
        49X4LpdatYYOkSl5KuXRZWbMWfzCwyMiJCYgbCNb6TlFiYYDZs6TLFx9ZfDsC4Dlw5BSKqp5X2SlC
        zAOgGe7Ms3Kh6uMXOMmmQClkiDQCRztUJjgICMbJmkKm8r58ZzkV4LyQksHooiSUcPHE6+pHOYmtN
        4OA4TZe1x/RUwcGk+6ALZ4uG6c2p/sIXbs20DMgC47IqAPKf3cB+dqqAnQVb4oLzYauXGdNO1pv4u
        uFoSRsJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtqOg-0000uE-Vo; Fri, 10 Jul 2020 10:36:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AC62E304E03;
        Fri, 10 Jul 2020 12:36:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 99C902B5130C9; Fri, 10 Jul 2020 12:36:48 +0200 (CEST)
Date:   Fri, 10 Jul 2020 12:36:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        security@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/security-bugs: Explain why plain text is
 preferred
Message-ID: <20200710103648.GE4800@hirez.programming.kicks-ass.net>
References: <202007091110.205DC6A9@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007091110.205DC6A9@keescook>
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

I can do 'gf' on Documentation/admin-guide/reporting-bugs.rst, I can do
didly squat with crap like :doc:'reporting-bugs'.

NAK

>  information is helpful.  Any exploit code is very helpful and will not
>  be released without consent from the reporter unless it has already been
>  made public.
>  
> +Please send plain text emails without attachments where possible.
> +It is much harder to have a context-quoted discussion about a complex
> +issue if all the details are hidden away in attachments.  Think of it like a
> +:doc:`regular patch submission <../process/submitting-patches>`

More unusable references.

> +(even if you don't have a patch yet): describe the problem and impact, list
> +reproduction steps, and follow it with a proposed fix, all in plain text.
> +

You forgot to mention that opening complex file formats is a security
risk all of its own.
