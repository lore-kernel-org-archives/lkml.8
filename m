Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C89C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40D8D206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731807AbgF3I6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 04:58:40 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:57923 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731684AbgF3I6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 04:58:37 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MbRwP-1jEvT93IUL-00bsRc for <linux-kernel@vger.kernel.org>; Tue, 30 Jun
 2020 10:58:35 +0200
Received: by mail-qt1-f172.google.com with SMTP id z2so14994922qts.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 01:58:34 -0700 (PDT)
X-Gm-Message-State: AOAM530k83AbYj6Zhi1dOCrQ6mbkcxjryixdZ9jw/srTQ+vtkukgb/eG
        QZkCxNv0xVVOIOhq2CG6drbXcPDjQWeu+4iX+Q8=
X-Google-Smtp-Source: ABdhPJxaSZgH2rgQJgPuAhnIa3X8SvuA51gHojFuP47P5mrGVpvgmK7vROQgwvQoaL1Oe0qlH/W59N9Q5gxKItJcg1c=
X-Received: by 2002:ac8:7587:: with SMTP id s7mr19799486qtq.304.1593507513500;
 Tue, 30 Jun 2020 01:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200629225932.5036-1-daniel.gutson@eclypsium.com>
In-Reply-To: <20200629225932.5036-1-daniel.gutson@eclypsium.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 30 Jun 2020 10:58:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2zzXHNB7CX8efpKeQF2gJkF2J4FwafU58wT2RGvjjTxw@mail.gmail.com>
Message-ID: <CAK8P3a2zzXHNB7CX8efpKeQF2gJkF2J4FwafU58wT2RGvjjTxw@mail.gmail.com>
Subject: Re: [PATCH] SPI LPC information kernel module
To:     Daniel Gutson <daniel.gutson@eclypsium.com>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:du9lv2FI1QX0HCVZsGx5N0naa3FDuPeYpPLy4CEL1+ZZ+OZwoZZ
 SvGy3k7P+fd145B2HU0V0TFdu0NmbN3YU2KYT/oT0cevitZr4BShXKECJgOXEj2sd80zb5K
 FDqIDjaGkhqSj2PuzJ0WjlnQqgwfaoNhC34Jsdve2kRiy0//j2VGp7jAWtddp3Apv9SrPhN
 S2DcMOsc5oap9dF4lbbUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VXJ8bQiQjuQ=:hYQxZLUkxkNQmxka3Uj1Ws
 /e8dAFxdZjplILz9kcpv2q+pForTBGyrnjsGgRnc5vQ+xn7+QQd7C4pt+BFfxSeZTLftTEPou
 LM9NtCkhoq/JoDBYArQ6eSTopkbuRQR7F4IVbVwUA5IbbFMArLJ4hUV9yDzhyTDzXeeCnuwaB
 9xD9hKnPr6yvgCOyHj64KHKcSVGJckJ2pbxDhr/kPuFIAvL44DhaIEXwN4O5oqoZik1f52dgR
 21+/EOXXWDnGadNvNNGRz0fU2vwtqJpFvsz2/UpK3iPZhlIMRk7qbGCJzET1+fQFW2pem3UUb
 trz9m05XvPbSGVvj03FCkXt2QmW0rrFCcFGBfF/PkwFmUku5BK1Xd9Ke4x2DY3Jpi4BNfEGDM
 YBGd6bmnhx7Nv1YU6l/2fcaAZa2YnLu69BJ/RCagqTfmYVCC4AQ2A5eZuh+nKSlBQdhwmSZtF
 yRmjqixMt9xKUz6R3/d8FcvYh0A0J3sAxSHaaLAN9rfOVt+5mm+xkXtZfX7bmD98CnPAuOjjG
 bpW/GH2LZmKJjxHVPGCgorldxeBVsCuPHFg1+SwHnwKho0Fvm+HW9gNoBXcfucp5W73TgCI/n
 RY4toSBFPQ8WmVIrFhq3LriV4kb4tk81X1pVF2BqjN+olP8IUeIMivkIfIT4cIpPsiuo8T3i8
 USLaOwKglZ7wb6RkGFsc4m28+K12h0YsWBy0tNwC68jkGExP+nneRFUDVLkU1/7vvTJztgtVE
 WfsEnHs48j2Wa31Hl41FdUyZsW9LAv45P1VYH6tWBKYGj9X4k4PjjCEDhKomG2RxhPZeDdhFm
 c0TtmPzPXvFmBf/MoTnkUqS/423FtHb7zbmJ7TaT/7roX9OdKQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 12:59 AM Daniel Gutson
<daniel.gutson@eclypsium.com> wrote:
>
> This kernel module exports configuration attributes for the
> system SPI chip.
> This initial version exports the BIOS Write Enable (bioswe),
> BIOS Lock Enable (ble), and the SMM Bios Write Protect (SMM_BWP)
> fields of the Bios Control register. The idea is to keep adding more
> flags, not only from the BC but also from other registers in following
> versions.
>
> The goal is that the attributes are avilable to fwupd when SecureBoot
> is turned on.
>
> A technical note: I check if *ppos == BUFFER_SIZE in the reading function
> to exit early and avoid an extra access to the HW, for example when using
> the 'cat' command, which causes two read operations.
>
> Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>

The description should start with a little more background for those that
don't already know what this driver is for. What is a "system SPI chip"?
Is this an SPI host connected over LPC, or an LPC bus connected over
SPI? Is there a particular spec that this follows?

> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index c7bd01ac6291..280365e7e53c 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -57,3 +57,4 @@ obj-$(CONFIG_PVPANIC)         += pvpanic.o
>  obj-$(CONFIG_HABANA_AI)                += habanalabs/
>  obj-$(CONFIG_UACCE)            += uacce/
>  obj-$(CONFIG_XILINX_SDFEC)     += xilinx_sdfec.o
> +obj-$(CONFIG_SPI_LPC)          += spi_lpc/

Have you tried finding a more suitable subsystem for it? If this
is for an LPC bus connected over SPI, it should probably go
into drivers/bus, or a new drivers/lpc that could also contain
the existing drivers/mfd/lpc_*.c and drivers/bus/hisi_lpc.c.

If this is for an SPI host connected over LPC, it should be in drivers/spi/

> diff --git a/drivers/misc/spi_lpc/Kconfig b/drivers/misc/spi_lpc/Kconfig
> new file mode 100644
> index 000000000000..08d74746578d
> --- /dev/null
> +++ b/drivers/misc/spi_lpc/Kconfig
> @@ -0,0 +1,20 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# SPI LPC information kernel module
> +#
> +
> +config SPI_LPC
> +       tristate "SPI LPC information"
> +       depends on SECURITYFS && CPU_SUP_INTEL

Can you ensure it compiles on all architectures by changing the
dependency to (CPU_SUP_INTEL || COMPILE_TEST)

> +       help
> +         This kernel modules exports the configuration attributes for the

             s/modules/module/

> +         system SPI chip.
> +         Enable this kernel module to read the BIOSWE, BLE, and SMM_BWP fields
> +         of the Bios Control register, by reading these three files:
> +
> +             /sys/kernel/security/firmware/bioswe
> +             /sys/kernel/security/firmware/ble
> +             /sys/kernel/security/firmware/smm_bwp

I don't understand the usage of securityfs here. Are you adding a new
"firmware" LSM? If so, please split out the security module into a separate
patch and have it reviewed by the respective maintainers.

> +static int read_spibar(enum PCH_Arch pch_arch, enum CPU_Arch cpu_arch,
> +                      u64 *offset);

Try to avoid forward declarations of static functions by reordering the files.

> +int spi_read_sbase(enum PCH_Arch pch_arch __maybe_unused,
> +                  enum CPU_Arch cpu_arch, struct spi_sbase *reg)
> +{
> +       int ret = 0;
> +
> +       reg->register_arch.source = RegSource_CPU;
> +       reg->register_arch.cpu_arch = cpu_arch;
> +
> +       switch (cpu_arch) {
> +       case cpu_avn:
> +       case cpu_byt:
> +               ret = read_sbase_atom_avn_byt(&reg->cpu_byt);
> +               break;
> +       default:
> +               ret = -EIO;
> +       }
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(spi_read_sbase);

This function seems to be Intel Atom specific but has a rather generic
name for an exported symbol.

> +int spi_read_bc(enum PCH_Arch pch_arch, enum CPU_Arch cpu_arch,
> +               struct spi_bc *reg)

Same here and for a couple of other functions later. Better try to use a
namespace prefix that is more specific to your driver.

> +enum CPU_Arch {
> +       cpu_none,
> +       cpu_bdw,
> +       cpu_bdx,
> +       cpu_hsw,
> +       cpu_hsx,
> +       cpu_ivt,
> +       cpu_jkt,

You might want to avoid having a central instance listing all possible
CPUs. Instead, structure it so that the common parts know nothing
about a specific implementation and each one can be kept in a separate
file for easier extension.

> +enum RegisterSource { RegSource_PCH, RegSource_CPU };
> +
> +struct RegisterArch {
> +       enum RegisterSource source;
> +
> +       union {
> +               enum PCH_Arch pch_arch;
> +               enum CPU_Arch cpu_arch;
> +       };
> +};

Please follow the normal naming of variables and types: use proper
namespace prefixes and lowercase letters instead of CameLcAse.


> +struct spi_bc {
> +       struct RegisterArch register_arch;
> +
> +       union {
> +               struct bc_pch_3xx_4xx_5xx pch_3xx;
> +               struct bc_pch_3xx_4xx_5xx pch_4xx;
> +               struct bc_pch_3xx_4xx_5xx pch_495;
> +               struct bc_pch_3xx_4xx_5xx pch_5xx;
> +               struct bc_cpu_snb_jkt_ivb_ivt_bdx_hsx cpu_snb;
> +               struct bc_cpu_snb_jkt_ivb_ivt_bdx_hsx cpu_jkt;
> +               struct bc_cpu_snb_jkt_ivb_ivt_bdx_hsx cpu_ivb;
> +               struct bc_cpu_snb_jkt_ivb_ivt_bdx_hsx cpu_ivt;
> +               struct bc_cpu_snb_jkt_ivb_ivt_bdx_hsx cpu_bdw;
> +               struct bc_cpu_snb_jkt_ivb_ivt_bdx_hsx cpu_bdx;
> +               struct bc_cpu_snb_jkt_ivb_ivt_bdx_hsx cpu_hsx;
> +               struct bc_cpu_snb_jkt_ivb_ivt_bdx_hsx cpu_hsw;
> +               struct bc_cpu_skl_kbl_cfl cpu_skl;
> +               struct bc_cpu_skl_kbl_cfl cpu_kbl;
> +               struct bc_cpu_skl_kbl_cfl cpu_cfl;
> +               struct bc_cpu_apl_glk cpu_apl;
> +               struct bc_cpu_apl_glk cpu_glk;
> +               struct bc_cpu_atom_avn cpu_avn;
> +               struct bc_cpu_atom_byt cpu_byt;
> +       };
> +};

Here too, try to avoid having a central data structure that knows about all
possible hardware.

> +#define GENERIC_MMIO_READ(Type, Suffix, function)                              \
> +       int mmio_read_##Suffix(u64 phys_address, Type *value)                  \
> +       {                                                                      \
> +               int ret = 0;                                                   \
> +               void __iomem *mapped_address =                                 \
> +                       ioremap(phys_address, sizeof(Type));                   \
> +               pr_debug("Reading MMIO 0x%llx 0x%lx\n", phys_address,          \
> +                        sizeof(Type));                                        \
> +               if (mapped_address != NULL) {                                  \
> +                       *value = function(mapped_address);                     \
> +                       iounmap(mapped_address);                               \
> +               } else {                                                       \
> +                       pr_err("Failed to MAP IO memory: 0x%llx\n",            \
> +                              phys_address);                                  \
> +                       ret = -EIO;                                            \
> +               }                                                              \
> +               return ret;                                                    \
> +       }
> +GENERIC_MMIO_READ(u8, byte, readb)
> +GENERIC_MMIO_READ(u16, word, readw)
> +GENERIC_MMIO_READ(u32, dword, readl)

This is definitely way too generic to be added in a 'misc' driver. Why would
you even want a function that reads a register by physical address?

The driver that owns the MMIO region normally maps it once during its
probe() function and then keeps a pointer around


+static int __init mod_init(void)
+{
+       int ret = 0;
+
+       if (get_pch_cpu(&pch_arch, &cpu_arch) != 0) {
+               pr_err("Couldn't detect PCH or CPU\n");
+               return -EIO;
+       }

This looks like there should be a PCI (or SPI or LPC) driver
instead of a linux-2.4 style module init that goes scanning the
PCI bus.

> +int viddid2pch_arch(u64 vid, u64 did, enum PCH_Arch *arch)
> +{
> +       switch (vid) {
> +       case 0x8086: /* INTEL */
> +               switch (did) {
> +               case 0x1c44:
> +               case 0x1c46:
> +               case 0x1c47:
> +               case 0x1c49:
> +               case 0x1c4a:
> +               case 0x1c4b:
> +               case 0x1c4c:
> +               case 0x1c4d:
> +               case 0x1c4e:
> +               case 0x1c4f:
> +               case 0x1c50:
> +               case 0x1c52:
> +               case 0x1c54:
> +               case 0x1c56:
> +               case 0x1c5c:
> +                       *arch = pch_6_c200;
> +                       return 0;
> +               case 0x1e47:
> +               case 0x1e48:
> +               case 0x1e49:
> +               case 0x1e44:

Some of these devices seem to be owned by drivers/mfd/lpc_ich.c
(despite a comment in there claiming otherwise).

Can you describe the relation between your code and that one?
Would it be possible to remove support for the parts that already
have a driver and use an mfc driver for those?

       Arnd
