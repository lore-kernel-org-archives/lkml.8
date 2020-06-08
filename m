Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A226C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 461CC2068D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wki+dDfE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgFHTZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 15:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgFHTZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 15:25:29 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB35C08C5C3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 12:25:28 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r7so18735257wro.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 12:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mxhIGg2cqw/XPpjpdkJxjIWYKGlCg1JDkmDrxitivV0=;
        b=Wki+dDfEOx3kuXRK+0nd8CQVmYMtGONVjSJ0CpY4bqVlR6pKRBsGxFhvST7jSBd/nu
         lwCgE8jIyWk6DG440Ct3cbpaBp8xUef4NsWL1Jog+ra+Ni5Vk0HEwG911gY+gHoJkAd6
         UFjvY0Nf8yaU6dFsgNu/Iwmed1BJTj1Csr3fDu8b0dq1sgC3EspY5WgW9MEDv/R4TJ1O
         IRFnUC63VOciy7ODCbAZ9qho4x3FX4vE4rcqv+kK7HLDhRq/gfdTSmv92nLqKOV8IG3C
         FuMcKLcSHJgDP6xG3GuiZsj4Auv32h4sDbD5A0ogpKPTVd7lmh+IiTN0fBxoT5MxAanj
         EUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mxhIGg2cqw/XPpjpdkJxjIWYKGlCg1JDkmDrxitivV0=;
        b=i/TuDT4ZINJWTYwVVVwbQR9prB5De2Y1sgquKCGTf9k+rGrat1EmExWz6lham+CDxD
         BAAk+TmNE6OJVGME3KEw13WpxvxI7rDTZ4LZwiHKgg59POpF+AlG9EWIwq4djEKSo8J/
         mU+MKPxXYIHg8bO/2WLNwUGqIeSgFTGckk01qrJVA5qPXdJmRfZP1F1IFSIEXGCiQwEb
         aSFd6L32jRigjfElmZL8I3ocgyFply1QiOpko0/UE6NFYOn9nCf0221y0anm6p5iwuOL
         NSx30wMMO/QxEeS/xFsxUDsDG4gkH+2i8lKjRd+fioYsvk6v2IqSgva172pGvFrXgrzD
         Af5A==
X-Gm-Message-State: AOAM5313q8S2CXTV4DfzrhOCDAvWUCmnaeokJTv+Eh3FfQWPsbrYydLT
        JMVihW4gg1Thf7v7AZr8nuw7Tw==
X-Google-Smtp-Source: ABdhPJyI9mGXeNtCefguGgkN84Z6BMGgUJsgmPkK8phVYm55kKWSXwGkpNK7uvgqjHjERUfVR7OTUg==
X-Received: by 2002:adf:a34d:: with SMTP id d13mr324885wrb.270.1591644326744;
        Mon, 08 Jun 2020 12:25:26 -0700 (PDT)
Received: from dell ([95.147.198.92])
        by smtp.gmail.com with ESMTPSA id z206sm472761wmg.30.2020.06.08.12.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 12:25:25 -0700 (PDT)
Date:   Mon, 8 Jun 2020 20:25:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 3/6] mfd: core: Propagate software node group to the
 sub devices
Message-ID: <20200608192524.GF4106@dell>
References: <20200608134300.76091-1-andriy.shevchenko@linux.intel.com>
 <20200608134300.76091-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200608134300.76091-4-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Jun 2020, Andy Shevchenko wrote:

> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> When ever device properties are supplied for a sub device, a software node
> (fwnode) is actually created and then associated with that device. By allowing
> the drivers to supply the complete software node group instead of just the
> properties in it, the drivers can take advantage of the other features the
> software nodes have on top of supplying the device properties.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/mfd-core.c   | 31 +++++++++++++++++++++++++++----
>  include/linux/mfd/core.h |  3 +++
>  2 files changed, 30 insertions(+), 4 deletions(-)

I'm not sure a change to the API is justified presently (same does go
for 'properties' really, but as it was only a couple of lines, it
didn't seem too intrusive).

My recommendation is to handle this in-house (i.e. locally in-driver)
for now.  When (if) more users adopt the practice, then we should
consider to draw down on line numbers and repetition and make it part
of the API.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
