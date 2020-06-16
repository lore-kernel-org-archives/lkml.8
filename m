Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCED8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB9FE20739
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iMCa5KT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgFPI3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbgFPI3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:29:13 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E04C03E97C
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:29:12 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 9so22430150ljv.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iUa26xbgXJeW35l3tPgw/qFl/EH6eao+CWqtytwfzpQ=;
        b=iMCa5KT2ALytLHCboqE4ka0Vk2yBe2jHv5q9UFQVadNvRX3zx00OIPajzJCVE19Yft
         NeN7/m9OMHOktHEjg4ng9Rgq+NvUIt1DxbCKPzNuvMctWuZ6RWKtXcxCp5LE2kIhwbzk
         1BOutYp1/+XG6uSXw5UjGgRbXfnLdvJ3J+jL9zoo2aBgRHrQjh4S4jFjwS7ur6ydhC38
         bhCOgGLsvhkV8PYh8xKJSsdhZy2EXyW7Cp+/EjD0irhb0/GBJo//2qP1Yq9AsS4UI3/n
         b+fyFAzy5mzEU8RTsFITTmVbZMWJw/oWGoSg1oStrROaTzMkjmT27u1BV+nJ8tK7aeR9
         EH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iUa26xbgXJeW35l3tPgw/qFl/EH6eao+CWqtytwfzpQ=;
        b=E86JoHKdaYwKwqpM4SooCh2UfnQe7SEnzphaiFui+TtiJ2wy9swEwCHSFxvNKM93DT
         YI2DcVHy77yYjIuPEAtHAkw/KzSWMwiaNsbIcyBTWlKFQGwTVbG2TwtpNLkZm9PpXBW4
         uzgzs80H6UcLdUuYvLJbK3Lm3dCfasY5PrxvCakQR1V9QNWt4WR9FEtyfNk0voX2vIio
         Sw6UM29bME+jAm9b1f5zrtmDiG2OcpksUnvbezoLR/vrBJb9Q+Y1Jh95QcGLXKre4O9E
         PNrBvH6RxsV0dNppj/U60VTGMIeYkOe++TdD9eNh5F5tjg5XylAgalwuvgiR51VqtYad
         JqvA==
X-Gm-Message-State: AOAM5323S2vhHM8ie57c3rGooe6TekwS4xqvLzuzICqeqM72bZliGJtv
        Faa2sf42gTljMJuFwtEGyC5qfA==
X-Google-Smtp-Source: ABdhPJyxAvXQd0bbF0EOVrxP5P6EeKTwx53AuI93eQUjvSBO15+WDlfO8iO2KrF0+EN/zJdjr4qivw==
X-Received: by 2002:a2e:45d6:: with SMTP id s205mr907846lja.101.1592296150212;
        Tue, 16 Jun 2020 01:29:10 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id s9sm4247916ljc.43.2020.06.16.01.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 01:29:09 -0700 (PDT)
Date:   Tue, 16 Jun 2020 10:29:07 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Maxim Uvarov <maxim.uvarov@linaro.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de, Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCHv8 0/3] optee: register drivers on optee bus
Message-ID: <20200616082907.GA2305431@jade>
References: <20200604175851.758-1-maxim.uvarov@linaro.org>
 <CAD8XO3YTz=xN2k5h8HsrYsLUgmC6dD57XbBj63e+3_xFF1H0rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD8XO3YTz=xN2k5h8HsrYsLUgmC6dD57XbBj63e+3_xFF1H0rw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxim and Jarkko,

On Mon, Jun 15, 2020 at 05:32:40PM +0300, Maxim Uvarov wrote:
> ping.
> Patchset was reviewed and all comments are codeverd. Optee-os patches
> were merged. These kernel patches look like they are hanging
> somewhere...

I'm almost OK with this patchset, except that
Documentation/ABI/testing/sysfs-bus-optee-devices needs to be updated
for the new kernel version and TEE mailing list which we're changing right
now.

The last patch touches files I'm not maintainer of. That patch depends
on the previous patches so it makes sense to keep them together.  If a
TPM device driver maintainer would ack that patch I can take it via my
tree. Or we can do it the other way around (with a v9 patchset),
whichever is preferred.

Cheers,
Jens

> 
> Thanks,
> Maxim.
> 
> On Thu, 4 Jun 2020 at 20:58, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
> >
> > v8: - fix v7 check.
> > v7: - check return value of dev_set_name() (Jarkko Sakkinen)
> > v6: - description, comments, patches reorder and destroy workqueue (Sumit Garg)
> > v5: - removed pr_err and fix typos in description (Jarkko Sakkinen)
> >     - added missed kfree in optee_open()
> > v4: - sysfs entry is optee-ta-uuid (Jerome Forissier, Sumit Garg)
> >     - added Documentation/ABI/testing/sysfs-bus-optee-devices (Greg Kroah-Hartman)
> > v3: - support tee-suppicant restart (Jens Wiklander)
> >     - description and comments (Jarkko Sakkinen)
> >     - do not name optee drivers by index in sysfs (Sumit Garg)
> > v2: - write TEE with capital letters.
> >     - declare __optee_enumerate_device() as static.
> >
> > Maxim Uvarov (3):
> >   optee: use uuid for sysfs driver entry
> >   optee: enable support for multi-stage bus enumeration
> >   tpm_ftpm_tee: register driver on TEE bus
> >
> >  .../ABI/testing/sysfs-bus-optee-devices       |  8 +++
> >  MAINTAINERS                                   |  1 +
> >  drivers/char/tpm/tpm_ftpm_tee.c               | 70 ++++++++++++++++---
> >  drivers/tee/optee/core.c                      | 27 ++++++-
> >  drivers/tee/optee/device.c                    | 38 +++++-----
> >  drivers/tee/optee/optee_private.h             | 10 ++-
> >  6 files changed, 119 insertions(+), 35 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices
> >
> > --
> > 2.17.1
> >
