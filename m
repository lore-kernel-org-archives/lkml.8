Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC55C433ED
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B116206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M+/a/Owq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgGXVIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 17:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgGXVIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 17:08:36 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22366C0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 14:08:36 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o13so6121298pgf.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 14:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=76t9ZH7WAoATJA2G6N4mlcv3kN45oTzZ3a5XU5U46cQ=;
        b=M+/a/OwqdBpq0MzoZSOiQLJduFo/y+ms2pRkWbwhI3T4KmvgqRLavGa78z9hwoF9jS
         R9MO1cdtoRRpX/WfevvaOLu+sNDiEKvFpnjDvQT1DXxswske/ZhYSgWK2ZzrgztpQV5c
         UaDOumPhpXJyuROGeQnVNy6IGSVEIxVR2/xhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=76t9ZH7WAoATJA2G6N4mlcv3kN45oTzZ3a5XU5U46cQ=;
        b=rFCgGnafGDocSJpXJj0NQNSBRpvQ0S5RHqPibKMEK6rJWZr3TUuzgtE3mZGKlfhduq
         ce9u6CdmkObemph8YgrUdCHK+t0/DLp7xWNjaDPh6nc5uBuPeyj6yEtQe1AhZqJAPJNs
         JjrcqWgFJmipFIvBvXI9Y91pl3y9rJ2mmW2ye6l+nBjJ5Van6eZ2FFFIlRFPq5YQEVrG
         hPM0qAQhwcQj+7f3vff187AdOLXvGdRlcYCiiLCMLvZVN021gBjEW4zZUTXSHlNxtGQh
         G+VB9+x1K9MCswCG7Z5rY/4wWi8M8C9Rz69vdyxYdrb+GG1uvuIkeUHDTJRz7IlDaTZ6
         onog==
X-Gm-Message-State: AOAM531v1fRFObAZCWFIeJR2PNMRtd1MbL+KY/lO393M7ubY4WidGgyj
        XIF5Rxz2bw2nIkEz5nrsxSwHqQ==
X-Google-Smtp-Source: ABdhPJyYPmyHsh2kMXa3ya19emFzTe8nTl43if8vOo6fCtjP9ZFqAI8AFST1uxSYhAyHyOECMG8uOw==
X-Received: by 2002:a63:7cf:: with SMTP id 198mr9884221pgh.309.1595624915552;
        Fri, 24 Jul 2020 14:08:35 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id k71sm7105007pje.33.2020.07.24.14.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 14:08:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=V2NduvgdrSNOs7Ufm+=Tk3+rtkSoJg8BH7cYtOdCHXcA@mail.gmail.com>
References: <20200723010137.3127584-1-swboyd@chromium.org> <CAD=FV=WtjyYY+bmocc17S9NbRs6inkAWjj7=c9qBsVf3LtG99Q@mail.gmail.com> <159561988523.3847286.14763422711224252201@swboyd.mtv.corp.google.com> <CAD=FV=WH1vKKe=MPVdtBJZWnSzxNLO0uyM02GFG6oCJfSEwehQ@mail.gmail.com> <159562087212.3847286.9484527206999948907@swboyd.mtv.corp.google.com> <CAD=FV=VUSwsP_xrHsufLjZqbWdn5V8rybtv2DWad2nBfU+VJ9w@mail.gmail.com> <159562244072.3847286.7905035931282026601@swboyd.mtv.corp.google.com> <CAD=FV=V2NduvgdrSNOs7Ufm+=Tk3+rtkSoJg8BH7cYtOdCHXcA@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: rpmh-rsc: Sleep waiting for tcs slots to be free
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>
To:     Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Jul 2020 14:08:33 -0700
Message-ID: <159562491399.3847286.17604881801973524633@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2020-07-24 13:31:39)
> Hi,
>=20
> On Fri, Jul 24, 2020 at 1:27 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Doug Anderson (2020-07-24 13:11:59)
> > >
> > > I wasn't suggesting adding a timeout.  I was just saying that if
> > > claim_tcs_for_req() were to ever return an error code other than
> > > -EBUSY that we'd need a check for it because otherwise we'd interpret
> > > the result as a tcs_id.
> > >
> >
> > Ok that sounds like you don't want a check for -EBUSY so I'll leave this
> > as >=3D 0.
>=20
> To clarify, I'd be OK with either of these (slight preference towards
> #2, but not a strong one):
>=20
> 1. Your current code and a REALLY OBVIOUS comment in
> claim_tcs_for_req() saying that we'd better not return any error codes
> other than -EBUSY (because we'll just blindly retry on all of them).
>=20
> - or -
>=20
> 2. Handling error codes other than -EBUSY, like this:
>=20
> wait_event_lock_irq(drv->tcs_wait,
>                     (tcs_id =3D claim_tcs_for_req(drv, tcs, msg)) !=3D -E=
BUSY,
>                     drv->lock);
> if (tcs_id < 0)
>   goto unlock;
>=20

Ah I think I understand. You're thinking that claim_tcs_for_req() may
return an error value that isn't -EBUSY some day and then this
wait_event_lock_irq() will keep spinning forever when it isn't busy but
invalid or some such? I'd rather not do #2 because it is dead code until
claim_tcs_for_req() changes. I'll add a comment indicating that it must
return something that is claimed or the caller will keep trying. When
the code changes the call sites should be evaluated by the author to
make sure that it keeps working. I'm afraid a really big comment won't
do much to help with that in the future.
