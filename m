Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F92DC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 12:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 374372078A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 12:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BtJw29RQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbgH1MnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbgH1Mmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 08:42:39 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FC1C06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 05:42:38 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w25so1115582ljo.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 05:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/5zqwAk7r19VbbapnJvQ3irBLvFfiJZbIrHezMmTPXU=;
        b=BtJw29RQNERRIfGfc1w5ErhoaKY+Tsu7I6WxNhT3vLOsTDSFDLx89zfGMvxIuLxUJL
         b5SYvgCTVkgF/w/upA4EtTZXa7cOph2XTjLSV3VL5TQ0qYrScLNEgIjQpubBlz9GECYm
         M6zBALTIZt9kZ6IT+cTSHmofWoT5mZQnQUDLzrc99HOp3gCbSZKx1E96DC/SiolCEMzF
         x5v10M1uV7wwhPhfoFUvy2qnD5epm4TLqZQS/ckI60spjubZY7ztBP4jHmr8kABXBwwV
         g5YGR68fM0NILHEso5Ltw/K6CbviyjKc/6uXFBxaGlbtucr14wWyPdjiHhGyAqZVZaE1
         DNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/5zqwAk7r19VbbapnJvQ3irBLvFfiJZbIrHezMmTPXU=;
        b=K81WG+L+GVLbiF5jptvgJLpoZkKM7FxEAzAv1c2Kvc2YSgJAjefJ4rzhZX5ghfVe/7
         lvWf2ebU9OaOzB+2/rqLPRclR1ptCXZdswCgvDcyRRn0CmfHKAAMa6fIwhWFsuumkPLE
         S30C2ZOs3ygRa+YQVKtqWBGlKSLE0/KDh0QoOt64rZoamvp+/in93H5/KLaBHA+aiKbi
         hO+dJR/8IpEUU+ebWvpTBBNutCMsLDjdWy0wupDHPUvByx9u60UTtyAzfWtaEsV/TlzW
         UVkVUlFvNyiGcAgBOVouHRYyIem/Fd4OU5Yi/uL05dDfyrgCNwiNbhoNRKNBR1BLzYM5
         p2ag==
X-Gm-Message-State: AOAM533AEgGlzb2GejNlvgRcmckRaW5AeoSQaxqGl3A3JegSeT5qmwq2
        pqeceB6QRldUSfA3hKXaj/MKwVjCUq+ahsjVeS+tPQ==
X-Google-Smtp-Source: ABdhPJxFJ+sPiCIUWaiBfJG6iVO8KI14e9lM1TexLLLZYSIPaYndoG33IsNrNvGWZQUjYZGGzvFSbia1xjrzAgHOAB4=
X-Received: by 2002:a2e:558:: with SMTP id 85mr826002ljf.293.1598618556891;
 Fri, 28 Aug 2020 05:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200825143348.1358679-1-thierry.reding@gmail.com>
In-Reply-To: <20200825143348.1358679-1-thierry.reding@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Aug 2020 14:42:26 +0200
Message-ID: <CACRpkdajUgrcjWPHZ60OxpXmo7FFH8ytspHoFLt-FZoTymKAPw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: devicetree: Keep deferring even on timeout
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 4:33 PM Thierry Reding <thierry.reding@gmail.com> wrote:

> From: Thierry Reding <treding@nvidia.com>
>
> driver_deferred_probe_check_state() may return -ETIMEDOUT instead of
> -EPROBE_DEFER after all built-in drivers have been probed. This can
> cause issues for built-in drivers that depend on resources provided by
> loadable modules.
>
> One such case happens on Tegra where I2C controllers are used during
> early boot to set up the system PMIC, so the I2C driver needs to be a
> built-in driver. At the same time, some instances of the I2C controller
> depend on the DPAUX hardware for pinmuxing. Since the DPAUX is handled
> by the display driver, which is usually not built-in, the pin control
> states will not become available until after the root filesystem has
> been mounted and the display driver loaded from it.
>
> Fixes: bec6c0ecb243 ("pinctrl: Remove use of driver_deferred_probe_check_state_continue()")
> Suggested-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Just like with the identical patch from John I got a while back, I'd like
some nod from the device core maintainers (Greg or Raphael) that this
is how we want to do things.

Yours,
Linus Walleij
