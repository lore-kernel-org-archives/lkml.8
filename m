Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E1CC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D5C8207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592530842;
	bh=/DcyoxhOq3EPl6v9vMrYGrha7kfVrA41Sgm4VzQ4Z1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bDyLhTkvKMyVdKksVqZFqguakZ9noZLly7rhDd3Xm8Ry3ykVwvrCXmwuwX6qU3dTr
	 r4WH8i9UmXXC4+TyHQnTU8FQlsnkHiJHJUg13phthZbNvGQzrMUK+0enZ0lPu1ujEI
	 mjweAYTlxKjxjXrMPPpNoIV+EjIAf/2K0CVBt0hY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbgFSBkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 21:40:40 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:33537 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgFSBkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 21:40:39 -0400
Received: by mail-il1-f194.google.com with SMTP id z2so7871271ilq.0;
        Thu, 18 Jun 2020 18:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mJoP7oVOvzpVuZPM3osFjxe5D6t5ctLfG4HCj8088To=;
        b=QvepFfza0ezZ6GE9/Lk5XNGwVLRHCvoEV3lxSkvonpKyiO8IYyod7gBG2bLZbj7d25
         Ie0iMzKwdW8laLSjaWVQQPPoGF5IZoYOKAkmgxlnXuBoVqK60dzOe+tNZ8cUsk1jGBhL
         mVGl7+EtdTtt/HOc4hu5O208IcrsWSu4eehhQ6mdZiW4b80l0BBxBav6zZC6mh2L8YVl
         GVLBajyycq4RL4u3Fe4IKKrSU5L3NY3mND+Gj2hRs2RAHEINNaNi9KVCrpqYQSZqtp9O
         Mpc9eJJJteV923TlXA/jY2gsmeZqJJl+PTvrtzSvEpzIct9l3BHiQvBS5RTEAhSbetmm
         WrEw==
X-Gm-Message-State: AOAM53315IHhi6VSfe4xUHKfoFxRy0hRUBQomVfBAx6qOeo1CWdoOJiC
        h2ho+tCbIZXvrGhf2Ryb+Yo=
X-Google-Smtp-Source: ABdhPJyfe8V1yYPwY1ynMF8zhUqQIJoWWg7x/rgBPX8e9zy+pO7+hD6Bij8+mo58ek+D21nEI0JpmQ==
X-Received: by 2002:a92:dc47:: with SMTP id x7mr1487780ilq.130.1592530838660;
        Thu, 18 Jun 2020 18:40:38 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id u2sm2346059ilg.29.2020.06.18.18.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 18:40:37 -0700 (PDT)
Date:   Thu, 18 Jun 2020 18:40:36 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH][next] fpga: dfl: Use struct_size() in kzalloc()
Message-ID: <20200619014036.GF3685@epycbox.lan>
References: <20200617221039.GA21877@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617221039.GA21877@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 05:10:39PM -0500, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes. Also, remove unnecessary
> function dfl_feature_platform_data_size().
> 
> This code was detected with the help of Coccinelle and, audited and
> fixed manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/fpga/dfl.c | 3 +--
>  drivers/fpga/dfl.h | 6 ------
>  2 files changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 990994874bf1..2dd13e036d45 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -487,8 +487,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
>  	 * it will be automatically freed by device's release() callback,
>  	 * platform_device_release().
>  	 */
> -	pdata = kzalloc(dfl_feature_platform_data_size(binfo->feature_num),
> -			GFP_KERNEL);
> +	pdata = kzalloc(struct_size(pdata, features, binfo->feature_num), GFP_KERNEL);
>  	if (!pdata)
>  		return -ENOMEM;
>  
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 2f5d3052e36e..044b0e88e5a8 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -299,12 +299,6 @@ struct dfl_feature_ops {
>  #define DFL_FPGA_FEATURE_DEV_FME		"dfl-fme"
>  #define DFL_FPGA_FEATURE_DEV_PORT		"dfl-port"
>  
> -static inline int dfl_feature_platform_data_size(const int num)
> -{
> -	return sizeof(struct dfl_feature_platform_data) +
> -		num * sizeof(struct dfl_feature);
> -}
> -
>  void dfl_fpga_dev_feature_uinit(struct platform_device *pdev);
>  int dfl_fpga_dev_feature_init(struct platform_device *pdev,
>  			      struct dfl_feature_driver *feature_drvs);
> -- 
> 2.27.0
> 
Applied to for-next,

Thanks!
