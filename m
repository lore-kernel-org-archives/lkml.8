Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6AFC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18DAB2078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dsH4IocR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHZP6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgHZP5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:57:43 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44593C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:57:43 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bh1so1094143plb.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ijQWHet8Hvpkx4cDZTd5XJNqC2I4V5jJoFi9k0Qv97U=;
        b=dsH4IocR3yy5Uc/4AvuYTBfKzPse7HEba7qvf7wpzpP8B29g1cHc6SgiNo0RQIw3T3
         TNL0WYjJ3NhcszT0LS3ibCtC8EPshS7UNRLDe7CC7Zh+ICR1e5VW2M78xC7EaOs17myC
         y4z3pH6ialJEj5LV/sQ+Fpjbv+lpwmu0WqGxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ijQWHet8Hvpkx4cDZTd5XJNqC2I4V5jJoFi9k0Qv97U=;
        b=Dp71DWBzQy3pNcCojXJwEL/8jKnff+vzCYXGTgnxTP10UjOa81ySl6ApY4n7lk1j2s
         dYP5n6aG+AVY2Wb3qJDUJpaC5+X71nDPKxJ1akEQLqVrWUUHqpZjRv8c89UpNWpouXAD
         Khf6IdEbnASEJD+npktzVJTaI4yBsMZxY3q6cOx4G7rpyi/uhIck3rZTbsuwuF9xcYec
         yCFqCRks5t/qp2kYyWuPkXlfBRAiJvm0bMH3V8uUg5gQ7gB3T0cy4d5kvOeSAl6rUhhH
         PcIrxGTZRFvaQDB8yD0FpT5OKaH4c7SfiSsT9SMj99oCB1pF48t6Tea+wt86wCS9Y6JR
         ETbg==
X-Gm-Message-State: AOAM532sF3i1Tzyr/tAv8qUbvG+eaf+CgS5iXJx1M8PG3Q9PZ3L98ntB
        +qXkxRnXnqtKWDCSvIib42JC1g==
X-Google-Smtp-Source: ABdhPJwABUwANAy+24sJPx0Nl4567R6wVmJBHxxgSG6TzcsdqKOKz4COI7yyclh24bzKWHMuAiAuWw==
X-Received: by 2002:a17:90a:c7c4:: with SMTP id gf4mr6546054pjb.17.1598457462620;
        Wed, 26 Aug 2020 08:57:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i1sm2667916pgq.41.2020.08.26.08.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 08:57:41 -0700 (PDT)
Date:   Wed, 26 Aug 2020 08:57:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Brooke Basile <brookebasile@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Ilja Van Sprundel <ivansprundel@ioactive.com>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [GIT PULL] USB fixes for 5.9-rc3
Message-ID: <202008260856.5DAEFCEFF@keescook>
References: <20200826134315.GA3882506@kroah.com>
 <CGME20200826150239eucas1p24c59716cc31edfeb2eece84d97936b93@eucas1p2.samsung.com>
 <1425ab4f-ef7e-97d9-238f-0328ab51eb35@samsung.com>
 <20200826153347.GB4187816@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826153347.GB4187816@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 05:33:47PM +0200, Greg KH wrote:
> On Wed, Aug 26, 2020 at 05:02:38PM +0200, Marek Szyprowski wrote:
> > Hi Greg,
> > 
> > On 26.08.2020 15:43, Greg KH wrote:
> > > The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:
> > >
> > >    Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)
> > >
> > > are available in the Git repository at:
> > >
> > >    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.9-rc3
> > >
> > > for you to fetch changes up to 23e26d0577535f5ffe4ff8ed6d06e009553c0bca:
> > >
> > >    usb: typec: tcpm: Fix Fix source hard reset response for TDA 2.3.1.1 and TDA 2.3.1.2 failures (2020-08-25 16:02:35 +0200)
> > >
> > > ----------------------------------------------------------------
> > > USB fixes for 5.9-rc3
> > >
> > > Here are a small set of USB fixes for 5.9-rc3.
> > >
> > > Like most set of USB bugfixes, they include the usual:
> > > 	- usb gadget driver fixes
> > > 	- xhci driver fixes
> > > 	- typec fixes
> > > 	- new qurks and ids
> > > 	- fixes for USB patches merged in 5.9-rc1
> > >
> > > Nothing huge, all of these have been in linux-next with no reported
> > > issues:
> > >
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >
> > > ----------------------------------------------------------------
> > > Alan Stern (1):
> > >        USB: yurex: Fix bad gfp argument
> > >
> > > Andy Shevchenko (1):
> > >        usb: hcd: Fix use after free in usb_hcd_pci_remove()
> > >
> > > Badhri Jagan Sridharan (1):
> > >        usb: typec: tcpm: Fix Fix source hard reset response for TDA 2.3.1.1 and TDA 2.3.1.2 failures
> > >
> > > Bastien Nocera (2):
> > >        USB: Also match device drivers using the ->match vfunc
> > >        USB: Fix device driver race
> > >
> > > Brooke Basile (2):
> > >        USB: gadget: u_f: add overflow checks to VLA macros
> > 
> > Sorry, but the above patch breaks USB Ethernet Gadget operation. It also 
> > didn't get the proper testing in linux-next (next-20200826 is the first 
> > one with this patch).
> > 
> > This is how it explodes on Samsung Exynos (ARM 32bit) based board with 
> > g_ether module loaded:
> > 
> > ------------[ cut here ]------------
> > kernel BUG at mm/slub.c:4116!
> 
> Why is slub.c erroring?  How is this related to freeing memory?

I assume this is related to the size calculations in the VLA macros...
nothing _looks_ wrong with that patch, but obviously something is. :)
Hmmm

-- 
Kees Cook
