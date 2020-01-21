Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27DBC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 21:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0CF24125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 21:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g30stGNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgAUVq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 16:46:56 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:53727 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbgAUVq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 16:46:56 -0500
Received: by mail-pj1-f68.google.com with SMTP id n96so2021483pjc.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 13:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fDebCTy0hik3MCAYelFozwWXYlboP6WEdTNaFFOa6Qo=;
        b=g30stGNcYAYejmqPX3QGMvQRcfFYude+JWw8giSfr6OiDPS6RgCMxeYyWrOWHq+hN7
         G4T+QgKQlJFRyXr3XKP0PnoLjzJDYv+5Tg4NQTTY0Dwa9Zys5wjgljyCNrYPFRaUA+Lt
         Cyz8+3gjAdpNq9jmtNj/snkr5YrjKsYZ2TCu1bdIO0DKEIF8nBiHFKXVhfJRSSxrmqDp
         UP/U2g8PnSouPfx41wGqUEfyTlnT5Yh8zAEKEUGlRYAXP1I4SC15d0zuQS59s4mxIt/Q
         6ksTVAjlWU/9BtaQ6Bc6A99czuhN10EKxoTSVovJIoQdPdD4KoXnwA7zqqeo2Nz2snro
         y5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fDebCTy0hik3MCAYelFozwWXYlboP6WEdTNaFFOa6Qo=;
        b=qIm6JBhmUU5mv8ERMRwZk9pjH/6WjQ+gV/A507oW/u6pjJxmRqzZPcsufn60CljKlO
         jQIY0X8Ij74kgjjE/CZFmHQmxHbfBSX2sFEK6Gr6KdZmM8HSuMIu6J2BB7vCdySoi38e
         aNGU2Ida6/+8rPXiImM4j1rBv4DEDLoySjz4x5C0zImQ2+QboXAp0fYTAg+pVr/VaMoF
         XjT47ttZPw4WVQi66Q41gg3TUrAl0tuhbcenvPfwKSSy+5D9Dj5hkUzn5ooVe2ftcirJ
         ksnBVmhjbhY01L94Fwhcvg1Tq2bcevy0YE6nsRhw2kV0H3ZZKP4Kxwl2EBnoqYyPt09w
         eOXg==
X-Gm-Message-State: APjAAAXbV+g4d2yAs468JH4ZL5k2NjnuaLOQWj8T+o9gXND6lUgfW7TE
        0WURqKkHn8qdXwzkh093/Jdgqg==
X-Google-Smtp-Source: APXvYqzL17T1P75u/Pe+CI1aCwnfHfGPivOy1oNvEdfupTQflxd5O9q6b7QrC7Bu4Lhgfa9EcF1OlA==
X-Received: by 2002:a17:902:302:: with SMTP id 2mr7725527pld.58.1579643215103;
        Tue, 21 Jan 2020 13:46:55 -0800 (PST)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id d20sm406338pjs.2.2020.01.21.13.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 13:46:54 -0800 (PST)
Date:   Tue, 21 Jan 2020 13:46:49 -0800
From:   Benson Leung <bleung@google.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, bleung@chromium.org, dtor@chromium.org,
        gwendal@chromium.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v2] platform/chrome: cros_ec: Match implementation with
 headers
Message-ID: <20200121214649.GA31808@google.com>
References: <20200117144356.247696-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <20200117144356.247696-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Enric!

Thanks for V2!

On Fri, Jan 17, 2020 at 03:43:56PM +0100, Enric Balletbo i Serra wrote:
> The 'cros_ec' core driver is the common interface for the cros_ec
> transport drivers to do the shared operations to register, unregister,
> suspend and resume. The interface is provided by including the header
> 'include/linux/platform_data/cros_ec_proto.h', however, instead of have
> the implementation of these functions in cros_ec_proto.c, it is in
> 'cros_ec.c', which is a different kernel module. Apart from being a bad
> practice, this can induce confusions allowing the users of the cros_ec
> protocol to call these functions.
>=20
> The register, unregister, suspend and resume functions *should* only be
> called by the different transport drivers (i2c, spi, lpc, etc.), so make
> this a bit less confusing by moving these functions from the public
> in-kernel space to a private include in platform/chrome, and then, the
> interface for cros_ec module and for the cros_ec_proto module is clean.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>=20
> Changes in v2:
> - Mention that moves cros_ec_handle_event in commit description (Benson L=
=2E)

Doesn't look like v2 has any commit message change. Could you double check?

> - Update copyright to 2020 (Benson L.)
> - Do not move EC_REBOOT_DELAY_MS (Benson L.)
>=20
>  drivers/platform/chrome/cros_ec.c           |  2 ++
>  drivers/platform/chrome/cros_ec.h           | 19 +++++++++++++++++++
>  drivers/platform/chrome/cros_ec_i2c.c       |  2 ++
>  drivers/platform/chrome/cros_ec_ishtp.c     |  2 ++
>  drivers/platform/chrome/cros_ec_lpc.c       |  1 +
>  drivers/platform/chrome/cros_ec_rpmsg.c     |  2 ++
>  drivers/platform/chrome/cros_ec_spi.c       |  2 ++
>  include/linux/platform_data/cros_ec_proto.h | 12 +-----------
>  8 files changed, 31 insertions(+), 11 deletions(-)
>  create mode 100644 drivers/platform/chrome/cros_ec.h
>=20
> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/=
cros_ec.c
> index 6d6ce86a1408..65c3207d2d90 100644
> --- a/drivers/platform/chrome/cros_ec.c
> +++ b/drivers/platform/chrome/cros_ec.c
> @@ -18,6 +18,8 @@
>  #include <linux/suspend.h>
>  #include <asm/unaligned.h>
> =20
> +#include "cros_ec.h"
> +
>  #define CROS_EC_DEV_EC_INDEX 0
>  #define CROS_EC_DEV_PD_INDEX 1
> =20
> diff --git a/drivers/platform/chrome/cros_ec.h b/drivers/platform/chrome/=
cros_ec.h
> new file mode 100644
> index 000000000000..e69fc1ff68b4
> --- /dev/null
> +++ b/drivers/platform/chrome/cros_ec.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * ChromeOS Embedded Controller core interface.
> + *
> + * Copyright (C) 2020 Google LLC
> + */
> +
> +#ifndef __CROS_EC_H
> +#define __CROS_EC_H
> +
> +int cros_ec_register(struct cros_ec_device *ec_dev);
> +int cros_ec_unregister(struct cros_ec_device *ec_dev);
> +
> +int cros_ec_suspend(struct cros_ec_device *ec_dev);
> +int cros_ec_resume(struct cros_ec_device *ec_dev);
> +
> +bool cros_ec_handle_event(struct cros_ec_device *ec_dev);
> +
> +#endif /* __CROS_EC_H */
> diff --git a/drivers/platform/chrome/cros_ec_i2c.c b/drivers/platform/chr=
ome/cros_ec_i2c.c
> index 9bd97bc8454b..6119eccd8a18 100644
> --- a/drivers/platform/chrome/cros_ec_i2c.c
> +++ b/drivers/platform/chrome/cros_ec_i2c.c
> @@ -14,6 +14,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> =20
> +#include "cros_ec.h"
> +
>  /**
>   * Request format for protocol v3
>   * byte 0	0xda (EC_COMMAND_PROTOCOL_3)
> diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/c=
hrome/cros_ec_ishtp.c
> index e5996821d08b..e1fdb491a9a7 100644
> --- a/drivers/platform/chrome/cros_ec_ishtp.c
> +++ b/drivers/platform/chrome/cros_ec_ishtp.c
> @@ -14,6 +14,8 @@
>  #include <linux/platform_data/cros_ec_proto.h>
>  #include <linux/intel-ish-client-if.h>
> =20
> +#include "cros_ec.h"
> +
>  /*
>   * ISH TX/RX ring buffer pool size
>   *
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chr=
ome/cros_ec_lpc.c
> index dccf479c6625..3e8ddd84bc41 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -23,6 +23,7 @@
>  #include <linux/printk.h>
>  #include <linux/suspend.h>
> =20
> +#include "cros_ec.h"
>  #include "cros_ec_lpc_mec.h"
> =20
>  #define DRV_NAME "cros_ec_lpcs"
> diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/c=
hrome/cros_ec_rpmsg.c
> index bd068afe43b5..dbc3f5523b83 100644
> --- a/drivers/platform/chrome/cros_ec_rpmsg.c
> +++ b/drivers/platform/chrome/cros_ec_rpmsg.c
> @@ -13,6 +13,8 @@
>  #include <linux/rpmsg.h>
>  #include <linux/slab.h>
> =20
> +#include "cros_ec.h"
> +
>  #define EC_MSG_TIMEOUT_MS	200
>  #define HOST_COMMAND_MARK	1
>  #define HOST_EVENT_MARK		2
> diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chr=
ome/cros_ec_spi.c
> index a831bd5a5b2f..46786d2d679a 100644
> --- a/drivers/platform/chrome/cros_ec_spi.c
> +++ b/drivers/platform/chrome/cros_ec_spi.c
> @@ -14,6 +14,8 @@
>  #include <linux/spi/spi.h>
>  #include <uapi/linux/sched/types.h>
> =20
> +#include "cros_ec.h"
> +
>  /* The header byte, which follows the preamble */
>  #define EC_MSG_HEADER			0xec
> =20
> diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/=
platform_data/cros_ec_proto.h
> index 119b9951c055..35051da5a2fa 100644
> --- a/include/linux/platform_data/cros_ec_proto.h
> +++ b/include/linux/platform_data/cros_ec_proto.h
> @@ -25,7 +25,7 @@
>   * The EC is unresponsive for a time after a reboot command.  Add a
>   * simple delay to make sure that the bus stays locked.
>   */
> -#define EC_REBOOT_DELAY_MS		50
> +#define EC_REBOOT_DELAY_MS	50

Looks like you put this back, but made a whitespace change in the process.
Remove this diff, please!

> =20
>  /*
>   * Max bus-specific overhead incurred by request/responses.
> @@ -206,10 +206,6 @@ struct cros_ec_dev {
> =20
>  #define to_cros_ec_dev(dev)  container_of(dev, struct cros_ec_dev, class=
_dev)
> =20
> -int cros_ec_suspend(struct cros_ec_device *ec_dev);
> -
> -int cros_ec_resume(struct cros_ec_device *ec_dev);
> -
>  int cros_ec_prepare_tx(struct cros_ec_device *ec_dev,
>  		       struct cros_ec_command *msg);
> =20
> @@ -222,10 +218,6 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
>  int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
>  			    struct cros_ec_command *msg);
> =20
> -int cros_ec_register(struct cros_ec_device *ec_dev);
> -
> -int cros_ec_unregister(struct cros_ec_device *ec_dev);
> -
>  int cros_ec_query_all(struct cros_ec_device *ec_dev);
> =20
>  int cros_ec_get_next_event(struct cros_ec_device *ec_dev,
> @@ -238,8 +230,6 @@ int cros_ec_check_features(struct cros_ec_dev *ec, in=
t feature);
> =20
>  int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
> =20
> -bool cros_ec_handle_event(struct cros_ec_device *ec_dev);
> -
>  /**
>   * cros_ec_get_time_ns() - Return time in ns.
>   *
> --=20
> 2.24.1
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXidxSQAKCRBzbaomhzOw
wjC1AQDnEJ6K9Ja0wqK6V7PX5Abmn46YyRJ23CyrmTWIff8TtAD/bw4MThtt52XY
w2IBXai6TJyIfWemnUC2mE6D/cQ9nwU=
=YlGN
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
