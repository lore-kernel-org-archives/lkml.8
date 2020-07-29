Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076D7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 05:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D10442070B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 05:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20150623.gappssmtp.com header.i=@draconx-ca.20150623.gappssmtp.com header.b="QvVLsteW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgG2Fac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 01:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgG2Fab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 01:30:31 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541DFC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 22:30:30 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id g6so11875750ybo.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 22:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UM1kYq2irrlxJjqvtpleLv5gWB5MEHXw+xU5EXyDcho=;
        b=QvVLsteWDq/bcm+aRVZrp/HPm2+8TlviBBzn6js/05c2LZtlpQY6PLc+RJsT5rZKVn
         br8+9hTY1iPjSfIxTOcFqM3hI+P8M7fj5DI2TcWFyLNKgg1qjMrOcRtGniotCx9fkMBH
         Xxv3jbqH3sWQyQJMg7CF/5r7drllem0TgmScyMT/wXga0hbFyz+WgBccO4y6tKpHdcrA
         uYtloxYQ87vghbl6aNBy9c++bLAFSp3F4HSke18EMJWRCrmS0oy8V2NJvxtQRHYOmzpA
         XaxNUbAQ8rSybLoBSXIRl8fzfVBTdCxRyBsPeMBi1aPaFIoNafR2c87VntjdovyUcCSI
         096A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UM1kYq2irrlxJjqvtpleLv5gWB5MEHXw+xU5EXyDcho=;
        b=jzGgxMD8BqITIdIoq88jto6Rg3Xf1oiCUXDp4huU8de7RER5RW52wFHFd1mQFTns7F
         /xrwCBhHHkjqIfWYiPXSRTISydk7JOGMNDmXMfjTYa/rRAUjraac0OpBiBlDrcUMM7je
         w5XekXRTkfpPw9GcBuVKclPH1HZD9n3YqrQldg6/Nb8Ld1nlxYZ1sSiXbGcKd9O1yOMw
         neo+3F2E7E11HGvgYWzENgrXcu4PuDX0rVV33gYeXkWVaw6YlnNousVSS9BCNf9JQpo4
         BYCLYdgVZtEAR4ZFzJfNuYVeMJTYwgrS9zzTT+vOh5xe2kQ2EC1jEQUQv35GG/jz3hbH
         faew==
X-Gm-Message-State: AOAM533QcziiFeV1s47O/uAbKz6FYMSFYZeJObO/lQlaNmPscjxa4fiM
        I/HRrV5klpMMd96FfqTiNt6h1JzP1Xi9wrlcsQJPHQ==
X-Google-Smtp-Source: ABdhPJwMiRPJlZu73WFTEwZfU6Zfx1DgVK1nD4W414uJDel/riVrRnXW3vqpYLIafNu8UZ2e5C71fPmg+j6u4sm1YfU=
X-Received: by 2002:a25:3411:: with SMTP id b17mr7330506yba.279.1596000629113;
 Tue, 28 Jul 2020 22:30:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:9b83:0:0:0:0:0 with HTTP; Tue, 28 Jul 2020 22:30:28
 -0700 (PDT)
X-Originating-IP: [24.53.240.163]
In-Reply-To: <CAPM=9twPbHvuu7fOXr+nSuB5GRy1PgY1PR6h5HDvzgUo=bobQQ@mail.gmail.com>
References: <20200729050403.jwbgdmvmc3ajdnem@atlas.draconx.ca> <CAPM=9twPbHvuu7fOXr+nSuB5GRy1PgY1PR6h5HDvzgUo=bobQQ@mail.gmail.com>
From:   Nick Bowler <nbowler@draconx.ca>
Date:   Wed, 29 Jul 2020 01:30:28 -0400
Message-ID: <CADyTPEytPcj6C6uDuHKAiKsWTLFYMuZvnYZoYQvdoggu7N+MQQ@mail.gmail.com>
Subject: Re: PROBLEM: 5.8-rc7 no video output with nouveau on NV36 (regression)
To:     Dave Airlie <airlied@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        James Jones <jajones@nvidia.com>,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-29, Dave Airlie <airlied@gmail.com> wrote:
> On Wed, 29 Jul 2020 at 15:05, Nick Bowler <nbowler@draconx.ca> wrote:
>>
>> Hi,
>>
>> After installing Linux 5.8-rc7 I seem to get no video output on my
>> NV36 card once the nouveau module is loaded.  The display (connected
>> to the digital output) simply reports "No Signal".
>>
>> I bisected to the following commit, and reverting this commit on
>> top of 5.8-rc7 appears to correct the issue.
>
> Can you test the drm fixes pull I just sent to Linus
>
> https://patchwork.freedesktop.org/patch/381225/

Yes, pulling this seems to fix things.

Thanks,
  Nick
