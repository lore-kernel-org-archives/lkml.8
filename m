Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8E4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 371092070A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="bZNUv2Ul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgFZTYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 15:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgFZTYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 15:24:34 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286F6C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 12:24:34 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id r22so9787587qke.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 12:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bVNITXsH6ARrT0iyl9SMYhunOQ9C68Vgy+G+vYxeBIQ=;
        b=bZNUv2Uly4BUZw63U5yhlWhcO7skTGQLSzUc8Qex6AlUPmwdDEmo93zMJbBIqzRpuj
         hDDzRvzEfk06xBiQeu7KlCUywScOYS1bSFmTctKQZ2xCoY2s6bo63N8Um3rPJBdzRO+m
         lZ/Hqke2UiYw/G8IVFOiF0gk6yxdrLDfY+hEEQCUrpZFLRfPQ3jcwx4nce95tl48+uOl
         BLGUeyzfJNPZzv/BHNpRIM2Lfpu2MhOeR5Gs/BcoRemjBlB2giVtXry2Wr8Z7sk0oN9h
         j2PJPty9aQJGtx5mIzjNUrIdWx1mgMlDvrhfA6uTh/x6CPnVh2FZ6WNHKaSa3F4ubBi+
         wAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bVNITXsH6ARrT0iyl9SMYhunOQ9C68Vgy+G+vYxeBIQ=;
        b=gLq6Sdb3Ns7P0a03ivzfy5keTEMWalJoBlIsTT5x6klbG/MePyyO3tzubFSVLviwu4
         ZzGvS5aTgI+51AqP61a/S4BtrDqZ325JZdA6PcdLrN0bszJAVzvXn/H+Qd15Iv/zVm0f
         j4M2FaV1Ei9Kie+6bsDUa6NWN0pOHrzQDa9OBjOWP90lqLN/krDUutGZEdU9wJcgNGaU
         E9X71uCja/Hera3AwG7yWwHZgrlqtDUGMRKjrzzSRv6Mgnm+dL9xzAECNyijZTzYAo0s
         URxLfQQamVz07v6hcyaql266V8+Yag/agZ7VmPq0bvGUnws92TlxqZ6+kr8opRqxcXWk
         Pdkw==
X-Gm-Message-State: AOAM531tJFbdDw1OahC1VxcNJhUhFobN1YxVfuLxta23ft8gi1L1w16s
        VO0OBcuUr0AO+E42MaXUKYA/qe7iY9IDYA==
X-Google-Smtp-Source: ABdhPJw74V8RzA7jJYlCKa+BewAAc5LsXr0oeTkJ087/bjboYvwJ2o1iJBi37yiqf5S2azmewqi14Q==
X-Received: by 2002:a37:a4c6:: with SMTP id n189mr4098837qke.484.1593199473287;
        Fri, 26 Jun 2020 12:24:33 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p7sm8247131qki.61.2020.06.26.12.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 12:24:32 -0700 (PDT)
Date:   Fri, 26 Jun 2020 15:24:26 -0400
From:   Qian Cai <cai@lca.pw>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ben.widawsky@intel.com, alex.shi@linux.alibaba.com,
        dwagner@suse.de, tobin@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, stable@kernel.org
Subject: Re: [PATCH] mm/vmscan: restore zone_reclaim_mode ABI
Message-ID: <20200626192426.GA4329@lca.pw>
References: <20200626003459.D8E015CA@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626003459.D8E015CA@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 05:34:59PM -0700, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> I went to go add a new RECLAIM_* mode for the zone_reclaim_mode
> sysctl.  Like a good kernel developer, I also went to go update the
> documentation.  I noticed that the bits in the documentation didn't
> match the bits in the #defines.
> 
> The VM evidently stopped caring about RECLAIM_ZONE at some point (or
> never cared) and the #define itself was later removed as a cleanup.
> Those things by themselves are fine.
> 
> But, the _other_ bit locations also got changed.  That's not OK because
> the bit values are documented to mean one specific thing and users
> surely rely on them meaning that one thing and not changing from
> kernel to kernel.  The end result is that if someone had a script
> that did:
> 
> 	sysctl vm.zone_reclaim_mode=1
> 
> That script went from doing nothing to writing out pages during
> node reclaim after the commit in question.  That's not great.
> 
> Put the bits back the way they were and add a comment so something
> like this is a bit harder to do again.  Update the documentation to
> make it clear that the first bit is ignored.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Fixes: commit 648b5cf368e0 ("mm/vmscan: remove unused RECLAIM_OFF/RECLAIM_ZONE")

This is a wrong format.
