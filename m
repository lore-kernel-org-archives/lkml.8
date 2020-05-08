Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F5FC47255
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF6CA21655
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="1rm4qMVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgEHVwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 17:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgEHVwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 17:52:46 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4727BC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 14:52:46 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id fb4so1384786qvb.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 14:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/Bg23MpwaLt5ES1Q90+CSXO9u0G+8VEy9TthqACk8pE=;
        b=1rm4qMVbcyKhgRbqDol38rBrkbyaZbxpfkXsQfwESaWUofm9FQVmK/wxaUfeIUZygo
         HsGYt09Ll+D1Q0/NDvGuVng7N+gAh0575gb8z6n8u+dxMoQHoC1vfOYVhf68hgZoLvhb
         LvTWV94B9ObgkjWuVKW+yxNPICHdMTrcOc92uPtwZpCy5PSiU0iklgWmIEx1+ny+Lmdp
         r8n9oZQHT856fp9eRfvxZU5UPwlEyFophlObXiv3bFFtElwVs1Cw9q3D149s40LMK8a/
         ZWmePp2TvUuF/ICL2KJQ7+1+jY2pq+wlkDiMsN/8bp0c8W/1W2ZxCweHg7a/K6x7WB9D
         NnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/Bg23MpwaLt5ES1Q90+CSXO9u0G+8VEy9TthqACk8pE=;
        b=q9RvQtBRReAioCnJ0y+//CzfeA+zL7i+nzO0Q9HS2BYYdvbZN4nNYQp1xt8aQ0h0gG
         nI9mWD1z7n4A70ZIAf3K5fezuEL+PpYfUZ3LPcY/Po2DkLiYo/zzFGXFfKhIZbAdQjch
         186U7E1+9yojGgmOY26SHx1DBaBrSXtTuUrKtMPYiHdKiIoCp6FDMzuMjD0dD9uRAjsa
         kzWc9g9eE7NrlFx20aGKVnEfLZIXMI8OHszvz4tvlK8cTObmf9iQNj8bt8PJQGLHDIhj
         rTPiseZV+wY3vRYnkARwkeUYtlXcB4tWCElcRhgDkZ2a+rtbuycS31Yz36B+UJloDgYJ
         MAmQ==
X-Gm-Message-State: AGi0PuYinHdDkWpdOYspjrO53qAGpx1qJO3xB7S/zY/Zkp2Q+GEmelva
        4XK37jH3LlJls70R66sOi7WZqQ==
X-Google-Smtp-Source: APiQypKmtl+1oHPPWXjPwav7h15WBhj4HMNp31tMAisZWuYqEd91uBiMzUO1EmthvbIEeETVN6J6bg==
X-Received: by 2002:a0c:f8c4:: with SMTP id h4mr4924155qvo.15.1588974765599;
        Fri, 08 May 2020 14:52:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id m7sm2547075qti.6.2020.05.08.14.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 14:52:45 -0700 (PDT)
Date:   Fri, 8 May 2020 17:52:28 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Mel Gorman <mgorman@suse.de>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: swap: fix vmstats for huge pages
Message-ID: <20200508215228.GC226164@cmpxchg.org>
References: <20200508212215.181307-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508212215.181307-1-shakeelb@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 02:22:13PM -0700, Shakeel Butt wrote:
> Many of the callbacks called by pagevec_lru_move_fn() do not correctly
> update the vmstats for huge pages. Fix that. Also __pagevec_lru_add_fn()
> use the irq-unsafe alternative to update the stat as the irqs are
> already disabled.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
