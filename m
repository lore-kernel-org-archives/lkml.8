Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24F0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 20:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74EE3206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 20:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CNjKWBwB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732948AbgGVUuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 16:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgGVUuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 16:50:18 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862F4C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 13:50:18 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id u8so1644675qvj.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 13:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n8KlKRTspw8Pc3SGEnCijMu4quJCuTK8tjWLNaWsZZ4=;
        b=CNjKWBwBPijZKfDVweV1dbMLdZgidgF7vr2xrC7T58RAzBogsUMBZkRCXbBnADGBjy
         w9tQh2QPpLPIQyMEh21JJ2JKdcebcFumROCYJULaLTKJTV1Ps19tdGWjOGvPYqZWGR6i
         8RC2yVecNEvDUzAhc9EqHlvkkhq6+gUH2vCAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n8KlKRTspw8Pc3SGEnCijMu4quJCuTK8tjWLNaWsZZ4=;
        b=Y0S+eGrqxDPjD6t8NgoPZt0Dcv31u2/Y8+TWe0Awsozb6vlraO1BKGcI1Aun9zOMjZ
         +urzqoL40zarIP657hHYK1d1LWlDxbQ5ayw+1ze5jxFQM4d3k3mICleD5ELIVeJNUKnj
         l/8oyii1NSjsfnn/Av7RVJh0mAeRjtICtaCIUodj40VqqtdWyH5sCtFwzP/9e0Gax33t
         wEhMWFjxfaI/lWQhLMc0KUyIgrNxsP0aT7WSjvCwVEWlGqHUYT84ApKaB0OsK3cISk4v
         yFB+e8yX1mLkoXBjRtToa0Zk6VocO8owB3B/zlKLvt3FiRIvqdLJyiiuEpX7G/RXU/yk
         4VcA==
X-Gm-Message-State: AOAM533GX/oeVmqUogvgKlcVeUF8r4zh0sK7td7Sx8cStF1UaqpgOl/3
        0iupAO4ButHVATfd3wqFr8OzEzCGjWE=
X-Google-Smtp-Source: ABdhPJwjZ7WWgP9st5d02wmL01WNb/KA2hikc8DxABBx+sMi9WpwvTWULQ4EIbjnv5Sz1ODa3OSsqQ==
X-Received: by 2002:a0c:ab55:: with SMTP id i21mr1849563qvb.139.1595451017158;
        Wed, 22 Jul 2020 13:50:17 -0700 (PDT)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com. [209.85.222.175])
        by smtp.gmail.com with ESMTPSA id r185sm869219qkb.39.2020.07.22.13.50.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 13:50:16 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id d14so3340271qke.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 13:50:15 -0700 (PDT)
X-Received: by 2002:a37:68c1:: with SMTP id d184mr1960342qkc.62.1595451014724;
 Wed, 22 Jul 2020 13:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200722015732.1720840-1-briannorris@chromium.org>
 <20200722015732.1720840-2-briannorris@chromium.org> <5ebf1534-8045-9894-9c1c-b92b9c6d8479@collabora.com>
In-Reply-To: <5ebf1534-8045-9894-9c1c-b92b9c6d8479@collabora.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 22 Jul 2020 13:50:02 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMk7Tg7Lwqt8Pv5BQT0J40dpJtqrL9TAn8y5Nj3TCkj6Q@mail.gmail.com>
Message-ID: <CA+ASDXMk7Tg7Lwqt8Pv5BQT0J40dpJtqrL9TAn8y5Nj3TCkj6Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/chrome: cros_ec_proto: check for missing EC_CMD_HOST_EVENT_GET_WAKE_MASK
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 3:19 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Brian,
>
> Thank you for your patch, I'll take a look soon but I'd like to ask if you can
> join the discussion with this patchset [1], specially this one [2]. We're trying
> to match EC errors with standard linux kernel errors because we think can be
> helpful.
>
> [1] https://lore.kernel.org/patchwork/cover/1276734/
> [2] https://lore.kernel.org/patchwork/patch/1276738/

Hi Enric,

Thanks, I'll do that. I do wonder sometimes how non-maintainers should
best support "community" around these things, for subsystems that
don't have a dedicated mailing list and are therefore sent only to
maintainers + LKML-fire-hose. I could probably subscribe to LKML and
filter it, but something tells me my mailbox will still manage to
explode somehow... Anyway, I digress.

Other than perhaps taking a lesson not to propagate -ENOTSUPP, I don't
think this series should block on that, as this is a bugfix IMO.

Regards,
Brian
