Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1212 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729977AbgCKPsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:48:11 -0400
Subject: Re: [PATCH V5 0/5] Add support for PCIe endpoint mode in Tegra194
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <thierry.reding@gmail.com>
CC: <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <jonathanh@nvidia.com>, <andrew.murray@arm.com>, <kishon@ti.com>,
        <gustavo.pimentel@synopsys.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20200303181052.16134-1-vidyas@nvidia.com>
 <20200311105141.GA30083@e121166-lin.cambridge.arm.com>
From: Vidya Sagar <vidyas@nvidia.com>
Message-ID: <e49b3c8d-f669-007b-5d35-b8ec4f0529aa@nvidia.com>
Date: Wed, 11 Mar 2020 21:18:02 +0530
MIME-Version: 1.0
In-Reply-To: <20200311105141.GA30083@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/11/2020 4:22 PM, Lorenzo Pieralisi wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, Mar 03, 2020 at 11:40:47PM +0530, Vidya Sagar wrote:
>> Tegra194 has three (C0, C4 & C5) dual mode PCIe controllers that can operate
>> either in root port mode or in end point mode but only in one mode at a time.
>> Platform P2972-0000 supports enabling endpoint mode for C5 controller. This
>> patch series adds support for PCIe endpoint mode in both the driver as well as
>> in DT.
>> This patch series depends on the changes made for Synopsys DesignWare endpoint
>> mode subsystem that are recently accepted.
>> @ https://patchwork.kernel.org/project/linux-pci/list/?series=202211
>> which in turn depends on the patch made by Kishon
>> @ https://patchwork.kernel.org/patch/10975123/
>> which is also under review.
>>
>> V5:
>> * Rebased patch-2 on top of Lorenzo's pci/endpoint branch
>> * Removed unwanted header files inclusion in patch-5
> 
> Applied patches 1,2,5 to pci/endpoint for v5.7, please let me know
> if something is missing.
Thanks Lorenzo and Thierry.

Thanks,
Vidya Sagar

> 
> Thanks,
> Lorenzo
> 
>> V4:
>> * Started using threaded irqs instead of kthreads
>>
>> V3:
>> * Re-ordered patches in the series to make the driver change as the last patch
>> * Took care of Thierry's review comments
>>
>> V2:
>> * Addressed Thierry & Bjorn's review comments
>> * Added EP mode specific binding documentation to already existing binding documentation file
>> * Removed patch that enables GPIO controller nodes explicitly as they are enabled already
>>
>> Vidya Sagar (5):
>>    soc/tegra: bpmp: Update ABI header
>>    dt-bindings: PCI: tegra: Add DT support for PCIe EP nodes in Tegra194
>>    arm64: tegra: Add PCIe endpoint controllers nodes for Tegra194
>>    arm64: tegra: Add support for PCIe endpoint mode in P2972-0000
>>      platform
>>    PCI: tegra: Add support for PCIe endpoint mode in Tegra194
>>
>>   .../bindings/pci/nvidia,tegra194-pcie.txt     | 125 +++-
>>   .../boot/dts/nvidia/tegra194-p2972-0000.dts   |  18 +
>>   arch/arm64/boot/dts/nvidia/tegra194.dtsi      |  99 +++
>>   drivers/pci/controller/dwc/Kconfig            |  30 +-
>>   drivers/pci/controller/dwc/pcie-tegra194.c    | 679 +++++++++++++++++-
>>   include/soc/tegra/bpmp-abi.h                  |  10 +-
>>   6 files changed, 916 insertions(+), 45 deletions(-)
>>
>> --
>> 2.17.1
>>

