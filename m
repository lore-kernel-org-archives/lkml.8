Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F8BC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AAD820773
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584531237;
	bh=SF1DNPR0enBSgKdBirdWsoRW6WTJoFq4zX3quBESlEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S+Xz2JRRLqdbwPf2a9+gJT5ZwfOKUrCVoD55lvGcpKru4cRNZGs6o+iP3fzeDaecN
	 ySsPWCEkBzRFusP05VHk4z9t/cyt8w1gWGGj6Wcs75XDILWGZHhwNhnwrPtTPISNiL
	 m2gGOI5iibSj1q5o3SfdPzx5g5k6+aXPW1Umae+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgCRLd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:33:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbgCRLdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:33:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 997FD20770;
        Wed, 18 Mar 2020 11:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584531235;
        bh=SF1DNPR0enBSgKdBirdWsoRW6WTJoFq4zX3quBESlEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iwyGiktsFUXhYejTsU/95UA6kvb1z/WXWGqDZhn/33VHFdV58Wg6GWpkwgGEwIySw
         /xeCN4IYDyQ2S0/G0BvqUr+fZ0TIup4aE2g/DEguMysi6uWmt/G9QTekzAEYAzqq39
         PAlT6r3jFYXoV2xXMAW1f4tR9bG6/RB2gtbxIbuI=
Date:   Wed, 18 Mar 2020 12:33:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiang Su <suqiang4@huawei.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] UIO: make maximum memory and port regions configurable
Message-ID: <20200318113352.GA2365557@kroah.com>
References: <20200307081008.26848-1-suqiang4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307081008.26848-1-suqiang4@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 07, 2020 at 04:10:08PM +0800, Qiang Su wrote:
> Now each uio device can only support 5 memory regions and
> 5 port regions. It is far from enough for some big system.
> On the other hand, the hard-coded style is not flexible.
> 
> Consider the marco is used as array index, so a range for
> the config is set in menuconfig. The range is set as 1 to 512.
> The default value is still set as 5 to keep consistent with
> current code.
> 
> Signed-off-by: Qiang Su <suqiang4@huawei.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> ---
> Changes since v1:
> - also make port regions configurable in menuconfig.
> - fix kbuild errors.
> ---
>  drivers/uio/Kconfig        | 18 ++++++++++++++++++
>  include/linux/uio_driver.h |  4 ++--
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
> index 202ee81cfc2b..cee7d93cfea2 100644
> --- a/drivers/uio/Kconfig
> +++ b/drivers/uio/Kconfig
> @@ -165,4 +165,22 @@ config UIO_HV_GENERIC
>  	  to network and storage devices from userspace.
>  
>  	  If you compile this as a module, it will be called uio_hv_generic.
> +
> +config MAX_UIO_MAPS
> +	depends on UIO
> +	int "Maximum of memory nodes each uio device support(1-512)"
> +	range 1 512
> +	default 5
> +	help
> +	  make the max number of memory regions in uio device configurable.
> +
> +config MAX_UIO_PORT_REGIONS
> +	depends on UIO
> +	int "Maximum of port regions each uio device support(1-512)"
> +	range 1 512
> +	default 5
> +	help
> +	  make the max number of port regions in uio device configurable.


Can you provide a lot more information in these help texts?  Explain why
you would ever want to change these values, and that if you do not
understand, just take the default ones.

Or, better yet, can we just make these values dynamic and grow as needed
by the system?  Why are they "fixed"?

thanks,

greg k-h
