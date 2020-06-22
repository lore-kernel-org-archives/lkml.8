Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0492EC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D422B207C3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cnVX3sYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgFVIKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgFVIJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:09:18 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDF2C061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 01:09:18 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 17so194916wmo.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 01:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lPM2dXcZWsfdanvmWpEJKe0oZi4Qaag02Vnv/2CyipI=;
        b=cnVX3sYPQCbhNmRKFn9tmv4J3PekwjpwF6bfi8cMBn2SGOb6LT/dVyM7wombRqgxpA
         is2ldG64YjU0yLCBODga9bjLY4rweVKScALDadK0DPBSHD4GQOASqFj2EfFbNg8jF5lQ
         hxWMa9gmc6n2o6E0PbjkRrnQOmKKOs/aagbN1jFEHRseJdungrzUTi2gvS28rxskZBwm
         lZ0woZ21p3kH6TUzjauOlKzuWgYiN79rDsW4inREu727cglKBj0bkV/0h9HnUAX29Hqw
         AeJcAhMaKyMZdK+GnP4kqbAz2ECNuKxVqw4mPqXf2oOYLgMcPpQostHQYYi1s3+TjFlr
         3PEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lPM2dXcZWsfdanvmWpEJKe0oZi4Qaag02Vnv/2CyipI=;
        b=NTwTCPLAOU+nVvJkdUgincC0F8LNjbFidSN+ruR6eSC4wptottzjH5Y/h8ig1Uh88p
         wDRquV+yabotqhFSsbOUQ58xPov38CM0ynjTMI4hpot+vVeQyBnIaZlqwcnKmX7NbYA/
         PAOLiKKyD7IDzNW7WoM6FS3EaM8ETFu5op+1hpm+PLR3FXqvy+rLVu0jS2rzBo5zzQDP
         4OHUDKGIL6sFFazWMwziUom7uWfdzOvj47cALzgDIzMBOJ9Xd3WfxG9pFE5qJzsEgmcb
         ajmavcOkkf7GdY7TRcS4ktzX6BfeJ+PRtbZu3byD40ncCbuCAVB/N5vRKYtsEc6anlaz
         bppg==
X-Gm-Message-State: AOAM530/+D/CHxhc3T2Zh2vRiyOoLNh+4xjbFNAuNa/B3ts28vAwsOtR
        4mixcXrc3blRt5eXJtn/2Pn6JA==
X-Google-Smtp-Source: ABdhPJzXTmJsexAMbC4fSFp/DV4mASBv8rG1X3KfMPe08q1ag1abOMxR5jA/eGxpEBtIkM/LyOFmSg==
X-Received: by 2002:a1c:9cd3:: with SMTP id f202mr16240567wme.64.1592813356869;
        Mon, 22 Jun 2020 01:09:16 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x18sm5883006wrq.13.2020.06.22.01.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 01:09:16 -0700 (PDT)
Date:   Mon, 22 Jun 2020 09:09:13 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     andy.shevchenko@gmail.com, michael@walle.cc, robh+dt@kernel.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux@roeck-us.net,
        andriy.shevchenko@linux.intel.com, robin.murphy@arm.com,
        gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mfd: core: Make a best effort attempt to match
 devices with the correct of_nodes
Message-ID: <20200622080913.GO954398@dell>
References: <20200611191002.2256570-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200611191002.2256570-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jun 2020, Lee Jones wrote:

> Currently, when a child platform device (sometimes referred to as a
> sub-device) is registered via the Multi-Functional Device (MFD) API,
> the framework attempts to match the newly registered platform device
> with its associated Device Tree (OF) node.  Until now, the device has
> been allocated the first node found with an identical OF compatible
> string.  Unfortunately, if there are, say for example '3' devices
> which are to be handled by the same driver and therefore have the same
> compatible string, each of them will be allocated a pointer to the
> *first* node.

Any more reviews/comments before I apply this?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
