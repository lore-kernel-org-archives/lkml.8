Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E77BC3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 01:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1856724656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 01:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GMZy5iX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgBSB71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 20:59:27 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43691 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbgBSB70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 20:59:26 -0500
Received: by mail-pg1-f196.google.com with SMTP id u12so11534812pgb.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 17:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=TZ+7kRkf1Lb1X9EkNUXTuLGtV52JPBS+BiH82cZ97uE=;
        b=GMZy5iX2FbvSR0qa5UWp68F42ojx9YlQxKtTgkrUEsiPsiOTsgLrVojcR12Pf6FHlV
         A1aT/CgO/luy/th87b66oa3WKnLZePEw0nQorqhPingnsgI9jvQoPgIeu7M+JxbNzugg
         cMRm8ESMLQMh5CxS3BOb2jjTISrjaYyWGA28/9nx2LGyT/I16zrpMKK1HsG20TLz0ezC
         +MEbCHc6YRKNYebsZ6Tw7G9vOG1JeRofS4NrpVWHBU9bTeQhSqhmFgX7Dg4o48Mc5KcC
         vfSIE4bxxBj8mfgL64t+PlyjiptWoqpUiw2aHcElM+xXRqB9+rBt544+0OLVOQr9KLod
         Eepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=TZ+7kRkf1Lb1X9EkNUXTuLGtV52JPBS+BiH82cZ97uE=;
        b=Eh0nJ3HdzyW17n7bYc928zaAnvi5IlEtoVPJC2lQbdaGIVdb+n3dLsWiN2zgyXjE/J
         qrJqJ53VKCy1pZq+BzM1+G6DLyfsCIFPkhxQbBSDA0VwS6kDX5sh+jDtWJheXsRLPPIo
         HrTRCIM5lAzqdT1wqXKwn38mxMgO1XQYRlU5fG7nqlPDOEq8KYFXegMMiXNDej3sUvuQ
         Mf9Y+tHc0RWZEsrTKsgVgiaqq46NitX4RuwR8UGZZuJNAJXuckpK0ZX/ztgd4JPoOUBn
         01IsPruK+/U+RfeKCw3LlzUxQzgFS9jAQ6ZsLhce8PUGEh2KZ69/jxXibVtLo808w/XK
         bLkw==
X-Gm-Message-State: APjAAAUQFxAH1I+r6cqUTzOp3Eq+uPjB/xGyehIhp+mQct1GRmQ2ZjJE
        7brYOrowk9YHsgfmOy9CpqW7jg==
X-Google-Smtp-Source: APXvYqw+V0VAtQKn0eaWJa755lGgYuTurTfSIJy5uTIQetEteVKiiY7hKxJ3kAsxkZ2gWHp2GxOq9w==
X-Received: by 2002:a63:aa07:: with SMTP id e7mr25757088pgf.90.1582077565568;
        Tue, 18 Feb 2020 17:59:25 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id r145sm306132pfr.5.2020.02.18.17.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 17:59:24 -0800 (PST)
Date:   Tue, 18 Feb 2020 17:59:24 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jeremy Cline <jcline@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, thp: track fallbacks due to failed memcg charges
 separately
In-Reply-To: <20200218082632.kn5ouiditzx5h2iq@box>
Message-ID: <alpine.DEB.2.21.2002181758480.108053@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.2002172139310.152060@chino.kir.corp.google.com> <20200218082632.kn5ouiditzx5h2iq@box>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020, Kirill A. Shutemov wrote:

> On Mon, Feb 17, 2020 at 09:41:40PM -0800, David Rientjes wrote:
> > The thp_fault_fallback stat in either /proc/vmstat is incremented if 
> > either the hugepage allocation fails through the page allocator or the 
> > hugepage charge fails through mem cgroup.
> > 
> > This patch leaves this field untouched but adds a new field,
> > thp_fault_fallback_charge, which is incremented only when the mem cgroup
> > charge fails.
> > 
> > This distinguishes between faults that want to be backed by hugepages but
> > fail due to fragmentation (or low memory conditions) and those that fail
> > due to mem cgroup limits.  That can be used to determine the impact of 
> > fragmentation on the system by excluding faults that failed due to memcg 
> > usage.
> > 
> > Signed-off-by: David Rientjes <rientjes@google.com>
> 
> The patch looks good to me, but I noticed that we miss THP_FAULT_FALLBACK
> (and THP_FAULT_FALLBACK_CHARGE) accounting in shmem_getpage_gfp().
> 
> Could you fix this while you are there?

Sure, I'll add it as a predecessor and also count THP_FAULT_ALLOC for 
consistency.
