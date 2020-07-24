Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62523C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DD6D2065F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVqQDzTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgGXUCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgGXUCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:02:35 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FEAC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:02:35 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id j9so4812438ilc.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rzect1zoYXwpE7Gw9KZ24QWNMjzrgegunIj60A2shmc=;
        b=OVqQDzTWn8XMRsxNGEhuRkIazKiSS31JWhr07wRCHUlfKUDGcsYpVBfyCaa90puKoW
         qI0e4xlQQvJlWE6XdH3BgJ6sUgyuWLJX7LOmlupBU/Dk+wjd/qNLp4uZz3e1/+s284lU
         FkmrKAprdSJqTdXTUgknSPgD9454YQ7AwE3ljQK85aE5CdVs2tG+4LKeaLCaKLkSqik3
         wsxZH96PADWKXlR0YEvk5ztmf32bTAgw/0Dla5aztfRlIVDuA7X3InyZAPrloLaP7YM2
         /MS6BM6gotX7ddZ2OTApi/l8Aw/q1T3n8Nkp1z7YHFPsrg8ny11KH3zHPH9mwNhfT9Ph
         IzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rzect1zoYXwpE7Gw9KZ24QWNMjzrgegunIj60A2shmc=;
        b=g5sYmlWV3oqpzwc+euRQLwvKGG/qs/Jrc/pxcYLEAe//86wXJJWwzX4U4GWPWVS0fk
         V9ws7GtsyTWY9YEya4zb4F0MGOncaBMvjMxgEE8uMxq6ZlNbob3ileIhSJ8QJbf6jsIU
         y7peegVqQFqNDtE1Cxc0dmog22+1LzGZQF/tbjJy5XLKZS6xN9EbFzOlnMXkl+R0OQb+
         Z9gbSTapUh++k+8/EB00Ph9v7tR2pD0g2l/6BQdXTcIJrwfLRyVTJrRuA1SordVvRXv6
         oyAuPUQB4s+cij8zTEAvTQC1/CDMpZkUKCGdRgy7MLpYtn47NsLncITCBwvtJTmymNlS
         2W7A==
X-Gm-Message-State: AOAM532jHHFmMJDdeZngzRIgas5rye3coFXZe20wIol2b4P41NbMvSS9
        ToJxwuOuHLXwct1e2qUC9oENckLluCBiOpHCc0E=
X-Google-Smtp-Source: ABdhPJyvQs3lL/Xdz9IxTYCy4TTdyO5pnFyiqOQns6Htik+Knq15InRF3xZrgvTUFkekiFsJqGolwDnmlC13gEAEiA8=
X-Received: by 2002:a92:1805:: with SMTP id 5mr11092495ily.127.1595620954759;
 Fri, 24 Jul 2020 13:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200724120637.GA427284@vaishnav-VirtualBox>
In-Reply-To: <20200724120637.GA427284@vaishnav-VirtualBox>
From:   Christopher Friedt <chrisfriedt@gmail.com>
Date:   Fri, 24 Jul 2020 16:02:23 -0400
Message-ID: <CAF4BF-T3do2jFYu_n_JXSOn8P8mk=_Z4XzKo_VfTK=-dskX4WA@mail.gmail.com>
Subject: Re: [PATCH] RFC : mikroBUS driver for add-on boards
To:     Vaishnav M A <vaishnav@beagleboard.org>
Cc:     greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, arnd@arndb.de,
        johan@kernel.org, elder@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>,
        robertcnelson@beagleboard.org, rajkovic@mikroe.com,
        zoran.stojsavljevic@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vaishnav!

On Fri, Jul 24, 2020 at 8:06 AM Vaishnav M A <vaishnav@beagleboard.org> wrote:
> +enum mikrobus_protocol {
> +       MIKROBUS_PROTOCOL_SPI = 0x01,
> +       MIKROBUS_PROTOCOL_I2C = 0x02,
> +       MIKROBUS_PROTOCOL_UART = 0x03,
> +       MIKROBUS_PROTOCOL_SPI_GPIOCS = 0x04,
> +       MIKROBUS_PROTOCOL_I2C_MUX = 0x05
> +};

We've already chatted about this off-list, but I just wanted to post
here as well so other readers are aware.

Given that MikroBus will be layered on top of Greybus and will use
Greybus Manifests, and that there is a related change [1] for the
Greybus Manifest tool (manifesto), and given that other, non-mikroBUS,
form factors may want to re-use the "[device-descriptor N]" tag, I
think it would make sense to use

[device-descriptor];
protocol = [cport protocol]

instead of

[device-descriptor];
protocol = [mikrobus protocol].

As you mentioned, there is no specific mikrobus i2c protocol, and the
protocol field is really just an enumeration.

If there are no other technical issues aside from that, I think it
would make sense to use the Greybus CPort protocol enumerations
instead of introducing a new one that is less generic.

That's the only significant critique I have.

Otherwise, great work and thank you for your contribution!

[1] https://github.com/projectara/manifesto/pull/2
