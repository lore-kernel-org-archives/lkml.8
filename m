Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05454C11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E9F24656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgBTKwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 05:52:42 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2447 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726700AbgBTKwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 05:52:42 -0500
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id ED46A89E090926DFCD66;
        Thu, 20 Feb 2020 10:52:39 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml701-cah.china.huawei.com (10.201.108.42) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 20 Feb 2020 10:52:39 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 20 Feb
 2020 10:52:39 +0000
Subject: Re: Questions about logic_pio
To:     Wei Xu <xuwei5@hisilicon.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        bhelgaas <bhelgaas@google.com>,
        andyshevchenko <andy.shevchenko@gmail.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1705dbe62ce.10ae800394772.9222265269135747883@flygoat.com>
 <5E4E55F7.70800@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <e3ddd7de-54b2-bdba-2233-6ace40072430@huawei.com>
Date:   Thu, 20 Feb 2020 10:52:38 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <5E4E55F7.70800@hisilicon.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml738-chm.china.huawei.com (10.201.108.188) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Arnd (also remove some defunct e-mail addresses)

On 20/02/2020 09:48, Wei Xu wrote:
> Hi Jiaxun,
> 
> On 2020/2/19 21:58, Jiaxun Yang wrote:
>> Hi there,
>>
>> Logic PIO gives us a way to make indirect PIO access, however,
>> the way it handles direct (MMIO) I/O access confused me.
>>
>> I was trying to create a PCI controller Driver and noticed that I/O range parsed
>> from DeviceTree will be added to the Logic PIO range by logic_pio_register_range.
>> And than PCI subsystem will use the ioport obtained from `logic_pio_trans_cpuaddr`
>> to allocate resources for the host bridge. In my case, the range added to the logic pio
>>   was set as hw_start 0x4000, size 0x4000.

FYI, For when CONFIG_INDIRECT_PIO is defined, in logical PIO space, we 
reserve the last 0x4000 bytes for Indirectio, while the rest is 
available for MMIO. When CONFIG_INDIRECT_PIO is not defined, all Logical 
PIO space is available for MMIO.

  Later, `logic_pio_trans_cpuaddr` called
>> by `pci_address_to_pio` gives a ioport of 0x0, which is totally wrong.

ioport of 0x0 seems fine. Here is my IO port listing for my host (which 
defines PCI_IOBASE):

00000000-0000ffff : PCI Bus 0002:f8
   00001000-00001fff : PCI Bus 0002:f9
     00001000-00001007 : 0002:f9:00.0
       00001000-00001007 : serial
     00001008-0000100f : 0002:f9:00.1
       00001008-0000100f : serial
     00001010-00001017 : 0002:f9:00.2
     00001018-0000101f : 0002:f9:00.2
00010000-0001ffff : PCI Bus 0004:88
00020000-0002ffff : PCI Bus 0005:78
00030000-0003ffff : PCI Bus 0006:c0
00040000-0004ffff : PCI Bus 0007:90
00050000-0005ffff : PCI Bus 000a:10
00060000-0006ffff : PCI Bus 000c:20
00070000-0007ffff : PCI Bus 000d:30
00ffc0e3-00ffc0e7 : hisi-lpc-ipmi.5.auto
00ffc2f7-00ffffff : serial8250.6.auto
   00ffc2f7-00ffc2fe : serial

>>
>> After dig into logic pio logic, I found that logic pio is trying to "allocate" an io_start
>> for MMIO ranges, the allocation starts from 0x0. And later the io_start is used to calculate
>> cpu_address.  In my opinion, for direct MMIO access, logic_pio address should always
>> equal to hw address,

I'm not sure what you mean by simply the hw address.

So there is the physical cpu address of the host bridge IO ports, and 
these host bridge IO ports are mapped in pci_remap_iospace() to some 
part of logical PIO space. The base of the logical PIO space corresponds 
to PCI_IOBASE virtual address.

  because there is no way to translate address from logic pio address
>> to actual hw address in {in,out}{b,sb,w,sb,l,sl} operations.

Please check 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/logic_pio.c?h=v5.6-rc2#n231 
for reference:

#if defined(CONFIG_INDIRECT_PIO) && defined(PCI_IOBASE)
#define BUILD_LOGIC_IO(bw, type)					\
type logic_in##bw(unsigned long addr)					\{									\	type ret = 
(type)~0;						\									\	if (addr < MMIO_UPPER_LIMIT) {					\		ret = 
read##bw(PCI_IOBASE + addr);			\	} else if (addr >= MMIO_UPPER_LIMIT && 
addr < IO_SPACE_LIMIT) { \		struct logic_pio_hwaddr *entry = 
find_io_range(addr);	\									\		if (entry)						\			ret = 
entry->ops->in(entry->hostdata,		\					addr, sizeof(type));		\		else				 
		\			WARN_ON_ONCE(1);				\	}								\	return ret;							\}											

For when the IO port address is within the MMIO range (addr < 
MMIO_UPPER_LIMIT), we use readl(PCI_IOBASE + addr); please remember that 
PCI_IOBASE virtual address is mapped to the physical host bridge IO port 
address.

For when CONFIG_INDIRECT_PIO is not defined, we use the asm generic version:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/asm-generic/io.h?h=v5.6-rc2#n461

As an aside, I do notice that the definitions here have changed here in 
87fe2d543f81 ("io: change inX() to have their own IO barrier overrides") 
since we introduced logic PIO.

>>
>> How this mechanism intends to work? 

I hope the above description makes this clearer.

What is the reason that we are trying to
>> allocate a io_start for MMIO rather than take their hw_start ioport directly?

For PCI MMIO, the io_start is the Logical PIO range start address.

>>
>> Thanks.
> 
> Corrected John's mail address.
> Maybe he can help.

Thanks to xuwei

> 
> Best Regards,
> Wei
> 
>>
>> --
>> Jiaxun Yang
>>
>>
>>
>> .
>>
> 
> .
> 

