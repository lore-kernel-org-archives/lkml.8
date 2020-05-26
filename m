Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82FFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BA3F20888
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="nbd8L+Wg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391281AbgEZVYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 17:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389914AbgEZVYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 17:24:07 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F34BC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:24:06 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x12so17461373qts.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TeV4Ee0rJbTsY7d9AFmITz3Jb7JZiolk7a5WrjoAzbk=;
        b=nbd8L+WgUcdz7k1REuKHKpHXR3rF9nc4a8g25dlTLgIeJAIwAG7dedgCu0mWsKv1CI
         +UEfuGSTs/3U5TgfvK/pZH1kY806eHNfFcWvSYHAcCGpLDQSRkmxnUILpQyP50c8uXeo
         ppdnnu9QPBdjsMqh3WTWkWFBJ7OkXsBzLjonDqeYFJB92nMXXuy4B7qq//j9YZ9TTCHr
         oU7OgYctIdtg40TxdB+vyx3CVzG3dMVCLXrYoQUc0IpSMkLl99G/SaHnZ/12N9eBdslz
         viVMJB1rh3wSU3OJalsh2sGpe4Uj8CI1YBQmAJLIwW/TaUhwUO4XW/mqZs21fnCSnQJa
         RH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TeV4Ee0rJbTsY7d9AFmITz3Jb7JZiolk7a5WrjoAzbk=;
        b=WGG+DJDx8fg71M11tnPEO83BEcAvG/jhYi2Ut1a7mL3Gr3OiU5+hnQ9yA5e0nrrt4i
         TyGK+ftxFVK63w+TMRxC6KgtR3gZmn0b/PcACuQPXxRGwY3K5zhhI3xDQtbifQMYdCye
         nlREUcJ1oj+x4+9dlWhlro0sGiUUD6gEw/eu6E7bTOVWhynVHO545L6slDEhxfbNgJ2X
         7I5JYY0lsgfAvfs2l85grSusnES16dWi/he4kxn3V1zIIwQSLYzCNdPLRxrU5tytR/fV
         bxXWaP3Wf3CD2ujx84SOBUWo90/HNzRKdE4XvyFddWBbQt+P/KR9yeEu63MBqIMmDZYa
         9cQQ==
X-Gm-Message-State: AOAM532OR+rK6pTuldZ7blJe4g3ygzbADedzmCU4CzAidseAJXIPz+9x
        xmKMJvoMz9IH1gmqJhSoqPWQBQ==
X-Google-Smtp-Source: ABdhPJyLt9Rebj7UujAonnAzzNJnNr43WIRcy0A1ROWCNy5yqE7jYiG9nWC4BQO342nxhcF5AbB3ig==
X-Received: by 2002:ac8:6d11:: with SMTP id o17mr928314qtt.266.1590528245300;
        Tue, 26 May 2020 14:24:05 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id h77sm748154qke.37.2020.05.26.14.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 14:24:04 -0700 (PDT)
Date:   Tue, 26 May 2020 17:24:02 -0400
From:   Qian Cai <cai@lca.pw>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/lockdep: Increase MAX_LOCKDEP_ENTRIES by half
Message-ID: <20200526212402.GH991@lca.pw>
References: <20200526174349.8312-1-longman@redhat.com>
 <20200526185850.GE991@lca.pw>
 <20200526195630.GF325280@hirez.programming.kicks-ass.net>
 <b88d5379-687d-8c14-40ae-221c79500996@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b88d5379-687d-8c14-40ae-221c79500996@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 04:30:58PM -0400, Waiman Long wrote:
> On 5/26/20 3:56 PM, Peter Zijlstra wrote:
> > On Tue, May 26, 2020 at 02:58:50PM -0400, Qian Cai wrote:
> > 
> > > I still don't understand why reading all sysfs files on this system
> > > could increase that much, but here is the lockdep file after
> > > running sysfs read to see if you could spot anything obviously,
> > > 
> > > https://cailca.github.io/files/lockdep.txt
> > 00000000f011a2a5 OPS:      20 FD:   45 BD:    1 .+.+: kn->active#834
> > 
> > is that somewhere near the number of CPUs you have?
> > 
> > Anyway, there's very long "kn->active#..." chains in there, which seems
> > to suggest some annotation is all sorts of buggered.
> > 
> It is actually one active lock per instance of the kerfs_node structures.
> That means more than 800 sysfs files are accessed in some way. As we could
> have much more than 800 sysfs files in the system, we could easily overwhelm
> the lockdep tables if we really try to access all of them.

Yes, there are a lot of those on large systems, NUMA, percpu, slab etc.
Isn't it better to extend MAX_LOCKDEP_ENTRIES dynamically? There are
plenty of memory over there.
