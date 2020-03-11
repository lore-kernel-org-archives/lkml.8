Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B7CC18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 00:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99DB21927
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 00:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xvp73QVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgCKAf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 20:35:58 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34771 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbgCKAf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 20:35:58 -0400
Received: by mail-vs1-f66.google.com with SMTP id t10so239737vsp.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 17:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dj9AJ6DgaDsv1owS/OBbLL2hfYDA+jQ+pn99BxM6NK0=;
        b=Xvp73QVkE935ImkOQZQ+bEOpPwsbuCXEDpTploRsshH27YQ78Xl8+Y0jFMALJsZJZr
         COzdzjlC79Gv7YvIvlLm5q5CV+nQ2Ev6nEv7Vjcy3ZClRMVySqOoIRpKLvz0puB76HFz
         JEwAyCg6gASt+sShiUPPEjJJxdmcSiyvoLNac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dj9AJ6DgaDsv1owS/OBbLL2hfYDA+jQ+pn99BxM6NK0=;
        b=Dd8Oi6M9ocvyZv+vy4A3fuLZunpoO65aCL5nr6QninG6yeNyh5r7V/WnlICrHtkBZF
         O7pN0TSC75kTPZKylT2PHSESspDPVmOY1GvDcW3ktmGucfizAfK4BiqioxaE02NH71om
         N0akyZdFgbf7om2EdkYswnWEF5tOgblVYNta8I7a0Dl4gMTGED5vUWwvRZ2dnPyt05RZ
         Xy3O5ByVJHKoRxzF1+69x4Aa4B5Vgx6AJKdvYHsxpTeGBjOTx1roSCkFXWnOVMYM/Hqz
         0qWQnfEGmnAVzhUtYbsMkEL447uAS0gNIC33nE1rix0iiuvfS4R0G3Txj1doWiRvjSHi
         creA==
X-Gm-Message-State: ANhLgQ3AHsBE6GMOXd6BC6zTgLVtQ+otBMvhfH97/VjI8BnBajIokjat
        GVvQbQHtiVKAMXkm0ZQwxdrZWpr9jH8=
X-Google-Smtp-Source: ADFU+vv0FsyfBydr4Cj57x4IFdXQ8aEjP5S5/X2DkgCqvbEDC2XgaA3pZMexUgBtjgLSFIBBEFuwog==
X-Received: by 2002:a67:fbcd:: with SMTP id o13mr469863vsr.174.1583886956716;
        Tue, 10 Mar 2020 17:35:56 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id i66sm13856047vkh.28.2020.03.10.17.35.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 17:35:55 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id z125so198824vsb.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 17:35:55 -0700 (PDT)
X-Received: by 2002:a05:6102:1cf:: with SMTP id s15mr403204vsq.109.1583886954828;
 Tue, 10 Mar 2020 17:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200306235951.214678-1-dianders@chromium.org> <20200306155707.RFT.9.I6d3d0a3ec810dc72ff1df3cbf97deefdcdeb8eef@changeid>
In-Reply-To: <20200306155707.RFT.9.I6d3d0a3ec810dc72ff1df3cbf97deefdcdeb8eef@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 10 Mar 2020 17:35:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UrUMSf9005eCta0rf=4BaSWNGwTDsuja2pFtqauaC25Q@mail.gmail.com>
Message-ID: <CAD=FV=UrUMSf9005eCta0rf=4BaSWNGwTDsuja2pFtqauaC25Q@mail.gmail.com>
Subject: Re: [RFT PATCH 9/9] drivers: qcom: rpmh-rsc: Kill cmd_cache and
 find_match() with fire
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 6, 2020 at 4:00 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> @@ -889,12 +793,6 @@ static int rpmh_probe_tcs_config(struct platform_device *pdev,
>                  */
>                 if (tcs->type == ACTIVE_TCS)
>                         continue;
> -
> -               tcs->cmd_cache = devm_kcalloc(&pdev->dev,
> -                                             tcs->num_tcs * ncpt, sizeof(u32),
> -                                             GFP_KERNEL);
> -               if (!tcs->cmd_cache)
> -                       return -ENOMEM;

During later code inspection I happened to notice that the "if" test
above the code I removed can also be removed.  I'll do that in v2.
The code after the v1 patch doesn't hurt, it's just silly to have the
"if (blah) continue" at the end of the loop.

I'll wait on sending a v2 until I get some testing / review feedback
on v1 or enough time passes.

-Doug
