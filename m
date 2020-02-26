Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE8FC4BA26
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5432C24688
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dWcCF8s4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgBZTbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 14:31:03 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:38648 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbgBZTbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 14:31:03 -0500
Received: by mail-io1-f65.google.com with SMTP id s24so425765iog.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 11:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5MFxJeomCczgXDzeNV9Xn+RHt64mPvJ12qZr3RbPrbU=;
        b=dWcCF8s4J9A+iP2iXoWcm3srPwjEatU3HdSYDIVsbNOiHHd7MtnwyuiE9mCNcHaGU0
         qwCoH2p/6/qrCzG/i3ueu4EZqypRCXV4NQTLYaswGjHLOJWyjjeUM9SXiYcQxeTrcELD
         ACUWcICt+Ximqv6VZnywYGgK6FeUCdHP4Ttig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5MFxJeomCczgXDzeNV9Xn+RHt64mPvJ12qZr3RbPrbU=;
        b=gsYKltaP1+AiM70l4rgzWm+My/4ZmVnMT44ORzr7WhcL7q7an2d0Rrc0QY1low9s8a
         2p5hcvhkdttUWaURhdJ4DmHJZU8R4UPZV3t548bbcx78V3rEpvvbYiO0B4Nhvug4AU/7
         7vouG9p+bNN26Jg+t8jm14FLvJB857/HdW60o2/V75+vCtfSZplt+L1WuNXqx1o4tYjw
         xg1Vth5TpmV9CYdK9LXvOfd2M2BfsuN1sE/ZKBT/fyn2HGX9FMj4VNx8CsdwnmvqnF9k
         Aec5J3ep/h3s5UKfnBCR8JPxBpy0fo9+bJ8CIvtW5cvyLsLhTBhqey3pjklpxWZUeaJG
         BApg==
X-Gm-Message-State: APjAAAVdJSd0e9P6qw0/Q42ijz3aGpnOB2t66rsB4x+9oeZN5lQOwJyU
        NbZdXQ57maql8B2TQ/JaQV8unLafgFFLJzS6QVx32w==
X-Google-Smtp-Source: APXvYqwm7wEEXPS3MuEPhTwwGRUEbcd/4WOJm2XgfK0kRKisj4w+h5pA1wDFpztH3aEcTh+AhwR4v0v1+qCPqLGRK8w=
X-Received: by 2002:a5d:8955:: with SMTP id b21mr146927iot.41.1582745462529;
 Wed, 26 Feb 2020 11:31:02 -0800 (PST)
MIME-Version: 1.0
References: <20200221053802.70716-1-evanbenn@chromium.org> <20200221163717.v2.1.I02ebc5b8743b1a71e0e15f68ea77e506d4e6f840@changeid>
 <CAL_JsqL94vtBEmV2gNWx-D==sLiRXjxBBFZS8fw1cR6=KjS7XQ@mail.gmail.com>
 <CAKz_xw2ETZ5eyNfdWU5cF6Qy23E1NqhpFHoLT_CzUDHWTCbw4Q@mail.gmail.com> <CAL_JsqLYpSK6HRT4s=hq153xvU_aiPCq3Hk_oZC-7X7e7daA7Q@mail.gmail.com>
In-Reply-To: <CAL_JsqLYpSK6HRT4s=hq153xvU_aiPCq3Hk_oZC-7X7e7daA7Q@mail.gmail.com>
From:   Julius Werner <jwerner@chromium.org>
Date:   Wed, 26 Feb 2020 11:30:51 -0800
Message-ID: <CAODwPW_FR0gHO_=yfCPwETXvKG9CvgvPddX-EOT=OXDPEkp_Kg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: watchdog: Add mt8173,smc-wdt watchdog
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Evan Benn <evanbenn@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Julius Werner <jwerner@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Not quite. /firmware is generic container. I'd expect another layer in
> the middle for the overall set of Mediatek firmware behind smc calls.
> Look at 'xlnx,zynqmp-firmware' for an example.

There are no other MediaTek firmware interfaces described in the
device tree on those platforms. Is it okay if we just call it
/firmware/watchdog in that case?
