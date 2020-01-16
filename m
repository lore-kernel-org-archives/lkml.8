Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE2DC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 20:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70DC20663
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 20:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="il+uX7ct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387511AbgAPUMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 15:12:13 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35835 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730031AbgAPUMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 15:12:10 -0500
Received: by mail-pg1-f194.google.com with SMTP id l24so10464208pgk.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 12:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6J6Nc5ckDiDXa+2kUuoaoERkijlEiyl14mk6r9DI/r4=;
        b=il+uX7ctaW0X4oV7wVZmOeXa38f+NsrzJ3oIEJQs9pyD2xFA2xUgGuuyDJDXeotVuR
         ErD3IkuyqfnwU/ypu47lv+XFoN6tHIDKa7PK2NMtSWgHwOKsAdyvzTIwxjsPrX3M2+qW
         YA2TPkU29XRrqJWPS/B9APr/Nr++fzwz3wOZtmAWYqQgTDFRP8R08YbC4hH45N0LYoIv
         U6IlYROUwbzenbJK6VloMe6PJbHwvvA3mah+letARJpI7LD4B6ew9K1TtQCJODH+YsFD
         tvv+SzItC46/HoVO/xcUj5kd9GA2fwPO9zjXFavbvW2VPGruqGkUZuar8sumvh74CbB7
         7ukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6J6Nc5ckDiDXa+2kUuoaoERkijlEiyl14mk6r9DI/r4=;
        b=l78DVwneDE2wlXWPzjNZFHje7fqhwsYwA1ZVZ/aG6wKd9XqMkR36XBdbKUCcaVigLh
         2s/T9dxnxZ1WythAJ56fGOuF7GWGqDOqOa/R1ACmF+7fw0GVPpnzZtUxO5tLJP8w7YMt
         GbabWaZ80PnHTK2JQWHbqKqA1IfHLJ6rtpSzWRVshbe8vhOKZp67+zet1s0DMs/vNQXD
         cFTKs5Ws//k9bPhjtzsIBaCefxnvWHmHipqCkFYOzK/OFt1Za1ndKuQUU5Lc5/XHoaZP
         9+1oRHsWdReVdNp3FkKjppbwuMfK+Hu6EGYthMTkHx/HINUmWmtKBmBjXUvIQsedZsrG
         6Rzw==
X-Gm-Message-State: APjAAAWrAygn1cwi91ukTH+yoHKSq//0hSf4pYwv28oZV+MO+jW9/baG
        4hM2Waustbd4ybrcNTsRKqeTzg==
X-Google-Smtp-Source: APXvYqwhmSa09FzuE/crdLMwuXjVa5mwdfG9E8SQM4dMlQmUd2VHEupHs1k8SakPeZ4umTGmE02VpQ==
X-Received: by 2002:a63:d705:: with SMTP id d5mr40744138pgg.24.1579205529705;
        Thu, 16 Jan 2020 12:12:09 -0800 (PST)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id l21sm26553092pff.100.2020.01.16.12.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 12:12:08 -0800 (PST)
Date:   Thu, 16 Jan 2020 12:12:04 -0800
From:   Benson Leung <bleung@google.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, bleung@chromium.org, dtor@chromium.org,
        gwendal@chromium.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH] platform/chrome: cros_ec: Match implementation with
 headers
Message-ID: <20200116201204.GE208460@google.com>
References: <20191210100645.12138-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X3gaHHMYHkYqP6yf"
Content-Disposition: inline
In-Reply-To: <20191210100645.12138-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X3gaHHMYHkYqP6yf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Enric,

On Tue, Dec 10, 2019 at 11:06:45AM +0100, Enric Balletbo i Serra wrote:
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

Also mention that this moves the cros_ec_handle_event definition too.

> called by the different transport drivers (i2c, spi, lpc, etc.), so make
> this a bit less confusing by moving these functions from the public
> in-kernel space to a private include in platform/chrome, and then, the
> interface for cros_ec module and for the cros_ec_proto module is clean.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>=20
>  drivers/platform/chrome/cros_ec.c           |  2 ++
>  drivers/platform/chrome/cros_ec.h           | 25 +++++++++++++++++++++
>  drivers/platform/chrome/cros_ec_i2c.c       |  2 ++
>  drivers/platform/chrome/cros_ec_ishtp.c     |  2 ++
>  drivers/platform/chrome/cros_ec_lpc.c       |  1 +
>  drivers/platform/chrome/cros_ec_rpmsg.c     |  2 ++
>  drivers/platform/chrome/cros_ec_spi.c       |  2 ++
>  include/linux/platform_data/cros_ec_proto.h | 16 -------------
>  8 files changed, 36 insertions(+), 16 deletions(-)
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
> index 000000000000..dc80550f5eaa
> --- /dev/null
> +++ b/drivers/platform/chrome/cros_ec.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * ChromeOS Embedded Controller core interface.
> + *
> + * Copyright (C) 2012 Google, Inc

Set Copyright date to 2020, especially for new file.

> + */
> +
> +#ifndef __CROS_EC_H
> +#define __CROS_EC_H
> +
> +/*
> + * The EC is unresponsive for a time after a reboot command.  Add a
> + * simple delay to make sure that the bus stays locked.
> + */
> +#define EC_REBOOT_DELAY_MS	50
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
> index 119b9951c055..f490e208540a 100644
> --- a/include/linux/platform_data/cros_ec_proto.h
> +++ b/include/linux/platform_data/cros_ec_proto.h
> @@ -21,12 +21,6 @@
>  #define CROS_EC_DEV_SCP_NAME	"cros_scp"
>  #define CROS_EC_DEV_TP_NAME	"cros_tp"
> =20
> -/*
> - * The EC is unresponsive for a time after a reboot command.  Add a
> - * simple delay to make sure that the bus stays locked.
> - */
> -#define EC_REBOOT_DELAY_MS		50
> -

Any reason why this define was moved?

>  /*
>   * Max bus-specific overhead incurred by request/responses.
>   * I2C requires 1 additional byte for requests.
> @@ -206,10 +200,6 @@ struct cros_ec_dev {
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
> @@ -222,10 +212,6 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
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
> @@ -238,8 +224,6 @@ int cros_ec_check_features(struct cros_ec_dev *ec, in=
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
> 2.20.1
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--X3gaHHMYHkYqP6yf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXiDDlAAKCRBzbaomhzOw
wvccAP93CPSSy+I2J/PuIoyga1nkkngYhKUJxU2yznrqozfqwQD+PJmDLiDF5SWF
vo3zC0TaxwQK9uQtt2K7gD7HhovosQ8=
=Tohc
-----END PGP SIGNATURE-----

--X3gaHHMYHkYqP6yf--
