Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DAEC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71315206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="W8fzMck6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgDJTeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:34:19 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9828 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgDJTeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:34:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e90ca2e0000>; Fri, 10 Apr 2020 12:34:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 10 Apr 2020 12:34:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 10 Apr 2020 12:34:19 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Apr
 2020 19:34:19 +0000
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Fri, 10 Apr 2020 19:34:18 +0000
Subject: Re: [PATCH] mm/memory_hotplug: Fix a typo in comment
 "recoreded"->"recorded"
To:     Ethon Paul <ethp@qq.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20200410160328.13843-1-ethp@qq.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <24fb071d-634b-adad-3d79-741969e68c2c@nvidia.com>
Date:   Fri, 10 Apr 2020 12:34:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200410160328.13843-1-ethp@qq.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586547246; bh=PL2FgoYNXJ05Hurx3BWr15Jh6tdTOpmMiB4Sq1HB4Dg=;
        h=X-PGP-Universal:Subject:To:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=W8fzMck6PQHjctyfFUg5nwr6tbLzzfLaw2VBuhLggxFYPtGVUGpYF56asqA44SK/j
         Twsh4mwrwoV/53C4jSx2bSh8uAw4tymQcigQFhnwRQLNbuwrHG572MMb58gswax9WB
         2phxFspCHw9Lt8w26B+fB1SxfeKJ6TxfExGM7P3blt1yvON6SDFqhQGNI+Vx/Ub3CU
         3VhMWMcpxgO178IQUv6EW/B2y1jWzuHnqtHFGpyemJ7huDlZIl7tUvQ4V115R1NLJZ
         t/8ONlUN99jpkQcXj5KMKKu84rXxDTir1xGJr/C/mLp4xJN/mao1Wri2KQL5vpZgVg
         qHWX55lYK8xnQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/10/20 9:03 AM, Ethon Paul wrote:
> There is a typo in comment, fix it.
> s/recoreded/recorded
> 
> Signed-off-by: Ethon Paul <ethp@qq.com>

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
>   mm/memory_hotplug.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 635e8e286598..d2e8f3a8088e 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1357,7 +1357,7 @@ offline_isolated_pages_cb(unsigned long start, unsigned long nr_pages,
>   }
>   
>   /*
> - * Check all pages in range, recoreded as memory resource, are isolated.
> + * Check all pages in range, recorded as memory resource, are isolated.
>    */
>   static int
>   check_pages_isolated_cb(unsigned long start_pfn, unsigned long nr_pages,
> 
