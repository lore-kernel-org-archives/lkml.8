Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9935C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C161720709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgICR7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 13:59:11 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:45298 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgICR7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 13:59:08 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Bj7pv2kRxz9vG1d;
        Thu,  3 Sep 2020 19:59:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id GpPnJOAGb8-M; Thu,  3 Sep 2020 19:59:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Bj7pv1bKMz9vG1Z;
        Thu,  3 Sep 2020 19:59:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 03E038B805;
        Thu,  3 Sep 2020 19:59:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id gRZ56r8LcyT0; Thu,  3 Sep 2020 19:59:04 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6AC828B803;
        Thu,  3 Sep 2020 19:59:02 +0200 (CEST)
Subject: Re: [PATCH 1/2] dma-mapping: introduce
 dma_get_seg_boundary_nr_pages()
To:     Christoph Hellwig <hch@lst.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-ia64@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Helge Deller <deller@gmx.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Vasily Gorbik <gor@linux.ibm.com>, schnelle@linux.ibm.com,
        hca@linux.ibm.com, Nicolin Chen <nicoleotsuka@gmail.com>,
        ink@jurassic.park.msu.ru, Thomas Gleixner <tglx@linutronix.de>,
        gerald.schaefer@linux.ibm.com, rth@twiddle.net,
        Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-alpha@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>
References: <20200901221646.26491-1-nicoleotsuka@gmail.com>
 <20200901221646.26491-2-nicoleotsuka@gmail.com>
 <CAHp75VcVJBSnPQ6NfdF8FdEDfM+oQ=Sr+cH5VGX4SrAqrgpf-g@mail.gmail.com>
 <20200903161252.GA24841@lst.de>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <7e1c3632-0917-0892-c1ca-8048674a3b05@csgroup.eu>
Date:   Thu, 3 Sep 2020 19:53:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200903161252.GA24841@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 03/09/2020 à 18:12, Christoph Hellwig a écrit :
> On Thu, Sep 03, 2020 at 01:57:39PM +0300, Andy Shevchenko wrote:
>>> +{
>>> +       if (!dev)
>>> +               return (U32_MAX >> page_shift) + 1;
>>> +       return (dma_get_seg_boundary(dev) >> page_shift) + 1;
>>
>> Can it be better to do something like
>>    unsigned long boundary = dev ? dma_get_seg_boundary(dev) : U32_MAX;
>>
>>    return (boundary >> page_shift) + 1;
>>
>> ?
> 
> I don't really see what that would buy us.
> 

I guess it would avoid the duplication of    >> page_shift) + 1

Christophe
