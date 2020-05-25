Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B06C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE666204EF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vQj9QTA/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390343AbgEYLqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 07:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390326AbgEYLqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 07:46:36 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D83C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 04:46:35 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m18so20425358ljo.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 04:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bWYfxIAWJy3heGwDbod2HfNErYY2yOdF0+bL0dgrzOk=;
        b=vQj9QTA/DYg7DsXQPvNV6nUI3a1yOwQ0VWk/U90mDlQ+3gSPHznwIlKZyHy5k+jTf5
         TmTOR4mRbWMy8bWaGbSjNkS4vLc5io5opo3fEHfWbxwNXLhasackcimYv1hG3hTuWztm
         aOhePHz6h4Pt1j6cIVD8yn7Kpd1IORvt05AFGF8MRJQBM0exJAOG8K/VmeH8OmefyeCd
         Llf3CtTVnB7HB15c88DYuKUBvV5Xi7IkN8BANcOBFrs3Ri9rQfE1X1neP1HvwWCc4cbf
         Wf09jsYaD55J1NkY54FHhGosQmbzGZ0rv2+u4sGszipJPKvqcrC/IoXwHicrKzN3xhjB
         v6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bWYfxIAWJy3heGwDbod2HfNErYY2yOdF0+bL0dgrzOk=;
        b=YtBWkxywEFQtEBLVUYRGFWIt2pfRnupbYCiTMR1u/2kOLH6/E+MF20OhIZfhvz9Yed
         7YcRF2VRoM4HotaOGZy9UuGwNa82i2pNOqIzGJJ5TvSFPPMLCFA8em1yfAi260GKxST3
         OGI95t5wsLzlRLIi/T29TxfmSwkpgfEgQD7NiNRtAb+QiUaWZjmlHJWttsURKQeyGhGP
         L2pkyA+MxEIKMmY78ul1ZnF88w3V/X9b8zqP9f+aNmbOvIMKM59O0lAmC+lthk8r8bEk
         6vrHZjt8vSE/PNCjP4X/ABtSMjWADeO4uxqLQWLXbg2XJ75DpQsRwD+q4xIvvF0CWTvt
         2iaA==
X-Gm-Message-State: AOAM530KL1DZyCXD8thSEtSrDZtPSTE1UfN20XYSsknSWTrDVkp9gc7f
        sAoxoXmA2D8usQcgUbxdwdqCKXsQyIGLCilW7QShbA==
X-Google-Smtp-Source: ABdhPJzXMklVyxm7HDHg3O3m/NvqorX6wkSQG4H/xaCPXxKdEbCUmEhq/fmnpSE8dPrcbHFjkt73KKvjjV+jtcSincc=
X-Received: by 2002:a2e:711c:: with SMTP id m28mr13382847ljc.104.1590407194394;
 Mon, 25 May 2020 04:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200523170859.50003-1-sudeep.holla@arm.com> <20200523170859.50003-6-sudeep.holla@arm.com>
In-Reply-To: <20200523170859.50003-6-sudeep.holla@arm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 May 2020 13:46:23 +0200
Message-ID: <CACRpkdZLpq2Ph_jUyjKMTgeeCp61QmMMK64Rb0-05wOK5apK1Q@mail.gmail.com>
Subject: Re: [PATCH 5/8] soc: ux500: Switch to use DEVICE_ATTR_RO()
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 7:09 PM Sudeep Holla <sudeep.holla@arm.com> wrote:

> Move device attributes to DEVICE_ATTR_RO() as that would make things
> a lot more "obvious" what is happening over the existing __ATTR usage.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
