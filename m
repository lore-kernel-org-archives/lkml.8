Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39985C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 06:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08CF420730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 06:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588055727;
	bh=k7tWYJkX8W/ar65FHR8zYw4w5XEC1lW5qZA/g/JFiVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mTf0laNTCH7BuO6HmYnZOf0r8Lz1S0OxcLJ9BSlGJG0OQ+/wcp2gLrYwIrudQ1xoU
	 kEfVOSxXV7yQQi563ENwu4ITt3H+jtof/vqVUIe4VGgLxVRKjDmvlHV4lECRIXdyoP
	 cIGB9aZTyQy3yUSTi9qzAkM+/RqQ+lu6s6L4jslE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgD1Gf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 02:35:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbgD1GfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 02:35:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A29A62051A;
        Tue, 28 Apr 2020 06:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588055725;
        bh=k7tWYJkX8W/ar65FHR8zYw4w5XEC1lW5qZA/g/JFiVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RLvjilNyud8QmW8Zo6v4xSzQMp3+7zg1YPyGm3NJfs1m53OGfuIN8LHS3kLa34I8u
         mFGoMiGe40IoDUty2S2Be/jWbYiITLWJoj0MlxlSKIznTT8Cd76+3O0D3J9hU+VUEr
         2dPDqSPXqvJeAz5EE2o1W49OslkvXFUv0MPKgNRY=
Date:   Tue, 28 Apr 2020 08:35:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     jeyu@kernel.org, corbet@lwn.net, rdunlap@infradead.org,
        mchehab+samsung@kernel.org, tglx@linutronix.de,
        akpm@linux-foundation.org, pawan.kumar.gupta@linux.intel.com,
        jgross@suse.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3] module: Allow to disable modsign in kernel cmdline
Message-ID: <20200428063522.GA990431@kroah.com>
References: <20200428060008.50417-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428060008.50417-1-tianjia.zhang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 02:00:08PM +0800, Tianjia Zhang wrote:
> This option allows to disable modsign completely at the beginning,
> and turn off by set the kernel cmdline `no_modsig_enforce` when
> `CONFIG_MODULE_SIG_FORCE` is enabled.
> 
> Yet another change allows to always show the current status of
> modsign through `/sys/module/module/parameters/sig_enforce`.
> 
> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
> 
> v3 change:
>   Beautify the document description according to the recommendation.
> 
> v2 change:
>   document this new option.
> 
>  Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
>  kernel/module.c                                 | 8 ++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 7bc83f3d9bdf..b30f013fb8c5 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3190,6 +3190,12 @@
>  	noirqdebug	[X86-32] Disables the code which attempts to detect and
>  			disable unhandled interrupt sources.
>  
> +	no_modsig_enforce
> +			[KNL] When CONFIG_MODULE_SIG_FORCE is set, this option
> +			allows to disable modsign completely at the beginning.
> +			This means that modules without (valid) signatures will
> +			be loaded successfully.
> +

So now we have module.sig_enforce and this one?  That feels really
confusing, why can't you just use the existing option?

And why would you want to allow the bootloader to override a kernel
build option like this?  That feels risky.

thanks,

greg k-h
