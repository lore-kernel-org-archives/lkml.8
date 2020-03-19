Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6AAC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334A72072D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584638021;
	bh=BbmwAERRRS1bmDmbsbyiruAsO6izlpHX+Ls+BqtqZyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dzpvvSo+W1lIj/mXq5HnjObUx1noT/R1rk3BpjY8cl3E79oAE9Jlht7DENKh9Zmam
	 Vh6amk2LiNkpP624m7Zw9Hp6f1K9w/bkbvS+FWrjy+jyyI0MVGwcrode6LYOBjgeml
	 ZDxXdmPL11T/c8EkTFY9BhQFsu5y3aMGairDo/Iw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgCSRNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:13:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53965 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbgCSRNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:13:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id 25so3424777wmk.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 10:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mjce+PtajvBrnNU6PU3NbzED18KwcHrcpD9gbDuRtfI=;
        b=OVixnNatsngFUyIQUpgSYS3nBBwK3mU0sBbivnosTpMa9UfZQB3ydr1Ulcq4uG6dP3
         KS8QlsoNiqqprZfbYxaiTk9rTkHSWnqs6gLi8foASzUgHr7t7nnr2T1oi/9ZKSnggvNi
         T/YAYj6VhJ+V8Xyz58NaWEtlZl0qzDnDn+8RzJHANcnNrLHb57GoqaIspf/L0hRssmGd
         NOck2CH92Q0ryidHng8XfdnVJpTKh9hGGnCq/dvS+qaTJRd4L4SauAn2RF3JoIk+SA1p
         YrEVVSlfCjVzq8p1ZlPCUmlChPbsAUaKRnXaCY+e7EcYJ5JPPLKosMAufdIAo0n9P491
         FFQg==
X-Gm-Message-State: ANhLgQ253zoXEVeSvtShpfmFpGEqodzKgpuNYT4c8+RluE1zqbkgomsQ
        Bm58gdhqm9KxoRIhHhvO2vM=
X-Google-Smtp-Source: ADFU+vt9yj55QpEIdAl5B4oDZ7rybmPOo/HI7euCOLhJ6V8N5Ra/j0xMqNNJkJEPaz27A4ujJPEm6w==
X-Received: by 2002:a1c:147:: with SMTP id 68mr4966843wmb.28.1584638016173;
        Thu, 19 Mar 2020 10:13:36 -0700 (PDT)
Received: from localhost (ip-37-188-140-107.eurotel.cz. [37.188.140.107])
        by smtp.gmail.com with ESMTPSA id g3sm4544841wro.93.2020.03.19.10.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 10:13:35 -0700 (PDT)
Date:   Thu, 19 Mar 2020 18:13:34 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     mateusznosek0@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm/vmscan.c: Clean code by removing unnecessary
 assignment
Message-ID: <20200319171334.GK20800@dhcp22.suse.cz>
References: <20200319165938.23354-1-mateusznosek0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319165938.23354-1-mateusznosek0@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is usually preferable to Cc author of the code (added Johannes)

On Thu 19-03-20 17:59:38, mateusznosek0@gmail.com wrote:
> From: Mateusz Nosek <mateusznosek0@gmail.com>
> 
> Previously 0 was assigned to 'sc->skipped_deactivate'. It could happen only
> if 'sc->skipped_deactivate' was 0 so the assignment is unnecessary and can
> be removed.

The above wording was a bit hard to understdand for me. I would go with
"
sc->memcg_low_skipped resets skipped_deactivate to 0 but this is not
needed as this code path is never reachable with skipped_deactivate != 0
due to previous sc->skipped_deactivate branch.
"

> Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>

The patch is correct. I am not sure it results in a better code though.
I will defer to Johannes here. I suspect he simply wanted to express
that skipped_deactivate should be always reset when retrying the direct
reclaim. After this patch this could be lost in future changes so the
code would be more subtle. But I am only guessing here.

> ---
>  mm/vmscan.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index dca623db51c8..453ff2abcb58 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3093,7 +3093,6 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
>  	if (sc->memcg_low_skipped) {
>  		sc->priority = initial_priority;
>  		sc->force_deactivate = 0;
> -		sc->skipped_deactivate = 0;
>  		sc->memcg_low_reclaim = 1;
>  		sc->memcg_low_skipped = 0;
>  		goto retry;
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
