Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C25C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 17:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59CD620739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 17:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R3LMWQII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbgFORlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 13:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729402AbgFORls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 13:41:48 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF848C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 10:41:47 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l17so405164wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 10:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oY7ZuVvlWCgY01/3kLGR+1QSYIg+ZjHtQqquGW90g1U=;
        b=R3LMWQIId1cQohqf0X5bTssX/ck9Tat9HT9OWIJtTHwUY6SJ0BH8CtiQge02sxzDUq
         D/468yONxMF7MsAlOugNzzC2YJRB8zxxor77YujZujBHqBzigCQA3qHyqsBqBv0L4hSO
         heY6DqIyS4VDmZpZ/dfwO4K6juqvUhQdCcCRjn2P8EmeeiRY68CMIc1mplZLpSV32+Up
         qnKCwRpwuXmELRT8UbaTONcw2qLfz5xjasSz/YKLBfBn26ttGQqeH2+xuaeqngeV8Kj5
         7r1s7iTqSl7egrjPqVKAxy73xUc5TkC0MrMLtFUOCRvhujErEotYGvevMF+1/hS5ISAV
         SOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oY7ZuVvlWCgY01/3kLGR+1QSYIg+ZjHtQqquGW90g1U=;
        b=EQwEYtt855stdi6foc0r+bbxDbFCFmYosb6F1AKbSA/+rngnHSq7FsalfENzLD4zqr
         5ePIEVxynOw71hrTuF2ewyaeiZ7Ozdblvv1mqKXOkSBajQQadMSZa8Lu1j/juke8VMkb
         rWCk40AsjpCK9T2D7mvUi44p+nSFVE2nW47LAshuv4iLldH7FRlb91L+fgCN77JIyIak
         G+0KTHS/8hLWBPk8jKqUy8oL+zAG499XfEJSyB7IuWH+eEVh0Eev+bAV3Ewu68luINgq
         zUirUUbWTW4brF2ZWuMvKvRk5WGRNNTOX5AShfMUQnVIgR42lreAcsUoE2xKxWeL7VPW
         OLVA==
X-Gm-Message-State: AOAM533U7R9rwcJuFT5CvdvulwTgL4rfQKDEJViD0sUWkxxMftGq92bU
        gmNCdcpdeXRY+S4FlbIRln61wg==
X-Google-Smtp-Source: ABdhPJxZIkU/7mhMBRsRT52yrMQRtnq6d09FQMcwSh1k29JPx1ndKo/Cpw28q7Mi57mkncpvcG63yA==
X-Received: by 2002:a1c:4857:: with SMTP id v84mr459057wma.96.1592242906131;
        Mon, 15 Jun 2020 10:41:46 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id a16sm25199304wrx.8.2020.06.15.10.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 10:41:45 -0700 (PDT)
Date:   Mon, 15 Jun 2020 18:41:41 +0100
From:   Quentin Perret <qperret@google.com>
To:     rjw@rjwysocki.net, rafael@kernel.org, viresh.kumar@linaro.org
Cc:     arnd@arndb.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, kernel-team@android.com,
        tkjos@google.com, adharmap@codeaurora.org
Subject: Re: [PATCH 2/2] cpufreq: Specify default governor on command line
Message-ID: <20200615174141.GA235811@google.com>
References: <20200615165554.228063-1-qperret@google.com>
 <20200615165554.228063-3-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615165554.228063-3-qperret@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 Jun 2020 at 17:55:54 (+0100), Quentin Perret wrote:
>  static int cpufreq_init_governor(struct cpufreq_policy *policy)
>  {
>  	int ret;
> @@ -2701,6 +2721,8 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
>  
>  	if (driver_data->setpolicy)
>  		driver_data->flags |= CPUFREQ_CONST_LOOPS;
> +	else
> +		cpufreq_get_default_governor();

Looking at this again, it appears that the comment above
cpufreq_parse_governor() confused me a bit -- this needs doing
unconditionally I think.

I'll fix it in v2.

Thanks,
Quentin
