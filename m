Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1398C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48092072D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584637322;
	bh=HA+zGVXTUj53EPWx7NhXds29ANBll+sakvZNHLJe4hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GgSnORt41QlSR+c7h0X31gL/1Yw5+PS6uUKZiCLCggkZc/2J7O6MVgUviX+pLOCgV
	 VH+lnEyjXhy1ERgX9XJPcKRLhEDiDVWDzXwBJ3/AhJkqJ9IxACD4pLM4ZnPZTrycdV
	 sZ9AzsNS5ik4DcoaYnggmnnKxHLMaZOj1Fmv3Prk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgCSRCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:02:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38194 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgCSRCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:02:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id l20so3198852wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 10:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PkyumrhKl+IK4umX5VdHbEracK2b1KPBfOOKx0h6L24=;
        b=Hz2SwNjRicfi3IsOucHdPTTPcs71bq1QKYGVXFcckF/S+Ot99gyjuC4fwT6ZKlu0g7
         rsKB8AL254zDMXj1J4TE03QSCflwq9C5xaG2x1Uy+XcSthk+wQ7QO+VStgLEJW3JA4IE
         Ym7LAf8gX+qTH8ioVeRZ/EAdB/cmjSvhoqDGz8SGNUmxd2ROc140yYYZstwCQivD6wnR
         1OVVy0r+JYQsss2Cq0WWzfk6IvIy/ByPp2nox/bGGkqnidkxjY6fyCDCmBfAqpNSdQrl
         LvSFw6o+eWxTS9cGFaTafSRUu3y+YP4ONV3uW75ME6SAUH565gR3JfTupeNN9i/9oQr8
         riCA==
X-Gm-Message-State: ANhLgQ2Q2fVBtDMqIW4LC5rs0p6Y5/FyQDzOzJczluykxM5T4UGh11t9
        yX/UEZKvcYO8kCe1U9f+bVU=
X-Google-Smtp-Source: ADFU+vsychoHHE53awpsghaJtibw5fq6M0ru8rgive+O5/VYOIjamoecJaSqPzGjJCrG1mj9YupJ/Q==
X-Received: by 2002:a1c:bb86:: with SMTP id l128mr4690014wmf.41.1584637319242;
        Thu, 19 Mar 2020 10:01:59 -0700 (PDT)
Received: from localhost (ip-37-188-140-107.eurotel.cz. [37.188.140.107])
        by smtp.gmail.com with ESMTPSA id z4sm3304501wrl.85.2020.03.19.10.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 10:01:58 -0700 (PDT)
Date:   Thu, 19 Mar 2020 18:01:52 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Roman Gushchin <guro@fb.com>, Aslan Bakirov <aslan@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Andreas Schaufler <andreas.schaufler@gmx.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH] mm: hugetlb: fix hugetlb_cma_reserve() if CONFIG_NUMA
 isn't set
Message-ID: <20200319170152.GJ20800@dhcp22.suse.cz>
References: <20200318153424.3202304-1-guro@fb.com>
 <20200318161625.GR21362@dhcp22.suse.cz>
 <20200318175529.GA6263@carbon.dhcp.thefacebook.com>
 <20200319161644.GH20800@dhcp22.suse.cz>
 <3f75f55dc6a9b4dfd3c6ac808c370bfd91d1554a.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f75f55dc6a9b4dfd3c6ac808c370bfd91d1554a.camel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19-03-20 12:56:34, Rik van Riel wrote:
> On Thu, 2020-03-19 at 17:16 +0100, Michal Hocko wrote:
> > 
> > This is not the first time HAVE_MEMBLOCK_NODE_MAP has been
> > problematic.
> > I might be missing something but I really do not get why do we really
> > need it these days. As for !NUMA, I suspect we can make it generate
> > the
> > right thing when !NUMA.
> 
> We're working on a different fix now.
> 
> It looks like cma_declare_contiguous calls memblock_phys_alloc_range,
> which calls memblock_alloc_range_nid, which takes a NUMA node as one
> of its arguments.
> 
> Aslan is looking at simply adding a cma_declare_contiguous_nid, which
> also takes a NUMA node ID as an argument. At that point we can simply
> leave CMA free to allocate from anywhere in each NUMA node, which by
> default already happens from the top down.
> 
> That should be the nicer long term fix to this issue.

Yes, that sounds like a better solution. Not that I would be much
happier to have HAVE_MEMBLOCK_NODE_MAP off the table as well ;)
Ohh well, it will have to remain on my todo list for some longer.
-- 
Michal Hocko
SUSE Labs
