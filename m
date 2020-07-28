Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFCFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 05:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EAA920792
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 05:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZQfCXDqT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgG1F0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 01:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgG1F0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 01:26:08 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A5DC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 22:26:08 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 140so10295716lfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 22:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IQp7PaFynBiHmKOu2OBCAYH79Xh1QNmxWYCgk0LUVrA=;
        b=ZQfCXDqTwg6A2LWdJy4l/CLLKlo49ehPpUkrL5HKyDwCPZnpI4lW8kLv8mzr4Glvot
         k/6Z7esA8OWs5WWlIoKLZ3Ptosrpme5R31iZsRZ2Y+OOcyasMXeSsHzIn3Tb/rhgDKkI
         c10GBawmKzQxMRipXa57JUl23rgzsqvDLXbTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IQp7PaFynBiHmKOu2OBCAYH79Xh1QNmxWYCgk0LUVrA=;
        b=UBUiYd3VGedSzc8vs0O5sOGyiSZZ5zyt2B701OrI028fQU+I/VZhPh+XoX97kxXBh/
         g5Cw3Mogi63KTu71hIxQbn3SB8qN0l/RL/Y8Q/tcaZlckTjnKqCegcM0lopDX13HXsMR
         NO2DEqaHhrGRlMLify/93aX0DKDog2DQLSrbZW1+q5H6e+fAeWyZL70qAuH3NwItD7AK
         Plfso2YU7beCCeJwzDL1WDHhawrH+pUS6nyo6rM5GtoPViDIW71Wxl6TURm705k+65uH
         7Ykp5m3WInHiCAD/klSOkqIfT6TzXUl2zwbldm19W1FxXR65JIAxcx0WV9zuU/0dyFNa
         xyxA==
X-Gm-Message-State: AOAM5325j5Txj8F1qY87EAO6JGQ2xNb+mCrxqYccOjU08rM7CqJuyjQF
        Tx3khEgqqBpo/yAJozxYHRSES90StCwNZMiOoRvEGw==
X-Google-Smtp-Source: ABdhPJwfOtKkd8/zHPbpHffp2qZss/tg5sQmgbCDcfGFDmNlqG3WYmrqkK5+TGrD1Hp1Iwez+/FLjYDCUj50hlEhXtw=
X-Received: by 2002:ac2:4351:: with SMTP id o17mr13365873lfl.103.1595913966471;
 Mon, 27 Jul 2020 22:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <1595847753-2234-1-git-send-email-moshe@mellanox.com>
In-Reply-To: <1595847753-2234-1-git-send-email-moshe@mellanox.com>
From:   Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Date:   Tue, 28 Jul 2020 10:55:54 +0530
Message-ID: <CAACQVJqNXh0B=oe5W7psiMGc6LzNPujNe2sypWi_SvH5sY=F3Q@mail.gmail.com>
Subject: Re: [PATCH net-next RFC 00/13] Add devlink reload level option
To:     Moshe Shemesh <moshe@mellanox.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 4:36 PM Moshe Shemesh <moshe@mellanox.com> wrote:
>
> Introduce new option on devlink reload API to enable the user to select the
> reload level required. Complete support for all levels in mlx5.
> The following reload levels are supported:
>   driver: Driver entities re-instantiation only.
>   fw_reset: Firmware reset and driver entities re-instantiation.
The Name is a little confusing. I think it should be renamed to
fw_live_reset (in which both firmware and driver entities are
re-instantiated).  For only fw_reset, the driver should not undergo
reset (it requires a driver reload for firmware to undergo reset).

>   fw_live_patch: Firmware live patching only.
This level is not clear. Is this similar to flashing??

Also I have a basic query. The reload command is split into
reload_up/reload_down handlers (Please correct me if this behaviour is
changed with this patchset). What if the vendor specific driver does
not support up/down and needs only a single handler to fire a firmware
reset or firmware live reset command?
>
> Each driver which support this command should expose the reload levels
> supported and the driver's default reload level.
> The uAPI is backward compatible, if the reload level option is omitted
> from the reload command, the driver's default reload level will be used.
>
> Patch 1 adds the new API reload level option to devlink.
> Patch 2 exposes the supported reload levels and default level on devlink
>         dev get.
> Patches 3-8 add support on mlx5 for devlink reload level fw-reset and
>             handle the firmware reset events.
> Patches 9-10 add devlink enable remote dev reset parameter and use it
>              in mlx5.
> Patches 11-12 mlx5 add devlink reload live patch support and event
>               handling.
> Patch 13 adds documentation file devlink-reload.rst
>
> Command examples:
>
> # Run reload command with fw-reset reload level:
> $ devlink dev reload pci/0000:82:00.0 level fw-reset
>
> # Run reload command with driver reload level:
> $ devlink dev reload pci/0000:82:00.0 level driver
>
> # Run reload command with driver's default level (backward compatible):
> $ devlink dev reload pci/0000:82:00.0
>
>
> Moshe Shemesh (13):
>   devlink: Add reload level option to devlink reload command
>   devlink: Add reload levels data to dev get
>   net/mlx5: Add functions to set/query MFRL register
>   net/mlx5: Set cap for pci sync for fw update event
>   net/mlx5: Handle sync reset request event
>   net/mlx5: Handle sync reset now event
>   net/mlx5: Handle sync reset abort event
>   net/mlx5: Add support for devlink reload level fw reset
>   devlink: Add enable_remote_dev_reset generic parameter
>   net/mlx5: Add devlink param enable_remote_dev_reset support
>   net/mlx5: Add support for fw live patch event
>   net/mlx5: Add support for devlink reload level live patch
>   devlink: Add Documentation/networking/devlink/devlink-reload.rst
>
>  .../networking/devlink/devlink-params.rst     |   6 +
>  .../networking/devlink/devlink-reload.rst     |  56 +++
>  Documentation/networking/devlink/index.rst    |   1 +
>  drivers/net/ethernet/mellanox/mlx4/main.c     |   6 +-
>  .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
>  .../net/ethernet/mellanox/mlx5/core/devlink.c | 114 +++++-
>  .../mellanox/mlx5/core/diag/fw_tracer.c       |  31 ++
>  .../mellanox/mlx5/core/diag/fw_tracer.h       |   1 +
>  .../ethernet/mellanox/mlx5/core/fw_reset.c    | 328 ++++++++++++++++++
>  .../ethernet/mellanox/mlx5/core/fw_reset.h    |  17 +
>  .../net/ethernet/mellanox/mlx5/core/health.c  |  74 +++-
>  .../net/ethernet/mellanox/mlx5/core/main.c    |  13 +
>  drivers/net/ethernet/mellanox/mlxsw/core.c    |   6 +-
>  drivers/net/netdevsim/dev.c                   |   6 +-
>  include/linux/mlx5/device.h                   |   1 +
>  include/linux/mlx5/driver.h                   |  12 +
>  include/net/devlink.h                         |  10 +-
>  include/uapi/linux/devlink.h                  |  22 ++
>  net/core/devlink.c                            |  95 ++++-
>  19 files changed, 764 insertions(+), 37 deletions(-)
>  create mode 100644 Documentation/networking/devlink/devlink-reload.rst
>  create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
>  create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h
>
> --
> 2.17.1
>
