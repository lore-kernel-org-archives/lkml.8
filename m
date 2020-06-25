Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BE5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC98C2089D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NArVAlHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405951AbgFYQLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403801AbgFYQLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:11:01 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCD7C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:11:01 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id r22so5788171qke.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=okAIsqd4SxHneATkVckCr3UNm2b8nr/CrryoP24fLIQ=;
        b=NArVAlHJOTknqWlDld7Ilx4/RRrM/OTCA9HKXAe8Qkq3YKCW1e+A4wRdknuCMd7Na9
         iOzc3mmB9FF9HM3WDCqVLvDvAOiBZ7QGL9qdT+g2Hq/ijw+dSpfNMgdKmQn6cqzZUOyr
         u6y6nddDQRbhW06LxmjL12Py6u347t10OeaZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=okAIsqd4SxHneATkVckCr3UNm2b8nr/CrryoP24fLIQ=;
        b=REgHE4TsKZfZcFCl5Z4EX1eAXx9aDk1w96gHV0ZAsf3OgC5Edu4Ww5/0udBuzk5AgF
         e9lWUhc99aaKVLqHgAIdJrfl71/o5+kSuoZ+gqBjcoSIU2kWp555VuL4Hu8Aj0tneS3O
         wYDMUK9GTnVXmmAiaKEvWAf6VL2VuCzOgmQ1EZBRe06wCmtByPL97n6iyFmNYc3C7UWm
         3frqOlj7H3/FF64CykUJV4LCysp88VM/ShjvsvEunXVNI2SxqBM18QelIjSuRyZrFli3
         3P49NMalTJVlAPN9fBYzodHW8uO1EfHwDQ7Zo1PLT3/+lCSR9jQsC5RyBi0MnmLchXDk
         LPZg==
X-Gm-Message-State: AOAM532OlzUoDz5vZs0MR0wwL3Hv3kj46ztvl7BjlTMoS2kt+xF4W864
        CFYjRhYCyiuLBHmxVK0gyYBfQsCsd4okGtPh1Bb5Iw==
X-Google-Smtp-Source: ABdhPJyaPeSTuHBCzPbefUYeXtG2dYbs8ISCie68osGg5dwF222thK+bkZI3zETWI32PJPMoA8/ZRYaC2ItGjFAEO6Q=
X-Received: by 2002:a37:5603:: with SMTP id k3mr1279121qkb.90.1593101460546;
 Thu, 25 Jun 2020 09:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200528113607.120841-1-pmalani@chromium.org> <fa79e7e4-08cd-1d9e-d8d7-71a50edcc4a2@collabora.com>
In-Reply-To: <fa79e7e4-08cd-1d9e-d8d7-71a50edcc4a2@collabora.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 25 Jun 2020 09:10:48 -0700
Message-ID: <CACeCKaeeLbZTRTOd0r5yM0MtvmdrkXu6x_HzbgSGZLw7xVyybA@mail.gmail.com>
Subject: Re: [PATCH 0/4] platform/chrome: typec: Add mux support
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Tzung-Bi Shih <tzungbi@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Enric!

On Thu, Jun 25, 2020 at 4:56 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Prashant,
>
> On 28/5/20 13:36, Prashant Malani wrote:
> > This series adds mux control support for USB and DP alternate modes on
> > devices using the cros-ec-typec driver with Type C switch handles
> > provided by firmware bindings.
> >
> > The first patch imports some recent updates to the
> > EC_CMD_USB_PD_MUX_INFO bit fields from the Chrome EC
> > code base[1], while the rest add the aforementioned functionality.
> >
> > This series depends on the following patch :
> > https://lkml.org/lkml/2020/5/19/1219
> >
> > [1] : https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/master/include/ec_commands.h
> >
> > Prashant Malani (4):
> >   platform/chrome: cros_ec: Update mux state bits
> >   platform/chrome: typec: Register PD CTRL cmd v2
> >   platform/chrome: typec: Add USB mux control
> >   platform/chrome: typec: Support DP alt mode
> >
> >  drivers/platform/chrome/cros_ec_typec.c       | 190 ++++++++++++++++--
> >  .../linux/platform_data/cros_ec_commands.h    |  14 +-
> >  2 files changed, 187 insertions(+), 17 deletions(-)
> >
>
> Tweaked a bit the subject, s/typec/cros_ec_typec/ and queued the four patches
> for 5.9.
>
> Thanks,
>  Enric
