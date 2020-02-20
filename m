Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D21DC11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 09:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5697224656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 09:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vT3CEAkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgBTJEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 04:04:24 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37403 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgBTJEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 04:04:24 -0500
Received: by mail-lj1-f194.google.com with SMTP id q23so3396652ljm.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 01:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EtwFUgXnzMG7xRSPK5ep4NdZQoJPGdlrXdQuPq3LaPs=;
        b=vT3CEAkG5tcsFFbFsHJmyzP1bPuTG0lGWwl1/VHgibZrTrs+dGGrWXcCh6PlmIp5qj
         aLgO0RmwGAPNzx4Nlh/SK0OT2bZRl+6Nbo728uQ5K/iZ81592QfwkpdE+20vagx4oR0+
         eI0H1ro6G/lRK06d1YjZsqpf0VfyEkiY4d2QL659oZeFIX18QVpWALrSOP71+V1A4po0
         t9o/0o+QOl5vxyAInUQI47v3hxI3qkAfCH4zZlcAh96LBiAHOgoWYyYe8xtZCw5UrOyc
         S9BoCwWMrdEyXAoa2NPb5Et5PKm+203P6MtFZ6d6P1Vxz2ExgOVAtLusSPRKYp5NqXIP
         UztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EtwFUgXnzMG7xRSPK5ep4NdZQoJPGdlrXdQuPq3LaPs=;
        b=A7yeabxY+qzm3XjKUlasw1wSd+w9codTaUNDM7e3g1x07PipVwQjhJ68PghA5wjVsg
         c+0sRalVTXwcir6dfTep9CatCVZC0qTUYIh8DRXqlye5r1J8zuwGHXz6sWwlTilM9Xzs
         YAwP21Qnb8W2e2hBoxKqleKXMYCz93nfiYyD1qF6ad4mC+PoZtI7OVvkchF6VH0CDpqs
         0/TUG6c6k2xrdYYzDExswaDtPSj/5HDaXmUwOvzgEgRhm6LAYJG1YnBH9vMMYxs5YPfk
         lLcEDH3t8dn4EGrt41YBllZE6C0Fz4qCz5T8WuFOvAFt60RfOVop/+eudp/9b8iVFj6q
         4zZw==
X-Gm-Message-State: APjAAAWn2/71bxISHMAqa3TCnZrHRbSo5Ia4NUynqm0ye1T4JkQPYiJK
        SOhryc/h3DiSrTn3uxSJhefnR5fH4Q0ABG3ibjBOZg==
X-Google-Smtp-Source: APXvYqykxTk2UJC6Vt5ZX+50V0sBVT8b6IEsTzEaCbxY0/TQGOpkj5sPXy865IF+LfcUD/8rZA4hCZqDPn22AA/jsNQ=
X-Received: by 2002:a2e:7d0c:: with SMTP id y12mr19074270ljc.39.1582189462310;
 Thu, 20 Feb 2020 01:04:22 -0800 (PST)
MIME-Version: 1.0
References: <20200219143229.18084-1-alexandre.torgue@st.com> <20200219143229.18084-3-alexandre.torgue@st.com>
In-Reply-To: <20200219143229.18084-3-alexandre.torgue@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 Feb 2020 10:04:11 +0100
Message-ID: <CACRpkdZ7uq4U6GBQQQh=pTLf4wW3KfH3Zrz9z_3ZQgoaJD9Ynw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pinctrl: stm32: Add level interrupt support to
 gpio irq chip
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 3:32 PM Alexandre Torgue
<alexandre.torgue@st.com> wrote:

> GPIO hardware block is directly linked to EXTI block but EXTI handles
> external interrupts only on edge. To be able to handle GPIO interrupt on
> level a "hack" is done in gpio irq chip: parent interrupt (exti irq chip)
> is retriggered following interrupt type and gpio line value.
>
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
> Tested-by: Marek Vasut <marex@denx.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

If Marc want to merge it with patch 1/2 go ahead!

Alternatively I can merge both patches.

Thanks to you & Marek for hashing this out, excellent work!

Yours,
Linus Walleij
