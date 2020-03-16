Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA52C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F9220658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LIPE1DcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbgCPJFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 05:05:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53161 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730152AbgCPJFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 05:05:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id 11so16680921wmo.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 02:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oPCmoFFrKYp/3bnxyKnj8h+h5zDtfc4YHiEF5mCDEio=;
        b=LIPE1DcKRpwkYjXJp80rvX4cAGU9/MqM+wTuQYV2XeQccBuMGwVzzfZMZdV/0rX1IZ
         Qm2RN3iS7Yuckhw6qzXj/iqokqk2MrfBMwZ4WG557zzePMrkvnw1RPdyb39kwxL4pcqS
         omtTjtr2Rac877d8r0u0J5P8Seq2so58aAmX+2bVVqqgFMGzD8zsdGVsCqreVi5BhH5S
         HZayX/je+fFEPKPZ9R760tKGgYKGMaqNtEzbs7KAhpkXDi4LKCBsW3em1iDTIgYLdlI+
         P2Ms3vB8YII8kY+fqGTwq984TRkifByilceEOHZijm5BCrU0LY1UgXzzohk0DxVmyn8A
         QmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oPCmoFFrKYp/3bnxyKnj8h+h5zDtfc4YHiEF5mCDEio=;
        b=hF5RgYUQRvesX0uXJfk/ifInspeFpTbF3DrgM9KnPRy/GI9Z5POxLiRKlG1PZa4NyJ
         wdeZ3xoCOnvt9O0rRXUut1fNfgIWGKvgvGPemHG7XzP1DTYiSp23KObq0daU8/djchdw
         xUByuMmJBb23Paq1nOy85B9bmxQa7tWTYB98AE1WaGzSIV5qJcb9eZkhyCOqp1/y2ajv
         CoMfGATwg/jWA9jtpunGa5V9j3QgGp8rGwPml8Ild8lPTXi3Fdy4VnvYlu8MbiCJwlLB
         XvQ1qjZAwSc4yHGmX8f3xDluDe6zjHQMme5jZca1/hrvuj96DEBgXjJUiog6bGOKTm/D
         3VsA==
X-Gm-Message-State: ANhLgQ3/gLP/WNTFS0n3ElwPcHqbJtmw4yoOx970mu4I2JB4xbITUJD2
        8aJSU8l+iTP549xbOsMk7TOcVg==
X-Google-Smtp-Source: ADFU+vtTbJN2j0t0MmV90WL70+p4V0kNL8o0e+BtASxYEDGFH4cHMmfu00aobz2Hxf/DkXDDo8qxYA==
X-Received: by 2002:a1c:1f0c:: with SMTP id f12mr26641787wmf.179.1584349549730;
        Mon, 16 Mar 2020 02:05:49 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id f9sm13603031wro.47.2020.03.16.02.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 02:05:48 -0700 (PDT)
Date:   Mon, 16 Mar 2020 09:05:46 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Milo Kim <milo.kim@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] backlight: lp855x: Ensure regulators are disabled on
 probe failure
Message-ID: <20200316090546.5eufi423ahstz6v3@holly.lan>
References: <20200224140748.2182-1-jonathanh@nvidia.com>
 <20200224143732.rreev3ypou26hvx3@holly.lan>
 <6ec74817-968b-ab5e-6566-56bbb9b67599@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ec74817-968b-ab5e-6566-56bbb9b67599@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 02:16:16PM +0000, Jon Hunter wrote:
> Hi Lee, Daniel,
> 
> On 24/02/2020 14:37, Daniel Thompson wrote:
> > On Mon, Feb 24, 2020 at 02:07:48PM +0000, Jon Hunter wrote:
> >> If probing the LP885x backlight fails after the regulators have been
> >> enabled, then the following warning is seen when releasing the
> >> regulators ...
> >>
> >>  WARNING: CPU: 1 PID: 289 at drivers/regulator/core.c:2051 _regulator_put.part.28+0x158/0x160
> >>  Modules linked in: tegra_xudc lp855x_bl(+) host1x pwm_tegra ip_tables x_tables ipv6 nf_defrag_ipv6
> >>  CPU: 1 PID: 289 Comm: systemd-udevd Not tainted 5.6.0-rc2-next-20200224 #1
> >>  Hardware name: NVIDIA Jetson TX1 Developer Kit (DT)
> >>
> >>  ...
> >>
> >> Fix this by ensuring that the regulators are disabled, if enabled, on
> >> probe failure.
> >>
> >> Finally, ensure that the vddio regulator is disabled in the driver
> >> remove handler.
> >>
> >> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> > 
> > Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> I received a bounce from Milo's email and so I am not sure that his
> email address is still valid.
> 
> Can either of you pick this up?

Lee generally starts to hoover up patches about this stage in the dev
cycle so I'd expect this to move fairly soon.


> Not sure if we should update the MAINTAINERS as well?

Sounds like a good plan, yes.


Daniel.
