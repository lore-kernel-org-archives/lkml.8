Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591DBC3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8B22187F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgCBMfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 07:35:20 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2493 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727519AbgCBMfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 07:35:19 -0500
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 5CB611CD9B5172B7698A;
        Mon,  2 Mar 2020 12:35:18 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml703-cah.china.huawei.com (10.201.108.44) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 2 Mar 2020 12:35:18 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 2 Mar 2020
 12:35:17 +0000
Subject: Re: About commit "io: change inX() to have their own IO barrier
 overrides"
To:     Sinan Kaya <okaya@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC:     "xuwei (O)" <xuwei5@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <2e80d7bc-32a0-cc40-00a9-8a383a1966c2@huawei.com>
 <c1489f55-369d-2cff-ff36-b10fb5d3ee79@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <8207cd51-5b94-2f15-de9f-d85c9c385bca@huawei.com>
Date:   Mon, 2 Mar 2020 12:35:17 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <c1489f55-369d-2cff-ff36-b10fb5d3ee79@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sinan,

Thanks for getting back to me.

> On 2/28/2020 4:52 AM, John Garry wrote:
>> About the commit in the $subject 87fe2d543f81, would there be any
>> specific reason why the logic pio versions of these functions did not
>> get the same treatment 

In fact, your changes and the logic PIO changes went in at the same time.

or should not? I'm talking about lib/logic_pio.c
>> here - commit 031e3601869c ("lib: Add generic PIO mapping method")
>> introduced this.
>>
>> In fact, logic pio will override these for arm64 with the vanilla
>> defconfig these days.
> 
> We only looked at inX()/inY() and readX()/writeX() API because the
> semantics of these API are defined in the kernel documentation.

Could we consider adding __io_pbr() et al to the kernel Documentation? I 
couldn't find them and I had to rely on checking 64e2c67738 ("io: define 
several IO & PIO barrier types for the asm-generic version") commit 
message to find the definition.

> We looked at how to generalize this so that there is a uniform
> behavior across different architectures.
> 
> Is logic PIO subject to ordering issues?

Well the point is that we're still concerned here with using 
readX/writeX for MMIO-based IO port accesses, see *** from logic_pio.c:

#define BUILD_LOGIC_IO(bw, type)					
type logic_in##bw(unsigned long addr)					
{									
	type ret = (type)~0;						
	if (addr < MMIO_UPPER_LIMIT) {					
		ret = read##bw(PCI_IOBASE + addr); ***	
	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {
		struct logic_pio_hwaddr *entry = find_io_range(addr);	
									
		if (entry)						
			ret = entry->ops->in(entry->hostdata,		
					addr, sizeof(type));		
		else							
			WARN_ON_ONCE(1);				
	}								
	return ret;							
}		

 > How is the behavior on different architectures?

So today only ARM64 uses it for this relevant code, above. But maybe 
others in future will want to use it - any arch without native IO port 
access is a candidate.

> 
> As long as the expectations are set, I see no reason why it shouldn't
> but, I'll let Arnd comment on it too.

ok, so it looks reasonable consider replicating your change for ***, above.

Thanks,
John
