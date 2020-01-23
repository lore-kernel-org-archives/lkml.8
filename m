Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD55EC33CAA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 07:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFBBC2467B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 07:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G52D8YgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgAWH3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 02:29:10 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29902 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725777AbgAWH3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 02:29:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579764549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Swf1miaJ2KibF1rWEltK6FB4Al/NU26D9Z8MNRvgV1o=;
        b=G52D8YgHWIsZhVqHm1vk9HxsUHKk+PSLCx86kvrT+ulwDx9uao78tLlE4H0Hp/Y7hWrNAh
        AFHS8H/y+f9NK242c56VMGje7MbdUqP2wwuL2mSRKFoZeyEXNM6PpAqZQgfRVsh9U8FfKC
        L/gJeqe2ZOZDQ3MAIJjNJOB6cGvH1BY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-Yrx5KV4OMdWYXRDKdw2KFw-1; Thu, 23 Jan 2020 02:29:07 -0500
X-MC-Unique: Yrx5KV4OMdWYXRDKdw2KFw-1
Received: by mail-wr1-f70.google.com with SMTP id t3so1284513wrm.23
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 23:29:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Swf1miaJ2KibF1rWEltK6FB4Al/NU26D9Z8MNRvgV1o=;
        b=kE6F71YnFcu6hW2G/X1MgPRGaq6RRyIpaKJq5EsZbqmrTWOGTLJzeQr7CnOyGsPePX
         ViyAqiEXc9Yx0rVLVKipudwASkLGF8jZwX+p3DKhRSkOltksYQIXAtDKS4e3OOYwugeO
         6XIQyvhmN+grw6jJjZ6tdjxM3DGbBW0ooaFEnjuZvexB+kh7SBBhG6kCFGl9OBd6ruWV
         EA+8WDMdomQ2d4BtpLXlYjaD+vuUw0czCYevhLhzbnayZST5H1vB6fYBN/x9JndmJyQt
         dbADZe1i0rN3HbDOvaOAkS8ZwQ3iSvHNlg9Z1GQsM24kVdj1g2k6OkJuQh9huYOwH8fX
         dmbg==
X-Gm-Message-State: APjAAAV1N1yTMNiyjdxyZLli3Tqf9Sfj7jv1Nuu8StfXgWC6x9h66+yv
        lFnkfCcdGJLMkztabZ0NNjQb9VIka0/jpJ858bdrDXg4HmEv8ddUzmaeTMpIIROQO60pmMYP/cv
        3vJkyCUTEgONtpmWBrmPjrhR/
X-Received: by 2002:adf:fe0e:: with SMTP id n14mr16615705wrr.116.1579764546475;
        Wed, 22 Jan 2020 23:29:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqynoI3k83YYvEjN9Vq70/cg2K/88hFd6YtoeaGnpbIqaxUURJKASpUHj31Q/0KxCIPHp2utJg==
X-Received: by 2002:adf:fe0e:: with SMTP id n14mr16615675wrr.116.1579764546241;
        Wed, 22 Jan 2020 23:29:06 -0800 (PST)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a9sm1509848wmm.15.2020.01.22.23.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 23:29:04 -0800 (PST)
Date:   Thu, 23 Jan 2020 08:29:04 +0100
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>, ktkhai@virtuozzo.com,
        christian.brauner@ubuntu.com, sjpark@amazon.de
Subject: Re: [PATCH v2 2/5] mm: introduce external memory hinting API
Message-ID: <20200123072904.ludphxkxseyg2qli@butterfly.localdomain>
References: <20200116235953.163318-1-minchan@kernel.org>
 <20200116235953.163318-3-minchan@kernel.org>
 <20200117115225.GV19428@dhcp22.suse.cz>
 <20200117155837.bowyjpndfiym6cgs@box>
 <20200117173239.GB140922@google.com>
 <20200117212653.7uftw3lk35oykkmb@box>
 <20200121181113.GE140922@google.com>
 <20200122104424.7gvrfivymjvdous4@butterfly.localdomain>
 <20200123014316.GB249784@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123014316.GB249784@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 05:43:16PM -0800, Minchan Kim wrote:
> > It seems I've overlooked an important piece of this submission: one
> > cannot apply the hint to all the anonymous mapping regardless of address
> > range. For KSM I'd rather either have a possibility to hint all the
> > anonymous mappings, or, as it was suggested previously, be able to iterate
> > over existing mappings using some (fd-based?) API.
> 
> Thing is how you could identify a certan range is better for KSM than
> others from external process?

I think the info like this is kinda available via /proc/pid/smaps. It
lists the ranges and the vmflags. But using it raises 2 concerns: one is
the absence of guarantee the mappings won't change after smaps is read
and the second one is that there's no separate vmflag for marking a vma
as non-meregable (and IIRC from previous attempts on addressing this,
we've already exhausted all the flags on 32-bit arches, so it is not
something that can be trivially addressed).

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer

