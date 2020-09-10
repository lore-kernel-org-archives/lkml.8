Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SHORT_URL,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA9DC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C65B2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/IeTM2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgIJSxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgIJSwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:52:13 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C735CC061756;
        Thu, 10 Sep 2020 11:52:00 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id m6so8081199wrn.0;
        Thu, 10 Sep 2020 11:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NoURE3RosGdEZhUcwRMpu2K3apR4AlJgBKa/tawEZfk=;
        b=Z/IeTM2e5NkdtHQMUTb3OBmgHD+yR+MMTlGFeyQDVmqgkF5U8650h+tRODQpFU5kgu
         mo7+bXbrs+gl/nHwF3XbbNUYNC+RwCYpn/Mfr64lBXPq9IzuhbYQm1e/1jftVD8V7/2p
         esqP62aZvxUvJLR5XZQZldvaHkKKyHC8hawG/RRtVj3A6Ve3SZzXKbAGJGJu8SA5mbiK
         YqQ1PcoouNZD6SyHdF20+qEnJrBar560sZujlPoMVVddRMqCtSLf8rssgtqmXupduZwY
         9vbxwvV04Zo0pv+n6oVhpSlXvE6YVz80BNjhKmxyah2pAotDUvJErEg1xdoxEIBKbuEv
         ZhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NoURE3RosGdEZhUcwRMpu2K3apR4AlJgBKa/tawEZfk=;
        b=Y2CkRtPKo7Hh/r7dAJIAQfeJj9f5nr0RuY7rZcuuvtRAoH1+7VNnr+zovsvieNQNA3
         dNoGdhBxN6zeyEj3DI1zcbDD/+wERD+LSw7nR3YIV1TSzME7+iFiH7Y3BsZoruF57RoB
         kwnShsOC6KEK+8KjTv6yuhwLBo73xUwNB5CZ73bc8wv6PS4AsE5kfx2Rej/aGePEDo/E
         4ucrl4F/GH7odjPl9J5ZqcVQunxRTQb6ySvLuANjeHg3eJJIhi0oviqqRxwK5oVs+c5y
         G13Z64HiIGnPbe8c26pAGGHgogS0asDb0HLEuJA8oXUa/SvFDeyOrrJE7Mb02wIHiEdt
         96VA==
X-Gm-Message-State: AOAM532anGwOSGArnSvWy305PgJPPvJOaZSk9n4T7SrdxJ0bYKfL012H
        I7iIATlwyhoidFq1w1c7zZwIt59Uc5bOm/6eB2mpAwB9BfE=
X-Google-Smtp-Source: ABdhPJzUqIlEf2y1VGjc3kYbIjir/oxCkfS4m5t1QPeH+zkIf2r0/3BLeq+PMPP2oRVwe/WAHibHdBxxCBRWp8JuO00=
X-Received: by 2002:a05:6000:1152:: with SMTP id d18mr10331726wrx.173.1599763919345;
 Thu, 10 Sep 2020 11:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200909193419.2006744-1-james.hilliard1@gmail.com>
 <1599706954.10822.3.camel@suse.de> <a1161f77-5b37-39ea-eb91-7b0b59278960@gmail.com>
 <20200910080850.GD24441@localhost> <CADvTj4rDdj8KtLhGZEZP+XZcF4DTE4oW9sNf=zNWaRPzkny93A@mail.gmail.com>
 <20200910085541.GA1099591@kroah.com> <CADvTj4pYR9H1X1_f4DYTkb5ViXAdx9sO5yBgHgM5vFaDMs_miQ@mail.gmail.com>
 <26a723e4-e166-6377-875a-f737a15dc6b1@marcansoft.com>
In-Reply-To: <26a723e4-e166-6377-875a-f737a15dc6b1@marcansoft.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Thu, 10 Sep 2020 12:51:47 -0600
Message-ID: <CADvTj4o9GL5p6eZq+0Q_Pw_ZKuYHvAtav79==CJDdnTj7q+bBg@mail.gmail.com>
Subject: Re: [PATCH v2] usb: serial: Repair FTDI FT232R bricked eeprom
To:     Hector Martin <hector@marcansoft.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Lars Melin <larsm17@gmail.com>,
        Oliver Neukum <oneukum@suse.de>, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russ Dill <Russ.Dill@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 3:57 AM Hector Martin <hector@marcansoft.com> wrote:
>
> On 10/09/2020 18.52, James Hilliard wrote:
> > So I'm having trouble coming up with a reliable way to fix this in userspace,
> > I've already got quite a few moving parts there as is and most of what I
> > come up with seems like it would not work reliably, at least for automatically
> > repairing the eeprom.
>
> I'm confused as to why this is hard to fix in userspace. You already
> said you have userspace code binding to the proper VID/PID, so your code
> won't find the bricked device. Then it's just a matter of having a udev
> rule run the unbricker when it detects the bad device (which should
> issue a USB reset when it's done reprogramming, making the device appear
> as the right VID/PID), thus effectively doing the same thing the kernel
> does. If this is embedded and not using udev, then substitute whatever
> equivalent you have. If you're polling for the device at runtime instead
> and don't have a device manager, just poll for the VID 0 device too and
> apply the fix.
Wouldn't you have to do a bunch of stuff like unbind the ftdi_sio driver before
you can issue usb control commands from userspace?

I haven't tested this yet but my assumption was that either a kernel driver
or libusb can issue usb control messages, but both can not be bound to
a device at the same time. I figured this wouldn't have come up when you
tested your python script since the script likely predated adding the brick PID
to the ftdi_sio Linux kernel driver.

Maybe it makes sense to add a sysfs interface for reading/writing eeprom values
without having to unbind the ftdi_sio driver.
>
> I can't think of a scenario where this would be difficult to fix in
> userspace...
>
> --
> Hector Martin (hector@marcansoft.com)
> Public Key: https://mrcn.st/pub
