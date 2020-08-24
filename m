Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1711C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94DD42074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzAfXB96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgHXTEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgHXTEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:04:06 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBD7C061573;
        Mon, 24 Aug 2020 12:04:06 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h19so10916919ljg.13;
        Mon, 24 Aug 2020 12:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=USWdSH85MLPCvRv3jIctUSCKGBhD/KP3Vil/oo0Sdlo=;
        b=dzAfXB96+Fj8h140QgfMjRnhKd5SULprrzZjn/ElG10SRsaNP6UF3yncDmw75rqGK0
         3evZq0txNSdfXl2ZDqtrITg9KbNyXUEnZJEIXcUg09S95tjK+JXVlqjXeD8/FMXvVYG9
         TEe4sjaHHnKmPzoZD6BmmT72TVFxVZjLxS09Qexbv3pwEDCj8b19rCFVKvtrQbUPiFLD
         o6kgOXcZz1Yl2znZfW0McFtfjiA3+pl8LfiMHDm6vIbv4ztq6VCrJq7xQ18idk5wo/Is
         01IMqHexmpWp3zrlUw1RcUgp0mNUhGNdl64cpmt0dTO1E1ZG0eTpDqkXcqv6JiTS7VMP
         gRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=USWdSH85MLPCvRv3jIctUSCKGBhD/KP3Vil/oo0Sdlo=;
        b=eJ7uDqi8gxfvIzUmgw1SltNtW3/Co75LWBFGYwWuJe85B8wFNTD/YpD3UebpXT8I3B
         Lh0NUIkLz9uww1W4f1dPs3YFCvnNomO9Tx79OoZY8fW1q0OwwJi1voEGBddNbwViG7N2
         Tj3To6srkrELdRbHmnh/Q5iM3c6uKrtqZi6+LyX/D9SziavlmnrxxWRQnxcBczz3n4wd
         xKfdcK+vsyc7UTsOTNL6I3aTIP85a/dMwRoJl12ZkvNb0KrZNYS9pebfpEmfH3/1Nhqh
         4pyoHOjVBo7ZGyYQNfCT/hZvqFQ6TSc5HmHjeaT4XR6VplIADOPNkAI0alVc3AMYBxA7
         FMbg==
X-Gm-Message-State: AOAM530Bouoxi0WkAsRwMIKmaEPyOM5UrZTSsN0imeSLAK6r+lS1H2BG
        WD2b4aVGHX5aDBSaJEqtLC41VV+hnG2h2+P2br2MNccgYzE=
X-Google-Smtp-Source: ABdhPJx5LoVa80DFxxsFAsqtTu9yB7rSnKi9LAMKmcVHEEEScaLV3pqtzL2kf2xsjzm64BZcniPy73W9Ucj/aU74FbA=
X-Received: by 2002:a2e:5cc9:: with SMTP id q192mr3262548ljb.452.1598295844638;
 Mon, 24 Aug 2020 12:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200824160247.19032-1-krzk@kernel.org> <20200824160247.19032-3-krzk@kernel.org>
 <CAOMZO5DquPR9BmQP0kZfTqNJmRabPe1Vtc801M9CVCPFCd1usQ@mail.gmail.com> <20200824185713.GA5343@kozik-lap>
In-Reply-To: <20200824185713.GA5343@kozik-lap>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 24 Aug 2020 16:03:53 -0300
Message-ID: <CAOMZO5B71L7+d_bUY2D=fjhhg5QFEnTsq=U84+7k9nhhmxV04g@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] arm64: dts: imx8mm-var-som: Add Variscite
 VAR-SOM-MX8MM System on Module
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 3:57 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> True, I'll fix it up, thanks.
>
> Any comments for the Symphony DTS before v4?

It looks good.

One suggestion is to remove pinctrl_pcie0 for now and add it when PCI
support is in place.
