Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0DCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA0E4207CD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="hLnUjzHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgGBNGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbgGBNGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 09:06:35 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFECBC08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 06:06:35 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id a11so15883860ilk.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 06:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zqZZnAc3Jm/n7Smq/DxgygE6EQ2lhk2n98XwSpXb0RU=;
        b=hLnUjzHhfTedPF4jpVK5uE9TMUUOiZWYludIhvLqWR9/HOAViSVHlTdJc0I8/CfSNN
         Q4VceRKFmTrYEaH34MuzYp0cMq4pD6E8sukjJpYleVpOTB57vrxCJswrNg5TcEVF6uCf
         VAT67vP1jU0uEU9tgPpuB/7/2klSZYFZ7QrGaxbekHD9LgAgezweQ52l+leLpfFPE0gy
         D866sFaH8LC2aYdKAxpA+mdvO93shIRA/d4cJjViD1NTP6QzMFpt4+OfLUqWeshhW3Zq
         vXWRkzW2gZrCkpqMuNR3ebQTmqRB+L36IT9xNz6jo1kB2la4oWFKLtP7vqH9Ny8L8Ch/
         spWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zqZZnAc3Jm/n7Smq/DxgygE6EQ2lhk2n98XwSpXb0RU=;
        b=rUyDhvpc733w6fiCtcr8IrWEJQl96MXRTbOAzDNH+wcAmsa0NgS2qdesi2XnB8k2Iz
         lIQC+iMtsmQH7CEI4xuslKhDAPcXcLWj+RjEbE9AyCvlgo4JKlhmzVaYYo5BnyqZIqRv
         fACO9nbsL2guSz+8xKswhYMP7XQ0RtS8h7zqGQGuRs7ifPRpXVCZ+RQol2RuZEb6m09/
         ZkT6h4NyAlGQpBeO/vPYlR5JuFU+c2NwC73lPwz6vlQCS76Yb0N+lNJGVLwGIHoY7h8G
         A54LwAYB4Ggk0OZ7QbcstYLcb+aa0MLWxhtBQ5J5xP7K6z/8mpHzeU9s5F34cd61Awtm
         zw5g==
X-Gm-Message-State: AOAM5316DYebxBOxAehD3wlY+++0XyTGxA8vEwj5Kvm4brsefcLuAXrw
        3w0fLxQjApmdGFmgPghuZjRLAUDlfwEaVcKzpCSt+A==
X-Google-Smtp-Source: ABdhPJzVVB5XahRflUVJctFkIuINfk+noXnsMc1NKChoIoFoswcoLo0pLtTGRTZu8jm8CSw3rvxtt3WvtxpW/Bpfcoc=
X-Received: by 2002:a05:6e02:dc5:: with SMTP id l5mr10658654ilj.220.1593695194982;
 Thu, 02 Jul 2020 06:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200629065008.27620-1-brgl@bgdev.pl> <20200629065008.27620-7-brgl@bgdev.pl>
 <20200702124419.GB1882489@kroah.com>
In-Reply-To: <20200702124419.GB1882489@kroah.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 2 Jul 2020 15:06:24 +0200
Message-ID: <CAMRc=MfcJ04mCZe9AGLZO0q93-oUoidQM6wLkg1et2XOf2wnwA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] hwmon: pmbus: use more devres helpers
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 2:44 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 29, 2020 at 08:50:08AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Shrink pmbus code by using devm_hwmon_device_register_with_groups()
> > and devm_krealloc() instead of their non-managed variants.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  drivers/hwmon/pmbus/pmbus_core.c | 28 +++++++++-------------------
> >  1 file changed, 9 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> > index a420877ba533..225d0ac162c7 100644
> > --- a/drivers/hwmon/pmbus/pmbus_core.c
> > +++ b/drivers/hwmon/pmbus/pmbus_core.c
> > @@ -1022,9 +1022,9 @@ static int pmbus_add_attribute(struct pmbus_data *data, struct attribute *attr)
> >  {
> >       if (data->num_attributes >= data->max_attributes - 1) {
> >               int new_max_attrs = data->max_attributes + PMBUS_ATTR_ALLOC_SIZE;
> > -             void *new_attrs = krealloc(data->group.attrs,
> > -                                        new_max_attrs * sizeof(void *),
> > -                                        GFP_KERNEL);
> > +             void *new_attrs = devm_krealloc(data->dev, data->group.attrs,
> > +                                             new_max_attrs * sizeof(void *),
> > +                                             GFP_KERNEL);
>
> dynamic sysfs attributes in a devm-allocated chunk of memory?  What
> could go wrong...
>

So what *can* go wrong, which it couldn't before this patch? The
drivers in this directory kfree() this memory anyway on driver detach.
Using devm here is equivalent to the previous behavior - only that the
memory is freed after remove() not inside it.

> Anyway, is this the only in-kernel user that you could find for this
> function?  If so, it feels like it's a lot of extra work for no real
> gain.
>

No. There are around 100 calls to krealloc() in drivers/. I assume
that at least half of these are called with an attached struct device.
I chose this driver, because it has a commit in its history that
explicitly says that it would use devm_krealloc() if it were available
(commit 85cfb3a83536 ("hwmon: (pmbus) Use krealloc to allocate
attribute memory"). I didn't want to spend a lot of time on converting
other users in case this patch gets rejected.

Bartosz
