Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F94C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 064F920706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PtcLxUsU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgHYHUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 03:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729209AbgHYHUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 03:20:19 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E54C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 00:20:19 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g1so2403135pgm.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 00:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=vg5jAvVQXxT9NoQtlYydmDlexL/3ZUaKgzWx4DPbqMc=;
        b=PtcLxUsUsen/kCOn1Qu+UpVo4UmeYVlFBp/3mrHIwuuvQGD4Tb+Wu5PLYRRFP/gc1s
         y4Pq+CTtelzAq6PBaRYVbXnk+EoRMmI80F/FoEz8CXXTU10OOK5yHzXYNo66W7fVQq8U
         vNLP0+0ENzRz8UG37xRLcwyjrlH/h7tMlBywU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=vg5jAvVQXxT9NoQtlYydmDlexL/3ZUaKgzWx4DPbqMc=;
        b=ehkzcakbpOdH3VxSiUe65WoBVjkoFDYXrtuZB0No3+et7VDMhPGpOEpu+3SZZ7jE5z
         3GI7uDodxGd6h85ceKRs4ps1kXEOvNa1VlGunykIV31B6vkeL3hJYrUMq4Vs5lsI6E7h
         X0vVriIRiwWTnIvJn9jLy1DTJVRLX+cmJOf6eeMQonKcy7GmOlBKjbgSnHh8NuqPg/NE
         BuZnVEo0gR9+R4Hco/AZgIE63EO1wJ18zt7xeKaRH1gL2soA1ntV8lyp/NqmT06kPhwM
         iLTAQ3qRUXDJx8UX6TkXIA3UI3urVlKIHFuXfjuK9Ys9ISGwDVN1WUjaMogx/u4OUMgl
         NXuA==
X-Gm-Message-State: AOAM533m9mGXGki1ciNps55JKzZUO6c+j5Eti9t4uCriORa8oKYYd5yS
        LQTZihzgIWnVNzisJy/SBhm+CINP1t6wrg==
X-Google-Smtp-Source: ABdhPJyzNUCbdnBjGxXGVwGQwQsAzmGrWhlHRrFkyhNvHPB0nHjuj4tILIjEYc9j4vEy2nHcmu4W8g==
X-Received: by 2002:a62:2704:: with SMTP id n4mr7083175pfn.246.1598340019012;
        Tue, 25 Aug 2020 00:20:19 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id x136sm13701355pfc.28.2020.08.25.00.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 00:20:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200824164212.GA3715@yoga>
References: <20200821204921.32536-1-sibis@codeaurora.org> <159804608868.334488.2486130699850456264@swboyd.mtv.corp.google.com> <20200824164212.GA3715@yoga>
Subject: Re: [PATCH v2 1/2] PM / Domains: Add GENPD_FLAG_NO_SUSPEND/RESUME flags
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>, khilman@kernel.org,
        ulf.hansson@linaro.org, rjw@rjwysocki.net, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, pavel@ucw.cz,
        len.brown@intel.com, rnayak@codeaurora.org, dianders@chromium.org,
        mka@chromium.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Tue, 25 Aug 2020 00:20:17 -0700
Message-ID: <159834001729.334488.11862381163144726708@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2020-08-24 09:42:12)
> On Fri 21 Aug 14:41 PDT 2020, Stephen Boyd wrote:
>=20
> > Quoting Sibi Sankar (2020-08-21 13:49:20)
> > > Add GENPD_FLAG_NO_SUSPEND/RESUME flags to instruct genpd to keep the
> > > status of the PM domain unaltered during suspend/resume respectively.
> > > The flags are aimed at power domains coupled to co-processors which
> > > enter low-power modes independent to that of the application processo=
r.
> > >=20
> > > Specifically the flags are to be used by the power domains exposed
> > > by the AOSS QMP driver linked to modem, adsp, cdsp remoteprocs. These
> > > power domains are used to notify the Always on Subsystem (AOSS) that
> > > a particular co-processor is up. AOSS uses this information to wait
> > > for the co-processors to suspend before starting its sleep sequence.
> > > The application processor powers off these power domains only if the
> > > co-processor has crashed or powered off and remains unaltered during
> > > system suspend/resume.
> >=20
> > Why are these power domains instead of some QMP message sent during
> > remote proc power up?
>=20
> The understanding I gained as I researched this, was that with this
> property enabled resources related to the particular subsystem will be
> kept enabled when the apss enters some power save mode. So my
> interpretation was that it does "keep something powered".

It looks like it tells AOSS that the processor is booted and to start
considering these processors in the SoC wide system suspend sequence.
Otherwise I guess the RPMh buckets associated with these remoteprocs
don't count in the aggregation and sleep/wake sequences that AOSS runs
through when putting the SoC into low power mode. I'm not sure it
actually "keeps something powered" so much as it lets something be
powered off. Sibi?

Another question, why can't the processors tell AOSS themselves about
their boot state? I guess because they may crash or be powered down and
then AOSS wouldn't know? Fair enough I guess, but I don't think this is
mentioned anywhere.

>=20
> > If this has been discussed before feel free to
> > disregard and please link to prior mailing list discussions.
> >=20
>=20
> There where some discussions related to the "QDSS clk" in that series,
> but I don't remember getting any feedback on modelling these things as
> power-domains.
>=20
> > I find it odd that this is modeled as a power domain instead of some
> > Qualcomm specific message that the remoteproc driver sends to AOSS. Is
> > there some sort of benefit the driver gets from using the power domain
> > APIs for this vs. using a custom API?
>=20
> We need to send "up" and "down" notifications and this needs to happen
> at the same time as other standard resources are enabled/disabled.
>=20
> Further more, at the time the all resources handled by the downstream
> driver was either power-domains (per above understanding) or clocks, so
> it made sense to me not to spin up a custom API.
>=20
=20
So the benefit is not spinning up a custom API? I'm not Ulf, but it
looks like this is hard to rationalize about as a power domain. It
doesn't have any benefit to model it this way besides to make it
possible to turn on with other power domains.

This modem remoteproc drivers isn't SoC agnostic anyway, it relies on
SMEM APIs, so standing up another small qmp_remoteproc_booted() and
qmp_remoteproc_shutdown() API would avoid adding a genpd flag here that
probably will never be used outside of this corner-case. There is also
some get/put EPROBE_DEFER sort of logic to implement, but otherwise it
would be possible to do this outside of power domains, and that seems
better given that this isn't really a power domain to start with.
