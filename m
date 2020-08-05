Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE11C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 23:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA6A522CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 23:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LU9szYBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgHEXCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 19:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgHEXCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 19:02:09 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF72C061575
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 16:02:08 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f193so13434343pfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 16:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=D2FPhVzVWIZtZx6XGuR9BhQEfUSs8mf478JBVJrxzMk=;
        b=LU9szYBp1vKOWYK9ZE2MZyWxoG2fOf5gfuZ9xclQWD92F++tEgEBCvgUKrCCnTfTt3
         9A/ZaiLsOcGPegcLzUuR/Dorr0doK73igcWN1VwgJCwVYuYU/M8KZ9AGen45tcUccRva
         bry7sknuU39Z3o26kNvSg/V5f4fpt0Hzd3zqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=D2FPhVzVWIZtZx6XGuR9BhQEfUSs8mf478JBVJrxzMk=;
        b=h2/ZgsrES8V6JJxwBAd0POtugsw1QbeDVWCNswzibAduO3PxL+8Eb8mADWrA9n7+2D
         ysKe/8hB/PxtwEGF1sTbnMSQEjZzr9OpDiqHHDQVUq37XI/tu+rTdlxwjOhBUKqbDIHf
         uhf0uD3YN+6GE8+B4GBsbdoU14Bz7S1B5/ZfuQAIhgkuptmfjhA6NfiEL2ccTj++gyYm
         sbEc5kU0ZCIJbVo4J4Fxp5SY8ngc5ORAkgwanAkjcdUtwt98S9W7w9VGBAoEHENhR9Wm
         KBKjoR7KNy3GjiTVYxQ+xyMPG/0+LVz1n0EuK/aFHBdQMLBd3nUEaQCvM9zisfsdWxBt
         xxMg==
X-Gm-Message-State: AOAM533oyjmgP3eLkGUgSgpgH0RI3nwH4s2OwTsfwqMT0XmH8ckmr+yQ
        74osSSPEM6g4GLXgk7FASs5q5w==
X-Google-Smtp-Source: ABdhPJwp/H0qqp4+L0IJ1bg07XMMXAt80MpWc8shwoxvp8ROrc+S0tzHERtBa44OHf4K4gGttO8rAA==
X-Received: by 2002:a63:f44d:: with SMTP id p13mr4784860pgk.363.1596668527377;
        Wed, 05 Aug 2020 16:02:07 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id z5sm4413264pfk.15.2020.08.05.16.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 16:02:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=UK+xHV6qsr2AsPB=BzmzN77AT-du8G2tt1QZMQUpGgKg@mail.gmail.com>
References: <20200805091141.1.I86b3faaecb0d82997b599b1300f879606c71e116@changeid> <159664899840.1360974.7548807728313161626@swboyd.mtv.corp.google.com> <CAD=FV=UK+xHV6qsr2AsPB=BzmzN77AT-du8G2tt1QZMQUpGgKg@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: qcom: aoss: Don't wait for IRQ if we might be in suspend/resume noirq
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alex Elder <elder@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To:     Doug Anderson <dianders@chromium.org>,
        Sibi Sankar <sibis@codeaurora.org>
Date:   Wed, 05 Aug 2020 16:02:05 -0700
Message-ID: <159666852526.1360974.3062132560884413001@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Sibi who wrote the code

Quoting Doug Anderson (2020-08-05 13:24:06)
>=20
> On Wed, Aug 5, 2020 at 10:36 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Why is the genpd being powered off at all? It looks like the driver is
> > written in a way that it doesn't expect this to happen. See where
> > adsp_pds_disable() is called from. Looks like the remoteproc "stop"
> > callback should be called or the driver should be detached.
> >
> > It sort of looks like the genpd is expected to be at the max level all
> > the time (it sets INT_MAX in adsp_pds_enable(), cool).
>=20
> In general in Linux there are some things that, at suspend time, get
> done behind a driver's back.  The regulator API, for instance, allows
> for regulators to be turned off in suspend even if a driver leaves
> them on.  Sure, it's good practice for a driver to be explicit but the
> regulator suspend states do allow for the more heavy-handed approach.
>=20
> I guess I assume that genpd is a bit similar.  If a driver leaves a
> genpd on all the time then it will still be turned off at suspend time
> and then turned back on at resume time.  It seems like it must be part
> of the genpd API.  Specifically genpd_sync_power_off() says: "Check if
> the given PM domain can be powered off (during system suspend or
> hibernation) and do that if so."  That makes it seem like it's how
> genpd works.
>=20
> Reading all the descriptions of things like GENPD_FLAG_ALWAYS_ON,
> GENPD_FLAG_ACTIVE_WAKEUP, GENPD_FLAG_RPM_ALWAYS_ON makes me even more
> convinced that it's normal (unless otherwise specified) for genpds to
> get turned off in suspend even if a driver just blindly left them on.
>=20
> Presumably if this "modem" genpd is supposed to stay on in suspend
> time it should have been marked "always on"?  I'd guess we'd need to
> add "GENPD_FLAG_ALWAYS_ON" in some (or all?) cases in qmp_pd_add() if
> this was true?

Agreed. I can't read the mind of Sibi so I can only guess that Sibi
wasn't expecting this behavior by reading the driver structure. That
could be a wrong assumption.

>=20
>=20
> > Maybe we need to
> > add some sort of suspend hooks to the remote proc driver instead? Where
> > those suspend hooks are called earlier and drop the genpd performance
> > state request but otherwise leave it enabled across suspend?
>=20
> I think you're saying:
>=20
> a) You think it's a bug today that the "modem" genpd is being powered
> off in suspend.  Any evidence to back this up?
>=20
> b) Assuming it's a bug today, we should mark the "modem" as
> GENPD_FLAG_ALWAYS_ON.
>=20
> c) If there are genpds that sometimes should be left on in suspend but
> sometimes not (and that doesn't match up with what
> GENPD_FLAG_ACTIVE_WAKEUP does), then we'd have to pass
> GENPD_FLAG_ALWAYS_ON as a flag and then add suspend hooks to make the
> decision for us.
>=20
> Did I understand that correctly?
>=20
> ...or are you suggesting that we work around the fact that
> qmp_pd_power_off() can't be called at "noirq" time by forcing it to
> suspend earlier?
>=20
> ...or am I just totally confused and you meant something else?
>=20
>=20
> > I know this isn't clearing the land mine that is calling this code from
> > noirq phase of suspend, but I'm just looking at the driver and thinking
> > that it never expected to be called from this phase of suspend to begin
> > with.
>=20
> You're saying that qmp_pd_power_off() wasn't expecting to be called
> from the noirq phase of suspend?  Sure, I guess not given the bug.
> ...but once we fix the bug, it works fine, doesn't it?  ...and it
> appears that it's part of the genpd API to be able to be called from
> the noirq phase.  To me that means that, even if we were supposed to
> be keeping this particular PD on during suspend we should take my
> patch.
>=20
>=20
> So the summary is: I still think my patch is correct, but I could
> certainly still be convinced otherwise.
>=20

I'm trying to say that the driver looks like it expects to power off the
genpd in the adsp_stop() callback. That same callback sends some sort of
message to the modem saying that it is being stopped (see
qcom_q6v5_request_stop()). Turning the performance state down, or
turning the power domain off completely, without telling the modem that
it's happening like as is done in adsp_stop() looks wrong. But who
knows, maybe the modem is happy with that and doesn't care?

In general, the whole thing looks weird to me because I would expect the
modem to take care of its own power requirements, including this
"load_state" one. Anyway, I hope Sibi can clarify what's going on.
