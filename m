Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85394C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 576EB22CA1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595346585;
	bh=clfDWnriezK8dpSx5v4C5wOuwdD1NHS0p4s3Y5u8cGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oYDgD++dpLjgf7f1M9PgoKnBxEoetI/B+QWZZ4nvziE7qgurUAFJOc/DhAsTuCqiS
	 3H42wqJFrLaAXdS83B+aPXMIyQB1tQIEtgz/EB82WiYZCH79uDFLyMJgu88DFjBNcl
	 c/yB9dd8eJFmFHKLTz1MODUkDRh4CfckBlDf/N7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbgGUPtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 11:49:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44439 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGUPtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:49:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id b6so21671397wrs.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 08:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xtdmt+rnuzEMChFrWyb/dtdXZAk0jWQrZ/8hX8rAe9g=;
        b=muZyO22wnVJZAEeN0JzpPU5MgnxpN6q9Qmf7eJNFJkxhPxPyJeoSo41bXMGA+hEwpN
         Q/PPPRYhjf1XzZjCuhrsO9bxMYEhIIXW+CjHiVQhoSSQ+Mm0jnmE0p3KmBBhJRNrbrh7
         MbFCviTs2qbdNEu5MYlS9gPbpwVL7ZFqTRezRDgSv4dbGjxkKghSwBGoQq0SSa+wVcMc
         Twiowfuyay4tdPUVddb6FmPo3OQXQlKfvEtWLW+D5egO38MrmUVO9D8saL6KIwlMmoyj
         IOjVE/VzENtTfZxqnNSUnvGZrIX5wzP4Q5NwjQpeoFiU/Sp9fsZ9bzBXLVmMc91f2WbK
         hkTA==
X-Gm-Message-State: AOAM532fH7JEGGZCIYdfoWJwtpxXYbxuvM+JodV4GRZzcUMyoCja3ZiN
        T5ODRx9xyIpc1cAiqJSHPjg=
X-Google-Smtp-Source: ABdhPJxy4F2wodkJo49QxNFn3BgSfG8D2cN6gDXk89JOUVRjjB4/hpsD+Uemj9tul5q4R9wlsOVHFg==
X-Received: by 2002:a5d:6a8d:: with SMTP id s13mr19257556wru.201.1595346581091;
        Tue, 21 Jul 2020 08:49:41 -0700 (PDT)
Received: from localhost (ip-37-188-169-187.eurotel.cz. [37.188.169.187])
        by smtp.gmail.com with ESMTPSA id 138sm4050398wmb.1.2020.07.21.08.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 08:49:40 -0700 (PDT)
Date:   Tue, 21 Jul 2020 17:49:39 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
Message-ID: <20200721154939.GO4061@dhcp22.suse.cz>
References: <20200721063258.17140-1-mhocko@kernel.org>
 <CAHk-=whewL14RgwLZTXcNAnrDPt0H+sRJS6iDq0oGb6zwaBMxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whewL14RgwLZTXcNAnrDPt0H+sRJS6iDq0oGb6zwaBMxg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-07-20 08:33:33, Linus Torvalds wrote:
> On Mon, Jul 20, 2020 at 11:33 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > The lockup is in page_unlock in do_read_fault and I suspect that this is
> > yet another effect of a very long waitqueue chain which has been
> > addresses by 11a19c7b099f ("sched/wait: Introduce wakeup boomark in
> > wake_up_page_bit") previously.
> 
> Hmm.
> 
> I do not believe that you can actually get to the point where you have
> a million waiters and it takes 20+ seconds to wake everybody up.

I was really suprised as well!

> More likely, it's actually *caused* by that commit 11a19c7b099f, and
> what might be happening is that other CPU's are just adding new
> waiters to the list *while* we're waking things up, because somebody
> else already got the page lock again.
> 
> Humor me.. Does something like this work instead? It's
> whitespace-damaged because of just a cut-and-paste, but it's entirely
> untested, and I haven't really thought about any memory ordering
> issues, but I think it's ok.
> 
> The logic is that anybody who called wake_up_page_bit() _must_ have
> cleared that bit before that. So if we ever see it set again (and
> memory ordering doesn't matter), then clearly somebody else got access
> to the page bit (whichever it was), and we should not
> 
>  (a) waste time waking up people who can't get the bit anyway
> 
>  (b) be in a  livelock where other CPU's continually add themselves to
> the wait queue because somebody else got the bit.
> 
> and it's that (b) case that I think happens for you.
> 
> NOTE! Totally UNTESTED patch follows. I think it's good, but maybe
> somebody sees some problem with this approach?

I can ask them to give it a try.

-- 
Michal Hocko
SUSE Labs
