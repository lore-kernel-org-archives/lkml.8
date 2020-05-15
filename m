Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC8AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3930C20657
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589527393;
	bh=Ir4lhWto/dDAJUOC1hBIxk4JypxuzE0ECEMZho5Y0M4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yqyxU10iZaG84zFZlfCIqhjkpYeAYzkWiRiXHuAapLPchkrn/4QFUwKgDqR69UUJ7
	 alCs0IdO0Zi6OJk7OwrRJ0Aashw/ZRxFUx1XrsE4lQePp9RPeanps4pRRB3b+cvH+0
	 B+dj859yg8Cv5MvqGk1u/rpyO3gxG77Zy2BZziso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgEOHXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 03:23:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55374 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbgEOHXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 03:23:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id f13so1198473wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 00:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ViqolJpDhhrZA9TAi6a+VUrDe/NCe25ekmSOzaROAko=;
        b=Ha29l6cMafFDVxmwbKjmBNru0A/Vkn1YfiICuVvT6LViZ2axN+SxzhsRvweZ0u30Ra
         L1eSeTzZiBYFJcix/a7cpScaKlVTSBa3DHLtID40S156SxUQ4pzvhbdJnLSMjfdtdmjz
         2za7OTx5VJwFTxNjhrhkegNAAAm82I6suFIu1gz3lAEclHkaO9e5O1CPeB/4AWSDFIIG
         rMVI78UR6cFczVDGKctCPDUQiNq/jvxdnQ2LE5qzZbI6eLYWAM/5mSPlMudi2lu1IWj9
         fAtAbWxNQnWICWRMehImOv6GldnoQB0ZoztjEYQxtCZExk2+6tHv7RbwnhjPjl/nfW+s
         0geg==
X-Gm-Message-State: AOAM532xAFQYNaK3v+cJTco9tQsGj6Q8po3/AAf3NJjI/VMuOwcDaxF3
        kfSJSxQHOeeeqXCddL1shJA=
X-Google-Smtp-Source: ABdhPJxExEn1K+SFUpE/RNI3yudtQWWFVZ+K0DND0NHpc9hBADLmfnfETugmECFCwjEC8m6oOfu2AA==
X-Received: by 2002:a1c:a910:: with SMTP id s16mr2478484wme.70.1589527388737;
        Fri, 15 May 2020 00:23:08 -0700 (PDT)
Received: from localhost (ip-37-188-249-36.eurotel.cz. [37.188.249.36])
        by smtp.gmail.com with ESMTPSA id f5sm2207946wrp.70.2020.05.15.00.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 00:23:08 -0700 (PDT)
Date:   Fri, 15 May 2020 09:23:07 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm/util.c: make vm_memory_committed() more accurate
Message-ID: <20200515072307.GG29153@dhcp22.suse.cz>
References: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
 <1588922717-63697-3-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588922717-63697-3-git-send-email-feng.tang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08-05-20 15:25:16, Feng Tang wrote:
> percpu_counter_sum_positive() will provide more accurate info.

Why do we need that?

> Its time cost is about 800 nanoseconds on a 2C/4T platform and
> 2~3 microseconds on a 2S/36C/72T server in normal case, and in
> worst case where vm_committed_as's spinlock is under severe
> contention, it costs 30~40 microseconds for the 2S/36C/72T sever,
> which should be fine for its two users: /proc/meminfo and HV ballon
> driver's status trace per second.

OK, this explains that the additional overhead is not terrible but there
is no actual information on why the imprecision is a problem.

> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  mm/util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index 988d11e..3de78e9 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -774,7 +774,7 @@ struct percpu_counter vm_committed_as ____cacheline_aligned_in_smp;
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

-- 
Michal Hocko
SUSE Labs
