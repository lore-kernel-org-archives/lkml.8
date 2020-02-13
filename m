Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2273DC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 20:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C3E217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 20:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7Nd/9vP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgBMUI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 15:08:29 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41199 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbgBMUI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 15:08:28 -0500
Received: by mail-lj1-f196.google.com with SMTP id h23so8066101ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 12:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BGyZT7dbwMQ7jRrV7OPOX8exFdqWmXNOVwOPlJZyRbk=;
        b=Q7Nd/9vPTfJrYfCbCnUoPbPOpTzh3mz2xPJW1hQXDfbva2G/ahXsRqzD1wUuPZ0P3d
         +VywfqW7xB0c1jzTKa7NJz6yLxoDyvNlvg34cVn9HgdBE0NIoNuEjhR1q5M5tg+WKX1s
         VR/cE6zJ0oW3d9yoa95wrCDl733BktZ0XiN5OqGki05JxaBJP9SLsgtvO6NIKNtbC2QN
         laeEw6HaaasnQGqEFM8QClPBWowIpVDKLEz5clAkkVrjEM5nZOWjCb0qr8FpJMzm7oWl
         MBgsia3Si3eM8ZVXJqbn+jwHsq5CG7Hr1ZPF2HhnxEJvtGIJfwYCRkECqsnu3hYJRJai
         b5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BGyZT7dbwMQ7jRrV7OPOX8exFdqWmXNOVwOPlJZyRbk=;
        b=lT0VZ4AMKtXFMR1OJWFSXwrO2rocwF8F1JDK+bBaCKPpa7sbKNl63zBWxd5de3BXFs
         vQW2p9+Bj35ow9PSIJDyyfAxa0cnWJyQukG9N0dDuKEqSpj40AOAiwQdAQ9yVVXmyG57
         VvLKiekQi/Zr/nu37getqkVOFCRnvS6hN8PTSD8BpYzxJVrvjF9TL9KIRMzivpw5n7Ih
         uKVAiZzU8kt4FGKO3kXMvgVsh8+52BaznguBD1kNrzCQcWHEu8tOKpTGIy9TKAfMQU9q
         dbfkheDxMxC77Eym4hMumwZ2d1BHCktb249ITihFH/cAsGT0m3K1jSGQASzoEgirKyTr
         nakQ==
X-Gm-Message-State: APjAAAWRYRjqUFKxWSbhaFMKsBTXGaYfGF1AAOMpQF7rGUumXYywRzrT
        WIBYhIU8kaLaY+XRRV2ROkw=
X-Google-Smtp-Source: APXvYqztD+iqwv6Xp+koxjrHW1aZ2Qay9QARoJlk+46QWn4zlAo+rJAYb4gEbYwOOYOAAItaIZGLEw==
X-Received: by 2002:a2e:98c6:: with SMTP id s6mr12200884ljj.14.1581624505681;
        Thu, 13 Feb 2020 12:08:25 -0800 (PST)
Received: from kedthinkpad ([5.20.204.163])
        by smtp.gmail.com with ESMTPSA id d20sm2132164ljg.95.2020.02.13.12.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 12:08:24 -0800 (PST)
Date:   Thu, 13 Feb 2020 22:08:23 +0200
From:   Andrey Lebedev <andrey.lebedev@gmail.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     wens@csie.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Andrey Lebedev <andrey@lebedev.lt>
Subject: Re: [PATCH v2 2/2] ARM: sun7i: dts: Add LVDS panel support on A20
Message-ID: <20200213200823.GA28336@kedthinkpad>
References: <20200210195633.GA21832@kedthinkpad>
 <20200212222355.17141-2-andrey.lebedev@gmail.com>
 <20200213094304.hf3glhgmquypxpyf@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213094304.hf3glhgmquypxpyf@gilmour.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 10:43:04AM +0100, Maxime Ripard wrote:
> On Thu, Feb 13, 2020 at 12:23:57AM +0200, andrey.lebedev@gmail.com wrote:
> > From: Andrey Lebedev <andrey@lebedev.lt>
> >
> > Define pins for LVDS channels 0 and 1, configure reset line for tcon0 and
> > provide sample LVDS panel, connected to tcon0.
> >
> > Signed-off-by: Andrey Lebedev <andrey@lebedev.lt>
> 
> And this prefix should be ARM: dts: sun7i ;)

Ah, thanks, I think I've got the pattern now!

> > +			/omit-if-no-ref/
> > +			lcd_lvds0_pins: lcd_lvds0_pins {
> 
> underscores in the node names will create a dtc warning at
> compilation, you should use lcd-lvds0-pins instead.

You're right, I wasn't following the naming convention here. dtc doesn't
produce any warning on this though. Fixed that anyway.

> This will create a spurious warning message for TCON1, since we
> adjusted the driver to tell it supports LVDS, but there's no LVDS
> reset line, so we need to make it finer grained.

Yes, I can attribute two of the messages in my dmesg log [1] to this
("Missing LVDS properties" and "LVDS output disabled". "sun4i-tcon
1c0d000.lcd-controller" is indeed tcon1). And yes, I can see how they
can be confusing to someone.

I'd need some pointers on how to deal with that though (if we want to do
it in this scope).

[1] excerpt from kernel boot log:

[    4.890975] sun4i-drm display-engine: bound 1e00000.display-frontend (ops sun4i_frontend_driver_exit [sun4i_frontend])
[    4.902032] sun4i-drm display-engine: bound 1e20000.display-frontend (ops sun4i_frontend_driver_exit [sun4i_frontend])
[    4.913467] sun4i-drm display-engine: bound 1e60000.display-backend (ops sun4i_backend_ops [sun4i_backend])
[    4.923806] sun4i-drm display-engine: bound 1e40000.display-backend (ops sun4i_backend_ops [sun4i_backend])
[    4.934451] sun4i-drm display-engine: bound 1c0c000.lcd-controller (ops sun4i_tcon_platform_driver_exit [sun4i_tcon])
[    4.945254] sun4i-tcon 1c0d000.lcd-controller: Missing LVDS properties, Please upgrade your DT
[    4.953935] sun4i-tcon 1c0d000.lcd-controller: LVDS output disabled
[    4.960857] sun4i-drm display-engine: No panel or bridge found... RGB output disabled
[    4.968845] sun4i-drm display-engine: bound 1c0d000.lcd-controller (ops sun4i_tcon_platform_driver_exit [sun4i_tcon])
[    5.080874] sun4i-drm display-engine: bound 1c16000.hdmi (ops sun4i_hdmi_driver_exit [sun4i_drm_hdmi])
[    5.110087] [drm] Initialized sun4i-drm 1.0.0 20150629 for display-engine on minor 0
[    5.763064] sun4i-drm display-engine: fb0: sun4i-drmdrmfb frame buffer device


-- 
Andrey Lebedev aka -.- . -.. -.. . .-.
Software engineer
Homepage: http://lebedev.lt/
