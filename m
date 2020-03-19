Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01975C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 00:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57D420772
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 00:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dR4pZVZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgCSAZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 20:25:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45736 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCSAZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 20:25:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id j10so379440pfi.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 17:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=TS6P2eCji56vuECNK+OnxyNExkiDHGAgsqe13dfkHLc=;
        b=dR4pZVZUPCB9WP5RtHi48RInvDPFxbVSZF64yzvFiowyJ8AaF/SzhGg3I26ovGtEw6
         juqhj9+JPPtZpwAankcBFWysZTi8RZQ7ONKfQr6nB/lNYH8WUdk0FqDQjrTSFdJhOYWC
         0QLySo4DZ1zSM5qz3RCpzIqXTnrqPpFZl/t7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=TS6P2eCji56vuECNK+OnxyNExkiDHGAgsqe13dfkHLc=;
        b=WcSECMopdaaSkln3p5HfXcz8U6t2BCHxbh0vYB/I8xcASumpp29vZF3XVymG2Mfw6s
         GxeXNedV09CgdrtkgniM4HoyoGieXNXl2r0Pj16MMjqJmQgUn9UiPt4/4RtgKWLctneI
         spiCha0GgfGnU27eL9UZ3L8Rf6BoiqvvT0KKuDQehulzqAza5h2YgFqwkvI/c7D+Xf/p
         eEMLg2iWVpUOmFT21KBMuogUvxfMlhpskmwxjewip2aN5JeGfpKlzkbapVRYXD8J3vLF
         aQzLmj7S5LBq6Q6lHTXBnx274NOdMpkQXVRQNnjwgwqxbV6nbNeiRfdTffdtvk1lTH6I
         KQYQ==
X-Gm-Message-State: ANhLgQ1AJrOExhTIfyiYtlK+pE0eCzApPqdz/Zu5YiNJqA/avZv2H7eq
        MUDZH9NT5sy5DNa//q5jhsjM5WQ+cQM=
X-Google-Smtp-Source: ADFU+vvR6DJVT7U8l4rNquQ/VWZAF6xNkv4StE9mw7mjRxnJhAzRjNNny3oDTrKT1S8WhBBPmAEZ+Q==
X-Received: by 2002:aa7:87c1:: with SMTP id i1mr1017080pfo.297.1584577542429;
        Wed, 18 Mar 2020 17:25:42 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h24sm178367pfn.49.2020.03.18.17.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 17:25:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1584505758-21037-3-git-send-email-mkshah@codeaurora.org>
References: <1584505758-21037-1-git-send-email-mkshah@codeaurora.org> <1584505758-21037-3-git-send-email-mkshah@codeaurora.org>
Subject: Re: [PATCH v5 2/4] soc: qcom: Add SoC sleep stats driver
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        Maulik Shah <mkshah@codeaurora.org>
To:     Maulik Shah <mkshah@codeaurora.org>, bjorn.andersson@linaro.org,
        evgreen@chromium.org, mka@chromium.org
Date:   Wed, 18 Mar 2020 17:25:40 -0700
Message-ID: <158457754092.152100.9555786468515303757@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2020-03-17 21:29:16)
> diff --git a/drivers/soc/qcom/soc_sleep_stats.c b/drivers/soc/qcom/soc_sl=
eep_stats.c
> new file mode 100644
> index 0000000..0db7c3d
> --- /dev/null
> +++ b/drivers/soc/qcom/soc_sleep_stats.c
> @@ -0,0 +1,244 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2011-2020, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/seq_file.h>
> +
> +#include <linux/soc/qcom/smem.h>
> +#include <clocksource/arm_arch_timer.h>
> +
> +#define STAT_TYPE_ADDR         0x0
> +#define COUNT_ADDR             0x4
> +#define LAST_ENTERED_AT_ADDR   0x8
> +#define LAST_EXITED_AT_ADDR    0x10
> +#define ACCUMULATED_ADDR       0x18
> +#define CLIENT_VOTES_ADDR      0x1c
> +
> +struct subsystem_data {
> +       const char *name;
> +       u32 smem_item;
> +       u32 pid;
> +};
> +
> +static struct subsystem_data subsystems[] =3D {

This can be const.

> +       { "modem", 605, 1 },
> +       { "adsp", 606, 2 },
> +       { "cdsp", 607, 5 },
> +       { "slpi", 608, 3 },
> +       { "gpu", 609, 0 },
> +       { "display", 610, 0 },
> +};
> +
> +struct stats_config {
> +       unsigned int offset_addr;
> +       unsigned int num_records;
> +       bool appended_stats_avail;
> +};
> +
> +struct stats_prv_data {
> +       const struct stats_config *config;

Can we have 'bool has_appended_stats' here instead?

> +       void __iomem *reg;
> +};
> +
> +struct sleep_stats {
> +       u32 stat_type;
> +       u32 count;
> +       u64 last_entered_at;
> +       u64 last_exited_at;
> +       u64 accumulated;
> +};
> +
> +struct appended_stats {
> +       u32 client_votes;
> +       u32 reserved[3];
> +};
> +
> +static void print_sleep_stats(struct seq_file *s, struct sleep_stats *st=
at)

Make stat const please.

> +{
> +       u64 accumulated =3D stat->accumulated;
> +       /*
> +        * If a subsystem is in sleep when reading the sleep stats adjust
> +        * the accumulated sleep duration to show actual sleep time.
> +        */
> +       if (stat->last_entered_at > stat->last_exited_at)
> +               accumulated +=3D arch_timer_read_counter()

This assumes that arch_timer_read_counter() is returning the physical
counter? Is accumulated duration useful for anything? I don't like that
we're relying on the arch timer code to return a certain counter value
that may or may not be the same as what is written into smem.

> +                              - stat->last_entered_at;
> +
> +       seq_printf(s, "Count =3D %u\n", stat->count);
> +       seq_printf(s, "Last Entered At =3D %llu\n", stat->last_entered_at=
);
> +       seq_printf(s, "Last Exited At =3D %llu\n", stat->last_exited_at);
> +       seq_printf(s, "Accumulated Duration =3D %llu\n", accumulated);
> +}
> +
> +static int subsystem_sleep_stats_show(struct seq_file *s, void *d)
> +{
> +       struct subsystem_data *subsystem =3D s->private;
> +       struct sleep_stats *stat;
> +
> +       stat =3D qcom_smem_get(subsystem->pid, subsystem->smem_item, NULL=
);

We already get this during probe in create_debugfs_entries() (which is
too generic of a name by the way). Why can't we stash that pointer away
so that it comes through the 'd' parameter to this function?

> +       if (IS_ERR(stat))
> +               return PTR_ERR(stat);
> +
> +       print_sleep_stats(s, stat);
> +
> +       return 0;
> +}
> +
> +static int soc_sleep_stats_show(struct seq_file *s, void *d)
> +{
> +       struct stats_prv_data *prv_data =3D s->private;
> +       void __iomem *reg =3D prv_data->reg;
> +       struct sleep_stats stat;
> +
> +       stat.count =3D readl(reg + COUNT_ADDR);
> +       stat.last_entered_at =3D readq(reg + LAST_ENTERED_AT_ADDR);
> +       stat.last_exited_at =3D readq(reg + LAST_EXITED_AT_ADDR);
> +       stat.accumulated =3D readq(reg + ACCUMULATED_ADDR);
> +
> +       print_sleep_stats(s, &stat);

Ok I see. The same stat info is in SMEM and also in some IO memory
location? So we have to read one from an iomem region and one from smem?
Please make subsystem_sleep_stats_show() take a 'struct
smem_sleep_stats' through 'd' that has the __le32 and __le64 markings
and then do the byte swaps into a stack local struct sleep_stats that
print_sleep_stats() can use.

> +
> +       if (prv_data->config->appended_stats_avail) {
> +               struct appended_stats app_stat;

Just use a u32 for this. The struct is not useful here.

> +
> +               app_stat.client_votes =3D readl(reg + CLIENT_VOTES_ADDR);
> +               seq_printf(s, "Client_votes =3D %#x\n", app_stat.client_v=
otes);
> +       }
> +
> +       return 0;
> +}
> +
> +DEFINE_SHOW_ATTRIBUTE(soc_sleep_stats);
> +DEFINE_SHOW_ATTRIBUTE(subsystem_sleep_stats);
> +
> +static struct dentry *create_debugfs_entries(void __iomem *reg,
> +                                            struct stats_prv_data *prv_d=
ata)

I'd prefer this was just inlined into probe.

> +{
> +       struct dentry *root;
> +       struct sleep_stats *stat;
> +       char stat_type[sizeof(u32) + 1] =3D {0};
> +       u32 offset, type;
> +       int i;
> +
> +       root =3D debugfs_create_dir("qcom_sleep_stats", NULL);
> +
> +       for (i =3D 0; i < prv_data[0].config->num_records; i++) {

Pass config as another argument instead of attaching it to prv_data
please.

> +               offset =3D STAT_TYPE_ADDR + (i * sizeof(struct sleep_stat=
s));
> +
> +               if (prv_data[0].config->appended_stats_avail)
> +                       offset +=3D i * sizeof(struct appended_stats);

I was imagining a macro like, SLEEP_STATn(i, has_appended) that did all the
math to figure out the offset.

> +
> +               prv_data[i].reg =3D reg + offset;
> +
> +               type =3D readl(prv_data[i].reg);
> +               memcpy(stat_type, &type, sizeof(u32));

Is it a 4-byte ascii register that may or may not be NUL terminated? We
should use __raw_readl() then so we don't do an endian swap. Using
memcpy_fromio() does this all for you.

> +               debugfs_create_file(stat_type, 0444, root,

Maybe just 0400? Not sure why everyone in the world needs to read this.

> +                                   &prv_data[i],
> +                                   &soc_sleep_stats_fops);
> +       }
> +
> +       for (i =3D 0; i < ARRAY_SIZE(subsystems); i++) {
> +               stat =3D qcom_smem_get(subsystems[i].pid, subsystems[i].s=
mem_item,
> +                                    NULL);
> +               if (IS_ERR(stat))
> +                       continue;
> +
> +               debugfs_create_file(subsystems[i].name, 0444, root,
> +                                   &subsystems[i],
> +                                   &subsystem_sleep_stats_fops);
> +       }
> +
> +       return root;
> +}
> +
> +static int soc_sleep_stats_probe(struct platform_device *pdev)
> +{
> +       struct resource *res;
> +       void __iomem *reg;
> +       void __iomem *offset_addr;
> +       phys_addr_t stats_base;
> +       resource_size_t stats_size;
> +       struct dentry *root;
> +       const struct stats_config *config;
> +       struct stats_prv_data *prv_data;
> +       int i;
> +
> +       config =3D device_get_match_data(&pdev->dev);
> +       if (!config)
> +               return -ENODEV;
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res)
> +               return PTR_ERR(res);
> +
> +       offset_addr =3D ioremap(res->start + config->offset_addr, sizeof(=
u32));
> +       if (IS_ERR(offset_addr))
> +               return PTR_ERR(offset_addr);
> +
> +       stats_base =3D res->start | readl_relaxed(offset_addr);

I still don't get it, but whatever. I highly doubt the lower bits are
anything besides 0 so a logical OR vs addition is not different.

> +       stats_size =3D resource_size(res);
> +       iounmap(offset_addr);
> +
> +       reg =3D devm_ioremap(&pdev->dev, stats_base, stats_size);
> +       if (!reg)
> +               return -ENOMEM;
> +
> +       prv_data =3D devm_kzalloc(&pdev->dev, config->num_records *
> +                               sizeof(struct stats_prv_data), GFP_KERNEL=
);

We have devm_kcalloc() for array allocations.

> +       if (!prv_data)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < config->num_records; i++)
> +               prv_data[i].config =3D config;
> +
> +       root =3D create_debugfs_entries(reg, prv_data);
> +       platform_set_drvdata(pdev, root);
> +
> +       return 0;
> +}
