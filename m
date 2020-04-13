Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2E8C2BBC7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75FC820644
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EzhotQmc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389379AbgDMV6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 17:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389370AbgDMV6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 17:58:35 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2904C0A3BE2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 14:58:34 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n10so5153270pff.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 14:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=zanq5PiFfynLIaqjhe4HCC3V677M/tJQ472IjXt9D6c=;
        b=EzhotQmc81EkovBvPGN5mWnyxVoPZjd35jt4gmHFoS/MDoopqx2F6mtnF8FpYDLlyg
         GHlPxowzJKV7lWSHJ3bGnC72n5i+KHLmtgF9uVr9nytrj1uHWmH58hfR21V8ll+zaG+U
         kQlgkQJzYehf07UUM8NMQyKNhYoIlTpaHTtGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=zanq5PiFfynLIaqjhe4HCC3V677M/tJQ472IjXt9D6c=;
        b=MNQLeGq5piFrYtJLgK2oAZC3swXyfF8unbT28Bb4EvEdzHjekozIwQS0IMviYWkxgx
         /buWxVCc9ntFDTTIC9QQQFcyoJX3wS1+wZeHfoR+H7pcMQZjCJ0jYhWp4duQidZEpHe1
         QPrlrnn/aYx/3OXwNcFCMsqKUufHiFuJd0TBGI6sJjc+y9GnznIiiYtk7pkE2FbGFdaQ
         XEGjAkVOOoF2JaGBwoHjxQLTc0/L2SvcO32+XXQZXHdMH4duOvfyJWYrmqFMvGUvf0NX
         Zf5Oo2jfYeDG7DBTpz0lOoDUmIdbAGA6eQocHUCTQffwqyzN3hDlMZnYCmLi9ZQnQnxH
         ByGA==
X-Gm-Message-State: AGi0PubM71R9DVExcauxMUgHvzM7nAp8o177Bb5bALjhAkkdspOzgT+h
        NCcl03t5za/ild48ND5j1Sgiow==
X-Google-Smtp-Source: APiQypLAPBU0UL7TF9uElDOEKnMunpNSWEjpFJzNM79HATGSwT2ahcxhwSHtAdm5sUDiC4felm74qg==
X-Received: by 2002:a63:4b16:: with SMTP id y22mr17066996pga.251.1586815114249;
        Mon, 13 Apr 2020 14:58:34 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id i190sm7596797pfc.119.2020.04.13.14.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 14:58:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200413100321.v4.6.I52653eb85d7dc8981ee0dafcd0b6cc0f273e9425@changeid>
References: <20200413170415.32463-1-dianders@chromium.org> <20200413100321.v4.6.I52653eb85d7dc8981ee0dafcd0b6cc0f273e9425@changeid>
Subject: Re: [PATCH v4 06/10] drivers: qcom: rpmh-rsc: A lot of comments
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     mka@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>,
        evgreen@chromium.org, Lina Iyer <ilina@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Maulik Shah <mkshah@codeaurora.org>
Date:   Mon, 13 Apr 2020 14:58:32 -0700
Message-ID: <158681511278.84447.11737265102305118967@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-04-13 10:04:11)
> I've been pouring through the rpmh-rsc code and trying to understand
> it.  Document everything to the best of my ability.  All documentation
> here is strictly from code analysis--no actual knowledge of the
> hardware was used.  If something is wrong in here I either
> misunderstood the code, had a typo, or the code has a bug in it
> leading to my incorrect understanding.
>=20
> In a few places here I have documented things that don't make tons of
> sense.  A future patch will try to address this.  While this means I'm
> adding comments / todos and then later fixing them in the series, it
> seemed more urgent to get things documented first so that people could
> understand the later patches.
>=20
> Any comments I adjusted I also tried to make match kernel-doc better.
> Specifically:
> - kernel-doc says do not leave a blank line between the function
>   description and the arguments
> - kernel-doc examples always have things starting w/ a capital and
>   ending with a period.
>=20
> This should be a no-op.  It's just comment changes.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Maulik Shah <mkshah@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index c9e5cddbc099..f0a7ada0c16f 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -171,12 +171,38 @@ static void write_tcs_reg_sync(struct rsc_drv *drv,=
 int reg, int tcs_id,
>         }
>  }
> =20
> +/**
> + * tcs_is_free() - Return if a TCS is totally free.
> + * @drv:    The RSC controller.
> + * @tcs_id: The global ID of this TCS.
> + *
> + * Returns true if nobody has claimed this TCS (by setting tcs_in_use).
> + * If the TCS looks free, checks that the hardware agrees.
> + *
> + * Must be called with the drv->lock held or the tcs_lock for the TCS be=
ing

I think we have 'Context:' for these sorts of things.

> + * tested. If only the tcs_lock is held then it is possible that this
> + * function will return that a tcs is still busy when it has been recent=
ly
> + * been freed but it will never return free when a TCS is actually in us=
e.
> + *
> + * Return: true if the given TCS is free.
> + */
>  static bool tcs_is_free(struct rsc_drv *drv, int tcs_id)
>  {
>         return !test_bit(tcs_id, drv->tcs_in_use) &&
>                read_tcs_reg(drv, RSC_DRV_STATUS, tcs_id);
>  }
> =20
> +/**
> + * tcs_invalidate() - Invalidate all TCSes of the given type (sleep or w=
ake).
> + * @drv:  The RSC controller.
> + * @type: SLEEP_TCS or WAKE_TCS
> + *
> + * This will clear the "slots" variable of the given tcs_group and also
> + * tell the hardware to forget about all entries.
> + *
> + * Return: 0 if no problem, or -EAGAIN if the caller should try again in=
 a
> + *         bit. Caller should make sure to enable interrupts between tri=
es.
> + */
>  static int tcs_invalidate(struct rsc_drv *drv, int type)
>  {
>         int m;
> @@ -624,6 +798,23 @@ static bool rpmh_rsc_ctrlr_is_busy(struct rsc_drv *d=
rv)
>         return false;
>  }
> =20
> +/**
> + * rpmh_rsc_cpu_pm_callback() - Check if any of the AMCs are busy.
> + * @nfb:    Pointer to the notifier block in struct rsc_drv.
> + * @action: CPU_PM_ENTER, CPU_PM_ENTER_FAILED, or CPU_PM_EXIT.
> + * @v:      Unused
> + *
> + * This function is given to cpu_pm_register_notifier so we can be infor=
med
> + * about when CPUs go down. When all CPUs go down we know no more active
> + * transfers will be started so we write sleep/wake sets. This function =
gets
> + * called from cpuidle code paths and also at system suspend time.
> + *
> + * If its last CPU going down and AMCs are not busy then writes cached s=
leep
> + * and wake messages to TCSes. The firmware then takes care of triggering
> + * them when entering deepest low power modes.
> + *
> + * Return: See cpu_pm_register_notifier.

cpu_pm_register_notifier()

> + */
>  static int rpmh_rsc_cpu_pm_callback(struct notifier_block *nfb,
>                                     unsigned long action, void *v)
>  {
