Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBE4C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CE520721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="LcxSVzG5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgAJPrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 10:47:25 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40311 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbgAJPrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:47:24 -0500
Received: by mail-pf1-f194.google.com with SMTP id q8so1319093pfh.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 07:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z4ABlzGfi6l9NY75xhWGkqHQ22z62lYF4lGV0Z/l5RI=;
        b=LcxSVzG5beLFAGBipNshQyqz86YJ4TvGiOt8WALynXqSjPkkq7quMQSkFPFePo5f1q
         kJd0E4o7b+dPaAwBlXzfg5j5FKpHhUCAp057Fb328BFbzN8FK/VNHdiDhDR1bzkAooFs
         EzOxEsiGw18GT7yVSM8MCsgBXWLwE304YYV4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z4ABlzGfi6l9NY75xhWGkqHQ22z62lYF4lGV0Z/l5RI=;
        b=oWeqlmpN9SU350nJaPc6pg/AKzoZ3OVKyLNpLLxbxOi/YuofFT8Q9S8C0fORdzyGGJ
         3VY3+IDvdiMMFUdNAcX39utDW69EZXjsxwq8BQT5nriUEoyhSb4Yp1QeJ46r5ZbzIr/z
         iudRQU/GP+QhaPT4ktd2DRaBTAqNL7CW4aS1GaKfYp3H9Q9NwUE0oNOhXMVa+fJSpJup
         A31PfFgHskQozayKxRCE6As0Ka2ynnwvE6GUj5WMIyJBuzaBZBx6Hto1sNgSSE05RukF
         XzEk35P+EAxCHhs9iA1lVIRZEquZPOOfrXRsWikBlO7Bagmpur1aQ0+G7ZcUgzHLTJPp
         disg==
X-Gm-Message-State: APjAAAUmFyh/mlJmsAdQbRGWXL7Kfh9qQORGFPyr1bCW0kHIfb8Z2gcq
        G7Qch5Wvc8lXhPIbEE4/J9ARoA==
X-Google-Smtp-Source: APXvYqwJtzElrbQ8rKden7GP/HTNQxSyjLQOYjfY8yPFbp0XjIM+yXed9Z3lzn1NH9U0cYSbLjiIow==
X-Received: by 2002:a62:c583:: with SMTP id j125mr5021922pfg.27.1578671244168;
        Fri, 10 Jan 2020 07:47:24 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id z26sm3137300pgu.80.2020.01.10.07.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 07:47:23 -0800 (PST)
Date:   Fri, 10 Jan 2020 10:47:22 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Amol Grover <frextrite@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] drivers: nvme: target: core: Pass lockdep expression to
 RCU lists
Message-ID: <20200110154722.GA128013@google.com>
References: <20200110132356.27110-1-frextrite@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110132356.27110-1-frextrite@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 06:53:58PM +0530, Amol Grover wrote:
> ctrl->subsys->namespaces and subsys->namespaces are traversed with
> hlist_for_each_entry_rcu outside an RCU read-side critical section
> but under the protection of subsys->lock.
> 
> Hence, add the corresponding lockdep expression to the list traversal
> primitive to silence false-positive lockdep warnings, and
> harden RCU lists.
> 
> Add macro for the corresponding lockdep expression to make the code
> clean and concise.

Amol, thanks. Could you fix this checkpatch warnings? hint: Use --fix-inplace

CHECK: Alignment should match open parenthesis
#50: FILE: drivers/nvme/target/core.c:562:
+               list_for_each_entry_rcu(old, &subsys->namespaces, dev_link,
+                                                       subsys_lock_held()) {

CHECK: Alignment should match open parenthesis
#60: FILE: drivers/nvme/target/core.c:1180:
+       list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link,
+                                                       subsys_lock_held())

Otherwise,

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> 
> Signed-off-by: Amol Grover <frextrite@gmail.com>
> ---
>  drivers/nvme/target/core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 28438b833c1b..7caab4ba6a04 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -15,6 +15,9 @@
>  
>  #include "nvmet.h"
>  
> +#define subsys_lock_held() \
> +	lockdep_is_held(&subsys->lock)
> +
>  struct workqueue_struct *buffered_io_wq;
>  static const struct nvmet_fabrics_ops *nvmet_transports[NVMF_TRTYPE_MAX];
>  static DEFINE_IDA(cntlid_ida);
> @@ -555,7 +558,8 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
>  	} else {
>  		struct nvmet_ns *old;
>  
> -		list_for_each_entry_rcu(old, &subsys->namespaces, dev_link) {
> +		list_for_each_entry_rcu(old, &subsys->namespaces, dev_link,
> +							subsys_lock_held()) {
>  			BUG_ON(ns->nsid == old->nsid);
>  			if (ns->nsid < old->nsid)
>  				break;
> @@ -1172,7 +1176,8 @@ static void nvmet_setup_p2p_ns_map(struct nvmet_ctrl *ctrl,
>  
>  	ctrl->p2p_client = get_device(req->p2p_client);
>  
> -	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link)
> +	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link,
> +							subsys_lock_held())
>  		nvmet_p2pmem_ns_add_p2p(ctrl, ns);
>  }
>  
> -- 
> 2.24.1
> 
