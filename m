Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3615CC11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 09:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B6124656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 09:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgBTJsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 04:48:52 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10659 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726637AbgBTJsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 04:48:52 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5400122256452FC430FA;
        Thu, 20 Feb 2020 17:48:49 +0800 (CST)
Received: from [127.0.0.1] (10.57.101.250) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Thu, 20 Feb 2020
 17:48:39 +0800
Subject: Re: Questions about logic_pio
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        yuanzhichang <yuanzhichang@hisilicon.com>,
        <john.garry@huawei.com>,
        gabrielepaoloni <gabriele.paoloni@huawei.com>,
        bhelgaas <bhelgaas@google.com>,
        andyshevchenko <andy.shevchenko@gmail.com>
References: <1705dbe62ce.10ae800394772.9222265269135747883@flygoat.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5E4E55F7.70800@hisilicon.com>
Date:   Thu, 20 Feb 2020 17:48:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <1705dbe62ce.10ae800394772.9222265269135747883@flygoat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.101.250]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiaxun,

On 2020/2/19 21:58, Jiaxun Yang wrote:
> Hi there,
> 
> Logic PIO gives us a way to make indirect PIO access, however,
> the way it handles direct (MMIO) I/O access confused me.
> 
> I was trying to create a PCI controller Driver and noticed that I/O range parsed
> from DeviceTree will be added to the Logic PIO range by logic_pio_register_range. 
> And than PCI subsystem will use the ioport obtained from `logic_pio_trans_cpuaddr`
> to allocate resources for the host bridge. In my case, the range added to the logic pio
>  was set as hw_start 0x4000, size 0x4000. Later, `logic_pio_trans_cpuaddr` called
> by `pci_address_to_pio` gives a ioport of 0x0, which is totally wrong.
> 
> After dig into logic pio logic, I found that logic pio is trying to "allocate" an io_start
> for MMIO ranges, the allocation starts from 0x0. And later the io_start is used to calculate
> cpu_address.  In my opinion, for direct MMIO access, logic_pio address should always
> equal to hw address, because there is no way to translate address from logic pio address
> to actual hw address in {in,out}{b,sb,w,sb,l,sl} operations.
> 
> How this mechanism intends to work? What is the reason that we are trying to
> allocate a io_start for MMIO rather than take their hw_start ioport directly?
> 
> Thanks. 

Corrected John's mail address.
Maybe he can help.

Best Regards,
Wei

> 
> --
> Jiaxun Yang
> 
> 
> 
> .
> 

