Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680A7C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 08:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3846B2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 08:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgzbRt/r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbgCRIKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 04:10:07 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36109 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgCRIKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 04:10:06 -0400
Received: by mail-io1-f66.google.com with SMTP id d15so23986735iog.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 01:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YXUayrHOPCJzF/6FJoY+BFEj3UMjmlbmnbZlPdkq6Po=;
        b=pgzbRt/reLTxd85HZ30lCVjELDNH9uycFJL3DJEFaKEB4p9NYustgyiOUAru6uWokT
         KI/F9LITN3XPzA7Hix1Bo5Kq1oH8I9u7saEJqACjSa8VP+P7nkpINUwi7jxAWD6K4CNJ
         vQOkhkvXrfBiMHt9EyVawr+UOjGLjnJ/9yMeKb6MDNXLm8i19ya5cJU+qY9xF99Omoas
         qBq1oi26LxtSVWRiI7FOXmaUq7KF+D/ioNFopm5Bs5ePKqM6mVJ1W9iVIrnwN5ojUTuU
         w3zqG/TXVPYrLW2zsd2Rg85DQ0lKTp1K09boKVZDyP6OAd882v6yqAvxx9/1dX90r1tf
         ijVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YXUayrHOPCJzF/6FJoY+BFEj3UMjmlbmnbZlPdkq6Po=;
        b=Bf4Ke42yy4r+jsbWQkpvumwHATGql8Ry31nfyti2HPbGgGYkC2CqOVXC13YCJ9cC6o
         QsRY449uXOBl9EvBJUNHjS0Iyxa0d8xMXkhS9r6Qb0v6a6uTri6xjW343mvK8foRztaK
         Jct1Gjv13IPPzj8uWXsW8kfV5TzevoWEv6cdI2bdKocLqKiiP515tvbeOgch0xWUHO+T
         +2ofdyHnOUZbwABfvRc1rRmLFEiAZPsDUU5d+XDbmiRJsgTByEyHkipC+vWf0BmON78z
         MOwGDKTCscSSM3QTsWW1RVxecf1h7EJmLghjnt0IiRGxYX3uXmvrRQWUDkP01xrdfBn8
         kbsQ==
X-Gm-Message-State: ANhLgQ01obCDYnpYQT04mk9Q8zLf0X4RuSNHziBNne7j59d5YTXlsMZ+
        U3WHekO9PkAJedBLWAudVeztPtg4JjHRsLL2Tos=
X-Google-Smtp-Source: ADFU+vtGaqToi+tepJgBsiJW6SjUf+4rCoDpemJXpl7GqXhJtz7305Sug3Xc0GMfFtuEBRvOt1afdJSJ/Ji7A3ARPyo=
X-Received: by 2002:a6b:c813:: with SMTP id y19mr2610596iof.125.1584519005895;
 Wed, 18 Mar 2020 01:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <1584343103-13896-1-git-send-email-hqjagain@gmail.com>
 <20200317170243.GR2363188@phenom.ffwll.local> <CAJRQjofSWYR--4V_4zmp6K9WVtqShdzpGuH1VFBPvHpViGYH5g@mail.gmail.com>
 <CAKMK7uG8v7cYUwqTJTgYGfC8LEZtczTZ5a+Z4NcRnbFVBcG4Fw@mail.gmail.com>
In-Reply-To: <CAKMK7uG8v7cYUwqTJTgYGfC8LEZtczTZ5a+Z4NcRnbFVBcG4Fw@mail.gmail.com>
From:   Qiujun Huang <hqjagain@gmail.com>
Date:   Wed, 18 Mar 2020 16:09:55 +0800
Message-ID: <CAJRQjodZegs-9GE8ypkAiU2gC_x=tAYvOz-_dseOyiDvfMApUA@mail.gmail.com>
Subject: Re: [PATCH RESEND] drm/lease: fix potential race in fill_object_idr
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Marco Elver <elver@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Dave Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 3:34 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Tue, Mar 17, 2020 at 11:33 PM Qiujun Huang <hqjagain@gmail.com> wrote:
> >
> > On Wed, Mar 18, 2020 at 1:02 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > >
> > > On Mon, Mar 16, 2020 at 03:18:23PM +0800, Qiujun Huang wrote:
> > > > We should hold idr_mutex for idr_alloc.
> > > >
> > > > Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> > >
> > > I've not seen the first version of this anywhere in my inbox, not sure
> > > where that got lost.
> > >
> > > Anyway, this seems like a false positive - I'm assuming this was caught
> > > with KCSAN. The commit message really should mention that.
> > >
> > > fill_object_idr creates the idr, which yes is only access later on under
> > > the idr_mutex. But here it's not yet visible to any other thread, and
> > > hence lockless access is safe and correct.
> >
> > Agree that.
>
> Do you know what the recommended annotation for kcsan false positives
> like this should be? Adding kcsan author Marco.

Actually it's not reported by kcsan. I found idr_alloc isn't safe for
parallel modifications,
and I didn't understand it's a exclusive path here.  :)

> -Daniel
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
