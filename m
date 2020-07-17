Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA89BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 01:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 968FE207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 01:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XimmIqy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgGQBAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 21:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgGQBAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 21:00:53 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72D5C061755;
        Thu, 16 Jul 2020 18:00:52 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id x9so10608882ljc.5;
        Thu, 16 Jul 2020 18:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PvwLgS93w4+R3M4B0OHgO9HiGM5AwA5/GRoIcW5VUB0=;
        b=XimmIqy1Cpd2ffFk9jhtDl8EZFsThbzRDSvXNcjYLKO/PQ6L2bl0FP7E9db8wcCyIN
         bR29iJjplPcRpuVuX9ZSX+wRuyjhLoWLSFZ6UtYC3Ic/P2qXX86VMd7/qHPtxgV7irY7
         LG4hHHRYQR9uwjKU2GLfdRnerCM/mcNht41ej5nwJS6hjAXIr2lxXX4pIJ7CY/tGuReO
         BYt70AD4k6Him75EJBrkdsEINZ5gFFhejURewIGrhLKe8zd95wSm9NLu2I7ppHkJzj89
         rnFSBZDMpWwo0cgoiGl+IdU/gB5Cq/WnPB6X8j6PytOiZISrcklQVU3ltGiIlx7UUWBb
         KWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PvwLgS93w4+R3M4B0OHgO9HiGM5AwA5/GRoIcW5VUB0=;
        b=F5qCMJtAxbd0e+n9DqSIBLNPxGevTJHgPi0iI9JfT22Y+YO6QXVi8hAsVYutIpZZFN
         nfdkHiJ0Y2Rz//1aeWc2+GCO8If4yVN5QmBQYnmGIRjS2Dxgy+kSbqUqie3QcmuEenn3
         yZE4/kUN8YO2pYarKwBOSk87zSq2qwm9jSRa5fghrngDq/5bG1HVmwWnDse82KGLRG2I
         NyTdhEDh7gg5lcKbbP0oZLerbjfvAY+HrkhroWwm4h/lnFuHLG4c8NYlDUwDlirJ9sZL
         6GpJriUc7gNsbxFDusJsgLl/vy+5H9ODkNsuOpMAg7uNG/S9xzgjJtyu+u+ANgycZLch
         RqeQ==
X-Gm-Message-State: AOAM530cStcC3gvhL5sPUApRsV0g9+eZ+EJFJSMveGoIItyDd+mNS55a
        TkuvM91Vv8GT9ipn3Pus+aKRmJKCeEHxxtFXyO4=
X-Google-Smtp-Source: ABdhPJzcDpSaZohCviRaojC+61vdJ6m4dlmgVTY7D/t7xjtmh4BSiX1WpdAgEwIkCWpC3cJz98IScuzW9wngmU/0Iss=
X-Received: by 2002:a2e:9144:: with SMTP id q4mr3406706ljg.84.1594947651117;
 Thu, 16 Jul 2020 18:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200713134114.137265-1-gnurou@gmail.com> <20200714223344.GA20740@amd>
 <CAAVeFuKomLcAue9rGXhK3Uc=H+v9ZLBA84Ozr_rZDRQMYeC=dg@mail.gmail.com> <17fe52a2-73ff-b547-8a59-5df009c929c8@gmail.com>
In-Reply-To: <17fe52a2-73ff-b547-8a59-5df009c929c8@gmail.com>
From:   Alexandre Courbot <gnurou@gmail.com>
Date:   Fri, 17 Jul 2020 10:00:39 +0900
Message-ID: <CAAVeFuJQCp7Fpqx3nUHMy29Jw1pLNoQtxRw3qxfEf3YKnrm0fw@mail.gmail.com>
Subject: Re: [PATCH] leds: add NCT6795D driver
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacek,

On Thu, Jul 16, 2020 at 4:32 AM Jacek Anaszewski
<jacek.anaszewski@gmail.com> wrote:
>
> Hi Alexandre,
>
> On 7/15/20 3:54 AM, Alexandre Courbot wrote:
> > Hi Pavel,
> >
> > On Wed, Jul 15, 2020 at 7:33 AM Pavel Machek <pavel@ucw.cz> wrote:
> >>
> >> Hi!
> >>
> >>> Add support for the LED feature of the NCT6795D chip found on some
> >>> motherboards, notably MSI ones. The LEDs are typically used using a
> >>> RGB connector so this driver creates one LED device for each color
> >>> component.
> >>
> >> Ok, let me take a look. What entries does it present in /sys?
> >
> > Right now these 3 directories in /sys/class/leds:
> >
> > nct6795d:blue:
> > nct6795d:green:
> > nct6795d:red:
> >
> > with the usual suspects `brightness` and `max_brightness` in each. I
> > am not 100% sure I got the names right so please let me know if that
> > is not correct.
>
> You miss LED function, that should be in the second section.

The reason for not having a function at the moment is that I took a
look at include/dt-bindings/leds/common.h and could not find any
function that could reasonably apply. This basically controls a RGB
connector on the motherboard which serves no particular function - you
can plug a RGB fan or anything else you want and control it in any
fashion. Is there a function that applies to this use-case?
