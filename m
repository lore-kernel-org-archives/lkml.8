Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1D0C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B580420717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgGQOsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:48:30 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:52801 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgGQOs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:48:29 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MUl4z-1kMbVr2E53-00QkxK for <linux-kernel@vger.kernel.org>; Fri, 17 Jul
 2020 16:48:26 +0200
Received: by mail-qt1-f178.google.com with SMTP id j10so7769140qtq.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:48:26 -0700 (PDT)
X-Gm-Message-State: AOAM532fMUsm5a4dluc6dFQX+tkYx7ogpU0AE2wgJCtnHPFkCkEXyEAq
        KHaul4rr4rKBqmx2VaC7a9kTTDhIu/93x2iZFH0=
X-Google-Smtp-Source: ABdhPJydQsPw4SiioCuxhNcixkYPSWMwyS3lcBB0SHVk4eRFINTHXayFSR41dX2ugUkkcZeAgbyJtgwGwm9+YcdHsTM=
X-Received: by 2002:ac8:2b98:: with SMTP id m24mr10840018qtm.7.1594997305357;
 Fri, 17 Jul 2020 07:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200716223627.253936-1-daniel.gutson@eclypsium.com>
In-Reply-To: <20200716223627.253936-1-daniel.gutson@eclypsium.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Jul 2020 16:48:09 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2miOXUESw+ayiEzAZ07NcieztVMEY31wUgrkD2tBAtDg@mail.gmail.com>
Message-ID: <CAK8P3a2miOXUESw+ayiEzAZ07NcieztVMEY31wUgrkD2tBAtDg@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] Firmware security information in SYSFS
To:     Daniel Gutson <daniel.gutson@eclypsium.com>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Y15CeUDDR3n/zN/hWqhVNMaWLrQLdLhuiw1zysYkWn3grGd2ML8
 FAjjCrVufncXDPps1MEOKyVwL6s/4JvGpUXOQmkR+eqfXxUf9zeLNjiau1SMM3KNwft9aaX
 AnQks19xUZ99sBwMh+Fhk5qgs38yDJ7ugdCICz1bPlizVSX92kMHbCQZMDgiGYuWI6jT9za
 kwzVeUOvuCjiLqlKQnOkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IFi9cgwujf0=:qYENg35n0W82/3fDPzlth3
 knCbi8ToGJUsmg3KLbpL+f6sQtWNWOuswQsEtAVjLaCFZaeuvYtGNK43uQMm2LU82hGCtc0Iw
 OWERsZ6rBHjpAJ1UOOcffzpNm9dSd2IDqp8ImDaN+3NVuNHUi8yHFHuxMERRtJnPMh4wzpSZV
 Ti9NHWfswUnyj/clnhBsEXgl96VIQruvl98fz6uDV+l16ctureuNfJY3LF6InO7Iv6lPMbM+m
 36lhBNWQoGt4Iak63NUW/s2uw/9+lgWiN2nSJBRwYPkL37wlw4ChKnxYn6RAL1zU2klJkXoet
 MZrCSOnIBHSbuaZxgyeZjUYY4dMcQhTVbWQLUDt3otWaNHXTx9KgdeBJrgSvD7v/CX6cJFGt8
 cwJEWtbT96lQKiG/jKDkFIywkZ8jNNxOwyUK9oM8EYu6xoG2Db59HaapmNXEjKgWtMlpRlYTl
 iSBbnIB1t/EpF+f37VmmVFzX9B6RuUHjKAFEEAc4hGMW3ei305U0GSS4YpnPBgaD/lGktltop
 9IMhz0GRNZP5FGbnI6odCCJkvzaCaxFBVVt+JZvNEn4K1bpKz70drLGatlDsz7qSK8DDdkjwd
 0Aywe25SRzDAaup2ICpQWismHS99XncztnVTssEUMIgGXuETaTfpTd5Ez7+g6Z3aYmbrh05wX
 aniIHmQKr9KjltdxikC/rD7MIkAOrOzkZa3kNfitMdYNmvGZlxfrXTQl/KSBerOufyf2D8XaM
 4b7VeQs7NwQqJOwo4towFO7QSF8VqNuH2b9ssh7WmthlL79BlqmO24JsVPg0Ic2RV8ux3StpY
 F9IqkHbai4vfmepTiEZ/+ntbrKu7k6iPUxtgTI1xtpoWhVH6uBASBwd8P+4q1USAQC0Z5B5Or
 Q5htdXXcWwcv8GUNi14Kp1rJ14l8WYhpQJByldKHAYlDtBEduoG2vwW4TRl385+qJqpvcvvuE
 otZZid2hAsv89O60jRGvlru5yk0AZ/tEFYU1EoUjPsbOS+sQuEvEB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 12:36 AM Daniel Gutson
<daniel.gutson@eclypsium.com> wrote:
>

> +static ssize_t internal_callback(struct kobject *kobj,
> +                                struct kobj_attribute *attr, char *buf)
> +{
> +       struct firmware_security_data *fwsd =
> +               container_of(attr, struct firmware_security_data, kobj_attr);
> +       return fwsd->callback(buf, fwsd->private_data);
> +}
> +
> +int register_firmware_security_data_callback(
> +       const char *name, ssize_t (*callback)(char *buf, void *private_data),
> +       void *private_data)

Why do you have a callback interface here? I would have expected
all the data to be static during the kernel run time, so just passing the
information here would make it much simpler.

> +static ssize_t cnl_read_field(char *buf, struct pci_dev *pdev, u32 mask)
> +{
> +       u32 bcr;
> +
> +       if (pci_read_config_dword(pdev, BCR, &bcr) != PCIBIOS_SUCCESSFUL)
> +               return -EIO;
> +
> +       return sprintf(buf, "%d\n", (int)!!(bcr & mask));
> +}
> +
> +static ssize_t cnl_wpd_firmware_security_callbacks(char *buf,
> +                                                  void *private_data)
> +{
> +       return cnl_read_field(buf, (struct pci_dev *)private_data, BCR_WPD);
> +}
> +
> +static ssize_t cnl_ble_firmware_security_callbacks(char *buf,
> +                                                  void *private_data)
> +{
> +       return cnl_read_field(buf, (struct pci_dev *)private_data, BCR_BLE);
> +}
> +
> +static ssize_t cnl_smm_bwp_firmware_security_callbacks(char *buf,
> +                                                      void *private_data)
> +{
> +       return cnl_read_field(buf, (struct pci_dev *)private_data, BCR_SMM_BWP);
> +}
> +
> +static void register_firmware_security_data_callbacks(struct pci_dev *pdev)
> +{
> +       register_firmware_security_data_callback(
> +               "bioswe", &cnl_wpd_firmware_security_callbacks, pdev);
> +       register_firmware_security_data_callback(
> +               "ble", &cnl_ble_firmware_security_callbacks, pdev);
> +       register_firmware_security_data_callback(
> +               "smm_bwp", &cnl_smm_bwp_firmware_security_callbacks, pdev);
> +}

All of this should probably become a single function that reads the
registers and then passes the contents into whatever common function
you have that makes them visible to user space.

> @@ -76,7 +119,7 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
>         { PCI_VDEVICE(INTEL, 0xa224), (unsigned long)&bxt_info },
>         { PCI_VDEVICE(INTEL, 0xa324), (unsigned long)&cnl_info },
>         { PCI_VDEVICE(INTEL, 0xa3a4), (unsigned long)&bxt_info },
> -       { },
> +       {},
>  };
...
>  #include "intel-spi.h"
>
> @@ -48,17 +49,17 @@
>
>  #define FADDR                          0x08
>  #define DLOCK                          0x0c
> -#define FDATA(n)                       (0x10 + ((n) * 4))
> +#define FDATA(n)                       (0x10 + ((n)*4))
>
>  #define FRACC                          0x50
>
> -#define FREG(n)                                (0x54 + ((n) * 4))
> +#define FREG(n)                                (0x54 + ((n)*4))
>  #define FREG_BASE_MASK                 0x3fff
>  #define FREG_LIMIT_SHIFT               16
>  #define FREG_LIMIT_MASK                        (0x03fff << FREG_LIMIT_SHIFT)
>

Accidental whitespace change, please skip these changes?

> @@ -161,7 +164,8 @@ struct intel_spi {
>
>  static bool writeable;
>  module_param(writeable, bool, 0);
> -MODULE_PARM_DESC(writeable, "Enable write access to SPI flash chip (default=0)");
> +MODULE_PARM_DESC(writeable,
> +                "Enable write access to SPI flash chip (default=0)");
>
>  static void intel_spi_dump_regs(struct intel_spi *ispi)
>  {

This looks like a useful change, but it should be a separate patch.

> @@ -179,8 +183,8 @@ static void intel_spi_dump_regs(struct intel_spi *ispi)
>         dev_dbg(ispi->dev, "DLOCK=0x%08x\n", readl(ispi->base + DLOCK));
>
>         for (i = 0; i < 16; i++)
> -               dev_dbg(ispi->dev, "FDATA(%d)=0x%08x\n",
> -                       i, readl(ispi->base + FDATA(i)));
> +               dev_dbg(ispi->dev, "FDATA(%d)=0x%08x\n", i,
> +                       readl(ispi->base + FDATA(i)));
>
>         dev_dbg(ispi->dev, "FRACC=0x%08x\n", readl(ispi->base + FRACC));
>
> @@ -220,9 +224,8 @@ static void intel_spi_dump_regs(struct intel_spi *ispi)
>                 base = value & PR_BASE_MASK;
>
>                 dev_dbg(ispi->dev, " %02d base: 0x%08x limit: 0x%08x [%c%c]\n",
> -                        i, base << 12, (limit << 12) | 0xfff,
> -                        value & PR_WPE ? 'W' : '.',
> -                        value & PR_RPE ? 'R' : '.');
> +                       i, base << 12, (limit << 12) | 0xfff,
> +                       value & PR_WPE ? 'W' : '.', value & PR_RPE ? 'R' : '.');
>         }
>
>         dev_dbg(ispi->dev, "Flash regions:\n");

More whitespace changes.

       Arnd
