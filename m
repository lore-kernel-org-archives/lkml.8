Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C322AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 10:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A00D720759
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 10:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBMPjRAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgG0K1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 06:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgG0K1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 06:27:49 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC59C061794;
        Mon, 27 Jul 2020 03:27:49 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t6so7789034plo.3;
        Mon, 27 Jul 2020 03:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MfnAXIeR1KafYrufEJLqv/puSReDeQoJLVmC/MZWqGI=;
        b=cBMPjRAhkvB1/gbD27+X++2U5e9tuVr2DvEmEMsdVWx+9ZPD7HRqswj0n48/wZE7Bx
         /MIRkFKMsljFs/1/zplVRkxpBvwpVlgVh7Qok+iAnPdpCKxTXLBSh93y/frRqzaZlBms
         ZAMrf6lNd04WR2kl9wvoJVZuRojPssXADz4eEPnPuGTOVWqSqBt2e+HwTGrCWTwuaj11
         ZD0MW6hIf4M7FEk1VY9Z7qq5AK0GBiR19ZtfcPG9YdoKgfJtoz9IxJNxc21xRQYxPm/K
         nlitfpaIwDsftdfnHXB51XPmXCat39CiviSqjUkXXdOtE/Qwn+wQTX+IsD8lKFerh0LX
         rb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MfnAXIeR1KafYrufEJLqv/puSReDeQoJLVmC/MZWqGI=;
        b=CPUdDeoqar7y6UMsEcvDu8l3Nk2ML6zlm9vY4be05lJPzvLTz8DYWzMLu8J4zTjkBD
         2uYGnxNhPPLt9RRuMDqrmd9HaAkzccKjl3qgi8wyoLP0mh34+246d3yn5evZEnQQQWRC
         Hk3CaPsRYXahXcGcqnAFKRl+YOIfrfkhfDe/mBgP6ynt+t8qvTV7AYA5Ii7enXlRctU3
         iy6FHLBmU4udOp0wqGiVbDmVXl4Pm2/jNEC9r93oyJ0OsgetY+glQNSijw/v0GVAAryO
         ct8nYUlbAn6Rpj9su2Yk4TFZ1zy6grIPDeSUI/VczWP92vi0pRopBFSdeqAc6mHNoiO+
         2AuQ==
X-Gm-Message-State: AOAM530s4NvqR9RB6UkILoQCQk7B/vcQhoXDcQbL4X+lL3fbgCZfH3RB
        fsSVSAfSvme1jIY1g+SCYZ6PEllxNL/Ef3eDlcM=
X-Google-Smtp-Source: ABdhPJxEHPFoGSoZxU9r1b2GjJ1IWxHQsitK6DAhl4vZAYD76oQq7AHniHMA/DHdJb4mBAanhYP8ZH93gI5OO/jHCCs=
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr15807500pjp.228.1595845669025;
 Mon, 27 Jul 2020 03:27:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200719002903.20469-1-rdunlap@infradead.org> <c76c51bfa78316caaf8201a63ac200fa373ae3ae.camel@linux.intel.com>
In-Reply-To: <c76c51bfa78316caaf8201a63ac200fa373ae3ae.camel@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 27 Jul 2020 13:27:34 +0300
Message-ID: <CAHp75VeugozEiOMg1VeWegrP1m0VU5xKfxEj6gJPQbnuYh5zCw@mail.gmail.com>
Subject: Re: [PATCH] isst: isst_if.h: drop a duplicated word
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 6:10 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Sat, 2020-07-18 at 17:29 -0700, Randy Dunlap wrote:
> > Drop the repeated word "for" in a comment.
> >
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: platform-driver-x86@vger.kernel.org
> > Cc: Darren Hart <dvhart@infradead.org>
> > Cc: Andy Shevchenko <andy@infradead.org>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>

Pushed to my review and testing queue, thanks!

> > ---
> > This description could still use some better wording.
>
> I will fix the wording in a follow up patch.
>
> >  include/uapi/linux/isst_if.h |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > --- linux-next-20200717.orig/include/uapi/linux/isst_if.h
> > +++ linux-next-20200717/include/uapi/linux/isst_if.h
> > @@ -69,7 +69,7 @@ struct isst_if_cpu_maps {
> >   * @logical_cpu:     Logical CPU number to get target PCI device.
> >   * @reg:             PUNIT register offset
> >   * @value:           For write operation value to write and for
> > - *                   for read placeholder read value
> > + *                   read placeholder read value
> >   *
> >   * Structure to specify read/write data to PUNIT registers.
> >   */
>


-- 
With Best Regards,
Andy Shevchenko
