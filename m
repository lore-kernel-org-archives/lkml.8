Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC4EC352BE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0524B206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OS7NWpAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391741AbgDNQcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391725AbgDNQcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:32:20 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CBEC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 09:32:20 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id s30so10685047qth.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 09:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SqpT1X280p+vEPTDIK1Gx8cxwNT9Kl8YEWiyZ9LyzJI=;
        b=OS7NWpAvehP7dmjbbLsxc4PcWImRNci6e5Mrxl8qYLhe6GYrpERBZdO0QOGfdWP3hV
         p33q6aQKGWSU5faiBV1L67Oo6vcsmFK4+GGqYgutIfp49b6hxY8XQIqZip8XY04g0FaP
         z8sLy8D2dcy4jI0eqqUs+O6Ygmv/qKH1Gr9NQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SqpT1X280p+vEPTDIK1Gx8cxwNT9Kl8YEWiyZ9LyzJI=;
        b=LwtjPoQxt8zZSK8vlU6pLFvatP2FpuzB7QOgaKbWnI2Zqfjp0DsKumTzuzUYXkQFOg
         oVCrXzAJLXmpLsR5AeO2pCBuJUMNYSQcQxgFyoV2xl27jF36TTeXmwoorK/S+bx60nb1
         jvw4eSQIiS1Ncfw/K3PhNjwrumiN5oBorrzog/kyVSehHRY/IvXdqIjRBOPi4Pf4Uhub
         y87jQ7M8npZ7KOGStzWcK64u3GulGoqA24FjYOpzC5z16Kequi9huC27NuMt3jYk1Q/A
         wK3j5LePPQSEUBGbQNxIzRqHgvwylgD8d3nPjjZZTZEocJAVNe5OLUazA6OMecEk2tFf
         UnSQ==
X-Gm-Message-State: AGi0PuaV1tR8IAGqfUbtbQD37cTNnTpZxmgH/mwmG00EzLUqRj/kBBsB
        pMPFPcIpHKi0yeqcea8myAyNxw==
X-Google-Smtp-Source: APiQypLLJHgEiHO8u72vxT6aP2yq3+L8ePGHN3hnF8/VapHORS7x+wE/Tf0PC55fPITD2G0BGbKRoA==
X-Received: by 2002:ac8:5048:: with SMTP id h8mr17167818qtm.189.1586881939416;
        Tue, 14 Apr 2020 09:32:19 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 190sm2787713qkj.87.2020.04.14.09.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:32:18 -0700 (PDT)
Date:   Tue, 14 Apr 2020 12:32:18 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Quentin Perret <qperret@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        ctheegal@codeaurora.org, dianders@chromium.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        qais.yousef@arm.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] sched/core: Fix reset-on-fork from RT with uclamp
Message-ID: <20200414163218.GA77963@google.com>
References: <20200414161320.251897-1-qperret@google.com>
 <20200414162128.GA66453@google.com>
 <20200414162713.GA256619@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414162713.GA256619@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 05:27:13PM +0100, Quentin Perret wrote:
> On Tuesday 14 Apr 2020 at 12:21:28 (-0400), Joel Fernandes wrote:
> > Shouldn't this be conditional on p->sched_reset_on_fork instead of deleting
> > the code?
> 
> Right, it's not obvious from the diff, but this code _is_ conditional on
> p->sched_reset_on_fork already. This is what the whole function looks
> like with my patch applied:
> 
> ---8<---
> static void uclamp_fork(struct task_struct *p)
> {
>         enum uclamp_id clamp_id;
> 
>         for_each_clamp_id(clamp_id)
>                 p->uclamp[clamp_id].active = false;
> 
>         if (likely(!p->sched_reset_on_fork))
>                 return;
> 
>         for_each_clamp_id(clamp_id) {
>                 unsigned int clamp_value = uclamp_none(clamp_id);
> 
>                 uclamp_se_set(&p->uclamp_req[clamp_id], clamp_value, false);
>         }

Oh ok, thanks for clarification.

 - Joel


> }
> --->8---
> 
> Thanks,
> Quentin
