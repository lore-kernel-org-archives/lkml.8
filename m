Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D012C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 08:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD5C320825
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 08:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="poKvZtY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgHVIUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 04:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgHVIUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 04:20:48 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97228C061573;
        Sat, 22 Aug 2020 01:20:48 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q1so1810565pjd.1;
        Sat, 22 Aug 2020 01:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tcUFMfCVC9uRonruJhKq5CJkq15cD+sb6a8YuyisFTg=;
        b=poKvZtY+iUmeR6J2SALMSuIGQnbmyETzuLIoti5vhJ7voGBjdZYXc7lXMIBfUt1YK4
         BA1jT75UesDLBq8n1LoTP1au0nD4veNThjg2fj91Esp7FlRj0HifR8zxCF13xC0tdDLJ
         RZxJf8hux9XFYVvw2APbivJzRaQMdUhzvX1FEPBA1d9vQBlrCO0sAQmJm9baeedHvns5
         aEj1ywsoahOB4G0SHTk1kBxPiO+ujZGl9SatmGWXKgJcltXWvJ0Tn2yXJY5iKic0pvzl
         eBiHy16g4XLHGxpJe8yb5RAr1K6AlHrgaXiUIKreW7MFmaJQ1NZAAaclP9dl0Ndtv2uI
         0Kjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tcUFMfCVC9uRonruJhKq5CJkq15cD+sb6a8YuyisFTg=;
        b=lwzOwczJDMisPiz7VcCkQ/keQle63NrWf9uhfIcezNGI3R+bBKZ8HqHua+X2skcb+U
         04AUhT8uTvAB+7y11cEhuUrTm5+YnKo9O2kfsY69x0Bu/m8WeX2BpzrEPZL7XtaLQUSQ
         sBp8gexVEpuxOMneca2D3XlahR4QCcT87EtEKIJhknpfNx7dcqHmfjfdhxmjPTZrlnfV
         wRSngE8NFK0e4O6n+/7+VcTqL1w5/fchRNAbVU9evifCOh8+XEgmF2mKhR4YGwgfn4Dl
         VOv5Uw1Dv+3esDy7PubuIQTvQpJeHpyDNd9fRIwOUf1Tai3m8BPjiDFhl10CUuunR0df
         86Qw==
X-Gm-Message-State: AOAM5337AJrYvz/S8yotd1Sgu3CCM0gDZOtOq+ZnLjPBT1JpbrmhOMs0
        IkUP68TgRHawQQ4plNqg7xZZX8tDIeb66ybKZTooxupF8kQhlA==
X-Google-Smtp-Source: ABdhPJwI/pKVJMO6ZczrtwKfg7OQcEo1CCZy7LQforpcGnrAxL0obcnO4w6p2wZ1bBqrDoN3GGnUMZiSugBD1lz1wow=
X-Received: by 2002:a17:90a:fa06:: with SMTP id cm6mr5648971pjb.129.1598084447750;
 Sat, 22 Aug 2020 01:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200821181433.17653-1-kenneth.t.chan@gmail.com> <20200822072949.GR3544863@nataraja>
In-Reply-To: <20200822072949.GR3544863@nataraja>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 22 Aug 2020 11:20:31 +0300
Message-ID: <CAHp75Vd+0EsP7g_Q9Q29YjdQaz23s0ach_rCXPZLCG2uoik=Ew@mail.gmail.com>
Subject: Re: [PATCH 0/9] platform/x86: panasonic-laptop: add optical drive,
 brightness and battery charging threshold
To:     Harald Welte <laforge@gnumonks.org>
Cc:     Kenneth Chan <kenneth.t.chan@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 10:53 AM Harald Welte <laforge@gnumonks.org> wrote:
>
> Dear Keneth and Linux kernel developers,
>
> as I have discontinued maintenance of the panasonic-laptop driver (and
> recently sent a related MAINTAINERS update to that fact), I would like
> to suggest Kenneth as the new maintainer for this driver.

Kenneth may send a corresponding MAINTAINERS update which you may Acknowledge.


-- 
With Best Regards,
Andy Shevchenko
