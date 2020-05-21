Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B339C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4D5F2072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQH3a0FV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgEUP7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbgEUP7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:59:20 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3CDC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:59:20 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so2993620plo.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V4UY/iO1dtV0DGmUtTr7wgmLRF9ZbtUeAeGkEQgW2fg=;
        b=DQH3a0FVeAxUii5Q3eYrIfWEp1bUHCfXNugFzqJ/GUHWCxzXXFTMo0sMT9dy2YP6mZ
         YmhHn9uRHC3ItJPcSz58ic3G6tvqkS0kQLRBm5jqfgcZfLsC4EYbXAZEUZnjXRD2d0vL
         c1kWNFWTl7h5yBBWE5xFrlZkZaWThPSte1CGJLA6Av/fli5/lcw0WRNN7hoM9SRIFqSl
         6Cxs2kPfhEDQ1107nQysWkXJLlyspHC+NWQQjH2kokwcGUxUbsMFkizUlInrnEyG+/tr
         JOMq4cJ9zRfhBPU9jqjIPl2orHY9tUXCkPehARudbM+1daUlkopRJnMkR7u/piU19x+z
         LQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V4UY/iO1dtV0DGmUtTr7wgmLRF9ZbtUeAeGkEQgW2fg=;
        b=DC9qT4TuqI8u3Q31Fg41vFHG7f/hmpeDXjPpwPbkyRrcvpisVUx04rCfrhp1IYwp1w
         tf5N0Y5XZGOWfPaHbUWwEI//wcDrGx7VFsa2zdJd6lIvnkk/gJ0/UYmoo9G02svJw2s6
         gHZScIe7u2QPonAJi5+wRr0ANawN3X0+UA0j0uU2+A/jL25UluFP7LhPLLRqvgfXD5qV
         7j3RDtvtsqJBzecBTzzWkwMA86poHk7OLpZtGQ/S8x/M3/sLCsKJnNFLeCnxIVIvKbVW
         eAo6qPJ3HoXS2Jx7G1exz1RLCjQLBQTCyue/cyd2ddnHsB9WJAKEQrZf0AD4of+lS97p
         ddSw==
X-Gm-Message-State: AOAM531RkkA4YXJWZLnHqsgg8boo9/02FXwcPp4e6mQdyw7x1ismn7uI
        teIhCFeBi0PCaQW4+qKPsO0FXskLf71pqAvk0F4GBTnJbOQ=
X-Google-Smtp-Source: ABdhPJzeahkzD0iIJ3NFgMjoUyG+a8GFkuxsdI6o6RB6HB7bhYm1f1p7qWMDlAv1w9DcLt3Ypxp7TJ4j6Khk9ZqObWs=
X-Received: by 2002:a17:902:6ac2:: with SMTP id i2mr10547431plt.18.1590076760169;
 Thu, 21 May 2020 08:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20161202195416.58953-1-andriy.shevchenko@linux.intel.com>
 <20200120121645.GI32742@smile.fi.intel.com> <20200521155304.GA1921871@smile.fi.intel.com>
In-Reply-To: <20200521155304.GA1921871@smile.fi.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 21 May 2020 18:59:08 +0300
Message-ID: <CAHp75VfY84FQaw5HF2hLV3gfY3DFgUa2vqtgEER1qXgKkhPdow@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] firmware: dmi_scan: Make it work in kexec'ed kernel
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 6:55 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Jan 20, 2020 at 02:16:45PM +0200, Andy Shevchenko wrote:
> > On Fri, Dec 02, 2016 at 09:54:14PM +0200, Andy Shevchenko wrote:
> > > Until now DMI information is lost when kexec'ing. Fix this in the same way as
> > > it has been done for ACPI RSDP.
> > >
> > > Series has been tested on Galileo Gen2 where DMI is used by drivers, in
> > > particular the default I2C host speed is choosen based on DMI system
> > > information and now gets it correct.
> >
> > Guys, it was quite a long no hear from you.
> > Today I found that Microsoft Surface 3 also affected by this.
> >
> > Can we apply these patches for now until you will find better solution?
> >
> > P.S. I may resend them rebased on recent vanilla.
>
> Okay, since there is no reply I take it as confirmation that the problem exists
> and needs to be addressed.  So, I'll send a new version of the series with
> updated commit messages (to mention Surface 3 issue).

Ah, I found reply from Eric from Jan 21, this year. Somehow it's
slipped thru my eyes.
I'll read it carefully and react accordingly.

-- 
With Best Regards,
Andy Shevchenko
