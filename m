Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E695C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BEAD20578
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z7BbP72N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgGGMk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGMk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:40:57 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02068C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 05:40:57 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q4so13976425lji.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 05:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QGcoFBPPxrng8eM90mEgFMsK7e0Ej5rArXOEd/o/bOc=;
        b=z7BbP72NcF/rAPzxpGYTN7OtYHdbfQTFq6N/8aGnLvg8gXxIvYoXy9df/SlkKyemSr
         zJ8hgYPkbAXBClonuaQuUMx3Ba1b2g8LdQCxocVGihwXkhk33tLyHJdHqcPZqaD6nlq4
         /B9cv3igBFC5Af3J/G3R5czIgkytIC9U9zZ26dB4ZeMtDGGiVZlvvV/XM9HPCjMnYCyd
         2m+GVvBJjkmvUW6dbx2YAQUqtKr4oRaxv9iNzn4ciJHPvf+j1/C54JqhQYbFZixENuMM
         AeokBASnTOXpqcfIE2FtPJdpxWZozV0uIw3BLS69ymo0JiZoH89JkmaWOoIcjr/x5jI0
         nY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QGcoFBPPxrng8eM90mEgFMsK7e0Ej5rArXOEd/o/bOc=;
        b=Cy+WafQCnmmYjZU758ViQ7J3O0eVAKTCKfXmF5pd7lZh+pk1P0WjJ8ZSvORxH01ZRd
         7w0gpNlCfY8hE9ZQNSrXEpFI8iSh1LPvwmwxUVLvRsOGd4Jp5o4cV87nIcmFj5fY83sP
         ZzgLq0tIylKQBVfztPjVOJXfedPRNizO7aQGznpebrxgZHZVpN/CMav8Y5TD5oRnos2w
         WYf6HsCy4WOnY8kO/oldfFJAE5I4jZPn0X1/234QG2shTC7PK3pf83Ow2U8ty4l+2mNh
         I+9QBVqjwaIQVWU31wa9VUrXtDmTs0AhDjT7+yQvpOn9ET9zTyJF9620bWIijHiTHk3u
         J+Mg==
X-Gm-Message-State: AOAM530SQBaqpbx2fEGRWN5TMaO55GG1ma0MbFktxZoqcp4JOmiSVjnE
        gIXYTRqT8jNapkFIfjHTRDc+x0cbVk0kJPeUPgD67Q==
X-Google-Smtp-Source: ABdhPJx0Mf86e5V6mQ4GHGO9xYIah6dO+UFkuYm8wL2/d7xbFzE7p6F1m8WeXnkTEy8KWN2UQbub3S5yOIXQahc3+Q0=
X-Received: by 2002:a2e:8046:: with SMTP id p6mr16117035ljg.100.1594125655520;
 Tue, 07 Jul 2020 05:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200625163127.4000462-1-lee.jones@linaro.org> <20200625163127.4000462-5-lee.jones@linaro.org>
In-Reply-To: <20200625163127.4000462-5-lee.jones@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jul 2020 14:40:43 +0200
Message-ID: <CACRpkdZ5ruZsdBeq38hEBRAvBwuDSVe=eo7Nnozb1C_J5FKS6g@mail.gmail.com>
Subject: Re: [PATCH 04/10] mfd: ab3100-otp: Add missing colon(s) for all
 documented kerneldoc arguments
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 6:31 PM Lee Jones <lee.jones@linaro.org> wrote:

> Kerneldoc validation gets confused if syntax isn't "@.*: ".
>
> Adding the missing colons squashes the following W=1 warnings:
>
>  drivers/mfd/ab3100-otp.c:60: warning: Function parameter or member 'dev' not described in 'ab3100_otp'
>  drivers/mfd/ab3100-otp.c:60: warning: Function parameter or member 'locked' not described in 'ab3100_otp'
>  drivers/mfd/ab3100-otp.c:60: warning: Function parameter or member 'freq' not described in 'ab3100_otp'
>  drivers/mfd/ab3100-otp.c:60: warning: Function parameter or member 'paf' not described in 'ab3100_otp'
>  drivers/mfd/ab3100-otp.c:60: warning: Function parameter or member 'imeich' not described in 'ab3100_otp'
>  drivers/mfd/ab3100-otp.c:60: warning: Function parameter or member 'cid' not described in 'ab3100_otp'
>  drivers/mfd/ab3100-otp.c:60: warning: Function parameter or member 'tac' not described in 'ab3100_otp'
>  drivers/mfd/ab3100-otp.c:60: warning: Function parameter or member 'fac' not described in 'ab3100_otp'
>  drivers/mfd/ab3100-otp.c:60: warning: Function parameter or member 'svn' not described in 'ab3100_otp'
>  drivers/mfd/ab3100-otp.c:60: warning: Function parameter or member 'debugfs' not described in 'ab3100_otp'
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
