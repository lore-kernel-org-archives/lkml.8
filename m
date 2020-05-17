Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D76C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 20:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8999D20758
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 20:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bmN73Qan"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgEQUAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 16:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgEQUAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 16:00:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37DCC061A0C;
        Sun, 17 May 2020 13:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4mr8wP1reH4H89d1vZ/7N3Uu1++dsHcORja4E02ixT0=; b=bmN73Qanno2+ww0Tf1TkbrWL6M
        rzsGcf8HZ+gcyCgysowjhW1nYtAU53udUjqW8cQStmv91eqi74EzaJ1XOuYF7fn326Axm4SRHhnT+
        T45xD5+gieaUp0YYCT5b9g1DwIDHsmpdSlaTAInYZwi7MILnHnQ+abAF1ZVA+u6lyhcJQHe64f5CP
        ql2GLWDhrxklakofoLSI3NfixMhCpPj4STC46q4vh0l3M+rIjsZ0IodBM9JlEbtLQ9+43Jc1y19x3
        WAlKU6S/9hoCkv+1qvC0KtbTjXfvSfZhbDG6dwdbmzFbPJHIJjq2CWNF2VopefIDi7iv9OBdYOnla
        YT4HU+cg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jaPST-0001JF-1u; Sun, 17 May 2020 20:00:25 +0000
Date:   Sun, 17 May 2020 13:00:24 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: documentation
Message-ID: <20200517200024.GO16070@bombadil.infradead.org>
References: <20200516122740.30665-1-grandmaster@al2klimov.de>
 <20200517134544.7d649bbb@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200517134544.7d649bbb@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 17, 2020 at 01:45:44PM -0600, Jonathan Corbet wrote:
> On Sat, 16 May 2020 14:27:40 +0200
> "Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:
> 
> > ... for security reasons.
> > 
> > No breaking changes as either the HTTP vhost redirects to HTTPS
> > or both vhosts redirect to the same location
> > or both serve the same content.
> 
> We're getting closer, but...
> 
>  - There is still too much stuff here.  Remember that somebody has to look
>    at and review this stuff.
> 
>  - A quick check shows that a fair number of these links are broken or
>    redirect to somewhere else.  What is the value of adding "https" to a
>    broken link?
> 
>  - Various documents have maintainers who are likely to be interested in
>    changes and should be copied; that is what the get_maintainer.pl script
>    is for.  If that generates a massive list of recipients, that's a cue
>    that your patch is too large.

... and cc: linux-docs.  I suspect I have some additional feedback, but
I can't provide it because I can't see the patch.
