Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5ACEC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 22:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A185624125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 22:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g12R0TrZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgAUWod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 17:44:33 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34690 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgAUWoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 17:44:32 -0500
Received: by mail-pl1-f193.google.com with SMTP id c9so1995387plo.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 14:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:subject:from:user-agent:date;
        bh=aK7MzoSYourzPjGEhxrGJ4jqnOGExlPzl/n41eSoggY=;
        b=g12R0TrZslmZQMJUJZaqFfLGnK3EBHSqXR+l/5UrH3jyFBUbFbhfE7orpigKr+AecJ
         1fE55caoHXcE9MyK0gBfaBUJ9vil5IHbPjOySgAL46hmlZDVXKL5XqBV6marSshneetT
         MD3hx7rWcDcCVWDBtt/IskHyM6kYGG/Vb8B68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:date;
        bh=aK7MzoSYourzPjGEhxrGJ4jqnOGExlPzl/n41eSoggY=;
        b=ZbSLH8Vqq7jAf2VZDWxRZZntYzQKcBPXBI9P5xSNlFcWbou1V1rMOixvtjXrI69bIh
         +tzX3V9SuvQeJ4ss0pT+PBeKimnBXPbWlhFetmHvb6PShqBMLD84Lt9pSkrf+ut6c72W
         3uYB6ZsdkTwULq8hS6sYwHkUKAnknGW58NO8TQHQq2vR6xOgbLm/1EkgZfRbjJ8q6oTh
         8T54wKSFvCsafHw5+eNzpa6C6NicbJHo9khV4AvS1iXzPf/tRQrYn+7snVxonsceoumy
         5xRtJdPPWSphTBamP4nxv3JRQ/XuzZLuUHFA/31dT751yBfIukynKvvxFA4ZI3q65uCk
         O9LA==
X-Gm-Message-State: APjAAAX+6lNVkUNDd9D935IemkVcL6OIRIFy4BU6mvKPN1vpm5Xq93ck
        YvafvJWsowcedni1dSB8T1mz+DGwYMspug==
X-Google-Smtp-Source: APXvYqy8ThGezy3hiGSpoge/z3woMUTnI7ybMGx8iV4CWzttP6QScLXu/dKD0buztCTUlArvfIVxLw==
X-Received: by 2002:a17:902:547:: with SMTP id 65mr7385331plf.50.1579646671754;
        Tue, 21 Jan 2020 14:44:31 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id z26sm45945376pfa.90.2020.01.21.14.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 14:44:31 -0800 (PST)
Message-ID: <5e277ecf.1c69fb81.e60bd.1a96@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200121194811.145644-2-swboyd@chromium.org>
References: <20200121194811.145644-1-swboyd@chromium.org> <20200121194811.145644-2-swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/3] alarmtimer: Make alarmtimer platform device child of RTC device
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Tue, 21 Jan 2020 14:44:30 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-01-21 11:48:09)
> @@ -115,10 +118,14 @@ static int alarmtimer_rtc_add_device(struct device =
*dev,
>                 get_device(dev);
>                 ws =3D __ws;
>                 __ws =3D NULL;
> +               pdev =3D NULL;
> +       } else {
> +               ret =3D - 1;

                         ^
Ick. This has an extra space.

>         }
>  unlock:
>         spin_unlock_irqrestore(&rtcdev_lock, flags);
> =20
> +       platform_device_unregister(pdev);
>         wakeup_source_unregister(__ws);
> =20
>         return ret;
