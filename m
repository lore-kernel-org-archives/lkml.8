Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDD1C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 19:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461FA206D5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 19:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583697461;
	bh=gSf8v0EKhZ8Lf+hGO7tIZ+99EssllmxOy1l9Lll5u5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zqjvdGCDVabclTU4rdgbgvF5uerMzN2dxHk4rKocmJ1xIbxRnZPBjMLoP1nTqyCAk
	 UeIZNlrLWReojt43O5RevKPF0FB2JdRQYESUCXy3w2PbQ1Ku+T74GXoMsg9PvGzgK8
	 32d9LHrZ0LwbChUr499k6RQaxEJCPG0+v7g9kpvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgCHT5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 15:57:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgCHT5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 15:57:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAB6B20848;
        Sun,  8 Mar 2020 19:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583697459;
        bh=gSf8v0EKhZ8Lf+hGO7tIZ+99EssllmxOy1l9Lll5u5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KzzetlXqNlTtgLfmE1ROVd6MhxOTesXbfzNQOKcYJQwAR1YSaszsG2tcwm8e36FSP
         cfXFXiBuec3YQV9jFsWXEhwzXzUYzlHwKAp1b7lSkYU+u6P140c2H+/TdQB3bRHw0I
         CyHiqCf0iBLl2RGzaWDrdH4HUJ4Il3eyeJpCSFaA=
Date:   Sun, 8 Mar 2020 20:57:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] MAINTAINERS: include GOOGLE FIRMWARE entry
Message-ID: <20200308195734.GA4070981@kroah.com>
References: <20200308195116.12836-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200308195116.12836-1-lukas.bulwahn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 08, 2020 at 08:51:16PM +0100, Lukas Bulwahn wrote:
> All files in drivers/firmware/google/ are identified as part of THE REST
> according to MAINTAINERS, but they are really maintained by others.
> 
> Add a basic entry for drivers/firmware/google/ based on a simple statistics
> on tags of commits in that directory:
> 
>   $ git log drivers/firmware/google/ | grep '\-by:' \
>       | sort | uniq -c | sort -nr
>      62     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>      13     Reviewed-by: Guenter Roeck <groeck@chromium.org>
>      12     Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>      11     Reviewed-by: Julius Werner <jwerner@chromium.org>
> 
> There is no specific mailing list for this driver, based on observations
> on the patch emails, and the git history suggests the driver is maintained.
> 
> This was identified with a small script that finds all files belonging to
> THE REST according to the current MAINTAINERS file, and I investigated
> upon its output.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3a0f8115c92c..ed788804daab 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7111,6 +7111,14 @@ S:	Supported
>  F:	Documentation/networking/device_drivers/google/gve.rst
>  F:	drivers/net/ethernet/google
>  
> +GOOGLE FIRMWARE
> +M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>

No, sorry, I am not the maintainer of this.  I'll be glad to be the
person the maintainers send patches to to get into Linus's tree, but I
am not going to be responsible for stuff I know nothing about :)

thanks,

greg k-h
