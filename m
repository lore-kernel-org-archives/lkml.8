Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B65EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2FE2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YiMsSpud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbgCXOff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:35:35 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44999 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbgCXOff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:35:35 -0400
Received: by mail-vs1-f68.google.com with SMTP id e138so11213693vsc.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 07:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vHxRlatObgRvnysxTZAZ7i5pl1JSDT2R3bHKmGhkgUE=;
        b=YiMsSpudpT6FxZHxA6De/saSAHGXK7VlyDXtpNtN9hNzxOPelBBcnUkk9LPz8Mz4Ir
         KztvWvGmrqbAk7jwUQE14sSAWV4hf05oN5i6odmjR/cou/29qpALc9peKPyrjgXDkrAc
         oq6V4L/S8pZ9LSBWm00J5so+SUpk1hSQ8Va+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vHxRlatObgRvnysxTZAZ7i5pl1JSDT2R3bHKmGhkgUE=;
        b=Rb2VhTczVERztTtCw/M+jPShvvlRiAvh5j8KRz7BtrhQV8rWRT4+WtS5kCBtroABjB
         2PmBXd4XD+1dEVQ/B0pgs/QSImyIqQDYrZbm6VfwDnOFH/RfhtYgNlstM7vzBoGnLof0
         2ezgKTm0ISsnwkldCsLUZ98Y9qv6YWWgek1SLSePfn2Wcdd/4/y9WDpoYEWk1bHF6XLh
         UUpjMwfBd2m3O6msk/1YDXC/ot95KzUXMoNw2zQKbL9W0f+yPwkgoKl4aBaFoAF0hnY2
         8RrOxmj1of6uayb9SrUWDmG6cpdH8W2Fwr/0fQs8HV0qj/oK2x6v74dXAT2Al94MtJya
         yZBA==
X-Gm-Message-State: ANhLgQ1qrfwhxs3eM73vbt8qQwV8bUTuXghk9GT1kjpIK0dDuYoK+2qa
        mSIPzGFdegn3pG23xAVxxk5+3MqERfQ=
X-Google-Smtp-Source: ADFU+vsVd1FWSHGswLQAc2fdZnfOkyHI79FbKSjh+JmWme81WubIUf+pK5eflghKFKBRMhpv5PMMJg==
X-Received: by 2002:a67:68c5:: with SMTP id d188mr9920226vsc.15.1585060533535;
        Tue, 24 Mar 2020 07:35:33 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id o39sm10036230uad.6.2020.03.24.07.35.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 07:35:32 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a6so1528639uao.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 07:35:32 -0700 (PDT)
X-Received: by 2002:a9f:300a:: with SMTP id h10mr18039835uab.91.1585060531555;
 Tue, 24 Mar 2020 07:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <1584944027-1730-1-git-send-email-kalyan_t@codeaurora.org>
In-Reply-To: <1584944027-1730-1-git-send-email-kalyan_t@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 24 Mar 2020 07:35:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VX+Lj=NeZnYxDv9gLYUiwUO6brwvDSL8dbs1MTF4ieuA@mail.gmail.com>
Message-ID: <CAD=FV=VX+Lj=NeZnYxDv9gLYUiwUO6brwvDSL8dbs1MTF4ieuA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: ensure device suspend happens during PM sleep
To:     Kalyan Thota <kalyan_t@codeaurora.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        mkrishn@codeaurora.org, travitej@codeaurora.org,
        nganji@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Mar 22, 2020 at 11:14 PM Kalyan Thota <kalyan_t@codeaurora.org> wrote:
>
> "The PM core always increments the runtime usage counter
> before calling the ->suspend() callback and decrements it
> after calling the ->resume() callback"
>
> DPU and DSI are managed as runtime devices. When
> suspend is triggered, PM core adds a refcount on all the
> devices and calls device suspend, since usage count is
> already incremented, runtime suspend was not getting called
> and it kept the clocks on which resulted in target not
> entering into XO shutdown.
>
> Add changes to manage runtime devices during pm sleep.
>
> Changes in v1:
>  - Remove unnecessary checks in the function
>      _dpu_kms_disable_dpu (Rob Clark).

I'm wondering what happened with my feedback on v1, AKA:

https://lore.kernel.org/r/CAD=FV=VxzEV40g+ieuEN+7o=34+wM8MHO8o7T5zA1Yosx7SVWg@mail.gmail.com

Maybe you didn't see it?  ...or if you or Rob think I'm way off base
(always possible) then please tell me so.

Thanks!

-Doug
