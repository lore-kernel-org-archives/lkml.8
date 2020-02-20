Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6097EC11D0A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C56206E2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582208204;
	bh=ELL3hEpGo9sAinW5R6kKrZvV1yKEFg4R0dnJKKl/e5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TktMJ33l1wmU1RLxT0MgCTxVLRFvdYybE7sAR/q6CTnOly9G/tNhvJR9BIDP4tK2C
	 HIrLa6icpe3rEHlFyih5Qrz5Z/+caBi+SU0wKlz553QDgMtJM+0tkjx/npFJiw8vlx
	 cFZOgdOhjzVQ4gSceRirf/GjnJLOG1/3zg00swBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgBTOQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:16:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:42512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbgBTOQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:16:42 -0500
Received: from localhost (static-140-208-78-212.thenetworkfactory.nl [212.78.208.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC20B208E4;
        Thu, 20 Feb 2020 14:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582208201;
        bh=ELL3hEpGo9sAinW5R6kKrZvV1yKEFg4R0dnJKKl/e5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QbjHw5kA8g04sBo+4CIz97a/75O3v3KPnvVZEWPkhLl9HNfY8YSJVGOU0eHiS6wBI
         sGzdXyEQ5LQVkLw+CI8Ti/rlYUV+mrdoF+jILKt7dL6Bb8Buoh5f5oR35Sf7QC0ijM
         yqtry28uArBqZ/Forgszj6uh9kyddJIl9X41IZdA=
Date:   Thu, 20 Feb 2020 15:16:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Russell King <linux@armlinux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND RFC PATCH v3] clk: Use new helper in managed functions
Message-ID: <20200220141637.GA3433108@kroah.com>
References: <f48d1df3-fc1f-ac5c-b11e-330f18aad539@free.fr>
 <20200220112700.GJ3374196@kroah.com>
 <8866e533-967f-e208-1ec8-888d72f3052e@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8866e533-967f-e208-1ec8-888d72f3052e@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 03:05:54PM +0100, Marc Gonzalez wrote:
> On 20/02/2020 12:27, Greg Kroah-Hartman wrote:
> 
> > On Thu, Feb 20, 2020 at 11:04:58AM +0100, Marc Gonzalez wrote:
> >
> >> Introduce devm_add() to wrap devres_alloc() / devres_add() calls.
> >>
> >> Using that helper produces simpler code, and smaller object size.
> >> E.g. with gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu:
> >>
> >>     text	   data	    bss	    dec	    hex	filename
> >> -   1708	     80	      0	   1788	    6fc	drivers/clk/clk-devres.o
> >> +   1524	     80	      0	   1604	    644	drivers/clk/clk-devres.o
> >>
> >> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> >> ---
> >> Differences from v2 to v3
> >> x Make devm_add() return an error-code rather than the raw data pointer
> >>   (in case devres_alloc ever returns an ERR_PTR) as suggested by Geert
> >> x Provide a variadic version devm_vadd() to work with structs as suggested
> >>   by Geert
> >> x Don't use nested ifs in clk_devm* implementations (hopefully simpler
> >>   code logic to follow) as suggested by Geert
> >>
> >> Questions:
> >> x This patch might need to be split in two? (Introduce the new API, then use it)
> >> x Convert other subsystems to show the value of this proposal?
> >> x Maybe comment the API usage somewhere
> >> ---
> >>  drivers/base/devres.c    | 15 ++++++
> >>  drivers/clk/clk-devres.c | 99 ++++++++++++++--------------------------
> >>  include/linux/device.h   |  3 ++
> >>  3 files changed, 53 insertions(+), 64 deletions(-)
> >>
> >> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> >> index 0bbb328bd17f..b2603789755b 100644
> >> --- a/drivers/base/devres.c
> >> +++ b/drivers/base/devres.c
> >> @@ -685,6 +685,21 @@ int devres_release_group(struct device *dev, void *id)
> >>  }
> >>  EXPORT_SYMBOL_GPL(devres_release_group);
> >>  
> >> +int devm_add(struct device *dev, dr_release_t func, void *arg, size_t size)
> > 
> > Please add a bunch of kerneldoc here, as I have no idea what this
> > function does just by looking at the name of it :(
> 
> Fair enough. (This was one of my "Questions" in the patch comments.)
> 
> Note: My patch adds a new function, then makes use of said function.
> Is this typically done in two patches or one?
> 
> Patch 1/2 augmenting the API.
> Patch 2/2 making use of the new function.

2 is usual.
