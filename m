Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99912C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 20:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75019206A2
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 20:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ySlzyU3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgHIUgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 16:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgHIUgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 16:36:01 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36ABC061786
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 13:36:00 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 185so7428695ljj.7
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 13:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VSSDBJk6gLE6rhGULG1G81ocpF+POHgO4nE9N3d7HUY=;
        b=ySlzyU3jUGPCX5KJkkeSbdRLwPab/kKxNC9gYhEFvTvICpgsKTziAtKKaxwnXMPrSo
         iFMmgPWmOSYE+3wNISfHXo4r3HxtW4xIV2GWoROvAj+HfqOMZrMS24sM4mxdwB0TYY3X
         mh/3vUcoKPlwx22+sAX1YTiTqwTjmnGcYp4hMM3oFvBkz1HtHqeJQsyVLBYmHPi57O8P
         IWApaiSk7SJ7M7Yec1VxO6xW5+m2dPr9QhlovomgAfafpIfli9YnUDR5SXRZ1Diu1g6G
         1Rp6v5IV0GZIcjnO6H+MzWC2fPREj8xS9eOKDyNsIYEcTNsKiUPzd1ufNdzbgGpBd1QC
         6vbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VSSDBJk6gLE6rhGULG1G81ocpF+POHgO4nE9N3d7HUY=;
        b=ZfjXfwB09oVrX8VCIayStbvw7YaaOfAaRy/WdscAbSd1IUZygms0Tre+c6Q4c4xkrX
         6UjjpGIYjaUk11VDZ+MgdUi/7TFfpD+eRUUqqDrLV4t30ErwJSzsr/SiZodazCDby49W
         4yo7Z3SHtX3uCdS2mhJqNEwAjs9R3y0h1vFPTbdxs1wwI59kw6vt7qpGEZCMMbM/3V/r
         909zxnlTdN2x6trP4wqaEqECvGKA0wprftSFEpmoqCMf69uRff1FbuBLo16R8NJ9siKG
         w7ATrJF5VBBJBzdgSXONKIepJ7kMv5Bsw4X07NrGCEg0hRs+m7X7pjQ0EvGeu8H7zr5N
         UKlw==
X-Gm-Message-State: AOAM530KLhcr176IlGgkNxg+uBLgaS70ARWrgMr9hTwFeTF+KHdtpVzw
        T/1OjuqyA0kOwG5chBbtgzqu85zFHshIZlrmu9/6+5AhwT4=
X-Google-Smtp-Source: ABdhPJx0+3HiK4BERST7xDlbkaqD0iE42jj++Nyzx5kx74nhW84mJ4cQsAa4/220bB8gjDfH3hkU85U+ShOtTiaYWdc=
X-Received: by 2002:a2e:90e:: with SMTP id 14mr11146237ljj.293.1597005359121;
 Sun, 09 Aug 2020 13:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkdZyVM32opVPtgPonC0Gqg7YVyCCXryvA66FQbQUELdHjg@mail.gmail.com>
 <CAHk-=wjHNkPHvGG_Ca_f8=+w5od9_XTQ8yD55+v-3WCKhvKviw@mail.gmail.com>
In-Reply-To: <CAHk-=wjHNkPHvGG_Ca_f8=+w5od9_XTQ8yD55+v-3WCKhvKviw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 9 Aug 2020 22:35:47 +0200
Message-ID: <CACRpkdaVmq3XhioG_=nNKSGVq+uAff7OAJPbyx04vVGCg5aE5g@mail.gmail.com>
Subject: Re: [GIT PULL] pin control changes for the v5.9 kernel cycle
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 9, 2020 at 9:55 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sun, Aug 9, 2020 at 6:06 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > Driver improvements:
> >
> > - Linear improvement and cleanups of the Intel drivers for
> >   Cherryview, Lynxpoint, Baytrail etc. Improved locking among
> >   other things.
>
> I'm having a hard time parsing that. What does "Linear improvement" mean?

Sorry, gradual or incremental improvement is a better
term.

Best regards,
Linus Walleij
