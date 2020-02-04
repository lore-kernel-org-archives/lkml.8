Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E6CC3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D4E20730
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRyxYkhu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgBDLH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:07:57 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38305 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgBDLH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:07:57 -0500
Received: by mail-pg1-f193.google.com with SMTP id a33so9490085pgm.5;
        Tue, 04 Feb 2020 03:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ESHQtDlIcqtlfd+NGPSAxf7TiL0GDSX0Vx2MqLzOZw8=;
        b=CRyxYkhua7wqf0UmXQPzq2KQXbrAz9m4mVtTNrv2cRwBLNqziFULS+46m1H0OU+DOt
         5YZK19o0bVR+jIfRuIK2NuRu5lObnKIwqtXBvtR5LxB0dUzWVBkCmDqdD5a6Xc2ZdyeD
         v2zSLltYTJSJsfDfYJgJURvpv809LiznmqL5dwlmSLA51wqDruR/vYMNvo7Wp3vjSODC
         5UutoOkZ1X1hveYWu3qzbSsII+qkXVidqTt1mxtYyW+fEyOBPhkq+CA+2lQlgFfwVm1P
         BeNQIVmNeLSHwVS9Qc8moooCkvdI6MK3rJJ3Jp55ofZ/L996+QKK7WvlUrqm2x/wHiwM
         nw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ESHQtDlIcqtlfd+NGPSAxf7TiL0GDSX0Vx2MqLzOZw8=;
        b=FDh28kNJtC3AkLraELOeYNqOzFWDVcZAt9bpGz+HrQoN6NASpexAKYzxYiqC/6gLpb
         ZMuKuzHzWBpYh3khgh+LpcyksyyeJha4W//i8UboRiVSkcSI8149GGfm9Fl0Q4+UzJLW
         r8cLUVtP+xhTgwDtkNRR3me0DcgKTKcN3vroJym8BxXwJPwJsrN6ul5AZTqedNlWdNCY
         7IpvXaGRLupHJZ9uOeLnc0jninXtq5RRhxnMUyPwcprBAtx8X8L1jb3jbflG52yC4+mj
         tILyoqeSbyYpqB7HYW4g8w3jj9cTGT+HcE8TMStgltWMECKwu/Jvvqfrozg+bNwFKa9+
         HDyw==
X-Gm-Message-State: APjAAAXKyArdZ710P0YljW/JsiI3fE9Ift+sMIWRRX4fUJN9tHvEHGcp
        tF/N0XRjs9aBQ3xojwR5xHBaaju04keZ52tJtLzi8TjqBdk=
X-Google-Smtp-Source: APXvYqyPQ+yETkyt1/TkchmZ3n6Rdzgwtsf/ny9fnoHapXSiK5r4dCz5U/ntSbFw4vm7r9QH01Z0RYz3v7l6Imiw3FU=
X-Received: by 2002:a65:4685:: with SMTP id h5mr32173510pgr.203.1580814476576;
 Tue, 04 Feb 2020 03:07:56 -0800 (PST)
MIME-Version: 1.0
References: <20200131023433.12133-1-chris.packham@alliedtelesis.co.nz>
 <20200131023433.12133-3-chris.packham@alliedtelesis.co.nz>
 <CAHp75VfT=KNM6J1bP5cPsLw7Z776opcB9Kf6qhNCZukY-7g=pQ@mail.gmail.com> <86509a5e6656c4f560ee6f6514ab00a232994957.camel@alliedtelesis.co.nz>
In-Reply-To: <86509a5e6656c4f560ee6f6514ab00a232994957.camel@alliedtelesis.co.nz>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 Feb 2020 13:07:48 +0200
Message-ID: <CAHp75VdRYDrTeBy9+TbbE8y3jt_Fntr6fnXon3CuqCZFYQ7Maw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] spi: Add generic SPI multiplexer
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 3, 2020 at 11:12 PM Chris Packham
<Chris.Packham@alliedtelesis.co.nz> wrote:
> On Mon, 2020-02-03 at 11:50 +0200, Andy Shevchenko wrote:

...

> > > +       priv->mux = devm_mux_control_get(&spi->dev, NULL);
> > > +       ret = PTR_ERR_OR_ZERO(priv->mux);
> >
> > This is a bit complicated.
> >
> > > +       if (ret) {
> >
> > Why not simple do
> >
> >   if (IS_ERR(priv->mux)) {
> >     ret = PTR_ERR(...);
> >     ...
> >   }
> >
> > ?
>
> I've had other maintainers/reviewers suggest the opposite for patches
> I've submitted to other subsystems which is why I went with
> PTR_ERR_OR_ZERO. It also works well with the goto err_put_ctlr; which
> needs ret to be set. It's not exactly a common pattern in the spi code
> so I'd be happy to go the other way if that's the desired convention
> for spi.

Either way is the same amount of lines. The slight difference, that we
don't check for 0. Can you check if generated code is different in
these cases?

-- 
With Best Regards,
Andy Shevchenko
