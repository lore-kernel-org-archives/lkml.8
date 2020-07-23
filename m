Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A22DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3925420709
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595510968;
	bh=Y9M0W+BfmdtTnM0e0J3GLfjs1x+wBeItYSyisu7KkPc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PPn6VwCjQSRTxFR44JJ2OuaWyFjmMd7/+lj0dIcr1X5dvVQXjkEBx/fL24F0MAsfI
	 t3yTID11pMon7XeLsurSasClri+81bwAd8JcdaM27e1/NNkGBiAzE3nV3hbgjgVQXE
	 N8BVvgb86YZVLmjJ0EibzYcvUKeKctnzEP/HwmY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgGWN30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 09:29:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgGWN30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 09:29:26 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3AF3207BB;
        Thu, 23 Jul 2020 13:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595510966;
        bh=Y9M0W+BfmdtTnM0e0J3GLfjs1x+wBeItYSyisu7KkPc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DWVKT6c9NYCjiddttZOJ6OG/xc5jT2VPc+bWMlCqOxBdFbePXRRWS9VTXA3ZKcBsc
         7KL4Pyme01xF4jrbcoNa6RNqw7WZnPQmGn2snAq2AfAxMi8LaTUFmlMX4WCDifnFxm
         2+YGbUXIqRXCE9vSIsDUhWnvjkjxPr0x0t5sWVJA=
Received: by mail-oi1-f170.google.com with SMTP id r8so4992148oij.5;
        Thu, 23 Jul 2020 06:29:25 -0700 (PDT)
X-Gm-Message-State: AOAM530gfRSQx04hgaUb26ErM1a/IulrGD+RVMT34czSFA88itcnI3xf
        zDY+No6UrrdjWdaa61MrOqXQ0EMTTHolmUkk7g==
X-Google-Smtp-Source: ABdhPJzcB/cFTt7vTTQVfNrMjdoW6Nv8EO943+ZDWBiwiUB3GPKRlSX+NgDSnLYFvceFXdY7Qh/d8tEfdXsnFfdwmaU=
X-Received: by 2002:aca:bb82:: with SMTP id l124mr3885042oif.106.1595510965163;
 Thu, 23 Jul 2020 06:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200722201313.754671-1-saravanak@google.com> <20200722201313.754671-2-saravanak@google.com>
 <CAL_JsqJvhpghE=LR=ng-gL5ek-7LOC1CGfOx6Vr-iACu-TX_fQ@mail.gmail.com> <CAGETcx9eRQPTH8YVtqtDdLkwHYbTw=DhWfryY98ZQ4_NOvALxw@mail.gmail.com>
In-Reply-To: <CAGETcx9eRQPTH8YVtqtDdLkwHYbTw=DhWfryY98ZQ4_NOvALxw@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 23 Jul 2020 07:29:12 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJx+N-P8Ffnh+0+JWYUaFLwSO8qUyyfyx=Yjurxqmq+tQ@mail.gmail.com>
Message-ID: <CAL_JsqJx+N-P8Ffnh+0+JWYUaFLwSO8qUyyfyx=Yjurxqmq+tQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] of: property: Add device link support for
 pinctrl-0 through pinctrl-8
To:     Saravana Kannan <saravanak@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 7:08 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Wed, Jul 22, 2020 at 2:09 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Wed, Jul 22, 2020 at 2:13 PM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > Add support for pinctrl-0 through pinctrl-8 explicitly instead of trying
> > > to add support for pinctrl-%d properties.
> > >
> > > Of all the pinctrl-* properties in dts files (20322), only 47% (9531)
> > > are pinctrl-%d properties. Of all the pinctrl-%d properties, 99.5%
> > > (9486) are made up of pinctrl-[0-2].
> > >
> > > Trying to parse all pinctrl-* properties and checking for pinctrl-%d is
> > > unnecessarily complicated. So, just add support for pinctrl-[0-8] for
> > > now. In the unlikely event we ever exceed pinctrl-8, we can come back
> > > and improve this.
> >
> > It wasn't immediately clear from this that pinctrl-8 is the current
> > max you found vs. a should be enough for a while.
>
> Hmmm... I tried. Looks like I failed. Open to copy-pasting any commit
> text that you think will make it clearer.

Append to the 2nd paragraph: 'pinctrl-8' is the current maximum found
in dts files.

> > Pinctrl is also a bit special in that we have 100s of child nodes and
> > only 1 to a few actual dependencies (the pinctrl node). I assume in
> > the end here, it's just the pin controller node that's the dependency
> > rather than creating lot's of dependencies?
>
> Correct. In the end, it just links to the one (or few) pin controller
> devices. Is there a requirement that all pinctrl-N properties point to
> the child state nodes of the same pin-controller node? Or can
> pinctrl-0 point to one and pinctrl-1 point to another pin controller
> node? If the former, all I'd need to do is parse pinctrl-0.

My initial thought was I'd expect the dependencies to be uniform
across pinctrl-%d properties as each one is supposed to be a different
mode of the same set of pins. However, the dra7 pathologic cases don't
follow that exactly with the higher speed MMC modes having an
additional i/o delay controller setting.

Rob
