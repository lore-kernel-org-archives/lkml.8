Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DC1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4616A20722
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoX2opiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbgGFQRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 12:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbgGFQRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 12:17:13 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EEFC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 09:17:13 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id g2so22933675lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 09:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cABH94MOiXKXL8yndza/T2t3RrdaGl2zE7lGDIUzINk=;
        b=XoX2opiqdygN1vAvWssde0XpffK6rJt5JrYJ/HT8UsI0BBIkJ/6tlc2N31e/aKXGKl
         b6/VSFm+G5gXny0oFTjCkOjt9kltUyky4pntmw+g9Px4JW1J+lMccrZbN5OFNKhnAxQY
         4A3M/+eY0gf9oRgSQBfTmUvQWedzhRVb5iQpYsoBK2p7Y2G73oWXAW5LcwAckACRrnqO
         H0Cy7RNBPFhQ0BzS2VD5LIjlOfRAdPWtU7XqFOjO4edKI+UyWVCIEtPxmkIp0XaQSAKu
         bkHN1rN9SQ1MtsMLXdy6kwwA/Y0uBZcNMetiBsVuuMp7k3ELo+WLoD2oqb+KS2/XFFqm
         1oBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cABH94MOiXKXL8yndza/T2t3RrdaGl2zE7lGDIUzINk=;
        b=NBnoqPqrFfNNQFsiv49OgfTfN68rOAgVc23FtFoWQrHsnGnmSu5NAAlnoZ06mPq98t
         vOcRpmRfSJG4XSLZfaOtijJoEFJL5LI58yvhk83C23BJCRLJcfG2e8xYr6fj8cUjmqHA
         eS+TouIOvejUW0CvrwRsof/7trXYPzo614kMwRDZg21ogOmxmLXtmivDnpbuVfBby3MJ
         HaQW/9Rl8HywXI7EzB00RAe+CYgGC4/5j6MTDj7a7XgzXhnbjT9ECZtWsoikQDeatu13
         EBWryqEJeILdc8KZ3NpfPO6SGMEaAU0l1qM0ujgL1Qh8yIAGB+cTxG8NXy+oyXgpDVJt
         YRiQ==
X-Gm-Message-State: AOAM531mVPihpT0zEaxvhYORSRIufjhS2NS/A74Wr8rCFasYt6fOUkJx
        xmPDHkgoFSbn8DilA1XUFH4ZnKY7GryabQ==
X-Google-Smtp-Source: ABdhPJx8N1eTfVqPegV35ULkhQu6i8hHvX5pJQlkm5nWLu5hOwbzF5nfIHd9GRJ+VoW+qF2BwPvIJA==
X-Received: by 2002:a19:701:: with SMTP id 1mr30150295lfh.138.1594052231604;
        Mon, 06 Jul 2020 09:17:11 -0700 (PDT)
Received: from [192.168.1.108] ([5.20.204.163])
        by smtp.gmail.com with ESMTPSA id e16sm7942488ljn.12.2020.07.06.09.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 09:17:10 -0700 (PDT)
Subject: Re: [PATCH] drm/lima: Expose job_hang_limit module parameter
To:     Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     andrey@lebedev.lt
References: <CAKGbVbtYusvURFcUyQtgUycNJPAQyDGDaLXW8qw-x49DqfKmQA@mail.gmail.com>
 <20200619075900.3030696-1-andrey.lebedev@gmail.com>
From:   Andrey Lebedev <andrey.lebedev@gmail.com>
Message-ID: <bd4370f5-6fb4-d32f-5ca4-02e56526f47d@gmail.com>
Date:   Mon, 6 Jul 2020 19:17:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200619075900.3030696-1-andrey.lebedev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello guys,

What is the status of this patch? Was this committed to any branch? Is 
it pending for merge to the mainline? Do I have to do anything in order 
to make it mergeable?

On 6/19/20 10:58 AM, Andrey Lebedev wrote:
> From: Andrey Lebedev <andrey@lebedev.lt>
> 
> Some pp or gp jobs can be successfully repeated even after they time outs.
> Introduce lima module parameter to specify number of times a job can hang
> before being dropped.
> 
> Signed-off-by: Andrey Lebedev <andrey@lebedev.lt>
> ---
> 
> Now all types are correct (uint).
> 
>   drivers/gpu/drm/lima/lima_drv.c   | 4 ++++
>   drivers/gpu/drm/lima/lima_drv.h   | 1 +
>   drivers/gpu/drm/lima/lima_sched.c | 5 +++--
>   3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_drv.c
> index a831565af813..ab460121fd52 100644
> --- a/drivers/gpu/drm/lima/lima_drv.c
> +++ b/drivers/gpu/drm/lima/lima_drv.c
> @@ -19,6 +19,7 @@
>   int lima_sched_timeout_ms;
>   uint lima_heap_init_nr_pages = 8;
>   uint lima_max_error_tasks;
> +uint lima_job_hang_limit;
>   
>   MODULE_PARM_DESC(sched_timeout_ms, "task run timeout in ms");
>   module_param_named(sched_timeout_ms, lima_sched_timeout_ms, int, 0444);
> @@ -29,6 +30,9 @@ module_param_named(heap_init_nr_pages, lima_heap_init_nr_pages, uint, 0444);
>   MODULE_PARM_DESC(max_error_tasks, "max number of error tasks to save");
>   module_param_named(max_error_tasks, lima_max_error_tasks, uint, 0644);
>   
> +MODULE_PARM_DESC(job_hang_limit, "number of times to allow a job to hang before dropping it (default 0)");
> +module_param_named(job_hang_limit, lima_job_hang_limit, uint, 0444);
> +
>   static int lima_ioctl_get_param(struct drm_device *dev, void *data, struct drm_file *file)
>   {
>   	struct drm_lima_get_param *args = data;
> diff --git a/drivers/gpu/drm/lima/lima_drv.h b/drivers/gpu/drm/lima/lima_drv.h
> index fdbd4077c768..c738d288547b 100644
> --- a/drivers/gpu/drm/lima/lima_drv.h
> +++ b/drivers/gpu/drm/lima/lima_drv.h
> @@ -11,6 +11,7 @@
>   extern int lima_sched_timeout_ms;
>   extern uint lima_heap_init_nr_pages;
>   extern uint lima_max_error_tasks;
> +extern uint lima_job_hang_limit;
>   
>   struct lima_vm;
>   struct lima_bo;
> diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
> index e6cefda00279..1602985dfa04 100644
> --- a/drivers/gpu/drm/lima/lima_sched.c
> +++ b/drivers/gpu/drm/lima/lima_sched.c
> @@ -503,8 +503,9 @@ int lima_sched_pipe_init(struct lima_sched_pipe *pipe, const char *name)
>   
>   	INIT_WORK(&pipe->recover_work, lima_sched_recover_work);
>   
> -	return drm_sched_init(&pipe->base, &lima_sched_ops, 1, 0,
> -			      msecs_to_jiffies(timeout), name);
> +	return drm_sched_init(&pipe->base, &lima_sched_ops, 1,
> +			      lima_job_hang_limit, msecs_to_jiffies(timeout),
> +			      name);
>   }
>   
>   void lima_sched_pipe_fini(struct lima_sched_pipe *pipe)
> 

-- 
Andrey Lebedev aka -.- . -.. -.. . .-.
Software engineer
Homepage: http://lebedev.lt/
