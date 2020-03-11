Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F29C18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4D521D56
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583918843;
	bh=xkhyaBEpKNgDSG40OjBYDAQobxBh+r6CMR4Riq1GXR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vw07/l8YpXFrjOZso0xpqBsPnMrmyNJHabTMijxGgojBNep7S6agitkB3CRgJM6WY
	 ybF4Fzxr3P/drifI1f+3SjWEqXZYUMZSveQ35yzMB2ws47u4mJi4X+M1Be8s4N51EK
	 CepEWFaN7LXmfKWa8JDEHpWym3SwWcGuCkaPbUMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgCKJ1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 05:27:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33895 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgCKJ1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 05:27:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id z15so1633003wrl.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 02:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6HDgqWtxzx0YdOe7/T+nmkFIQiMnqZT0BKBTXUpjOCU=;
        b=t3o3bihLjTYyXZ20mRbEGlENjOhtmJyxiDOo9WdTmmSHoqmxNw3aC6xA/32HsnoZBi
         zFYEFcS7oI8HNA8Bnhd3P7qAGM6HMbAc8LcceeQU2jHxTagogLuOrnNzsfMT06TSnG3e
         /jDe8pbCy02Xw/Xlroe3rYCbncP1LZer236D7KBAyxcoUqRn7z0ozV86kYiqfwUwKkrH
         K+LAXRqX2U1Z48pgIOafxdWhl0k0MOHRiuuKuOwtYT03hZT2Gp3Hn0QHYkPA/eyq3RAA
         qEYWrYIgv92RBXdCk0IJWCAe0HRt9PacDlJu2k7dkFHR6osWFK+QhuPnFx5ZULdX6YAz
         X8Ag==
X-Gm-Message-State: ANhLgQ3UB1AKot7bmTuoGg8wDzmDayQWIOi+aQfmjglSy+n4ZvhQuoRY
        FFHaNBJLb8DiR7/f/+FT9qI=
X-Google-Smtp-Source: ADFU+vuDpsVvLkTM3Nb0UuQU+CfWyUONSVBwVo++oOV/H5y+feN1kM/a62ZA/aQlB3IMgq9t/5e1Yg==
X-Received: by 2002:adf:e98f:: with SMTP id h15mr3475093wrm.263.1583918839739;
        Wed, 11 Mar 2020 02:27:19 -0700 (PDT)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id a26sm7815970wmm.18.2020.03.11.02.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 02:27:19 -0700 (PDT)
Date:   Wed, 11 Mar 2020 10:27:18 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH v2] x86/mm: Remove the redundant conditional check
Message-ID: <20200311092718.GG23944@dhcp22.suse.cz>
References: <20200311011823.27740-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311011823.27740-1-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-03-20 09:18:23, Baoquan He wrote:
> In commit f70029bbaacb ("mm, memory_hotplug: drop CONFIG_MOVABLE_NODE"),
> the dependency on CONFIG_MOVABLE_NODE was removed for N_MEMORY. Before
> commit f70029bbaacb, CONFIG_HIGHMEM && !CONFIG_MOVABLE_NODE could make
> (N_MEMORY == N_NORMAL_MEMORY) be true. After commit f70029bbaacb, N_MEMORY
> doesn't have any chance to be equal to N_NORMAL_MEMORY. So the conditional
> check in paging_init() doesn't make sense any more. Let's remove it.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
> v1->v2:
>   Update patch log to make the description clearer per Michal's
>   suggestion.
> 
>  arch/x86/mm/init_64.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index abbdecb75fad..0a14711d3a93 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -818,8 +818,7 @@ void __init paging_init(void)
>  	 *	 will not set it back.
>  	 */
>  	node_clear_state(0, N_MEMORY);
> -	if (N_MEMORY != N_NORMAL_MEMORY)
> -		node_clear_state(0, N_NORMAL_MEMORY);
> +	node_clear_state(0, N_NORMAL_MEMORY);
>  
>  	zone_sizes_init();
>  }
> -- 
> 2.17.2

-- 
Michal Hocko
SUSE Labs
