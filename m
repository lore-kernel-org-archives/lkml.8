Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C67C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4560D20578
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A4ESPLRG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgGGMmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgGGMmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:42:24 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675BDC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 05:42:24 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e4so49733137ljn.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 05:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6qpEzrY02ovA0aYgrzmDF7GFid8ang4s0P7kWvdAM18=;
        b=A4ESPLRGuaLgSSD2COKNlNdTLY9d3I1rMaSMMn7vinB9AltBGxkFIQm8dMNtw+bGe3
         z7jgR4k0m2woWIrylhhxzUYxBztXql8eLhpsmJRZ7rleF4nlwm2sAb1it0KS2JROJG/4
         avMpFkA2f1F4rFOFzEoR5YLOt76+IDeu1kpiLnHOXL4bwgeeqTfm7E7aJ2Mfv1we2T2u
         15OAKeJGikQMp/gSQsT0gGYq6QYaegakm8ru0j/eIaYdd4Aw2lqBoMx7JDTY0x/EeEWM
         IjensR/CTcFUz6cPf82UOUDvCAs4g+gnkUAvS1n/MT6FOM5kNGfELAtXAey0NUKheteR
         dDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6qpEzrY02ovA0aYgrzmDF7GFid8ang4s0P7kWvdAM18=;
        b=X48lvLiGjkfng2Lz3Rn9Z0JpjFywKGzeoUimaI8kGeAKGJeg8T8id4j84HeIagKqEH
         u1ssPWJKjrXDV/JXd3BOtkqh3/m6Mhk5XHCvdyHcou90aVqEGBifZhi0Om3b0DOFX4U1
         995HIfwBFXXExgfJznvxWiW1j2PYbzpaqj7mW0lohHy7+JphMc9G9dvcTv1IHYYpnBkz
         PdIknGUKHJRwzLlRrtDNAFU+2EFRQspwoFsaE1pPHydZC2VrZB+UHa/TPo7EaXYsQNee
         vQzRg098f/KQ2gtUs5uzX3csHHMbOJp5JqgQ2vAdFidwb4ExoOAo29+CAyAzMCT5S9TC
         lA/w==
X-Gm-Message-State: AOAM531p6r7M7rccktY+hnt2SjCwRIewBlOrEKTSKV2Q1kd139CfXqKj
        /9Q+gE0o22RVE2l+kZ7vQlKky76ywdc4oVPMc+ZnQw==
X-Google-Smtp-Source: ABdhPJwYC2CtSDClbk5eUasXsml9ZGmgHAUpCfPZpo4GflqJeILbdq+wspjnFBOfTezLth8SX5+6d8dBlTZ6aq7sS4I=
X-Received: by 2002:a2e:9a4d:: with SMTP id k13mr8715562ljj.283.1594125742967;
 Tue, 07 Jul 2020 05:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200625191708.4014533-1-lee.jones@linaro.org> <20200625191708.4014533-6-lee.jones@linaro.org>
In-Reply-To: <20200625191708.4014533-6-lee.jones@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jul 2020 14:42:12 +0200
Message-ID: <CACRpkdZSL9MekpPDgy79nbRDkf8bfx_KUfrOCDv22YJNrCbSbA@mail.gmail.com>
Subject: Re: [RESEND 05/10] regulator: ab8500: Remove unused embedded struct expand_register
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 9:17 PM Lee Jones <lee.jones@linaro.org> wrote:

> Used primarily for the AB8540 which lost support in early 2018.
> It is now deemed safe to remove this legacy data structure.
>
> Also fixes W=1 issue:
>
>   drivers/regulator/ab8500.c:88: warning: Function parameter or member 'expand_register' not described in 'ab8500_regulator_info'
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
