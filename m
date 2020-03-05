Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3773C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A314420801
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LyepxGFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgCEWW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:22:29 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:42747 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgCEWW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:22:29 -0500
Received: by mail-ua1-f68.google.com with SMTP id p2so2715209uao.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 14:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PEWESvvWwpim3ir+IdcWqEyheUQ9bGdHqQ7W44KO964=;
        b=LyepxGFC82FfUE+1J2lVQWWyuqVVp2z5tVSjuhGBRsTtHVafF7bDmh0fL2MZHw4exc
         H+AtuxARcuXS/r4EyKg9tRrldm+tMXz0v1TGYiOQpfBmskWwJlaxzCw6PH50usJBcGjM
         z9jC9FKpN4it0S+uzDbSHvQl+RDS3bOOD1n78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PEWESvvWwpim3ir+IdcWqEyheUQ9bGdHqQ7W44KO964=;
        b=JacXofVr9xgeTmYDDyhmJZpB39wSMXCKzRzEt2yWND3wb2ufyxr3+heFDUsL2xsh5c
         8D7L7lvAXaTfNZJTvzFOOOJuMgPv2UFh1UQSEv4sdkaN9VyOnrvaM9aOyEkl4A7qNrYM
         NP0Ni9bbLnC0prhlbD0rpMXc8N9+FtROXG3vHx4/bPCoWvT0lz0j5ZoOJApTTEKoTtB7
         eDYozTlS2QHYSrsuEZXMglioGFBkoduLKicUZJIevyTxXDS4d+gXuzwcj2+swsIVeUbQ
         vjLMvxWodSJRvOfKSu1yCwF0tQRhDkJxufWtIJ0wORFeLA8hYZXAvx7xLify/jNGajWO
         TqtA==
X-Gm-Message-State: ANhLgQ0zUUHNi3/MskqdIhmC6aOPL80ZLy8CPPgEL6LtQzUDeT/mL9jT
        cHyxIj8z6ejgWNJ3vcZVyooHrCV5htc=
X-Google-Smtp-Source: ADFU+vv9XxXWL0Grfo/bTE8lIY9f8K0gpQpfEovJ1gZBZasSdoeHy3cECgjiKMO/r4cq0bHxD98NeQ==
X-Received: by 2002:ab0:1e84:: with SMTP id o4mr34875uak.126.1583446947737;
        Thu, 05 Mar 2020 14:22:27 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id h67sm8812131vka.25.2020.03.05.14.22.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 14:22:27 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id w142so264953vsw.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 14:22:26 -0800 (PST)
X-Received: by 2002:a67:e98e:: with SMTP id b14mr408848vso.106.1583446946520;
 Thu, 05 Mar 2020 14:22:26 -0800 (PST)
MIME-Version: 1.0
References: <1583238415-18686-1-git-send-email-mkshah@codeaurora.org>
 <1583238415-18686-3-git-send-email-mkshah@codeaurora.org> <CAD=FV=VOARbQzY_p-SyDFu0mzFROp8nV9E=sraNrykWiySwEpw@mail.gmail.com>
 <8e307595-7758-6eb5-ab2d-73ab1ac1029c@codeaurora.org>
In-Reply-To: <8e307595-7758-6eb5-ab2d-73ab1ac1029c@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 5 Mar 2020 14:22:15 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VzNnRdDN5uPYskJ6kQHq2bAi2ysEqt0=taagdd_qZb-g@mail.gmail.com>
Message-ID: <CAD=FV=VzNnRdDN5uPYskJ6kQHq2bAi2ysEqt0=taagdd_qZb-g@mail.gmail.com>
Subject: Re: [PATCH v10 2/3] soc: qcom: rpmh: Update dirty flag only when data changes
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 5, 2020 at 3:10 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> > To summarize:
> >
> > a) If the only allowable use of "WAKE_ONLY" is to undo "SLEEP_ONLY"
> > then we should re-think the API and stop letting callers to
> > rpmh_write(), rpmh_write_async(), or rpmh_write_batch() ever specify
> > "WAKE_ONLY".  The code should just assume that "wake_only =3D
> > active_only if (active_only !=3D sleep_only)".  In other words, RPMH
> > should programmatically figure out the "wake" state based on the
> > sleep/active state and not force callers to do this.
> >
> > b) If "WAKE_ONLY" is allowed to do other things (or if it's not RPMH's
> > job to enforce/assume this) then we should fully skip calling
> > cache_rpm_request() for RPMH_ACTIVE_ONLY_STATE.
> >
> >
> > NOTE: this discussion also makes me wonder about the is_req_valid()
> > function.  That will skip sending a sleep/wake entry if the sleep and
> > wake entries are equal to each other.  ...but if sleep and wake are
> > both different than "active" it'll be a problem.
>
> Hi Doug,
>
> To answer above points, yes in general it=E2=80=99s the understanding tha=
t wake is
> almost always need to be equal to active. However, there can be valid rea=
sons
> for which the callers are enforced to call them differently in the first =
place.
>
> At present caller send 3 types of request.
> rpmh_write(RPMH_ACTIVE_ONLY_STATE, addr=3D0x10, data=3D0x99);
> rpmh_write(RPMH_SLEEP_STATE, addr=3D0x10, data=3D0x0);
> rpmh_write(RPMH_WAKE_ONLY_STATE, addr=3D0x10, data=3D0x99);
>
> Now, Lets assume we handle this in rpmh driver since wake=3Dactive and th=
e caller
> send only 2 type of request (lets call it active and sleep, since we have=
 assumption
> of wake=3Dactive, and we don=E2=80=99t want 3rd request as its handled in=
 rpmh driver)
> So callers will now invoke 2 types of request.
>
> rpmh_write(RPMH_ACTIVE_ONLY_STATE, addr=3D0x10, data=3D0x99);
> rpmh_write(RPMH_SLEEP_STATE, addr=3D0x10, data=3D0x0);
>
> with first type request, it now needs to serve 2 purpose
> (a)    cache ACTIVE request votes as WAKE votes
> (b)    trigger it out immediately (in ACTIVE TCS) as it need to be also c=
omplete immediately.
>
> For SLEEP, nothing changes. Now when entering to sleep we do rpmh_flush()=
 to program all
> WAKE and SLEEP request=E2=80=A6so far so good=E2=80=A6
>
> Now consider a corner case,
>
> There is something called a solver mode in RSC where HW could be in auton=
omous mode executing
> low power modes. For this it may want to =E2=80=9Conly=E2=80=9D program W=
AKE and SLEEP votes and then controller
> would be in solver mode entering and exiting sleep autonomously.
>
> There is no ACTIVE set request and hence no requirement to send it right =
away as ACTIVE vote.
>
> If we have only 2 type of request, caller again need to differentiate to =
tell rpmh driver that
> when it invoke
>
> rpmh_write(RPMH_ACTIVE_ONLY_STATE, addr=3D0x10, data=3D0x99);
>
> with this caching it as WAKE is fine  ((a) in above) but do not trigger i=
t ((b) in above)
>
> so we need to again modify this API and pass another argument saying whet=
her to do (a + b) or only (a).
> but caller can already differentiate by using RPMH_ACTIVE_ONLY_STATE or R=
PMH_WAKE_ONLY_STATE.
>
> i think at least for now, leave it as it is, unless we really see any imp=
act by caller invoking all
> 3 types of request and take in account all such corner cases before i mak=
e any such change.
> we can take it separate if needed along with optimization pointed in v9 s=
eries discussions.

I totally don't understand what solver mode is for and when it's used,
but I'm willing to set that aside for now I guess.  From looking at
what you did for v12 it looks like the way you're expecting things to
function is this:

* ACTIVE: set wake state and trigger active change right away.

* SLEEP: set only sleep state

* WAKE: set only wake state, will take effect after next sleep/wake
unless changed again before that happens.


...I'll look at the code with this understanding, now.  Presumably also:

* We should document this.

* If we see clients that are explicitly setting _both_ active and wake
to the same thing then we can change the clients.  That means the only
people using "WAKE" mode would be those clients that explicitly want
the deferred action (presumably those using "solver" mode).

Do those seem correct?


If that's correct, I guess one subtle corner-case bug in
is_req_valid().  Specifically if it's ever valid to do this:

rpmh_write(RPMH_ACTIVE_ONLY_STATE, addr=3D0x10, data=3D0x99);
rpmh_write(RPMH_SLEEP_STATE, addr=3D0x10, data=3D0x0);
rpmh_write(RPMH_WAKE_ONLY_STATE, addr=3D0x10, data=3D0x0);

...then it won't work.  You'll transition between sleep/wake and stay
with "data=3D0x99".  Since "sleep =3D=3D wake" then is_req_valid() will
return "false" and we won't bother programming the commands for
sleep/wake.  One simple way to solve this is remove the
"req->sleep_val !=3D req->wake_val" optimization in is_req_valid().


I guess we should also document that "batch" doesn't work like this.
The "batch" API is really designed around having exactly one "batch"
caller (the interconnect code) and we assume that the batch code will
be sending us pre-optimized commands I guess?  Specifically there
doesn't seem to be anything trying to catch batch writes to "active"
and also applying them to "wake".


-Doug
