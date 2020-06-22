Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6693CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 423AC206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592817497;
	bh=WT5Ahyyx8i42ZQ7qRM232RE91svh9/PZCmdTtWCUiG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WPWV1Ntzkbpig67xEMdiThAE77OTjyL2b0PpSaaAZQTlDzSnzuPDVq+6jLMh6doYX
	 u4PFhdUQLYwPzE/7e5q3R6cUZDiZDDDNgqAUFsCXzQmPeUOmCYHYbUI7ejzuUXYOxv
	 w8Juun+e5nLIjP4O7v/LJ1w0+CxCgBqO9/XyBrLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgFVJSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 05:18:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbgFVJSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:18:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 599BB206D7;
        Mon, 22 Jun 2020 09:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592817494;
        bh=WT5Ahyyx8i42ZQ7qRM232RE91svh9/PZCmdTtWCUiG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qzasOlcGl3Chi6UQVFm+8GxPrhmg34NRNqqxRvAJDF+mrMVGxHk2JgTsil1So0K0a
         1PrNabfWAVL7Wu3jLCpHvgz5njoAbyZvMx3Z3CMpRKf6wI9SGnn/+DupyqSlWD2Ewl
         If6SAZMB1EZFLX4VnIMb6DabtSLKgqmMPHVyxKLI=
Date:   Mon, 22 Jun 2020 11:18:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Enderborg <peter.enderborg@sony.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 1/2] tracefs: Remove unnecessary debug_fs checks.
Message-ID: <20200622091809.GA3396796@kroah.com>
References: <20200617133738.6631-1-peter.enderborg@sony.com>
 <20200622083019.15479-1-peter.enderborg@sony.com>
 <20200622083019.15479-2-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622083019.15479-2-peter.enderborg@sony.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 10:30:18AM +0200, Peter Enderborg wrote:
> This is a preparation for debugfs restricted mode.
> We don't need debugfs to trace, the removed check stop tracefs to work
> if debugfs is not initialised. We instead tries to automount within
> debugfs and relay on it's handling. The code path is to create a
> backward compatibility from when tracefs was part of debugfs, it is now
> standalone and does not need debugfs. When debugfs is in restricted
> it is compiled in but not active and return EPERM to clients and
> tracefs wont work if it assumes it is active it is compiled in
> kernel.

I'm sorry, but I can't parse this changelog text at all.  Why exactly
are you doing this?

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> ---
>  kernel/trace/trace.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index ec44b0e2a19c..34ed82364edb 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -8946,9 +8946,7 @@ struct dentry *tracing_init_dentry(void)
>  	if (tr->dir)
>  		return NULL;
>  
> -	if (WARN_ON(!tracefs_initialized()) ||
> -		(IS_ENABLED(CONFIG_DEBUG_FS) &&
> -		 WARN_ON(!debugfs_initialized())))
> +	if (WARN_ON(!tracefs_initialized()))
>  		return ERR_PTR(-ENODEV);
>  

This change makes sense to me anyway, so:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

