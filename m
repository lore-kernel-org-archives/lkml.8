Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B57C2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 18:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB5920737
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 18:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ftU32uvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgC0Sbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:31:38 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41878 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgC0Sbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 14:31:37 -0400
Received: by mail-ot1-f66.google.com with SMTP id f52so10760327otf.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 11:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KI2dTrx/jXK38PbXpYOkSOlcGmSiDkUIwHW8vQMK71g=;
        b=ftU32uvodMmh9TUHBTsggNDykA0JWSoOl8vv6OZMmjFyeH+BjHX3KbXJ64DokTNeW8
         bJYL7htiWlyya8+yMZKcSWzvd2QzqRSVq90WRpVAWIED6t6G4Vvy7gQfUYwlHv636Qon
         pJILf2c9ad+yw94jyDC4zn1jVtQfCbD0fA8u3QGgsSr56xs/5hzWg7WxsVfMscprH+9x
         9lycyrBABLC8NZOHDGFQg2Ys67QcMo26x36JMYW8Tf1jlljbxEUL0GxZ9hL1SlJ2Zf6M
         YYu2l01UCXdJThX0Sx+viedEeZKn4XfRrk4z/XGsRE5sUu2IdQj9jfosX+ApYrGPqjwJ
         nSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KI2dTrx/jXK38PbXpYOkSOlcGmSiDkUIwHW8vQMK71g=;
        b=pM8+kMCp+2VKNxNkTAhOxH+5R5UYvqfBMmCZO2ADJDUdUMqHW9GiNquLVRfpHo96qm
         V1w92XqoxVWMQmoRi8rwUB5NK1wY/Upf8e6WPZEmuVOrO6SH7KMUE9yMOZL9gXiUBhQC
         sb/VPw9XQWpTNpmTNJa0zEANoFbfTTKt6SFFJjNmabP2VEpkoi6S0ilABbe9yUYtiME6
         h0lHphnJ8gD7JkJVbl80llkSvn/A+sJ5P0gL3fRaQk8gPCtUvhGhd7GM+oUcWRGTHlip
         69EOast4OpUg8PraCG1sxOOTqtoLGEHloAOgK6lXd8kkow0Pq6b4WmFS3rVXn2xxR1vI
         HD9w==
X-Gm-Message-State: ANhLgQ0IQn7Q62Xkcg5MNEnrJf30qTrr7kiAoiFk/yQ56AQDmHRoHABA
        k39LPkBeuGAPEKQjqGFtlwutJWEFKG4/oIA7H4ODdA==
X-Google-Smtp-Source: ADFU+vvTE+yu3Qrc0iwfoYnnfjvt5whAuu9S0p0ocDjhgWmev5ClxaCzU9FH1Cxy+HeexYbpKglLL/8Ushcu3EV/D5M=
X-Received: by 2002:a9d:42f:: with SMTP id 44mr22412otc.236.1585333895496;
 Fri, 27 Mar 2020 11:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200321210305.28937-1-saravanak@google.com> <CGME20200327102554eucas1p1f848633a39f8e158472506b84877f98c@eucas1p1.samsung.com>
 <bd8b42d3-a35a-cc8e-0d06-2899416c2996@samsung.com> <20200327152144.GA2996253@kroah.com>
In-Reply-To: <20200327152144.GA2996253@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 27 Mar 2020 11:30:59 -0700
Message-ID: <CAGETcx-J+TP+0NsOe75Uu3Q8K6=qYja6eDbjNH2764QV53=nMA@mail.gmail.com>
Subject: Re: [RFC PATCH v1] driver core: Set fw_devlink to "permissive"
 behavior by default
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 8:21 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Mar 27, 2020 at 11:25:48AM +0100, Marek Szyprowski wrote:
> > Hi,
> >
> > On 2020-03-21 22:03, Saravana Kannan wrote:
> > > Set fw_devlink to "permissive" behavior by default so that device links
> > > are automatically created (with DL_FLAG_SYNC_STATE_ONLY) by scanning the
> > > firmware.
> > >
> > > This ensures suppliers get their sync_state() calls only after all their
> > > consumers have probed successfully. Without this, suppliers will get
> > > their sync_state() calls at late_initcall_sync() even if their consuer
> > >
> > > Ideally, we'd want to set fw_devlink to "on" or "rpm" by default. But
> > > that needs more testing as it's known to break some corner case
> > > drivers/platforms.
> > >
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Frank Rowand <frowand.list@gmail.com>
> > > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> >
> > This patch has just landed in linux-next 20200326. Sadly it breaks
> > booting of the Raspberry Pi3b and Pi4 boards, either in 32bit or 64bit
> > mode. There is no warning nor panic message, just a silent freeze. The
> > last message shown on the earlycon is:
> >
> > [    0.893217] Serial: 8250/16550 driver, 1 ports, IRQ sharing enabled

Marek,

Any chance you could get me a stack trace for when it's stuck? That'd
be super helpful and I'd really appreciate it. Is it working fine on
other variants of Raspberry?

>
> I've just reverted this for now.
>

Greg,

I have no problem with reverting this. If there's any other
tree/branch you can put this on where it could get more testing and
reporting of issues, that'd be great.

-Saravana
