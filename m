Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBC7C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10DE20719
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YVl+ztN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgCRRnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:43:13 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43871 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgCRRnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:43:09 -0400
Received: by mail-pl1-f194.google.com with SMTP id f8so11484388plt.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8KNatPg9fDsNkes9p9h39y/qD8NdjIoU+LxXc8m/Vjo=;
        b=YVl+ztN95jehslTerOr2LfRpQtOqX1omMH5RD7UIH2+3//BBHRoxIaBcDR19JBZO2b
         Q9dB2A41wndWyQP2tHgVDSft47pz1KJuKuqOp9Zm7AB9wl3xBjSYAIO19tSHmpzWQLjh
         0YztDbf+gPlXg+IjK/7MLD9X8XwyGBYyI4cPE6H+ze6CVOUBUbe+7fgP4z0UdQXlS78e
         VMyMCzIDeuUr6BBuzH9+0sRt3ckOG4H6uPZVRtgXmeIO4imSSP/Ci3QfzIFtWk7WBAKj
         5zIrSy6UUUVIcptZiy55j1XC9ICCOkS4kFWamphzvmBPZF/0KpdfmFi+VmYuQTdTGqwB
         bREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8KNatPg9fDsNkes9p9h39y/qD8NdjIoU+LxXc8m/Vjo=;
        b=ITR6vbn5oIzsByLK2vv854eEuFLj6NSxxGY1YDKmuLd6kTs7MiLzKZaTxFZ7edxtKc
         NxTfheb7ww60G6es8wUz5ZkeWEbOyZpoiclxyrYWvk66Dn+2R4tCJylZeEHVIRZ2UNOL
         kyh/KYt5QGNJtgrM5qb/Jn55wkmz3glP0rl8RiYb+afqwXKP5lvCz/jfv6dD/OpOzRdk
         /dqIrlmI1LqsaZvao4x5qqXzhdCpO7CFn9kgd9aqv09vP1VvJZ1SDkutodkiq8pE+O8l
         mnQAocbZR7Z7NyUX4gyfH5SNEUoq7GYTBZM3G5VKka8+fDTK0I2vOhpJjRcE+Uc7N8Ei
         cyxw==
X-Gm-Message-State: ANhLgQ23tCAiYOXFF1mPvTHS5beIyKlLLsobCsbA5qsj55ZgYJohPpLi
        bdKg50pEu1Ar6ErehTe+NJT5aw==
X-Google-Smtp-Source: ADFU+vuEXmQ1TR70dZ24sJGyRQwp5h4CfxBrWG/G+RBtGuMckiQMOZYlt4wVbUvQtUvybSNyfizgcw==
X-Received: by 2002:a17:902:eb11:: with SMTP id l17mr4758237plb.52.1584553387964;
        Wed, 18 Mar 2020 10:43:07 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id kb18sm3594169pjb.14.2020.03.18.10.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:43:07 -0700 (PDT)
Date:   Wed, 18 Mar 2020 10:43:02 -0700
From:   Benson Leung <bleung@google.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 2/4] platform/chrome: Add Type C connector class driver
Message-ID: <20200318174302.GA137510@google.com>
References: <20200316090021.52148-1-pmalani@chromium.org>
 <20200316090021.52148-3-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <20200316090021.52148-3-pmalani@chromium.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Prashant,

On Mon, Mar 16, 2020 at 02:00:17AM -0700, Prashant Malani wrote:
> Add a driver to implement the Type C connector class for Chrome OS
> devices with ECs (Embedded Controllers).
>=20
> The driver relies on firmware device specifications for various port
> attributes. On ACPI platforms, this is specified using the logical
> device with HID GOOG0014. On DT platforms, this is specified using the
> DT node with compatible string "google,cros-ec-typec".
>=20
> The driver reads the device FW node and uses the port attributes to
> register the typec ports with the Type C connector class framework, but
> doesn't do much else.
>=20
> Subsequent patches will add more functionality to the driver, including
> obtaining current port information (polarity, vconn role, current power
> role etc.) after querying the EC.
>=20
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Thanks for posting this. For my bit:
Co-developed-by: Benson Leung <bleung@chromium.org>

> ---
>=20
> Changes in v5:
> - Added Reviewed-by tag which was missed in earlier version.
>=20
> Changes in v4:
> - Added Reviewed-by tag from previous review cycle
> - Added code to store port caps within the Cros EC type C data structure
> - Added code to use reg to get the port-number in DT platforms.
>=20
> Changes in v3:
> - Fixed minor spacing nits, and moved a modification to probe() if check
>   from later patch to here instead.
>=20
> Changes in v2:
> - Updated Kconfig to default to MFD_CROS_EC_DEV.
> - Fixed code comments.
> - Moved get_num_ports() code into probe().
> - Added module author.
>=20
>  drivers/platform/chrome/Kconfig         |  11 ++
>  drivers/platform/chrome/Makefile        |   1 +
>  drivers/platform/chrome/cros_ec_typec.c | 238 ++++++++++++++++++++++++
>  3 files changed, 250 insertions(+)
>  create mode 100644 drivers/platform/chrome/cros_ec_typec.c
>=20
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kc=
onfig
> index 5f57282a28da0..2320a4f0d9301 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -214,6 +214,17 @@ config CROS_EC_SYSFS
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called cros_ec_sysfs.
> =20
> +config CROS_EC_TYPEC
> +	tristate "ChromeOS EC Type-C Connector Control"
> +	depends on MFD_CROS_EC_DEV && TYPEC
> +	default MFD_CROS_EC_DEV
> +	help
> +	  If you say Y here, you get support for accessing Type C connector
> +	  information from the Chrome OS EC.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called cros_ec_typec.
> +
>  config CROS_USBPD_LOGGER
>  	tristate "Logging driver for USB PD charger"
>  	depends on CHARGER_CROS_USBPD
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/M=
akefile
> index aacd5920d8a18..caf2a9cdb5e6d 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_CROS_EC_ISHTP)		+=3D cros_ec_ishtp.o
>  obj-$(CONFIG_CROS_EC_RPMSG)		+=3D cros_ec_rpmsg.o
>  obj-$(CONFIG_CROS_EC_SPI)		+=3D cros_ec_spi.o
>  cros_ec_lpcs-objs			:=3D cros_ec_lpc.o cros_ec_lpc_mec.o
> +obj-$(CONFIG_CROS_EC_TYPEC)		+=3D cros_ec_typec.o
>  obj-$(CONFIG_CROS_EC_LPC)		+=3D cros_ec_lpcs.o
>  obj-$(CONFIG_CROS_EC_PROTO)		+=3D cros_ec_proto.o cros_ec_trace.o
>  obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)	+=3D cros_kbd_led_backlight.o
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/c=
hrome/cros_ec_typec.c
> new file mode 100644
> index 0000000000000..02e6d5cbbbf7a
> --- /dev/null
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -0,0 +1,238 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2020 Google LLC
> + *
> + * This driver provides the ability to view and manage Type C ports thro=
ugh the
> + * Chrome OS EC.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_data/cros_ec_commands.h>
> +#include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/platform_device.h>
> +#include <linux/usb/typec.h>
> +
> +#define DRV_NAME "cros-ec-typec"
> +
> +/* Platform-specific data for the Chrome OS EC Type C controller. */
> +struct cros_typec_data {
> +	struct device *dev;
> +	struct cros_ec_device *ec;
> +	int num_ports;
> +	/* Array of ports, indexed by port number. */
> +	struct typec_port *ports[EC_USB_PD_MAX_PORTS];
> +	/* Initial capabilities for each port. */
> +	struct typec_capability *caps[EC_USB_PD_MAX_PORTS];
> +};
> +
> +static int cros_typec_parse_port_props(struct typec_capability *cap,
> +				       struct fwnode_handle *fwnode,
> +				       struct device *dev)
> +{
> +	const char *buf;
> +	int ret;
> +
> +	memset(cap, 0, sizeof(*cap));
> +	ret =3D fwnode_property_read_string(fwnode, "power-role", &buf);
> +	if (ret) {
> +		dev_err(dev, "power-role not found: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D typec_find_port_power_role(buf);
> +	if (ret < 0)
> +		return ret;
> +	cap->type =3D ret;
> +
> +	ret =3D fwnode_property_read_string(fwnode, "data-role", &buf);
> +	if (ret) {
> +		dev_err(dev, "data-role not found: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D typec_find_port_data_role(buf);
> +	if (ret < 0)
> +		return ret;
> +	cap->data =3D ret;
> +
> +	ret =3D fwnode_property_read_string(fwnode, "try-power-role", &buf);
> +	if (ret) {
> +		dev_err(dev, "try-power-role not found: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D typec_find_power_role(buf);
> +	if (ret < 0)
> +		return ret;
> +	cap->prefer_role =3D ret;
> +
> +	cap->fwnode =3D fwnode;
> +
> +	return 0;
> +}
> +
> +static int cros_typec_init_ports(struct cros_typec_data *typec)
> +{
> +	struct device *dev =3D typec->dev;
> +	struct typec_capability *cap;
> +	struct fwnode_handle *fwnode;
> +	const char *port_prop;
> +	int ret;
> +	int i;
> +	int nports;
> +	u32 port_num =3D 0;
> +
> +	nports =3D device_get_child_node_count(dev);
> +	if (nports =3D=3D 0) {
> +		dev_err(dev, "No port entries found.\n");
> +		return -ENODEV;
> +	}
> +
> +	if (nports > typec->num_ports) {
> +		dev_err(dev, "More ports listed than can be supported.\n");
> +		return -EINVAL;
> +	}
> +
> +	/* DT uses "reg" to specify port number. */
> +	port_prop =3D dev->of_node ? "reg" : "port-number";
> +	device_for_each_child_node(dev, fwnode) {
> +		if (fwnode_property_read_u32(fwnode, port_prop, &port_num)) {
> +			ret =3D -EINVAL;
> +			dev_err(dev, "No port-number for port, aborting.\n");
> +			goto unregister_ports;
> +		}
> +
> +		if (port_num >=3D typec->num_ports) {
> +			dev_err(dev, "Invalid port number.\n");
> +			ret =3D -EINVAL;
> +			goto unregister_ports;
> +		}
> +
> +		dev_dbg(dev, "Registering port %d\n", port_num);
> +
> +		cap =3D devm_kzalloc(dev, sizeof(*cap), GFP_KERNEL);
> +		if (!cap) {
> +			ret =3D -ENOMEM;
> +			goto unregister_ports;
> +		}
> +
> +		typec->caps[port_num] =3D cap;
> +
> +		ret =3D cros_typec_parse_port_props(cap, fwnode, dev);
> +		if (ret < 0)
> +			goto unregister_ports;
> +
> +		typec->ports[port_num] =3D typec_register_port(dev, cap);
> +		if (IS_ERR(typec->ports[port_num])) {
> +			dev_err(dev, "Failed to register port %d\n", port_num);
> +			ret =3D PTR_ERR(typec->ports[port_num]);
> +			goto unregister_ports;
> +		}
> +	}
> +
> +	return 0;
> +
> +unregister_ports:
> +	for (i =3D 0; i < typec->num_ports; i++)
> +		typec_unregister_port(typec->ports[i]);
> +	return ret;
> +}
> +
> +static int cros_typec_ec_command(struct cros_typec_data *typec,
> +				 unsigned int version,
> +				 unsigned int command,
> +				 void *outdata,
> +				 unsigned int outsize,
> +				 void *indata,
> +				 unsigned int insize)
> +{
> +	struct cros_ec_command *msg;
> +	int ret;
> +
> +	msg =3D kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	msg->version =3D version;
> +	msg->command =3D command;
> +	msg->outsize =3D outsize;
> +	msg->insize =3D insize;
> +
> +	if (outsize)
> +		memcpy(msg->data, outdata, outsize);
> +
> +	ret =3D cros_ec_cmd_xfer_status(typec->ec, msg);
> +	if (ret >=3D 0 && insize)
> +		memcpy(indata, msg->data, insize);
> +
> +	kfree(msg);
> +	return ret;
> +}
> +
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id cros_typec_acpi_id[] =3D {
> +	{ "GOOG0014", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, cros_typec_acpi_id);
> +#endif
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id cros_typec_of_match[] =3D {
> +	{ .compatible =3D "google,cros-ec-typec", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, cros_typec_of_match);
> +#endif
> +
> +static int cros_typec_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct cros_typec_data *typec;
> +	struct ec_response_usb_pd_ports resp;
> +	int ret;
> +
> +	typec =3D devm_kzalloc(dev, sizeof(*typec), GFP_KERNEL);
> +	if (!typec)
> +		return -ENOMEM;
> +
> +	typec->dev =3D dev;
> +	typec->ec =3D dev_get_drvdata(pdev->dev.parent);
> +	platform_set_drvdata(pdev, typec);
> +
> +	ret =3D cros_typec_ec_command(typec, 0, EC_CMD_USB_PD_PORTS, NULL, 0,
> +				    &resp, sizeof(resp));
> +	if (ret < 0)
> +		return ret;
> +
> +	typec->num_ports =3D resp.num_ports;
> +	if (typec->num_ports > EC_USB_PD_MAX_PORTS) {
> +		dev_warn(typec->dev,
> +			 "Too many ports reported: %d, limiting to max: %d\n",
> +			 typec->num_ports, EC_USB_PD_MAX_PORTS);
> +		typec->num_ports =3D EC_USB_PD_MAX_PORTS;
> +	}
> +
> +	ret =3D cros_typec_init_ports(typec);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static struct platform_driver cros_typec_driver =3D {
> +	.driver	=3D {
> +		.name =3D DRV_NAME,
> +		.acpi_match_table =3D ACPI_PTR(cros_typec_acpi_id),
> +		.of_match_table =3D of_match_ptr(cros_typec_of_match),
> +	},
> +	.probe =3D cros_typec_probe,
> +};
> +
> +module_platform_driver(cros_typec_driver);
> +
> +MODULE_AUTHOR("Prashant Malani <pmalani@chromium.org>");
> +MODULE_DESCRIPTION("Chrome OS EC Type C control");
> +MODULE_LICENSE("GPL");
> --=20
> 2.25.1.481.gfbce0eb801-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXnJdpgAKCRBzbaomhzOw
wh3uAQDciKeMfcJi1Z+m2nAHqUmVWft/R1c9mINrN6zghxbqoAEAoZFATi4QYZvv
0FPRqI8L07qkTDNm0mIMrEgYV/gAygc=
=DKm/
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
