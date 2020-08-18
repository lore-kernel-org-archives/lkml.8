Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFBDC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47F9F207DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597759849;
	bh=UHw4qYbrPzRK3neMF8n6Uj8EaiKp5P1vRzZt6PNtX6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cVYd56SDSzfaj9wpNiVbTwUonTYrb3oAGVgCsozt7806H9aOvvPtPjxfn3jhi7pSl
	 LO9mhIkTT+wAknguv61MvzC24s9/iZH0MvZiXNcII2qPKe/A76dgy0kcgzFzoc41yK
	 UtlGp+YRCxG3u4S6OrlgAvZfwGwjEcq6EQvDoceE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgHROKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:10:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgHROKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:10:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 680E920738;
        Tue, 18 Aug 2020 14:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597759843;
        bh=UHw4qYbrPzRK3neMF8n6Uj8EaiKp5P1vRzZt6PNtX6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JwdreFb2yrFPYQ71OidGcViRAMHjNx2EJlto3t7cvzfAVHBAvG/rcRpoKuUuSsd/C
         QEN05fF1pcFOrIg5VHA3jW/liJnwcrnTBGRtYnep+4s2FbVNFMtNiZyye8isnX11sn
         /rgIpdipBW13EJlirv+om+qZeat8nxmJh5UtZ9rg=
Date:   Tue, 18 Aug 2020 16:11:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomer Samara <tomersamara98@gmail.com>
Cc:     devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Riley Andrews <riandrews@android.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hridya Valsaraju <hridya@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Laura Abbott <labbott@redhat.com>,
        Martijn Coenen <maco@android.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v2 1/4] staging: android: Replace BUG_ON with WARN_ON
Message-ID: <20200818141106.GB562377@kroah.com>
References: <cover.1597602783.git.tomersamara98@gmail.com>
 <fd55c53cb20c4887a87c05fffa28c28a740cd314.1597602783.git.tomersamara98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd55c53cb20c4887a87c05fffa28c28a740cd314.1597602783.git.tomersamara98@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 16, 2020 at 10:23:25PM +0300, Tomer Samara wrote:
> BUG_ON() is replaced with WARN_ON at ion_page_pool.c

Why?

> Fixes the following issue:
> Avoid crashing the kernel - try using WARN_ON & recovery code ratherthan BUG() or BUG_ON().

Ideally you can get rid of WARN_ON() too, right?

Many systems run in panic-on-warn mode, so this really does not change
anything.  Try fixing this up properly to not crash at all.

> 
> Signed-off-by: Tomer Samara <tomersamara98@gmail.com>
> ---
>  drivers/staging/android/ion/ion_page_pool.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
> index 0198b886d906..c1b9eda35c96 100644
> --- a/drivers/staging/android/ion/ion_page_pool.c
> +++ b/drivers/staging/android/ion/ion_page_pool.c
> @@ -46,11 +46,13 @@ static struct page *ion_page_pool_remove(struct ion_page_pool *pool, bool high)
>  	struct page *page;
>  
>  	if (high) {
> -		BUG_ON(!pool->high_count);
> +		if (WARN_ON(!pool->high_count))
> +			return NULL;

And can you test this that it works properly?

thanks,

greg k-h
