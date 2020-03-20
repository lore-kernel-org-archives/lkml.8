Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22BAC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 10:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FEF720722
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 10:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgCTKXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 06:23:10 -0400
Received: from foss.arm.com ([217.140.110.172]:47072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbgCTKXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 06:23:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF43131B;
        Fri, 20 Mar 2020 03:23:09 -0700 (PDT)
Received: from [10.37.12.158] (unknown [10.37.12.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B3393F305;
        Fri, 20 Mar 2020 03:23:07 -0700 (PDT)
Subject: Re: [PATCH 2/2] perf: arm_dsu: Support DSU ACPI devices.
To:     tuanphan@amperemail.onmicrosoft.com
Cc:     mark.rutland@arm.com, tuanphan@os.amperecomputing.com,
        linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        patches@amperecomputing.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1584491323-31436-1-git-send-email-tuanphan@os.amperecomputing.com>
 <a571cf7e-c2a5-e8f8-e782-8087249143b0@arm.com>
 <64AE7BB3-F2A9-4A62-82FD-FFF2D6B7101C@amperemail.onmicrosoft.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <ba33d1fa-1afb-941b-0961-dc2394af03c6@arm.com>
Date:   Fri, 20 Mar 2020 10:27:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <64AE7BB3-F2A9-4A62-82FD-FFF2D6B7101C@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tuan

On 03/19/2020 10:49 PM, Tuan Phan wrote:
> Hi Suzuki,
> 
>> On Mar 18, 2020, at 5:45 PM, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> Hello,
>>
>>
>> Please find my comments below.
>>
>> On 03/18/2020 12:28 AM, Tuan Phan wrote:
>>> Add support for probing device from ACPI node.
>>> Each DSU ACPI node defines "cpus" package which
>>> each element is the MPIDR of associated cpu.
>>> Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>

...

>>> +#else /* CONFIG_ACPI */
>>> +	int i, cpu, ret;
>>> +	const union acpi_object *obj;
>>> +	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
>>> +	struct dsu_pmu *dsu_pmu =
>>> +		(struct dsu_pmu *) platform_get_drvdata(pdev);
>>> +
>>
>>> +	ret = acpi_dev_get_property(adev, "cpus", ACPI_TYPE_ANY, &obj);
>>
>> Is the binding documented somewhere ?
>>
>>
>> nit: Also, why not :
>> 	ret = acpi_dev_get_propert(adev, "cpus", ACPI_TYPE_PACKAGE, &obj);
>> 	if (ret < 0)
>> 		return ret;
>> ?
> => I couldn’t find the device tree binding document of DSU anywhere. Is It enough

The DT bindings are here :

Documentation/devicetree/bindings/arm/arm-dsu-pmu.txt

> to put a comment describing the acpi binding in the code or need somewhere else?

The concern here is that we are simply trying to replicate the DT
binding here, especially replacing the CPU phandles with MPIDRs.
I am not an expert in the ACPI bindings, but I prefer ACPI
phandle reference to the CPUs (which is much simpler) to
MPIDRs (which is not that intuitive). And this is the same message
that I got from our ACPI folks.

Irrespective of what we end up with, this must be part of the "ACPI 
bindings" document here :

DEN0093 - Generic ACPI for Arm Components x.y Platform Design Document

So that everybody uses the same bindings irrespective of the OS.
You don't need to document the bindings here with the Linux kernel code.


Kind regards
Suzuki
