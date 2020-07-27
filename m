Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64940C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D51C2083B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTRw/ggl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733051AbgG0Okg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729596AbgG0OJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:09:14 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F25C061794;
        Mon, 27 Jul 2020 07:09:14 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id e22so2316901pjt.3;
        Mon, 27 Jul 2020 07:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ps9gbXfMY9gEoRvLMrM4gPnJ2K1TqhpHPJ+1koA1XlE=;
        b=TTRw/ggloTOv5tFUzkTPMaC9P4H4zn5RUSgZ8tuPIehl4KfhiSnqc9URK/XVaUe0z9
         JvhnfDplOssiiv4MRcwj30vFBpjR4v9d7RJ8vDKStCLcNbW6thmA8ixbQq7fg4n3xfo2
         6OS+is5nsc81nkZU1NgQk0CVMvnX3Q+RDiB8OyOC5muqXa7FHRgTfjETCJeAWpPA1JoW
         FMZeBigEl6suZNwsCToTEl6+A5p34nuUUrcwsS1gHeMrG0zg8uJ5jtDNADTz69f4DOVF
         E0Kpu/yHkIDaffVhBH68Vf7O/qZ1oONBQZRlKhgPYMT5CNneqqMkPbaFwpybMjOZczJh
         KEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ps9gbXfMY9gEoRvLMrM4gPnJ2K1TqhpHPJ+1koA1XlE=;
        b=kLi6QHkccuVlKDkbvS5H04uhAYtkVWKnA0IbNiGGqe2GV9n+gnebD+sgdvJfiL5MBe
         gad5bW/GMzGux0Dw7zLIQYFo0rh68IXNOTrFdUoDyrt0WCHz1QZMuBa3eT8n9fTu/3R0
         ki6xmUyRfy46pbSJ7ViXbroixnx/1C4x7TBZSfnLudqwx77yBAU8Ne8W5L9xEZCwLVZe
         FKlT5U8iscOmVWPOvLzOh+XZ2jMUkfEkIFTZe2+1FJh/kudDeLO+MvDHGQ/cm92XbfBB
         VAHmyl/j3xThxceNXqaTjkpZ0kY2xlQhWsREWrme+oQl0UEEo9f1aNrKG+lVviA8HHNV
         RA5w==
X-Gm-Message-State: AOAM533Sv/EzZmZNeIpQTv5P9xpgC12mSpw+b9mfv+qeuh2XTUZcHsvZ
        QI/xU6ZYbhkm/WgG4AmzB8UGKYOrlTlad6pyVyU=
X-Google-Smtp-Source: ABdhPJxp0MKMIJLZxQNKOBEyl/pD4FWGtiC8dyXDtpZ3+4QH6ixWcadx6p17sd38M60xe6jmlABVkhI9TeebUXIBYb0=
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr16702118pjp.228.1595858954219;
 Mon, 27 Jul 2020 07:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75Vdo22ofbCktupFYbfYy6PQ609fsk5B6u2b3FpfKxs8OQg@mail.gmail.com>
 <20200727131742.82289-1-vaibhavgupta40@gmail.com> <CAHp75VfmKvAy6bSk70g3c2qJcUzzo0AUhzxR6dFja+ZppGMLRg@mail.gmail.com>
 <20200727134646.GA114726@gmail.com>
In-Reply-To: <20200727134646.GA114726@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 27 Jul 2020 17:08:59 +0300
Message-ID: <CAHp75Vfuw1rAYxy41hVKNaqZQg4W-_Y=6St-X0yb5O4zN6qCfw@mail.gmail.com>
Subject: Re: [PATCH v2] spi: spi-topcliff-pch: drop call to wakeup-disable
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Joe Perches <joe@perches.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe, can we amend checkpatch to at least shout about simple typos in
the tag area?
See below for the context.

On Mon, Jul 27, 2020 at 4:48 PM Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:
> On Mon, Jul 27, 2020 at 04:38:40PM +0300, Andy Shevchenko wrote:
> > On Mon, Jul 27, 2020 at 4:21 PM Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:

...

> > > Fix: f185bcc77980("spi: spi-topcliff-pch: use generic power management")
> >
> > Fixes: and missed space.

(1)

> > > Reported by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >
> > Missed dash.
> > Does checkpatch complain?
> No, I got this message:
> "* .patch has no obvious style problems and is ready for submission"

(2)

-- 
With Best Regards,
Andy Shevchenko
