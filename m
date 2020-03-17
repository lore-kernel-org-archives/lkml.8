Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C46C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B60F20738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgCQQeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 12:34:46 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2569 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726924AbgCQQeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:34:44 -0400
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 55B5C956EB33F56154FC;
        Tue, 17 Mar 2020 16:34:43 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML711-CAH.china.huawei.com (10.201.108.34) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 17 Mar 2020 16:34:42 +0000
Received: from [127.0.0.1] (10.47.11.44) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 17 Mar
 2020 16:34:42 +0000
Subject: Re: [PATCH 11/11] EDAC/ghes: Create one memory controller per
 physical memory array
To:     Borislav Petkov <bp@alien8.de>,
        Robert Richter <rrichter@marvell.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Toshi Kani <toshi.kani@hpe.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        Shiju Jose <shiju.jose@huawei.com>
References: <20200306151318.17422-1-rrichter@marvell.com>
 <20200306151318.17422-12-rrichter@marvell.com>
 <20200316095149.GE26126@zn.tnic>
From:   John Garry <john.garry@huawei.com>
Message-ID: <924f4c0e-1f9d-e7de-17cd-466eb3a74d90@huawei.com>
Date:   Tue, 17 Mar 2020 16:34:32 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200316095149.GE26126@zn.tnic>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.11.44]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2020 09:51, Borislav Petkov wrote:
> On Fri, Mar 06, 2020 at 04:13:18PM +0100, Robert Richter wrote:
>> The ghes driver only creates one memory controller for the whole
>> system. This does not reflect memory topology especially in multi-node
>> systems. E.g. a Marvell ThunderX2 system shows:
>>
>>   /sys/devices/system/edac/mc/mc0/dimm0
>>   /sys/devices/system/edac/mc/mc0/dimm1
>>   /sys/devices/system/edac/mc/mc0/dimm2
>>   /sys/devices/system/edac/mc/mc0/dimm3
>>   /sys/devices/system/edac/mc/mc0/dimm4
>>   /sys/devices/system/edac/mc/mc0/dimm5
>>   /sys/devices/system/edac/mc/mc0/dimm6
>>   /sys/devices/system/edac/mc/mc0/dimm7
>>   /sys/devices/system/edac/mc/mc0/dimm8
>>   /sys/devices/system/edac/mc/mc0/dimm9
>>   /sys/devices/system/edac/mc/mc0/dimm10
>>   /sys/devices/system/edac/mc/mc0/dimm11
>>   /sys/devices/system/edac/mc/mc0/dimm12
>>   /sys/devices/system/edac/mc/mc0/dimm13
>>   /sys/devices/system/edac/mc/mc0/dimm14
>>   /sys/devices/system/edac/mc/mc0/dimm15
>>
>> The DIMMs 9-15 are located on the 2nd node of the system. On
>> comparable x86 systems there is one memory controller per node. The
>> ghes driver should also group DIMMs depending on the topology and
>> create one MC per node.
>>
>> There are several options to detect the topology. ARM64 systems
>> retrieve the (NUMA) node information from the ACPI SRAT table (see
>> acpi_table_parse_srat()). The node id is later stored in the physical
>> address page. The pfn_to_nid() macro could be used for a DIMM after
>> determining its physical address. The drawback of this approach is
>> that there are too many subsystems involved it depends on. It could
>> easily break and makes the implementation complex. E.g. pfn_to_nid()
>> can only be reliable used on mapped address ranges which is not always
>> granted, there are various firmware instances involved which could be
>> broken, or results may vary depending on NUMA settings.
>>
>> Another approach that was suggested by James' is to use the DIMM's
>> physical memory array handle to group DIMMs [1]. The advantage is to
>> only use the information on memory devices from the SMBIOS table that
>> contains a reference to the physical memory array it belongs too. This
>> information is mandatory same as the use of DIMM handle references by
>> GHES to provide the DIMM location of an error. There is only a single
>> table to parse which eases implementation. This patch uses this
>> approach for DIMM grouping.
>>
>> Modify the DMI decoder to also detect the physical memory array a DIMM
>> is linked to and create one memory controller per array to group
>> DIMMs. With the change DIMMs are grouped, e.g. a ThunderX2 system
>> shows one MC per node now:
>>
>>   # grep . /sys/devices/system/edac/mc/mc*/dimm*/dimm_label
>>   /sys/devices/system/edac/mc/mc0/dimm0/dimm_label:N0 DIMM_A0
>>   /sys/devices/system/edac/mc/mc0/dimm1/dimm_label:N0 DIMM_B0
>>   /sys/devices/system/edac/mc/mc0/dimm2/dimm_label:N0 DIMM_C0
>>   /sys/devices/system/edac/mc/mc0/dimm3/dimm_label:N0 DIMM_D0
>>   /sys/devices/system/edac/mc/mc0/dimm4/dimm_label:N0 DIMM_E0
>>   /sys/devices/system/edac/mc/mc0/dimm5/dimm_label:N0 DIMM_F0
>>   /sys/devices/system/edac/mc/mc0/dimm6/dimm_label:N0 DIMM_G0
>>   /sys/devices/system/edac/mc/mc0/dimm7/dimm_label:N0 DIMM_H0
>>   /sys/devices/system/edac/mc/mc1/dimm0/dimm_label:N1 DIMM_I0
>>   /sys/devices/system/edac/mc/mc1/dimm1/dimm_label:N1 DIMM_J0
>>   /sys/devices/system/edac/mc/mc1/dimm2/dimm_label:N1 DIMM_K0
>>   /sys/devices/system/edac/mc/mc1/dimm3/dimm_label:N1 DIMM_L0
>>   /sys/devices/system/edac/mc/mc1/dimm4/dimm_label:N1 DIMM_M0
>>   /sys/devices/system/edac/mc/mc1/dimm5/dimm_label:N1 DIMM_N0
>>   /sys/devices/system/edac/mc/mc1/dimm6/dimm_label:N1 DIMM_O0
>>   /sys/devices/system/edac/mc/mc1/dimm7/dimm_label:N1 DIMM_P0
>>
>> [1] https://lkml.kernel.org/r/f878201f-f8fd-0f2a-5072-ba60c64eefaf@arm.com
>>
>> Suggested-by: James Morse <james.morse@arm.com>
>> Signed-off-by: Robert Richter <rrichter@marvell.com>
>> ---
>>   drivers/edac/ghes_edac.c | 137 ++++++++++++++++++++++++++++++---------
>>   1 file changed, 107 insertions(+), 30 deletions(-)
> 
> This is all fine and good but that change affects the one x86 platform
> we support so the whole patchset should be tested there too. Adding
> Toshi.
> 
> As a matter of fact, the final version of this set should be tested on
> all platforms which are using this thing. Adding John Garry too who
> reported issues with this driver recently on his platform.

Adding other RAS-centric guys for H.

Cheers,
John

> 
> Thx.
> 

