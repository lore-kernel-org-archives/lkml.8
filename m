Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8C3C07548
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 14:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4B0E207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 14:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599748839;
	bh=0G7G667jJ2wLzt+yDf+HSMCCNH8aghZdGO9b0EnNJWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wtyYaFFkekuWHRHUh6EWYoZzJH7uL0rUA76EYplVMtEW9hUbBVvvLBv4TiFaoGCyh
	 vc2dw6gpOQ009ytFi8KQYyi/+7OYtWQOefLW8vaNOJ6uqLlrDbyiFXOzZ5/SsSlnWC
	 75dTIvE+wNxlADBaAWAXCsw/MuIMa5tVtK7WipGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgIJOkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 10:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731158AbgIJOeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:34:16 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCAAC20855;
        Thu, 10 Sep 2020 14:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599748419;
        bh=0G7G667jJ2wLzt+yDf+HSMCCNH8aghZdGO9b0EnNJWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EVD0MtwMK40ue8Yva5Nf+q97hPxufi58lFUJDEhyVkbP6r4lc6NxL1zt763eBBiIa
         nJ5VFw7zVHrodSqZ78a1z0wj654tpJKFLtUVD8dFAzP9chKwA5xE+AhRKzUnGCpQFn
         JB0NOTCHtcWRP7KhWCeAK26YMA+ctnpR7XP/NJ0c=
Date:   Thu, 10 Sep 2020 09:39:00 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     timur@kernel.org, b.zolnierkie@samsung.com,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] video: fbdev: fsl-diu-fb: remove unneeded variable 'res'
Message-ID: <20200910143900.GA4162@embeddedor>
References: <20200910140558.1191423-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910140558.1191423-1-yanaijie@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 10:05:58PM +0800, Jason Yan wrote:
> Eliminate the following coccicheck warning:
> 
> drivers/video/fbdev/fsl-diu-fb.c:1428:5-8: Unneeded variable: "res".
> Return "0" on line 1450
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  drivers/video/fbdev/fsl-diu-fb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
> index a547c21c7e92..e332017c6af6 100644
> --- a/drivers/video/fbdev/fsl-diu-fb.c
> +++ b/drivers/video/fbdev/fsl-diu-fb.c
> @@ -1425,7 +1425,6 @@ static int fsl_diu_open(struct fb_info *info, int user)
>  static int fsl_diu_release(struct fb_info *info, int user)
>  {
>  	struct mfb_info *mfbi = info->par;
> -	int res = 0;
>  
>  	spin_lock(&diu_lock);
>  	mfbi->count--;
> @@ -1447,7 +1446,7 @@ static int fsl_diu_release(struct fb_info *info, int user)
>  	}
>  
>  	spin_unlock(&diu_lock);
> -	return res;
> +	return 0;
>  }
>  
>  static const struct fb_ops fsl_diu_ops = {
> -- 
> 2.25.4
> 
