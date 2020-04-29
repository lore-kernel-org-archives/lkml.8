Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF13C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 07:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B46C20731
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 07:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GH4EWzGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgD2HP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 03:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgD2HP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 03:15:58 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEB1C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 00:15:57 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b11so1163117wrs.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 00:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=s7R4+bePxKlabVPpFBITsjKfStI3nEAUf2UOkiFno54=;
        b=GH4EWzGOe8RRh5tsgYno8jCZAkddtKCXTHS1m3yl7fQ+4NKt0g+PrVGf82frmw8iKl
         N+q3vfWwP5PPUHwsk2gmo0T9I2o6XsARZCFVfKvS/4aBlPYhYe5FUf0u1OEnHFZLBK/p
         lNnshae4PeebL2my9Ocn2J+xDhwX7Gz1iPlLmud/ZMAcUGVFJFYF6evbchwm8iwt9/mb
         /nYVCjFYkssRhdu3+25LC63wxryG7yABZ1eqhs5FZlPU3fQ5VtJGxyhzVFYohtLda3gP
         1RNGshKrilDAUMU5OM7CCY6EigpKYcz4EoqqyJa0e/41tylu2QZY/OOA5jup8cdqyh/I
         x7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=s7R4+bePxKlabVPpFBITsjKfStI3nEAUf2UOkiFno54=;
        b=P0eOTWxg/ajtx6x7FmigSNxcyZV8raMocQ0uStE0E9V6pPbooYARYlE7SBpFFUDJVt
         K//HYElkgpeANZ07ird1lYhd5XGCW1yBj6RKz+W7ahZTb06Whr1SmAVi7hwX8IP0bZWC
         DrRsPDbkMO9MCr4PoYy/PujrwCYa6zC7PChbZSdbDdBugID1cO11jsSu0C7vkVz9xBVo
         gZSKyrUrm10ZlXo+OVg6gDniUBWsqSf93mvAvTOGfFgeDV0tiUlytu/oq5jOR/hZHUXi
         lYgh39/5++6JbtnaeiWKSauXyFs8N77r5ulI+U2GhEqz2vmfERY15lXxeliZdBISLcBg
         ReaQ==
X-Gm-Message-State: AGi0PuYoR4fNXTVOc0BCOielTBVYoLf2XNJlgaYUm9OAr5OqqYaqMNK7
        t3hHgkFMd7nQ51LHp9CEuOa6tA==
X-Google-Smtp-Source: APiQypIxPrWKn+sWAYVxC4qIaHDqaWSjaUEw9shmYSoUSX1typND6hX5WdtJ3rxd3akJze/lgOcvxw==
X-Received: by 2002:adf:e944:: with SMTP id m4mr36984777wrn.366.1588144556218;
        Wed, 29 Apr 2020 00:15:56 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id h1sm6924529wme.42.2020.04.29.00.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 00:15:55 -0700 (PDT)
Date:   Wed, 29 Apr 2020 08:15:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 4/4] ASoC: wm8994: Silence warnings during deferred probe
Message-ID: <20200429071553.GW3559@dell>
References: <20200427074832.22134-1-m.szyprowski@samsung.com>
 <CGME20200427074843eucas1p1a3a265df0c7f14b0aaec25eb65daf606@eucas1p1.samsung.com>
 <20200427074832.22134-5-m.szyprowski@samsung.com>
 <20200427112202.GB4272@sirena.org.uk>
 <20200428103638.GP3559@dell>
 <20200428111413.GD5677@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200428111413.GD5677@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020, Mark Brown wrote:

> On Tue, Apr 28, 2020 at 11:36:38AM +0100, Lee Jones wrote:
> > On Mon, 27 Apr 2020, Mark Brown wrote:
> 
> > > This completely eliminates the diagnostics which means that if the clock
> > > isn't there the user is a bit stuck trying to work out what's missing.
> > > There should still be a diagnostic.
> 
> > The driver won't defer forever though.  The final pass should fail
> > with a different error.  At which point the error will be released to
> > the system log, no?
> 
> One of the really common cases is that someone forgot to build the
> driver for the dependency so it'll just defer forever waiting for
> something that never loads.

Need to find another way to identify these failures.  There are 10's
if not 100's of cases of silently returning if -EPROBE_DEFER is
caught.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
