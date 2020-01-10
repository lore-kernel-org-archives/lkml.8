Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00731C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B922C20678
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="bnG0n5CN";
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="a3TmIFfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgAJRuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:50:02 -0500
Received: from mx07-00252a01.pphosted.com ([62.209.51.214]:8468 "EHLO
        mx07-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728486AbgAJRuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:50:01 -0500
X-Greylist: delayed 806 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Jan 2020 12:49:59 EST
Received: from pps.filterd (m0102628.ppops.net [127.0.0.1])
        by mx07-00252a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00AHYixs006123
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 17:36:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org; h=subject : to :
 cc : references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp;
 bh=VmrJ62al7CSJqDnZbgM4IQGS6w64QwkkFSJjUF2T67A=;
 b=bnG0n5CNWRLpdwoBy0ZppXxnMv+lNIZF0QOpWYqODOU2OrFw+gMiIYtQnEXo2UMQMinC
 UlGooeJTWUGbtYbhG/Oy5gD6ZvEp8tXD09mYXqTub4S79hg6ILj5zruS8D2bvyJ2JU4O
 j4Cd3pbfdrI/xPCq1+1v8ItnaLad7WR2TDCvw4pJ/BxdaDcUBf5OEziwDqrII62morBh
 aDu91ZXp8bHzwcnIC9bDehykeSGSoV+r2gbvT45OFZ7hi1iRQjJLkRORPFN3AU4XGkel
 LyP+rMx2XgULCsGqJPYY1dGFnVD6NiHcMZ7GW0Phdo0v4QY73tYq/CrxXfFVV+DhgN9h fQ== 
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        by mx07-00252a01.pphosted.com with ESMTP id 2xah08u1a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 17:36:32 +0000
Received: by mail-wm1-f70.google.com with SMTP id p2so1120479wma.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 09:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VmrJ62al7CSJqDnZbgM4IQGS6w64QwkkFSJjUF2T67A=;
        b=a3TmIFfNvj4nYPFfMcdti6+6y11Xg4eEdOHhKxwUmJ8oYyMjA6U9KxONMotcplKM8C
         CZ/hcWsj0dvzLWXnc7WSG+MHyxNY9g/qcmZvauM6yq+7RDn4CMMYZMnEuccMdZKCgn5O
         gkDGb20Yg3UeemE1aB5DuJRncTCp2vopjmP4xDc8Of/k9QRKkXuFBP3BcqxpnksQdNY6
         n9jYSTeC2OXIFLlauIQTzrHY+3fKFAeFI4k19oCqaGc/AeLvFXX55SO218Fsph8eC5OF
         wHVhdxXufcBfIgRYa1jPpaTPu1pHEfIzwpUx1oYk8CEoQgJshFiTQSp62u7fXW1vm+Jw
         Pe/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VmrJ62al7CSJqDnZbgM4IQGS6w64QwkkFSJjUF2T67A=;
        b=P7ALkOkepkYgJLgSsnh8rkY0Z0vzeRpiAvlzO3anxbXSFg1c4uFyYdHVF84JFp189u
         U7GYoUrprwFSGaySx2l7/vjZ+JBgb9qsPqm3rRXQI7PHJJMRMQpuPW1C54t8oaUGCWVU
         nmDJimF3CIePRrMK4JF3PkGR0EeAR4OV5OsLD6pVsotbYWOMRfgZTylOITGQ/FAQR0YS
         jsy3EHymnUKA7RbEPG+AL0+lVvpHvXOM2CS0K1LDT2jD+8ehV3WGWmnEcTQRlS13t+D0
         6f2pgfo14fGtv/pUEesdulCzltK/hm1WlnqQka4aDn6kcyTC9LwOaxSkO2n30zkH5LJ0
         HqaA==
X-Gm-Message-State: APjAAAXgFA56hWGDHC3zpddP0C1oUqW2IrS/4zGsvQjYAmYgjaPT136P
        Muz+zhMG8UImN3eFb2gtiEQtnDStE3fKqWLRhRImwVFsEJUIsDjmcX9JE625IiVcPuUVKZ4YPK6
        aBYm7+dTjxZIJvQ2hIA6xygVU
X-Received: by 2002:a1c:730d:: with SMTP id d13mr5439679wmb.126.1578677791645;
        Fri, 10 Jan 2020 09:36:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqyDvHda/vVFwEomWaXK6Z8R2pnK1KjJdIV8/DNRF6e/NKDIeh18hgbtQkhbdIVwlI8HYnf1gg==
X-Received: by 2002:a1c:730d:: with SMTP id d13mr5439668wmb.126.1578677791447;
        Fri, 10 Jan 2020 09:36:31 -0800 (PST)
Received: from ?IPv6:2a00:1098:3142:14:910a:522a:cf5c:edd0? ([2a00:1098:3142:14:910a:522a:cf5c:edd0])
        by smtp.gmail.com with ESMTPSA id f1sm3134788wmc.45.2020.01.10.09.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 09:36:30 -0800 (PST)
Subject: Re: [PATCH] dma-contiguous: CMA: give precedence to cmdline
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200110171933.15014-1-nsaenzjulienne@suse.de>
From:   Phil Elwell <phil@raspberrypi.org>
Message-ID: <7ae5bad5-eee6-407f-bfa1-aff34f1a0550@raspberrypi.org>
Date:   Fri, 10 Jan 2020 17:36:30 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200110171933.15014-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-10_01:2020-01-10,2020-01-09 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On 10/01/2020 17:19, Nicolas Saenz Julienne wrote:
> Although the device tree might contain a reserved-memory DT node
> dedicated as the default CMA pool, users might want to change CMA's
> parameters using the kernel command line for debugging purposes and
> whatnot. Honor this by bypassing the reserved memory CMA setup, which
> will ultimately end up freeing the memblock and allow the command line
> CMA configuration routine to run.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
> 
> NOTE: Tested this on arm and arm64 with the Raspberry Pi 4.
> 
>   kernel/dma/contiguous.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index daa4e6eefdde..8bc6f2d670f9 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -302,9 +302,16 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
>   	phys_addr_t align = PAGE_SIZE << max(MAX_ORDER - 1, pageblock_order);
>   	phys_addr_t mask = align - 1;
>   	unsigned long node = rmem->fdt_node;
> +	bool default_cma = of_get_flat_dt_prop(node, "linux,cma-default", NULL);
>   	struct cma *cma;
>   	int err;
>   
> +	if (size_cmdline != -1 && default_cma) {
> +		pr_info("Reserved memory: bypass %s node, using cmdline CMA params instead\n",
> +			rmem->name);
> +		return -EBUSY;
> +	}
> +
>   	if (!of_get_flat_dt_prop(node, "reusable", NULL) ||
>   	    of_get_flat_dt_prop(node, "no-map", NULL))
>   		return -EINVAL;
> @@ -322,7 +329,7 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
>   	/* Architecture specific contiguous memory fixup. */
>   	dma_contiguous_early_fixup(rmem->base, rmem->size);
>   
> -	if (of_get_flat_dt_prop(node, "linux,cma-default", NULL))
> +	if (default_cma)
>   		dma_contiguous_set_default(cma);
>   
>   	rmem->ops = &rmem_cma_ops;
> 

For what it's worth,

Reviewed-by: Phil Elwell <phil@raspberrypi.org>

Phil
