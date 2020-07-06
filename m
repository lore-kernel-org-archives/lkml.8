Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480FDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 22:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 212782065D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 22:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UiQ5LvHR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgGFWpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 18:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgGFWpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 18:45:39 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8993C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 15:45:39 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id 12so26849488oir.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 15:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m+R4BaRxlZ5SIfaCiQACIiM2M6H+Vaa14qTpDrKg+A0=;
        b=UiQ5LvHRtU8qleTuekrNQgZEdQe4j6dZHNkbO9CyTXc+SfIixtapTt1x9frWS33yYI
         gPyUFSz1o4jkujB/CgGw61h3LyD34nPp9dY4HkK0KMVwU7aWbC963RMNjfk3bNjKqRdX
         ku7jjF4u/r4EEcZNQ5bte+Xm3pEI/en/VjYhrGsRLSAPtS3fBbnuayzuKzqq3Qpht2S9
         fsbxKto+ykYW4IfGn2NW0qvXy7TaVeI0GG4VbMj0YOXEc1i5vuW4uzwsKX+oS2cflRx5
         9t2Zj4agoTp6zZPhSeTG07KTCMj0EnkJUN93At3hsPSFjNG1FsTokzYXVBb1YiAGQh8L
         B9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m+R4BaRxlZ5SIfaCiQACIiM2M6H+Vaa14qTpDrKg+A0=;
        b=K9A5E6mLk1afWzywpmh6+9BfsvGzajiNbtXIgiZE3I8RLyHKe08cg0A4QxvRD3ZZtG
         bSMGo9H0LLpmUA3J/c+YlAnP9fWu9IunbR8RGmt5XNeMrxSnJQHJByeay/ulUVeD7w2u
         vgjYdECopVWWbM3+M8GVCToGuxT2zI6PmCaDwXcNR2RgqZY9GjXzHDFoLQaopITI9YSm
         ylFhHYosZTVmo3K0iI+p6E2Y+zhfQhL1vOpMETIb27Nhqh3PSlb9kN8HAlTNySeGjiD3
         OiG6SvYsQzJKYjEuZjIhKn7JHVWiM1iT+LFb2UIOt062Ji/QoqwEpntZE6d4Qmd9GxPi
         GE7A==
X-Gm-Message-State: AOAM5325e4ZjezSBu9Jhi2fJ9MboWF6aDMS9sCiWwjQPLkerIrBK2wm3
        9JnbYoj0DTsqKyUQEE29nFY4IynG6j+8hnMfD92yMQ==
X-Google-Smtp-Source: ABdhPJwlQiCm2Ys0Qnd7e140yhhsZn0THpYzHOijr2vjH4goeRH3Y1OcNMHeClMqRQtkwRUKuQm8SesnmuC8rrOBqd8=
X-Received: by 2002:aca:a983:: with SMTP id s125mr1236726oie.30.1594075538731;
 Mon, 06 Jul 2020 15:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200521191800.136035-1-saravanak@google.com> <CAGETcx8UGps6bz1YhYcbjCAAXenBuR6XDT0qv5WED5zbyfzNFw@mail.gmail.com>
 <20200529123025.GA1710508@kroah.com> <CAGETcx-QiAysfd7AVV2Y7_GWRd2sj4N=8KwQ_T4fUZ5gVaV8Jw@mail.gmail.com>
In-Reply-To: <CAGETcx-QiAysfd7AVV2Y7_GWRd2sj4N=8KwQ_T4fUZ5gVaV8Jw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 6 Jul 2020 15:45:02 -0700
Message-ID: <CAGETcx94Os7o+xZPSs3vVOQAzGtESAGFXtUNdrEAK9iya05s1w@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] driver core: Add device link related sysfs files
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 8:45 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Fri, May 29, 2020 at 5:30 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > Looks semi-sane, but it's too close to the merge window at the moment
> > for me to take this.  If there's no objections by the time 5.8-rc1 is
> > out, I'll queue it up in my tree for 5.9-rc1.
>
> Another friendly reminder :)

*nudge* *nudge*

-Saravana
