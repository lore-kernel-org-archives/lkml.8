Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCBEC433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CFFE207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bXWkGcM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgH1OyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgH1OyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:54:15 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40241C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:54:15 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id t6so1614235ljk.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EaaDnpIAd/0N0TJd1zen3eByHC6IpKh9i3Fpiy9qR/k=;
        b=bXWkGcM/3QvfdQoTxvuWnsiCIP6Ks+5QoU4VaVvISf+Dna3kvGIf6YZZW66m/GT4JL
         PToRSL1UdKdKcIRp/NNDz8whnwPjThqKj6jx55L92BmFeS9sdTVR77YlyqC1R4+bYf3a
         0X5PUCqg7TQKLymp1mQfeCWX8MWIuh+srrDFX81wbr413tv5IMWBt61vCG65v5w6l3OJ
         cioSvCbVjk1Izwh4cFysn6/9JWEoMlhvRUiI7s5FXKbYIXVqJqna4lAMVyjXZHvj/jHF
         ad3QnxLOv9C/Vj0qCJ53ciUSg5YwV3wqVYOOtAxhYvw33D4RVWYNfox9o6ZK67/Qma7M
         LvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EaaDnpIAd/0N0TJd1zen3eByHC6IpKh9i3Fpiy9qR/k=;
        b=jv/1GB3F0yq5y/FBHIEfZn/eQ8feLLxc5c6SkaZWqOYvWbtjoarX7jhGoT0cESjkLs
         2UIj2WLt3qy5YXzdN/CcPxbZ13ASf9WfQIbP8NrEuLw5UjtRnlRltiaZG9dTcjfbDsJ5
         F9GemssCPFsdc9jyYB6ZRcL27o5O4lZKFIVPt7N/Pcy7d+gVJ7GOStQe9knawftUg2r0
         t0U/NEDkoZzUF3Tujue/k/c/U8m5Cxi4r/rrhscESaPblspDgFlhrSFaXMcgfB/uu6I2
         2UY1NnC9otLylstZnaLIQxyAzDp9GQ0mFFJXApQrXiuuS4AXBaJcPp8M5recGTpmc+dw
         xKXg==
X-Gm-Message-State: AOAM5317eTbrPS0UxXHAVafG4G0LEZwE6BLx8SLWsZ4ije2xoqTfXseh
        DE6X29wOKsTwHRTvsJ8oB2Icm5HlNfjqBbdvg2oBeQ==
X-Google-Smtp-Source: ABdhPJw/f0HJ8MCYMcu1gB0bXpSqkJ9CYpXN9gEZm4uK0TEZUd3ZGEkcmGUeF/RM7NNZxPKum8shT+U99APw0soiIZ8=
X-Received: by 2002:a2e:6a17:: with SMTP id f23mr972357ljc.338.1598626452983;
 Fri, 28 Aug 2020 07:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200828142018.43298-1-andre.przywara@arm.com>
In-Reply-To: <20200828142018.43298-1-andre.przywara@arm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Aug 2020 16:54:02 +0200
Message-ID: <CACRpkdZUrPeUbpNeCZcw8kq5k3egijAuh7R1_3TkbPz5wN+=Lw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] dt-bindings: Convert SP804 to Json-schema (and fix users)
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chanho Min <chanho.min@lge.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wei Xu <xuwei5@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 4:20 PM Andre Przywara <andre.przywara@arm.com> wrote:

> This is the second attempt at converting the SP804 timer binding to yaml.
> Compared to v1, I forbid additional properties, and included the primecell
> binding. Also the clock-names property is now listed, although without
> further requirements on the names. Changelog below.

The series:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

> I couldn't test any of those DT files on actual machines, but tried
> to make the changes in a way that would be transparent to at least the
> Linux driver. The only other SP804 DT user I could find is FreeBSD,
> but they seem to use a different binding (no clocks, but a
> clock-frequency property).

That's annoying. I suppose FreeBSD just made that up and doesn't
even have a binding document for it?

In an ideal world I suppose we should go and fix FreeBSD but I have
no idea how easy or hard that is.

Yours,
Linus Walleij
