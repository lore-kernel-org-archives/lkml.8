Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57EFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC5102082F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X4t7jax6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgFVTcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbgFVTcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 15:32:18 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E60C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:32:18 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id t6so14083502otk.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kDvWJFrzfpWbkxz8YXuc2rLUJQ0CoVh8mMluFwhFK9g=;
        b=X4t7jax66/02t8oexfXxT0PX6kXxK5rECyLccSKXxOoR/BkGQMHjqxEkJEN2Mm/X5C
         YlhyuvZzjl2K51NtRfnqMTHkwxtI8Uq0QybiLU6lXgXwrWDYh7IL84D9cm5G/+7ATEVl
         OCOfKFp6jJAOR6rkGn2vefwW2qKFVjRwzEs4z6NnDS7PLZU3CwM5YdQVmZ2xtadDm/Fb
         vtQUapslp69ZExR2yYVeVqY7DHLy0vGOCzFNzhhDzqVrZRt45QgeZ3lmcFYM8mkvG4JR
         5t2QO9VHFSR/CJ0E+pOVnXztmWWnD7FvUKEfCiGiWNgIgeoVy/op0sPXg6XwEFxkZpWB
         yNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kDvWJFrzfpWbkxz8YXuc2rLUJQ0CoVh8mMluFwhFK9g=;
        b=A0FPX4Fdhu4SNtHXtFqLYDJoUmIZe6XxUS2ScPOi65g7a5h1l5VUAtGLrWqnkwI1PG
         JoLe28KX27L3QHqQiTYVUa7qZq7uV9S2h/y8z0QLo4SapM9w2cL14veUA7t3bsrWbWc8
         MGayeX/Hrcz6lduxq4Gro9OCdP8SKYjsp0c3yFPhLhTBWY42pUN8l51lifF5jAihcJrG
         mNFriauRFLwaGWWvYO1VeBztPipneA2+o2hLajDPS2cWftxyRJIVmCdvUJ0GKnTXmAja
         nBbxGv3upE35VlLvwzFu73X9plorxkYAJASXsp3/A7h2Tv4Mni4DuA33Qe/42/aRSNJ0
         JWjQ==
X-Gm-Message-State: AOAM53194hXHw5aespQXzkXFCZAd5Qq4KXk2ui+MwOB+pOGoCmeQEb1C
        HwjKro+vgGiDOKjE0PIEAtmUZg==
X-Google-Smtp-Source: ABdhPJw1Yikg9xiPvrCpS0EyuUZHl3QTpNdEklGCVVNVy0Q/IhIJ13yL7Nwk/uZDAT74cBkAEULrRg==
X-Received: by 2002:a9d:67c1:: with SMTP id c1mr14225076otn.27.1592854337928;
        Mon, 22 Jun 2020 12:32:17 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a10sm3630772ooo.39.2020.06.22.12.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 12:32:17 -0700 (PDT)
Date:   Mon, 22 Jun 2020 12:29:32 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Maulik Shah <mkshah@codeaurora.org>, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, john.stultz@linaro.org
Subject: Re: [PATCH] soc: qcom: rpmh-rsc: Set suppress_bind_attrs flag
Message-ID: <20200622192932.GV128451@builder.lan>
References: <1592808805-2437-1-git-send-email-mkshah@codeaurora.org>
 <159281658960.62212.15968925558324290917@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159281658960.62212.15968925558324290917@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22 Jun 02:03 PDT 2020, Stephen Boyd wrote:

> Quoting Maulik Shah (2020-06-21 23:53:25)
> > rpmh-rsc driver is fairly core to system and should not be removable
> > once its probed. However it allows to unbind driver from sysfs using
> > below command which results into a crash on sc7180.
> 
> What is the crash? The world falls apart because rpmh APIs start
> referencing pointers that point to freed memory?
> 

Presumably the devm_of_platform_populate() will cause said drivers to be
dismantled as well - but I think it's safe to say that that code path
isn't well tested...

I've applied the patch, but would have preferred that some time was
spent to make sure that things are unloadable as well.

Regards,
Bjorn

> > 
> > echo 18200000.rsc > /sys/bus/platform/drivers/rpmh/unbind
> > 
> > Lets prevent unbind at runtime by setting suppress_bind_attrs flag.
> 
> Ok. But when the Android module brigade comes knocking they'll have to
> revert this change and solve this problem too. Have fun!
> 
> > 
> > Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> > ---
> 
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
