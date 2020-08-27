Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAAAC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C25112177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598531450;
	bh=Vvrp+tmN89M6bjpy2BUk7ljI+sJ9DIn4CATSiek9ki8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RY7awfXYJsBkk2lGPXuXRfh4CC1zgRKwEjcU5t5AeAZVjC6Hui7eKszQW67JlTmke
	 +PcdpKCh6zr+7pl3m4J7QNOq3LYJHdFn+6eunnsnrvAfyNyHkeCtp9077zIyY5lodO
	 92wQx04WrbVfKt+6DiX74qSHcKWJsiTJSn+Jlisw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbgH0Mai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 08:30:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728905AbgH0MHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:07:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D938207F7;
        Thu, 27 Aug 2020 12:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598530063;
        bh=Vvrp+tmN89M6bjpy2BUk7ljI+sJ9DIn4CATSiek9ki8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i9INf6l5YnclFk7aRMzOoBMO21t3LSimLuoZjyzYAIRBlFe86T7sxlIo90SJKqSYl
         5z/GjEaqjK5pjV7jcdXD3PEtpTYJdMQNpzCoV0IUCG6lJYEk5Ee5KnhBefCXoAK73a
         B7Fe9slMYjtVmlknqNAJ/LyviVmUczkBlnaDhrCs=
Date:   Thu, 27 Aug 2020 14:07:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brooke Basile <brookebasile@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/2] docs: process: Add cross-link to security-bugs
Message-ID: <20200827120757.GB417381@kroah.com>
References: <20200827105319.9734-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827105319.9734-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 12:53:18PM +0200, Krzysztof Kozlowski wrote:
> The submitting patches mentions criteria for a fix to be called
> "security fix".  Add a link to document explaining the entire process
> of handling security bugs.
> 
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/process/submitting-patches.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
