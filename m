Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9809DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71891207F9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCreMSX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgGIQcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgGIQce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 12:32:34 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8B9C08C5CE;
        Thu,  9 Jul 2020 09:32:34 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j19so1185500pgm.11;
        Thu, 09 Jul 2020 09:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mds9JnL5+YNLjwOOXncrDDf4ATysP7TR1qNQc1p6UDk=;
        b=fCreMSX9EhBerl+2TyxRKjDaEWa+JLTGXeNDKhvWlwcUMmvEU4iOBJ1hETBBaoIXY+
         3wGaamvx0qGsqNTVreuH1ejdGCJDiPEcB2eAm9QUsFNVM4NL4b8jSFsKlSdKhuT6WIbs
         BqEriVLsFwIIaXEmGJHEAfWi/GvaWm0/I7gLpt83Yk4Hl/RggpY1LX1mZBxA2tJcRyeX
         vrWdojyiXqa5aIQjG3W40pVoMxpj3KaNhnJJVXMGIOTxx8l/hfsh6sqUlP3CNhSLL51+
         BOi8gRSuXFlXnnk2d56lugrqmXpvdmnpbgfDCe4uSvgKeYoGdb5uQN4OCHY7lfa64bD2
         SG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mds9JnL5+YNLjwOOXncrDDf4ATysP7TR1qNQc1p6UDk=;
        b=TaBBRE/BVk3egnZzd3DqxZs5mByj7WedO2j8tPNaD5WCSP5ZeMNznBCkR7S4u7LayK
         G/Wo2ce0lRLwp1LflJPy7GNBNoszb8gDhk5acX6Sgf3JS4XdIEoFBO1LkwQHT8y427nS
         Wk2LPB03REUts9EVXzJ2KyOMFkk4PfTqiCkUtorgptVCuce6FAWPlnpNjfwVjKbc8/3E
         juUcM8WlSBzqgsgabFe8eamezj/dDqaZLRQGH4kQNGvE51ehjO5rRaiffDEpiwLwaddw
         AEWkjJU4TjOrbUQoJ+C8gc6jXI91l9GfFDDFL+/Cce6XcxcBgyjFUvJGXt9CX5UJnXfy
         PZJw==
X-Gm-Message-State: AOAM530mbT0ReTus3jD288aCOQjw0yXnWd1svpkENiXImxOEuHlxSHlO
        LEWN+1RexnioE7jLVOSR2Nr5hf4KtA5rNWrdUU0=
X-Google-Smtp-Source: ABdhPJwEDObaYpjZKatGt4CVCe8DGRH/+UZeqYJ47OTcz/gffgUl65HJoQvqw/MGNTXOyb7Ko2oxd8cS3euVMSG5BLY=
X-Received: by 2002:a05:6a00:790:: with SMTP id g16mr23259445pfu.36.1594312353918;
 Thu, 09 Jul 2020 09:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200601091851.5491-1-vadimp@mellanox.com> <20200601091851.5491-3-vadimp@mellanox.com>
In-Reply-To: <20200601091851.5491-3-vadimp@mellanox.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 Jul 2020 19:32:17 +0300
Message-ID: <CAHp75VfXPxoQjeOTMRmO=Yf3YSsGJh2xRRSm9U7wTpRx9N8Bgw@mail.gmail.com>
Subject: Re: [PATCH platform-next v1 2/8] platform/mellanox: mlxreg-hotplug:
 Add environmental data to uevent
To:     Vadim Pasternak <vadimp@mellanox.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 12:19 PM Vadim Pasternak <vadimp@mellanox.com> wrote:
>
> Send "udev" event with environmental data in order to allow handling
> "ENV{}" variables in "udev" rules.

...

> +static int
> +mlxreg_hotplug_udev_event_send(struct kobject *kobj,
> +                              struct mlxreg_core_data *data, bool action)
> +{
> +       char event_str[MLXREG_CORE_LABEL_MAX_SIZE + 2];
> +       char label[MLXREG_CORE_LABEL_MAX_SIZE] = { 0 };
> +       int i;
> +
> +       mlxreg_hotplug_udev_envp[0] = event_str;

> +       for (i = 0; data->label[i]; i++)
> +               label[i] = toupper(data->label[i]);

Sounds like a candidate to be in string_helpers.h

#include <ctype.h>
...
static inline void string_upper(char *dst, const char *src)
{
  do {
    *dst++ = toupper(*src);
  } while (*src++);
}

// similar for tolower
...

There are plenty existing users that can benefit and I can imagine how
many more will come.
So, If you add the first patch in the series to bring this in, I will take it.

> +       if (action)
> +               snprintf(event_str, MLXREG_CORE_LABEL_MAX_SIZE, "%s=1", label);
> +       else
> +               snprintf(event_str, MLXREG_CORE_LABEL_MAX_SIZE, "%s=0", label);

Wouldn't be easier to have

..."%s=%d" ... !!action...

?

> +
> +       return kobject_uevent_env(kobj, KOBJ_CHANGE, mlxreg_hotplug_udev_envp);
> +}

-- 
With Best Regards,
Andy Shevchenko
