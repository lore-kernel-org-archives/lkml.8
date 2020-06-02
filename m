Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA1DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 23:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D6B120663
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 23:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591139002;
	bh=OXQM4AcVIYEC6obwPWhV7jGyMtCvOlSqtc8ENe1AivU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ky0eFRq+mvVGP0gYvlGrGK2hkLCai+DtweL6XnoXhwxfpMb/N8UQ78ba8CD6Pyf1F
	 nWa7OepY+64eo7bkVNZLQ1JLemf2lWyOSWETv5wxVfiTgK3YZnTr4VB+qKtPIK0Mk6
	 0w4nJJjO+9qoeOk6H8r4JaRqYtB+80opSBeOy38A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgFBXDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 19:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbgFBXDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 19:03:21 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC41DC08C5C1
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 16:03:20 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id j12so102292lfh.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 16:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HuqADZlz/+ixMviXEQWbebgF++rl4PnbtyN63wR082U=;
        b=ciuG9bpzQMkWDQSS32g0Sqw8ILsZfGGanf0utolyh2ANFc5qoInQK+kbfJwaZfxGgE
         GwkzwW/qj3PCIcDNDPxrH8YH8NBu0BUg5bpaCawy2gYyFz9U9rT99tIsJn+O/fH1RPWK
         ICrq+w9hKSk2+OKzKMDcxzJJeWXsBmpyynYrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HuqADZlz/+ixMviXEQWbebgF++rl4PnbtyN63wR082U=;
        b=Ck7izk3pXrdSHs8k6UmQ8kEJx29YLQSCHXgHlcym5rqSk2bkEohv5i2fZQRns5w52d
         HlDW01FBxRddvJCAsAvbgDpAhTvqyah9OEXwClb1K3KUaJEDBZ8lLwVfeu2NFQxES67h
         lTVldSiMAGvQrUbKET0h9VJBtkXSMFdyucjYitYIJKD2Xk5iqL4hL92jr8NUAzwnDesh
         c2hdQbP3zhZP97rrSMWwy68MHyzuEGriobCasb9ncf2r0mHta7rVAtDcwAUCMkqP3uUd
         5Nt4e9ltLHjc2QemXLgAmtDJ3jYqs7FQZTnUPQlt92A4MAxI0InLdtiTZkPllCbu5R/l
         4iQg==
X-Gm-Message-State: AOAM532keMIYOQqnyEfcYbwCqzvJx4Skyutjx6Yq3C3xjv0/MTE9FZHL
        n3IMoelKfZsj1vxkjQf6W5oCF39PIuI=
X-Google-Smtp-Source: ABdhPJw0J2cqT2uUjsR+u2oTFUOgWrbsadN9qfkbMO1yGxPxOwWj68ZzWy11UdcNfhjj5qfcFBH56A==
X-Received: by 2002:ac2:5de1:: with SMTP id z1mr802791lfq.183.1591138998486;
        Tue, 02 Jun 2020 16:03:18 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id f27sm58638ljp.65.2020.06.02.16.03.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 16:03:17 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id e125so101697lfd.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 16:03:17 -0700 (PDT)
X-Received: by 2002:a19:d52:: with SMTP id 79mr829373lfn.125.1591138997106;
 Tue, 02 Jun 2020 16:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <dacd50ff-f674-956b-18cd-9d30e2221b09@kernel.dk>
In-Reply-To: <dacd50ff-f674-956b-18cd-9d30e2221b09@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Jun 2020 16:03:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjuAN_vgUN_TiPtzSpz2NX9XQq7-nJ1u=gHG=EKdRdrkA@mail.gmail.com>
Message-ID: <CAHk-=wjuAN_vgUN_TiPtzSpz2NX9XQq7-nJ1u=gHG=EKdRdrkA@mail.gmail.com>
Subject: Re: [GIT PULL] io_uring updates for 5.8-rc1
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 10:55 AM Jens Axboe <axboe@kernel.dk> wrote:
>
>   git://git.kernel.dk/linux-block.git for-5.8/io_uring-2020-06-01

I'm not sure why pr-tracker-bot didn't like your io_uring pull request.

It replied to your two other pull requests, but not to this one. I'm
not seeing any hugely fundamental differences between this and the two
others..

               Linus
