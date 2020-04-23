Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5D2C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDCA120728
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="URkDANZ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgDWNwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728613AbgDWNwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 09:52:08 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71591C08E934
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 06:52:08 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id q10so5598299ile.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 06:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K0kiSpJdpt5NzjR2rc87lSUDGTW+J0mkXavjC7NX4h0=;
        b=URkDANZ18i7l8EMTaDnbsvv9CKA6pBNYrsSuVcozBJdAlFu+Fm88JzkvHTwro//ZXr
         s4VnlFHqww7tuoLrRodMANhPeZYIS3CaqJqrlssyMUUIeKf7badVaQEllGFc3uO/0ovb
         OgW4aNCG2x/2w2XaDfybOCC65I9HMeKWIYYMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K0kiSpJdpt5NzjR2rc87lSUDGTW+J0mkXavjC7NX4h0=;
        b=dL+W5bx0EgnSnooFufSbAnl48k6IHCvnJM/ikNzNVHkCCtusRSE7EDlOKxeF4u41lP
         CV42r8bH6cqhnzXQUPspUbHskWoy87uIDfuMhwF4B3ldDun8JJ2k2GSt5Zlj+yvsLAaU
         MwZnk4Bi4r8LMURzt+yWZfTlRU+6w8CGT/ntsgQ5dlg7czlkg0hjeypYU6oQ5+g186T2
         QjxiQv6mD3wt6d5ey+jFsw/smeL3hE2j8r20qS5PTE0ntBjujSEoF9n6LS+j3+ng6IHO
         Z9tvGsZ7ConswxqHNFTRtXg9omC3KxDvdkoUlkpMiPi5UkajjEZjeHl4WcMuJK4/IR14
         45Jw==
X-Gm-Message-State: AGi0PubLGWE8ClC1iNTMZfO5RJXDbrACJUt6ozaC4KUp86p3BTQNAeQU
        GAeW3BgmOC86ekQl8yqVBQWeEyjrLnQDPK8p1+LblO1N
X-Google-Smtp-Source: APiQypJE+c0suQ0XLykWP3NEC/rlj/rHRfrunXiI2/nKj47l8PHG5g0xmK+UP5b30nEX3sMv8Tw6exgnCYtYG1Q7RoI=
X-Received: by 2002:a92:3509:: with SMTP id c9mr1052016ila.262.1587649927663;
 Thu, 23 Apr 2020 06:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200423044050.162093-1-joel@joelfernandes.org>
 <20200423114008.GB13910@bombadil.infradead.org> <CAEXW_YTwHApBgUBS1-GBUQ4i7iNHde1k5CxVVEqHPQfAV+51HQ@mail.gmail.com>
In-Reply-To: <CAEXW_YTwHApBgUBS1-GBUQ4i7iNHde1k5CxVVEqHPQfAV+51HQ@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 23 Apr 2020 09:51:56 -0400
Message-ID: <CAEXW_YQp3vRoZbsgkhm4PmPaXW+ePdAKV6m5+eXxkGcYjQTLXA@mail.gmail.com>
Subject: Re: [RFC] fs: Use slab constructor to initialize conn objects in fsnotify
To:     Matthew Wilcox <willy@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 9:20 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> There's one improvement (although probably verys small) that the paper mentions:
> Also according to the paper you referenced, the instruction cache is
> what would also benefit. Those spinlock and hlist initialization
> instructions wouldn't cost L1 I-cache footprint for every allocation.

Just to add to my statement: Obviously, this benefit gives diminishing
returns in this code path considering that the allocations here are
infrequent. But I just mentioned it here for completeness sake.

Thanks,

 - Joel
