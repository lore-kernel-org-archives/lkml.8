Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93AEC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 18:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE9520674
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 18:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgBESoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 13:44:12 -0500
Received: from ale.deltatee.com ([207.54.116.67]:55462 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbgBESoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 13:44:11 -0500
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1izPej-0005YR-F5; Wed, 05 Feb 2020 11:44:10 -0700
To:     Arindam Nath <arindam.nath@amd.com>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
References: <cover.1580921119.git.arindam.nath@amd.com>
 <aa4e69feffab2fd3cd846569e0546c5cf8f8f6b4.1580921119.git.arindam.nath@amd.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <761e76e0-2e5e-6c71-3384-1ec10dcf8e88@deltatee.com>
Date:   Wed, 5 Feb 2020 11:44:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <aa4e69feffab2fd3cd846569e0546c5cf8f8f6b4.1580921119.git.arindam.nath@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, sanju.mehta@amd.com, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, arindam.nath@amd.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 3/4] ntb_perf: pass correct struct device to
 dma_alloc_coherent
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-02-05 10:16 a.m., Arindam Nath wrote:
> From: Sanjay R Mehta <sanju.mehta@amd.com>
> 
> Currently, ntb->dev is passed to dma_alloc_coherent
> and dma_free_coherent calls. The returned dma_addr_t
> is the CPU physical address. This works fine as long
> as IOMMU is disabled. But when IOMMU is enabled, we
> need to make sure that IOVA is returned for dma_addr_t.
> So the correct way to achieve this is by changing the
> first parameter of dma_alloc_coherent() as ntb->pdev->dev
> instead.
> 
> Fixes: 5648e56 ("NTB: ntb_perf: Add full multi-port NTB API support")
> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> Signed-off-by: Arindam Nath <arindam.nath@amd.com>

Ugh, this has been fixed repeatedly and independently by a number of
people. I sent a fix[1] in more than a year ago and Sanjay repeated the
effort a couple months ago[2].

I have the same feed back for you that I had for him: once we fix the
bug we should also go in and remove the now unnecessary
dma_coerce_mask_and_coherent() calls in the drivers at the same time
seeing it no longer makes any sense. My patch did this already.

Thanks,

Logan

[1] https://lore.kernel.org/lkml/20190109192233.5752-3-logang@deltatee.com/
[2]
https://lore.kernel.org/lkml/1575983255-70377-1-git-send-email-Sanju.Mehta@amd.com/
