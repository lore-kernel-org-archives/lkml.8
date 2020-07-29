Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB6FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 05:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4DB32074B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 05:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNTCiceL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgG2FHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 01:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgG2FHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 01:07:55 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD804C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 22:07:54 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id g11so11168033ejr.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 22:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=17rgfvEqWRRLKn9YQbbbiT3iU7imxRyw7YqATsKhtFo=;
        b=KNTCiceL1uzKIM2SCntISrAyD2hg5y6BndIU6/klvYBW+Qxkme/gTkC3QOYnpMIp5U
         lJgnl1IMXoNJEJEHd01uN5pexk7koNI0Y+22c8o46aq3bqrCK8ySXvoTdH6wOGjEMCN0
         3m9EOlW09paURv9SGfAmPY/f6q1w716J0KDWpAM5wBrl9IcgZPaYVaJL0znZ2rDOma/Q
         bcKdfA0Ma4LTsZJxcWtjYNZLSWaiKQenRglu1jTKWtDapIUGY74LyzXWtsOsMdiJZO83
         heJtE5efiEjh8AsqyfRKXDs2XQ5H7XL5QrE2NmJQ8/N6w0hVK3n3YAVgE4pu35NXRN4M
         4bVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=17rgfvEqWRRLKn9YQbbbiT3iU7imxRyw7YqATsKhtFo=;
        b=Lk4+Lq/gtGr71VAJcgA9vcB+dkKNVV53Go6EXrJRMuOarIDHaFctBfEnLOCFBxsVjp
         UjdL4i0jKTfIBVzJc+aGw1Ba08FmkaL7HtaVQLdMjSL+EWclLtQLSOkDtI6I3kxQoSPo
         Z2GGTR0Z/BbSnzWIW1CkDMY5o5Re28VI0FCuydqNBhrRQK2YmWuZhIx/WvcLspvQObVz
         qVVW+9f3fLEeokqPhb3rq6F0QUAfiTTvSn32qinmqxQw+71gf7qFSjZ0EMOVHWgCMuWt
         xFeQgdr+ox8pTZJDqqE0NFLxKq1+y/5gkVJZ6ymh4HJ0+xaMWmQBobDht1rAupD7fru/
         Ywhg==
X-Gm-Message-State: AOAM532ZgFr8a8TzblEr1464bTT9OYl4RMo1VO/AoZQDzF3vKJA3DZcB
        JvP9N9HgWBhkSzVMOIN726qZadyLYz3soJFgt3g=
X-Google-Smtp-Source: ABdhPJxKWHL44O+eQP6IhWRR6v5fi+xjn3BDG/U9J2cVA4fj6g9WSLaeCX3tn089JoOOjSo2F8MaFWutKFLLOZqwRZE=
X-Received: by 2002:a17:906:1104:: with SMTP id h4mr19427246eja.456.1595999273441;
 Tue, 28 Jul 2020 22:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200729050403.jwbgdmvmc3ajdnem@atlas.draconx.ca>
In-Reply-To: <20200729050403.jwbgdmvmc3ajdnem@atlas.draconx.ca>
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 29 Jul 2020 15:07:42 +1000
Message-ID: <CAPM=9twPbHvuu7fOXr+nSuB5GRy1PgY1PR6h5HDvzgUo=bobQQ@mail.gmail.com>
Subject: Re: PROBLEM: 5.8-rc7 no video output with nouveau on NV36 (regression)
To:     Nick Bowler <nbowler@draconx.ca>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        James Jones <jajones@nvidia.com>,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jul 2020 at 15:05, Nick Bowler <nbowler@draconx.ca> wrote:
>
> Hi,
>
> After installing Linux 5.8-rc7 I seem to get no video output on my
> NV36 card once the nouveau module is loaded.  The display (connected
> to the digital output) simply reports "No Signal".
>
> I bisected to the following commit, and reverting this commit on
> top of 5.8-rc7 appears to correct the issue.

Can you test the drm fixes pull I just sent to Linus

https://patchwork.freedesktop.org/patch/381225/

Otherwise we are awaiting a fix from James for one other issue, should
be here today/tomorrow.

Dave.
