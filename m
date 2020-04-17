Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B84C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 03:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D085221E8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 03:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TB0a5lNM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgDQDT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 23:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727791AbgDQDT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 23:19:58 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919F9C061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 20:19:57 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id e25so524585ljg.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 20:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JD3qiMlHd5EsQciWAFjGX//qBSPNMw64iDNLCTkUKfs=;
        b=TB0a5lNMV5v5AvPFqVnlEKrEDHE3KUNwIu863mg6jZAtMaYxOCT5jFqDFUsawtXPrd
         PGk1bcpvXXW+ocAzG/hBgkVpBg1L2+T8A54vPJbIYfZNHV8gqlITwAkwXGB7xccf16wI
         spIfDfl6B9zF/fYzxhXZ+s25gGsxiEJhLUSus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JD3qiMlHd5EsQciWAFjGX//qBSPNMw64iDNLCTkUKfs=;
        b=ac9NrLdn6XFXf5R6UkzmyEF5FfO1SmgKN/9Hrr1Ws86hQmm5RS2m7Rabs7nwp37m3Z
         ZzgyI8IH6siyxIlwM20hQQlKbv5yKxkA9cbU4ej3BH4AEHFHXsqSHzVCtgXPCBzhKnDm
         aq2/WmbeE8wTmWO/qe/rrhkAgq+L7wlRe5IZd+viVFNQy7Xs5kJQqInwtLl6whrJEQZb
         fA7z7u4tGxxrHiC9eMxLmf9NsP6ORQOFGseVkOBUHp0bpb0Mhhwur6drUvBeIo07NmjF
         BfurS3qNU5COwMqaeYKwaWZBWuYneoUzKzHdz5zQnCIBTM93HzAMSCuSr+xaVqXnOuY9
         0u2g==
X-Gm-Message-State: AGi0PuZ0FrpCo2u3uraVYPh6qVDZB2KpZXX4T0AHsmv+yzYwpVrlGc9h
        e40+1NkgZLFzbg+2To90M/tmgxoF4VU=
X-Google-Smtp-Source: APiQypK4Rmh6pLHbgTnaSu6zL7wzlaCdP73doXwZGW7w+y2PgInKae+b5gCxGriGpTaR1bx9Y6Mr/A==
X-Received: by 2002:a2e:9b41:: with SMTP id o1mr737922ljj.145.1587093595084;
        Thu, 16 Apr 2020 20:19:55 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id m193sm16781385lfa.39.2020.04.16.20.19.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 20:19:54 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id r7so482395ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 20:19:54 -0700 (PDT)
X-Received: by 2002:a05:651c:208:: with SMTP id y8mr697713ljn.280.1587093593874;
 Thu, 16 Apr 2020 20:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200417030449.10601-1-grace.kao@intel.com>
In-Reply-To: <20200417030449.10601-1-grace.kao@intel.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 16 Apr 2020 20:19:42 -0700
X-Gmail-Original-Message-ID: <CA+ASDXM7SLqv_9wrkc=+gnv9bLLHBox3O4vvmgwPf1H2qLyL3g@mail.gmail.com>
Message-ID: <CA+ASDXM7SLqv_9wrkc=+gnv9bLLHBox3O4vvmgwPf1H2qLyL3g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] pinctrl: cherryview: Add missing spinlock usage in chv_gpio_irq_handler
To:     Grace Kao <grace.kao@intel.com>
Cc:     linux-gpio@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Regarding subject: this says v2 -- where's v1?]

Hi,

On Thu, Apr 16, 2020 at 8:07 PM Grace Kao <grace.kao@intel.com> wrote:
>
> According to Braswell NDA Specification Update (#557593),
> concurrent read accesses may result in returning 0xffffffff and write
> instructions may be dropped. We have an established format for the
> commit references, i.e.
> cdca06e4e859 ("pinctrl: baytrail: Add missing spinlock usage in
> byt_gpio_irq_handler")
>

Might deserve a Fixes tag and Cc stable:

Fixes: 0bd50d719b00 pinctrl: cherryview: prevent concurrent access to
GPIO controllers
Cc: stable@vger.kernel.org>

> Signed-off-by: Grace Kao <grace.kao@intel.com>

Seems like you should at least give me the reporter credit, if not the
actual authorship, since I did in fact write this patch...

Reported-by: Brian Norris <briannorris@chromium.org>

And since I approve of my own patch:

Reviewed-by: Brian Norris <briannorris@chromium.org>
