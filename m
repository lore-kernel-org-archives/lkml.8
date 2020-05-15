Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31843C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1038A2076A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589527335;
	bh=yNsMorB63lhA7MT5roLVlFLZPFPqtP6Y+2hbfxUG/VY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H/cBimUjGq56FmfxvbZP0huGJpUhHGoJFf8btSjHdALQeTYTpbg61E0Oj0GTt8rt4
	 xsR5/pg0iTAZ7zhpdkFGnjAkXkUP94meeuv1gyOuNNVddBSAgKWU8idOsAOV3HagrG
	 nTc5w9ehE/2A0c/JtNtLoZlG4x/L9EqUTgIrVQBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgEOHWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 03:22:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39901 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgEOHWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 03:22:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id l18so2262112wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 00:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wWbNW8kbMyNjSXbBam4c4gSY4otg46mxe59LKoz0OF8=;
        b=VLbXMBbtTSe3t/bDtzSuJTxytWH9OGWqxlQXPhyVcpqOhvtX3/A0JomO5TPgSfujWD
         ZoCvjk4p0Wm+eYR4rb4K8T8HCKlo1zmHA5uPpJmD8+qs6xV0epGALdzVStvRDFBVyMsI
         AnpnZfTtISiwnEyzalKGdHjJpZIX0CVX+yVZ7A5UHVAvEpfXleBzyfVe8qaP+wRCMCWh
         9PhCGuZ/FS/cqHHfYki7BGDbG4j+xVmpIvE01z5i7Mv3ddj8kgPI/gSW+HihawktNBv+
         QRuX20CvDEgHEukfq1xSU1kQj/zy1Z4+LIt2xohp+Ixc736ggNJrLAYvv+uIv75+dxks
         TLaA==
X-Gm-Message-State: AOAM533Zfbm+iCLrQvgoIfUWWFTrYIS4sTKzTbofmvb78GcDW4NjAyRV
        XsDmnmJ6JgIaka9OF6UzBlw=
X-Google-Smtp-Source: ABdhPJwNTmCMUmKiYMOk+Ml322N9pT1hmc/pcQdWgRnBrHGVidmJLilnZQwB3PGJVF+EXOHBLeyM7g==
X-Received: by 2002:a5d:6705:: with SMTP id o5mr2746406wru.426.1589527331467;
        Fri, 15 May 2020 00:22:11 -0700 (PDT)
Received: from localhost (ip-37-188-249-36.eurotel.cz. [37.188.249.36])
        by smtp.gmail.com with ESMTPSA id z18sm2109678wmk.46.2020.05.15.00.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 00:22:10 -0700 (PDT)
Date:   Fri, 15 May 2020 09:22:09 +0200
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
Subject: Re: [PATCH 1/3] proc/meminfo: avoid open coded reading of
 vm_committed_as
Message-ID: <20200515072209.GF29153@dhcp22.suse.cz>
References: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
 <1588922717-63697-2-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588922717-63697-2-git-send-email-feng.tang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08-05-20 15:25:15, Feng Tang wrote:
> Use the existing vm_memory_committed() instead, which is also
> convenient for future change.
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  fs/proc/meminfo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index 8c1f1bb..578c0b8 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -42,7 +42,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>  
>  	si_meminfo(&i);
>  	si_swapinfo(&i);
> -	committed = percpu_counter_read_positive(&vm_committed_as);
> +	committed = vm_memory_committed();
>  
>  	cached = global_node_page_state(NR_FILE_PAGES) -
>  			total_swapcache_pages() - i.bufferram;
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
