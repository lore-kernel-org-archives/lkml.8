Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CFCC2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 00:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02FF52071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 00:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFPVrqX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgDXAa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 20:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbgDXAa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 20:30:58 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E406C09B042;
        Thu, 23 Apr 2020 17:30:58 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id y6so3242112pjc.4;
        Thu, 23 Apr 2020 17:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L5XArOSUZwIEnxR3eCf7lGVK2eb+Bi3jkepM1WeX9QE=;
        b=YFPVrqX/oo9QxWP7xGzlaGJ9raYM+zVB0puskfyk362PScv39Lh67FW0q+PCC8NpeG
         pbW8NfRzGNkrdsK4jdMh/G1k2wT9sziF6YTxoVNJ/wmwmKVvOXPga05yfPr+cbBNtnDI
         QNRMbCkJyu5bU0tF+Gz2dR6hbULu4Z4ktTjvQUesjqAcBKSiBdYQGFv7OX83/2QS2vP6
         70MjjYA9OMDctxic2eG+QCQV3QVT8WcivhAvczc5+vH6amZtwibpZCabA//sCP+ITktv
         UJ6LOoeKeYB83s85iZxIxbmwLrOySFnUeMghkxwak+uK1NHrs8JDMAl9sHfTNN/+x9cj
         HC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L5XArOSUZwIEnxR3eCf7lGVK2eb+Bi3jkepM1WeX9QE=;
        b=ePZfndb0nhlhYgBGhnrSlhzmDxKcM18W1gR6YHCoG7vVNta0UBbXnpsDiV4qLB0NlK
         KFsi/o2/6PNty1Ou99T+sojlWZPe5+pc4YVxy2asABDhPnYKbMX6M+qBqgjSxXGftW9g
         AIrGwajTGDScj2mpOSff2Z36Nza4di8spiTaEyqEJxZAiVFttG5DKOzTWyLXRgFW1ukj
         +gVgBQuU5IhnzXbJb7hwBPHT9EhRRhozD+jZNmXW1IZwIY+4Q21jEEiV5fADOeQTP7jD
         EiwIjtJd1MFv8xgvEFovwIQH6H4JZF5awOhWXBzt8ir51/GQRUkgDSZ9+hU5UusOCC7/
         QTQQ==
X-Gm-Message-State: AGi0PubGhy6THhF7kQI5AROrG2I0W5CzHhhcM+WeK96rKDj1QKNSxlMS
        2D8/fgNOIJbh2A0J4LBryQI=
X-Google-Smtp-Source: APiQypI3JWqoZTZWFf/ZQssaQxK4U5EkPUiDF5YTIb5ST9FWlo/Kw86wh7/VtzgytUMI/y6cnR53Eg==
X-Received: by 2002:a17:902:768b:: with SMTP id m11mr2702867pll.82.1587688258138;
        Thu, 23 Apr 2020 17:30:58 -0700 (PDT)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id j26sm3816474pfr.215.2020.04.23.17.30.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 17:30:57 -0700 (PDT)
Date:   Fri, 24 Apr 2020 09:30:52 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 15/18] mm: memcontrol: make swap tracking an integral
 part of memory control
Message-ID: <20200424003051.GE13929@js1304-desktop>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-16-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420221126.341272-16-hannes@cmpxchg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 06:11:23PM -0400, Johannes Weiner wrote:
> Without swap page tracking, users that are otherwise memory controlled
> can easily escape their containment and allocate significant amounts
> of memory that they're not being charged for. That's because swap does
> readahead, but without the cgroup records of who owned the page at
> swapout, readahead pages don't get charged until somebody actually
> faults them into their page table and we can identify an owner task.
> This can be maliciously exploited with MADV_WILLNEED, which triggers
> arbitrary readahead allocations without charging the pages.
> 
> Make swap swap page tracking an integral part of memcg and remove the
> Kconfig options. In the first place, it was only made configurable to
> allow users to save some memory. But the overhead of tracking cgroup
> ownership per swap page is minimal - 2 byte per page, or 512k per 1G
> of swap, or 0.04%. Saving that at the expense of broken containment
> semantics is not something we should present as a coequal option.
> 
> The swapaccount=0 boot option will continue to exist, and it will
> eliminate the page_counter overhead and hide the swap control files,
> but it won't disable swap slot ownership tracking.
> 
> This patch makes sure we always have the cgroup records at swapin
> time; the next patch will fix the actual bug by charging readahead
> swap pages at swapin time rather than at fault time.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

