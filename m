Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2E6C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC5820773
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="itOjqh2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgCRMEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 08:04:01 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40271 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgCRMEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 08:04:00 -0400
Received: by mail-ot1-f66.google.com with SMTP id e19so4113614otj.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 05:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ON8aSc7ZZcAQyUZHAW9VI1gG1tyQ24ZFYQEruz9gWo0=;
        b=itOjqh2g1ZkLQELaM5IsOxGDSehkAZSmi4DU42VdIH9j47wwlmETry1dzPBv5Eu2Zj
         UBrRvqDq//rX8EWY0EYa5W22keh9vNNZ6QfRfXs9wNVLj3m+oVUy+1kR5iwdtSvRMTIN
         jfxQrRsJZC8t7HWZiYa5fJWWEbQIr2BxkaQoIO0Ft/OWzSNud9Ugf8EDv1d2Z3Ky3oR2
         8j3Ji1FQIzWvwqWLi8Iq+UwJGEdkSHGiR68rVWH41xtsSTBJQsdMvG8n60TLEmPX8THN
         r45sSugLCWzpjIc6GHDjOxbH5a7YqjDx2Jy4Sfo/ekFeFcfNC96IyDXkUnueg/39MMcH
         szZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ON8aSc7ZZcAQyUZHAW9VI1gG1tyQ24ZFYQEruz9gWo0=;
        b=RcrgwcwUyagol0WcNDxwIf6Ux2gjNsXBbC12rGHRzfTJPU6X6V0uZFs1ZJC1ucv9Kx
         iU775I9AXz9ns5JCVXBNwuD6gzhhVQbumkvy156EGk7jS2+/ounyIPgog4f6n/AxOjzL
         V29XUsg78MJPxE5+jnEETlOgGkEm8fQkGHL2CJOSeFmw4dF3fLTnHMUeXnJU8503abW4
         Hw5tZYI5uFz7tkN4y/NvwJlRy63kBel3LlYZ7/CN7ntWGCkN21O5tijPUGukZNiKdd3z
         9a/Oq9Ooa2Tu03hzEvvbLZ3jCcy5/D+6SkcSyl7jW5ByaQNHdJFwJqvpW5WnDI+kaSEv
         qVfA==
X-Gm-Message-State: ANhLgQ2lb9vMnJ5nTfNunogDYID3gIChp0YgiPFwFLeY2AJDqnPAyzFi
        KFO7INCW7Di7+34l0trGTWhIEzc2PUhe0tvT5D+13g==
X-Google-Smtp-Source: ADFU+vsWQ+o1R/VBSQJ1XYliOSPlCQgT3ZFST7kCA8+qMaRb8f2/sFxzTZdgRhJSWh6L7H0D/CX1fqXT4OmreAQGI8A=
X-Received: by 2002:a9d:6b1a:: with SMTP id g26mr3442844otp.2.1584533039830;
 Wed, 18 Mar 2020 05:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <1584343103-13896-1-git-send-email-hqjagain@gmail.com>
 <20200317170243.GR2363188@phenom.ffwll.local> <CAJRQjofSWYR--4V_4zmp6K9WVtqShdzpGuH1VFBPvHpViGYH5g@mail.gmail.com>
 <CAKMK7uG8v7cYUwqTJTgYGfC8LEZtczTZ5a+Z4NcRnbFVBcG4Fw@mail.gmail.com>
In-Reply-To: <CAKMK7uG8v7cYUwqTJTgYGfC8LEZtczTZ5a+Z4NcRnbFVBcG4Fw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 18 Mar 2020 13:03:48 +0100
Message-ID: <CANpmjNNaBqV2jPcM9p_dB4KEUJDTcRd+V_LyD=tejSRG4DBAeg@mail.gmail.com>
Subject: Re: [PATCH RESEND] drm/lease: fix potential race in fill_object_idr
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Qiujun Huang <hqjagain@gmail.com>,
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

On Wed, 18 Mar 2020 at 08:34, Daniel Vetter <daniel@ffwll.ch> wrote:
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

AFAIK KCSAN has not reported this, so I think there is nothing to do here.

Thanks,
-- Marco
