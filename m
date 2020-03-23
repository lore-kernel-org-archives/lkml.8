Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9887AC54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 11:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D73F2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 11:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584963451;
	bh=Qvwdz8ilRZsCc6m4V1drguRDObDE7BaSWVLZcfchPxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kO5Ux4QwMFISeVb3k3V0SXyJfVWlyd6hjUP5hXAV3Yb+pHv/sz8XSzr+y7Y1VBJAs
	 3BzWpf6T8lrudQt1G3ffKK0bayw17T8oCfo7CA8GoHO8Ez8AcOIZDE8/OB6DwhpV1r
	 c6YR6GkYUBZ7BoBmCRAxewfQgaSqI/s4f0a/nEWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgCWLha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 07:37:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728115AbgCWLha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 07:37:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40C172072D;
        Mon, 23 Mar 2020 11:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584963448;
        bh=Qvwdz8ilRZsCc6m4V1drguRDObDE7BaSWVLZcfchPxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pDQDVC84TdvDgm8Yp4vynCgeBAz6qkIsJyMp4y6tkStNL9WlwK/con7SNvepYz+O7
         LKn/lf+cKyg3+AirXdzLWCQnfNlXXUF0JF9f14TRpJ//Ma610xkNa6WfCHyWl3b+Hz
         pVbtSWsDiApFIZ2kuB9HQQauBID5XBMiYWylvG5g=
Date:   Mon, 23 Mar 2020 12:37:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vram-helper: remove unneeded #if defined/endif
 guards.
Message-ID: <20200323113726.GA663867@kroah.com>
References: <20200323112802.228214-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323112802.228214-1-wambui.karugax@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 02:28:02PM +0300, Wambui Karuga wrote:
> Remove unneeded #if/#endif guards for checking whether the
> CONFIG_DEBUG_FS option is set or not. If the option is not set, the
> compiler optimizes the functions making the guards
> unnecessary.
> 
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> ---
>  drivers/gpu/drm/drm_gem_vram_helper.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
> index 76506bedac11..b3201a70cbfc 100644
> --- a/drivers/gpu/drm/drm_gem_vram_helper.c
> +++ b/drivers/gpu/drm/drm_gem_vram_helper.c
> @@ -1018,7 +1018,6 @@ static struct ttm_bo_driver bo_driver = {
>   * struct drm_vram_mm
>   */
>  
> -#if defined(CONFIG_DEBUG_FS)
>  static int drm_vram_mm_debugfs(struct seq_file *m, void *data)
>  {
>  	struct drm_info_node *node = (struct drm_info_node *) m->private;
> @@ -1035,7 +1034,6 @@ static int drm_vram_mm_debugfs(struct seq_file *m, void *data)
>  static const struct drm_info_list drm_vram_mm_debugfs_list[] = {
>  	{ "vram-mm", drm_vram_mm_debugfs, 0, NULL },
>  };
> -#endif
>  
>  /**
>   * drm_vram_mm_debugfs_init() - Register VRAM MM debugfs file.
> @@ -1045,11 +1043,9 @@ static const struct drm_info_list drm_vram_mm_debugfs_list[] = {
>   */
>  void drm_vram_mm_debugfs_init(struct drm_minor *minor)
>  {
> -#if defined(CONFIG_DEBUG_FS)
>  	drm_debugfs_create_files(drm_vram_mm_debugfs_list,
>  				 ARRAY_SIZE(drm_vram_mm_debugfs_list),
>  				 minor->debugfs_root, minor);
> -#endif
>  }
>  EXPORT_SYMBOL(drm_vram_mm_debugfs_init);
>  
> -- 
> 2.25.1

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
