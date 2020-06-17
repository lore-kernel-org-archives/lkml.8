Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8760C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 06:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8EB32082F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 06:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uPykhRwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgFQGHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 02:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgFQGHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 02:07:32 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9292AC06174E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 23:07:31 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a9so1368676ljn.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 23:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k2ZEmHhrPs/ulmpdqloJHox+N+2D34dGnYoIhwM09Oc=;
        b=uPykhRwTSAish44ZDPcrnTHTYCxTAoPDQs0s4pqD9Gz+ToeIJigh/T49FDZ4AhuDkX
         ZFti8QWz6Uspvl1RbUitrc4JdzWcICXShXq9TFZKvcMSclCNwY/iHqtBXrDk4tBAazFI
         uzfQqSxSYL7XNi/zx0qIUgOGebOCQ7N2AuzBr3yWfXTTxy3Q/Cegh2vVDSZV4dM3+onD
         KnZocUo2gfKgj2zcrY/20wezao3Gn/JjFkIG9XieO3vzKrjsy3BR2h0UoWhafeGP6dbV
         CzJ5DImXZwKUKFLzbM7oo8fP0qvdLZQHpNFDTZbcD0cNDOwiAUtY3AQAhkx8zFdlZ7Kn
         eu+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k2ZEmHhrPs/ulmpdqloJHox+N+2D34dGnYoIhwM09Oc=;
        b=QdIhwF/MD3+nVeTGi5ApOHsUY632gVICZTWh8Uua8JkxxVsdJ64UFTPFFbg0/QvA2r
         1E5bz0wUOZ2EPRyW2eLJQlc+YGJzJicbjTk5wVED3GLYiDiM75Fz8T77dzKkWhFQuu3d
         1teoBBsaVYPonh9QDprc6Yi13Epzl7SQCO4JYvV9mqoCNb3Z8b9BzxSg0V2V5ybOtSSB
         mWximDlqRiD872R6TjGWQqodL8ZzybfDM1OHZsEr2gyzGijHN/4F1F/gQCEvhlYdRG7L
         re4gjU7uKvuto8BP+yc/yjzZ+vytETfyKK0tbQ6zWTi6LU+4hC7IdQoAdKJfSUmk5rlC
         TQ6A==
X-Gm-Message-State: AOAM533FGP85rYZtVxWMLbYZAzuNdHuRAiYb31MXSJGPXhtlUZiCuvmp
        VUOO/EwXCbj30EVnx+t8kx8Zzam6UduYuxQDP+80wQ==
X-Google-Smtp-Source: ABdhPJwVGClABjAHoGqIadqLzIigFwQpGKlcnffd1cvXC97YTGleZl7YASG+am+g3y0+dLrdmn9YK7ztFIvmDc5Os+w=
X-Received: by 2002:a2e:5c47:: with SMTP id q68mr3402768ljb.30.1592374049915;
 Tue, 16 Jun 2020 23:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200604175851.758-1-maxim.uvarov@linaro.org> <20200604175851.758-2-maxim.uvarov@linaro.org>
 <20200616205017.GC20943@linux.intel.com>
In-Reply-To: <20200616205017.GC20943@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 17 Jun 2020 11:37:17 +0530
Message-ID: <CAFA6WYO1X3zdOMgVnHvKm7MAWWyE=dhbLpCcU5zJG7R2fCuycg@mail.gmail.com>
Subject: Re: [PATCHv8 1/3] optee: use uuid for sysfs driver entry
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Maxim Uvarov <maxim.uvarov@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de, Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jun 2020 at 02:20, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, Jun 04, 2020 at 08:58:49PM +0300, Maxim Uvarov wrote:
> > With the evolving use-cases for TEE bus, now it's required to support
> > multi-stage enumeration process. But using a simple index doesn't
> > suffice this requirement and instead leads to duplicate sysfs entries.
> > So instead switch to use more informative device UUID for sysfs entry
> > like:
> > /sys/bus/tee/devices/optee-ta-<uuid>
> >
> > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>
> Sumit, are you able to test these easily?

Yes, I could give them a try.

Maxim,

Could you share fTPM TA tree which I should use for testing?

-Sumit

>
> /Jarkko
