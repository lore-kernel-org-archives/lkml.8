Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD154C35673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 02:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6F92067D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 02:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582512788;
	bh=yVkuU9V841ix1fFjroZlF2lRi1LQ89gDQoAPV/sfzNg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=DuQGmEeZkjB7GrzGeGl1HhVXJ1RZiBu+nnLIGdlzUOyGV+kDXvyyOw4L2dk+M2R9e
	 jJpZ66yztYEL9UndyWU+U4wEiY5z075WIRI+bEnrNURgVYSViBY+2/gXCgHYRnPNG+
	 FXCExvf2fB9T5vnkDWuihYn7/Ueg6CXt9UJiljNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgBXCxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 21:53:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:34954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbgBXCxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 21:53:07 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89E9620658;
        Mon, 24 Feb 2020 02:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582512786;
        bh=yVkuU9V841ix1fFjroZlF2lRi1LQ89gDQoAPV/sfzNg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ph640y11De0Q/2uQE9cOsxGxAdnLnzQrKA3g8172EQideqSf2Py47xLXEU5lMhTwY
         ZUdX2clBRLcOJf9Zbz0BENZ5lOKAJOa/2ZZNpuriG2ZGwQYqku8m4sd2iMZv34y5eV
         MXPLDgshEqVgSJpHnV+qJk4iihkAuc97/k8c9CFE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9723C3521885; Sun, 23 Feb 2020 18:53:03 -0800 (PST)
Date:   Sun, 23 Feb 2020 18:53:03 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 13/15] torture: Replace cpu_up/down with add/remove_cpu
Message-ID: <20200224025303.GH2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200223192942.18420-1-qais.yousef@arm.com>
 <20200223192942.18420-14-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223192942.18420-14-qais.yousef@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 07:29:40PM +0000, Qais Yousef wrote:
> The core device API performs extra housekeeping bits that are missing
> from directly calling cpu_up/down.
> 
> See commit a6717c01ddc2 ("powerpc/rtas: use device model APIs and
> serialization during LPM") for an example description of what might go
> wrong.
> 
> This also prepares to make cpu_up/down a private interface for anything
> but the cpu subsystem.
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> CC: Davidlohr Bueso <dave@stgolabs.net>
> CC: "Paul E. McKenney" <paulmck@kernel.org>
> CC: Josh Triplett <josh@joshtriplett.org>
> CC: linux-kernel@vger.kernel.org

From a torture-test perspective:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/torture.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/torture.c b/kernel/torture.c
> index 7c13f5558b71..a479689eac73 100644
> --- a/kernel/torture.c
> +++ b/kernel/torture.c
> @@ -97,7 +97,7 @@ bool torture_offline(int cpu, long *n_offl_attempts, long *n_offl_successes,
>  			 torture_type, cpu);
>  	starttime = jiffies;
>  	(*n_offl_attempts)++;
> -	ret = cpu_down(cpu);
> +	ret = remove_cpu(cpu);
>  	if (ret) {
>  		if (verbose)
>  			pr_alert("%s" TORTURE_FLAG
> @@ -148,7 +148,7 @@ bool torture_online(int cpu, long *n_onl_attempts, long *n_onl_successes,
>  			 torture_type, cpu);
>  	starttime = jiffies;
>  	(*n_onl_attempts)++;
> -	ret = cpu_up(cpu);
> +	ret = add_cpu(cpu);
>  	if (ret) {
>  		if (verbose)
>  			pr_alert("%s" TORTURE_FLAG
> @@ -192,17 +192,18 @@ torture_onoff(void *arg)
>  	for_each_online_cpu(cpu)
>  		maxcpu = cpu;
>  	WARN_ON(maxcpu < 0);
> -	if (!IS_MODULE(CONFIG_TORTURE_TEST))
> +	if (!IS_MODULE(CONFIG_TORTURE_TEST)) {
>  		for_each_possible_cpu(cpu) {
>  			if (cpu_online(cpu))
>  				continue;
> -			ret = cpu_up(cpu);
> +			ret = add_cpu(cpu);
>  			if (ret && verbose) {
>  				pr_alert("%s" TORTURE_FLAG
>  					 "%s: Initial online %d: errno %d\n",
>  					 __func__, torture_type, cpu, ret);
>  			}
>  		}
> +	}
>  
>  	if (maxcpu == 0) {
>  		VERBOSE_TOROUT_STRING("Only one CPU, so CPU-hotplug testing is disabled");
> -- 
> 2.17.1
> 
