Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678CFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D36E206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BuX4Q2f/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389198AbgEYInt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 04:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388367AbgEYIns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 04:43:48 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE169C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 01:43:47 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b6so19894696ljj.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 01:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c9oiGHt9PBJoqyCwwv33bq3uxWQdSndxMSFHyZz70QE=;
        b=BuX4Q2f/lzQJvGFKiZIlqhWhogs8lr3fcw+sZpc6G0plTK1oabro108MGvtaiMSvta
         IzZFgH3+6dAj+mW+ilQ7e/Xl3qGFGW6UnRz++vvMtNvH1Iydo2gAxmFleD0bCTlU4OGC
         WwXgktHERh4xL568BMwGrFum1lfAr0lvZvkgIMvJ/l3p37faF/Pd/c+DTzCgHDQx5ziE
         3q80wbIKz14cHdt0Vuc82XCE2gQN0QuoZWse6gN5xqWX6Gj/Ry9TO1bXYOtWeC4TKK6p
         mXvZxZy6QaF74rDikcFGZuln8XZAp3CRQDDJsLVCEudq94+aVsntxbcgyavrHWMaSvVP
         WM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c9oiGHt9PBJoqyCwwv33bq3uxWQdSndxMSFHyZz70QE=;
        b=SJP+LNsmPgV3kuJFI0Af6CE/lBqgDghlFFuVSHnvjkvJJ0JpW6dTDBf70OMlBISagY
         sDRc++3n71slAZr59IAvFAYk9MBIT8xi5dj5q3im4b//YzCKWlQRj0HTmplLq9EgenKG
         eYtNFKcLYaT/9JcG6htOaqYiDb1szKeku7d1mNx0NqUsGkPSkZBYtSCfJtABhWlvONQY
         d1nclDd6IK/1DhHaSJiJfXtSxfHWFeA2QndJ5qldao/cNuea0tVQ5u75+4/tHHE8m7zQ
         +k3Q3ALbtCAxZ53kbORv+s/k+YDM4a3awdy8O4aEr9/litIsGUQgT/lxF828JzfXisaC
         7Cgg==
X-Gm-Message-State: AOAM531hT+draOddLGwuQm0J5tKU1Y9rMMphT7fpPcLyx7hst0ZT0+Ry
        0GSKK09LQtkCgBJnUEqZv70YV8ZFi6046ozm/1iToQ==
X-Google-Smtp-Source: ABdhPJzJzDb/nbfb/AfHIt2PD8Hlir7+oQAowRn9WMca5ooAz57VzWQdZv5VnV8f24g2bCjQh6/IWZyE5mAFUZu4TZE=
X-Received: by 2002:a2e:3818:: with SMTP id f24mr10278752lja.338.1590396226463;
 Mon, 25 May 2020 01:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200518133645.19127-1-jonathan.albrieux@gmail.com> <20200518133645.19127-3-jonathan.albrieux@gmail.com>
In-Reply-To: <20200518133645.19127-3-jonathan.albrieux@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 May 2020 10:43:35 +0200
Message-ID: <CACRpkdZrcie3Op2aLoTQgwT-2so+s2FqKn0R4B8VQ7qcxz2oCg@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: iio: magnetometer: ak8975: add gpio
 reset support
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 3:37 PM Jonathan Albrieux
<jonathan.albrieux@gmail.com> wrote:

> +  reset-gpio:
> +    description: an optional pin needed for AK09911 to set the reset state

This kind of properties should always be plural, so
reset-gpios please.

Yours,
Linus Walleij
