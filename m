Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B68C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 10:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C8A20754
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 10:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgCTK0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 06:26:19 -0400
Received: from foss.arm.com ([217.140.110.172]:47118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbgCTK0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 06:26:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D07DD31B;
        Fri, 20 Mar 2020 03:26:17 -0700 (PDT)
Received: from [10.57.21.157] (unknown [10.57.21.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C1B83F305;
        Fri, 20 Mar 2020 03:26:13 -0700 (PDT)
Subject: Re: [PATCH 2/2] Documentation/vmcoreinfo: Add documentation for
 'KERNELPACMASK'
To:     John Donnelly <John.P.Donnelly@Oracle.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        Dave Anderson <anderson@redhat.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Will Deacon <will@kernel.org>
References: <1584603551-23845-1-git-send-email-amit.kachhap@arm.com>
 <1584603551-23845-2-git-send-email-amit.kachhap@arm.com>
 <5235269c-e3c7-efff-6083-a05a39699735@Oracle.com>
From:   Amit Kachhap <amit.kachhap@arm.com>
Message-ID: <3d8eb414-c70c-f97b-b2e0-376ebd99403c@arm.com>
Date:   Fri, 20 Mar 2020 15:56:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5235269c-e3c7-efff-6083-a05a39699735@Oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/19/20 7:21 PM, John Donnelly wrote:
> On 3/19/20 2:39 AM, Amit Daniel Kachhap wrote:
>> Add documentation for KERNELPACMASK variable being added to vmcoreinfo.
>>
>> It indicates the PAC bits mask information of signed kernel pointers if
>> ARMv8.3-A Pointer Authentication feature is present.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Dave Anderson <anderson@redhat.com>
>> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
>> ---
>>   Documentation/admin-guide/kdump/vmcoreinfo.rst | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst 
>> b/Documentation/admin-guide/kdump/vmcoreinfo.rst
>> index 007a6b8..5cc3ee6 100644
>> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
>> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
>> @@ -393,6 +393,12 @@ KERNELOFFSET
>>   The kernel randomization offset. Used to compute the page offset. If
>>   KASLR is disabled, this value is zero.
>> +KERNELPACMASK
>> +-------------
>> +
>> +Indicates the PAC bits mask information if Pointer Authentication is
>> +enabled and address authentication feature is present.
>> +
>>   arm
>>   ===
>>
>>
> 
> 
> Hi,
> 
> Does this require changes to the  makedumpfile or crash utilities ?

I did the corresponding change in crash tool. The link is mentioned in 
first patch of the series.

Thanks,
Amit Daniel
> 
> 
> 
