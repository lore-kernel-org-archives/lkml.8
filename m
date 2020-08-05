Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9140C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B627122D37
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nGyF9IXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgHERhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbgHERgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:36:41 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9BFC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 10:36:41 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g33so7433631pgb.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 10:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=TqHSAMp8R9yjcJhJNY5gQmNjs+yy4KePPVj1aohM6WU=;
        b=nGyF9IXoycCUHVld2Jm4U70zWA2OEiovVVkkhEDR3FzJ7SrBPFe2tSvCO48Zd3PpdG
         rFPVdR6yV87Ms1+TZhRMyWyKIIxGdiidxGJzkdSB3ndJgbdk4TZ2uysIUdsmBSVsP5zS
         tT2iVVfqa3eDiX600obX/fF8KMMUCPgJyPde4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=TqHSAMp8R9yjcJhJNY5gQmNjs+yy4KePPVj1aohM6WU=;
        b=TP9xtc/z9HL1jE8+7ei1OFZjA+KccvdNYS81nhEhJL7kZK0czcdSaruIHHJlcJV2Ve
         vC4ulWPOdYDjrBh8WqlYS5yN2AFUUr4W5e362GyCwT75c4/ZU6FBmMsTjwY/xxJUdQTz
         w6yeO2Bj/uLemdgdMAaXScfaXMYq9Yoo+ZuufwuNwAyGQ9UfrWRrwEg+vIKOZrl9TR2a
         WrrqeoYAmvu04rkLBZs70IeqnvMnE79Y5BsqLhClvni5srmLnV7vxrCb1BSPf+c8WzrJ
         3+3V9sPQ/e3j9KRtE/6U+jltN55Mj3SP35eQBJzjzX0UwM6C/2W8+WMoUBcQN5otHbfl
         h6MA==
X-Gm-Message-State: AOAM5314eobn/TZXOU79t4yA6QdV+ygXkYOW2nRMDPNnsXysTGj86Fdk
        NQpY1L8wpGdSYV0i0rDz5CNUFJ7sxTg=
X-Google-Smtp-Source: ABdhPJyBez3FCD3PduZL9oHarwuFOeuYy5QPWKxvfznYBipmHne+NaoPymbxlbOaPwsJ3TQaYcky6A==
X-Received: by 2002:a65:4502:: with SMTP id n2mr3917439pgq.132.1596649000378;
        Wed, 05 Aug 2020 10:36:40 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id g18sm4350827pfi.141.2020.08.05.10.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 10:36:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200805091141.1.I86b3faaecb0d82997b599b1300f879606c71e116@changeid>
References: <20200805091141.1.I86b3faaecb0d82997b599b1300f879606c71e116@changeid>
Subject: Re: [PATCH 1/2] soc: qcom: aoss: Don't wait for IRQ if we might be in suspend/resume noirq
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Alex Elder <elder@linaro.org>, mka@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Date:   Wed, 05 Aug 2020 10:36:38 -0700
Message-ID: <159664899840.1360974.7548807728313161626@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-08-05 09:16:10)
> Running suspend/resume tests on a sc7180-based board with a modem I
> found that both system suspend and system resume would hang for 1
> second.  These messages indicate where:
>=20
>   genpd genpd:0:4080000.remoteproc: calling genpd_suspend_noirq+0x0/0x2c =
@ 18659, parent: none
>   genpd genpd:0:4080000.remoteproc: genpd_suspend_noirq+0x0/0x2c returned=
 0 after 987917 usecs
>=20
> Adding a printout, I found that we were working with the power domain
> where "res->pd.name" was "modem".
>=20
> I found that we were hanging on the wait_event_interruptible_timeout()
> call in qmp_send().  Specifically we'd wait for the whole 1 second
> timeout to hit, then we'd notice that our condition was true and would
> continue on our merry way.  Sure enough, I could confirm that
> wait_event_interruptible_timeout() was returning "1" which indicates
> that the condition evaluated to true and we also timed out.
>=20
> Dumping the stack at the time of the failure made the problem clear.
> Specifically the stack looked like:
>    qmp_send+0x1cc/0x210
>    qmp_pd_power_toggle+0x90/0xb8
>    qmp_pd_power_off+0x20/0x2c
>    genpd_sync_power_off+0x80/0x12c
>    genpd_finish_suspend+0xd8/0x108
>    genpd_suspend_noirq+0x20/0x2c
>    dpm_run_callback+0xe0/0x1d4
>    __device_suspend_noirq+0xfc/0x200
>    dpm_suspend_noirq+0x174/0x3bc
>    suspend_devices_and_enter+0x198/0x8a0
>    pm_suspend+0x550/0x6f4
> As you can see we're running from the "noirq" callback.  Looking at
> what was supposed to wake us up, it was qmp_intr() (our IRQ handler).
> Doh!

Why is the genpd being powered off at all? It looks like the driver is
written in a way that it doesn't expect this to happen. See where
adsp_pds_disable() is called from. Looks like the remoteproc "stop"
callback should be called or the driver should be detached.

It sort of looks like the genpd is expected to be at the max level all
the time (it sets INT_MAX in adsp_pds_enable(), cool). Maybe we need to
add some sort of suspend hooks to the remote proc driver instead? Where
those suspend hooks are called earlier and drop the genpd performance
state request but otherwise leave it enabled across suspend?

I know this isn't clearing the land mine that is calling this code from
noirq phase of suspend, but I'm just looking at the driver and thinking
that it never expected to be called from this phase of suspend to begin
with.

>=20
> I believe that the correct fix here is to assume that our power_off /
> power_on functions might be called at "noirq" time and just always
> poll if we're called via that path.  Other paths can continue to wait
> for the IRQ.
>=20
> Fixes: 2209481409b7 ("soc: qcom: Add AOSS QMP driver")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> This problem was observed on the Chrome OS 5.4 tree which has some
> extra patches in it compared to mainline.  The top of the current
> Qualcomm tree didn't have the delay, but that's probably because
> everything isn't fully enabled there yet.  I at least confirmed that
> this patch doesn't actually _break_ anything on mainline, though.
