Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8D0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1427920708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbgGHHSw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:18:52 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2565 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729972AbgGHHSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:18:51 -0400
Received: from dggemi404-hub.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id CE7EC7E3DC7FCAFBC0BD;
        Wed,  8 Jul 2020 15:18:47 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.177]) by
 dggemi404-hub.china.huawei.com ([10.3.17.142]) with mapi id 14.03.0487.000;
 Wed, 8 Jul 2020 15:18:41 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     "liwei (CM)" <liwei213@huawei.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>
CC:     fengbaopeng <fengbaopeng2@hisilicon.com>,
        "nsaenzjulienne@suse.de" <nsaenzjulienne@suse.de>,
        "steve.capper@arm.com" <steve.capper@arm.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sujunfei <sujunfei2@hisilicon.com>
Subject: RE: [PATCH] arm64: mm: free unused memmap for sparse memory model
 that define VMEMMAP
Thread-Topic: [PATCH] arm64: mm: free unused memmap for sparse memory model
 that define VMEMMAP
Thread-Index: AQHWVMrtlX9AbygsxkCkGlEoK5gXXaj9QcNg
Date:   Wed, 8 Jul 2020 07:18:39 +0000
Message-ID: <B926444035E5E2439431908E3842AFD255E7A1@DGGEMI525-MBS.china.huawei.com>
References: <20200708015555.14946-1-liwei213@huawei.com>
In-Reply-To: <20200708015555.14946-1-liwei213@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.214]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: liwei (CM)
> Sent: Wednesday, July 8, 2020 1:56 PM
> To: catalin.marinas@arm.com; will@kernel.org
> Cc: liwei (CM) <liwei213@huawei.com>; fengbaopeng
> <fengbaopeng2@hisilicon.com>; nsaenzjulienne@suse.de;
> steve.capper@arm.com; rppt@linux.ibm.com; Song Bao Hua (Barry Song)
> <song.bao.hua@hisilicon.com>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; sujunfei <sujunfei2@hisilicon.com>
> Subject: [PATCH] arm64: mm: free unused memmap for sparse memory model
> that define VMEMMAP
> 
> For the memory hole, sparse memory model that define
> SPARSEMEM_VMEMMAP do not free the reserved memory for the page map,
> this patch do it.

Hello Wei,
Just curious if this patch breaks MEMORY_HOTPLUG?

> 
> Signed-off-by: Wei Li <liwei213@huawei.com>
> Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
> Signed-off-by: Xia Qing <saberlily.xia@hisilicon.com>
> ---
>  arch/arm64/mm/init.c | 81
> +++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 71 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c index
> 1e93cfc7c47a..d1b56b47d5ba 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -441,7 +441,48 @@ void __init bootmem_init(void)
>  	memblock_dump_all();
>  }
> 

Thanks
Barry

