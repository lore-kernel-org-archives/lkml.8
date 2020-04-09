Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C33C3A5A0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2707321D7E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPNexXEe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgDIJkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 05:40:22 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43738 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgDIJkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 05:40:22 -0400
Received: by mail-lj1-f194.google.com with SMTP id h25so833843lja.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 02:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LgFkSUz0v3R4bkB5V+D5UMhS2cYsaT9/1pL+etapsD4=;
        b=JPNexXEeIt/U33OVj4WP/94syOFkeqUwHdMIq5H7RWXe/OPXbAdyMUgK5wZq3sWUNL
         imvoRp5Hm+NfjsOvyfqYeYGoB681I+J5FB7oUydEX/h/RPt3UQZvy+0LjaIhLDpgsB+h
         0NGnPZ8vb7rkKg6hES58shForkhPwzm7TAiqRSSkG6+biZ9mMP9uwQuflpspRklJEbGQ
         1TpUAhkJIJPHIf5vnwk6wSiCWg1Hw1yu/ONv654UmU15YcPhgWOu8XRH8iPAoAMdYzJY
         Qxw+VqkfJgqp6HqILw1wM87TCGOUbmhk0KOtw7wqMUQWBY54Py/oXaFg8qpLhOs0+jpU
         /bjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LgFkSUz0v3R4bkB5V+D5UMhS2cYsaT9/1pL+etapsD4=;
        b=lwH3KO61twHiM+PVeNnXGuhFlfgebcwrbmz4Qy57EQhUcaseMW85nYbU6w3aWaGui0
         XLhu6uKiPddV1+5BImnj4T4jROlAWKFiQ7uOMuZmKSTyt0bWg7E1ruq6+eCJO/K5bdo9
         OapIkNqTSGKJFa0lV3kmktEmk3VtlVRGIFqfLTqch2hU3nl0NSLuOoxntgzFt5IBpITh
         AT7O88uOmIax3vnaZZX5nq0uZ/E1xcRxyS4UrsQRPuEZXETUUMO5BsowSd38wbB4fip1
         Oh0wrRp1zVS+cYl7N8ZksaqezLfZBxW3oDgN4xypoF6Vl41gsLlZpPuN+m9pfql0AMW+
         yUrQ==
X-Gm-Message-State: AGi0PuaBtI0iyIGSfRJxNM/PqL9zB+f0bZmyDtDFgUVV8Q3mscAfVSkp
        oDZ/jjvDmHGtMxWn/jl305M1+ASlHZJwmTh6rUE=
X-Google-Smtp-Source: APiQypKo8LVXqoYVtBrVuYWmZZJdh2e+KxaobbXQfvZgNQnkc/ER8sfgHVJboqMyLu9tpe5TL8wloOsVOP6LiaWj28U=
X-Received: by 2002:a2e:89c5:: with SMTP id c5mr7351482ljk.48.1586425219621;
 Thu, 09 Apr 2020 02:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586422035.git.baolin.wang7@gmail.com> <CAK8P3a1rWuL-mSeFBN0Dk7u3wnDmPgknEM3Em734KP64-Wv0ZQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1rWuL-mSeFBN0Dk7u3wnDmPgknEM3Em734KP64-Wv0ZQ@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Thu, 9 Apr 2020 17:40:08 +0800
Message-ID: <CADBw62qEfdLM9e2oyPKz1qRk4mZaFPbXRYpLfVHzxKj0Cz90kw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Add new reg_update_bits() support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 5:15 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Apr 9, 2020 at 10:58 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> >
> > The Spreadtrum platform uses a special set/clear method to update
> > registers' bits, thus this patch set introduces a new reg_update_bits()
> > callback, as well as adding a helper in syscon driver to support
> > this feature.
> >
> > Any comments are welcome. Thanks.
>
> This looks like a good idea to me, both the concept and the implementation.

Thanks for your quick response :)

>
> The one thing I'd note is that we have a similar mechanism for devices made
> by Sigmatel and later Freescale after they acquired them.
> include/linux/stmp_device.h only holds a couple of definitions, so it's much
> less abstract than your approach, but the idea is similar.

Ah, yes, sigmatel devices' idea is similar with ours.

>
> It would be nice in theory to move the sigmatel devices over to
> reg_update_bits() in theory, but this seems unlikely to actually happen,
> given that these are mostly obsolete drivers at this point.

I checked all sigmatel devices (about 10 drivers), I think there will
be more work to change them to use syscon/regmap when changing to
reg_update_bits(). I am afraid I can not thelp to convert them without
a hardware, and as you said, some drivers are already dead. So I think
it would be nice if the driver owners can help to convert these
drivers, if we get a consensus about the reg_update_bits()
implementation at last.

-- 
Baolin Wang
