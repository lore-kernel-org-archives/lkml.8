Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DF5C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E499B2073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fx/ZK68h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbgC3HfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 03:35:15 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45625 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729533AbgC3HfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 03:35:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id t4so435017plq.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 00:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wdQn7+4WjNITqnyMEnPuurluuA3035fLGCjTPx0cnYk=;
        b=fx/ZK68h26OH+GmcexCn72v3EpUL3eA4hs5riAubSO+umgs3wLz+QvP1oTdth5ERT6
         SmQpm2VW9qKNOdiAN+UBsBcS67w2MPlViI4L1QJqNkIkw7D8qWrJFogBXLlrrMKx7R0M
         2LVpAZgLjvQspYRHdDZvj8O99hO7+6D0qyAXn/8Isd5AEtDGyDXlUTHeTgXzbPm/1tqV
         ntvfy79mTCFVuKkeKQgi6OD5dhmXLpnVXlGiArUy1p92NXrsY4i/aZ1mzdyvWuSBlHak
         6JFD/gOtUqlcwqixNC4D+nKZjL5wA0GGoPiJSg3Su/eNxoTazUL4ftrCfrLWZ/Dsi5Y6
         2n2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wdQn7+4WjNITqnyMEnPuurluuA3035fLGCjTPx0cnYk=;
        b=IiLYV95/pafyR52W8Mv94VKB6SJM+t0eDH7FbJZaiUiaF9XH+yf2U37nUZoaVBxFTv
         iI/MYxgXfKByzuFB5Ot+5jcvFRNfiMyq9Q/0/vRdAIoCr1PVP8xlH2UTz91PSnHN4Iiu
         waPYzVXBgSm73qcW9jQQR+UnUYn+rYzKIrCbLlIAA6G4S6C9HZUGKLrJodAuecnl1C6t
         Phxxwcp8VIri3+P8NbXMhZeLIV/9cObNvWUW6cjjDeqpWUNXMBviwQWOz6Jj+QnvW/XB
         uWXgGBWoOQOTOFeSPvdrKH3r3y3W5VfC4w7dWighsz+cTNhL0DNjYOYIVeC2RvE+sJPE
         Kf/g==
X-Gm-Message-State: AGi0PuZpq04jQWqlGYg/NLh2KVOKFIhf7c0JtpOJWHOEYgkesgl/xRAd
        M/LVziKHnyMk5GRVyle2qxDLx3DkSxbqzAhD8qA=
X-Google-Smtp-Source: APiQypJonPQ0NJJfEeeTy3uMh+gCqXFagcsebaKEe/nfYQ2K/YhJr5UACyAC2dLNPciq2iHQy4r7XYUSO2bJOr9z1Bo=
X-Received: by 2002:a17:902:8215:: with SMTP id x21mr7757300pln.255.1585553713343;
 Mon, 30 Mar 2020 00:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <f53fdf2283e1c847a4c44ea7bea4cb6600c06991.camel@perches.com>
In-Reply-To: <f53fdf2283e1c847a4c44ea7bea4cb6600c06991.camel@perches.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 30 Mar 2020 10:35:01 +0300
Message-ID: <CAHp75VfJS4hAxdq67NwAXs8U+6UzL8=bqnCEpSy45R0Gj1L8NA@mail.gmail.com>
Subject: Re: commit 23cb8490c0d3 ("MAINTAINERS: fix bad file pattern")
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 5:38 AM Joe Perches <joe@perches.com> wrote:
>
>    MAINTAINERS: fix bad file pattern
>
>     Testing 'parse-maintainers' due to the previous commit shows a bad file
>     pattern for the "TI VPE/CAL DRIVERS" entry in the MAINTAINERS file.
>
>     There's also a lot of mis-ordered entries, but I'm still a bit nervous
>     about the inevitable and annoying merge problems it would probably cause
>     to fix them up.

I'm wondering if order depends to current locale. If so, the script
should override locale as well.

>
>     The MAINTAINERS file is one of my least favorite files due to being huge
>     and centralized, but fixing it is also horribly painful for that reason.
>
> The identical commit was sent at least twice.
> Once directly to you.
>
> https://patchwork.kernel.org/patch/11361131/
> https://lore.kernel.org/linux-media/20200128145828.74161-1-andriy.shevchenko@linux.intel.com/
>
>
> About the pain associated to fixing the file:
> I think it would be minimally painful to run
>
> $ ./scripts/parse-maintainers.pl --input=MAINTAINERS --output=MAINTAINERS --order
>
> Immediately before an -rc1 is released.
>
> Relatively few of any pending patches to MAINTAINERS
> in -next would be impacted and there would be better
> consistency in the silly file.
>
>


-- 
With Best Regards,
Andy Shevchenko
