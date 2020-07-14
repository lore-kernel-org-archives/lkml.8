Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7077CC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47A8C224B2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o7Zg0wey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgGNNpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgGNNpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:45:11 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1284C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 06:45:10 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so6128467wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 06:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=smSfqWzZJxpTQw/VqREmipLrv4Sx7Dys34CbnDlAU7E=;
        b=o7Zg0weyxdSjrD0g+eqgXHWEfH1xUQCcFTXIZpziuL+Ae/jug80qQ+38INEd+CeNk3
         OUVkxKRnZx5Z+CCK0LlUJpo2dx5CtPOE/PFy4Y0lIrP7fVs5Zn6L2h+f1Be3FKlF2Vj9
         EgBToUVUcXEue4hVPV5YVs1mCyJRsct0jGA23IhQyB/fVLwQ+hBt7d3acmjW4eIyOi5y
         HgpArNzY9DLbtCP5MG7D5EviZLSLvoQvGJ8BklMgjmnU26hb2iWIlp7lUPpYjJUWOkSu
         3QXpJh7UZ2HMKB5/6TLKPoDaNWwSm6u8QqF+KQRI9FxzdpxYmieTSTXacwN8CGQB4Zzz
         S2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=smSfqWzZJxpTQw/VqREmipLrv4Sx7Dys34CbnDlAU7E=;
        b=e0+EbS/LMn+34IsYVIqz4ksT5kSYgrLtZGqrf8+YeSY6TLD+6IXA4QNKyMzfUEiJpp
         FD1ro0uL5Oc5kAYni6nM+GjVt2p3wUkHMGMnVSqLB/2ShajLEupbioZnFka/z1U1YP2o
         8M7QJQX2yEBbP4srdR51xo/8TjIQxL3utQQQAMfWh0Nd6/w12KNr72hYzU0NpEWHNSA5
         9hr5kPaKhHM2DCRAF0GfLcxvLrRtt5aLDfyYo2qu/ibvW5Z+ALJj0e4B/Pm/4hvRfue5
         P0NkmOdkcYxwJc7GzLvYkVbvsB54OjrkkHYYkWLW6sOnTC5Vxz1/611NYdGe2zCHqeZ5
         LOrw==
X-Gm-Message-State: AOAM530QvCZ4ZFylvBwUd7+Uz2ddReUwbxBEvblFJx6e/n/BdUXHXepf
        dcxY6A8GDvw333YUShUbNDbKIQ==
X-Google-Smtp-Source: ABdhPJziCnTeG9/CGGJq5nJ2MGQ74Vd+XsXnjOYZY5B8Y+Ou8W9YV+1+WO3chgu59IGqHE4wX6r9Lg==
X-Received: by 2002:a05:600c:2249:: with SMTP id a9mr4415026wmm.163.1594734308586;
        Tue, 14 Jul 2020 06:45:08 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id z132sm4901605wmb.21.2020.07.14.06.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 06:45:07 -0700 (PDT)
Date:   Tue, 14 Jul 2020 14:45:04 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 20/25] pinctrl: pinctrl-rza1: Demote some kerneldoc
 headers and fix others
Message-ID: <20200714134504.GA1398296@dell>
References: <20200713144930.1034632-1-lee.jones@linaro.org>
 <20200713144930.1034632-21-lee.jones@linaro.org>
 <20200714131403.eguxpnzsioxfzzko@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200714131403.eguxpnzsioxfzzko@uno.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020, Jacopo Mondi wrote:

> Hi Lee,
> 
> On Mon, Jul 13, 2020 at 03:49:25PM +0100, Lee Jones wrote:
> > Some description blocks are void of any description/documentation,
> > others are missing 'struct' identifiers, there are also a couple of
> > misspellings of function parameter names.  Fix all of them.
> >
> > Fixes the following W=1 kernel build warning(s):
> >
> >  drivers/pinctrl/pinctrl-rza1.c:81: warning: cannot understand function prototype: 'struct rza1_bidir_pin '
> >  drivers/pinctrl/pinctrl-rza1.c:90: warning: cannot understand function prototype: 'struct rza1_bidir_entry '
> >  drivers/pinctrl/pinctrl-rza1.c:98: warning: cannot understand function prototype: 'struct rza1_swio_pin '
> >  drivers/pinctrl/pinctrl-rza1.c:108: warning: cannot understand function prototype: 'struct rza1_swio_entry '
> >  drivers/pinctrl/pinctrl-rza1.c:116: warning: cannot understand function prototype: 'struct rza1_pinmux_conf '
> >  drivers/pinctrl/pinctrl-rza1.c:443: warning: cannot understand function prototype: 'struct rza1_mux_conf '
> >  drivers/pinctrl/pinctrl-rza1.c:462: warning: cannot understand function prototype: 'struct rza1_port '
> >  drivers/pinctrl/pinctrl-rza1.c:482: warning: cannot understand function prototype: 'struct rza1_pinctrl '
> >  drivers/pinctrl/pinctrl-rza1.c:546: warning: Function parameter or member 'port' not described in 'rza1_pinmux_get_flags'
> >  drivers/pinctrl/pinctrl-rza1.c:546: warning: Function parameter or member 'pin' not described in 'rza1_pinmux_get_flags'
> >  drivers/pinctrl/pinctrl-rza1.c:546: warning: Function parameter or member 'func' not described in 'rza1_pinmux_get_flags'
> >  drivers/pinctrl/pinctrl-rza1.c:546: warning: Function parameter or member 'rza1_pctl' not described in 'rza1_pinmux_get_flags'
> >  drivers/pinctrl/pinctrl-rza1.c:575: warning: Function parameter or member 'port' not described in 'rza1_set_bit'
> >  drivers/pinctrl/pinctrl-rza1.c:575: warning: Function parameter or member 'reg' not described in 'rza1_set_bit'
> >  drivers/pinctrl/pinctrl-rza1.c:575: warning: Function parameter or member 'bit' not described in 'rza1_set_bit'
> >  drivers/pinctrl/pinctrl-rza1.c:575: warning: Function parameter or member 'set' not described in 'rza1_set_bit'
> >  drivers/pinctrl/pinctrl-rza1.c:672: warning: Function parameter or member 'rza1_pctl' not described in 'rza1_pin_mux_single'
> >  drivers/pinctrl/pinctrl-rza1.c:672: warning: Excess function parameter 'pinctrl' description in 'rza1_pin_mux_single'
> >
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > Cc: linux-renesas-soc@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Thanks, at the time I had no real idea about the implications of
> documenting with kerneldoc :)

You and 1000 others! :D

Don't lose any sleep over it.

> Acked-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
