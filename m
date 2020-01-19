Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D431AC33CAF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 21:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A350F206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 21:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Axgh4EC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgASV5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 16:57:13 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177]:37277 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgASV5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 16:57:12 -0500
Received: by mail-pl1-f177.google.com with SMTP id c23so12296167plz.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 13:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=sgjV84nCEnzbwj6ezGkciS3O1efN4WtDGoU2lYCK0MU=;
        b=Axgh4EC1lgaKyEUskSo9a2kogl5Y/r5vOb6buWTNDyhkn98nuVedRGsmbC/xUWQWat
         sRx+bP5NRPuhIMUgBnP/fRzRBx/qEtZ2yFM9NJUuFpTZFQ7/p37JY5L9xzWKZkmSdbmq
         PuLVN5Lkv/FImE7NbF8HZVgGp8KsD9bVtDdlRafFGV+SajGPXYDheDRjIRgsKw2hMoel
         nFJd/CAulgfdvQrVowLUkSLT/G0/N0VJBr3OnP+MVeezDBogwytTa3pf7FF7Qjb8KjNG
         c6WbtPUpR9PKuoePrxk8EOpI31EFU/08Vws4zzHyqdchuOX9mHMA4IZKgoREZwOQZ3Hf
         E9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=sgjV84nCEnzbwj6ezGkciS3O1efN4WtDGoU2lYCK0MU=;
        b=ONzOilTYUw9853S2eOFtmFnAsFuEHWlW9CDLNpOgfNn/VNXw0G2JtVjEl/kK/85uz6
         RSfuMCCgw0LupxSoBUYsoYHjuDc1M8fJpCKlMLXlIabpsfILv2bJYSJ+kGEwQ5vEtK0L
         7sVHS2f1ckmhRk/B5HxMShAJerpaNI9iEgNKeOPtptTPz6ZVoaCzMzxPrOmtLdZs4Yf5
         eZ9OAOAREObAJADgot1IWczypomkp0vQvXIdkRoHFP/hZHjE5lYjbW0hw9uckL0uvNsy
         KgH+WlgP955b3C3xO0gJ5aX9LETh4grAi/DJy3aDi5OoszQgypZwLblxKpxq7H3Y+aOD
         72zQ==
X-Gm-Message-State: APjAAAUm504cydGX7jiNQ/0o36uAflKUg3nGkpyFER11JGmj38kXlo21
        bxq2h3BBaUBjC8LZ8YHsDcNefYPnSe8=
X-Google-Smtp-Source: APXvYqwCuHGQaqO8riKKlkERDqzLF6h9yeD1unPBi3A8sA3J85TXPrAU4vefgWFzrtcBfUv3/XLOGg==
X-Received: by 2002:a17:902:900a:: with SMTP id a10mr11526249plp.191.1579471031885;
        Sun, 19 Jan 2020 13:57:11 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id c68sm36886806pfc.156.2020.01.19.13.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 13:57:11 -0800 (PST)
Date:   Sun, 19 Jan 2020 13:57:10 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch v2] mm, thp: fix defrag setting if newline is not used
In-Reply-To: <20200118170445.370d908ce29f42068390addb@linux-foundation.org>
Message-ID: <alpine.DEB.2.21.2001191351570.43388@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.2001141757490.108121@chino.kir.corp.google.com> <20200116191609.3972fd5301cf364a27381923@linux-foundation.org> <025511aa-4721-2edb-d658-78d6368a9101@suse.cz> <alpine.DEB.2.21.2001170136280.20618@chino.kir.corp.google.com>
 <a3c269a7-ff41-ee7c-9041-ee06e50c5a10@suse.cz> <alpine.DEB.2.21.2001171411020.56385@chino.kir.corp.google.com> <20200118170445.370d908ce29f42068390addb@linux-foundation.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jan 2020, Andrew Morton wrote:

> > If thp defrag setting "defer" is used and a newline is *not* used when
> > writing to the sysfs file, this is interpreted as the "defer+madvise"
> > option.
> > 
> > This is because we do prefix matching and if five characters are written
> > without a newline, the current code ends up comparing to the first five
> > bytes of the "defer+madvise" option and using that instead.
> > 
> > Use the more appropriate sysfs_streq() that handles the trailing newline
> > for us.  Since this doubles as a nice cleanup, do it in enabled_store()
> > as well.
> 
> I can't really I really understand this prefix-matching thing that
> we're taking away.  Documentation/admin-guide/mm/transhuge.rst doesn't
> appear to mention it.  Could we please add a paragraph to the changelog
> to spell all this out.  Bonus points for formally describing the
> behaviour which we're removing!
> 

The current implementation relies on prefix matching: the number of bytes 
compared is either the number of bytes written or the length of the option 
being compared.  With a newline, "defer\n" does not match 
"defer+"madvise"; without a newline, however, "defer" is considered to 
match "defer+madvise" (prefix matching is only comparing the first five 
bytes).  End result is that writing "defer" is broken unless it has an 
additional trailing character.

This means that writing "madv" in the past would match and set "madvise".  
With strict checking, that no longer is the case but it is unlikely 
anybody is currently doing this.
