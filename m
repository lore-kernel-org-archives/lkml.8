Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E17C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CE95208C7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599062237;
	bh=di7oB6z89bc0JJQJfIcyG++9jmlU3N16jB15jFiLFGA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=M4ROuh19gdNltQCE7GSqKoEnrKg3pyC6BD3+ofFoDe+ulY6ec+KBNNgyLNwTWRTJp
	 s1aH0NG/szo50bTRXTpMwE5J2PNLyHrPxA0irbl3c+fUTBIj3gT2i9E0ZADDJvebxJ
	 iGZGrFbZ/Sz9k02HyciRz+TwAEgFwtBMLbzmD3so=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgIBP5Q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:57:16 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41209 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgIBP5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:57:13 -0400
Received: by mail-oi1-f195.google.com with SMTP id 2so4817882ois.8;
        Wed, 02 Sep 2020 08:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9DEmVUjPTyBKjnvLO+wWE+XjYNvSuVDxJTujI+Ajagc=;
        b=tah/q2vZSU9oxJGcPFUN5fLabRgqZl8zP6NJUTySpXfPW61JTp4ilmA/aAM56B5vxh
         Zhgl2mqe0Nh8Zo624Y6D0/AIm40SJMW7XWwFItqlJ3EELZj56utzFsG3X53Jt8TGdjh1
         fuW3QYQVTPhYTw+WcKn/tOobIeFzXT/xU1J/L1U1ecISDz6eJm4aNkkYrHGqWUMKCq+M
         yohjfgZdh/TadwE2MGUuyJ0E9rO13yzd6H+yF0ltZL2xo1/L/itpSGW0R4dV48/eh/yL
         hc3gvcyE6QAWx5IFnqvK8KOTWqTo1bxgQkyo1Oyc4OYx5961g9z/5heeHPuJ+pqWoMdo
         ISsw==
X-Gm-Message-State: AOAM532ISOINb0De+lNwJwIA7zCoPND6PQvYQnvybKEtVNDQWcCYKubZ
        UbD1FSOTz+a+LfOyTokVtasF+v4rDeLv2K0RzXE=
X-Google-Smtp-Source: ABdhPJxISKaKeJir20XopYsr2P5EemHb8bMmTSWmdl+aDQipaSVLQOc5ztTEce5sBNaV5tILpcudk3dJ78Xf43NpMbg=
X-Received: by 2002:aca:fd95:: with SMTP id b143mr2357844oii.68.1599062232602;
 Wed, 02 Sep 2020 08:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200901210333.8462-1-sakari.ailus@linux.intel.com> <20200901210333.8462-7-sakari.ailus@linux.intel.com>
In-Reply-To: <20200901210333.8462-7-sakari.ailus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 2 Sep 2020 17:57:01 +0200
Message-ID: <CAJZ5v0jFceTFRTD55cz3ZHRZpuNRK_z9=_DxWexc8ArsGU3cog@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] Documentation: ACPI: Document allow-low-power-probe
 _DSD property
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-i2c <linux-i2c@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Hyungwoo Yang <hyungwoo.yang@intel.com>,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 1, 2020 at 11:03 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Document the probe-low-power _DSD property and how it is used with I²C
> drivers.

I would reorder the series to make this go right after the [1/6] or
maybe even fold it into that patch.

The point is that the changes in [1/6] clearly depend on the property
defined here.

> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  .../acpi/dsd/allow-low-power-probe.rst        | 28 +++++++++++++++++++
>  Documentation/firmware-guide/acpi/index.rst   |  1 +
>  2 files changed, 29 insertions(+)
>  create mode 100644 Documentation/firmware-guide/acpi/dsd/allow-low-power-probe.rst
>
> diff --git a/Documentation/firmware-guide/acpi/dsd/allow-low-power-probe.rst b/Documentation/firmware-guide/acpi/dsd/allow-low-power-probe.rst
> new file mode 100644
> index 0000000000000..6fcc89162b898
> --- /dev/null
> +++ b/Documentation/firmware-guide/acpi/dsd/allow-low-power-probe.rst
> @@ -0,0 +1,28 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +======================================
> +Probing I²C devices in low power state
> +======================================
> +
> +Introduction
> +============
> +
> +In some cases it may be preferred to leave certain devices powered off for the
> +entire system bootup if powering on these devices has adverse side effects,
> +beyond just powering on the said device. Linux recognizes the _DSD property
> +"allow-low-power-probe" that can be used for this purpose.

It would be good to refer to the document defining the generic _DSD
properties mechanism and the GUID used for that from here.

The meaning of  "_DSD property" may not be entirely clear to the
reader as it stands.

And maybe call the property "i2c-allow-low-power-probe" or similar, to
indicate that it is specific to i2c.

> +
> +How it works
> +============
> +
> +The property "allow-low-power-probe" boolean property may be used to tell Linux

"boolean device property" ?

> +that the I²C framework should instruct the kernel ACPI framework to leave the
> +device in the low power state. If the driver indicates its support for this by
> +setting the I2C_DRV_FL_ALLOW_LOW_POWER_PROBE flag in struct i2c_driver.flags
> +field and the "allow-low-power-probe" property is present, the device will not
> +be powered on for probe.
> +
> +The downside is that as the device is not powered on, even if there's a problem
> +with the device, the driver likely probes just fine but the first user will
> +find out the device doesn't work, instead of a failure at probe time. This
> +feature should thus be used sparingly.

It would be good to give an ASL example with this property provided.

> diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
> index ad3b5afdae77e..0070fcde9e669 100644
> --- a/Documentation/firmware-guide/acpi/index.rst
> +++ b/Documentation/firmware-guide/acpi/index.rst
> @@ -11,6 +11,7 @@ ACPI Support
>     dsd/graph
>     dsd/data-node-references
>     dsd/leds
> +   dsd/allow-low-power-probe
>     enumeration
>     osi
>     method-customizing
> --
