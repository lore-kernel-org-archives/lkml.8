Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SHORT_URL,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BFBC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 04:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2FC42075B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 04:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTHoYaMk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgIJEkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 00:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgIJEkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 00:40:12 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2E7C061573;
        Wed,  9 Sep 2020 21:40:10 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a9so4403950wmm.2;
        Wed, 09 Sep 2020 21:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mc9SNJlcG+CRra5ZD7ro4UIYeqbPZf8MuQyyBF3eIN4=;
        b=LTHoYaMk5cQETYo/PMWMjoLIuUg0dtbCwLfx27HE4m8ksDcqiDZUz08HtGzlvImGuA
         4R/336vmqWeBNR53AtfB8dbj9NEP9zFjGqASl4MHMbute89Fvps+3Fy0HCaGzCCXD6A6
         zxl/tlOefZjf4O+m4iDtaM68dQcoGnzHBKXOwDBm6GXbUQCQJSA81/xabUK2beM8XN4A
         Km9EfQ6FAqawq6wYGSJVD0LQoniC7rhX7X5FY0T06um1LH/3gLYMY/FJ1tRSQhMESjUn
         AruZDX1jcPtowc3cXe50dTdmlImFE6ImylL8PW8SRU+A+MizPZ0en8ULjVCKOEZixgPd
         /drw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mc9SNJlcG+CRra5ZD7ro4UIYeqbPZf8MuQyyBF3eIN4=;
        b=S762FsE1PBBzh3GacVhVJwalKkXVhTGRVian3dmgO+0PVkOp0IQyq2W64PcZDD5Jaj
         dfkgucLwVvDyo/G4CvshQw9f8Ij3n8bzqzsCPW+ZD6t2BWIpWKRwHNxHIwrMdmymT+ak
         54umkhUOCTJ9Pe/NoSOAmQ9dQUSZw63UpE/JlDPF4sDUtd3kwyWD7Rq6qn2yFwcKBPuN
         9nmlGf/rq/g84nCzwpBMx5xKSZC4HRt9/tr1FKqvKL8vQ1HhvT+KwP4rMCoMktAn60vZ
         XSyuGlRCbldEXNr3Yr9uQ43vaXKucPlT0tykh5Cl3baw5fNIitItubnpl6oOYO+GQx4Q
         krYw==
X-Gm-Message-State: AOAM532M5XNZgqczDrnWPF4rdm3YCDIqhlDxJUXUOzfe5if3M+kO0i4G
        3Rw82QTvfemTuLnaFfD8fi9HwfwAy/sMjJXTv6hauxLdEXo=
X-Google-Smtp-Source: ABdhPJxd//jSojRixlr0FByN5tErk8/x5DHyd+5Pmz7vOOMTDT9m1YCBgpJAtJb+RfR/4yxVUyP6SZDMrWbtkn4bbwU=
X-Received: by 2002:a1c:14e:: with SMTP id 75mr6893527wmb.114.1599712809340;
 Wed, 09 Sep 2020 21:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200909193419.2006744-1-james.hilliard1@gmail.com>
 <1599706954.10822.3.camel@suse.de> <D2C1360E-65CC-410A-8B39-48F7340FEFCE@marcansoft.com>
 <CADvTj4o-T92C0bO6Bp9p1N-CjX80nzL+y6bPfosMqU2ftdex8Q@mail.gmail.com> <17A89C84-23A1-42DD-B541-F61BC7693560@marcansoft.com>
In-Reply-To: <17A89C84-23A1-42DD-B541-F61BC7693560@marcansoft.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Wed, 9 Sep 2020 22:39:56 -0600
Message-ID: <CADvTj4p7BuegLic+i9eW_JwXBPhkKZy85K98sX_as3S5Tv3vPg@mail.gmail.com>
Subject: Re: [PATCH v2] usb: serial: Repair FTDI FT232R bricked eeprom
To:     Hector Martin marcan <hector@marcansoft.com>
Cc:     Oliver Neukum <oneukum@suse.de>, linux-usb@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russ Dill <Russ.Dill@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 9, 2020 at 9:49 PM Hector Martin "marcan"
<hector@marcansoft.com> wrote:
>
>
>
> On September 10, 2020 12:46:20 PM GMT+09:00, James Hilliard <james.hilliard1@gmail.com> wrote:
> >On Wed, Sep 9, 2020 at 9:17 PM Hector Martin "marcan"
> ><hector@marcansoft.com> wrote:
> >>
> >>
> >>
> >> On September 10, 2020 12:02:34 PM GMT+09:00, Oliver Neukum
> ><oneukum@suse.de> wrote:
> >> >Am Mittwoch, den 09.09.2020, 13:34 -0600 schrieb James Hilliard:
> >> >> This patch detects and reverses the effects of the malicious FTDI
> >> >> Windows driver version 2.12.00(FTDIgate).
> >> >
> >> >Hi,
> >> >
> >> >this raises questions.
> >> >Should we do this unconditionally without asking?
> >> >Does this belong into kernel space?
> >>
> >> I agree; this is very cute, but does it really need to be an
> >automatic Linux feature? Presumably someone looking to fix a bricked
> >FTDI chip can just run my script, and those who just want to use those
> >chips with Linux already can since the driver binds to the zero PID.
> >Well for one your script is not easily useable with embedded platforms
> >like mine where I ran into this issue, I have no python2 interpreter
> >available in my production builds.
>
> Surely you can port the exact same algorithm to plain userspace C, as you did to kernel space C :)
Sure, but it would be significantly more complex, require a lot more code
and testing since there can be other userspace apps interacting with the
hardware, in addition to being less reliable and potentially difficult
to install
for some setups. Detecting and dealing with this issue in the kernel is
very simple and reliable in comparison. There's also potentially permissions
issues if one wants to do this from userspace from my understanding.
>
> >>
> >> I am deeply amused by the idea of Linux automatically fixing problems
> >caused by malicious Windows drivers, but thinking objectively, I'm not
> >sure if that's the right thing to do.
> >From my understanding Linux fixing up hardware issues caused
> >by faulty/weird Windows drivers isn't exactly unusual.
>
> I'm not aware of any instances like this where nonvolatile memory is modified. At most you'll get things like resetting devices that a previous windows warm boot misconfigured, I think?
Yeah, I think it's mostly nonvolatile memory, I've seen this issue quite a bit
with some of the Realtek ethernet drivers.

I think user experience for devices should be that one can move
a USB device from Linux to Windows and back without having to manually
reprogram an eeprom. The sheer amount of resources FTDI has wasted
with their malicious Windows driver is crazy and likely far exceeds any losses
from counterfeiting. I think due to how widespread this issue is it makes sense
to aggressively and automatically mitigate the damages wherever possible, it's
also likely a major source of ewaste since people may throw out perfectly
functional hardware without knowing it can be fixed easily.
>
> >>
> >> >
> >> >> +static int ftdi_repair_brick(struct usb_serial_port *port)
> >> >> +{
> >> >> +    struct ftdi_private *priv = usb_get_serial_port_data(port);
> >> >> +    int orig_latency;
> >> >> +    int rv;
> >> >> +    u16 *eeprom_data;
> >> >> +    u16 checksum;
> >> >> +    int eeprom_size;
> >> >> +    int result;
> >> >> +
> >> >> +    switch (priv->chip_type) {
> >> >> +    case FT232RL:
> >> >> +            eeprom_size = 0x40;
> >> >> +            break;
> >> >> +    default:
> >> >> +            /* Unsupported for brick repair */
> >> >> +            return 0;
> >> >> +    }
> >> >> +
> >> >> +    /* Latency timer needs to be 0x77 to unlock EEPROM
> >programming */
> >> >> +    if (priv->latency != 0x77) {
> >> >> +            orig_latency = priv->latency;
> >> >> +            priv->latency = 0x77;
> >> >> +            rv = write_latency_timer(port);
> >> >> +            priv->latency = orig_latency;
> >> >> +            if (rv < 0)
> >> >> +                    return -EIO;
> >> >> +    }
> >> >
> >> >Do you really want to change this without returning to the original?
> >> >
> >> >       Regards
> >> >               Oliver
> >>
> >> --
> >> Hector Martin "marcan" (hector@marcansoft.com)
> >> Public key: https://mrcn.st/pub
>
> --
> Hector Martin "marcan" (hector@marcansoft.com)
> Public key: https://mrcn.st/pub
