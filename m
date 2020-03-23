Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933B5C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CC7206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tWTwtLci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgCWVwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:52:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39583 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgCWVwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 17:52:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id d25so8174336pfn.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 14:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zzaojujfcls2hgFyVUn0hD1Rb+7tZyy+TgUJhbpUoN0=;
        b=tWTwtLciVWGSxsbK51pBsm7+vZ073MLGRYvTY2C4gVsjjvEfn14hy7mCtlIsWT+LvQ
         al5phEEv8sdIIHJnFOjBu5CNIfygJVjQbwKif/nBhzkXYzPt2NeARsXaQbO7sHjYl7Ho
         IyuMyLSDe76UZsuPAvnYEFVGKNVGSkygCw+8o5OXo9RGlOSzkscK/JydAc5DUTMZO83W
         03ohm0vE/DAPjcuZXljtjSbkdPHLTIyQmiBH6KTiDrfaisDWAPIrUN0bK7hUee01IuaS
         2vh5bPwOmBCgwlmBoPM7NeRT3ejSr2KPgaJ3H/+g6hW07PbV15/ZheZ3OF+7xCrlsE1Y
         pXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zzaojujfcls2hgFyVUn0hD1Rb+7tZyy+TgUJhbpUoN0=;
        b=YCVe5XP7Cyr/qPA3EQK3EYOA2m9HZCdFKW/ldCQKN111NSLJu9Vgh5diYszXNG7KxU
         TYc3vr2wWov2Ae3JUIcpgrKyWhWd9w0CedItF0rEziGWGuH8xk5OTlLw+L+hkL6KjpW6
         jmhET2bQgOwnieM5mqzZRBqHTuP15odwWGCmSX9/fzqxvz2JRVS7eixnyS7UFzQ0sen3
         sHnj/6Pot3dCSyrzMN8Z7LftJyJOc7yVeVU0zhFMXk3Iir6QcBs0OzK1m0G0ZXPSvd0r
         jW1yGHGGPIKePwzGTBvlR51ZFvUOLkVqtOgqiX4L/eXrt2zSUiAGwoTzOy+46Go6bhZ0
         tkaQ==
X-Gm-Message-State: ANhLgQ3N7R9otMucTo9y+JOvB/GV8g8vKY6MYbq110qy9eDgpxgwTV/1
        gN+4OpnXID6DRitdsQiGdwOl+A==
X-Google-Smtp-Source: ADFU+vvmkqQHQNARe/Cfqm5giF+9fLK7xjtj+Kr/nmczELP2SRPVq3XmEvxUAYfyJp75b2PX8eQsiQ==
X-Received: by 2002:a63:ec50:: with SMTP id r16mr25369318pgj.274.1585000327853;
        Mon, 23 Mar 2020 14:52:07 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id j12sm5499008pgs.0.2020.03.23.14.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 14:52:07 -0700 (PDT)
Date:   Mon, 23 Mar 2020 15:52:05 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] remoteproc: Traverse rproc_list under RCU read
 lock
Message-ID: <20200323215205.GA30464@xps15>
References: <20200310063817.3344712-1-bjorn.andersson@linaro.org>
 <20200310063817.3344712-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310063817.3344712-2-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 11:38:14PM -0700, Bjorn Andersson wrote:
> In order to be able to traverse the mostly read-only rproc_list without
> locking during panic migrate traversal to be done under rcu_read_lock().
> 
> Mutual exclusion for modifications of the list continues to be handled
> by the rproc_list_mutex and a synchronization point is added before
> releasing objects that are popped from the list.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Change v3:
> - New patch
> 
>  drivers/remoteproc/remoteproc_core.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 097f33e4f1f3..f0a77c30c6b1 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1854,8 +1854,8 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
>  	if (!np)
>  		return NULL;
>  
> -	mutex_lock(&rproc_list_mutex);
> -	list_for_each_entry(r, &rproc_list, node) {
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(r, &rproc_list, node) {
>  		if (r->dev.parent && r->dev.parent->of_node == np) {
>  			/* prevent underlying implementation from being removed */
>  			if (!try_module_get(r->dev.parent->driver->owner)) {
> @@ -1868,7 +1868,7 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
>  			break;
>  		}
>  	}
> -	mutex_unlock(&rproc_list_mutex);
> +	rcu_read_unlock();
>  
>  	of_node_put(np);
>  
> @@ -1925,7 +1925,7 @@ int rproc_add(struct rproc *rproc)
>  
>  	/* expose to rproc_get_by_phandle users */
>  	mutex_lock(&rproc_list_mutex);
> -	list_add(&rproc->node, &rproc_list);
> +	list_add_rcu(&rproc->node, &rproc_list);
>  	mutex_unlock(&rproc_list_mutex);
>  
>  	return 0;
> @@ -2140,9 +2140,12 @@ int rproc_del(struct rproc *rproc)
>  
>  	/* the rproc is downref'ed as soon as it's removed from the klist */
>  	mutex_lock(&rproc_list_mutex);
> -	list_del(&rproc->node);
> +	list_del_rcu(&rproc->node);
>  	mutex_unlock(&rproc_list_mutex);
>  
> +	/* Ensure that no readers of rproc_list are still active */
> +	synchronize_rcu();
> +

Please add linuc/rculist.h to include the RCU API.  With that:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  	device_del(&rproc->dev);
>  
>  	return 0;
> -- 
> 2.24.0
> 
