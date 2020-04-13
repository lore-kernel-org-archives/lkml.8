Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054E0C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C357620739
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="LH+nAylm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbgDMPHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbgDMPHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:07:41 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421D0C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 08:07:41 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id n10so9631453iom.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 08:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BmS8uD73nyjTWQk8RFHFcE/DF5t1t9W1XjYRchC4K3k=;
        b=LH+nAylmToi4pOuRewgTRk55HLlz56y+kKJjmphV3hDoR382xP7H33swFtUk+DpAcT
         RMX9+UO/Z4vdy/GKWpXpslq6WFKgtJKuA75yC5Kdlbsad6o6z72oBfKRNpb8qHpPGqJc
         Xr5IczkpslLJbOYOM2gcIn83/Ot4377hHQip7JO4oA60X/1tLuZmt08Bhjtgi/GJbuS1
         kFNmFi7ahNIVuKuyduczWqU/1GQonEP/0aXIavuCtAUs1aerLLmIqO8L3Nyj+OhlYEa3
         N03PbKc/Mvs2stnDjWzjN79+jaWaaWG3cUUyExhUW6vOdIC8zy6XeYmn5+LOO4Mr1iHR
         Dt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BmS8uD73nyjTWQk8RFHFcE/DF5t1t9W1XjYRchC4K3k=;
        b=D4l7L45WRO6SYelXPw5vP5dTQGlMGIfsVV2+WqsARyr2YTOMcNe6UBSAHISu4W2t+0
         wl7M8GOy7bCKkcnBVGYRJ5khNM5f+ebe5v7v2qowJ1YkaiOPjU453WBmyGhzUd//TF/X
         mPkDOvSg148Kfbed4tzujvfti5x2pU10zLboaKIIuOv6fMCdC5IY+sUME2qJPcdPmqMU
         EHPu8oIf9ftb+hsM/CUbGma9GuCQx8vrzOQDGgvRzMD3MJuQbkdxlmNwuhjBguuOa8z7
         LO0WCtYNLbt/oiA85adBMWf89E5BZQyVRWqQIlbcTGDefq2M89RiArdWr+VisObgjWPv
         HU9A==
X-Gm-Message-State: AGi0PuYgH/78wD47wBLkqar/M6k2rcPtYRBwpp0e6Iow56+L8+dvIUqH
        lyEvDXdj/B8ogqaNdfciCOX2MOuGk7tMjipivI2p8g==
X-Google-Smtp-Source: APiQypJQEKWbxwbXMY0isEUBPGbNwg64jGIdkvab+usH+wdQAESs49H0rttP89qwuRC6yUK9Dzn1uYw18fnmAej/OVU=
X-Received: by 2002:a05:6602:2f94:: with SMTP id u20mr1937598iow.21.1586790460587;
 Mon, 13 Apr 2020 08:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200406074750.56533-1-songmuchun@bytedance.com>
In-Reply-To: <20200406074750.56533-1-songmuchun@bytedance.com>
From:   =?UTF-8?B?5a6L54mn5pil?= <songmuchun@bytedance.com>
Date:   Mon, 13 Apr 2020 23:07:03 +0800
Message-ID: <CAMZfGtUY_GLXZ4jV4s0UZqsVF0W57dzUh0wVGynXYCy3CMN4iA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: add __init to sched_init_granularity functions
To:     mingo@kernel.org, peterz@infradead.org, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, rostedt@goodmis.org,
        Benjamin Segall <bsegall@google.com>, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 3:48 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> Function sched_init_granularity() is only called from __init
> functions, so mark it __init as well.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1141c7e77564d..6f05843c76d7d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -191,7 +191,7 @@ static void update_sysctl(void)
>  #undef SET_SYSCTL
>  }
>
> -void sched_init_granularity(void)
> +void __init sched_init_granularity(void)
>  {
>         update_sysctl();
>  }
> --
> 2.11.0
>

Ping guys. Any suggestions?

-- 
Yours,
Muchun
