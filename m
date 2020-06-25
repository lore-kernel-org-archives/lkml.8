Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CE0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 07:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CED1320706
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 07:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V0Qm/oHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390013AbgFYHFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 03:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgFYHFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 03:05:42 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A115C061573
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 00:05:41 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id j1so2617897pfe.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 00:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=54XkrBaVyAyTSAQVsK+aaD8/kj0EXr7tvET2IMXpdPY=;
        b=V0Qm/oHHBwPGhvkp2dEnfWtroNUDtkOfZ0oNfrfb/1XLmhnf02kwK/MxXbrwf4Z/vf
         S0Hvz1hpi1y/BbedYGsK7UOQH5BCqKVqJOq5cczDwLu5hsGyNk1c/uIvSXnLzwHQfC+q
         LMYakp0O0pivulqY8qRoBsKQkJZzlwr9LxL0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=54XkrBaVyAyTSAQVsK+aaD8/kj0EXr7tvET2IMXpdPY=;
        b=oIiiP3yNO+L8t2PDb/ZQwTdK8PXY6vlveZOsIxCUJa+xE1lEGbKdtOm6mU9SV05Jpv
         7eux35AQQkpA4T/EXDqglketY/6vRyDuLj1HPW9kmcyCjBWp2UzeXGIMPT+RJZu8G2wG
         DF9kpgpGONT8dZMlNtzMlYcBP91PRXY4INrv0nq/MZ2dl/khWwJt8bfswMJmiW2iAi0B
         UmtRyC0gOJB2xXbsXi2tqlcQHRB45tcZfBaos75KXttWh39h0MrTrmNDznsTrCraBFCP
         dUlwyygwJEzsczbciVCw18djK9+UiKzXdEC3J61X9VTc3KU4swx1hCn1Qxvu071CD20f
         kYOA==
X-Gm-Message-State: AOAM530Mt7irGa4K3qNDVEHBqzfeZD8PObSO06tP9tzPhscyNox0YEwl
        0ATxODd2XfUtTlrFqiUI+DXh2Q==
X-Google-Smtp-Source: ABdhPJwQX0D/dqpL66/VoKYKOaMgFBqlg9FWZQGW8JNr3ynXt5dt+gGgua1bavVuMlXSj5Me4+UFXg==
X-Received: by 2002:a62:1c46:: with SMTP id c67mr32024426pfc.170.1593068740399;
        Thu, 25 Jun 2020 00:05:40 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id s188sm21646684pfb.118.2020.06.25.00.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 00:05:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200407082923.2001556-2-patrick.rudolph@9elements.com>
References: <20200407082923.2001556-1-patrick.rudolph@9elements.com> <20200407082923.2001556-2-patrick.rudolph@9elements.com>
Subject: Re: [PATCH v4 1/2] firmware: google: Expose CBMEM over sysfs
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     coreboot@coreboot.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Julius Werner <jwerner@chromium.org>,
        Samuel Holland <samuel@sholland.org>
To:     linux-kernel@vger.kernel.org, patrick.rudolph@9elements.com
Date:   Thu, 25 Jun 2020 00:05:38 -0700
Message-ID: <159306873839.62212.9311861115757727633@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting patrick.rudolph@9elements.com (2020-04-07 01:29:06)
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>=20
> Make all CBMEM buffers available to userland. This is useful for tools
> that are currently using /dev/mem.
>=20
> Make the id, size and address available, as well as the raw table data.
>=20
> Tools can easily scan the right CBMEM buffer by reading
> /sys/bus/coreboot/drivers/cbmem/coreboot*/cbmem_attributes/id
> or
> /sys/bus/coreboot/devices/coreboot*/cbmem_attributes/id
>=20
> The binary table data can then be read from
> /sys/bus/coreboot/drivers/cbmem/coreboot*/cbmem_attributes/data
> or
> /sys/bus/coreboot/devices/coreboot*/cbmem_attributes/data
>=20
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---

Sorry, this fell off my radar. Looks close though so please resend.

> diff --git a/Documentation/ABI/stable/sysfs-bus-coreboot b/Documentation/=
ABI/stable/sysfs-bus-coreboot
> new file mode 100644
> index 000000000000..6055906f41f2
> --- /dev/null
> +++ b/Documentation/ABI/stable/sysfs-bus-coreboot
> @@ -0,0 +1,44 @@
> +What:          /sys/bus/coreboot/devices/.../cbmem_attributes/id
> +Date:          Apr 2020
> +KernelVersion: 5.6
> +Contact:       Patrick Rudolph <patrick.rudolph@9elements.com>
> +Description:
> +               coreboot device directory can contain a file named
> +               cbmem_attributes/id if the device corresponds to a CBMEM
> +               buffer.
> +               The file holds an ASCII representation of the CBMEM ID in=
 hex
> +               (e.g. 0xdeadbeef).
> +
> +What:          /sys/bus/coreboot/devices/.../cbmem_attributes/size
> +Date:          Apr 2020
> +KernelVersion: 5.6
> +Contact:       Patrick Rudolph <patrick.rudolph@9elements.com>
> +Description:
> +               coreboot device directory can contain a file named
> +               cbmem_attributes/size if the device corresponds to a CBMEM
> +               buffer.
> +               The file holds an representation as decimal number of the
> +               CBMEM buffer size (e.g. 64).
> +
> +What:          /sys/bus/coreboot/devices/.../cbmem_attributes/address
> +Date:          Apr 2020
> +KernelVersion: 5.6
> +Contact:       Patrick Rudolph <patrick.rudolph@9elements.com>
> +Description:
> +               coreboot device directory can contain a file named
> +               cbmem_attributes/address if the device corresponds to a C=
BMEM
> +               buffer.
> +               The file holds an ASCII representation of the physical ad=
dress
> +               of the CBMEM buffer in hex (e.g. 0x000000008000d000) and =
should
> +               be used for debugging only.

If this is for debugging purposes only perhaps it should go into
debugfs. We try to not leak information about physical addresses to
userspace and this would let an attacker understand where memory may be.
That's not ideal and should be avoided.

> +
> +What:          /sys/bus/coreboot/devices/.../cbmem_attributes/data
> +Date:          Apr 2020
> +KernelVersion: 5.6
> +Contact:       Patrick Rudolph <patrick.rudolph@9elements.com>
> +Description:
> +               coreboot device directory can contain a file named
> +               cbmem_attributes/data if the device corresponds to a CBMEM
> +               buffer.
> +               The file holds a read-only binary representation of the C=
BMEM
> +               buffer.
> diff --git a/drivers/firmware/google/cbmem-coreboot.c b/drivers/firmware/=
google/cbmem-coreboot.c
> new file mode 100644
> index 000000000000..f76704a6eec7
> --- /dev/null
> +++ b/drivers/firmware/google/cbmem-coreboot.c
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * cbmem-coreboot.c
> + *
> + * Exports CBMEM as attributes in sysfs.
> + *
> + * Copyright 2012-2013 David Herrmann <dh.herrmann@gmail.com>
> + * Copyright 2017 Google Inc.
> + * Copyright 2019 9elements Agency GmbH
> + */
> +
[..]
> +       &bin_attr_data,
> +       NULL
> +};
> +
> +static const struct attribute_group cb_mem_attr_group =3D {
> +       .name =3D "cbmem_attributes",
> +       .attrs =3D cb_mem_attrs,
> +       .bin_attrs =3D cb_mem_bin_attrs,
> +};
> +
> +static const struct attribute_group *attribute_groups[] =3D {
> +       &cb_mem_attr_group,
> +       NULL,

Nitpick: Drop the comma on sentinel so nothing can come after lest a
compile error happens.

> +};
> +
> +static int cbmem_probe(struct coreboot_device *cdev)
> +{
> +       struct device *dev =3D &cdev->dev;
> +       struct cb_priv *priv;
> +
> +       priv =3D devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       memcpy(&priv->entry, &cdev->cbmem_entry, sizeof(priv->entry));
> +
> +       dev_set_drvdata(dev, priv);

Agreed, avoid the memcpy().

> +
> +       return 0;
> +}
