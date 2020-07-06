Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7E4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B479E206CD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgGFKa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 06:30:28 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2428 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727896AbgGFKa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 06:30:28 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 6C1BE820FBC114AEC6D9;
        Mon,  6 Jul 2020 11:30:26 +0100 (IST)
Received: from localhost (10.52.123.111) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 6 Jul 2020
 11:30:25 +0100
Date:   Mon, 6 Jul 2020 11:29:21 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jia He <justin.he@arm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Kaly Xin <Kaly.Xin@arm.com>
Subject: Re: [PATCH 1/3] arm64/numa: set numa_off to false when numa node is
 fake
Message-ID: <20200706112921.00006f7f@Huawei.com>
In-Reply-To: <20200706011947.184166-2-justin.he@arm.com>
References: <20200706011947.184166-1-justin.he@arm.com>
        <20200706011947.184166-2-justin.he@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.111]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jul 2020 09:19:45 +0800
Jia He <justin.he@arm.com> wrote:

Hi,

> Previously, numa_off is set to true unconditionally in dummy_numa_init(),
> even if there is a fake numa node.
> 
> But acpi will translate node id to NUMA_NO_NODE(-1) in acpi_map_pxm_to_node()
> because it regards numa_off as turning off the numa node.

That is correct.  It is operating exactly as it should, if SRAT hasn't been parsed
and you are on ACPI platform there are no nodes.  They cannot be created at
some later date.  The dummy code doesn't change this. It just does enough to carry
on operating with no specified nodes.

> 
> Without this patch, pmem can't be probed as a RAM device on arm64 if SRAT table
> isn't present.
> 
> $ndctl create-namespace -fe namespace0.0 --mode=devdax --map=dev -s 1g -a 64K
> kmem dax0.0: rejecting DAX region [mem 0x240400000-0x2bfffffff] with invalid node: -1
> kmem: probe of dax0.0 failed with error -22
> 
> This fixes it by setting numa_off to false.

Without the SRAT protection patch [1] you may well run into problems
because someone somewhere will have _PXM in a DSDT but will
have a non existent SRAT.   We had this happen on an AMD platform when we
tried to introduce working _PXM support for PCI. [2]

So whilst this seems superficially safe, I'd definitely be crossing your fingers.
Note, at that time I proposed putting the numa_off = false into the x86 code
path precisely to cut out that possibility (was rejected at the time, at least
partly because the clarifications to the ACPI spec were not pubilc.)

The patch in [1] should sort things out however by ensuring we only create
new domains where we should actually be doing so. However, in your case
it will return NUMA_NO_NODE anyway so this isn't the right way to fix things.

[1] https://patchwork.kernel.org/patch/11632063/
[2] https://patchwork.kernel.org/patch/10597777/

Thanks,

Jonathan

> 
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  arch/arm64/mm/numa.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> index aafcee3e3f7e..7689986020d9 100644
> --- a/arch/arm64/mm/numa.c
> +++ b/arch/arm64/mm/numa.c
> @@ -440,7 +440,8 @@ static int __init dummy_numa_init(void)
>  		return ret;
>  	}
>  
> -	numa_off = true;
> +	/* force numa_off to be false since we have a fake numa node here */
> +	numa_off = false;
>  	return 0;
>  }
>  


