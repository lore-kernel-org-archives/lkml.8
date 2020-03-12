Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1579DC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16872067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K9wdZeHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgCLQhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 12:37:48 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:41835 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgCLQhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 12:37:45 -0400
Received: by mail-ot1-f43.google.com with SMTP id s15so6922425otq.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 09:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MYtEPdrTksnGvDZU5deL4CbY9Pr9ioIV5tkxQ/zHu9E=;
        b=K9wdZeHL5rkylrZz3QIeSH+2rSRaU/h8JfwlYHPQVkc1YTeX3aYZHzKozu1Uh9dGmW
         al/g5ZOeGmatS1po/OOiwYPpVnuwgNjRDMnm37LUrARxdr2D7c+UQ8BfOm773vJ38KB4
         WyJL6FoyqANhVa43OkIu37Qm+iMm4zKxaNoyM1dwCOxiTEHUeCvSpIqJa5SWrNPYI0mG
         7FEO4d6rMrB+CWnvO+a1xme3jdmlAWODxkI6xVbkFJ7KojYC/IAy1zx8BHJZZW4NU2XD
         duN5csFpY+MN/H6Y4wwobhExb+fpRbdG/uyLFsrcm7iHlXNPYNlOPB4/MKHiQ8sgTL20
         wivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MYtEPdrTksnGvDZU5deL4CbY9Pr9ioIV5tkxQ/zHu9E=;
        b=oDlj5dK7+U6OAuI50wJUgmyRTR1/JqA4dC3kr4ohUMR2+aeXYOVsf9+b4ObHi8PIz0
         Ykusr6Q3/Gft+Pai6pV/XT8ifqRu1A1zBKZ7xuQYT/LnxDk1fetDgwZwNlOkoG2hBdNl
         JxOAz/C91Yw+1/OySMwGpzXII/SsmZgAn7zWURVQV9Wk2ee09PDK2GINV6c2UzEnuX2N
         hjTcexeCcvChErm0/UAejD3XmBPuCTmip7q1CKW2ouUEZWKb1ajcUwtGZreuEhJJWPsw
         kCdLMCjrKGsg5Fkcx74PyGrtOjLR2J9SymVbxsnkFOA9WAwmbnmAYNOI3wSpCBfImUqz
         w+Ng==
X-Gm-Message-State: ANhLgQ15h3WZ2KQSo02qmeU938mELRu5NzD6eI2RuXmXbqiXhwyb3rNB
        T9e4JotcPv2tWIcjKHiibgFgapFm/vRVqwMJ+ucKwA==
X-Google-Smtp-Source: ADFU+vtZrRh7IowOp5OH0oSfDw8psJiJhEtJqqx6lihfLrI2TL2niHppJIGBv22OqVb3O+3TasH0O7liOBZUKkgfp2I=
X-Received: by 2002:a9d:7756:: with SMTP id t22mr6718289otl.272.1584031064139;
 Thu, 12 Mar 2020 09:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200310134603.30260-1-robert.foss@linaro.org>
 <20200310134603.30260-4-robert.foss@linaro.org> <20200310143014.GL1922688@smile.fi.intel.com>
In-Reply-To: <20200310143014.GL1922688@smile.fi.intel.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 12 Mar 2020 17:37:33 +0100
Message-ID: <CAG3jFyuSj4NRAPHk0qch4SXg3iS7zss6tbRuC3mBnVL=MsLwVw@mail.gmail.com>
Subject: Re: [v1 3/3] media: ov8856: Implement sensor module revision identification
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     ben.kao@intel.com, linux-media <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Sakari Ailus <sakari.ailus@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Andy,

On Tue, 10 Mar 2020 at 15:30, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Mar 10, 2020 at 02:46:03PM +0100, Robert Foss wrote:
> > Query the sensor for its module revision, and compare it
> > to known revisions.
> > Currently only the '1B' revision has been added.
>
> Are you sure you send latest version?
>
> I have a d=C3=A9j=C4=85 vu that I have seen this already and this one doe=
sn't address any
> comment given.

I think pulled a series Dongchun Zhus earlier series apart and used some of=
 it,
I may have missed some of the feedback given to his v3. Sorry about that.

>
> ...
>
> > +     dev_info(&client->dev, "OV8856 revision %x (%s) at address 0x%02x=
\n",
> > +             val,
>
> > +             val =3D=3D OV8856_1B_MODULE ? "1B" : "unknown revision",
>
> This is weird. Can you add a bit more general way of showing revision?

This is modeled after the ov7251 driver, since that output came in
handy during bringup.

    dev_info(dev, "OV7251 revision %x (%s) detected at address 0x%02x\n",
         chip_rev,
         chip_rev =3D=3D 0x4 ? "1A / 1B" :
         chip_rev =3D=3D 0x5 ? "1C / 1D" :
         chip_rev =3D=3D 0x6 ? "1E" :
         chip_rev =3D=3D 0x7 ? "1F" : "unknown",
         client->addr);

To me this is pretty general approach, at least until this revision
information is used in other places.
I'm not quite sure what you had in mind. Maybe the current
implementation is a little bit clunky in the case of ov8856 since
there's only one revision number known currently.

Either way, I'll happily change it. But I don't quite know what you
have in mind.

>
> > +             client->addr);
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
