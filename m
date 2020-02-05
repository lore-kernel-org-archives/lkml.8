Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8023CC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 21:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D7B20730
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 21:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580939240;
	bh=X1U2b/7YDrhtmK6EUP7WVPrInjLUfc8vwhs+po06m5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yqPgWlMbpdkhcyel6K9EXEgmkuOIITM3ZDHg25lULGglyH5IlGtrt7JluW3SjBC5G
	 my06yvvJocYQIZ9ZPzi9KaWrUtEya2/lXTa8pHmJq4e5huWfma4R7liZOV+wK4RX0P
	 GknOQKXDwT/qp76yRA6i+lNOm449ixWjUbpxThnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgBEVrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 16:47:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:46422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbgBEVrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 16:47:19 -0500
Received: from localhost (unknown [193.117.204.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A51A2072B;
        Wed,  5 Feb 2020 21:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580939238;
        bh=X1U2b/7YDrhtmK6EUP7WVPrInjLUfc8vwhs+po06m5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E7mPdsjjUz26jmYrMIbbAspsocDDXvV0G1aojD/z/3yl4SUqCJNSaJjoDCBd6NIUq
         Poo6BTC2wZBaEgzwMyABvn4NXjb1/DpeISwhdmjcwQ1AJU60R5+jqC9+4zrMwD10+y
         hiWSDIcYCns8EoiAiVlPHcp2VsmLlwvKMdAprVy8=
Date:   Wed, 5 Feb 2020 21:47:16 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org, kys@microsoft.com,
        jamorris@microsoft.com
Subject: Re: [PATCH] Documentation/process: Change Microsoft contact for
 embargoed hardware issues
Message-ID: <20200205214716.GA1468203@kroah.com>
References: <20200205213621.31474-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205213621.31474-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 04:36:21PM -0500, Sasha Levin wrote:
> Remove Sasha Levin as the Microsoft contact. A new contact will be
> assigned by Microsoft.
> 
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  Documentation/process/embargoed-hardware-issues.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
> index 33edae654599..a6f4f6e5c78b 100644
> --- a/Documentation/process/embargoed-hardware-issues.rst
> +++ b/Documentation/process/embargoed-hardware-issues.rst
> @@ -250,7 +250,7 @@ an involved disclosed party. The current ambassadors list:
>    Intel		Tony Luck <tony.luck@intel.com>
>    Qualcomm	Trilok Soni <tsoni@codeaurora.org>
>  
> -  Microsoft	Sasha Levin <sashal@kernel.org>
> +  Microsoft

That's fine, but when will that contact "be assigned"?  I'd rather not
go without one at all for no good reason other than "people need to
figure their stuff out" :)

thanks,

greg k-h
