Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72510C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46A132073A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jhPrNDlf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgEGSY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726367AbgEGSY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:24:57 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15B1C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 11:24:57 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 207so3169081pgc.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 11:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=JmY2P1v7eg8hDmhKflScuHXGXBSSsuu5HkSbuBLgbys=;
        b=jhPrNDlftSgnKSOz8O1RetlNzRfXH3C3YfhdTWWuEs29gIgWK6oL29IfLgxRij2kT5
         OqSb4lf+u53Z+EiCqRa3fWGAu7V9mm0CBTbW37YmMf9JYi3h4YTGd10k3IDBNewcinqe
         7dDWeyWF/dL60TYHDNRuvbsQevXTdHmJ7XaNo3uvfeABDRdEk9wbVj2sM0e+AYX4mcZ9
         b8BY6XfajFs/tpJ/WSXmgGNm47Pm+Rrg+HiYIGgVghxFZK9X2o2zi+D14ZXH/I15mRVG
         4M7CsnyyS361GYMFC0TaqeLgWRTccilxC6nuneyRmG3MugBw3NQH3ojPzA+CCGiM6U2+
         2/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=JmY2P1v7eg8hDmhKflScuHXGXBSSsuu5HkSbuBLgbys=;
        b=e225lYYno8pxaaQkC6JCu/oamj1Yp27lj1nuxaRg3pyZnENRIB3fGhJdtWdjm8sIxT
         SxnDojpTQj2LTpsaZClUHAX0gddmV978Y2HLvrC/apbTzbV8OaQXKaH9gYIDEBZnVA/d
         2oP/7ePLd4YFY93YVo55wl9ppclbhOBVq12j+0sFprFL/mvwYX8eWV5TNw0V/O99nSWN
         aFFiAYYDJw4XjcSAdoU+kf14FfTuV+ETc2CzngZ/wXQbA+yjzV0XbMWmz9YJt2jg47DJ
         fcapb0H4FmCWg195qOd4WCjLrX7+EvLOybslhBkOTf4v4H8/Vn/DZm3q+38l/SYfngv5
         /quQ==
X-Gm-Message-State: AGi0PuYJrUnPPTJC6csBRyr1pXtjjzPhmDbiF4IqSpbMAqA8U1l+QmjE
        nQqLmzFNHD9/Z29S5MjiYMfx1Q==
X-Google-Smtp-Source: APiQypKrgOaQyef7OD6jBNbka3s7B9VCNQ5iAd3KucwyUfrgYjNeEs2S2MZcXTYqRGwgW2iSs1Bx3g==
X-Received: by 2002:a63:790a:: with SMTP id u10mr11928436pgc.126.1588875897015;
        Thu, 07 May 2020 11:24:57 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id x18sm5622964pfi.22.2020.05.07.11.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 11:24:56 -0700 (PDT)
Date:   Thu, 7 May 2020 11:24:55 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <guro@fb.com>,
        Wen Yang <wenyang@linux.alibaba.com>
Subject: Re: [PATCH] slub: limit count of partial slabs scanned to gather
 statistics
In-Reply-To: <f716f4ef-7f8a-f1b2-f80a-2d99666f67c2@yandex-team.ru>
Message-ID: <alpine.DEB.2.22.394.2005071122170.142256@chino.kir.corp.google.com>
References: <158860845968.33385.4165926113074799048.stgit@buzz> <5BAA0D82-555E-4E72-966A-A147472271D0@lca.pw> <39E953F3-BBA4-43BF-AA0D-B1BED21F9A4D@lca.pw> <f716f4ef-7f8a-f1b2-f80a-2d99666f67c2@yandex-team.ru>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 May 2020, Konstantin Khlebnikov wrote:

> > > > To get exact count of free and used objects slub have to scan list of
> > > > partial slabs. This may take at long time. Scanning holds spinlock and
> > > > blocks allocations which move partial slabs to per-cpu lists and back.
> > > > 
> > > > Example found in the wild:
> > > > 
> > > > # cat /sys/kernel/slab/dentry/partial
> > > > 14478538 N0=7329569 N1=7148969
> > > > # time cat /sys/kernel/slab/dentry/objects
> > > > 286225471 N0=136967768 N1=149257703
> > > > 
> > > > real	0m1.722s
> > > > user	0m0.001s
> > > > sys	0m1.721s
> > > > 
> > > > The same problem in slab was addressed in commit f728b0a5d72a ("mm,
> > > > slab:
> > > > faster active and free stats") by adding more kmem cache statistics.
> > > > For slub same approach requires atomic op on fast path when object
> > > > frees.
> > > > 
> > > > Let's simply limit count of scanned slabs and print warning.
> > > > Limit set in /sys/module/slub/parameters/max_partial_to_count.
> > > > Default is 10000 which should be enough for most sane cases.
> > > > 
> > > > Return linear approximation if list of partials is longer than limit.
> > > > Nobody should notice difference.
> > > > 
> > > > Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> > > 
> > > This patch will trigger the warning under memory pressure, and then makes
> > > lockdep unhappy. Also,  it is almost impossible tell how many
> > > max_partial_to_count is sufficient from user perspective.
> 
> Oops, my bad. Printing under this lock indeed a bad idea.
> 
> Probably it's better to simply remove this message.
> I cannot imagine situation when precise count of object matters at such scale.
> 

If the printk is removed, then probably better to remove the 
max_partial_to_count param as well?  I doubt it would ever be used since 
nothing points to it other than the kernel code now.  If somebody 
complains about the approximation, we can (a) convince them the 
approximation is better than precise calculation to prevent irqs from 
being disabled for several seconds and (b) add it later if absolutely 
necessary.  I notice the absence of other module_param()'s in mm/slub.c, 
so likely better to avoid adding special tunables like this unless 
absolutely necessary.
