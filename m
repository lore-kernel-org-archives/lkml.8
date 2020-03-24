Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0845FC54EEB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 01:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5FF20714
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 01:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585012118;
	bh=N8ny1ddSH/WDtO8Ur8IBPuVWrQVYsU/hhfFIi/kKH78=;
	h=Date:From:To:Subject:In-Reply-To:References:List-ID:From;
	b=dkchYfBY3UuL+aXrJjB5zdCRhzQ7Bhz+HShIcJ5n4eJ/8Wb7Mvui2+mRasCkckPU1
	 1kbbbuqQ1wVSDRUjjOtZlkZ0nuCmycqqUDoz/KwIgCweDicQvcB6zLa58f+SHYp7qD
	 rcOWpL28VNHA+hKD03xodgF77JSRA3oZTW5YU/Ws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgCXBIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 21:08:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:50010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbgCXBIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 21:08:37 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D072220714;
        Tue, 24 Mar 2020 01:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585012117;
        bh=N8ny1ddSH/WDtO8Ur8IBPuVWrQVYsU/hhfFIi/kKH78=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=NwnIBNso0VcDySPOFtACQf/IyXu0Mx81CcufV3Yhj8Jn7rhCANQZJz6uoNGQyDOZy
         5k1pBQ/MUwcPz2GnuBF6J1L2ryc47EjmuCy9nKNzp5AbYhbUmSQc9lLA6uAKVuDYal
         UXd78+ngt+C8WcQe+0oJMHCjjpl/4SZZ2BwT4tWk=
Date:   Mon, 23 Mar 2020 18:08:36 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Bharata B Rao <bharata@linux.ibm.com>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] mm: fork: fix kernel_stack memcg stats for various
 stack implementations
Message-Id: <20200323180836.2d824f5d45f2f5dce729d5b2@linux-foundation.org>
In-Reply-To: <20200323180633.5e75654282d076d74766bd88@linux-foundation.org>
References: <20200303233550.251375-1-guro@fb.com>
        <20200321164856.be68344b7fac84b759e23727@linux-foundation.org>
        <20200324004221.GA36662@carbon.dhcp.thefacebook.com>
        <20200323180358.7603217aa9955f298255da4e@linux-foundation.org>
        <20200323180633.5e75654282d076d74766bd88@linux-foundation.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Mar 2020 18:06:33 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> And here's the altered "mm: memcg/slab: introduce
> mem_cgroup_from_obj()", which I have renamed to "mm: memcg/slab: use
> mem_cgroup_from_obj()":
> 
> The end result is slightly different - mem_cgroup_from_obj() will now
> end up inside #ifdef CONFIG_MEMCG_KMEM.  Should I undo that?

err, no, we've just fed forward the build fixes in
mm-memcg-slab-introduce-mem_cgroup_from_obj-v2.patch so I think we're
all good.
