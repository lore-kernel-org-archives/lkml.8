Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C05DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14D5C2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrIvR5rr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgFJQXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbgFJQXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 12:23:40 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20115C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 09:23:40 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id t9so2840254ioj.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 09:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=8r6t1BgudKZLnrzWDpOZuoosZv5egz7G/h3K6qL0zdU=;
        b=YrIvR5rrFXtlg88x4MMln70QoUlWBkpdnXvBWenUitbjr8xx15mpu6nwcUma4H1QyI
         Waf1qa8+XJQKR0ahNkB8Z3TI8qcqgmTF/va7hesQnlLQwiTcOBptzSt9JtAHxCIu444z
         wIU8qwsQKdcwKhmJM3HvMJgpy/tEfRHHlVf5+Mghqo+Hy3HwiS3tN1kU9iOxiKSlCC2P
         H9O2phEdV1KIj2+/yFeVNZUKlYxxR1C7CPYSK3a+7+2EobxcZAnIfmkHYIiXDEEqSK/v
         /x/wLzB21S1iZcOfJefqmqbiThzyW7QZJj/664FT4CSEjDZ89XLr99AZ3DT/3HF3IHrl
         oqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=8r6t1BgudKZLnrzWDpOZuoosZv5egz7G/h3K6qL0zdU=;
        b=gSI9qMdTHPnatPczLP9FpdWedi+9rsnRcIzCUwxgsNiKXE8Z1Y8e4kNRd/ImyYthYE
         SPZdRVTnmKuNcFBh8jpnvvamLgjSAl2Q8PBYg2eeoSupL4UVZAMRXwTib9ZzQA8BxKML
         AhhI4V/xRm/ESnnxiSG9z5WmKIuqTgCT5a4yExKFLcbDHLJJc397xnlqt4DKDkdAMLtr
         hrRD0KhJTkL0SLoxs0/H9Mw2hb3TanyCJNacdyYXgITSMO7hzLTBoTnED6bUfOAbUw0A
         VMPRHCkqKaUG4idzR3oyxAlpZ1w6gRuZLOTFkMNj0NjhapaywOLy9L/Ev8DMTjSjGgtj
         fiVw==
X-Gm-Message-State: AOAM5313RodLAnJ0GZfV6O0i4JCOihOP2IESRXm5dz79OERTwhFoHfcV
        +E9i4X+1Ug+Q8dtfMNIkKNbm8Tk4YBLHQsEmAzw=
X-Google-Smtp-Source: ABdhPJwmi7uvchJQHNAVXwLD/lKS3pf7gfgBMZWVL9jgzw308zunfGBbVqBdGxvGKfkN5TZk5f+6ksna9Cx+DDNWG8Y=
X-Received: by 2002:a05:6602:2c45:: with SMTP id x5mr3999023iov.80.1591806219542;
 Wed, 10 Jun 2020 09:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200610125147.2782142-1-christian.brauner@ubuntu.com>
 <CANiq72m_p2BRXswCGhUZi-Nta2y0uNXDQLRjPUFydB7YGV-6HQ@mail.gmail.com> <20200610155836.GA2360592@ubuntu-n2-xlarge-x86>
In-Reply-To: <20200610155836.GA2360592@ubuntu-n2-xlarge-x86>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 10 Jun 2020 18:23:28 +0200
Message-ID: <CA+icZUVxfrWCZ3JYT_3hT1iN3Ph0ZArJxTpjxVBNLRi7LvGFnw@mail.gmail.com>
Subject: Re: [PATCH] .clang-format: update column limit
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 5:58 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Wed, Jun 10, 2020 at 05:55:14PM +0200, Miguel Ojeda wrote:
> > Hi Christian,
> >
> > On Wed, Jun 10, 2020 at 2:51 PM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> > >
> > > The provided clang-format file wraps at 80 chars. If no one minds, I'd like
> > > to adjust this limit to 100 similar to what checkpatch (cf. [1]) uses now.
> >
> > Thanks! Picking this up with a few changes to the commit message.
> >
> > Cheers,
> > Miguel
> >
>
> If it isn't too late:
>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
>

Hi Christian,

just put your patch into my linux-5.7 patch-series before start building.

Feel free to add my:

Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>

Thanks.

Regards,
- Sedat -
