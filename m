Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C965DC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 02:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DE12076A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 02:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgCZCoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 22:44:19 -0400
Received: from mail.loongson.cn ([114.242.206.163]:47746 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727585AbgCZCoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 22:44:19 -0400
Received: from [10.130.0.79] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxn9_2Fnxeeh4gAA--.2S3;
        Thu, 26 Mar 2020 10:44:07 +0800 (CST)
Subject: Re: [PATCH v2 2/3] MIPS: Loongson: Add DMA support for 7A1000
To:     Christoph Hellwig <hch@infradead.org>
References: <1584932355-3642-1-git-send-email-yangtiezhu@loongson.cn>
 <1584932355-3642-3-git-send-email-yangtiezhu@loongson.cn>
 <20200325132756.GA13750@infradead.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <821ab35b-72d8-59e0-98cb-f5b199ae3a2f@loongson.cn>
Date:   Thu, 26 Mar 2020 10:44:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20200325132756.GA13750@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dxn9_2Fnxeeh4gAA--.2S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Gw17Zr1kWF1rtrWfAr17GFg_yoW8Jr4UpF
        s7XFWrCr1UKryUWFZ2vaykWr1YvrW5Cr9xWFWDCF90kas0q34jqa1Dta1jgas0qw1UCrs7
        Xa97JayfZF4UGw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE
        67vIY487MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
        73UjIFyTuYvjfUO_MaUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/25/2020 09:27 PM, Christoph Hellwig wrote:
> On Mon, Mar 23, 2020 at 10:59:14AM +0800, Tiezhu Yang wrote:
>> Implement __phys_to_dma() and __dma_to_phys() according to the
>> node id offset in the 7A1000 DMA route config register.
> Can you please try to just use the dma_pfn_offset field in struct device
> for all loongson platforms?  I'm pretty sure I asked for that last time
> around..

Oh, sorry, I don't quite understand what you mean last time.

Do you mean use the default implementation in include/linux/dma-direct.h
when CONFIG_ARCH_HAS_PHYS_TO_DMA is not set?

#ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
#include <asm/dma-direct.h>
#else
static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t 
paddr)
{
         dma_addr_t dev_addr = (dma_addr_t)paddr;

         return dev_addr - ((dma_addr_t)dev->dma_pfn_offset << PAGE_SHIFT);
}

static inline phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t 
dev_addr)
{
         phys_addr_t paddr = (phys_addr_t)dev_addr;

         return paddr + ((phys_addr_t)dev->dma_pfn_offset << PAGE_SHIFT);
}
#endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */

If so, I will verify it used with the AMD RS780E and Loongson 7A1000 
bridge chip.

Thanks,

Tiezhu Yang

