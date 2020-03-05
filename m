Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A893C3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BF6207FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BQufJX3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgCERPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:15:30 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40117 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgCERPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:15:12 -0500
Received: by mail-io1-f66.google.com with SMTP id d8so4128159ion.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 09:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bLVc72+NvHbHflO1/mhElGn5mslbixEGyqtU22wNbzY=;
        b=BQufJX3zg+gQzLw25jvC+wiv8qKJlzqGMQwSX/omduYNht7JYBotYPuk8BMzUHJsai
         +bof1wzwev80VmQzxXBx80uOrRkIYRbZgwiAYDG2h9x5ap/t/00Rrq47r9AyxQLIdlOu
         UUvRD+R8Pe1l5xhuaw7JfIQ94SuWG0lTvOP4gEj3TDbLdK+gG7s3SrVsqVHn2hvmh4rg
         HSq4JSqtAa9ULRPAFOl0qS24pqOVRuxNB0f9Qts5KqCeYKCNq9hI06D1pCWrzkuoZoRQ
         7MEIU4+Qr1U7zR5cAINsOrJTi/f+MFURPhxPwOOwjJNvgNtfuNy1nKSCP/Y78bheVS01
         ZniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bLVc72+NvHbHflO1/mhElGn5mslbixEGyqtU22wNbzY=;
        b=OZSTB8eRRb/E9OxgABsZQGXFVxyIcrC9omRsT7MFFa5CN7RUJlaQYthMRgU5Ln/Dc5
         I9AsVaum0wXcTi6dz8sRdXcRAJULAtBjqgMzkoHsqS9e0bxy/L8q5zrra3ku2og/73h3
         Qezc1W7ShWP//xtePfFf6rn7JPfDi97cPWSjxQN4tKQgy7H513lQNt5pWmsTRZtOXsdk
         julApMp4vYNRr1vNqZWLJv3HGBdfFaJOA4XVIvoXU4513p2Q7zm8l9k1YCMqAjJDUELA
         Y6xKibBdj5mkIiyno2A21y3NUFK8Hga/NlggRHy48Dr/LgQm6WJP6XnQA2DMlQfhojJ9
         qw6Q==
X-Gm-Message-State: ANhLgQ2Hnz+1E8OyMmG62EqXRzm8voakUV77yphdMA2gCO4+E/aqcMkN
        6CRQryDFkUKctzzvxrt3NBxSV+9Lv4SsLuTO1c7EbQ==
X-Google-Smtp-Source: ADFU+vt+cTzF+W4m9ZuLrugVE31A2dI3lE2J9BIpQq/GwEAFV9ZK8xkEnolSrCBv/dwQ0MPPETibjSvK5e83+lwRFIU=
X-Received: by 2002:a6b:dc05:: with SMTP id s5mr86042ioc.72.1583428511510;
 Thu, 05 Mar 2020 09:15:11 -0800 (PST)
MIME-Version: 1.0
References: <20200221101936.16833-1-t-kristo@ti.com> <20200221101936.16833-16-t-kristo@ti.com>
 <20200304224220.GC2799@xps15> <28ab188e-9e6e-35dd-c423-30aaa80afb90@ti.com>
In-Reply-To: <28ab188e-9e6e-35dd-c423-30aaa80afb90@ti.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 5 Mar 2020 10:15:00 -0700
Message-ID: <CANLsYkwKUQZ=xxG5Xox7G+7J6VYDriJAUckY3WH56pQRtwE=Rw@mail.gmail.com>
Subject: Re: [PATCHv7 15/15] remoteproc/omap: Switch to SPDX license identifiers
To:     Suman Anna <s-anna@ti.com>
Cc:     Tero Kristo <t-kristo@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        "Andrew F. Davis" <afd@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Mar 2020 at 17:24, Suman Anna <s-anna@ti.com> wrote:
>
> Hi Mathieu,
>
> On 3/4/20 4:42 PM, Mathieu Poirier wrote:
> > On Fri, Feb 21, 2020 at 12:19:36PM +0200, Tero Kristo wrote:
> >> From: Suman Anna <s-anna@ti.com>
> >>
> >> Use the appropriate SPDX license identifiers in various OMAP remoteproc
> >> source files and drop the previous boilerplate license text.
> >>
> >> Signed-off-by: Suman Anna <s-anna@ti.com>
> >> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> >> ---
> >>  drivers/remoteproc/omap_remoteproc.h | 27 +--------------------------
> >>  1 file changed, 1 insertion(+), 26 deletions(-)
> >>
> >> diff --git a/drivers/remoteproc/omap_remoteproc.h b/drivers/remoteproc/omap_remoteproc.h
> >> index 13f17d9135c0..828e13256c02 100644
> >> --- a/drivers/remoteproc/omap_remoteproc.h
> >> +++ b/drivers/remoteproc/omap_remoteproc.h
> >> @@ -1,35 +1,10 @@
> >> +/* SPDX-License-Identifier: BSD-3-Clause */
> >
> > This is odd considering omap_remoteproc.c is GPL-2.0-only
>
> We were using these enums on the firmware-side as well. The first
> version of this in v1 [1] is actually using Dual BSD and GPL-2.0-only,
> but even that one had posed some questions, so just converting to use
> the SPDX for the original license text.

Very well.

Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>
> regards
> Suman
>
> [1] https://patchwork.kernel.org/patch/11215415/
> >
> > Thanks,
> > Mathieu
> >
> >>  /*
> >>   * Remote processor messaging
> >>   *
> >>   * Copyright (C) 2011-2020 Texas Instruments, Inc.
> >>   * Copyright (C) 2011 Google, Inc.
> >>   * All rights reserved.
> >> - *
> >> - * Redistribution and use in source and binary forms, with or without
> >> - * modification, are permitted provided that the following conditions
> >> - * are met:
> >> - *
> >> - * * Redistributions of source code must retain the above copyright
> >> - *   notice, this list of conditions and the following disclaimer.
> >> - * * Redistributions in binary form must reproduce the above copyright
> >> - *   notice, this list of conditions and the following disclaimer in
> >> - *   the documentation and/or other materials provided with the
> >> - *   distribution.
> >> - * * Neither the name Texas Instruments nor the names of its
> >> - *   contributors may be used to endorse or promote products derived
> >> - *   from this software without specific prior written permission.
> >> - *
> >> - * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> >> - * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> >> - * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> >> - * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> >> - * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> >> - * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> >> - * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> >> - * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> >> - * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> >> - * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> >> - * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> >>   */
> >>
> >>  #ifndef _OMAP_RPMSG_H
> >> --
> >> 2.17.1
> >>
> >> --
> >> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>
