Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5986C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5112072A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578673904;
	bh=Rrk4n1nHKqxj+BZCcSgnpXUKkWUtPTA1mv68Gy7dZO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xBNxNnQdAmWXeAjTm6z3zbeIf0L7HrewSkuMxEjj1qRCSypuVqJ0tLqdOi2tIEjbL
	 N0bbEnm3Ky28kmbaycX3gZrkkT0hme5GWMik2QvnGRuIfSLq+4lvS7ckebpkT+eCLP
	 t3asNOceiU0aEnIJdq2NZOBl2e4zi+zYs/dBZYvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgAJQbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:31:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:55804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbgAJQbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:31:43 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65178205F4;
        Fri, 10 Jan 2020 16:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578673902;
        bh=Rrk4n1nHKqxj+BZCcSgnpXUKkWUtPTA1mv68Gy7dZO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IrbMpNEO3empPNaJOZ9/BBjsosxffjbyeTmhwaC5ygwe1vlJhhVWfAh0XUUOmOySF
         nPLJuu4WDpKEvLXufBqY1wH+gLdayWRrZ2S6z2KwnwLWQ/Z/yLjN7KIp/aLEd+Sx26
         dThCEIS9BeCJC1ZHLa2ixTdNyl1x5Tb/XyRM+3G0=
Date:   Sat, 11 Jan 2020 01:31:34 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Amol Grover <frextrite@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] drivers: nvme: target: core: Pass lockdep expression to
 RCU lists
Message-ID: <20200110163134.GA18579@redsun51.ssa.fujisawa.hgst.com>
References: <20200110132356.27110-1-frextrite@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110132356.27110-1-frextrite@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 06:53:58PM +0530, Amol Grover wrote:
> +#define subsys_lock_held() \
> +	lockdep_is_held(&subsys->lock)

This macro requires "struct nvmet_subsys *subsys" was previously declared
in the function using it, which isn't obvious when looking at the users. I
don't think that's worth the conciseness.

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
