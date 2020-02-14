Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E389BC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE982222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WMQs/0hL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389042AbgBNVcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 16:32:23 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35879 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388065AbgBNVcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 16:32:23 -0500
Received: by mail-io1-f67.google.com with SMTP id d15so12128288iog.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 13:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BZKc7Iw5Ao6DeSW088cynAow9LgysvsQp4C3aBIY+yc=;
        b=WMQs/0hLj9/SxQ3vyxLv+3rncv4W8okLOKv6C0paboIrojTdECQfyJCrhOCRT0fx4G
         oM3HAXuULlD2gvgTYP2NxZj61hNw6RN40PPsvbd226CVbYcK1BLyT/VvhFm1NUfXzdYg
         VY8r0gqWL+Gg+F2FX6wfqU9i/m0gWGApmJFk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BZKc7Iw5Ao6DeSW088cynAow9LgysvsQp4C3aBIY+yc=;
        b=mqqodJIXZYP+tIYN++LTtlYAf9JnjEYCQncZepN58m6r/WTBuxZCrkBPxlOJboEgJi
         3ngPK6gm79jMpmvm5cUlJIMOzvt89p2Xh9VktbqKaAP2WKTQiSNjs8zroy5KiRemguqF
         aE6goPV1PbcUwvgVtpF7oo++W2gUvttPjX+cmOUxP9B0q1MowyLwsFOzu2w6flMslhiX
         SMu1KPiouuQD2We3D+L3D6g/tX1LbUQfIb/BIMUsxPb7Hx2zaJpUnS6ZCs5ROR1m3+f/
         MAP7c+s2gCuNxKdbgRuwjn/N4jbSRj7OG5XEjX0foVFowiW7SIUdqSV/AMdKjr06L54f
         ssDw==
X-Gm-Message-State: APjAAAUwbs679wZkXpv8UkhfYaRXphA5u0KiDHGzNvKBo6qXI2HR/wEd
        t6yXO9tlFEPL5Y1jsiBTYdifAEMLzWxZVbryEkQKoeIy
X-Google-Smtp-Source: APXvYqx7rGGJlQRvlXAmdf/4YbIGlcmVKixshxKK0TyrASYGQsdOT/bDRr50fWVkgOszmmXZ5IeK2mFn5MiS01GixLo=
X-Received: by 2002:a5d:8796:: with SMTP id f22mr3932931ion.163.1581715942261;
 Fri, 14 Feb 2020 13:32:22 -0800 (PST)
MIME-Version: 1.0
References: <20200214062637.216209-1-evanbenn@chromium.org>
 <20200214172512.2.I7c8247c29891a538f258cb47828d58acf22c95a2@changeid> <804d3cc5-688d-7025-cb87-10b9616f4d9b@roeck-us.net>
In-Reply-To: <804d3cc5-688d-7025-cb87-10b9616f4d9b@roeck-us.net>
From:   Julius Werner <jwerner@chromium.org>
Date:   Fri, 14 Feb 2020 13:32:09 -0800
Message-ID: <CAODwPW-d_PpV4Jhg2CC+7Tfyrrh=gh6hRfcEKFb4gj+LB6vrWw@mail.gmail.com>
Subject: Re: [PATCH 2/2] watchdog: Add new arm_smc_wdt watchdog driver
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Evan Benn <evanbenn@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Julius Werner <jwerner@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, linux-watchdog@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Anson Huang <Anson.Huang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > with a Secure Monitor firmware to forward watchdog operations to
> > firmware via a Secure Monitor Call. This may be useful for platforms
> > using TrustZone that want the Secure Monitor firmware to have the final
> > control over the watchdog.
> >
>
> As written, one would assume this to work on all systems implementing
> ARM secure firmware, which is not the case. Please select a different
> name, and provide information about the systems where this is actually
> supported.
>
> If it happens to be standardized, we will need a reference to the standard
> supported. This needs to distinguish from IMX_SC_WDT, which also supports
> a secure monitor based watchdog (but doesn't claim to be generic).

Back when I wrote this I was hoping it could be something that other
platforms can pick up if they want to, but that hasn't happened yet
and the code on the Trusted Firmware side is still MediaTek-specific.
Unfortunately Arm doesn't make it easy to write generic SMC interfaces
and my attempts to change that haven't been very fruitful for now. So
yes, probably makes sense to treat this as MediaTek-specific for now,
we can still consider expanding it later if there's interest from
other platforms. (I would like to avoid every vendor writing their own
driver and SMC interface for this, although looking at that IMX driver
it seems that we're already there.)
