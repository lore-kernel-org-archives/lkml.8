Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF64C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A5792073E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592925516;
	bh=mnwNnQI+cOX0/U6ehCl/R5q2MW2Ri9PFBeSlH2aRRSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=De5rdume2VFxzLwbvtR55qshcVXrDl0tKyNB5nHdgFuq87clU5kf3kwHmPNfFJjft
	 iCRTKsIs6KRgcg+C5f6+ZoIG+KrNXblm5E9CnEkxiV8tyq1u2TtRvjnFfaO4FLUdMA
	 hMVv5NLdgGWRhsOqHXrzLv1YukK0ZilsU0n9nSr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732975AbgFWPSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:18:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41265 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732878AbgFWPSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 11:18:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15so991649wrq.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 08:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MvVMGC38xXiscRPFSdMMDf6uiRQWRRdbs+WbHzNkqzw=;
        b=mvcbLclUJfFUeAvRzmTBFgM82c2Jy48h4Oc5pf7l0ZgHdDVQCaEqvu4gzjkFXTH/fO
         nYbVfeYebeSVOL47ZYZ0/r5EwndbADztyXCKvGtFbH3ldWXiFr8klo7/pa0PUn1YY3ws
         UmcbwqcaQFDBY0wEU7/N/y6HlSUkiLuNKZGf5pxQXagANxRLvInVDn92cyLkyjQr/SpP
         YvYQMF3EyuDOpKqRtGO2DKkbs0UA1d6lrtH1r4xUXAONMUQkYO/5TuHxa1QX/ymd2EXO
         MsI6OLl6k+0ebKxyLFfBRsR6otDGTbzL4BhSVupQudkEjt5jxrqadfd5nsVK7tN8sV06
         JO3w==
X-Gm-Message-State: AOAM530kl7oTWXSai1sUieU/hJmQfWt396/AHYHlsTqnrQv5tVADy6sa
        U/3DkCcvUA1kjDFX4HPdwbG4FYN8
X-Google-Smtp-Source: ABdhPJxwKDtGOosIK0mMYQ2x8HB4inuejFylH9hLUI2PE8006277yYs71YGTWvOAtJOfh+J39dpRBw==
X-Received: by 2002:adf:fd41:: with SMTP id h1mr26516448wrs.374.1592925511338;
        Tue, 23 Jun 2020 08:18:31 -0700 (PDT)
Received: from localhost (ip-37-188-173-135.eurotel.cz. [37.188.173.135])
        by smtp.gmail.com with ESMTPSA id g3sm25628896wrb.46.2020.06.23.08.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 08:18:30 -0700 (PDT)
Date:   Tue, 23 Jun 2020 17:18:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, osalvador@suse.de,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, david@redhat.com
Subject: Re: [PATCH] mm/spase: never partially remove memmap for early section
Message-ID: <20200623151828.GA31426@dhcp22.suse.cz>
References: <20200623094258.6705-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623094258.6705-1-richard.weiyang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23-06-20 17:42:58, Wei Yang wrote:
> For early sections, we assumes its memmap will never be partially
> removed. But current behavior breaks this.
> 
> Let's correct it.
> 
> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>

Can a user trigger this or is this a theoretical bug?

> ---
>  mm/sparse.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index b2b9a3e34696..1a0069f492f5 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -825,10 +825,10 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>  		ms->section_mem_map &= ~SECTION_HAS_MEM_MAP;
>  	}
>  
> -	if (section_is_early && memmap)
> -		free_map_bootmem(memmap);
> -	else
> +	if (!section_is_early)

This begs a comment.

>  		depopulate_section_memmap(pfn, nr_pages, altmap);
> +	else if (memmap)
> +		free_map_bootmem(memmap);
>  
>  	if (empty)
>  		ms->section_mem_map = (unsigned long)NULL;
> -- 
> 2.20.1 (Apple Git-117)
> 

-- 
Michal Hocko
SUSE Labs
