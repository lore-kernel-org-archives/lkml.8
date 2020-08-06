Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3939C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5277820786
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596733602;
	bh=kjjEQrmzRcW6mj2dWdQ0NVjMbC/KC39dQPmW2tifhjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0RSx8c+voVW6LgWmfR/eASNLOfeOFfLkDSFLnvkILyMawXu/xdKN4xq9ak7RkP76v
	 +IvYBeLKv3NyPUabYoof4Dnr/BltOhCAM+6ft5DNuWlJ95e+/Y3oRmQUIdMR99j+Zq
	 UDkGEb7bn71ZaFie5dQkITI78kJgURLlXwaPLicA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgHFRGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730000AbgHFRFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:05:40 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1279CC0A54DA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 07:07:56 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a26so24675523ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 07:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AQEugxAcEBQ6a4sgcA20W1Quw9HbEc41R2dof7DTeNU=;
        b=fCyC2qUuNOqTdzjAFTbFyIzpk34L4hh66NZP0hzKJf0dXILT3/k2Tz2WLL+Fp50MpH
         sLYlBxs9kVVk3nXPCkZj02Zsnn81Q+RtPAbiAsDdQ+cxGU/p5XnpgWvSpsf7ouH6+Ihw
         LLUQMSlRUosZIu6C1ErB3JgncVnBlnc9otqvPjaYYqui4Fs4JPknCR64JTWVgs5V5QSt
         YJS+7UPbSabyZjgEYsHJ9nNDHiSI7xJfjADN5nAGnD0Wdli5O12vX0PrMLgUQlASKcuz
         3EXVUFeSWa93M++O6CrqmL+ZcPUAOUd1ybAir5CC5Ms/tAPwH4r0Yt/tsXYvFdm4zKVc
         wUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=AQEugxAcEBQ6a4sgcA20W1Quw9HbEc41R2dof7DTeNU=;
        b=iXPwxpiFzad6XmY03QOM8/+/KFBW/Z3Up1MWIuetOER2nHaveaPQK0qhSJKyOtToT+
         q+uNHoMpCwTtTK+zYscUvrBhTb8P1lk7WgiHRpAb5fslNf6FWwXj2lW/RpomUW+iAjCO
         40pF4VABwIZdx+ntlwwjDznhluF9IDVUvPqBQurKGsktcEsEL8iOQEy0fUtnMghGPwfx
         S7Aa/xF+jvqKDut6FURS9NXUhht8m/bcDC+9qpDg7Ueqve5nYfSV8zWNLxElCgrjEqv7
         7XqWtpkNZsDIm9xYbaZlhL+R14ivsw7i6oWX9p0Ik8cxqSXwLgNI2hug3B3wDEirjbq3
         ZMeg==
X-Gm-Message-State: AOAM532LWmRjURSpjhsavunJ8uasv5EfLCM4tiLihyZperGPqpR5BISS
        Iur9kjkRE7DEceDoQGbAJVs=
X-Google-Smtp-Source: ABdhPJyETMaep/2LOaTjdL/VLSQhcd5lLv830gLluG4vfw6POwpqBNqOQhHPLutRnm5NyFhntswIdA==
X-Received: by 2002:a17:906:e24f:: with SMTP id gq15mr4554926ejb.46.1596722873192;
        Thu, 06 Aug 2020 07:07:53 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id g9sm3625374edk.97.2020.08.06.07.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 07:07:52 -0700 (PDT)
Date:   Thu, 6 Aug 2020 16:07:50 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v4 05/10] sched/topology: Define and assign sched_domain
 flag metadata
Message-ID: <20200806140750.GC2077896@gmail.com>
References: <20200731115502.12954-1-valentin.schneider@arm.com>
 <20200731115502.12954-6-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731115502.12954-6-valentin.schneider@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Valentin Schneider <valentin.schneider@arm.com> wrote:

> +#ifndef SD_FLAG
> +#define SD_FLAG(x, y, z)
> +#endif

AFAICS there's not a single use of sd_flags.h that doesn't come with 
its own SD_FLAG definition, so I suppose this should be:

#ifndef SD_FLAG
# error "Should not happen."
#endif

?

Also, some nits:

> +/*
> + * Expected flag uses
> + *
> + * SHARED_CHILD: These flags are meant to be set from the base domain upwards.
> + * If a domain has this flag set, all of its children should have it set. This
> + * is usually because the flag describes some shared resource (all CPUs in that
> + * domain share the same foobar), or because they are tied to a scheduling
> + * behaviour that we want to disable at some point in the hierarchy for
> + * scalability reasons.

s/foobar/resource

?

> +/*
> + * cross-node balancing
> + *
> + * SHARED_PARENT: Set for all NUMA levels above NODE.
> + */
> +SD_FLAG(SD_NUMA,                12, SDF_SHARED_PARENT)

s/cross-node/Cross-node

BTW., is there any particular reason why these need to be defines with 
a manual enumeration of flag values - couldn't we generate 
auto-enumerated C enums instead or so?

> +#ifdef CONFIG_SCHED_DEBUG
> +#define SD_FLAG(_name, idx, mflags) [idx] = {.meta_flags = mflags, .name = #_name},

s/{./{ .
s/e}/e }

Thanks,

	Ingo
