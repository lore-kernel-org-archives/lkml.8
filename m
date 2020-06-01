Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB93EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94E3C206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=plvision.eu header.i=@plvision.eu header.b="ygKkf2Zn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgFAJDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:03:12 -0400
Received: from mail-eopbgr140127.outbound.protection.outlook.com ([40.107.14.127]:4576
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725290AbgFAJDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:03:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=deb+i6XPF4e8haP0a6BgxFdV29L8Phmjwh7t62mv7vPrSGJYr3Ne/WnFOqX7Y0x/RKI55dxjThm4GELEw2uQ7JEa01UhkUpo8J5azHyiiwPVGHrVjjIYmZgp2cTUL1sMy+0AYuzFroJ9lQ1Scq2AlDE5JGjJgi42A8G3Q6jnxMITsxyeWNQgjqwq5Dw63HIAn05lrfIuxypvNDCJDPssflxwDOkKfiPgnATmqX4Bu9Z4nXjCRhm85YelNJJ3exxVysMkepg8SKfxVIRR5e/zE4hngwz5VlBI6VnhyL8hOoD/FSFdLOVGYv0CL31nKgS+lXUz+r8HzTY79oDCrQKUxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cnTBpNaOkeSzZLo8KHc1Ulu5gAl72+JLR2TUc78S8M=;
 b=bQNJJiRGITgqkeBbFy2hkWonlGtu5LCn6WTM/CmllDVfPmPKi41nN0q1I7LyS+JW6yXamJOvmUJxa0MWQIEDjoW+aMpuSsVF3AoVJ8p1hYByRsKPN7QKRxs4fFMczNZBmWsocM+5X3UvSMUzrZ8UI86Gt23cKPXwNEIkeU7L+W/Nz32/de5BkQCiP9NCIOX9BrMpKIr8hNZhPaWaD4OxZHk7pHEVrJPPPlUEYWIQHvaqFuvSMv+HYUefWyG+e+L3NFe4rmM+egXNbTwnkgF+m7AsNqDdlpZElixBLszypRH8HDJxJV6B3F4T2MGGJs/wMRFhbtnJ0oGsKEg7hJsBjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cnTBpNaOkeSzZLo8KHc1Ulu5gAl72+JLR2TUc78S8M=;
 b=ygKkf2Zn2igp+KiSeF8OoHOkquY56GPr6X30j3qr7/LZB0gZgEKVaoBdjkhPDD85O+JQfBJMsDcfKivizNcAQzKOhKcdG8P5r/iCm8QCfxBxjgsfcolH5fmJv+k8cBt/vMtBjNR9qsTtbz1JmhcCAL9gvkfcC0nphobohhaQsvA=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0399.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:35::10)
 by VI1P190MB0445.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:32::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.22; Mon, 1 Jun
 2020 09:03:07 +0000
Received: from VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 ([fe80::8149:8652:3746:574f]) by VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 ([fe80::8149:8652:3746:574f%7]) with mapi id 15.20.3045.022; Mon, 1 Jun 2020
 09:03:06 +0000
Date:   Mon, 1 Jun 2020 12:03:00 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Taras Chornyi <taras.chornyi@plvision.eu>
Subject: Re: [PATCH v2 2/2] nvmem: add ONIE NVMEM cells support
Message-ID: <20200601090300.GA21928@plvision.eu>
References: <20200529230451.21337-1-vadym.kochan@plvision.eu>
 <20200529230451.21337-3-vadym.kochan@plvision.eu>
 <8a8653c5-b112-4042-cbdf-8498e38d14ee@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a8653c5-b112-4042-cbdf-8498e38d14ee@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: AM0PR04CA0061.eurprd04.prod.outlook.com
 (2603:10a6:208:1::38) To VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:35::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plvision.eu (217.20.186.93) by AM0PR04CA0061.eurprd04.prod.outlook.com (2603:10a6:208:1::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19 via Frontend Transport; Mon, 1 Jun 2020 09:03:06 +0000
X-Originating-IP: [217.20.186.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80e55814-c044-4128-ed41-08d8060a9973
X-MS-TrafficTypeDiagnostic: VI1P190MB0445:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1P190MB04451F965DEE265A2C55AB3C958A0@VI1P190MB0445.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o8ojpjOoWSJi1dS2JYYKmV/NBRDwpFUPouKDuKYp57CCQs+79ph5n9SLuw/fcFhCQcoRTXRu9clQZyXId0GMlcm7lbmJH8Vhod8w0UNv24B2E350ih5bLXzVDaki6TE/CJBY8RUUFn/wuU4sVHHa/8MaWmiZDn4UL76Q5CWapx0idkL1dgGsRaFpf5nC1p7/oi2VRgTI9b2f8tV5LaJ/CAWKTlBczh1DTyGFCxpnN6sNW7iatPxd1HlJwm9WCEqJB+zKNwpNe3Ja54ZeOMfWHJR59c22/JMAL/KVVLgN7HBNCuUN9FSem63t0wCO0zE2eZys7ETBFUgmwoDINNaPCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0399.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(39830400003)(346002)(376002)(366004)(396003)(136003)(8676002)(4326008)(16526019)(5660300002)(186003)(66556008)(66476007)(8936002)(66946007)(6666004)(1076003)(8886007)(316002)(44832011)(54906003)(52116002)(7696005)(6916009)(86362001)(83380400001)(107886003)(26005)(508600001)(2906002)(36756003)(55016002)(53546011)(956004)(2616005)(33656002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Jrj3kSIoR5v6PoyPK2pfRLI6v5a21ouJMMRaMreL3q/nhuo41Bcz4p/MMlMB0v+mS1AuV31H7DZ+OxssZsSnGQEYcAVtbXndpEUVjIHtVECgC89Zf3M4rW9GK0C7WGTJE68k/op/iYXvNJO8X3A6HxQo38ZuYrMxftt+NF1Lj0CnMoRkRA1FKZxibDezaqHEQJaoFtu6XrMiOoWMnhnLh4Kw++teAN0k7t0ny4k5ibLHwHXQzz96zD8Qj1mzHlapvtIOwNO58d1Q7kUuV+6dNK41o2scRT1DV60ikX/ryTWrNCrikb3N4BvzZw7nEVSPHvnxC/gDR6UTgByhPcdJxAZ+9qYRNB1vtL0XWxwtZbnBXTEZwonM5XCyD650qK0Jnix9xnIPSD0G8+WlYaU5yfmz2GeN9le4bMDrsQnAN+WvHFxguaVRo3hDsT6CIzIu9xo054hYUY+IlO/o/2Q7aa+ZpqgQHA7XdIXTTvJvBtQ=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e55814-c044-4128-ed41-08d8060a9973
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 09:03:06.9304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0F/BaPeapjxXarl8U0tkLAFh789LwR8bIp6Pi/NqVxb77JXkdDSFVUkt+8xyqBcMxXUa1NXvcSpTcscrTKcVdLKf4JjbVJVOThL3Og5dC6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P190MB0445
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 01, 2020 at 09:50:52AM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 30/05/2020 00:04, Vadym Kochan wrote:
> > ONIE is a small operating system, pre-installed on bare metal network
> > switches, that provides an environment for automated provisioning.
> > 
> > This system requires that NVMEM (EEPROM) device holds various system
> > information (mac address, platform name, etc) in a special TLV layout.
> > 
> > The driver registers ONIE TLV attributes as NVMEM cells which can be
> > accessed by other platform driver. Also it allows to use
> > of_get_mac_address() to retrieve mac address for the netdev.
> > 
> > Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> > ---
> >   drivers/nvmem/Kconfig      |   9 +
> >   drivers/nvmem/Makefile     |   3 +
> >   drivers/nvmem/onie-cells.c | 332 +++++++++++++++++++++++++++++++++++++
> 
> Is there a reason why Device tree bindings are missing for this driver?
> 
Sorry, I will do this, but I am not sure if even this driver is
conceptually acceptable.

> 
> 
> >   3 files changed, 344 insertions(+)
> >   create mode 100644 drivers/nvmem/onie-cells.c
> > 
> > diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> > index d7b7f6d688e7..dd9298487992 100644
> > --- a/drivers/nvmem/Kconfig
> > +++ b/drivers/nvmem/Kconfig
> > @@ -273,4 +273,13 @@ config SPRD_EFUSE
> >   	  This driver can also be built as a module. If so, the module
> >   	  will be called nvmem-sprd-efuse.
> > +config NVMEM_ONIE_CELLS
> > +	tristate "ONIE TLV cells support"
> > +	help
> > +	  This is a driver to provide cells from ONIE TLV structure stored
> > +	  on NVME device.
> > +
> > +	  This driver can also be built as a module. If so, the module
> > +	  will be called nvmem-onie-cells.
> > +
> >   endif
> > diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> > index a7c377218341..2199784a489f 100644
> > --- a/drivers/nvmem/Makefile
> > +++ b/drivers/nvmem/Makefile
> > @@ -55,3 +55,6 @@ obj-$(CONFIG_NVMEM_ZYNQMP)	+= nvmem_zynqmp_nvmem.o
> >   nvmem_zynqmp_nvmem-y		:= zynqmp_nvmem.o
> >   obj-$(CONFIG_SPRD_EFUSE)	+= nvmem_sprd_efuse.o
> >   nvmem_sprd_efuse-y		:= sprd-efuse.o
> > +
> > +obj-$(CONFIG_NVMEM_ONIE_CELLS)	+= nvmem-onie-cells.o
> > +nvmem-onie-cells-y		:= onie-cells.o
> > diff --git a/drivers/nvmem/onie-cells.c b/drivers/nvmem/onie-cells.c
> > new file mode 100644
> > index 000000000000..1e8b4b8d1c0d
> > --- /dev/null
> > +++ b/drivers/nvmem/onie-cells.c
> > @@ -0,0 +1,332 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * ONIE NVMEM cells provider
> > + *
> > + * Author: Vadym Kochan <vadym.kochan@plvision.eu>
> > + */
> > +
> > +#define ONIE_NVMEM_DRVNAME	"onie-nvmem-cells"
> > +
> > +#define pr_fmt(fmt) ONIE_NVMEM_DRVNAME ": " fmt
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/init.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/nvmem-consumer.h>
> > +#include <linux/nvmem-provider.h>
> > +
> > +#define ONIE_NVMEM_TLV_MAX_LEN	2048
> > +
> > +#define ONIE_NVMEM_HDR_ID	"TlvInfo"
> > +
> 
> ...
> 
> > +
> > +static int onie_nvmem_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct device_node *np = dev->of_node;
> > +	struct nvmem_cell_info *cells;
> > +	struct onie_nvmem_attr *attr;
> > +	struct nvmem_device *nvmem;
> > +	struct onie_nvmem *onie;
> > +	unsigned int ncells = 0;
> > +	int err;
> > +
> > +	nvmem = of_nvmem_device_get(np, NULL);
> > +	if (IS_ERR(nvmem))
> > +		return PTR_ERR(nvmem);
> > +
> TBH, this looks completely incorrect way to do this and misuse of nvmem
> consumer interface.
> 
> Ideally nvmem provider driver should populate "cells" in struct nvmem_config
> after decoding them and then register nvmem provider.
> 
> That should just work!
> 
> 
> --srini
But this is not nvmem provider but just describes the cells for any
nvmem device, because ONIE uses special TLV structure on the nvmem
device. So from the nvmem device point it is a consumer but provides the cells
for the given device.

> 
> 
> > +	onie = kmalloc(sizeof(*onie), GFP_KERNEL);
> > +	if (!onie) {
> > +		err = -ENOMEM;
> > +		goto err_nvmem_alloc;
> > +	}
> > +
> > +	INIT_LIST_HEAD(&onie->attrs);
> > +	onie->attr_count = 0;
> > +	onie->nvmem = nvmem;
> > +
> > +	err = onie_nvmem_decode(onie);
> > +	if (err)
> > +		goto err_nvmem_decode;
> > +
> > +	if (!onie->attr_count) {
> > +		pr_err("%s: has no ONIE attributes\n", nvmem_dev_name(nvmem));
> > +		err = -EINVAL;
> > +		goto err_no_attrs;
> > +	}
> > +
> > +	cells = kmalloc_array(onie->attr_count, sizeof(*cells), GFP_KERNEL);
> > +	if (!cells) {
> > +		err = -ENOMEM;
> > +		goto err_cells_alloc;
> > +	}
> > +
> > +	onie->cell_lookup = kmalloc_array(onie->attr_count,
> > +					  sizeof(struct nvmem_cell_lookup),
> > +					  GFP_KERNEL);
> > +	if (!onie->cell_lookup) {
> > +		err = -ENOMEM;
> > +		goto err_lookup_alloc;
> > +	}
> > +
> > +	list_for_each_entry(attr, &onie->attrs, head) {
> > +		struct nvmem_cell_lookup *lookup;
> > +		struct nvmem_cell_info *cell;
> > +
> > +		cell = &cells[ncells];
> > +
> > +		lookup = &onie->cell_lookup[ncells];
> > +		lookup->con_id = NULL;
> > +
> > +		cell->offset = attr->offset;
> > +		cell->name = attr->name;
> > +		cell->bytes = attr->len;
> > +		cell->bit_offset = 0;
> > +		cell->nbits = 0;
> > +
> > +		lookup->nvmem_name = nvmem_dev_name(onie->nvmem);
> > +		lookup->dev_id = dev_name(dev);
> > +		lookup->cell_name = cell->name;
> > +		lookup->con_id = cell->name;
> > +
> > +		ncells++;
> > +	}
> > +
> > +	onie->cell_tbl.nvmem_name = nvmem_dev_name(onie->nvmem);
> > +	onie->cell_tbl.ncells = ncells;
> > +	onie->cell_tbl.cells = cells;
> > +
> > +	nvmem_add_cell_table(&onie->cell_tbl);
> > +	nvmem_add_cell_lookups(onie->cell_lookup, ncells);
> > +
> > +	dev_set_drvdata(dev, onie);
> > +
> > +	onie_nvmem_attrs_free(onie);
> > +
> > +	nvmem_device_put(nvmem);
> > +
> > +	return 0;
> > +
> > +err_lookup_alloc:
> > +	kfree(onie->cell_tbl.cells);
> > +err_cells_alloc:
> > +	onie_nvmem_attrs_free(onie);
> > +err_no_attrs:
> > +err_nvmem_decode:
> > +	kfree(onie);
> > +err_nvmem_alloc:
> > +	nvmem_device_put(nvmem);
> > +
> > +	return err;
> > +}
> > +
