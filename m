Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D10C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E775A24683
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgA1Q4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 11:56:22 -0500
Received: from foss.arm.com ([217.140.110.172]:60626 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgA1Q4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 11:56:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29B78328;
        Tue, 28 Jan 2020 08:56:21 -0800 (PST)
Received: from [192.168.122.167] (unknown [10.118.28.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3DBC3F52E;
        Tue, 28 Jan 2020 08:56:20 -0800 (PST)
Subject: Re: [PATCH RFC 0/2] Add basic generic ACPI soc driver
To:     John Garry <john.garry@huawei.com>, rjw@rjwysocki.net,
        lenb@kernel.org
Cc:     arnd@arndb.de, olof@lixom.net, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, guohanjun@huawei.com,
        gregkh@linuxfoundation.org
References: <1580210059-199540-1-git-send-email-john.garry@huawei.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <bb87efe5-d0be-498a-25a1-008a7bebd452@arm.com>
Date:   Tue, 28 Jan 2020 10:56:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1580210059-199540-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/28/20 5:14 AM, John Garry wrote:
> A requirement has come up recently to be able to read system SoC packages
> identifiers from userspace [0].
> 
> For device tree FW-based systems, this would be quite straightforward, in
> that we could add a soc driver for that system and use the DT model
> identifier as the soc id - that's how most soc drivers seem to do it.
> 
> For ACPI-based systems, the only place I know to get (put) such SoC
> information is in the PPTT, specifically the ID Type Structure for a
> processor package node. A processor package node describes a physical
> boundary of a processor topology.

Well presumably that is one of the use cases for DMI, which has fields 
for the processor/socket as well as the machine vendor.

But, quickly looking at the use case, I can't help but think you don't 
really want any of the above, or the PPTT id. It seems the mapping 
should actually be tied directly to the uncore PMU definition, rather 
than a soc/machine/whatever identifier. Which would imply keying off one 
of the ACPI object identifiers for the PMU itself.


> 
> The ACPI spec does not declare how the fields in this structure must be
> used, however it does provide pretty clear examples, which I would expect
> most implementers to follow. As such, I try to solve the problem in 2
> parts:
> - Add ACPI PPTT API to get opaque package structure
> - Add basic ACPI generic soc driver, which can interpret the fields
>    for known platforms to fill in the ID Type Structure as per example
>    in the spec.
> 
> So I'm hoping here for some comments on this approach - hence the RFC.
> I've cc'ed some folks which may have suggestions.
> 
> [0] https://lore.kernel.org/linux-arm-kernel/1579876505-113251-6-git-send-email-john.garry@huawei.com/ ,
>      https://lore.kernel.org/linux-arm-kernel/1579876505-113251-1-git-send-email-john.garry@huawei.com/
> 
> John Garry (2):
>    ACPI/PPTT: Add acpi_pptt_get_package_info() API
>    soc: Add a basic ACPI generic driver
> 
>   drivers/acpi/pptt.c        |  81 +++++++++++++++++++++++++++++
>   drivers/soc/Makefile       |   1 +
>   drivers/soc/acpi_generic.c | 102 +++++++++++++++++++++++++++++++++++++
>   include/linux/acpi.h       |  13 +++++
>   4 files changed, 197 insertions(+)
>   create mode 100644 drivers/soc/acpi_generic.c
> 

