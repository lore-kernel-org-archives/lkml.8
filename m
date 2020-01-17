Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F7AC33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FC820730
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="flAhPTGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgAQJoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 04:44:02 -0500
Received: from mail-pj1-f52.google.com ([209.85.216.52]:32984 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbgAQJoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:44:01 -0500
Received: by mail-pj1-f52.google.com with SMTP id u63so4076923pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 01:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=00G05jNcrM2B7qg+tGmrQSVLLyzjItlORoc+42XWNYc=;
        b=flAhPTGxlrlifEOZ+Tn9hOXazKmSkeBxFMkQr7zEaZUkHgvdnuNsmY0fYyogJXEd/b
         k+WQoNlGHUsVjpAWDRB/Ru69KzFJjaHKiJ0LBpYlqMllOy9ImLsOG8RLWkGG8jl5NTKw
         tfuEheB6PhYV7Kd+eLr1zs1HDMQ1hkFhozggktUGVuvMWLx0IAFD9vtVZ3alEY01ztXH
         CUCjNUHUIehXaqZCk61UUImcuiv9FODEFzHCcetLk7bbyVkZikDBKRzYgGjP4iNN0YTO
         pcDX1TzP+wd16+CA+zSn2nIEByurgz6daAUfY5R660xi6M73yTwnSFDp1eUhSaHztJ/Z
         ejbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=00G05jNcrM2B7qg+tGmrQSVLLyzjItlORoc+42XWNYc=;
        b=QCNSqPOm4Z83NusyN5OnkHH69ntYn5H/r8f+pHRjPwAQOKbjLPzfIiRVVjUBTMKXR6
         hJ2EQltjIwAMa6rU4E+KQBLjd6oSgZMW4H+4+61fNI+pukT7fe3ZLP1pMZEpBcVn0XP7
         khm2mMaIuJkr8WAzKfZA0ximuIucIaFwx4/pzEEWKipqimpr9LGQEJP1vauRAJOs+Jt2
         LmID8MkDHKPZQdMacHi6hnZ7A5Et6AfXCJv9PY4wSQH6UV7EMOfudxIN1Aupc6d8i/PM
         46cCY0FYSYAKc1iuurlW5S+h9zgpbUCH+k4EsBCkHLV6NZrh2qReaVYIR5CQ1HCyem2M
         WpTg==
X-Gm-Message-State: APjAAAWOtISfYNoYPshcGgcBQVEep+sCuvx9/X1vMxzdatABjLkh/Co6
        /hn7ywMceIC3H2vk5ggwGtttGBveukk=
X-Google-Smtp-Source: APXvYqw8Dp4mZAayb4IID1REqC1qp5S0dGgoKB/YWhMp7YhOVOoG6Gu5U+T5/Nnkhnoe4g/ylicm0Q==
X-Received: by 2002:a17:902:321:: with SMTP id 30mr38684650pld.130.1579254240671;
        Fri, 17 Jan 2020 01:44:00 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id x132sm28646025pfc.148.2020.01.17.01.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 01:44:00 -0800 (PST)
Date:   Fri, 17 Jan 2020 01:43:59 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm, thp: fix defrag setting if newline is not used
In-Reply-To: <025511aa-4721-2edb-d658-78d6368a9101@suse.cz>
Message-ID: <alpine.DEB.2.21.2001170136280.20618@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.2001141757490.108121@chino.kir.corp.google.com> <20200116191609.3972fd5301cf364a27381923@linux-foundation.org> <025511aa-4721-2edb-d658-78d6368a9101@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2020, Vlastimil Babka wrote:

> >> If thp defrag setting "defer" is used and a newline is *not* used when
> >> writing to the sysfs file, this is interpreted as the "defer+madvise"
> >> option.
> >>
> >> This is because we do prefix matching and if five characters are written
> >> without a newline, the current code ends up comparing to the first five
> >> bytes of the "defer+madvise" option and using that instead.
> >>
> >> Find the length of what the user is writing and use that to guide our
> >> decision on which string comparison to do.
> > 
> > Gee, why is this code so complicated?  Can't we just do
> > 
> > 	if (sysfs_streq(buf, "always")) {
> > 		...
> > 	} else if sysfs_streq(buf, "defer+madvise")) {
> > 		...
> > 	}
> > 	...
> 
> Yeah, if we knew this existed :)
> 
> We would lose the prefix matching but hopefully nobody will complain.
> 

I tested Vlastimil's patch and it works as intended so I was about to 
modify the changelog and send his patch and ask for a sign-off line 
because I think I agree the *partial* prefix matching has ~0.1% chance of 
breaking userspace and that 0.1% chance outweighs my desire to make the 
code consistent for all options.

But if userspace were broken by this, then at least it was already broken 
for "defer" depending on newline vs no newline.  (What we do know is that 
nobody has used "defer" for the past couple years without a newline :).

If nobody objects, I'll test and send Andrew's version with the changelog 
because I think we all agree the risk of breakage here is very minimal and 
actually fixes the case for defer.  
