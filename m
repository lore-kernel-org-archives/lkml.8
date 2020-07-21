Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517F5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B44C208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="men9rtWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgGUD3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 23:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgGUD3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 23:29:50 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35488C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 20:29:50 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k5so955956pjg.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 20:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MxGv80/RHZys1Fyrt2FNd0EFBhYyXaZisAhmtR8geU0=;
        b=men9rtWsO17inFkfs3GVcIfF93QcNLgGSxjW9CIUyB8ldPfU/uOnTm3go7r55g1/5q
         JmvSCUXjrA9rNV3Tl2T95LnVTSc3V9O4+eCFW4gPMA4TTLkpzY4nUC3hnUo0MTrkVTxk
         2jP8GwMI29TsgJUv+tbiYrGD7E0i9zNCdAVWyHUF4B/YrqK6vx2dg5fagHKGwlQIj8fw
         Ox9oW7TYiTY5/IxrKcAK3K1QopMVB2Ps3Iok/7CssSxG9mfb7/yojEYqmo5LrnbbRGPv
         CD758d9mIkqRmrmvdlT+nDY6tGojuyvXiTTd+tTJonDrzLtVMBYZqsk1pwPJyg1H0UYf
         TRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MxGv80/RHZys1Fyrt2FNd0EFBhYyXaZisAhmtR8geU0=;
        b=ltPWJhj6vukGqRi9hpew/4o4e4aIOb0EQh/aXnaJCkEloo7lBX3AJzm5lD+OJ8SqaU
         vra+/0RzsMSoCN/F3V8chQBA/acKbbYJD37xEPR4R+d+Ssl5BjhvKm/JLWpwhhDsD948
         T3wsYT+RQCsHJ+ljmODhoHiJfmOns6uyfBoPusORk6RmREIl0c8hcl2bI0/lpG4V8zbS
         IeZB92RN7PYEh5jVHWDU0pGhncV81Gfhj2I5UWezQn/sxbXo2eypFCK1OH/kisiop5qr
         DvGXr7U2d1M+9VIcpvMHGPzWVQ1UeyKPZCzVoQ4MpaoOCTSAYBEf2YFsw1GpqxfHxuYB
         5GMw==
X-Gm-Message-State: AOAM531oUaB5SppdEtTMyG0HUPLs6W58NAr6kkkaUa7vGQUVpXnXazRJ
        KX0awukQsuHEA5INBGMjDo15rEwqdpfqwYg8TiLSbxwU
X-Google-Smtp-Source: ABdhPJx3k6REPPn1/fkaOwx9O6wZzCcLn9v7xbM6r8FiA0K/h7GXT7YPwf2v50+n8W3XkCkQCr2/NamEtaAvVG0c8+E=
X-Received: by 2002:a17:90a:784b:: with SMTP id y11mr2596953pjl.51.1595302189579;
 Mon, 20 Jul 2020 20:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200716042053.1927676-1-saravanak@google.com>
In-Reply-To: <20200716042053.1927676-1-saravanak@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 20 Jul 2020 20:29:13 -0700
Message-ID: <CAGETcx8mtZdkbcqJ6dTpesb=7wHrKbB9q=wrnihtNbT1rz6ocw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] regulator_sync_state() support
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 9:20 PM Saravana Kannan <saravanak@google.com> wrote:
>
> Consider the following example:
> - regulator-X is provided by device-X.
> - regulator-X is a supplier to device-A, device-B and device-C.
> - device-A is off/inactive from boot.
> - device-B and device-C are left on/active by the bootloader
> - regulator-X is left on boot by the bootloader at 2000 mV to supply
>   device-B and device-C.
>
> Example boot sequence 1:
> 1. device-X is probed successfully.
> 2. device-A is probed by driver-A
>    a. driver-A gets regulator-X
>    b. driver-A votes on regulator-X
>    c. driver-A initializes device-A
>    d. driver-A votes off regulator-X
>    e. regulator-X is turned off.
> 3. System crashes or device-B and device-C become unreliable because
>    regulator-X was turned off without following the proper quiescing
>    steps for device-B and device-C.
>
> Example boot sequence 2:
> 1. device-X is probed successfully.
> 2. device-B is probed by driver-B
>    a. driver-B gets regulator-X
>    b. driver-B votes on regulator-X
>    c. driver-B lowers device-B performance point.
>    d. driver-B lowers voltage vote to 1000 mV.
>    e. regulator-X voltage is lowered to 1000 mV.
> 3. System crashes or device-C becomes unreliable because regulator-X
>    voltage was lowered to 1000 mV when device-C still needed it at 2000 mV

Marek,

I'd appreciate it if you could test this series to see if it fixes
your coupled regulator issue that you reported earlier. I'm expecting
it to fix it without needing any special case handling in your
regulator drivers. But it'll be good to get confirmation from you.

Thanks,
Saravana
