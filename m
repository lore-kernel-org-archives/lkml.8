Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CE9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47FAF2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590761671;
	bh=RInw0V2i4A66Z3OZFjC8ANETmPcNpIUO7YhcNcTiPbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h7aAe4i4OkM12ly9ngbPLx9m59kNEF2//rMLWx9NdnlgfaUZXcSRE3Nymfp0dULji
	 3dP47RK4XFhMgQUhguyBREDjnF0f5NMbVIlwv3lNlId2XGNsq/cwiYXeOY1sF/5MEi
	 vF0+yHNDVPjmPvTtxx+hEj5fpr9QVBeyb33lk0kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgE2OOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 10:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgE2OO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 10:14:29 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F7EC03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 07:14:28 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e16so2036103qtg.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 07:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EDRKW5f/zaMPNUZQVyaaupy1Rs+0+6RwhhPEbq1U2bY=;
        b=mRRZApYUxUdESBETS1TDDFvZt81Or8xWLZifLm0by3TNLQHFH80wZPP1cG5kTW9vuI
         0sJCHR/4rxuV61knJyUiIlMBCU250JhLXeU2erzzEzPOPvBGzyvcOCxJUp+OI0G2qhWl
         9lRDEjxHtEyMpEUkbPqj25panUVU80JHO2z1suom+K6f4e6qjgCbMOtQg8AcyKNkVNaL
         o7M2SvpSMBqpW3+Dvr3U7yPttUqeFLW7jTeK2XGqVz06HNO7pTK5qWlS/r78PWfDV5l7
         weHUuMDHjZ94X5ZjQobonJkhexcs69Hfw2OMG49ISa7dkO6/URlT/xIz3F8Mv/I8N8bP
         kBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=EDRKW5f/zaMPNUZQVyaaupy1Rs+0+6RwhhPEbq1U2bY=;
        b=WHNXClpNldgdFqS/cLIdJolEVtS8bq3QpPF8sXnnyIRNeGYrU3Qag0aDJ5ldIE36Q6
         8Z+pjwAP2xJjub4Xgv8VL1OPy77Rox8Pe/hRzBx4WQ8wDPmpM8TGDta6FG6PZRHej+6k
         l/vWHxUVJN3GruvoS9LW2ZnClgkMIMxYoR9x0OOe30d8ca2a7ShK/zasAnTaH6WmjAVY
         p0qEipIPFK36TCFINu0I8oAaAllS5+4aHquxxZFWgfqw65AFYQlkDEa4o20mPsQ3Wmmr
         jJNI3pQFFzZiqQ21t3PaJ+818sfqggT7tLvc1b9TKYx/eiRpz7wFjIXScQDPnhmjVQSy
         ShjQ==
X-Gm-Message-State: AOAM533zWnUngwkYgnrbAbsmnFafVLoaPZwD2/WbQ+C30PxfD/xF27cD
        Lb1pVpBshDq1vs7xSVG9pBY=
X-Google-Smtp-Source: ABdhPJxWUZCKsaYaT16MI612givLAhkxLVpA70YMZ9MO1Ds5VYtj2DwuQsCK/XL37xEjeGVo34w9qQ==
X-Received: by 2002:ac8:4d8e:: with SMTP id a14mr8994117qtw.343.1590761667614;
        Fri, 29 May 2020 07:14:27 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:5493])
        by smtp.gmail.com with ESMTPSA id w10sm8589960qtc.15.2020.05.29.07.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 07:14:27 -0700 (PDT)
Date:   Fri, 29 May 2020 10:14:25 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH 2/4] workqueue: don't check wq->rescuer in rescuer
Message-ID: <20200529141425.GB3530656@mtj.duckdns.org>
References: <20200529065903.1758-1-laijs@linux.alibaba.com>
 <20200529065903.1758-3-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529065903.1758-3-laijs@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 06:59:00AM +0000, Lai Jiangshan wrote:
> Now rescuer checks pwq->nr_active before requeues the pwq,
> it is a more robust check and the rescuer must be still valid.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  kernel/workqueue.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index b2b15f1f0c8d..8d017727bfbc 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -248,7 +248,7 @@ struct workqueue_struct {
>  	struct list_head	flusher_overflow; /* WQ: flush overflow list */
>  
>  	struct list_head	maydays;	/* MD: pwqs requesting rescue */
> -	struct worker		*rescuer;	/* MD: rescue worker */
> +	struct worker		*rescuer;	/* I: rescue worker */
>  
>  	int			nr_drainers;	/* WQ: drain in progress */
>  	int			saved_max_active; /* WQ: saved pwq max_active */
> @@ -2532,12 +2532,13 @@ static int rescuer_thread(void *__rescuer)
>  			if (pwq->nr_active && need_to_create_worker(pool)) {
>  				spin_lock(&wq_mayday_lock);
>  				/*
> -				 * Queue iff we aren't racing destruction
> -				 * and somebody else hasn't queued it already.
> +				 * Queue iff somebody else hasn't queued it
> +				 * already.
>  				 */
> -				if (wq->rescuer && list_empty(&pwq->mayday_node)) {
> +				if (list_empty(&pwq->mayday_node)) {
>  					get_pwq(pwq);
> -					list_add_tail(&pwq->mayday_node, &wq->maydays);
> +					list_add_tail(&pwq->mayday_node,
> +						      &wq->maydays);

send_mayday() also checks for wq->rescuer, so when sanity check fails,
scenarios which would have leaked a workqueue after destroying its rescuer
can lead to use-after-free after the patch. I'm not quite sure why the patch
is an improvement.

Thanks.

-- 
tejun
