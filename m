Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878A9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58249206D3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uo7UO3Dz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgAaP5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 10:57:43 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46322 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728922AbgAaP5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 10:57:43 -0500
Received: by mail-pg1-f196.google.com with SMTP id z124so3667924pgb.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 07:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sze0BBlw28/vvUMYTGMEhxjvTbDKyuD9mFgWdc6IiRQ=;
        b=Uo7UO3DzvLTaGXorH5ASMuMVAooot3RsLFc6K9nCXDj3tcpoD8n1Fji9j5+9avoynY
         rnEGGuCOfVI2oO39NOFQgdfto1DzeuyK9kn2U/QQ4XRUId+RhsRITyS4dUXjA/R4YN8p
         rr1V2FtdglSWvLHfudEI20SUeDZqw49PtRjztb8DBiMijBS2s9PAp7iUZPfp6/QYrlNH
         dR6zExKY/DnYWgR9G07WKCh3yMC2x1IehCvSPtopK8ASHAg7ueBRFd2pL2uQ6Tuy4YO0
         NGOSqYF2A88aBu1JFgKRsRWKVXRqk7gHzlESZPtj9j+gf9zJpXIM4dALqR0YM96+hYqT
         vnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sze0BBlw28/vvUMYTGMEhxjvTbDKyuD9mFgWdc6IiRQ=;
        b=CJuvVQQznR7XFETG/WPPcmxVfOpGSqfIhD+pDHdsKuvN25JA0Aoel64F94U+E+rSHz
         eZgc490mdX5eX6bQuNZqkwRZoCF2SHC16lwo6umS9MtrToKRxnQz1BSo/lE2+H+2OE5d
         qLssoC3AaLNxa94VK/C5eMcPiuqKx+vlnxAGPd9QfTvpkMpA9DJkh6qjbGmEg62msY/c
         choT5aokJPyZg9sJRUMcRXGlAPl+dVBKrL/zW51Fo5xs4GGKG7G8OXZyO3s9yckcFp4l
         9pu6S3miaCfnv++msHBQive4BnTJPjcv+L/fXRaMsj3Sj75djc+5fWMsxSCuimxBbo/7
         nmmQ==
X-Gm-Message-State: APjAAAXFnROscmQtiMshI8W8rDH47ZfNUwEYLLIPSlqwC+w79jSXMPZl
        hcvYtt9/TbLTca8ii3nUWbY3ODSflPyf2vB42r0=
X-Google-Smtp-Source: APXvYqzuoCw3oPgfZDscC2kvwIwh8g4u8/eQbkAhcB79vldO6A0E+cVobFqbMP+48+WjrIkDHd+kvFCSF+mAVxwQaeo=
X-Received: by 2002:a65:5242:: with SMTP id q2mr10715791pgp.74.1580486262778;
 Fri, 31 Jan 2020 07:57:42 -0800 (PST)
MIME-Version: 1.0
References: <20200131153440.20870-1-calvin.johnson@nxp.com> <20200131153440.20870-6-calvin.johnson@nxp.com>
In-Reply-To: <20200131153440.20870-6-calvin.johnson@nxp.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 31 Jan 2020 17:57:34 +0200
Message-ID: <CAHp75Vf+UVMS1WOQ3KB8DiSB5KD2oFQs5ZmJ5yDPi=3i4uZVRg@mail.gmail.com>
Subject: Re: [PATCH v1 5/7] device property: Introduce fwnode_phy_is_fixed_link()
To:     Calvin Johnson <calvin.johnson@nxp.com>
Cc:     linux.cj@gmail.com, Jon Nettleton <jon@solid-run.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        cristian.sovaiala@nxp.com, laurentiu.tudor@nxp.com,
        ioana.ciornei@nxp.com, V.Sethi@nxp.com, pankaj.bansal@nxp.com,
        "Rajesh V . Bikkina" <rajesh.bikkina@nxp.com>,
        Calvin Johnson <calvin.johnson@oss.nxp.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 5:38 PM Calvin Johnson <calvin.johnson@nxp.com> wrote:
>
> From: Calvin Johnson <calvin.johnson@oss.nxp.com>
>
> Introduce fwnode_phy_is_fixed_link() function that an Ethernet driver
> can call on its PHY phandle to find out whether it's a fixed link PHY
> or not.

> +/*
> + * fwnode_phy_is_fixed_link()
> + */

Please, do a full kernel doc description.

> +bool fwnode_phy_is_fixed_link(struct fwnode_handle *fwnode)
> +{
> +       struct fwnode_handle *fixed_node;
> +       int len, err;
> +       const char *managed;
> +
> +       fixed_node = fwnode_get_named_child_node(fwnode, "fixed-link");
> +       if (fixed_node)
> +               return fixed_node;
> +
> +       err = fwnode_property_read_string(fixed_node, "managed", &managed);

> +       if (err == 0 && strcmp(managed, "auto") != 0)
> +               return true;
> +
> +       return false;

Maybe other way around?

  if (err)
    return false;

  return !strcmp(managed, "auto");

?

Same pattern perhaps for the patch where you introduce fwnode_get_phy_mode().

> +}

-- 
With Best Regards,
Andy Shevchenko
