Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D74C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 15:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948F524686
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 15:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgA1PUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 10:20:45 -0500
Received: from foss.arm.com ([217.140.110.172]:59338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbgA1PUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 10:20:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC4AB31B;
        Tue, 28 Jan 2020 07:20:43 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 727093F68E;
        Tue, 28 Jan 2020 07:20:42 -0800 (PST)
Date:   Tue, 28 Jan 2020 15:20:40 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     John Garry <john.garry@huawei.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, jeremy.linton@arm.com,
        arnd@arndb.de, olof@lixom.net, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, guohanjun@huawei.com,
        gregkh@linuxfoundation.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH RFC 2/2] soc: Add a basic ACPI generic driver
Message-ID: <20200128152040.GC47557@bogus>
References: <1580210059-199540-1-git-send-email-john.garry@huawei.com>
 <1580210059-199540-3-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580210059-199540-3-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(commenting on other parts though I am not sure if we want to add this
despite it being deprecated)

On Tue, Jan 28, 2020 at 07:14:19PM +0800, John Garry wrote:
> Add a generic driver for platforms which populate their ACPI PPTT
> processor package ID Type Structure according to suggestion in the ACPI
> spec - see ACPI 6.2, section 5.2.29.3 ID structure Type 2.
>
> The soc_id is from member LEVEL_2_ID.
>
> For this, we need to use a whitelist of platforms which are known to
> populate the structure as suggested.
>
> For now, only the vendor and soc_id fields are exposed.
>
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/soc/Makefile       |   1 +
>  drivers/soc/acpi_generic.c | 102 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 103 insertions(+)
>  create mode 100644 drivers/soc/acpi_generic.c
>
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 8b49d782a1ab..2a59a30a22cd 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -3,6 +3,7 @@
>  # Makefile for the Linux Kernel SOC specific device drivers.
>  #
>
> +obj-$(CONFIG_ACPI_PPTT)		+= acpi_generic.o
>  obj-$(CONFIG_ARCH_ACTIONS)	+= actions/
>  obj-$(CONFIG_SOC_ASPEED)	+= aspeed/
>  obj-$(CONFIG_ARCH_AT91)		+= atmel/
> diff --git a/drivers/soc/acpi_generic.c b/drivers/soc/acpi_generic.c
> new file mode 100644
> index 000000000000..34a1f5f8e063
> --- /dev/null
> +++ b/drivers/soc/acpi_generic.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) John Garry, john.garry@huawei.com
> + */
> +
> +#define pr_fmt(fmt) "SOC ACPI GENERIC: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/sys_soc.h>
> +
> +/*
> + * Known platforms that fill in PPTT package ID structures according to
> + * ACPI spec examples, that being:
> + * - Custom driver attribute is in ID Type Structure VENDOR_ID member
> + * - SoC id is in ID Type Structure LEVEL_2_ID member
> + *    See ACPI SPEC 6.2 Table 5-154 for PPTT ID Type Structure
> + */
> +static struct acpi_platform_list plat_list[] = {
> +	{"HISI  ", "HIP08   ", 0, ACPI_SIG_PPTT, all_versions},

What do you want to match this ? The same silicon can end up with
different OEMs and this list just blows up soon for single SoC if
used by different OEM/ODMs. I assume we get all the required info
from the Type 2 table entry and hence can just rely on that. If
PPTT has type 2 entry, just initialise this soc driver and expose
the relevant information from the table entry.

--
Regards,
Sudeep
