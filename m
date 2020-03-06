Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF0BC10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 21:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828DB20709
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 21:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BUhj7FUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgCFV1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 16:27:54 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36474 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgCFV1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 16:27:54 -0500
Received: by mail-pj1-f65.google.com with SMTP id l41so1630765pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 13:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=C0VzUXVAs0KwQk2ex+LNFdy9kNQT2H0n7ipR3g6Roag=;
        b=BUhj7FUou0TJsOwEx6ONrXB1sekmtZSqO819dYogLqGfctQMqCmMPfrSjPHxFJYlGF
         oh+KLjeD+JQicByp6I4YjvohSnBLI467WClN0CdeJJGtjuRyMlTzzPBsjIfdwj9lUQh4
         hGitKzXxMqv5/s7XHsPifAQJF0G+5iOt0tOw4k9bb6zsQRdYMYb0KNNMuxwbSlqDWhK3
         BmZOG1xEEtSljmfun/Empcz3j8ajeXExAliYTJIXFo3n+rfVjnV+1rjL/voBYJtic3kW
         dt9LlNHd56fUvMOmmZ39p9BDiszfpR7OfczW3u0ydKORQ0i2TJspmOv2PwSfR/E6bREy
         TXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=C0VzUXVAs0KwQk2ex+LNFdy9kNQT2H0n7ipR3g6Roag=;
        b=oZajZthdWFUQH/pHKbp0mh1hr9MxZqqvQOlm7W5oTgoHUQMtWTSFHeYl0w2xficUwi
         bPp8aReB8+Q/5brKNVES6Zn6qciDrAU6YUSywvI9AyHbgI8OQ4JB7NWRy2H4vMBAGEwC
         ctn31XFw2/Jujua4qLJYn4UwUndgRSIN745EJIcksS/S1ICikKRtzaymwyNHyt3CFS8A
         vlTLFLkJ514CSaBFwJxxxAFPO12sGZVHTl/bKnf7cM7OqtZ+qNYTTsrPsKWi8RhSgNLM
         cZbUC/2NAWNLebwcg1gbO2pVI5RrzutKRBwGcgsKfkMRgv0ds3RdrTYXJVFlmF/uigmk
         UbVw==
X-Gm-Message-State: ANhLgQ3VjbqZ/jeRQbBzS7g5Ze1K4zvacR7vDZhcedIBJkrtLgTtDnhI
        nA1CpzrZOEj2H6yfPGsPChmG634j39g=
X-Google-Smtp-Source: ADFU+vtsizdnHi84qmMKsek2u26+wR5vE2A0wbnhG6ZjbIZuDtumLM2crAg46sW5d0vDTU6DCQ8MKw==
X-Received: by 2002:a17:90a:3ee5:: with SMTP id k92mr3974491pjc.81.1583530072599;
        Fri, 06 Mar 2020 13:27:52 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id x3sm10279826pjq.5.2020.03.06.13.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 13:27:51 -0800 (PST)
Date:   Fri, 6 Mar 2020 13:27:51 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Yang Shi <shy828301@gmail.com>
cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jeremy Cline <jcline@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [patch 1/2] mm, shmem: add thp fault alloc and fallback stats
In-Reply-To: <CAHbLzkpgyrFe6L+U=2hoAyc5o8+2K5r8uyMTKx780iR3EiRE5g@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2003061324400.181741@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.2002172139310.152060@chino.kir.corp.google.com> <alpine.DEB.2.21.2002181828070.108053@chino.kir.corp.google.com> <CAHbLzkrJ_=8f8STvZ2GPGH6Arup8cKgGqigj4FQXWpmD-C5wNQ@mail.gmail.com> <alpine.DEB.2.21.2002181942460.155180@chino.kir.corp.google.com>
 <CAHbLzkq20hzLdYM-EMOfWRqPOr+OQF8uq5yWR=Yb6vQY51LKwg@mail.gmail.com> <20200220131202.i77zt3zj53mimrnu@box> <CAHbLzkpgyrFe6L+U=2hoAyc5o8+2K5r8uyMTKx780iR3EiRE5g@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Mar 2020, Yang Shi wrote:

> > > > I think we can choose to either include file allocations into both
> > > > thp_fault_alloc and thp_fault_fallback or we can exclude them from both of
> > > > them.  I don't think we can account for only one of them.
> > >
> > > How's about the 3rd option, adding THP_FILE_FALLBACK.
> >
> > I like this option.
> >
> > Problem with THP_FAULT_* is that shmem_getpage_gfp() is called not only
> > from fault path, but also from syscalls.
> 
> I found another usecase for THP_FILE_FALLBACK. I wanted to measure
> file THP allocation success rate in our uecase. It looks nr_file_alloc
> / (nr_file_alloc + nr_file_fallback) is the most simple way.
> 
> David, are you still working on this patch?
> 

Yes, I have a refresh to send out.  I don't enable CONFIG_FS_DAX but the 
THP_FAULT_FALLBACK there seems somewhat out of place.  It's not 
necessarily within the scope of my patchset but thought I'd mention it if 
someone had strong feelings about whether the DAX cases should be 
separated out as well.
