Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4269C33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 05:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95757222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 05:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="0blqWPP0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgANFA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 00:00:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34720 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgANFA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 00:00:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so10829885wrr.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 21:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EyjzXR8COdd1eoaRXFYjBLgXqmenG49ZI6sEr2gOrtw=;
        b=0blqWPP0XUEalKMl98BWEQtugyWInoGtd5Gp4piQFuLXDFIFejyG2RWvPdhBEfXxWI
         R07mJCfH/uBiZJSo3P8V8xZ3BFGBkgpKk6o0kXcWhRfVJqKPfnY6ya/16lZInohkZIz5
         vxD63I7ruVJmpGyYrU+we2V+Npd/Rf2hIq16w/GLgctPGnYfZ54P0oL7RyCdMTuA3Rcc
         WyOAuKOYTiPtOMyC1OpvVm/9lwu/xha/WfilFKqKaNwG1gBig6Ay2jFLS7D70UqpIm2v
         Ck7/GCpJIW8EOtTmPU1HZEe7efIft4Y1OlL5v4lkA+//W/3ctXAPjoJLE4PYSP2X1rLP
         RzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EyjzXR8COdd1eoaRXFYjBLgXqmenG49ZI6sEr2gOrtw=;
        b=k19n85YvItiy7eA4GuyyzunkYqOo5v/tjfTIKlDDQjAgiuA4OY0KRj7TjVQMjCRD8t
         ddP32lYNHD2/DnrtR8ShGH6py+VFJHUdQSALZghNDMt6voo0a0vSHDcbNuVIPyHt53Qp
         JU0k2mG8MC0sDi5g3DNUUsaCI0x3v/xmpF2fhZzFoLtOitWlzx+Htd+JfB79y5ntb9c1
         kqvew9Ut+KRXHMkG/Uii30KqkEvQZF+zkRg5SOdDQb/7N1F9BIRt/pcq2fUg9G9ihJgI
         VkyLmJjfwmscloWFqEEBXjxWZBozjfko+AVm5P6Cy0lp0yZU15mssOEWnSzMatMKa1tU
         KpGg==
X-Gm-Message-State: APjAAAVJzfnRqPyZ7PmN7ttMXJPkUOAg+IxHFXpwzfMDf103/crO5gY3
        F5lkD9WfDa+SvntoPwbE8TNGCOTP7RcuixC/s7fdUw==
X-Google-Smtp-Source: APXvYqy8JGDxg4Mr/pqYBdBQ3gHtmzQ+mvGy2inraq9v/RF0Hlgf/VdA+Rkzqv7LoaKDL2B0TlDYpBsMBqiwN3AWFQc=
X-Received: by 2002:adf:fa12:: with SMTP id m18mr21869141wrr.309.1578978026945;
 Mon, 13 Jan 2020 21:00:26 -0800 (PST)
MIME-Version: 1.0
References: <1578897500-23897-1-git-send-email-yash.shah@sifive.com> <1578897500-23897-3-git-send-email-yash.shah@sifive.com>
In-Reply-To: <1578897500-23897-3-git-send-email-yash.shah@sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 14 Jan 2020 10:30:16 +0530
Message-ID: <CAAhSdy2QvF+U0eJ1XMc8L5gJB5e_9_XUoQpg8pVof+kxxJ5avg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] riscv: Add support to determine no. of L2 cache
 way enabled
To:     Yash Shah <yash.shah@sifive.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, bp@suse.de,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 12:09 PM Yash Shah <yash.shah@sifive.com> wrote:
>
> In order to determine the number of L2 cache ways enabled at runtime,
> implement a private attribute ("number_of_ways_enabled"). Reading this
> attribute returns the number of enabled L2 cache ways at runtime.
>
> Using riscv_set_cacheinfo_ops() hook a custom function, that returns
> this private attribute, to the generic ops structure which is used by
> cache_get_priv_group() in cacheinfo framework.
>
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  drivers/soc/sifive/sifive_l2_cache.c | 38 ++++++++++++++++++++++++++++++++++++
>  include/soc/sifive/sifive_l2_cache.h |  2 ++
>  2 files changed, 40 insertions(+)
>
> diff --git a/drivers/soc/sifive/sifive_l2_cache.c b/drivers/soc/sifive/sifive_l2_cache.c
> index a506939..8741885 100644
> --- a/drivers/soc/sifive/sifive_l2_cache.c
> +++ b/drivers/soc/sifive/sifive_l2_cache.c
> @@ -9,6 +9,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_address.h>
> +#include <linux/device.h>
> +#include <asm/cacheinfo.h>
>  #include <soc/sifive/sifive_l2_cache.h>
>
>  #define SIFIVE_L2_DIRECCFIX_LOW 0x100
> @@ -31,6 +33,7 @@
>
>  static void __iomem *l2_base;
>  static int g_irq[SIFIVE_L2_MAX_ECCINTR];
> +static struct riscv_cacheinfo_ops l2_cache_ops;
>
>  enum {
>         DIR_CORR = 0,
> @@ -107,6 +110,38 @@ int unregister_sifive_l2_error_notifier(struct notifier_block *nb)
>  }
>  EXPORT_SYMBOL_GPL(unregister_sifive_l2_error_notifier);
>
> +int sifive_l2_largest_wayenabled(void)
> +{
> +       return readl(l2_base + SIFIVE_L2_WAYENABLE);
> +}

The sifine_l2_largest_wayenabled() is not called from anywhere else
so make it static and rename it to l2_largest_wayenabled().

> +
> +static ssize_t number_of_ways_enabled_show(struct device *dev,
> +                                          struct device_attribute *attr,
> +                                          char *buf)
> +{
> +       return sprintf(buf, "%u\n", sifive_l2_largest_wayenabled());
> +}
> +
> +static DEVICE_ATTR_RO(number_of_ways_enabled);
> +
> +static struct attribute *priv_attrs[] = {
> +       &dev_attr_number_of_ways_enabled.attr,
> +       NULL,
> +};
> +
> +static const struct attribute_group priv_attr_group = {
> +       .attrs = priv_attrs,
> +};
> +
> +const struct attribute_group *l2_get_priv_group(struct cacheinfo *this_leaf)
> +{
> +       /* We want to use private group for L2 cache only */
> +       if (this_leaf->level == 2)
> +               return &priv_attr_group;
> +       else
> +               return NULL;
> +}
> +
>  static irqreturn_t l2_int_handler(int irq, void *device)
>  {
>         unsigned int add_h, add_l;
> @@ -170,6 +205,9 @@ static int __init sifive_l2_init(void)
>
>         l2_config_read();
>
> +       l2_cache_ops.get_priv_group = l2_get_priv_group;
> +       riscv_set_cacheinfo_ops(&l2_cache_ops);
> +
>  #ifdef CONFIG_DEBUG_FS
>         setup_sifive_debug();
>  #endif
> diff --git a/include/soc/sifive/sifive_l2_cache.h b/include/soc/sifive/sifive_l2_cache.h
> index 92ade10..55feff5 100644
> --- a/include/soc/sifive/sifive_l2_cache.h
> +++ b/include/soc/sifive/sifive_l2_cache.h
> @@ -10,6 +10,8 @@
>  extern int register_sifive_l2_error_notifier(struct notifier_block *nb);
>  extern int unregister_sifive_l2_error_notifier(struct notifier_block *nb);
>
> +int sifive_l2_largest_wayenabled(void);
> +

You can drop the sifive_l2_largest_wayenabled() declaration from here.

>  #define SIFIVE_L2_ERR_TYPE_CE 0
>  #define SIFIVE_L2_ERR_TYPE_UE 1
>
> --
> 2.7.4
>

Apart from above it looks good.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
