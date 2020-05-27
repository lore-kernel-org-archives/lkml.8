Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E16C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C70D8207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="sExtPwMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387486AbgE0Dtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 23:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgE0Dtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 23:49:50 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20736C03E97B
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 20:49:49 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x12so18127816qts.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 20:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dVMhtUwlG7AgZ0Ijz3j9HLaOpimNX6eb8QQEpufvZ6g=;
        b=sExtPwMIpav1ROWvRyoQV2sve5tEvstu/cUoWiG8YF+qvuePbma/yLZ0k8svPQhpQg
         b4zE5SnUv8LyJ/sXjy2t8wvivL6wwko8GOq6BSMx0Zu4S8is/+8gROSd9+J/EJkreJaE
         0dIpEI8jMKZOz1gNuUUDxRlpZq68hkucY9YMRiTDP4grSJsIleVRRkDO6pksVFnEhXIZ
         xhWfDqzwFOAcFFLGQNzsV3Hz/l1mHI9pk5+ZEix3zzH/uUALeraXLtiAvAGFniq2CS2t
         3LLlbEGo2DFv51LzG3hD1/mwnfS8mr864C/U+LpL3U8s0jSDsyaB3q59lH4r68bDRqt3
         WMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dVMhtUwlG7AgZ0Ijz3j9HLaOpimNX6eb8QQEpufvZ6g=;
        b=rSO3cAj97Ni3b3camdlkVy5+DOMJkcRVhVTd1UZL+qS7zhc8O2Ht47+DEMhvFjAktR
         UY9ccBXhD03dX82LXeBCb7DZGlrFKSs3+nihV6lfJSRk2WQ7JNegNrqhjHjVpDozgZVL
         prDWQIGNK8vf55k31p4I5mqmvb3SVyLupAhOjeIQ2OoYF/Rt+hChnRWzhb9nfbdQLrSh
         doquoHgY5IrQxuEhlKr3KeX3iqkGjXwy/tmFCOWbfIhhmcOuYd34lzIzJvQnINZDxgLl
         gAyWJhb/VwqSxD0rgegjP2LUL2AaJeO3TiEW0ruDVSLrT7yGU6fjMOnLZkXWeher5UuU
         XFVA==
X-Gm-Message-State: AOAM530f3gn2X5Cs/SRlc0EMda3KjSMaM8UG961dXdf0GcGfc6f4MnhK
        fc0Lj7BzZHsvo9ZI6hYhoow/OGenz9PFZfvIkWLzFQ==
X-Google-Smtp-Source: ABdhPJzw/Ea21QjAz+NNc+UEvVjKgzKsu7W2vzxBdItWR7V+TRRc1JIl7TX2+ezCAqEJ32OO1Ie36scyU+a6wB1ZZqk=
X-Received: by 2002:ac8:7383:: with SMTP id t3mr2301591qtp.221.1590551388107;
 Tue, 26 May 2020 20:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
 <20200427072342.5499-1-jian-hong@endlessm.com> <20200428162152.ztsqp7nxqbwqrm6r@gilmour.lan>
 <CAPpJ_efvtVzb_hvoVOeaePh7UdE13wOiiGaDBH38cToB-yhkUg@mail.gmail.com>
 <20200507172158.cybtakpo6cxv6wcs@gilmour.lan> <CAPpJ_efxenmSXt2OXkhkQ1jDJ59tyWBDUvmpyOB-bfPMDENQZg@mail.gmail.com>
 <CAPpJ_ed9TMJjN8xS1_3saf5obQhULJSLNgQSAFxgiWM2QX9A7Q@mail.gmail.com> <20200526102018.kznh6aglpkqlp6en@gilmour.lan>
In-Reply-To: <20200526102018.kznh6aglpkqlp6en@gilmour.lan>
From:   Daniel Drake <drake@endlessm.com>
Date:   Wed, 27 May 2020 11:49:36 +0800
Message-ID: <CAD8Lp467DiYWLwH6T1Jeq-uyN4VEuef-gGWw0_bBTtmSPr00Ag@mail.gmail.com>
Subject: Re: [PATCH v2 00/91] drm/vc4: Support BCM2711 Display Pipelin
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Jian-Hong Pan <jian-hong@endlessm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Tue, May 26, 2020 at 6:20 PM Maxime Ripard <maxime@cerno.tech> wrote:
> I gave it a try with U-Boot with my latest work and couldn't reproduce it, so it
> seems that I fixed it along the way

Is your latest work available in a git branch anywhere that we could
test directly?

Thanks
Daniel
