Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE51AC35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85455208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nWJQI+9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgBUPWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:22:14 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43356 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbgBUPWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:22:13 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so2554749ljm.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 07:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=exuAjtpKxgZ7i5AH9HXCKWVlRd9sU0cfO8mDnBFc0RU=;
        b=nWJQI+9L7DCA8Ayl9t/XIuyrE3NcUydyRFAA89Dndn5F/u38EWON/eVC6HJGZDfkIZ
         aZoE1J2/bQVxvRODxYDS3VWDPkqPM2kp1s3wFzYR3eZ9Gr9hLxaY4yRTOl8C6lS5GBCe
         j4/hZazy5ZeyDNWILADRjbQFkNY9N71WMwZlFhUyFod9wTrQCHl/IRMSea8I0PsHNPyH
         /r8AyZCi0g/HW6x1SlG7/N6Z7rmvSQcvWhLcp9suy3ypfiihHtLePeNGrW2XlkKaECfd
         /p18fg+AXexJlKHc4jc3XDJ5esSgJI8uh9MwK7AUTJRv9GxuqOr/eM39t3rIgP/H9RCI
         F6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=exuAjtpKxgZ7i5AH9HXCKWVlRd9sU0cfO8mDnBFc0RU=;
        b=bRemxyjPXsnlZWMzieL1E6YqOhYTvfGEkYfsuIx5vjl4e1PfCqmbpDwcxwso0WBP84
         yy7kjkOoaZQXpvio8vgbf2sXawffgBzbqdkXMwuDvHQ7skkrSdUvIe5vXN4HQIn1mXge
         2G0n5IddpGGJG5EmaX//bgfcC4+0IymTsQbbNfPD3vxye4VBPSeIaIMkoUDjRk/hC8Jy
         KVvW7AKLRhWAariLJuTYjmPsUQcym7uGfOxur34b6k2YJvZaD2yYnMjCYnE4yxzGD7Wt
         4hGg2O7UFqJaA9qnBpZzpgyPE79+PIxHt16Ef9PNeuV9TpGA5NAFpEb/paW2fi57BtMB
         C1pQ==
X-Gm-Message-State: APjAAAXDRZG9F24VU1hVEMzs3q8Q00CtUBVbQdkuVg5gVvE6Utfydnvj
        Rip28XrBiUIKruhanShdE+GXwknyimz4h24a2H51vA==
X-Google-Smtp-Source: APXvYqwZU623dWBmI+RqyZ+fasWfep+rEmqFbWrsvBd4fMrL/FDepPpf5X5DjWg3+ZKIgPDrckxSlsGph5amZfGYv/o=
X-Received: by 2002:a2e:81c3:: with SMTP id s3mr21858980ljg.168.1582298530346;
 Fri, 21 Feb 2020 07:22:10 -0800 (PST)
MIME-Version: 1.0
References: <20200220050440.45878-1-john.stultz@linaro.org> <20200220050440.45878-4-john.stultz@linaro.org>
In-Reply-To: <20200220050440.45878-4-john.stultz@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Feb 2020 16:21:59 +0100
Message-ID: <CACRpkdYVQs0dDT8dn2GzQQXrbXATRi8iqHB41EQBMEwMiEFgzA@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] pinctrl: Remove use of driver_deferred_probe_check_state_continue()
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 6:05 AM John Stultz <john.stultz@linaro.org> wrote:

> With the earlier sanity fixes to
> driver_deferred_probe_check_state() it should be usable for the
> pinctrl logic here.
>
> So tweak the logic to use driver_deferred_probe_check_state()
> instead of driver_deferred_probe_check_state_continue()
>
> Cc: Rob Herring <robh@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> Change-Id: If72682e0a7641b33edf56f188fc067c68bbc571e

I sure trust that you know what you're doing here.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I assume you will merge this through device core?

Yours,
Linus Walleij
