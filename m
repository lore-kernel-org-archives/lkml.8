Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C7EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EB08206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f34fIThx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgESNGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 09:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgESNGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 09:06:21 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CA5C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 06:06:21 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ci21so1320066pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 06:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Owd8w23sKJnYwtdRMz/02Wxs/sCgJAtWumyomSw5smk=;
        b=f34fIThxjnHezKXAhGE705YOQqEfgg1Pe3wOaxMR7RCVj0cthZk+EC9jbpdJBqpHSo
         BozTDJLjNlnBdlKWY1BZjKOWiw82owIdVTl5jVmUpqNI6fTZyo6tCDGjWrpsNe9YFolo
         14XJF43noJ4TIg8NTOF4Itg4tBO/jfTcHcfLTXDOzhCioofQZjvU5ONpXPtm3s0MOIX/
         Q5ReYVWd8hcdne6wJh5Hzao2x7BCeU3MSuuSJiRyaD1fiputX0duEOZh5Uo6MiS6HKrm
         y3UGZr8J79W/SXE5M+/ieptijy+2ZA9IgRcwXezDvVTz7RaMDoRWyxY7887XahUpKWS1
         AOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Owd8w23sKJnYwtdRMz/02Wxs/sCgJAtWumyomSw5smk=;
        b=J3cAZNPbhUi8D9StX3Zkmm0hCFfqTPuHjWzR3e8VlwB0XM8X6hdSfq1yi2bzU3ym6a
         eQhMpWfHjX8tFqQjM71rTYGF98qd3eARQfr0pPTx1n6OPFO/AUaLeNsHzHgAuDB9cYfn
         On4kOVzsj0B4ti//aQvbKhoK+1XrKkzaJQePiK8NUqdEA553Re3H6WY/oXKhUphkj3ak
         ixqAcrF39SG1o71lfSmQmmPflLtZeW+nMLYJjvYi2UmOVP7TvL10Rgtdz7Tk+oikSt9K
         jQmCV2E6pwIgX32yu6lzvLq2m4XOyxpK5evEfO0Ae/4BsPUey6T98A6pXyQlSS+IlfAN
         g6TA==
X-Gm-Message-State: AOAM532ByJ7dtir1EW4gnR46Jx+jK862dLHJ1Otkf+mfoFL/PAZhF7cn
        UhIfgtIH9OVaP8+2/b7R+TKDDQ==
X-Google-Smtp-Source: ABdhPJzIKPmzADaWHU0zrotDwyfCHRD13T4qawSgU6JudknRCihCje1NeeNyGKpFMY62tMS/fbNdiQ==
X-Received: by 2002:a17:90a:fa95:: with SMTP id cu21mr4884258pjb.106.1589893581072;
        Tue, 19 May 2020 06:06:21 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:202:2523:d194:de3b:636f])
        by smtp.gmail.com with ESMTPSA id gd1sm2299753pjb.14.2020.05.19.06.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 06:06:17 -0700 (PDT)
Date:   Tue, 19 May 2020 06:06:14 -0700
From:   Michel Lespinasse <walken@google.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH v5.5 09/10] mmap locking API: add mmap_assert_locked()
 and mmap_assert_write_locked()
Message-ID: <20200519130614.GC189720@google.com>
References: <20200422001422.232330-1-walken@google.com>
 <20200422001422.232330-11-walken@google.com>
 <20200422015829.GR5820@bombadil.infradead.org>
 <CANN689EnGsJXA8n6JvTryQfkCtARPvtZbkH+9Dd2a4X+fvqU9g@mail.gmail.com>
 <20200423015917.GA13910@bombadil.infradead.org>
 <20200424012612.GA158937@google.com>
 <20200424013858.GB158937@google.com>
 <fcf53ca7-d3a0-93e2-47af-7dd9b32b081a@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcf53ca7-d3a0-93e2-47af-7dd9b32b081a@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 01:01:33PM +0200, Vlastimil Babka wrote:
> On 4/24/20 3:38 AM, Michel Lespinasse wrote:
> > +static inline void mmap_assert_locked(struct mm_struct *mm)
> > +{
> > +	VM_BUG_ON_MM(!lockdep_is_held_type(&mm->mmap_sem, -1), mm);
> > +	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_sem), mm);
> > +}
> > +
> > +static inline void mmap_assert_write_locked(struct mm_struct *mm)
> > +{
> > +	VM_BUG_ON_MM(!lockdep_is_held_type(&mm->mmap_sem, 0), mm);
> > +	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_sem), mm);
> > +}
> 
> I would remove VM_BUG_ON_MM() from the lockdep part. If kernel has lockdep
> enabled, it's already in heavy debugging mode enough so let's just use it and
> not depend on DEBUG_VM. Many sites you convert don't require DEBUG_VM for the
> lockdep checks.
> 
> With that you can also use the standard lockdep_assert_held() and
> lockdep_assert_held_write() wrappers.
> 
> If user has both lockdep and DEBUG_VM enabled, should we run both variants?
> Perhaps lockdep is enough as it's more comprehensive? Your initial v5 version
> was doing that.

Thanks, changed these to lockdep_assert_held() /
lockdep_assert_held_write() as suggested. This misses dumping out the
mm, but I think there is only limited value in that. I did keep the
rwsem_is_locked fallback as people had commented earlier about
getting assertions in the non-lockdep case. If both are enabled...
then we'll get somewhat redundant assertions, but I think that is fine
(better to keep the code simple than try to work around that).

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
