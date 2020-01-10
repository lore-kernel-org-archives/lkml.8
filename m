Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A98C33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC6B2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="kL/Co5LE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgAJLcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 06:32:21 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:33136 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbgAJLcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 06:32:21 -0500
Received: by mail-il1-f193.google.com with SMTP id v15so1550031iln.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 03:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6vZ3i0ACJsvtUUtpcXPXYAyzu7/orFMlNRJwZ/DecAE=;
        b=kL/Co5LE5HonXQt0kBSSk3dt8JhyLrNcFhBDGbiYgEAaWkv1Puis/asJlEBzQB46Ch
         xMM7tLnalKW4JXu2Fd3hs2BIl11Tpr5quruv5JWZZL2PUJPJz/A50tlZzvVFVtxraP9I
         bv8XR5D3NJdOEGNCisf6g/jZIGPGh4eR7ZVdFHqB/TDv0V/7vQuVAAl1G8RlOmOmvDFw
         oJyf+9QHjCCUiE/D0XAFpqZZmGQibIPun+ACV+hFcFbzqJr7cs3sNZ93ZUgH8Xq4UjpM
         JDax9lUYJ2ZK+AKZ6yqPOcg9Y4IXKqA0vt/Kk9gXqbZF+EWu0nVaF7shG++1howTBi7X
         eaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6vZ3i0ACJsvtUUtpcXPXYAyzu7/orFMlNRJwZ/DecAE=;
        b=BCpFBf6lIfe9j8dtmHf1VG0+CKVFqoBO6eo+EdxWverLH+yzRmOgWeUbzV2uJAaehj
         LK70GhiWFnvAbuvYb1MQErPkfNROSc63KrFXvSfKhtqyIHzYx8HALOwmzWWvw0wnJNRu
         H4tcHbGONeNmi4ych2thh3SWNwirpJO4PRibHOocUTT/LikHZ2YQMRnDIam7e36K5Frm
         CNMXEd2SUSxPXzUObI6xqgoN06SpdhQ8+04DmXv+wOYD1w+2eneuOIntlkad9ze0Lghh
         uxz0z7Z4qYP6co7l4fVvtW5hIwDl5NEaHBMViMQw8nK3uAG8YcabadP0NGpLds9ABf/c
         d+lw==
X-Gm-Message-State: APjAAAX1thA1bhqzCY42Ej4NnJGYmtV0s2e8VP+7yuSwxb0IkeTmRPs8
        6kqFTjai5YWTzmOtoZJrvXKMpHop6kuMFSIw+WNB/Q==
X-Google-Smtp-Source: APXvYqz0bgtDRAx1G7UDm6V7rhYVa6QaXBuJyg25e91VF1x0+DZw3AFQviBXm01q2UvtAk9x2VvP91vpxv5TNVeCcdY=
X-Received: by 2002:a92:3b98:: with SMTP id n24mr2060356ilh.189.1578655940535;
 Fri, 10 Jan 2020 03:32:20 -0800 (PST)
MIME-Version: 1.0
References: <20200109154529.19484-1-sakari.ailus@linux.intel.com>
 <20200109154529.19484-6-sakari.ailus@linux.intel.com> <CAMRc=MfqRqtW=nMuKFcpLrBHYg7wwPboUEvYpj2sBXM8yWEM_w@mail.gmail.com>
 <20200110112851.GC5440@paasikivi.fi.intel.com>
In-Reply-To: <20200110112851.GC5440@paasikivi.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 10 Jan 2020 12:31:41 +0100
Message-ID: <CAMRc=MfJgMFDgpb4HmUhj7kioZUgP2zaOiXk0Pw=C7t-GuLagA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] at24: Support probing while off
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-i2c <linux-i2c@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 10 sty 2020 o 12:28 Sakari Ailus <sakari.ailus@linux.intel.com> napisa=
=C5=82(a):
>
> Hi Bartosz,
>
> On Fri, Jan 10, 2020 at 12:16:14PM +0100, Bartosz Golaszewski wrote:
> > czw., 9 sty 2020 o 16:44 Sakari Ailus <sakari.ailus@linux.intel.com> na=
pisa=C5=82(a):
> > >
> > > In certain use cases (where the chip is part of a camera module, and =
the
> > > camera module is wired together with a camera privacy LED), powering =
on
> > > the device during probe is undesirable. Add support for the at24 to
> > > execute probe while being powered off. For this to happen, a hint in =
form
> > > of a device property is required from the firmware.
> > >
> > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> >
> > Why am I not Cc'ed on this patch?
>
> I'll make sure you'll be cc'd on any future versions of the patch.
>

Thanks. Please make sure this applies on top of my for-next branch[1].
We've had a couple changes in the driver this cycle.

Bart

[1] git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
