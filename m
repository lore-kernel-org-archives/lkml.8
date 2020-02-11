Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726EDC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 08:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465B62082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 08:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sGNsGTnM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgBKIQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 03:16:13 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33597 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgBKIQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 03:16:10 -0500
Received: by mail-pg1-f195.google.com with SMTP id 6so5331043pgk.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 00:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xswv++CNAvO8e5sgNruhbowWlh0GfK8dElDPHW1nR6o=;
        b=sGNsGTnMfq8QZdL3EYCI5vJMdsruYoXFihusDYkjqS7mnP0EDgXIooDwv0xzXE3ih9
         e4nl9cogZuS0tgKaiqA82x9tVymx2TsPCK+IOJrzfJAwohkoumroXFMEK3lI+icntias
         pGIJaCWeafoUiiJ32pGjCKoqqz8n6qBZXbKWim3msj+Q2xJ2WWT4/0Yslm5G4cJ/zqzZ
         rNUDpvokpDSerqph+7mUtOGSr+j93h4W8NqihZp3p0Al9gh/u5iK7eTly8jxYthrvgXk
         0U33oIiddyJ1NUr5s3wPSDQRPPV8b0xvGzLO3dzLiVVABUhMeOB4TQgzvf9Nip4y63yA
         vKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xswv++CNAvO8e5sgNruhbowWlh0GfK8dElDPHW1nR6o=;
        b=KUzQDAknCTupRt4pkgIVSvX1p5AjJIviCqog5NzBTbVlc44olmYVY53yS+iUopfl7U
         hYWCdFGFWmTc56U6HIEVUU7kx0Ri2imLbtukcBy4NGjbNckdZ03EWFqpC6uHPJPWYKl7
         Z47LqZtFF8+kcJwusO36hY0WQ/64tWdBlmQe5MbP9R2QmPsMWZRbWr1vJhb2d/n70OO+
         wkomIdfL4tltQRVrJ6qdbvCiDSmWv1ZCIP02UvhI5M0j4sKE5KwrB0WGpSOr19bwosQu
         n4qKi2rIP8TrhXa8tTBPXKeGpfRJvBgj1obdhx5Y6RT6fQoI5o+ZSnJRMoWS8pOrguD1
         Agow==
X-Gm-Message-State: APjAAAWTdrNmGUg3ICErk5F+OaJQgL43PeEqzlB2YoUxPU6RDTaVm+8l
        M5KexPd0Il2A+Os9tO+kpls=
X-Google-Smtp-Source: APXvYqw/hmZOVAzUtLXY/XY4YCFceL9DE1cr4uVOYJDUEiNBoin0KMZ3ft1hVhWvNUGvNg/aCQjzOg==
X-Received: by 2002:aa7:82ce:: with SMTP id f14mr2110275pfn.167.1581408969602;
        Tue, 11 Feb 2020 00:16:09 -0800 (PST)
Received: from f3 (ag119225.dynamic.ppp.asahi-net.or.jp. [157.107.119.225])
        by smtp.gmail.com with ESMTPSA id a19sm1913611pju.11.2020.02.11.00.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 00:16:08 -0800 (PST)
Date:   Tue, 11 Feb 2020 17:16:04 +0900
From:   Benjamin Poirier <benjamin.poirier@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Takashi Iwai <tiwai@suse.de>, Kailang Yang <kailang@realtek.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ALSA: hda/realtek - Fix Lenovo Thinkpad X1 Carbon
 7th quirk value
Message-ID: <20200211081604.GA8286@f3>
References: <20200211055651.4405-1-benjamin.poirier@gmail.com>
 <20200211055651.4405-2-benjamin.poirier@gmail.com>
 <b23abac0-401c-9472-320c-4e9d7eab26de@perex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b23abac0-401c-9472-320c-4e9d7eab26de@perex.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/02/11 08:40 +0100, Jaroslav Kysela wrote:
[...]
> > 
> > In summary, Node 0x17 DAC connection 0x3 offers the loudest max volume and
> > the most detailed mixer controls. That connection is obtained with quirk
> > ALC295_FIXUP_DISABLE_DAC3. Therefore, change the ThinkPad X1 Carbon 7th to
> > use ALC295_FIXUP_DISABLE_DAC3.
> 
> The volume split (individual volume control) will cause trouble for the UCM
> volume control at the moment which is the target for this device to get the
> digital microphone working. If there is no possibility to share DAC, it
> would be probably more nice to join the volume control in the driver.
> 
> Have you tried to use 0x03 as source for all four speakers?

Front speakers are fixed to 0x02. Node 0x14
  Connection: 1
     0x02

> 
> Why PA handles the rear volume control with the current driver code in the
> legacy ALSA driver? It should be handled like standard stereo device. I'll
> check.

The device comes up with "Analog Stereo Output" profile by default. I
changed it to "Analog Surround 4.0 Output" to test controlling each
channel individually:

> > pavucontrol controls are reported with the device configured with the
> > "Analog Surround 4.0 Output" profile.

> 
> You should also test PA with UCM.

Please let me know what do I need to test exactly? I'm not familiar with
UCM.
