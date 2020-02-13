Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D01C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E0D206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAaIg/8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgBMSLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:11:15 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46177 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbgBMSLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:11:15 -0500
Received: by mail-lj1-f193.google.com with SMTP id x14so7654635ljd.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 10:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EuxVXqo0aLZOHDOucp4vbQndf0tOU7++wA3AtEmGBpw=;
        b=fAaIg/8ux70EQiQpgn3mUB6nFui/A2paoKIJeaWZbLEdTL5kpOBkJBUFHWxQFKCXAR
         hdga3DG2R/MFIRy7zFfSp4ZQKb3pvJjXw9Qcx+wRmcmwNZkXJIt/MConhjPzsr4Z4MNy
         dWu0arsyksu0AK7JqiqRgO11JmtdupXzDXpHAqpQABRIBaMXk5VdYgl43dB59tVRtRXj
         4uKHCwzDx4ufdChhKAmEqsFiZULQvn+btVHIwKwNlfcU6z642R4+mA0uyvG3LGNjigyi
         MIXAJ86LhHhWEsROWucZcslFhq4C2TaNszH9lD8VwEyrKQtR1tGumGwpZNHRzWNX4grS
         My/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EuxVXqo0aLZOHDOucp4vbQndf0tOU7++wA3AtEmGBpw=;
        b=GfH+jziZfTAEzuTcWj5QGq5PyjlHgyP5BDOqFAHKKVUk+RKvc6Vbx8By8e2YNhMDIR
         ZR38iS6UDollzToaEJo1M6q6ktmdzxlFpjMrwS0ChFzzwoQIstbZ6dNI9Q+rTgaC9agt
         nM+jNGg/8ZceWeBrsBFyHvgLRSD2smPMSCPwm5ZwHSW5oDmiuYNLXsyDrNcm2/kQdGnx
         dpZqHijRusXL//jZF/il9YPj++yA1E/BzrjHllB9FoeIOD+rntPujsRJxNfFBYKD5NrD
         yEFJEZPVCfqEj2KeRU3oPFZkNjGpQ8EIhmn+vcH7Lay80J5QD9XyaZmeK2ysIo8KkQVd
         eeZA==
X-Gm-Message-State: APjAAAWuZbgzd84GSMzUZZ513Ycm8SNJcjJQjn4cOi7TJs+hFSsfZxjN
        /gb/qUJ+SSob098f6b6fPWlqC/kQiiLr+A==
X-Google-Smtp-Source: APXvYqzzT+FLUGY7cXzPsygITqUHZQgOYAok8PALBHATY6k8I9bEwK7EFmVCMYTPxGMkzKG+gNRuhA==
X-Received: by 2002:a2e:9157:: with SMTP id q23mr11857429ljg.196.1581617472996;
        Thu, 13 Feb 2020 10:11:12 -0800 (PST)
Received: from kedthinkpad ([5.20.204.163])
        by smtp.gmail.com with ESMTPSA id d24sm1655804lfl.58.2020.02.13.10.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 10:11:12 -0800 (PST)
Date:   Thu, 13 Feb 2020 20:11:10 +0200
From:   Andrey Lebedev <andrey.lebedev@gmail.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     wens@csie.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Support LVDS output on Allwinner A20
Message-ID: <20200213181110.GA25367@kedthinkpad>
References: <20200210195633.GA21832@kedthinkpad>
 <20200211072004.46tbqixn5ftilxae@gilmour.lan>
 <20200211204828.GA4361@kedthinkpad>
 <20200212125345.j6e3txfjqekuxh2s@gilmour.lan>
 <20200212224653.GA19494@kedthinkpad>
 <20200213092433.sc2rs7el63mwvf3y@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213092433.sc2rs7el63mwvf3y@gilmour.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 10:24:33AM +0100, Maxime Ripard wrote:
> > > do you have a board when you have been able to test it?
> >
> > Yes, I have the hardware (Cubieboard 2) at hand, but I cannot change the
> > any physical connections on it. FWIW, it is https://openvario.org, the
> > device we are (painfully) trying to upgrade from old kernel-3.4 with
> > proprietary mali drivers to contemporary software.
> 
> What painpoints do you have?

So, even though proprietary mali drivers worked well for us, they seem
to hold us back to old kernel-3.4, and it started to get harder to avoid
various compatibility issues with newer software. Since there seemed to
be a good progress with OSS lima driver lately, we decided to try to
replace mali with lima. And that naturally pulled to switch to DRM/KMS.

The first painpoint is this LVDS support problem: after a week of trial
and error, I discovered that support was simply not there. But it seemed
that not that much was actually missing and after couple of evenings
deep into debugging, here we are.

Another one is the screen rotation: the device is installed into the
glider' instrument panel, and some pilots prefer it in portrait
orientation.  Under old mali setup, all that (seemingly) was required
was setting "fbcon=rotate:n" boot arg, and both linux console and
graphical app (https://xcsoar.org/) rotated "automagically". With new
DRM/KMS setup, only console is rotated, all graphical apps seem to see
the screen in its "natural" landscape orientation. Do you know if there
is any way to leverage DMS/KMS infrastructure to make screen appear
rotated for userspace apps (writing to /sys/class/graphics/fb0/rotate
didn't work)?  There's of course a plan B to teach the app to rotate its
output, but that leads to problem number 3.

And the 3rd outstanding problem is that app doesn't really work under
lima module and lima mesa driver. It starts, but renders a black window.
I haven't dug deeply into this yet, but it is possible that some opengl
API isn't supported in OSS drivers yet (even though app only renders 2d
graphics).

Hopefully that wasn't too much complaining for you :) If you have any
insight on possible causes or attack vectors on any of these, that would
help a lot. Also, please feel free to correct any of false assumptions I
make above, I'm happy to learn more about this.


-- 
Andrey Lebedev aka -.- . -.. -.. . .-.
Software engineer
Homepage: http://lebedev.lt/
