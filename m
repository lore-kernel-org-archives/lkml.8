Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E512C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 12:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77B72176D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 12:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579176768;
	bh=Rno+FCx/m1FJiLhugMJfP4rvryOioCbSFWb8zHnO6x4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rNfnSEZ4ZxUkB9CVpzzpm0XJCY8A7BTEZJVdDjHWF8GfAk7/1s6X9Hk/1dMSmYzjc
	 9Qr7Zc7NMtHtcDji5jGjHepXm5WvLAROHRs+DOhxE5rsJYpHq6IhjU8qTJB0e8GL9r
	 6kbEo2LUFsw/R3+l8hZC27Bkc2c4PG3FyCkbp6hE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgAPMMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 07:12:47 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38609 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgAPMMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 07:12:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so18927016wrh.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 04:12:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0rLdvAF+Tn/NR14A4y+3n0cCH4WC63jUVnW1yxIhRT8=;
        b=GuzXOeJBB+oSflWOUi7S7CVezJM+nnrJYCdTr9TPQQDbmg6cLzw9Ded3zi9Htt8c4h
         zIqyKtaPiX1jxsGoEY1dg7WgsGJ+Xli6Y4M/n+s3zGGAs8vf8W9e+ZbR/e6gm6p36A4H
         YheX0E+tBuiReKLU+OLWHazMWbsCq2JgRwXy6lZlLIskoJuOkeKzqoIJ8omrWrDjzlBH
         y5fPfulS2ftVOhfnTZLJD6i71w733SFV6fsQWBYxpKlvzrXxS4DKtLFVprY0hAb87gb0
         pd5eB4VpG9ci9GlaCpHfSGgVAEGcv/5n5ZCV6aL2OP8i6vddr1PRIriNWTB1B6zkdM4N
         lXlQ==
X-Gm-Message-State: APjAAAUfPuRw+OFlsCzie7fyMzI8YJt1eyRbTlSIxJzWd8tDTvmoA7EZ
        ahYU/tg+vexH7E1kE6L4coo=
X-Google-Smtp-Source: APXvYqwscoC+uS5MwbMLg1PKaUrbBbc0a7r+kz7kgZD6Vfh2GDIcn7wbZyal11zA/CtZLTnG+p/whw==
X-Received: by 2002:adf:a308:: with SMTP id c8mr2970195wrb.240.1579176764684;
        Thu, 16 Jan 2020 04:12:44 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id d14sm30434151wru.9.2020.01.16.04.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 04:12:43 -0800 (PST)
Date:   Thu, 16 Jan 2020 13:12:40 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     buddy.zhang@aliyun.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/cma.c: find a named CMA area by name
Message-ID: <20200116121240.GS19428@dhcp22.suse.cz>
References: <20200116101322.17795-1-buddy.zhang@aliyun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116101322.17795-1-buddy.zhang@aliyun.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16-01-20 18:13:22, buddy.zhang@aliyun.com wrote:
> From: BuddyZhang <buddy.zhang@aliyun.com>
> 
> This function could help developer who want to find a special
> named CMA area.
> 
> The CMA supports multiple named CMA areas, and the device could
> use or exclusive a special CAM arae via "cma_area" on "struct
> device". When probing, the device can setup special CMA area which
> find by "cma_find_by_name()".
> 
> If device can't find named CMA area, "cma_find_by_name()" will
> return NULL, and device will used default CMA area.

Please do not add new exported symbols without actual users.

> Signed-off-by: BuddyZhang <buddy.zhang@aliyun.com>
> ---
>  mm/cma.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index be55d1988c67..6581dabcaf34 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -40,6 +40,18 @@ struct cma cma_areas[MAX_CMA_AREAS];
>  unsigned cma_area_count;
>  static DEFINE_MUTEX(cma_mutex);
>  
> +struct cma *cma_find_by_name(const char *name)
> +{
> +	int idx;
> +
> +	for (idx = 0; idx < MAX_CMA_AREAS; idx++) {
> +		if (cma_areas[idx].name && !strcmp(name, cma_areas[idx].name))
> +			return &cma_areas[idx];
> +	}
> +	return NULL;
> +}
> +EXPORT_SYMBOL(cma_find_by_name);
> +
>  phys_addr_t cma_get_base(const struct cma *cma)
>  {
>  	return PFN_PHYS(cma->base_pfn);
> 
> base-commit: 5b483a1a0ea1ab19a5734051c9692c2cfabe1327
> -- 
> 2.17.1
> 

-- 
Michal Hocko
SUSE Labs
