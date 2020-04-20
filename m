Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F115FC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 06:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD8FF2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 06:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EK5Hw0hf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgDTGhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 02:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725815AbgDTGhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 02:37:00 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1DDC061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 23:36:59 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id g4so497537ljl.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 23:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wzzonVjiFqiRq0e4HZwoXw5dkwvtdDd69mGiOUp396o=;
        b=EK5Hw0hfRi7o3dbY+m85I9ucv5v66qj7OqXEX+bN5I9Ho7VT/zjTxzC2y5ndZgTLp4
         99OTCzzx86xo+9nnsmaeAPrYxiYN9gta1Bx8e4xL6A+TNCIk0Y1pOfMuVSP7+Ky9MxJk
         icD8NMJ2oyMpTn5IwdwkIHlirSgPG+o7M5F+xzma+LkxlV0FX8FM5Ph7L6kz31bjpW9e
         XS8DclfyqEzVx1oijfQjNr3mHsw12Z1jI94nHwFb3SIF/YqcMwdptQyO1Duhx3E8EA0y
         UiNNQzwCxyxQ6on2JJwBvZKFeFMuOWx+/42PfAS76D7/fUFHE3Kp3Pt464f+GOt6+t9R
         x41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wzzonVjiFqiRq0e4HZwoXw5dkwvtdDd69mGiOUp396o=;
        b=MVlKdfVJIWI/FTgFkfe84pSoTlYHQ/5gzfnPlgIIH31aXsg5POzjic+dNCczy5BFHf
         8/k827pW1pkcbehKWu16n5z/3kkQpz1SO8bMAT9fjN7A0/u9jFqcpLQ0WPGotdfPvUPH
         jh9xO6akEm5rbxEboZAgoz7W8zJzaqBHET1hDPXWpB5nBBbzDE4frsKh7fTPaJA6WhNx
         gc5Y7YyVHeiwa4QKfYmmmYXfRenVus8AffBlKakx/7ypnCx74Ss70un28J39YUn0qmeD
         GZzHjhONbonDvxBd6H6BkKNfuIjAkIFSHEBFDky1JFgviybHDJ7iKGb+n6pXIl+Bwoqw
         Eiaw==
X-Gm-Message-State: AGi0PuZT+rGGqek7UMM/ZueD+W3f+z1gkuR2YGZ6U1yFnA1xwsK7m6Z/
        4QhjNpOt794pv/FIwMkhqu9Lcb4e32+0pUfLxQLBxQ==
X-Google-Smtp-Source: APiQypKA679rD7AuS1a3F+mVgpCG1iaYgkNLaDrBfSG+xwFJq90YlS7Ir42YOcTAQVcDdf8Cg1XUizrVtpaTwD7CyVg=
X-Received: by 2002:a05:651c:23b:: with SMTP id z27mr8783634ljn.125.1587364618355;
 Sun, 19 Apr 2020 23:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200418100933.8012-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20200418100933.8012-1-lukas.bulwahn@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 20 Apr 2020 08:36:47 +0200
Message-ID: <CACRpkda7DBqJ_3N7eyqBREFk1jQpRQokgOqLq-sGs9UpaaSfXg@mail.gmail.com>
Subject: Re: [PATCH RESEND] MAINTAINERS: adjust to renaming physmap_of_versatile.c
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Sebastian Duda <sebastian.duda@fau.de>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 12:10 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit 6ca15cfa0788 ("mtd: maps: Rename physmap_of_{versatile, gemini}
> into physmap-{versatile, gemini}") renamed physmap_of_versatile.c to
> physmap-versatile.c, but did not adjust the MAINTAINERS entry.
>
> Since then, ./scripts/get_maintainer.pl --self-test complains:
>
>   warning: no file matches F: drivers/mtd/maps/physmap_of_versatile.c
>
> Rectify the ARM INTEGRATOR, VERSATILE AND REALVIEW SUPPORT entry and now
> also cover drivers/mtd/maps/physmap-versatile.h while at it.
>
> Co-developed-by: Sebastian Duda <sebastian.duda@fau.de>
> Signed-off-by: Sebastian Duda <sebastian.duda@fau.de>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Boris, please pick or ack this patch.
> applies cleanly on current master and next-20200417

Patch applied to my Versatile tree.

Will send a pull request for this to ARM SoC soon.

Yours,
Linus Walleij
