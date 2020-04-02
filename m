Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48389C2BA15
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA162073B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732835AbgDBNzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:55:40 -0400
Received: from foss.arm.com ([217.140.110.172]:43052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732349AbgDBNzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:55:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19C6230E;
        Thu,  2 Apr 2020 06:55:39 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4DBC3F52E;
        Thu,  2 Apr 2020 06:55:38 -0700 (PDT)
Subject: Re: [PATCH] ACPI: PPTT: Inform user that table offset used for
 Physical processor node ID
To:     John Garry <john.garry@huawei.com>, rjw@rjwysocki.net,
        lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        sudeep.holla@arm.com, linuxarm@huawei.com, wanghuiqiang@huawei.com
References: <1585830145-208714-1-git-send-email-john.garry@huawei.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <89f68a3c-264a-5d1b-e63a-d1147ea07320@arm.com>
Date:   Thu, 2 Apr 2020 08:55:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1585830145-208714-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/2/20 7:22 AM, John Garry wrote:
> If the the Processor ID valid is not set for a Physical Processor Package
> node, then the node table offset is used as a substitute. As such, we
> may get info like this from sysfs:
> 
> root@(none)$ pwd
> /sys/devices/system/cpu/cpu0/topology
> root@(none)$ more physical_package_id
> 56
> 
> Inform the user of this in the bootlog, as it is much less than ideal, and
> they can remedy this in their FW.
> 
> This topic was originally discussed in:
> https://lore.kernel.org/linux-acpi/c325cfe2-7dbf-e341-7f0f-081b6545e890@huawei.com/T/#m0ec18637d8586f832084a8a6af22580e6174669a
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 4ae93350b70d..b4ed3c818e00 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -515,6 +515,8 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
>   		if (level == 0 ||
>   		    cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID)
>   			return cpu_node->acpi_processor_id;
> +		if (level == PPTT_ABORT_PACKAGE)
> +			pr_notice_once("Physical package node Processor ID valid not set, will use table offset as substitute\n");

What happens in the find_acpi_cpu_topology_hetro_id() case, if the last 
IDENTICAL node isn't a socket/etc. Are we expecting to warn of a missing 
processor container there as well?



>   		return ACPI_PTR_DIFF(cpu_node, table);
>   	}
>   	pr_warn_once("PPTT table found, but unable to locate core %d (%d)\n",
> 

