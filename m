Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E760C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A6A24699
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582806198;
	bh=2zPnlV0ZH+D2gKvuwb636d2VVVPT90Hpg9RA/haF8ww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=blSG7PJ033F8vDePc5EwFmYpPHecvyEvxsX9qeDcK/jEirVkq6Ah9y+q5xhxgvVAF
	 xLXUESPXZbyQ5LPKzWLcNUsQzTR9vAOWrZ/96h79MVK3fqtKuSEwFWAYC8h5pcKlhA
	 Ynb9f2/MdGqxMfVeB5Gw10NiPwE9XJFii8KW43/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgB0MXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:23:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:60312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728929AbgB0MXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:23:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E6212468E;
        Thu, 27 Feb 2020 12:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582806196;
        bh=2zPnlV0ZH+D2gKvuwb636d2VVVPT90Hpg9RA/haF8ww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RhGbIY7R/Y/9wdj2JrTB0IWT+V6WY/fdbRIzuk2c74jsyICgj1YC/bl4NFDTanvoT
         Sf62Zbx9p/M70y4IvsJ1I2E+EiIM2VzeKReKfieuL69ecKOGAmYFM3LsIALK5cKU2F
         L5mwXjPTJeO8SQFYb3b4n9yAiyShX8kIbZNF/Xi4=
Date:   Thu, 27 Feb 2020 13:23:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     daniel@ffwll.ch, airlied@linux.ie, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 02/21] drm: convert the drm_driver.debugfs_init() hook to
 return void.
Message-ID: <20200227122313.GB896418@kroah.com>
References: <20200227120232.19413-1-wambui.karugax@gmail.com>
 <20200227120232.19413-3-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227120232.19413-3-wambui.karugax@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 03:02:13PM +0300, Wambui Karuga wrote:
> As a result of commit 987d65d01356 (drm: debugfs: make
> drm_debugfs_create_files() never fail) and changes to various debugfs
> functions in drm/core and across various drivers, there is no need for
> the drm_driver.debugfs_init() hook to have a return value. Therefore,
> declare it as void.
> 
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> ---
>  include/drm/drm_drv.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> index 97109df5beac..c6ae888c672b 100644
> --- a/include/drm/drm_drv.h
> +++ b/include/drm/drm_drv.h
> @@ -323,7 +323,7 @@ struct drm_driver {
>  	 *
>  	 * Allows drivers to create driver-specific debugfs files.
>  	 */
> -	int (*debugfs_init)(struct drm_minor *minor);
> +	void (*debugfs_init)(struct drm_minor *minor);


Doesn't this patch break the build, or at least, cause lots of build
warnings to happen?

Fixing it all up later is good, but I don't think you want to break
things at this point in the series.

thanks,

greg k-h
