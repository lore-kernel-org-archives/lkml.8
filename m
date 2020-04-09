Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC8CC2BB54
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342A720A8B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pf7bzjaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgDIJIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 05:08:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39344 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgDIJIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 05:08:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id k15so3842036pfh.6;
        Thu, 09 Apr 2020 02:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jZZ8GSU7SStyQTRXHioxf7XISlIWbs7FKaemI5HyWec=;
        b=Pf7bzjaQ5hDx/t/Gdhx+prJ3hZzWY7z8BOrXNmQwwinVDgyebp53shIOJjd/WGNd1Z
         OOQ/kZcMWJEDsJRCZWhzvOTSEob4M9qR40v7j34+JTtHWGvVmvhVa3CYjK5GFsSGPWXu
         q02HGutMwJzFkVcPvmT+Tk34V8p/mgSxxTMHAlEc8khkxK0x2nCPspiwpkRuBjKh2s2v
         gF7uFFYHyGT7Z8L9hu9RQ865SLcN+yyxp82YIBVcOeFKg3MBRvXMAioXWveHFpeKRkWa
         E2nE7qZ6hp717cRLYztk2N6R/qyIq0mnXi2EIa0VrVZgC7xiA58EAypfm4qY7gFd4aTb
         f1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jZZ8GSU7SStyQTRXHioxf7XISlIWbs7FKaemI5HyWec=;
        b=Q9AIW/R9D58Cj4QjoMH/KFwMyxinkB859l5Nlk8XDiIYKnrHgECOmISlThF6aeWrnJ
         nLZvfBqAJwzKYYuU3+QDuQroKcBg125PWjf3uh4k5nz6z+PxoBRm8iOgsn6lx+H7sX0B
         DfaRz0yMqvZof5h8/YaifoKFHab7fCw4mkp8YWP0jspIN/CYRabjTV0JhUrMfaWG0HH9
         IjC6lrUthjIpVuRR+suW3LQgkygjzjCvk4+oXxfdXTWSLK072VH6Mi7LWlhpyUYqI1Xl
         L8BSLo3etSrGgmApP1u+0wUvzCgVI+yUwy6i2HANy/k86zPV9+1tb5h9GJouWSs3QyeF
         0dQw==
X-Gm-Message-State: AGi0PuYYqTH/mbcuUHRbJoHZxYg3gBdPPVuj9rxMv4GMAMXtBgPPqhxg
        GLT/kykSCvuj0rf+xD6tY8ph/QAj3u65FaPLT/Q=
X-Google-Smtp-Source: APiQypKsgNzxuKsYZzk5G8ZRDgratsR3V/rE5QkFegtqm1hvP5di0TFrjuZRpWKL4SNREGUub3ToDaBPO3YM4QEqcko=
X-Received: by 2002:aa7:958f:: with SMTP id z15mr11815993pfj.130.1586423296973;
 Thu, 09 Apr 2020 02:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200408181406.40389-1-alcooperx@gmail.com> <20200408181406.40389-5-alcooperx@gmail.com>
In-Reply-To: <20200408181406.40389-5-alcooperx@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 Apr 2020 12:08:05 +0300
Message-ID: <CAHp75Vd_nbgwdE5Fbm3oxd_+51BJZ=67sVyjKiN2zLS+J4X-Fw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] usb: host: Add ability to build new Broadcom STB
 USB drivers
To:     Al Cooper <alcooperx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        devicetree <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 12:52 AM Al Cooper <alcooperx@gmail.com> wrote:
>
> Add the build system changes needed to get the Broadcom STB XHCI,
> EHCI and OHCI functionality working. The OHCI support does not
> require anything unique to Broadcom so the standard ohci-platform
> driver is being used. The link order for XHCI was changed in the
> Makefile because of the way STB XHCI, EHCI and OHCI controllers
> share a port which requires that the XHCI driver be initialized
> first. Also update MAINTAINERS.

> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3477,6 +3477,14 @@ S:       Supported
>  F:     drivers/i2c/busses/i2c-brcmstb.c
>  F:     Documentation/devicetree/bindings/i2c/brcm,brcmstb-i2c.yaml
>
> +BROADCOM BRCMSTB USB EHCI DRIVER
> +M:     Al Cooper <alcooperx@gmail.com>
> +L:     linux-usb@vger.kernel.org
> +L:     bcm-kernel-feedback-list@broadcom.com
> +S:     Maintained
> +F:     drivers/usb/host/ehci-brcm.*
> +F:     Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml

This has ordering issues.
Run parse-maintainer.pl to fix. (Note, it creates by default a new
file, you might need to run diff manually to see the difference).

-- 
With Best Regards,
Andy Shevchenko
