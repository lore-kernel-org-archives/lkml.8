Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1FEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8876D20792
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RMBV6f6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgFKR6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 13:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgFKR6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 13:58:02 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AFBC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 10:58:02 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x13so7105580wrv.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 10:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qqQFrQ3hX/shpvXWwGDhgGnBTSC3S+c/PjVDVDzS3rE=;
        b=RMBV6f6Vh3v68zzMMHOq3d5aiyVunV3JQHjQMLCK5mcpOiReTC01XShfGzGrwrQ9le
         a4+jjLn21/X563twetGXCugC9XtXko++QhuEG+0XaUmOcHXbW86y6YWyI0SOV7Azz0l7
         W2tymZ5SNSJ/jocsB7hHRw3qS6PhW57rMECOhlc86I/a4T8dxlY7kAM5iLRfgsjbxAFO
         R5NMtjlIia1/y5Gxb/WOAds91fNOnixD4OHfzKqvWw9iYCyIxyZ8F8ID8w7XL3IeqyiQ
         igq2mb4Bl2nogRTuPNp3f9UoK3AS5ItEK82wtNms1G63k/FPVEsO2L4y2JcDRgt8EO1w
         aRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qqQFrQ3hX/shpvXWwGDhgGnBTSC3S+c/PjVDVDzS3rE=;
        b=L6jTSphHXINhBJ9PsniDOnL7gSNUmi0dEmGoFcojkE3zUFoPRUKYibiFish+U1QZVs
         gBCNIN1HbJiYQg85XQvvHKezF8kSy4H7C+QsTk1goObrKyZ48vXiB+Ze/rzeq7vGNLvj
         2RAacC7sTxhjDiLcEOwPbcN+rGpzagBYjz5Q8iVlOyOcTHMOA8LcRoAxUPYRtbhBdNVb
         3frGua2OB1bzuTxjLs1flMg6/k1vxaeS5J9ll/aAjVys4RDqXMNLwKHWfDaYJsfRXQao
         Xo0PEC46vfce8qB7j4qSKBFDBOTYMUh715jcK01FR5E6u5bIQlQ2+eaBW+eIVKE7p3lE
         4Ixg==
X-Gm-Message-State: AOAM533NlqIhgWvmn0pDc4y4XKwYTpqDa5oDRGbeHpnbqx7xLBNNh4H8
        DqijyFvvJhh6vDasCWUz/6j3gg==
X-Google-Smtp-Source: ABdhPJwF+ldQ32ipjGqMh+nSh0lfcFoy4UZXkOMJ83ncLJVxf71MRIhMXWJgqpQ0qjiTsPT0o/sTXg==
X-Received: by 2002:adf:a1c1:: with SMTP id v1mr11031281wrv.205.1591898280460;
        Thu, 11 Jun 2020 10:58:00 -0700 (PDT)
Received: from dell ([2.27.167.101])
        by smtp.gmail.com with ESMTPSA id c81sm5358903wmd.42.2020.06.11.10.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 10:57:59 -0700 (PDT)
Date:   Thu, 11 Jun 2020 18:57:57 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v16 00/11] Convert PWM period and duty cycle to u64
Message-ID: <20200611175757.GB4106@dell>
References: <cover.1591136989.git.gurus@codeaurora.org>
 <20200611165505.GA9335@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200611165505.GA9335@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jun 2020, Guru Das Srinagesh wrote:

> On Tue, Jun 02, 2020 at 03:31:04PM -0700, Guru Das Srinagesh wrote:
> > Because period and duty cycle are defined in the PWM framework structs as ints
> > with units of nanoseconds, the maximum time duration that can be set is limited
> > to ~2.147 seconds. Consequently, applications desiring to set greater time
> > periods via the PWM framework are not be able to do so - like, for instance,
> > causing an LED to blink at an interval of 5 seconds.
> > 
> > Redefining the period and duty cycle struct members in the core PWM framework
> > structs as u64 values will enable larger time durations to be set and solve
> > this problem. Such a change to the framework mandates that drivers using these
> > struct members (and corresponding helper functions) also be modified correctly
> > in order to prevent compilation errors.
> > 
> > This patch series introduces the changes to all the drivers first, followed by
> > the framework change at the very end so that when the latter is applied, all
> > the drivers are in good shape and there are no compilation errors.
> > 
> > Changes from v15:
> >   -  Rebased to tip of for-next.
> > 
> > Changes from v14:
> >   - Collected Uwe's Acked-by for the pwm core patch.
> >   - Addressed comments in pwm-clps711x.c.
> > 
> > Changes from v13:
> >   - Pruned cc-list and added same (reduced) set of reviewers to all patches.
> >   - Added Lee Jones' Acked-by to the pwm_bl.c patch.
> >   - Added Jani Nikula's Acked-by to intel-panel.c patch.
> >   - Added Stephen Boyd's Acked-by to pwm-clk.c patch.
> >   - Addressed Geert's review comments in clps711x.c patch.
> > 
> > Changes from v12:
> >   - Rebased to tip of for-next
> >   - Collected Acked-by for sun4i
> >   - Reworked patch for intel-panel.c due to rebase, dropped Jani's Acked-by as
> >     a result
> > 
> > Changes from v11:
> >   - Rebased to tip of for-next.
> >   - Collected "Acked-by:" for v7 (unchanged) of pwm: sifive: [4]
> >   - Squished stm32-lp.c change with final patch in series
> >   - sun4i: Used nsecs_to_jiffies()
> >   - imx27: Added overflow handling logic
> >   - clps711x: Corrected the if condition for skipping the division
> >   - clk: pwm: Reverted to v8 version, added check to prevent division-by-zero
> > 
> > Changes from v10:
> >   - Carefully added back all the "Reviewed-by: " and "Acked-by: " tags received
> >     so far that had gotten missed in v9. No other changes.
> > 
> > Changes from v9:
> >   - Gathered the received "Reviewed-by: " tag
> >   - Added back the clk-pwm.c patch because kbuild test robot complained [3]
> >     and addressed received review comments.
> >   - clps711x: Addressed review comments.
> > 
> > Changes from v8:
> >   - Gathered all received "Acked-by: " and "Reviewed-by: " tags
> >   - Dropped patch to clk-pwm.c for reasons mentiond in [2]
> >   - Expanded audience of unreviewed patches
> > 
> > Changes from v7:
> >   - Changed commit messages of all patches to be brief and to the point.
> >   - Added explanation of change in cover letter.
> >   - Dropped change to pwm-sti.c as upon review it was unnecessary as struct
> >     pwm_capture is not being modified in the PWM core.
> > 
> > Changes from v6:
> >   - Split out the driver changes out into separate patches, one patch per file
> >     for ease of reviewing.
> > 
> > Changes from v5:
> >   - Dropped the conversion of struct pwm_capture to u64 for reasons mentioned
> >     in https://www.spinics.net/lists/linux-pwm/msg11541.html
> > 
> > Changes from v4:
> >   - Split the patch into two: one for changes to the drivers, and the actual
> >     switch to u64 for ease of reverting should the need arise.
> >   - Re-examined the patch and made the following corrections:
> >       * intel_panel.c:
> > 	DIV64_U64_ROUND_UP -> DIV_ROUND_UP_ULL (as only the numerator would be
> > 	64-bit in this case).
> >       * pwm-sti.c:
> > 	do_div -> div_u64 (do_div is optimized only for x86 architectures, and
> > 	div_u64's comment block suggests to use this as much as possible).
> > 
> > Changes from v3:
> >   - Rebased to current tip of for-next.
> > 
> > Changes from v2:
> >   - Fixed %u -> %llu in a dev_dbg in pwm-stm32-lp.c, thanks to kbuild test robot
> >   - Added a couple of fixes to pwm-imx-tpm.c and pwm-sifive.c
> > 
> > Changes from v1:
> >   - Fixed compilation errors seen when compiling for different archs.
> > 
> > v1:
> >   - Reworked the change pushed upstream earlier [1] so as to not add an
> >     extension to an obsolete API. With this change, pwm_ops->apply() can be
> >     used to set pwm_state parameters as usual.
> > 
> > [1] https://lore.kernel.org/lkml/20190916140048.GB7488@ulmo/
> > [2] https://lore.kernel.org/lkml/20200312190859.GA19605@xxxxxxxxxxxxxx/
> > [3] https://www.spinics.net/lists/linux-pwm/msg11906.html
> > [4] https://www.spinics.net/lists/linux-pwm/msg11986.html
> > 
> > Guru Das Srinagesh (11):
> >   drm/i915: Use 64-bit division macro
> >   hwmon: pwm-fan: Use 64-bit division macro
> >   ir-rx51: Use 64-bit division macro
> >   pwm: clps711x: Use 64-bit division macro
> >   pwm: pwm-imx-tpm: Use 64-bit division macro
> >   pwm: imx27: Use 64-bit division macro and function
> >   pwm: sifive: Use 64-bit division macro
> >   pwm: sun4i: Use nsecs_to_jiffies to avoid a division
> >   backlight: pwm_bl: Use 64-bit division function
> >   clk: pwm: Use 64-bit division function
> >   pwm: core: Convert period and duty cycle to u64
> > 
> >  drivers/clk/clk-pwm.c                      |  7 ++++-
> >  drivers/gpu/drm/i915/display/intel_panel.c |  2 +-
> >  drivers/hwmon/pwm-fan.c                    |  2 +-
> >  drivers/media/rc/ir-rx51.c                 |  3 +-
> >  drivers/pwm/core.c                         | 14 ++++-----
> >  drivers/pwm/pwm-clps711x.c                 |  2 +-
> >  drivers/pwm/pwm-imx-tpm.c                  |  2 +-
> >  drivers/pwm/pwm-imx27.c                    | 48 ++++++++++++++++++++++++++----
> >  drivers/pwm/pwm-sifive.c                   |  2 +-
> >  drivers/pwm/pwm-stm32-lp.c                 |  2 +-
> >  drivers/pwm/pwm-sun4i.c                    |  2 +-
> >  drivers/pwm/sysfs.c                        |  8 ++---
> >  drivers/video/backlight/pwm_bl.c           |  3 +-
> >  include/linux/pwm.h                        | 12 ++++----
> >  14 files changed, 77 insertions(+), 32 deletions(-)
> > 
> > -- 
> 
> Hello Thierry, Uwe, Lee,
> 
> Gentle reminder for this patch series :) Earlier discussions on next
> steps were as per [1] and [2].
> 
> [1] https://lore.kernel.org/lkml/20200522125028.GG2163848@ulmo/
> [2] https://lore.kernel.org/lkml/20200526065935.GA3628@dell/

Not much happens during the merge-window.

I don't have insider info on this, but my best guess is that Thierry
will pick this up once -rc1 has been released.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
