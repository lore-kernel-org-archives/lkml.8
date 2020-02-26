Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EC0C4BA1E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F14D24653
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JhadmEQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgBZS2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:28:19 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:44230 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgBZS2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:28:18 -0500
Received: by mail-ua1-f67.google.com with SMTP id a33so1317481uad.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 10:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tOnWU9Af8Z1M/sr5aPcEIXOq/cdqaGi3s9UAo3FqHhE=;
        b=JhadmEQPiPGecR6QNzOLHR/1PpT4FgW6xODKaYeG03MKADYexhyPl5jQKku1T0BCqT
         iLAD1o4YdPFNP8Mk5W7h2AMRHBVU5LpUn3Go9CpnIg94BRMQUouN//PIx6DLXqZDUkGP
         55D4dSr9AjLSPR5X0gBANKjy2nIDy4oeu0O77djyDbdV/SxoSDTqMyFbxowEpZfo5Dak
         XHZqNixfU0wFEDUWWyqx5pW8lL2GIoV+MVpftVNsGXk0LvFQ/CUumU0odvzSTLTlUY0t
         pNRs0ccIM/mxpnxmouW4wYAe/yERQ9VH5TYhTzH31lrfFDYKGenRv3Jiurrq8Fv1TNT7
         /Xeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tOnWU9Af8Z1M/sr5aPcEIXOq/cdqaGi3s9UAo3FqHhE=;
        b=FdOIh9J7RTBnE0C7PCx7sn1flkFnq7XSYoldaxaGVFkwp2qYUNPkhH0HuNbnxT7IhV
         FWZVw2mDKchde8Rz8tpTmFLLBc63JOnqExHBhi0IrxBrzIr6WEPzFP/Nyz/EtgEMSasO
         MnqcoJ4oGphsxAbcQ/MEvk+cxtorhuSSjh1IIRYR2a+BBhjCIOjZkk37FnFyw3s/2HjQ
         s772BB/ewE1HUezypEfHM2ngg9RrEyvEUjP2V3RSU5FkUYc43gl9qmqyv/m22CAE1cNE
         Z6wMOFzmfb3B8g3KlE/3dAEEPyoUshmY3gJ2H/HOnFOCvhAt1wFb3QTnhx0w1Fx4Gbek
         TRBg==
X-Gm-Message-State: APjAAAVRhE9fzYbSxIN691oDvoq1puyEfY16zr5zSAi+4X7/eRvE13Py
        nQ97miWAJ2VusIm4t0ZxoCWOiS1CND/XpBYtz+Pw9k+iOpk=
X-Google-Smtp-Source: APXvYqw/RNF4Z+/+JTriQGcol2XF33VI/o4ZPCriY3sKTN3fLPOI9/+puJWP3m6DcGbwEQrgC4d5wbreP5MivXH+TpA=
X-Received: by 2002:ab0:7196:: with SMTP id l22mr266698uao.99.1582741696540;
 Wed, 26 Feb 2020 10:28:16 -0800 (PST)
MIME-Version: 1.0
References: <20200226182517.49214-1-badhri@google.com>
In-Reply-To: <20200226182517.49214-1-badhri@google.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Wed, 26 Feb 2020 10:27:40 -0800
Message-ID: <CAPTae5JYx7j=JTkihKCTr35HJCpEyEo2VDKTBpe7ozopKJT=cQ@mail.gmail.com>
Subject: Re: [PATCH v3] usb: typec: Add sysfs node to show cc orientation
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Puma Hsu <pumahsu@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Following up with the initial patch from
Puma(https://lkml.org/lkml/2019/10/15/1317) after
addressing the comments from the previous patches.

Thanks & Regards,
Badhri


On Wed, Feb 26, 2020 at 10:25 AM Badhri Jagan Sridharan
<badhri@google.com> wrote:
>
> Export Type-C orientation information when available.
> - "normal": CC1 orientation
> - "reverse": CC2 orientation
> - "unknown": Orientation cannot be determined.
>
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
> Version history:
> V3:
> - Heikki's suggestion to us .is_visible callback.
>   unsigned int orientation_aware:1 has been introduced to
>   make support of this attribute optional for drivers such
>   as UCSI
> - Guenter's suggestion to rename to "orientation".
> - Heikki's suggestion to stick with string values instead
>   of exposing it as integer values.
> ---
>  Documentation/ABI/testing/sysfs-class-typec |  9 +++++++
>  drivers/usb/typec/class.c                   | 27 +++++++++++++++++++++
>  drivers/usb/typec/tcpm/tcpm.c               |  1 +
>  include/linux/usb/typec.h                   |  1 +
>  4 files changed, 38 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> index 0c2eb26fdc06b..b834671522d6f 100644
> --- a/Documentation/ABI/testing/sysfs-class-typec
> +++ b/Documentation/ABI/testing/sysfs-class-typec
> @@ -108,6 +108,15 @@ Contact:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
>  Description:
>                 Revision number of the supported USB Type-C specification.
>
> +What:          /sys/class/typec/<port>/orientation
> +Date:          February 2020
> +Contact:       Badhri Jagan Sridharan <badhri@google.com>
> +Description:
> +               Indicates the active orientation of the Type-C connector.
> +               Valid values:
> +               - "normal": CC1 orientation
> +               - "reverse": CC2 orientation
> +               - "unknown": Orientation cannot be determined.
>
>  USB Type-C partner devices (eg. /sys/class/typec/port0-partner/)
>
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 12be5bb6d32ca..2524f1571e425 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -1244,6 +1244,26 @@ static ssize_t usb_power_delivery_revision_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(usb_power_delivery_revision);
>
> +static ssize_t orientation_show(struct device *dev,
> +                                  struct device_attribute *attr,
> +                                  char *buf)
> +{
> +       struct typec_port *p = to_typec_port(dev);
> +       enum typec_orientation orientation = typec_get_orientation(p);
> +
> +       switch (orientation) {
> +       case TYPEC_ORIENTATION_NONE:
> +               return sprintf(buf, "%s\n", "unknown");
> +       case TYPEC_ORIENTATION_NORMAL:
> +               return sprintf(buf, "%s\n", "normal");
> +       case TYPEC_ORIENTATION_REVERSE:
> +               return sprintf(buf, "%s\n", "reverse");
> +       default:
> +               return sprintf(buf, "%s\n", "unknown");
> +       }
> +}
> +static DEVICE_ATTR_RO(orientation);
> +
>  static struct attribute *typec_attrs[] = {
>         &dev_attr_data_role.attr,
>         &dev_attr_power_operation_mode.attr,
> @@ -1254,6 +1274,7 @@ static struct attribute *typec_attrs[] = {
>         &dev_attr_usb_typec_revision.attr,
>         &dev_attr_vconn_source.attr,
>         &dev_attr_port_type.attr,
> +       &dev_attr_orientation.attr,
>         NULL,
>  };
>
> @@ -1283,6 +1304,10 @@ static umode_t typec_attr_is_visible(struct kobject *kobj,
>                         return 0;
>                 if (port->cap->type != TYPEC_PORT_DRP)
>                         return 0444;
> +       } else if (attr == &dev_attr_orientation.attr) {
> +               if (port->cap->orientation_aware)
> +                       return 0444;
> +               return 0;
>         }
>
>         return attr->mode;
> @@ -1493,6 +1518,8 @@ int typec_set_orientation(struct typec_port *port,
>         }
>
>         port->orientation = orientation;
> +       sysfs_notify(&port->dev.kobj, NULL, "orientation");
> +       kobject_uevent(&port->dev.kobj, KOBJ_CHANGE);
>
>         return 0;
>  }
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 78077c234ef27..bc0032a6b9a14 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4742,6 +4742,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>         port->typec_caps.pd_revision = 0x0300;  /* USB-PD spec release 3.0 */
>         port->typec_caps.driver_data = port;
>         port->typec_caps.ops = &tcpm_ops;
> +       port->typec_caps.orientation_aware = 1;
>
>         port->partner_desc.identity = &port->partner_ident;
>         port->port_type = port->typec_caps.type;
> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index 44d28387ced48..b00a2642a9cd6 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -211,6 +211,7 @@ struct typec_capability {
>         u16                     pd_revision; /* 0300H = "3.0" */
>         int                     prefer_role;
>         enum typec_accessory    accessory[TYPEC_MAX_ACCESSORY];
> +       unsigned int            orientation_aware:1;
>
>         struct fwnode_handle    *fwnode;
>         void                    *driver_data;
> --
> 2.25.0.265.gbab2e86ba0-goog
>
