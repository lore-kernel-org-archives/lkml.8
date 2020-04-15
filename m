Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EAFC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5929E206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qTeA4cQ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411832AbgDOTLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:11:15 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5949 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416838AbgDOSjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:39:12 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e9754950001>; Wed, 15 Apr 2020 11:38:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 15 Apr 2020 11:39:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 15 Apr 2020 11:39:12 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Apr
 2020 18:39:11 +0000
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 15 Apr 2020 18:39:11 +0000
Subject: Re: [PATCH] mm: Fix a typo in comment "strucure"->"structure"
To:     Ethon Paul <ethp@qq.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20200411064723.15855-1-ethp@qq.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <67e122e5-53ff-e04c-9c38-53eab9701f01@nvidia.com>
Date:   Wed, 15 Apr 2020 11:39:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200411064723.15855-1-ethp@qq.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586975893; bh=HIEJfqDa6z36CFLcM5FjNWWhspU6i61JZSNWRpLc+iA=;
        h=X-PGP-Universal:Subject:To:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=qTeA4cQ4rBx4zeyaqTIowFatNac376KFePSltMkFaDS5ctV5+b9WK5ZQFPDdF+fla
         CfaD1Ok2tRrDyWFnAWngIOS0/xhBE6XTY+Z/OnjawvXKslz64JSb82jt1ZMxk1Z40C
         F29tGgj6cPE+ZzwtqvUsFtA258R182lwrGjuTy/seukzL5D8MPuaygPUjGC22GpT6Y
         9/B7JfotboCEQDrZnZLNvP2wgQu+6m9N28+oOjA2BgLOyL3d6lY008zO859+m2BKJt
         vqoTo5kQ7DGP0MxYFdKQTJ/NGxZtv57kc2iRoSlJtJmJOYQa6Ap8p2s19TeF7tfHCs
         oPaJJocYX2Irw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/10/20 11:47 PM, Ethon Paul wrote:
> There is a typo in comment, fix it.
> 
> Signed-off-by: Ethon Paul <ethp@qq.com>

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
>   mm/internal.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index b5634e78f01d..7e998459f887 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -130,7 +130,7 @@ extern pmd_t *mm_find_pmd(struct mm_struct *mm, unsigned long address);
>    *
>    * zonelist, preferred_zone and classzone_idx are set first in
>    * __alloc_pages_nodemask() for the fast path, and might be later changed
> - * in __alloc_pages_slowpath(). All other functions pass the whole strucure
> + * in __alloc_pages_slowpath(). All other functions pass the whole structure
>    * by a const pointer.
>    */
>   struct alloc_context {
> 
