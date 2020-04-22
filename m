Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDB5C38A30
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 06:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30CEA2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 06:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUOUDClk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgDVGmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 02:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgDVGmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 02:42:15 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9140FC03C1A6;
        Tue, 21 Apr 2020 23:42:15 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d184so594001pfd.4;
        Tue, 21 Apr 2020 23:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Drc+56Q36eDpJcbMrcUJkfyYMbc4NMUbpx2Oj4m1kIA=;
        b=CUOUDClkinZimUWFeCOxuqvCFZL8oJ4l7+brBtc7xtSfkuDi8UsLA+VHKR4YMwKO8p
         nTywzbCpVQ7TjgRm20khS6C+SNQCruZOWGnqOuj/a8tv10tKQj7t1VUxfkSnU22gi/zI
         fR64Hpy+yb2ajCoVr8dBtKM84OyeQfsSxka9Uq8WLNa5NNMxZxDZ0n9bqHMHodAr6U5L
         95QzwG7l8owtJHvhyDE7oZTAgtceuXBsps0jjvvRYx1zKLY4P7ExdGyVtdz3CplwRa8z
         L5J0PLgzizfm6wou7IZP9dqjV8T114XHK+SjsE4lXC35XKT+LMJ4J8u035kjiJ69yIEJ
         l6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Drc+56Q36eDpJcbMrcUJkfyYMbc4NMUbpx2Oj4m1kIA=;
        b=jJfotcH2zD9of6+u5AYdfWC/ZnuHqRoPhxkJNM7/1RJdMVpMv9fBYkFQH6wlTmKu09
         dJOFG7bYdyjZjnGAy5LHZoVh1q8JGMDbAoE78RFvNKo08c5IkTM40OB4fAEUdelzDMkf
         7wslSyiMNLZGLtANfrdDxI/p26FLb298K/2Jgv4c11c77RYyfX/a5v3xCL2pqrPC/fn2
         mcd0TrypUJKyKB/M2r2RzVKl277hfXrdqYty9lZ4NvXYtvXUh93IDUv2muUt6Cy9oGIE
         f5dvVC4Wg18CAwmDa9vxPcMv0G26zo+z8SltoksNB7yV9f4FV1Pl66XBZoKEoMUHoDmj
         1mxw==
X-Gm-Message-State: AGi0PuYDucSREtbuu//eXpuBsuGCrkbsi13lnQGL6PWpboeJ8STG5EaN
        OGW3eDZtpS9NyY6rDfEf6KI=
X-Google-Smtp-Source: APiQypLtEtPtZdsmpKWeCmbaul3a9tV3vD6iMVWju5gPx0XndvMSFMVnpRQXvLt195I+J2jI7ab8tg==
X-Received: by 2002:a65:4908:: with SMTP id p8mr24814442pgs.413.1587537735137;
        Tue, 21 Apr 2020 23:42:15 -0700 (PDT)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id k10sm4467360pfa.163.2020.04.21.23.42.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Apr 2020 23:42:14 -0700 (PDT)
Date:   Wed, 22 Apr 2020 15:42:09 +0900
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
Subject: Re: [PATCH 08/18] mm: memcontrol: prepare cgroup vmstat
 infrastructure for native anon counters
Message-ID: <20200422064208.GH6780@js1304-desktop>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-9-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420221126.341272-9-hannes@cmpxchg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 06:11:16PM -0400, Johannes Weiner wrote:
> Anonymous compound pages can be mapped by ptes, which means that if we
> want to track NR_MAPPED_ANON, NR_ANON_THPS on a per-cgroup basis, we
> have to be prepared to see tail pages in our accounting functions.
> 
> Make mod_lruvec_page_state() and lock_page_memcg() deal with tail
> pages correctly, namely by redirecting to the head page which has the
> page->mem_cgroup set up.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
