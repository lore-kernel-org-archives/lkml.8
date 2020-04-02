Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8F9C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BFB20784
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585811676;
	bh=FVq8i6uthrbfLR09edgbxiWw4ECv/fXnjsmRytRkY7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vcrsiSaIvuYQCQvBNDkIQgBL+/btHiiWz78g+0Zi8I+xeiqc3Wm7h3vh8telHH9A6
	 gm6YuxMMO2oBMlDgt8f5khQYxzX00OCajadx/KXsn2C7+0TiyIfvIt1G3GGTenAPBC
	 T4mhg8w3R64sfWpjwtpXcVn5PJqZm4fqu4f37JZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387506AbgDBHOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:14:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36714 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729289AbgDBHOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 03:14:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id d202so2408360wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 00:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6zSvzlPFPe5kHJzBH7BwpSL+DKal1qwCEGq/fwhdzrA=;
        b=QJ9PZqGCl0XPyqkdFQpVBXNWRTyYa4HhN5pOyzO7GoVDz/GXoP3ScInMgZ1p24lvit
         Gsd5iCHyVfOujdCug0OgaZJiwgpdMY8U9i80zMFiNgJHIg7AVd7qcrIoL0PTuxjox2JW
         T19afUTKzTUFsK0o5bCwAfzRi8179FTGhO+uTpu5iQFyZi1JQVJ99S3W5FdjIBIO/2Jh
         kP8eY74MtXqwPIt2siF9IA01lIjQUmQvRS4fJy9msQDv/NBwIrt2nRAWZdznjUp8yuul
         mLGaapanH3WUOc3C4oUQyF7ZagC0YBMCVRwqShAN/qHoAB6WxAtoZWaL7ZG5tPiqZaXV
         iojw==
X-Gm-Message-State: AGi0PubhGqoqYr0a/hODqv0Ufkg+nKWGV6Io6DUeZ7nhkegi4iJXExOL
        N7HctB27mLz5DpdlaWI+EYo=
X-Google-Smtp-Source: APiQypKiVW22lJ+zXwmqgSewMfQ0EZe3P5GLY+hzyfn7cDXQkP9nUkwb6vE+mIG8HHsIvmk4wH3uVw==
X-Received: by 2002:a1c:9ad7:: with SMTP id c206mr1976823wme.48.1585811673285;
        Thu, 02 Apr 2020 00:14:33 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id t6sm5729079wma.30.2020.04.02.00.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 00:14:32 -0700 (PDT)
Date:   Thu, 2 Apr 2020 09:14:23 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>,
        Andreas Schaufler <andreas.schaufler@gmx.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v3] mm: hugetlb: optionally allocate gigantic hugepages
 using cma
Message-ID: <20200402071423.GE22681@dhcp22.suse.cz>
References: <20200311220920.2487528-1-guro@fb.com>
 <20200401192553.7f437f150203a5fa044a1f75@linux-foundation.org>
 <20200402024406.GA69473@carbon.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402024406.GA69473@carbon.DHCP.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-04-20 19:44:06, Roman Gushchin wrote:
> On Wed, Apr 01, 2020 at 07:25:53PM -0700, Andrew Morton wrote:
> > On Wed, 11 Mar 2020 15:09:20 -0700 Roman Gushchin <guro@fb.com> wrote:
> > 
> > > At large scale rebooting servers in order to allocate gigantic hugepages
> > > is quite expensive and complex. At the same time keeping some constant
> > > percentage of memory in reserved hugepages even if the workload isn't
> > > using it is a big waste: not all workloads can benefit from using 1 GB
> > > pages.
> > > 
> > > The following solution can solve the problem:
> > > 1) On boot time a dedicated cma area* is reserved. The size is passed
> > >    as a kernel argument.
> > > 2) Run-time allocations of gigantic hugepages are performed using the
> > >    cma allocator and the dedicated cma area
> > > 
> > > In this case gigantic hugepages can be allocated successfully with a
> > > high probability, however the memory isn't completely wasted if nobody
> > > is using 1GB hugepages: it can be used for pagecache, anon memory,
> > > THPs, etc.
> > > 
> > > * On a multi-node machine a per-node cma area is allocated on each node.
> > >   Following gigantic hugetlb allocation are using the first available
> > >   numa node if the mask isn't specified by a user.
> > > 
> > > Usage:
> > > 1) configure the kernel to allocate a cma area for hugetlb allocations:
> > >    pass hugetlb_cma=10G as a kernel argument
> > > 
> > > 2) allocate hugetlb pages as usual, e.g.
> > >    echo 10 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
> > > 
> > > If the option isn't enabled or the allocation of the cma area failed,
> > > the current behavior of the system is preserved.
> > > 
> > > x86 and arm-64 are covered by this patch, other architectures can be
> > > trivially added later.
> > 
> > Lots of review input on v2, but then everyone went quiet ;)
> > 
> > Has everything been addressed?
> 
> I hope so. There is a nice cleanup from Aslan, which can be merged in or
> treated as a separate patch.

With the follow up patche I didn't have any objections. I would prefer
having hugetlb parts folded into the original patch to make the review
easier though. Then I can have a look again. If those patches are going
to be as they are now then no problem with me.
-- 
Michal Hocko
SUSE Labs
