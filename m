Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62293C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 11:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40864207DA
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 11:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598787722;
	bh=am/hmgglnuiX6yiLja6fWl2y2FRHDnlO4Tkzu/I/DM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rXOWTlQ7NOTRc12VprZe5LacYQVk9PRI+/FCVV8Zl+GGC/rKFdfP9Eq6FcSDjzIlm
	 jqA61LpwhyVTZ7ZsKfd1GQgRJQ3FkbbSzzWOxGJAG7gYX9h3klfqgmYmtYZcIo96+P
	 cY5JYd0TMfzRD6tOorDSJKyT46/aULWzWsfh+vrc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgH3LmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 07:42:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728805AbgH3Ll7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 07:41:59 -0400
Received: from kernel.org (unknown [87.70.91.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 635E4207DA;
        Sun, 30 Aug 2020 11:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598787718;
        bh=am/hmgglnuiX6yiLja6fWl2y2FRHDnlO4Tkzu/I/DM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CjW/2dUkNrqxkQXpcJx+yzNETEJTMuetP94EWLA6Yzz2lFcbylG9wNVXUuCpFPZIb
         yfMTmmvz7pg6x5XtO5ZzQaXyKSVWHBwh5BEBntahMR8xNpFDHssVrR87Fjzt5h/+E8
         2q301cS0g0/QAxeh+3QJe3zF22rLSywTWjXXRm40=
Date:   Sun, 30 Aug 2020 14:41:53 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: submit-checklist: add Documentation clean
 builds
Message-ID: <20200830114153.GC423750@kernel.org>
References: <e38b108c-afec-fd0e-ad09-b4dd5da59fd1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e38b108c-afec-fd0e-ad09-b4dd5da59fd1@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23, 2020 at 05:38:12PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Add to Documentation/process/submit-checklist.rst that patch
> submitters should run "make htmldocs" and verify that any
> Documentation/ changes (patches) are clean (no new warnings/errors).
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  Documentation/process/submit-checklist.rst |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> --- linux-next-20200821.orig/Documentation/process/submit-checklist.rst
> +++ linux-next-20200821/Documentation/process/submit-checklist.rst
> @@ -24,6 +24,10 @@ and elsewhere regarding submitting Linux
>  
>    c) Builds successfully when using ``O=builddir``
>  
> +  d) Any Documentation/ changes build successfully without warnings/errors.

Maybe "... without new warnings/errors"?
Unfortunately we still have plenty of old ones...

> +     Use ``make htmldocs`` or ``make pdfdocs`` to check the build and
> +     fix any issues.
> +
>  3) Builds on multiple CPU architectures by using local cross-compile tools
>     or some other build farm.
>  
> 

-- 
Sincerely yours,
Mike.
