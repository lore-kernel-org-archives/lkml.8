Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5BAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 00:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA447207ED
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 00:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtsuPBBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgERAsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 20:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgERAsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 20:48:17 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3801C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 17:48:16 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id l19so8006458lje.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 17:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=99zfnT+jlIhxeXf7C8eEbI957pcTZl11keR9XegYgeE=;
        b=NtsuPBBfeEL33RNoTJvk4KDKHPZxPoL5nT8FBW6cqNeNkd2tdfKBLWF/Nofnr2TfkR
         WfPGJL65Oxi+rSWIbNRQ+VQWLZkPj2HXThR5EhgWhs0xwaypVZWO4gkM+DpzfZaOdd1h
         1eQfW+hzDVDhZddBFOw9o9Zg5geXUxs4j/uWk/VGX3jKIT2hbAuPv+kZtEXZGFLk4OGH
         hrNX5qQ6YrIZRWuf8yPYeNLo9qzT5sWv9+QrD56DdGtymCQm64pwXV0FqQh4H+gAZZsg
         tsROiqfGaUH5judBbY0i96U1WP7c9IrGjk9k6iGrO60hh+gw9Y6V+KPx0tsVY7a3uIB+
         9KaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=99zfnT+jlIhxeXf7C8eEbI957pcTZl11keR9XegYgeE=;
        b=FU+NLej9D0qTuUYquMapDGMkeTzwxM/eNyOvJwEI8R+q/U+wq4wP5R4AC5O+PJdVl/
         nq8Enjdl5wGU03lLS7gLDchGA6wL6/mizeZw4c/bHu56PKSrz71Yr1yqJUap6+VYFb3G
         PZpZVGx5vfsdRuE1d/pgV/oueZgIWKyv6iGwZMUi5kRsLk77cBcJWgjky0blKSzG97Ab
         OuMJRcdw8KD+2AZqTx0Rt57gTZwG2n5zoFvqVGNPYVZBXqqOrYXcujzcxfbiEbX9zD+f
         PottQ+aRBqfMyJI5P7Pil143jVdXp6wt7Hm/0Zt52SUizI9jusmRdtFew1HLQM/J++Fo
         vkww==
X-Gm-Message-State: AOAM532gYu1Qj+mWr+uWh2u0RuRC2nm1M572F6emLYFQjEB/WUbVlqXf
        WVU19UXQT86geblwq8EBNs5hUPFiOyoDy77mFN4=
X-Google-Smtp-Source: ABdhPJwtWVqQezl+R0G++NNh4poFaGzeaFqxE4QFP8wtthGe2uE9QL06bgdch8juVQ20JTz/gbJq+ymyF1xss2G2R40=
X-Received: by 2002:a2e:4952:: with SMTP id b18mr8867279ljd.41.1589762895194;
 Sun, 17 May 2020 17:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200515070742.14151-1-steves.lee@maximintegrated.com>
 <CAJKOXPf-Q-e_K-puR-N2NRwQCmaKD=EczzON4rBymvV2CyoiTg@mail.gmail.com> <20200515122948.GD5066@sirena.org.uk>
In-Reply-To: <20200515122948.GD5066@sirena.org.uk>
From:   Steve Lee <steves.lee.maxim@gmail.com>
Date:   Mon, 18 May 2020 09:48:04 +0900
Message-ID: <CABff4NSSpK5bZg9WRJ77+QzR_Z_eNaNcMviAOiNWxHCch_S6sw@mail.gmail.com>
Subject: Re: [V5 PATCH 2/2] ASoC: max98390: Added Amplifier Driver
To:     Mark Brown <broonie@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, ckeepax@opensource.cirrus.com,
        geert@linux-m68k.org, rf@opensource.wolfsonmicro.com,
        =?UTF-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        dmurphy@ti.com, jack.yu@realtek.com, nuno.sa@analog.com,
        steves.lee@maximintegrated.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        ryan.lee.maxim@gmail.com, ryans.lee@maximintegrated.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 9:29 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, May 15, 2020 at 10:42:24AM +0200, Krzysztof Kozlowski wrote:
>
> > Your "From" address still does not match the Signed-off-by. Set the
> > author of commit to the signed-off person.
>
> git commit --amend --author='foo <foo@example.com>'

 Thanks. I will resend patch with matching email with signed off by.
