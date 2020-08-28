Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6BFC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D14ED2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PDwFjpBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgH1OEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgH1OEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:04:01 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060BEC061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:04:00 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t6so1423038ljk.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rldKsSyO8Mg537CVV+Im8ZTuxYELV9OmrakV1T0wY/Q=;
        b=PDwFjpBrjMGZqRuXHVqS7hGcWTYKK0nnG4+t4VnDXwrYPVxegILF8fCM+bL5bC5R+i
         yPp4FcOpKsEi5sKQTlyxGO4JUuKD623n+0yu9tNbb4ni1xLpESNAIsjp7YXtV6+VxpNx
         vCzX1BsPAV5VmshKr5Jye4VpJNFyO1zvmS/SEHGP4vSRYSUv7un36gcDvaT/Nn13fpE7
         E9ofE5OgFTmcolusEV9tQPn0dxje6oeKeERTdgVT5N1u0q8RENHMujOoqFJgcHYajb4G
         7fYT2amLIXBG6J73nzW/c/7zGDIyT8/CJZ6+IL/UkEHiwyxFLZEHJceh25ux6KmWERMr
         reaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rldKsSyO8Mg537CVV+Im8ZTuxYELV9OmrakV1T0wY/Q=;
        b=AxR6oY59KSUxuy+k5xnDMMvKHW8a3n7GXkoV8wQnysjduqiouJx8efwxF96Ypy1ZOV
         ABj4YQCtabfM5JxHPpMbfnY+ZZZ/riqa3mS84KVIKa4Cgc85eKl9xxZFrcrplouS4aqQ
         LUbFDjzRK2lUAFIEYiQspjbdop4UhlWYBUFjJZWu3fGrdCnXF//qK+zogPrw/K+eWac2
         FWehHOoc4dyzACkW/EWrW9Ruo0fuRx1eqZ+Zh4D/kX6wmDmuZnRcuJ4P5/X+Y6Nqa03b
         3t+UxWIyHcPR4a7ktjM8r87BF9rxO9rRSo0Pkr5ORz3v1PUGwV86Yjf8H+fnWYJX7UpP
         U98Q==
X-Gm-Message-State: AOAM533/1SkF4DfuyRHeXFcChVtPZk7gJLRkL/kVvJi7wA0Ejp3lTELw
        mkiDNACTXcecXShgCztO/go644OZcPxNMUMRYACwqQ==
X-Google-Smtp-Source: ABdhPJy/lRwhYXIy9Li0MsIsJNiilVbU4bVGVdfEhrtNhbXGJ6I+YewRcrBJgEQDzRS6qeXXRhZzPUjCB/O3NeqcRnI=
X-Received: by 2002:a2e:b80b:: with SMTP id u11mr1020983ljo.286.1598623439418;
 Fri, 28 Aug 2020 07:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200826183805.19369-1-andre.przywara@arm.com> <20200826183805.19369-3-andre.przywara@arm.com>
In-Reply-To: <20200826183805.19369-3-andre.przywara@arm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Aug 2020 16:03:48 +0200
Message-ID: <CACRpkdZx3GUaAk=2pEEEGvxH6nUt-UVZh=mTG1VV9ZBevGVU5w@mail.gmail.com>
Subject: Re: [PATCH 2/6] ARM: dts: arm: Fix SP804 users
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 8:38 PM Andre Przywara <andre.przywara@arm.com> wrote:

> The SP804 DT nodes for Realview, MPS2 and VExpress were not complying
> with the binding: it requires either one or three clocks, but does not
> allow exactly two clocks.
>
> Simply duplicate the first clock to satisfy the binding requirement.
> For MPS2, we triple the clock, and add the clock-names property, as this
> is required by the Linux primecell driver.
> Try to make the clock-names more consistent on the way.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

This looks good to me, shall I simply apply this patch to my
Versatile tree (I suppose Sudeep should ack it too) or are
you sending it upstream to the soc tree?

Yours,
Linus Walleij
