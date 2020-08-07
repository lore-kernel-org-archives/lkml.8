Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4133C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 01:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A52E5221E2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 01:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j7HC3Z5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgHGBuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 21:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgHGBuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 21:50:37 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96669C061575
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 18:50:36 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id f24so390216ejx.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 18:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cD8jsk4+SBG8xPQfCCj2wmUpFVhawKwctfW4av5cjwU=;
        b=j7HC3Z5KWqeecaZcmC3YJkQ+9fE581GofeymgTxpCPrJdWE+UU1MMGXjGjBL3tQfy8
         537lS5kxtZrY9X0agbW+fq+ASnx+ufvq5xYa5fBh5z/aOOGPSrTa23sW4U1ceMrhFzSK
         J4cuZa2LhzUuuEnzgxPFjP4K8a/30hM5cSK5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cD8jsk4+SBG8xPQfCCj2wmUpFVhawKwctfW4av5cjwU=;
        b=VB7Q7tuBvQkW0v3NMLJpAk37getbBdx6bDUFShc6kNL91vYH0GVkbYbqqryPZ+zR+4
         k0GA+dn2AuTS8uIOsZCQGFTOr2boiM8FwsZQlKbkRSBDH8pFKp16yaUApFMrLWMUAjIQ
         gcDxOiwB5QwjEnjrUI13cvGa/xATgNC6oAOkxbh6KV6ee9Xmr/RCAGg+EVa1c5dlNKxk
         XNb9bcfi1yCKm+K/AQ6PiJP7IRUUDivU2pOhrx5VeT46U6gGF8tTI2LpEB3NwQA87pn2
         BDhZemVH04JotBC2t4MiF0rgDWBwA1IFLKCaifBwnxn+UebSmK0995sRy6eAYTexGTgm
         XMeg==
X-Gm-Message-State: AOAM530CMdO6pirXP7ndWGpEAiBIavTGT55b6T8O1vRiXGSD7s3XUUV7
        53bnd0F/waT791LQ7JnslwnGtYVTmr+KOMEMNLajtDvH
X-Google-Smtp-Source: ABdhPJw8niI7X7Sw8klc/4xbPNLsxrK/3t5hOTwIymbgO2pDc9aWiI0yYJOrcmGNz7OW7xrCLVM1Q6LDAFSnP9cYNMA=
X-Received: by 2002:a17:907:208e:: with SMTP id pv14mr7578996ejb.438.1596765034757;
 Thu, 06 Aug 2020 18:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200710144520.RESEND.1.Id0f52f486e277b5af30babac8ba6b09589962a68@changeid>
 <20200710070332.GA1175842@kroah.com> <CANMq1KDcKWgyYYP_m0-WV7602g7zUbU0PPkvwXxbSTF5vFfKGQ@mail.gmail.com>
In-Reply-To: <CANMq1KDcKWgyYYP_m0-WV7602g7zUbU0PPkvwXxbSTF5vFfKGQ@mail.gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 7 Aug 2020 09:50:23 +0800
Message-ID: <CANMq1KC7CgUT+neoOUZbnr8MbDgqEikqt2vn8dxAS1rpX=C2aA@mail.gmail.com>
Subject: Re: [RESEND PATCH] media: atomisp: Replace trace_printk by pr_info
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 8:41 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> On Fri, Jul 10, 2020 at 3:03 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Jul 10, 2020 at 02:45:29PM +0800, Nicolas Boichat wrote:
> > > trace_printk should not be used in production code, replace it
> > > call with pr_info.
> > >
> > > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > > ---
> > > Sent this before as part of a series (whose 4th patch was a
> > > change that allows to detect such trace_printk), but maybe it's
> > > easier to get individual maintainer attention by splitting it.
> >
> > Mauro should take this soon:
> >
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> Mauro: did you get a chance to look at this? (and the other similar
> patch "media: camss: vfe: Use trace_printk for debugging only")

Mauro: Another gentle ping. Thanks.

> Thanks!
