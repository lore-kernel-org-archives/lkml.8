Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F7CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6FF1207F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fy0kdcuo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgERKEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 06:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgERKEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 06:04:53 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABA8C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 03:04:53 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id t15so3078661ios.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 03:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RKROO8T8T/wRvHNAyo40LMuoZm+6bud6XqpTFz5/h4w=;
        b=fy0kdcuoeSucOVpB37b28WEy2Z7BTjSQPoaSXSZqfWX5PynLzWLa06IIOmSb47HQfk
         Nk7Lz8qUhRmZt6Uqw/+gbocUoU6pJc8rWwzPJwyXSzPNmym88rVnFeD71u5olQiXqTch
         i6vC8EcjOjdQRWfG5xjD03JaXffn85wsZgbw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RKROO8T8T/wRvHNAyo40LMuoZm+6bud6XqpTFz5/h4w=;
        b=qAklO3my9QS6yYWLk0hXYrpoIyCRpAjHIxi9njiFEm6tDkNg4CeIGb7NohQdiu21Lm
         LKqPa2rOqSpPAMADDjP/jz+CEcltUDOI3J3ZZ2oweolDsR8yHlqfbiUSeV8r41mvshey
         qkHr093w1bPS76UQAIEPVKFP3ghpzWtwGWHiOCoszVRxSoNXy5vbZ3k0aNlEWpXewuX8
         wpzm2J6gJl4LkO2Ue56rCkBF8MSsLFetn1Yx2CSinr2EkoNAL+nwFCiosGU8J/x6fGOC
         x9VV9gb1HttLKZuQEcdUzT9zl/pKdUKfrK1XHV8r4oxKaT8D0KGrk9CFPkbkx7/9M18t
         g3HA==
X-Gm-Message-State: AOAM5316Uz9FAQPiZhpDTcrmAzb+1DQ7BnXyxVill6H1ETIan6FG/rCX
        BkQwmuByIzR/909lGU2zJds1jI6te0s=
X-Google-Smtp-Source: ABdhPJyzCyk9LQ0CYTpq5J35JaxAbdvLpLzVw/ZMJAuB5NmY7Q5EnVQZLtfq0QVtFhtifRoXpvXsJA==
X-Received: by 2002:a6b:e911:: with SMTP id u17mr13588535iof.29.1589796292687;
        Mon, 18 May 2020 03:04:52 -0700 (PDT)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com. [209.85.166.179])
        by smtp.gmail.com with ESMTPSA id f9sm3722934iow.47.2020.05.18.03.04.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 03:04:51 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id j3so9204077ilk.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 03:04:51 -0700 (PDT)
X-Received: by 2002:a92:b001:: with SMTP id x1mr5174498ilh.18.1589796290578;
 Mon, 18 May 2020 03:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200506072314.112409-1-tientzu@chromium.org> <20200506072314.112409-2-tientzu@chromium.org>
 <20200515124621.GB1888557@kroah.com>
In-Reply-To: <20200515124621.GB1888557@kroah.com>
From:   Claire Chang <tientzu@chromium.org>
Date:   Mon, 18 May 2020 18:04:39 +0800
X-Gmail-Original-Message-ID: <CALiNf2_ukL1Ogk3MW5_DSCXHcVxTaE2Rv_JkF+hi7E-8XfrBxw@mail.gmail.com>
Message-ID: <CALiNf2_ukL1Ogk3MW5_DSCXHcVxTaE2Rv_JkF+hi7E-8XfrBxw@mail.gmail.com>
Subject: Re: [PATCH 1/3] serdev: ttyport: add devt for tty port
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh@kernel.org, jslaby@suse.com, long.cheng@mediatek.com,
        changqi.hu@mediatek.com, linux-serial@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 8:46 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, May 06, 2020 at 03:23:12PM +0800, Claire Chang wrote:
> > serial_match_port() uses devt to match devices. However, when serdev
> > registers a tty port, devt has never been set. This makes
> > device_find_child() always return NULL.
> >
> > Assign devt in serdev_tty_port_register() to fix this.
> >
> > Signed-off-by: Claire Chang <tientzu@chromium.org>
> > ---
> >  drivers/tty/serdev/serdev-ttyport.c | 2 ++
> >  1 file changed, 2 insertions(+)
>
> So is existing code broken because of this?  Or does no one ever call
> device_find_child() on this?  Who needs/uses this?
>
> thanks,
>
> greg k-h

I'm not sure. Our use case is to control the wake on bluetooth
behavior by the power/wakeup node.

`readlink -f /sys/class/bluetooth/hci0`
/sys/devices/platform/soc/11003000.serial/serial0/serial0-0/bluetooth/hci0

and we'd like to use
`/sys/devices/platform/soc/11003000.serial/serial0/power/wakeup` to
decide whether to enable the in-band wakeup on uart host side.

Thanks,
Claire
