Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3312C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 15:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C452071A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 15:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRlwotb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgAYPcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 10:32:15 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33013 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgAYPcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 10:32:15 -0500
Received: by mail-lj1-f195.google.com with SMTP id y6so5958058lji.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 07:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8KP2c213igfgkw0KmFxPUN0yTObRVyryH62ZDiOL/10=;
        b=fRlwotb4IXszTUfIKDL+N3NEH84rENpRkT7qKhO1exf1puDJtmHR+rwY/GFtbP8SYz
         IruoJVuzZBIeUkOoLOnItlQCynFVwr2b2Z/mE73H5/PpX71cKaGYCa5SAug2aoAjGTSr
         MZaPGFFShGSh2FPMIGmMw5knyr6WjTGSIEQumsEgW2jzE5m8jLwiZd5mSgP68lqBq/fV
         PdgKxXtEnQe/Y3DD8a0YFL4/MolACZAJDUFrXuMlqm6N/Ys3XBqsEw6GXQO+iIzmOZfp
         snlDQ9RR4cyQnmDeGySZZUbR99Z17wjO9k0fFgAzVOe2eyvYcUe4NDyRWlTqjJXB34Be
         bOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8KP2c213igfgkw0KmFxPUN0yTObRVyryH62ZDiOL/10=;
        b=ftObZ/alQXg61sYDJ8Y4BarOLSu2w4cDUl2EnURw/GKiUxFhweX8tiLJfNe1/YIzbn
         2PmpvaDyOFDt5jTZuzxWjzy4sIxUktZFkwAj2Vsr9mcaDhCH4KI+t0o0kyV5HMotmzi0
         KDcRWsVeXJTr24EtqDwzELklKQD+wlnzZgdJYIxxWi7UYPNVLBmitP88I01ExFYBo5P1
         DUQr8hmeoOA5dY+eyHnN0gG/Qugt+tCGHA+CyvO8fDf1OXTPIqJ313QBT0S7/Wz/+oN7
         r3kStZMkW00KxaeZqeDLU0l/Y54yDef2yDLcp0obfmHqLl36MEzgOioiqOR+7Vb9KRY5
         Ernw==
X-Gm-Message-State: APjAAAWytepRSw51GniJDSVNFOsuORlZHT5Rti/wRrQ/6GHMyllcU/jU
        6IrtqVu1PsNbdTjlAgvsZtA=
X-Google-Smtp-Source: APXvYqygE7mOxhwOZXo/2srGxDXTK0GubCxlL48L7tu22Fz2W8aGf9GNd3hzj+nuZh2+cEzkKoq9UQ==
X-Received: by 2002:a2e:870b:: with SMTP id m11mr5366102lji.93.1579966333414;
        Sat, 25 Jan 2020 07:32:13 -0800 (PST)
Received: from uranus.localdomain ([5.18.171.94])
        by smtp.gmail.com with ESMTPSA id w6sm4825027lfq.95.2020.01.25.07.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2020 07:32:12 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id ABF12461625; Sat, 25 Jan 2020 18:32:11 +0300 (MSK)
Date:   Sat, 25 Jan 2020 18:32:11 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH] sched/rt: optimize checking group rt scheduler
 constraints
Message-ID: <20200125153211.GP2437@uranus>
References: <157996383820.4651.11292439232549211693.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157996383820.4651.11292439232549211693.stgit@buzz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 05:50:38PM +0300, Konstantin Khlebnikov wrote:
...
> -/* Must be called with tasklist_lock held */
>  static inline int tg_has_rt_tasks(struct task_group *tg)
>  {
> -	struct task_struct *g, *p;
> +	struct task_struct *task;
> +	struct css_task_iter it;
> +	int ret = 0;
>  
>  	/*
>  	 * Autogroups do not have RT tasks; see autogroup_create().
> @@ -2407,12 +2408,12 @@ static inline int tg_has_rt_tasks(struct task_group *tg)
>  	if (task_group_is_autogroup(tg))
>  		return 0;
>  
> -	for_each_process_thread(g, p) {
> -		if (rt_task(p) && task_group(p) == tg)
> -			return 1;
> -	}
> +	css_task_iter_start(&tg->css, 0, &it);
> +	while (!ret && (task = css_task_iter_next(&it)))
> +		ret |= rt_task(task);

Plain 'ret = rt_task(task);' won't work?

> +	css_task_iter_end(&it);
>  
> -	return 0;
> +	return ret;
>  }
