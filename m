Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F63C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879C32077D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qUIpwaPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgCYN60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 09:58:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38247 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbgCYN6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 09:58:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id l20so2769205wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 06:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+tGgYo2CyFQ5/ZrnsabAg+kp3Ik1H6ilvri2xC2PxQY=;
        b=qUIpwaPL0zpc2DadL3AHfGh4E3v4M/87dNEoklHTQjMDWJEfFVnyf5Ss4YGMY6XBqB
         euQNEWtqTY6CmOHtjx/CRP9TXK9jCBQmLE0m+UNXAuTIQgwn/7BFYgqKRcdB+r6B/Pkc
         pEWuCOje2qxysWGXNpaN1yrfpFM1n4fL3ELZkSj5u6FVlTOBzvscVb7YkcGKG5ga6Is4
         PtFy951sjeCOexQTdvGdc13AQbw6Z/NGyyIvMX2Da3BLOwkH2H6oixtpfo2VqZh9iUtD
         8CiPmQZFKUxid1I/2mtIwTHe4bZRkPv9NS1BA+Lo6uXkx1wEkputLNwAHWiD81PyOcuN
         aWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+tGgYo2CyFQ5/ZrnsabAg+kp3Ik1H6ilvri2xC2PxQY=;
        b=WIC0TLp09v0wQVfk6VIRT5JdVgsADaZrQ23Xgf8Oat/NTUVDUq8dLdBcjAGqzLVZbb
         LMQMaA8yXkKhvZ+4oDdyTGnIcSbTMNBaL2ZY4sFcPFlXlKMvI5TFBvwfi8dAE3SvHRU6
         De2RD0G45CFXuPst3zr3rV4z+VPk8i5GdmBaV68h26x6P6FkW+ovrn3dSvA7mUlGFPzk
         R+cYehJF2ntbNipKXIKNJKhpEIZEyVa5bOU8ZKvFh1O/zFw6Dom1nkXRp64mPnEnqrw0
         BL4P/ekEKcXUpQzxcwK/q56i73UsICZlQK+kPeZNsEjQRSGacUe0WFBbEj97kjAoz0dO
         zwmQ==
X-Gm-Message-State: ANhLgQ2+0dQsdK1GJCHL5ZYjZ/3FT3BDQiwqUU2A3j1riA0lAje26Fuf
        OG5wNupOrPouC0JuWVNJtpLGQQ==
X-Google-Smtp-Source: ADFU+vswiMrJ8m5vBF1K13vBcNWQEwmx5DFcX7UljtBkucuN4xnftXOanGDNYxZDpesV5QskXz/AAQ==
X-Received: by 2002:a1c:3d5:: with SMTP id 204mr3608904wmd.188.1585144702229;
        Wed, 25 Mar 2020 06:58:22 -0700 (PDT)
Received: from vingu-book ([2a01:e0a:f:6020:1d0e:bd73:e049:d9c6])
        by smtp.gmail.com with ESMTPSA id n2sm36305941wro.25.2020.03.25.06.58.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Mar 2020 06:58:21 -0700 (PDT)
Date:   Wed, 25 Mar 2020 14:58:18 +0100
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Aubrey Li <aubrey.li@intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com, vpillai@digitalocean.com,
        joel@joelfernandes.org, Aubrey Li <aubrey.li@linux.intel.com>
Subject: Re: [PATCH] sched/fair: Don't pull task if local group is more
 loaded than busiest group
Message-ID: <20200325135818.GA8201@vingu-book>
References: <1585140388-61802-1-git-send-email-aubrey.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1585140388-61802-1-git-send-email-aubrey.li@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 25 mars 2020 à 20:46:28 (+0800), Aubrey Li a écrit :
> A huge number of load imbalance was observed when the local group
> type is group_fully_busy, and the average load of local group is
> greater than the selected busiest group, so the imbalance calculation
> returns a negative value actually. Fix this problem by comparing the

Do you see any wrong task migration ? because if imbalance is < 0, detach_tasks should return early

> average load before local group type check.
> 
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> ---
>  kernel/sched/fair.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c1217bf..c524369 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8862,17 +8862,17 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>  		goto out_balanced;
>  
>  	/*
> +	 * If the local group is more loaded than the selected
> +	 * busiest group don't try to pull any tasks.
> +	 */
> +	if (local->avg_load >= busiest->avg_load)

If local is not overloaded, local->avg_load is null because it has not been already computed.

You should better add such test in calculate_imbalance after we computed local->avg_load and set imbalance to NULL

something like:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9e544e702f66..62f0861cefc0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9152,6 +9152,15 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s

                sds->avg_load = (sds->total_load * SCHED_CAPACITY_SCALE) /
                                sds->total_capacity;
+
+               /*
+                * If the local group is more loaded than the selected
+                * busiest group don't try to pull any tasks.
+                */
+               if (local->avg_load >= busiest->avg_load) {
+                       env->imbalance =0;
+                       return;
+               }
        }

        /*


> +		goto out_balanced;
> +
> +	/*
>  	 * When groups are overloaded, use the avg_load to ensure fairness
>  	 * between tasks.
>  	 */
>  	if (local->group_type == group_overloaded) {
> -		/*
> -		 * If the local group is more loaded than the selected
> -		 * busiest group don't try to pull any tasks.
> -		 */
> -		if (local->avg_load >= busiest->avg_load)
> -			goto out_balanced;
> -
>  		/* XXX broken for overlapping NUMA groups */
>  		sds.avg_load = (sds.total_load * SCHED_CAPACITY_SCALE) /
>  				sds.total_capacity;
> -- 
> 2.7.4
> 
