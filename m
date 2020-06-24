Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B2DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2B7920768
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vvkd1UY9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404943AbgFXQOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404928AbgFXQOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:14:39 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8661AC0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 09:14:39 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u26so4840445wmn.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 09:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JZwW5G5yWDQn7isXOxX6OgeleecRbTC9nCsi8uj1JNQ=;
        b=vvkd1UY91KCarieRskOqn4JPNlnOQzqs9UCV25dgPU4GhdYxZhq6iQFStm/crcaxZ1
         SaqYy5hyEwv6QKqfAAPLeJbGf/0B1SnbEeLVk/VMLhX4kIdYeVB2OImuZvbdcUcr1mMX
         YeZTk3pgZHj7OpVZtQKE8Dr33AZ8kek8YYU+ib4PNri/SvMiyoYMiixaBBTLqb1HAArs
         tlH7+e+JuVvGychuZMxj1QThYw1Ruf5BZERGQz8bdAA99pfmM/KJrtZFVkWU/t8B2vHv
         1stmNq0PgDpRWSd6JG2kcwPdMzLuoD4seA09IgNmk5ZvsUppndK1TT1CLrqxX7ZHD6mQ
         PDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JZwW5G5yWDQn7isXOxX6OgeleecRbTC9nCsi8uj1JNQ=;
        b=oc0fZmQAbYGX3F7n0RqXjaPpH9T7HgX+eGaPnKYSIYy74TfLGOG3JX5v19uGV6Btw+
         d2bu/d34U/BIVYVbUGehGt2YnR+mQJvCtWvJ3maKLaYlLEgn3bgrB/6na5Y6NromM4sH
         1eXgsvdaZ7xAxl6bcf22XPtri9A2y1srhxJmLiKqySLq/rc0Pi4o/iqTGGg0HJItyncy
         wz1aCuYLq54VJr0wsB9SPGL4qrZR8xNt4E9lbLuqjynAwok0ESagb0q2KAZ8bgXPnLaE
         biNGJautuw+66r2OJCakOVcBAVK3LWfyG8HZAeFcnzFoBtrZx8dEdj762HVZr38bomyV
         di/A==
X-Gm-Message-State: AOAM530YfgGSnib+l2g1F2d77F69FGwRe0DmezRIwdPIYKQ6VdWudDzy
        XQLuCMlu7VrVxns8zpza+Zp8Bg==
X-Google-Smtp-Source: ABdhPJwLF8n1RB43kspzHdY8WTuv/0NWaBJLIc+6JrYaIAS9KX1GtgIjzTREB/louHC0/laR7dJR6Q==
X-Received: by 2002:a05:600c:204d:: with SMTP id p13mr30158147wmg.88.1593015278202;
        Wed, 24 Jun 2020 09:14:38 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id f186sm8428843wmf.29.2020.06.24.09.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 09:14:37 -0700 (PDT)
Date:   Wed, 24 Jun 2020 17:14:35 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     andy.shevchenko@gmail.com, michael@walle.cc, robh+dt@kernel.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux@roeck-us.net,
        andriy.shevchenko@linux.intel.com, robin.murphy@arm.com,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mfd: core: Make a best effort attempt to match
 devices with the correct of_nodes
Message-ID: <20200624161435.GI954398@dell>
References: <20200622151054.GW954398@dell>
 <037c0fd2-df35-5981-7ef2-c6199841650d@gmail.com>
 <20200622191133.GY954398@dell>
 <dc893ce4-8a4d-b7d9-8591-18a8b9b2ea2b@gmail.com>
 <20200623064723.GZ954398@dell>
 <83f2be78-1548-fa2b-199a-2391b2eceb47@gmail.com>
 <20200623195905.GB954398@dell>
 <6684101d-1013-2964-c247-394f9b12a194@gmail.com>
 <20200624074631.GE954398@dell>
 <d7774c42-fd41-9fab-2ea0-cd6bc7d35383@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7774c42-fd41-9fab-2ea0-cd6bc7d35383@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jun 2020, Frank Rowand wrote:

> On 2020-06-24 02:46, Lee Jones wrote:
> > On Tue, 23 Jun 2020, Frank Rowand wrote:
> > 
> >> On 2020-06-23 14:59, Lee Jones wrote:
> 
> < big snip >
> 
> Thanks for the replies in the above portion.

NP.

> >>>> But yes or no to my solution #2 (with some slight changes to
> >>>> make it better (more gracious handling of the detected error) as
> >>>> discussed elsewhere in the email thread)?
> >>>
> >>> Please see "[0]" above!
> >>>
> >>> AFAICT your solution #2 involves bombing out *all* devices if there is
> >>> a duplicate compatible with no 'reg' property value.  This is a)
> >>> over-kill and b) not an error, as I mentioned:
> >>
> >> As I mentioned above, I set you up to have this misunderstanding by
> >> a mistake in one of my earlier emails.  So now that I have pointed
> >> out what I meant here by "more gracious handling of the detected
> >> error", what do you think of my amended solution #2?
> > 
> > Explained above, but the LT;DR is that it's not correct.
> 
> I don't agree with you, I think my solution is better.  Even if I
> prefer my solution, I find your solution to be good enough.

I still don't see how it could work, but please feel free to submit a
subsequent patch and we can discuss it on its own merits.

> So I am dropping my specific objection to returning -EAGAIN from
> mfd_match_of_node_to_dev() when the node has previously been
> allocated to a device.

Great.  Thanks for taking an interest.

Does this mean I can apply your Reviewed-by?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
