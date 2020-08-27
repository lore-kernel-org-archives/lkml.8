Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A7CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C83E20786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598514699;
	bh=DIJvlMKzbNSjh9srx4Yl9VXGvX0GWse5Ag3lAUo1ZA8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2ZpG9JxIvSD33BKJtwvl6ICJl8BAHMiGZhAri84mLd2vovT3exj/zbXaaM/crnYaG
	 hppNSOHmKIGl+8oLrQQKOz1e7exD0I3z2qhh22HLl3TDb9Z77LxFK1Ip3fe1iXyk/l
	 ewQL60iH0Ekf2Ul9golHIW80P6wW7stnijylP7Kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgH0Hvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:51:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbgH0Hvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:51:35 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C54EC22BEA;
        Thu, 27 Aug 2020 07:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598514695;
        bh=DIJvlMKzbNSjh9srx4Yl9VXGvX0GWse5Ag3lAUo1ZA8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SoALY6gPrgwmZay6+eURH9ZzpaAxs/X25l9uaoKsnD6ALA8ub+C/P0MSP6KQnGomS
         Ej7TCGuF3ATMUb2L2c3ZO8LbEAYUazhfb+ZUtN6t0IqMAkSJx7eIaD5ktBClxjWyJU
         Y9LzkUmuyNvZI4vPd6u5oO6axGR8GkfBqZ7EmQWI=
Received: by mail-ej1-f48.google.com with SMTP id a21so6404295ejp.0;
        Thu, 27 Aug 2020 00:51:34 -0700 (PDT)
X-Gm-Message-State: AOAM5318sMU5DKtJBB2hEd+LfKrZtqMf2NqD5L/K3sbxONUg/r9NIIG/
        RScSyiWzCb1FXdxBYmsj45SegnRS4EU1NeDJvcU=
X-Google-Smtp-Source: ABdhPJziPMOxuJ09gXI/k0UxZq5JIsN+YRZxuWQCwZAMvUN9h301PIjJLzJwvv8KaGlNXCdLLGgwchSj+JCKsUFkr98=
X-Received: by 2002:a17:906:d144:: with SMTP id br4mr19445113ejb.385.1598514693333;
 Thu, 27 Aug 2020 00:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200826150239eucas1p24c59716cc31edfeb2eece84d97936b93@eucas1p2.samsung.com>
 <20200826134315.GA3882506@kroah.com> <1425ab4f-ef7e-97d9-238f-0328ab51eb35@samsung.com>
In-Reply-To: <1425ab4f-ef7e-97d9-238f-0328ab51eb35@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 27 Aug 2020 09:51:22 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfmN6HAGXH-Qf4JAuo5Zbcu0y1yhrP2ZcdPMf8jwTv3Xw@mail.gmail.com>
Message-ID: <CAJKOXPfmN6HAGXH-Qf4JAuo5Zbcu0y1yhrP2ZcdPMf8jwTv3Xw@mail.gmail.com>
Subject: Re: [GIT PULL] USB fixes for 5.9-rc3
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        Ilja Van Sprundel <ivansprundel@ioactive.com>,
        Kees Cook <keescook@chromium.org>,
        Brooke Basile <brookebasile@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020 at 17:03, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Hi Greg,
>
> On 26.08.2020 15:43, Greg KH wrote:
> > The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:
> >
> >    Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)
> >
> > are available in the Git repository at:
> >
> >    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.9-rc3
> >
> > for you to fetch changes up to 23e26d0577535f5ffe4ff8ed6d06e009553c0bca:
> >
> >    usb: typec: tcpm: Fix Fix source hard reset response for TDA 2.3.1.1 and TDA 2.3.1.2 failures (2020-08-25 16:02:35 +0200)
> >
> > ----------------------------------------------------------------
> > USB fixes for 5.9-rc3
> >
> > Here are a small set of USB fixes for 5.9-rc3.
> >
> > Like most set of USB bugfixes, they include the usual:
> >       - usb gadget driver fixes
> >       - xhci driver fixes
> >       - typec fixes
> >       - new qurks and ids
> >       - fixes for USB patches merged in 5.9-rc1
> >
> > Nothing huge, all of these have been in linux-next with no reported
> > issues:
> >
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > ----------------------------------------------------------------
> > Alan Stern (1):
> >        USB: yurex: Fix bad gfp argument
> >
> > Andy Shevchenko (1):
> >        usb: hcd: Fix use after free in usb_hcd_pci_remove()
> >
> > Badhri Jagan Sridharan (1):
> >        usb: typec: tcpm: Fix Fix source hard reset response for TDA 2.3.1.1 and TDA 2.3.1.2 failures
> >
> > Bastien Nocera (2):
> >        USB: Also match device drivers using the ->match vfunc
> >        USB: Fix device driver race
> >
> > Brooke Basile (2):
> >        USB: gadget: u_f: add overflow checks to VLA macros
>
> Sorry, but the above patch breaks USB Ethernet Gadget operation. It also
> didn't get the proper testing in linux-next (next-20200826 is the first
> one with this patch).
>

Hi Greg,

I have a different question - why is this patch not findable on any
LKML lists? lore.kernel.org does not have it. Neither has mine inbox
tracking most of the lists (also main linux-kernel). Maybe subject
changed?

Do we have another process of sending patches for fast inclusion in
the Linux kernel? Is addressing a HW vulnerability?

Best regards,
Krzysztof
