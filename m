Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56901C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DB48206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U/GN/C0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgHKVVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgHKVVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:21:48 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F32C061787
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:21:48 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id y17so3934569uaq.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YkOspF4zgYBjdY3oC8rtcOqQAQAqXdWA9ihgYSGWztw=;
        b=U/GN/C0aEZYEX3j/COiQ5AVesJ9TnprTlzhKvppyFnKnGwH2QHMTzwfcP7m9Fs3d49
         7hfDZ5yNcB6yPQ1aru+wLlMnLRMCLbOrto01CE22pWxykc6rtv9W+itgCb+biyrZx3yJ
         QYYcRfxq6PxwuCi4CBx30SByo78sd0kjujYOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YkOspF4zgYBjdY3oC8rtcOqQAQAqXdWA9ihgYSGWztw=;
        b=hiTFATBLWk/46M8N1jJVY7FFpDF4AucaCtIQR5iJOxOgdYCH8hCTLyrU4WzsDbaVsw
         xOcoVvxwTbKoZ8JLNDirTpYI/lT/FTLmCJ5CIrczcVwEXtmgbHkYicghRLahJk18svjh
         AznZzaXLzjhKgO8zDNwBgGKu+Oln6u+bfGqSS+0hryKIRJLL2Y9Lsn/RXjgl63ZQiG6s
         oIy6mH3BX3HjHMAuI3vDwTBIbJnt7wpj9hOJy3iFdb14Sha4FAkj25J0eW+habT3d/zH
         d7UzxbMQi5J8X2t+ViCnwtMK8RlZynEDTaJURcXcj0Gih5wMQ9rfDrFSVOWCr5GSMd4z
         r48Q==
X-Gm-Message-State: AOAM533KCInLCBtpuAZmaZUzXUBgl/7ebRBmVrP3PI3tPOc10obOGFo0
        dh1wt8LeazFsm9BmlvvZ77d5RK1Cduc=
X-Google-Smtp-Source: ABdhPJz2o8e8E3jv2Yr+pnolM9gK5TkNUNjvD6Ee39cWO+bGnTqt1TVm6rD51d+ezS6afghud2DIeA==
X-Received: by 2002:ab0:14c8:: with SMTP id f8mr1701287uae.23.1597180906934;
        Tue, 11 Aug 2020 14:21:46 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id c193sm32330vke.11.2020.08.11.14.21.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 14:21:45 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id d20so3940815ual.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:21:45 -0700 (PDT)
X-Received: by 2002:ab0:623:: with SMTP id f32mr10207868uaf.121.1597180904985;
 Tue, 11 Aug 2020 14:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200805091141.1.I86b3faaecb0d82997b599b1300f879606c71e116@changeid>
 <159664899840.1360974.7548807728313161626@swboyd.mtv.corp.google.com>
 <CAD=FV=UK+xHV6qsr2AsPB=BzmzN77AT-du8G2tt1QZMQUpGgKg@mail.gmail.com>
 <159666852526.1360974.3062132560884413001@swboyd.mtv.corp.google.com>
 <4c40db0fe88dd9aff6897ebc103aa3e9@codeaurora.org> <CAD=FV=Xmf5Qj8obuKdE5CqYL7ek7CQQLPt4j4eTu=RpwcDwM2w@mail.gmail.com>
 <8450aff2d16aed092295c61a8e4ca850@codeaurora.org>
In-Reply-To: <8450aff2d16aed092295c61a8e4ca850@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 11 Aug 2020 14:21:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WWYA-hxdAVdLHj9Ej9nCWohOHsh9GA1GZ3Mg-XuJfeyA@mail.gmail.com>
Message-ID: <CAD=FV=WWYA-hxdAVdLHj9Ej9nCWohOHsh9GA1GZ3Mg-XuJfeyA@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: qcom: aoss: Don't wait for IRQ if we might be in
 suspend/resume noirq
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alex Elder <elder@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 6, 2020 at 10:33 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> On 2020-08-06 22:40, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Aug 6, 2020 at 7:36 AM Sibi Sankar <sibis@codeaurora.org>
> > wrote:
> >>
> >> On 2020-08-06 04:32, Stephen Boyd wrote:
> >> > +Sibi who wrote the code
> >> >
> >> > Quoting Doug Anderson (2020-08-05 13:24:06)
> >> >>
> >> >> On Wed, Aug 5, 2020 at 10:36 AM Stephen Boyd <swboyd@chromium.org>
> >> >> wrote:
> >> >> >
> >> >> > Why is the genpd being powered off at all? It looks like the driver is
> >> >> > written in a way that it doesn't expect this to happen. See where
> >> >> > adsp_pds_disable() is called from. Looks like the remoteproc "stop"
> >> >> > callback should be called or the driver should be detached.
> >> >> >
> >> >> > It sort of looks like the genpd is expected to be at the max level all
> >> >> > the time (it sets INT_MAX in adsp_pds_enable(), cool).
> >> >>
> >> >> In general in Linux there are some things that, at suspend time, get
> >> >> done behind a driver's back.  The regulator API, for instance, allows
> >> >> for regulators to be turned off in suspend even if a driver leaves
> >> >> them on.  Sure, it's good practice for a driver to be explicit but the
> >> >> regulator suspend states do allow for the more heavy-handed approach.
> >> >>
> >> >> I guess I assume that genpd is a bit similar.  If a driver leaves a
> >> >> genpd on all the time then it will still be turned off at suspend time
> >> >> and then turned back on at resume time.  It seems like it must be part
> >> >> of the genpd API.  Specifically genpd_sync_power_off() says: "Check if
> >> >> the given PM domain can be powered off (during system suspend or
> >> >> hibernation) and do that if so."  That makes it seem like it's how
> >> >> genpd works.
> >> >>
> >> >> Reading all the descriptions of things like GENPD_FLAG_ALWAYS_ON,
> >> >> GENPD_FLAG_ACTIVE_WAKEUP, GENPD_FLAG_RPM_ALWAYS_ON makes me even more
> >> >> convinced that it's normal (unless otherwise specified) for genpds to
> >> >> get turned off in suspend even if a driver just blindly left them on.
> >> >>
> >> >> Presumably if this "modem" genpd is supposed to stay on in suspend
> >> >> time it should have been marked "always on"?  I'd guess we'd need to
> >> >> add "GENPD_FLAG_ALWAYS_ON" in some (or all?) cases in qmp_pd_add() if
> >> >> this was true?
> >> >
> >> > Agreed. I can't read the mind of Sibi so I can only guess that Sibi
> >> > wasn't expecting this behavior by reading the driver structure. That
> >> > could be a wrong assumption.
> >> >
> >> >>
> >> >>
> >> >> > Maybe we need to
> >> >> > add some sort of suspend hooks to the remote proc driver instead? Where
> >> >> > those suspend hooks are called earlier and drop the genpd performance
> >> >> > state request but otherwise leave it enabled across suspend?
> >> >>
> >> >> I think you're saying:
> >> >>
> >> >> a) You think it's a bug today that the "modem" genpd is being powered
> >> >> off in suspend.  Any evidence to back this up?
> >> >>
> >> >> b) Assuming it's a bug today, we should mark the "modem" as
> >> >> GENPD_FLAG_ALWAYS_ON.
> >> >>
> >> >> c) If there are genpds that sometimes should be left on in suspend but
> >> >> sometimes not (and that doesn't match up with what
> >> >> GENPD_FLAG_ACTIVE_WAKEUP does), then we'd have to pass
> >> >> GENPD_FLAG_ALWAYS_ON as a flag and then add suspend hooks to make the
> >> >> decision for us.
> >>
> >> Doug/Stephen,
> >>
> >> Yes this is a bug, we wouldn't want
> >> to disable aoss_qmp genpd for modem
> >> during suspend (when the modem is
> >> running). The qmp send for modem
> >> is the primary means through which
> >> aoss determines whether to wait for
> >> modem before proceeding to sleep. So
> >> looks like updating the flag with
> >> GENPD_FLAG_ACTIVE_WAKEUP is the way
> >> to go. But introducing another flag
> >> that doesn't touch genpd's during
> >> suspend/resume should also work.
> >
> > OK, sounds good.  As per out-of-band conversation:
> >
> > * You'll plan to post a patch updating the flag.
> >
> > * There's still nothing here that says my patch is the wrong thing to
> > do also.  It seems like genpd poweroff routine are expected to be able
> > to run at "noirq" time so we should make sure we are able to do that.
> >
> > I'm also curious: my patch doesn't affect the behavior.  The genpd
> > would be powered off with or without my patch, my patch just removes a
> > pointless 1 second delay.  Therefore I guess today there is some type
> > of bug because the genpd is being turned off.  What would be the
> > visible impact of that bug?  ...or is it somehow masked by something
> > else keeping this power on so it wasn't an issue right now?
>
> I've been told AOSS decides to wait
> for modem suspend if its been notified
> that modem is on through qmp_send. AFAIK
> we never ran into this because AOSS sleep
> sequence starts after xo-shutdown which
> wont be reached in the presence of active
> rpmh votes from modem.
>
> Regardless we definitely want this genpd left
> untouched during suspend/resume.

With Sibi's patch [1] then ${SUBJECT} patch is no longer needed since
we are no longer called during "noirq" / "syscore" time.  Assuming
Sibi's patches (or something similar to them) are OK, we can consider
this patch abandoned.  I'll re-post patch #2 on its own once we get
confirmation that Sibi's patches are OK w/ folks.

[1] https://lore.kernel.org/r/20200811190252.10559-2-sibis@codeaurora.org

-Doug
