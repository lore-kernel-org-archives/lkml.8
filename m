Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60627C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357ED222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FWTYD9qH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgBGSYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 13:24:21 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39787 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgBGSYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 13:24:20 -0500
Received: by mail-pg1-f194.google.com with SMTP id j15so189002pgm.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 10:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:in-reply-to:cc:to:message-id:mime-version
         :content-transfer-encoding;
        bh=rjZ+rz1tMKWI7bHXbhY43JHCn3z3DegyIwG/TDVNjXY=;
        b=FWTYD9qHqvntLBQRg+TWhHreHJked/6E59ChwCw4W6u/61wCcfwzh9dy109owrtK6j
         ZnSY7gwVViHBhYX5KyaxtPjGjuBKA1ZbQxeC09g9t9oFsuc6VLbiOqSkvzVmSk4BedYb
         RrE0gIebTVPGMLWpq7X5kZf9m3Ta8qOnOw1kXAs7cumR2l6gWp7/4DthcauvG6Dxofta
         ciyxJQmHh5pW+4wR4gPGmLy9dugVhgzlFFFmzcxOTqJp4OzOP1wyklrz3JedZLwF/myZ
         sA8Uf84uyvrHPX5N8Xlh7GDtLsWJ70hPeyqL74Cf65cA7Mj0ZwToXAw3W9EIDhMbcA+P
         Kdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:in-reply-to:cc:to:message-id
         :mime-version:content-transfer-encoding;
        bh=rjZ+rz1tMKWI7bHXbhY43JHCn3z3DegyIwG/TDVNjXY=;
        b=dsimLdb0D95/QZuwWAO6SYiueDSyCD+151UWR1y2Zkh0k1+pntl0vidiQLM7LzO70X
         FrGdwEeokrcAWzmyVIuVLyI/2aFyoh2C4LZ5OiIVhusvBwVHlxb/JGa/MGjxKf0qZpb7
         Q/hM8EAtpf4nq4nHgXRsl+PLih7bvnBxjGfb2WZ1PnQerCP5/mCJfDUzAEr+KOdC696C
         HUllVJ3chPhMiLMhQJL7Vm+X66FIIeHChfhuayfnLJtAzjpbpg9p0TyDgZN+QyvN21GS
         4w5Xz/WArkIRkHq0dh5ZVE6ypHDCnC81eLdN2nUstVna/iwV2JchP08yy/2CFL7so1ND
         jgcw==
X-Gm-Message-State: APjAAAWZhzmllrZLzA7Ei9Lu4p6bOQM3wTkvZP6Eah73qpwaBY1iKM2C
        3R2K5NvJ7Ky1wNTS/E0FwwXWUA==
X-Google-Smtp-Source: APXvYqxe3fvpH009bmrNk57D4faklFjXWGxPUQtWMXJLwq1leAXW9kSA2RPaGgKRagbsux60wBFovA==
X-Received: by 2002:a63:e30a:: with SMTP id f10mr478465pgh.331.1581099860086;
        Fri, 07 Feb 2020 10:24:20 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
        by smtp.gmail.com with ESMTPSA id 72sm3937487pfw.7.2020.02.07.10.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 10:24:19 -0800 (PST)
Date:   Fri, 07 Feb 2020 10:24:19 -0800 (PST)
X-Google-Original-Date: Fri, 07 Feb 2020 10:24:12 PST (-0800)
From:   Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject:     Re: [PATCH v4 2/2] riscv: Add support to determine no. of L2 cache way enabled
In-Reply-To: <1579247018-6720-3-git-send-email-yash.shah@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        allison@lohutok.net, alexios.zavras@intel.com,
        Greg KH <gregkh@linuxfoundation.org>, tglx@linutronix.de,
        bp@suse.de, anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com,
        yash.shah@sifive.com
To:     yash.shah@sifive.com
Message-ID: <mhng-4c96b04e-5adc-4b88-8b39-715cd765e6a5@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2020 23:43:38 PST (-0800), yash.shah@sifive.com wrote:
> In order to determine the number of L2 cache ways enabled at runtime,
> implement a private attribute ("number_of_ways_enabled"). Reading this
> attribute returns the number of enabled L2 cache ways at runtime.
>
> Using riscv_set_cacheinfo_ops() hook a custom function, that returns
> this private attribute, to the generic ops structure which is used by
> cache_get_priv_group() in cacheinfo framework.
>
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> ---
>  drivers/soc/sifive/sifive_l2_cache.c | 38 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/drivers/soc/sifive/sifive_l2_cache.c b/drivers/soc/sifive/sifive_l2_cache.c
> index a506939..3fb6404 100644
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
>  	DIR_CORR = 0,
> @@ -107,6 +110,38 @@ int unregister_sifive_l2_error_notifier(struct notifier_block *nb)
>  }
>  EXPORT_SYMBOL_GPL(unregister_sifive_l2_error_notifier);
>
> +static int l2_largest_wayenabled(void)
> +{
> +	return readl(l2_base + SIFIVE_L2_WAYENABLE);
> +}

WayEnable is 8 bits.

> +
> +static ssize_t number_of_ways_enabled_show(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	return sprintf(buf, "%u\n", l2_largest_wayenabled());
> +}
> +
> +static DEVICE_ATTR_RO(number_of_ways_enabled);
> +
> +static struct attribute *priv_attrs[] = {
> +	&dev_attr_number_of_ways_enabled.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group priv_attr_group = {
> +	.attrs = priv_attrs,
> +};
> +
> +const struct attribute_group *l2_get_priv_group(struct cacheinfo *this_leaf)
> +{
> +	/* We want to use private group for L2 cache only */
> +	if (this_leaf->level == 2)
> +		return &priv_attr_group;
> +	else
> +		return NULL;
> +}
> +
>  static irqreturn_t l2_int_handler(int irq, void *device)
>  {
>  	unsigned int add_h, add_l;
> @@ -170,6 +205,9 @@ static int __init sifive_l2_init(void)
>
>  	l2_config_read();
>
> +	l2_cache_ops.get_priv_group = l2_get_priv_group;
> +	riscv_set_cacheinfo_ops(&l2_cache_ops);
> +
>  #ifdef CONFIG_DEBUG_FS
>  	setup_sifive_debug();
>  #endif
