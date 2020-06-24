Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE44C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7ADE20724
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QMdo0p8h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391140AbgFXNxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391067AbgFXNxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:53:41 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45122C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 06:53:40 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c139so1802932qkg.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 06:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mRYyM0zIbTqM68BjvlCr5uVHmxe6eetV1Y2qfNzGsZM=;
        b=QMdo0p8hDI4oUxlGJ6mKTHrE9I8PX2YElUaRnEJgAceas6VgcEISoKLS5RPVe7WFDF
         32KtmlRdhAmaO4ahS4applF66ZAqe/3P34ZvqPWuxynVAcOf7zgj5ZY3LoSmjEgt3qwU
         DPP8V8jT6tUX8hQqLQpMN3qSEFc9KwWa8t7BZMYm1yx5wYfgATgYQCBEOisWdijwwILF
         4tDhPSSTcSZkm6bp2sLvSBbLWGl71d8JJrOMFcLIuMd3t9ArgeGOOP4oWnkwbKSI5ge8
         FfNwpXgm3RjuMCxP72lw1nD6Fa+huxcZoXcG4iFecfcHvDQ1QkZrEwWbIhdqencn0bTk
         Xhgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mRYyM0zIbTqM68BjvlCr5uVHmxe6eetV1Y2qfNzGsZM=;
        b=Y79Qpk4PcKzTVlfLqAHCpS/+1hwIbI4oG2bTfO+Ex208wFP9CirYpUmevpHYPjNdoE
         IGVE9n7b2B9Az2sqOb713BH/4hx9cKtDfpji60lD4vaJ8mSlkspreHR+RbJgSTKTcXN7
         7aNkOl2il/ix+r/ozqFeKhGcwmmrHrjDN/5Vvk09+SP6nV2y1GXAtCUJhV7vEuC+zxn6
         2D4rhXQg2J0w38ek0RYvfc87Bgd+DW0GLmeOOEjcprgb8qsGtddakqKzPN++5slwOdWG
         i2BJ2P4FPW4sFh99fqpzVBNEk2fD9UlA83Fkm5y3o5+hkuN27nZbxKJ/3E513k/5G02X
         fYEw==
X-Gm-Message-State: AOAM530KCx/WiD85TGEh7iT/koh8hChpwJY2Irg775CsHsG2IHWqjmhQ
        6KsaCdcrGqry9vQLZGaucte0JHKN5dqzKn40bVN+3fikEow=
X-Google-Smtp-Source: ABdhPJzLrJsp8nI9YPn+rBVjga4ZfPE1sjzOTMQdbFWUEbt8fB5HtHHrlaJtml/YlcZA315Y+hVMaVc8OM65rS07uWU=
X-Received: by 2002:a05:620a:1114:: with SMTP id o20mr25806203qkk.120.1593006819575;
 Wed, 24 Jun 2020 06:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200623040107.22270-1-warthog618@gmail.com> <20200623040107.22270-7-warthog618@gmail.com>
In-Reply-To: <20200623040107.22270-7-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 24 Jun 2020 15:53:29 +0200
Message-ID: <CAMpxmJWuoTGOvptmP2Z0RhW7eSeFLZSsHXx3d25o2AuV-u5wkA@mail.gmail.com>
Subject: Re: [PATCH 06/22] gpiolib: cdev: rename numdescs to num_descs
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 23 cze 2020 o 06:02 Kent Gibson <warthog618@gmail.com> napisa=C5=82(a)=
:
>
> Rename numdescs to num_descs to be more consistent with the naming of
> other counters and improve readability.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
>

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
