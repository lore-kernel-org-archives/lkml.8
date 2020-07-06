Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B2EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41B6B205CB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDOAtQyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgGFXRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 19:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGFXRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 19:17:49 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D6EC061755;
        Mon,  6 Jul 2020 16:17:49 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h19so47684248ljg.13;
        Mon, 06 Jul 2020 16:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nEcvT0S80lShmAiUij3CBN+xqWJ51ORTb8sU2Ut1qgk=;
        b=EDOAtQyReOU3AMpOSQgrhZLWhjVkCvI1UTEHEdKEHtr8NSJbLnu1Sa7qdcFgKt007H
         AKgRtRRxae4uVduq8c/w4yDh3t6aPAm8i2qKeA/t6CGIFf+9qpJk1m4dTfdbz3ssnH+r
         2PhNR5XvrwtWGXGzOuRhNXkiisBAySMpIZRzuCHjXgOn7oF4lOfCp1dRJhJc962mW36w
         99Ww+gTDLQdzJSUkJ9Uj21pMp1Z6tr9zxObI8m/D2+7mGFmcENekh8kzHWg3w1yIvFUe
         99dLd4GarZLXBk5ULsoynPUlEzK7MAwqGLPpndm0LtnXuAVY48nQ7MsMwQ03dSUCZxNR
         vRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nEcvT0S80lShmAiUij3CBN+xqWJ51ORTb8sU2Ut1qgk=;
        b=W75of52UfGwHva9v7UR8C8wOMQ5pKZf+MQbS1wREC3LhNdcEu8tMINKYY7hpQ1I2kb
         iUfVSMBOJkW0CjpJrOlCKH6UpP/9YwSiBuYEaN5gz4/OOVZOy+IiFpRFDtyVieIe8XHl
         iI2IX0Yjmbw1Bdi3NZQY8x5rNhT+zIxbhKXTN6Ff0iisfMiX4u0NoxOQvufXq45MZ0WQ
         PptgUrrw/xi6o3w82MMzxUjyvW3msNYwNJLYb0arT1JTuQe/FagrL3YVH9XDtcCqVEhT
         5HxrJIgaeFS4LpXALs0cn6L/IYeeDzsml6qG8LrL+kzURomK5023THxfFZYvgDRgDhiY
         WKww==
X-Gm-Message-State: AOAM5336t7fbNSbhGjuhDiljvUlPXX73Sn20mnJQfJpFdvGk0SKUjSrY
        RUJu6j8mivOHHx2ZfjxJqcHSU3ET9EkjXKxn5jo=
X-Google-Smtp-Source: ABdhPJwlDCf9v0R98ITc7rx/wPBYFtbBwBAFbGagAwGeMmvKrxL+vLuj9lStCiDWbQSZjXgWx89Ph+NyMX800D7X8AQ=
X-Received: by 2002:a2e:880e:: with SMTP id x14mr18185773ljh.218.1594077467685;
 Mon, 06 Jul 2020 16:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAFXsbZo3xXXgCSd4AgDs8U46hBR0+HkQgzsvwJ=B6rUiondydA@mail.gmail.com>
In-Reply-To: <CAFXsbZo3xXXgCSd4AgDs8U46hBR0+HkQgzsvwJ=B6rUiondydA@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 6 Jul 2020 20:17:36 -0300
Message-ID: <CAOMZO5C1TeUzTYtdBWvtcuc=U52SvC4RFmU8_RRDf6RprABD6w@mail.gmail.com>
Subject: Re: [PATCH] arm: DT: vf610-zii-scu4-aib.dts: Configure fibre ports to 1000BaseX
To:     Chris Healy <cphealy@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

Subject style is usually:

ARM: dts: vf610-zii-scu4-aib: Configure fibre ports to 1000BaseX

On Sun, Jul 5, 2020 at 10:02 PM Chris Healy <cphealy@gmail.com> wrote:
>
> The SFF soldered onto the board expect the ports to use 1000BaseX.  It
> makes no sense to have the ports set to SGMII, since they don't even
> support that mode.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Chris Healy <cphealy@gmail.com>

Not clear here if the original Author is Andrew and you are forwarding
his patch.

If this is the case, then Andrew's name should appear in the From line.
