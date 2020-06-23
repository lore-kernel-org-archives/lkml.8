Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58363C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3703C207F9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="gdKqYos2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733220AbgFWSwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733075AbgFWSwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 14:52:30 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B8FC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 11:52:29 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 72so4168766otc.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 11:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o0ZyZBP3R+xTsYbXudhPpeqGQTx9+AtNXicoVw+deco=;
        b=gdKqYos2nRamqmG/sd35v1EqNpbtG3PgDZ2E/tKpeKaJVjd4jrL/oqg/dsC2xdGuAe
         Qkmdffu9YfXVdVYSddOShypUzRWjTKVlWLxPdP9yqsTz7molW/pzEeuAUYju9xxAAcgq
         K9PUEARzddqf1oxlK1zqzhgkwo5t3CaCemnRymg8KwkEqU7p7N3RD7ihuegY7ql0WoV3
         wjKEEeyegTPJ83s8obqhz7P1ZUyNxmBRgaipBT18usGwYxJmZsAdpWUD/5X6ZIeQl2Hj
         08RzZPNIT6yNJJQoLxFURJfHOBxXMLf5g6IcnutbZvEmXa7QXH5+blWDmvXQB3xaOTrw
         xWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o0ZyZBP3R+xTsYbXudhPpeqGQTx9+AtNXicoVw+deco=;
        b=IWttZ98tVskmr1p5jYRh+o82QwuL5S6J2YIafRTI4UiMkPC9gPS3v1rt7vQWrqsJO+
         jvvS52eXvTP+X30qSTEmgy/PS1jSo+ESnh6oQfANIaevRJYbotohAx0IBWDUi9v92ZH2
         ZZwJDn30bEN8myEuI0G81etrq38cMTABl+Kz5sBBHuRcMZJrrByEhHySD5tuOJgh+Qwx
         qf7Jx77GvC+T00JuoI7gEUX+opfbKRq0MpK5MXrEz8xz6/Ifb5m5V306UGrnMeq/ucSj
         dwY0b+oe/lWbPiTmBVVbIInTrDoGFkS8R55mkpfG0Lnn66ffxmh1ON6dBPWvnU7RE4wl
         dmyg==
X-Gm-Message-State: AOAM531f3PCJhdPsereAWDizgTc6LpzSt67Fe8DTv8t4htLFcFG1Ik+q
        mOWEMdzwWsHnRmH1L7Bb1HDQrr1C6s1y830WscxjHQ==
X-Google-Smtp-Source: ABdhPJzp+aM0LlFXFQjN4tMW0nFimdEGTUlw1nniLZRr8VJRCoJV2HqfPjDySP2P6IFuViQjezhymY70H2D/O0Ud/6Y=
X-Received: by 2002:a05:6830:210d:: with SMTP id i13mr18314198otc.252.1592938348318;
 Tue, 23 Jun 2020 11:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <1592937087-8885-1-git-send-email-tharvey@gateworks.com> <CAOMZO5CbLvf_iV5K1zXZdYqgpBqrOZmTGR=NYyL+j73ojTGOnw@mail.gmail.com>
In-Reply-To: <CAOMZO5CbLvf_iV5K1zXZdYqgpBqrOZmTGR=NYyL+j73ojTGOnw@mail.gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Tue, 23 Jun 2020 11:52:16 -0700
Message-ID: <CAJ+vNU19ebj3xpOKxeHMzdMQjVdZoJCTFJ5DSYat7U4tpZTWvQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] ARM: dts: imx6qdl-gw551x: fix audio SSI
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 11:41 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Tim,
>
> On Tue, Jun 23, 2020 at 3:31 PM Tim Harvey <tharvey@gateworks.com> wrote:
> >
> > The audio codec on the GW551x routes to ssi1
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>
> Shouldn't this have a Fixes tag, so that it could be backported to
> older stable kernels?

Fabio,

Yes, it likely should as it fixes audio capture from 3117e851cef1b4e1.
I didn't think it would apply cleanly to stable but it looks like it
does.

I cc'd stable@vger.kernel.org. Should I submit a new revision with the
following?

Cc: stable@vger.kernel.org
Fixes: 3117e851cef1b4e1 ("ARM: dts: imx: Add TDA19971 HDMI Receiver to GW551x")

Thanks,

Tim
