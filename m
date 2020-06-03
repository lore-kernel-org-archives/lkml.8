Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86151C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 13:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6243420674
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 13:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591191335;
	bh=xIJ78WqCPDXXk0402bFHxK/2TnjqYqbfayPj2IN8XTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jvPg32+vlsBtxigzZqJ+n1/aTXImNgVG3t8dANRneXxfJ9xd4/pYdmFYrj2wwmyPV
	 I6h4SYLA4B9U/uUCL75a863EpNbSXr98j0LuyJ9J4M/ujGC9Mqtj00n2bfUdbOkpkI
	 YNKdNvWS3eoSmNUUwlbRjncPpmz0ohWtUfUP4H+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgFCNfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 09:35:34 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:34557 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgFCNfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 09:35:34 -0400
Received: by mail-ej1-f65.google.com with SMTP id l27so2213538ejc.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 06:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HMfuPrTv7nZgMPcnR6scpe04ZPIW4XYf31Wlqr4SBCU=;
        b=bHliBKqW7Y6sT0/azf2UROQGwllxYWKNEoXDhMx1Q0MJ5tPEaJfu2sH+BPBSwYldxy
         A3HOLc1VEGCtQ6MPVJ1pNZ7uOj1QsTxEcwW0QwczMJ34C5z1aUnXZ0Uz+4wo+JFr9mgz
         rIr3AVPRXuJN15/53KHFpWon1D+ws89bFQviuWX+4eHk5WH2XCg7onmq0KC1sybo1H6d
         VMMp3b4m1gdjFckUUvkU6A7GT+IsPW4cFHVR3zm8PSc3IcK2VJWwC/JBlWyJzopYPg3h
         JToqQtzI9o0ZxL4CrPfKLCiJT72ui7wKf45WpXo+nl9Ai+fKYvI2jlkho90TI8f8m0LH
         6ysQ==
X-Gm-Message-State: AOAM53293DEMNDvYlAfjAiD6YRQMUXcW4W420IAnLYTkVyINON93XSvi
        8NS7wmzAF3Aam9Nzni9X5Uc=
X-Google-Smtp-Source: ABdhPJx/tNh+j12opk4X5dPeEPB24shY1lt2sstGdKjo8olNYMWFwR8nSVgzyf7La+mvmB2x+POkGw==
X-Received: by 2002:a17:906:fb9b:: with SMTP id lr27mr2335640ejb.405.1591191330752;
        Wed, 03 Jun 2020 06:35:30 -0700 (PDT)
Received: from localhost (ip-37-188-178-109.eurotel.cz. [37.188.178.109])
        by smtp.gmail.com with ESMTPSA id z3sm1135456ejl.38.2020.06.03.06.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 06:35:29 -0700 (PDT)
Date:   Wed, 3 Jun 2020 15:35:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>, Qian Cai <cai@lca.pw>,
        andi.kleen@intel.com, tim.c.chen@intel.com, dave.hansen@intel.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Subject: Re: [PATCH v4 2/4] mm/util.c: make vm_memory_committed() more
 accurate
Message-ID: <20200603133528.GJ7533@dhcp22.suse.cz>
References: <1590714370-67182-1-git-send-email-feng.tang@intel.com>
 <1590714370-67182-3-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590714370-67182-3-git-send-email-feng.tang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 29-05-20 09:06:08, Feng Tang wrote:
> percpu_counter_sum_positive() will provide more accurate info.
> 
> As with percpu_counter_read_positive(), in worst case the deviation
> could be 'batch * nr_cpus', which is totalram_pages/256 for now,
> and will be more when the batch gets enlarged.
> 
> Its time cost is about 800 nanoseconds on a 2C/4T platform and
> 2~3 microseconds on a 2S/36C/72T server in normal case, and in
> worst case where vm_committed_as's spinlock is under severe
> contention, it costs 30~40 microseconds for the 2S/36C/72T sever,
> which should be fine for its only two users: /proc/meminfo and
> HyperV balloon driver's status trace per second.
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>

I cannot speak for HyperV part. Cc maintainers but this shouldn't be a
problem for meminfo.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index 9b3be03..3c7a08c 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -790,7 +790,7 @@ struct percpu_counter vm_committed_as ____cacheline_aligned_in_smp;
>   */
>  unsigned long vm_memory_committed(void)
>  {
> -	return percpu_counter_read_positive(&vm_committed_as);
> +	return percpu_counter_sum_positive(&vm_committed_as);
>  }
>  EXPORT_SYMBOL_GPL(vm_memory_committed);
>  
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
