Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1FDC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8173C206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgANOsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:48:21 -0500
Received: from foss.arm.com ([217.140.110.172]:53184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgANOsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 09:48:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 978E21435;
        Tue, 14 Jan 2020 06:48:20 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3A443F68E;
        Tue, 14 Jan 2020 06:48:19 -0800 (PST)
Date:   Tue, 14 Jan 2020 14:48:17 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>
Cc:     Linuxarm <linuxarm@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cpu-topology: Skip the exist but not possible cpu
 nodes
Message-ID: <20200114144817.GB48816@bogus>
References: <1578725620-39677-1-git-send-email-prime.zeng@hisilicon.com>
 <20200113101922.GE52694@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340E41D1@DGGEMM506-MBX.china.huawei.com>
 <20200113122101.GA49933@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340E59BA@DGGEMM506-MBX.china.huawei.com>
 <20200114102956.GB10403@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340E6EE9@DGGEMM506-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED340E6EE9@DGGEMM506-MBX.china.huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 12:17:41PM +0000, Zengtao (B) wrote:
[...]

> Thanks very much for your explanation.
> So finally it turns into a very simple patch like this, more cleaner:
> +/*
> + * This function returns the logic cpu number of the node.
> + * There are basically three kinds of return values:
> + * (1) logic cpu number which is > 0.
> + * (2) -ENDEV when the node is valid one which can be found in the device tree

s/ENDEV/ENODEV/ again :)

> + * but there is no possible cpu nodes to match, when the CONFIG_NR_CPUS is
> + * smaller than cpus node numbers in device tree, this will happen. It's
> + * suggested to just ignore this case.
> + * (3) -1 if the node does not exist in the device tree
> + */
>  static int __init get_cpu_for_node(struct device_node *node)
>  {
>         struct device_node *cpu_node;
> @@ -261,7 +271,8 @@ static int __init get_cpu_for_node(struct device_node *node)
>         if (cpu >= 0)
>                 topology_parse_cpu_capacity(cpu_node, cpu);
>         else
> -               pr_crit("Unable to find CPU node for %pOF\n", cpu_node);
> +               pr_info("CPU node for %pOF exist but the possible cpu range is :%*pbl\n",
> +                       cpu_node, cpumask_pr_args(cpu_possible_mask));
> 
>         of_node_put(cpu_node);
>         return cpu;
> @@ -286,9 +297,8 @@ static int __init parse_core(struct device_node *core, int package_id,
>                                 cpu_topology[cpu].package_id = package_id;
>                                 cpu_topology[cpu].core_id = core_id;
>                                 cpu_topology[cpu].thread_id = i;
> -                       } else {
> -                               pr_err("%pOF: Can't get CPU for thread\n",
> -                                      t);
> +                       } else if (cpu != -ENODEV) {
> +                               pr_err("%pOF: Can't get CPU for thread\n", t);
>                                 of_node_put(t);
>                                 return -EINVAL;
>                         }
> @@ -307,7 +317,7 @@ static int __init parse_core(struct device_node *core, int package_id,
> 
>                 cpu_topology[cpu].package_id = package_id;
>                 cpu_topology[cpu].core_id = core_id;
> -       } else if (leaf) {
> +       } else if (leaf && cpu != -ENODEV) {
>                 pr_err("%pOF: Can't get CPU for leaf core\n", core);
>                 return -EINVAL;
>         }
> 
> Any more suggestions?

None except the above minor nit. I will wait for v3 before I give ack/review
tag. Thanks for the patience.

--
Regards,
Sudeep
