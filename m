Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADD4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3640C20823
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590018165;
	bh=l2mS/FNkusn6YLF9oQ03x6lf0x9xSKXhbjmtXuuKOEU=;
	h=Date:From:To:Subject:In-Reply-To:References:List-ID:From;
	b=JHR5SHh5yV36oi3tw7pb9hjZ3JIdBBzKoTSX188XD8hdMOBViqyY5OORAKjSZ1mHW
	 K0MM1Hs39bdaN1NF+g3Guq+hv0csRF5BwEa0ZzgpSBRdDPDJOPgwa+dhLTvi6/n0an
	 q8pYh8/jtsagiXxVxYY47jscnAx+0JPAtHjjoVEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgETXmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 19:42:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbgETXmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:42:44 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8BD92072C;
        Wed, 20 May 2020 23:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590018164;
        bh=l2mS/FNkusn6YLF9oQ03x6lf0x9xSKXhbjmtXuuKOEU=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=qJ+3eof3hck1Gh1nBa2/+j6vwmtmoQW2xYQ0eTC853DIb8H/4+cHCLfaXLzznyRd6
         ZFvs8b1FX05UdabsiW4zNAhkt+Oi8JMbHMFNUnude+cklLBNZvcgSEyR+fU9qXbBDa
         2AkRUBPbAjt3JLK7Wd6YJ3db43kp8TzLxIItbyQo=
Date:   Wed, 20 May 2020 16:42:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chris Down <chris@chrisdown.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: unify reclaim retry limits with page
 allocator
Message-Id: <20200520164243.56133fa135f65cc708e70ec0@linux-foundation.org>
In-Reply-To: <20200520164037.e3598bc902e39415f4c263e7@linux-foundation.org>
References: <20200520163142.GA808793@chrisdown.name>
        <20200520164037.e3598bc902e39415f4c263e7@linux-foundation.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 May 2020 16:40:37 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> > -/* The number of times we should retry reclaim failures before giving up. */
> 
> hm, what tree is this against?

Ah, my habit of working in reverse time order sometimes does this ;)

I suggest that "mm, memcg: reclaim more aggressively before high
allocator throttling" and this patch become a two-patch series?

