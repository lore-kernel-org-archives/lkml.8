Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE793C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AF66206E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QBtBrpjd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgGHRgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgGHRgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:36:51 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B273C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 10:36:51 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id h17so38499333oie.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 10:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xIPxHFNL2iAKNO6TfsfK5i3c3GAB1DsvCug2FocHVtY=;
        b=QBtBrpjdEAaDgN/nY2WU1E7mnTl0LdGw45K2oFN6eGJYyIsG9ugEteWhqxsSpzq2GW
         ReZkIkMN/gB9YQl0SS01Uwl3q5rXHR3G/28TB4+hvWifUg3fXDlrcs/J3/lkovvNWR/z
         8Hx5UVU3acMZxZl4sazyYM+tNHZjosg8iYKGDgF0N1xNEyQCGOJtyGpQCuDn8ktQ/40g
         gYUobTJR11Ho1MUk0ayZvLJ14uZZSB5////Dd34xOBhxWQ24H11heE9J6s4O3AZLaKdH
         YP2w9UhijAGa26TfnVXw3p5EZ/yVBc3jnMLEIVaHEbJ5O4aWYiojSmebaryi+YYsV/Hq
         +RKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xIPxHFNL2iAKNO6TfsfK5i3c3GAB1DsvCug2FocHVtY=;
        b=GSz+cljz2Nj2vBMiuaUEn5ce/kgonzD1DCmskClj1jUqMCIAX4VYv3j7hcnkqYyq1c
         3PCtK0/yuQUfJ2xLRLetTSO6ELBPQf7/uWPoVTajU2w5V91Wrp0wJNgR4Kybpo16mkKF
         T4X5RbhlsQcXmxeZ6WlQos9OiF8zZvuJIxscsqofm2e81Fr3CiJCrTYtFMe2qg7f7NU5
         d9wO+5PZm/cSxhAuGTp02ZVlVlLjjG3YhWY5GlTNGiIQ9lo+vyoCrWCQCVG7XWEL02vk
         5RQnb0q8fpsHu95t0AZmnXHT2AHswzoNVMg3ef0TwUg1W2XpsMU/7XbcTXC6aBdy4eqr
         vlBg==
X-Gm-Message-State: AOAM532kyBBuU2s7oSjKKhXNhdqeZIoD/UZv+LXozTnvYTlBOh2rzB+H
        jBN0rPa51JbT91Cn44tsHT5jRm+WQ84v25uSplBm2Q==
X-Google-Smtp-Source: ABdhPJyWOqIT8y4BnHhXxpTPX2k9Z252XO3U9PSnCYIeYLF77r6UaNqlEEbfud/bKiN6dVw2TwUs6UYwZ7wNGXbTR/k=
X-Received: by 2002:aca:a983:: with SMTP id s125mr8215567oie.30.1594229810224;
 Wed, 08 Jul 2020 10:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200701194259.3337652-1-saravanak@google.com>
 <CAJZ5v0gPKHSpC+9BNt_n_wP+8Lmekb1VapfgHPwenHopekHV=w@mail.gmail.com> <CAMuHMdW+dqCCqKjtxgZAAG-sFiMpbsEs_GoVGeKq6__A7EDBxg@mail.gmail.com>
In-Reply-To: <CAMuHMdW+dqCCqKjtxgZAAG-sFiMpbsEs_GoVGeKq6__A7EDBxg@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 8 Jul 2020 10:36:14 -0700
Message-ID: <CAGETcx-dcvsWDJPbM_c1O4ScJmPu97+WWRkygmF1g-grdAha9A@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Fix dpm_list ordering issue due to fw_devlink optimization
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 1:16 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Rafael,
>
> On Tue, Jul 7, 2020 at 5:56 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Wed, Jul 1, 2020 at 9:43 PM Saravana Kannan <saravanak@google.com> wrote:
> > > When commit 93d2e4322aa7 ("of: platform: Batch fwnode parsing when
> > > adding all top level devices") enabled batch processing of fw_devlink to
> > > optimize the parsing time, it caused a suspend/resume regression due to
> > > the use of deferred probing early on at boot.
> > >
> > > This series fixes the regression by avoiding the use of deferred probing
> > > when optimizing fw_devlink parsing.
> > >
> > > Saravana Kannan (3):
> > >   driver core: Don't do deferred probe in parallel with kernel_init
> > >     thread
> > >   driver core: Rename dev_links_info.defer_sync to defer_hook
> > >   driver core: Avoid deferred probe due to fw_devlink_pause/resume()
> > >
> > >  drivers/base/base.h    |  1 -
> > >  drivers/base/core.c    | 44 ++++++++++++++++++++++++++++++------------
> > >  drivers/base/dd.c      |  5 -----
> > >  include/linux/device.h |  5 +++--
> > >  4 files changed, 35 insertions(+), 20 deletions(-)
> > >
> > > --
> >
> > Geert, any chance to test this series on top of 5.8-rc?  It is
> > expected to fix the suspend/resume regression reported by you.
>
> Sorry, I had completely forgotten I hadn't tested this iteration of
> the fix(es) yet. Thanks for the reminder!
>
> Works fine when applied on top of v5.8-rc4.
> Tested on r8a7740/armadillo, sh73a0/kzm9g, r8a7791/koelsch,
>  and r8a77951/salvator-xs.
>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Great! Thanks!

-Saravana
