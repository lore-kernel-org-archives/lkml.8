Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E081C47255
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 19:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7860A21974
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 19:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PJyrvR/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgEHTl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 15:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726797AbgEHTl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 15:41:28 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F30C05BD0A
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 12:41:26 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id h26so2344631lfg.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 12:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o4LTBtkW42ncc3xQ7z7L3UptQlNLannjQiNWN85xz6s=;
        b=PJyrvR/+6sIkZyAcKbhumskZG8NDstC0NjMWeWUa2gXrnapzGgrIUDv//WNM52ITv6
         3Kgui9JoHsNvLQmzlOxVY1ZmU8LYVhjSAybWTonwvajI5Jg7mU7xhWVST6veGrCtgetF
         5BAO33H/r1llfRPVsarse3bYf+Rg1HyVgxe4+u6FUlHGFy8BJh/U3lY8olz8RyIEeNGN
         YZtn/yWuBKm3I/we0P8dnTRtpDU09oZBfP8rijonMrG4WEUiymNlOtNmdoVhtw+xUjQj
         sR28pIYVmKqUYIQSMbVOXahn1Xez2Sgerb/+VPH7g+Tij5QkxyHn0/XbomfIiTZUv+8W
         XrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o4LTBtkW42ncc3xQ7z7L3UptQlNLannjQiNWN85xz6s=;
        b=kCbtEdIg7Q5r1NKUMz1N4k9VyQjRscJQWMnGEUEYQ0nIh+FIInagYu7xItOGX4pTtv
         s8r5xXjbqC/IcARzN/jSyYWmTujfnkEi73serOKldOfYxRLbNcniA07VXtBzRmvEGcA2
         77aNEW1sQFDRpUJisMnEXQgOsGCBuVygpyQWILGRw4fqbM04H1X3Aq4VUaNEjZrNFmTU
         XwAtKzMF32d/aAJbt+uOUkZ+1lmln9D2pMSQxXipi5Kc1T4+exzC2oo9UjLMfJIAO4cZ
         9SbhrlgtXJEjazbcrVuUQ7f9pzA+wsU0lu4M5JRFw8C4Jh5qUd17Fq/kXkvqmZnCTDEe
         OlrA==
X-Gm-Message-State: AOAM532Jgl9CL89OAfomJoWsikzIj8S0NxWTCo1C7LTilBYJUSEC5hwY
        jMu7Vp7Up/D/81VVh76oNj/5jgS4fUk06Vg89tLOfg==
X-Google-Smtp-Source: ABdhPJzAjAstldzlrJ0KZee1gVua53zcjm+vjwc4UDwqEaPy842LDceP7toVn6P/HY7LTJK+cY0zCyMDWr1qXY8xY0g=
X-Received: by 2002:ac2:414c:: with SMTP id c12mr2921938lfi.47.1588966884749;
 Fri, 08 May 2020 12:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200503172206.13782-1-xc-racer2@live.ca> <BN6PR04MB0660B420EFA83668BBF4F315A3A90@BN6PR04MB0660.namprd04.prod.outlook.com>
 <CACRpkdb3kG=7SQg8RGh1F=8=_mivV6p_zxpodFT=M-f3PmiyYQ@mail.gmail.com>
 <BN6PR04MB0660BA0E181869F866594E98A3A50@BN6PR04MB0660.namprd04.prod.outlook.com>
 <20200507042318.GD89269@dtor-ws> <BN6PR04MB0660FB7E230C514608743560A3A20@BN6PR04MB0660.namprd04.prod.outlook.com>
In-Reply-To: <BN6PR04MB0660FB7E230C514608743560A3A20@BN6PR04MB0660.namprd04.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 May 2020 21:41:13 +0200
Message-ID: <CACRpkdaZtwVva0sqYgkyPzZNTTJRF3GjFUjhG0wDiOFqJHfniw@mail.gmail.com>
Subject: Re: [PATCH 2/5] input: misc: bma150: Conditionally disable bma023 support
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Input <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 5:57 PM Jonathan Bakker <xc-racer2@live.ca> wrote:

> It looks to me like the preferred method would be to also add IIO support for
> smb380/bma150, add the exclusive Kconfig entries, and leave the input
> driver in place.  Does this work for everyone?

That's my preferred solution for sure, so go for it if I have a say.

Yours,
Linus Walleij
