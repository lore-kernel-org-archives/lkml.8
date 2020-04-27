Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2727EC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDC5D2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AM6v7iFK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgD0HXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 03:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgD0HXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 03:23:51 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139FEC061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 00:23:51 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id x23so12936865lfq.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 00:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dhfzSCFN3LuVL9FviVa2f/RqgnA5QyWgzvIluSwaqXY=;
        b=AM6v7iFKPgywVSa8BjofQvc3E2gF0uzCMQ2OkZuVDoF//nV5Pbv3mCwFDoxRXWk2JY
         4EtJRdQR6gSFqFdKWxbcwW/IjoObZKLUDxySI/E+xmzZvgCOwYd36b8o4+JBKFlxVCAA
         uqLpWqHQHNQyLX7HVpGibJgPAAGurpKTozNgAueiAxjz2r7FTzkdrD9wMrbVVMSC9l8d
         Xz/xqBiL5qIoi0c3B8Cn2vCg5X9sAhotjm6yQhOjg54l/841GT7EFVH9RdilsPWLjrpG
         xyeWHjEuZOoD8/K1LhH7C5N+Yr8bfBEfdhoOWbaG499MI+MbDO8McZ/tHpqTtRBntjkZ
         kRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dhfzSCFN3LuVL9FviVa2f/RqgnA5QyWgzvIluSwaqXY=;
        b=Ec2kDnLSk/jEyDttgkXsQFNzz5unq+5YE4YVXWXZGZqJY5JYXOMA07JSxdQXhwieFt
         iHEpyQUv++m28Bbty6vGWVpt9dVfGAa4Y6RKDGjue6yGapGCZqTN4J9iR3CVRPBK5P24
         x/ZwR/dfNPwwhJOl3AIZ6utbs6AH3ubFl/OmgvA+Z+tU2zotLChtn038TiJg1Q/GCIzT
         ueiCDAev+etgSwlcYH+tATDO+ZcZ9DeIbavxDbipNnOzpsSPwp2DtD+HOwtAQDmHznXZ
         fV+PbX/khGjPd8AdG+piutlTvoIbzZY180Y62R8iNKSU1ZAT5a/+UflMFaLNPILBb/Wd
         RGlg==
X-Gm-Message-State: AGi0PuY4mQLCFDaVzcNcpK+QucLvjp7nhIwLuUA7VhrbDwoCcpv4E79Y
        4kwB2lLUMm7QBMqOuyYfldFPzOnpwa9R7G+WkyA=
X-Google-Smtp-Source: APiQypIy+IEhvM6EmXV3vVg+45MIOpCDG5Keb14lzHyKgfieTn00xug+4Uk6qZDQ/F4Cnq1OondY/kXN8Sia1X4VEiQ=
X-Received: by 2002:ac2:53a6:: with SMTP id j6mr14517458lfh.153.1587972229546;
 Mon, 27 Apr 2020 00:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <c2fd765aa388d4510194ba02c017e39bde57c8d4.1587478171.git.baolin.wang7@gmail.com>
In-Reply-To: <c2fd765aa388d4510194ba02c017e39bde57c8d4.1587478171.git.baolin.wang7@gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Mon, 27 Apr 2020 15:23:38 +0800
Message-ID: <CADBw62rJ8VYTgnW_3q4=TkCyZx2B1DHsG+oOmiph8FLsukUROQ@mail.gmail.com>
Subject: Re: [PATCH v3] mfd: syscon: Add Spreadtrum physical regmap bus support
To:     Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Brown <broonie@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd and Lee,

On Tue, Apr 21, 2020 at 10:13 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> Some platforms such as Spreadtrum platform, define a special method to
> update bits of the registers instead of read-modify-write, which means
> we should use a physical regmap bus to define the reg_update_bits()
> operation instead of the MMIO regmap bus. Thus we can register a new
> physical regmap bus into syscon core to support this.
>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>

Do you have any comments for this patch? Thanks.

> ---
> Changes from v2:
>  - Fix building errors without enabling CONFIG_ARCH_SPRD.
>
> Changes from v1:
>  - Add WARN_ONCE() for seting bits and clearing bits at the same time.
>  - Remove the Spreadtrum SoC syscon driver, instead moving the regmap_bus
>  instance into syscon.c driver.
>
> Changes from RFC v2:
>  - Drop regmap change, which was applied by Mark.
>  - Add more information about how to use set/clear.
>  - Add checking to ensure the platform is compatible with
>  using a new physical regmap bus.
>
> Changes from RFC v1:
>  - Add new helper to registers a physical regmap bus instead of
>  using the MMIO bus.
> ---
>  drivers/mfd/syscon.c | 83 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 81 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index 3a97816d0cba..ca91b7770e1a 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -40,6 +40,72 @@ static const struct regmap_config syscon_regmap_config = {
>         .reg_stride = 4,
>  };
>
> +#if IS_ENABLED(CONFIG_ARCH_SPRD)
> +#define SPRD_REG_SET_OFFSET    0x1000
> +#define SPRD_REG_CLR_OFFSET    0x2000
> +
> +/*
> + * The Spreadtrum platform defines a special set/clear method to update
> + * registers' bits, which means it can write values to the register's SET
> + * address (offset is 0x1000) to set bits, and write values to the register's
> + * CLEAR address (offset is 0x2000) to clear bits.
> + *
> + * This set/clear method can help to remove the race of accessing the global
> + * registers between the multiple subsystems instead of using hardware
> + * spinlocks.
> + *
> + * Note: there is a potential risk when users want to set and clear bits
> + * at the same time, since the set/clear method will always do bits setting
> + * before bits clearing, which may cause some unexpected results if the
> + * operation sequence is strict. Thus we recommend that do not set and
> + * clear bits at the same time if you are not sure about the results.
> + */
> +static int sprd_syscon_update_bits(void *context, unsigned int reg,
> +                                  unsigned int mask, unsigned int val)
> +{
> +       void __iomem *base = context;
> +       unsigned int set, clr;
> +
> +       set = val & mask;
> +       clr = ~set & mask;
> +
> +       if (set)
> +               writel(set, base + reg + SPRD_REG_SET_OFFSET);
> +
> +       if (clr)
> +               writel(clr, base + reg + SPRD_REG_CLR_OFFSET);
> +
> +       WARN_ONCE(set && clr, "%s: non-atomic update", __func__);
> +       return 0;
> +}
> +
> +static int sprd_syscon_read(void *context, unsigned int reg, unsigned int *val)
> +{
> +       void __iomem *base = context;
> +
> +       *val = readl(base + reg);
> +       return 0;
> +}
> +
> +static int sprd_syscon_write(void *context, unsigned int reg, unsigned int val)
> +{
> +       void __iomem *base = context;
> +
> +       writel(val, base + reg);
> +       return 0;
> +}
> +#endif
> +
> +static struct regmap_bus sprd_syscon_regmap_bus = {
> +#if IS_ENABLED(CONFIG_ARCH_SPRD)
> +       .fast_io = true,
> +       .reg_write = sprd_syscon_write,
> +       .reg_read = sprd_syscon_read,
> +       .reg_update_bits = sprd_syscon_update_bits,
> +       .val_format_endian_default = REGMAP_ENDIAN_LITTLE,
> +#endif
> +};
> +
>  static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>  {
>         struct clk *clk;
> @@ -50,6 +116,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>         int ret;
>         struct regmap_config syscon_config = syscon_regmap_config;
>         struct resource res;
> +       bool use_phy_regmap_bus = false;
>
>         syscon = kzalloc(sizeof(*syscon), GFP_KERNEL);
>         if (!syscon)
> @@ -106,14 +173,26 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>         syscon_config.val_bits = reg_io_width * 8;
>         syscon_config.max_register = resource_size(&res) - reg_io_width;
>
> -       regmap = regmap_init_mmio(NULL, base, &syscon_config);
> +       /*
> +        * The Spreadtrum syscon need register a real physical regmap bus
> +        * with new atomic bits updating operation instead of using
> +        * read-modify-write.
> +        */
> +       if (IS_ENABLED(CONFIG_ARCH_SPRD) &&
> +           of_device_is_compatible(np, "sprd,atomic-syscon")) {
> +               use_phy_regmap_bus = true;
> +               regmap = regmap_init(NULL, &sprd_syscon_regmap_bus, base,
> +                                    &syscon_config);
> +       } else {
> +               regmap = regmap_init_mmio(NULL, base, &syscon_config);
> +       }
>         if (IS_ERR(regmap)) {
>                 pr_err("regmap init failed\n");
>                 ret = PTR_ERR(regmap);
>                 goto err_regmap;
>         }
>
> -       if (check_clk) {
> +       if (!use_phy_regmap_bus && check_clk) {
>                 clk = of_clk_get(np, 0);
>                 if (IS_ERR(clk)) {
>                         ret = PTR_ERR(clk);
> --
> 2.17.1
>


-- 
Baolin Wang
