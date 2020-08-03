Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93830C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DF4C20781
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="dPmwvzU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgHCPE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHCPE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:04:57 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3742C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 08:04:57 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e5so14387269qth.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 08:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v+Y+IeNd3F1n7XlNjxMNDs/pWS3JUJFhlRHoN7oY4mY=;
        b=dPmwvzU/T3ag5U9ZtHrb8FV/spAvxfqrf4OhrQC7VydMsrv1GHyUT0zQQAEW7C/Qtt
         Yt8Rem5DpO9L7QJV7wMT1FFmOTy8QBWr/wHw45xpFH//Qjd/lhzEfCSnHhIHGGPPohZT
         Qk1jGOLKPFn1VPCZDl0/bGw5fpyz0SRe48g6oY/c2Ig1GX4uSXppcfWs8N438ECQQ39y
         aGznKxCwvspawWMJN2u9PIB8uprF/BpoBJxjnTbkgUARj/1SI4YZvGhrcjqYl4aiIINW
         zslsvSi/tek2Dac92PSdQfoDsTHLPlLIk8YJpto6kYzAsXst393AATiGwLEve+0aEp/V
         fzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v+Y+IeNd3F1n7XlNjxMNDs/pWS3JUJFhlRHoN7oY4mY=;
        b=XDiFRSXq9Mo97r5FAwEROPUSwXjn8xbnmpbWx8OL06Dmt+IOOCwJchUSIknlnICFiK
         R+1Rgz0tGdcBjGzokCTPNGEU5x8wgeZg8Il5pFA9JDgm5JNLv7MFVG01UbR/ttBnyJ9B
         kleZUbaIeRUJ3kfNyxvqenOlI8izBS20P8wpckhffkd4NJkGC4r0QvxxZDx6nYipw8tl
         phquSn5dxQS/3ZW7dySkL6hBrIeDSqIG3xUyKfyy3/1YLRWpWWXfidMOx7wXw1EdK8UR
         gQH1JEVmJYCqClZ9N7KAPEYkF1U7E6hRyGLp64CCWX9p33WLfA1cwI/h06ZvujJQWQr4
         4Dwg==
X-Gm-Message-State: AOAM530r3TRQpjEzU7RmAzJ5MfQ77oNLDqJu1i302pHtHsO+SIY0QXhE
        CPD0ldqv67cHe9VU12TNP+pX8A==
X-Google-Smtp-Source: ABdhPJxuutL92UDVwZwgNfnQqW8lEG9FgF9JCj+WFcZul4NVGAGyNYmG3d/G2pSMDybyPalENciq3g==
X-Received: by 2002:ac8:5146:: with SMTP id h6mr17130263qtn.290.1596467096898;
        Mon, 03 Aug 2020 08:04:56 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:ce31])
        by smtp.gmail.com with ESMTPSA id s33sm23316565qtk.11.2020.08.03.08.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 08:04:53 -0700 (PDT)
Date:   Mon, 3 Aug 2020 11:03:49 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 05/19] mm: memcontrol: decouple reference counting
 from page accounting
Message-ID: <20200803150349.GA502356@cmpxchg.org>
References: <20200623174037.3951353-1-guro@fb.com>
 <20200623174037.3951353-6-guro@fb.com>
 <20200803090033.GE5174@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803090033.GE5174@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 11:00:33AM +0200, Michal Hocko wrote:
> On Tue 23-06-20 10:40:23, Roman Gushchin wrote:
> > @@ -5456,7 +5460,10 @@ static int mem_cgroup_move_account(struct page *page,
> >  	 */
> >  	smp_mb();
> >  
> > -	page->mem_cgroup = to; 	/* caller should have done css_get */
> > +	css_get(&to->css);
> > +	css_put(&from->css);
> > +
> > +	page->mem_cgroup = to;
> >  
> >  	__unlock_page_memcg(from);
> 
> What prevents from memcg to be released here?

->attach_task() and kill_css() are exclusive through the cgroup_mutex,
so the base ref cannot disappear from under us during this operation.
