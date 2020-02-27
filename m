Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C7CC3F2C0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6DD24677
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fSnXxRqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbgB0WG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 17:06:59 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39105 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730189AbgB0WG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:06:59 -0500
Received: by mail-ua1-f67.google.com with SMTP id c21so252316uam.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 14:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QZJFYpDMu28rzg4sSH4lYDpplDJcLA4t74m3kwP0OVc=;
        b=fSnXxRqDh7UfXXPdr2gz+QQFlZLuXvGjpruN8a7b0yy4UgTtmHn06hZFqIHGRvYNQG
         aTs1vV/VJNDqO64I6+DPkfrEJS/Gi5zmkHsLsciwXoZPq/OS9g9jIYQjEsY/VBPCji92
         DVYwcrXRTNUyds2NfyFsBneM5dOfsQkdMShgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QZJFYpDMu28rzg4sSH4lYDpplDJcLA4t74m3kwP0OVc=;
        b=EYZEPYcivMX+aY3z/8EU0O4KdX+W/EDgbCsrmf3N+xWs5AWuhxU//hWBzw/y6aHFHQ
         8mlP6xl44yLoFhhf/fsErpQFkx+JPpgfir4zTUth3tBRNoI90eHff6yahwBkpXbEOek+
         Y1EhJFSisxzIj5jbICNdOTy6ZoK+c1Tq2lCWgHrD+NP8nUYgxcy/Zqg8tNxakUHQ+7jM
         gFaoAf1CL6tCMoSVsxV7Lt2Z+jO8hFiFOJOxYQTozwHVmnutPctofMWIVsR8LfofSNFX
         1YGBQHhdwfKIRdouKKbxsh0DKT2+YHFWP6vShXxQfSBcvyf19wFPYtMhuSLqBPviU4Hx
         fRGQ==
X-Gm-Message-State: ANhLgQ3JebExtD+/k5tyRgk/fgE7qTAqwe8xX4vYeYgDMAeXsPm2OlFR
        6PBXY4/v5oASWgCXqpxkMINxE8WM4Go=
X-Google-Smtp-Source: ADFU+vvqA0ZF44/+UMsFPsBLPjEUB/AumP5BcAfFnheqWzgxGh0TsNHY/px76b3DQhOcHwtJu1lVow==
X-Received: by 2002:a9f:3e9e:: with SMTP id x30mr530527uai.122.1582841218076;
        Thu, 27 Feb 2020 14:06:58 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id h139sm2419155vke.34.2020.02.27.14.06.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 14:06:56 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id t20so250777uao.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 14:06:55 -0800 (PST)
X-Received: by 2002:ab0:45b6:: with SMTP id u51mr513744uau.120.1582841215133;
 Thu, 27 Feb 2020 14:06:55 -0800 (PST)
MIME-Version: 1.0
References: <20200226210414.28133-1-linux@roeck-us.net> <20200226210414.28133-3-linux@roeck-us.net>
In-Reply-To: <20200226210414.28133-3-linux@roeck-us.net>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 27 Feb 2020 14:06:44 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UutvJE+k4W0sQDs6q+oOfbz5Tz670+L-8fFHfdB=KytQ@mail.gmail.com>
Message-ID: <CAD=FV=UutvJE+k4W0sQDs6q+oOfbz5Tz670+L-8fFHfdB=KytQ@mail.gmail.com>
Subject: Re: [RFT PATCH 2/4] usb: dwc2: Do not update data length if it is 0
 on inbound transfers
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QW50dGkgU2VwcMOkbMOk?= <a.seppala@gmail.com>,
        Boris ARZUR <boris@konbu.org>, linux-usb@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Martin Schiller <ms@dev.tdt.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 26, 2020 at 1:04 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> The DWC2 documentation states that transfers with zero data length should
> set the number of packets to 1 and the transfer length to 0. This is not
> currently the case for inbound transfers: the transfer length is set to
> the maximum packet length. This can have adverse effects if the chip
> actually does transfer data as it is programmed to do. Follow chip
> documentation and keep the transfer length set to 0 in that situation.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/usb/dwc2/hcd.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

I don't have any other test setup that you don't have, so just giving
my review tag and not tested tag.

I will note that it feels like this should have a "Fixes" tag or a
direct Cc to stable to make it obvious that it should make its way
back to stable trees.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
