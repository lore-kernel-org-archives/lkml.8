Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE397C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8760C2072F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QwlBA16h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgDFTCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:02:07 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10803 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgDFTCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 15:02:07 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e8b7ca10000>; Mon, 06 Apr 2020 12:01:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 06 Apr 2020 12:02:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 06 Apr 2020 12:02:06 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Apr
 2020 19:02:05 +0000
Received: from [10.2.56.115] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Apr 2020
 19:02:05 +0000
Subject: Re: [PATCH 1/2] mm: clarify __GFP_MEMALLOC usage
To:     Michal Hocko <mhocko@kernel.org>, NeilBrown <neilb@suse.de>
CC:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
References: <20200403083543.11552-1-mhocko@kernel.org>
 <20200403083543.11552-2-mhocko@kernel.org>
 <alpine.DEB.2.21.2004031238571.230548@chino.kir.corp.google.com>
 <87blo8xnz2.fsf@notabene.neil.brown.name>
 <20200406070137.GC19426@dhcp22.suse.cz>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <4f861f07-4b47-8ddc-f783-10201ea302d3@nvidia.com>
Date:   Mon, 6 Apr 2020 12:02:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200406070137.GC19426@dhcp22.suse.cz>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586199713; bh=qqIagahZ8DDUVZjQFUcg1ElI28hwEI0fMAZ7/LsRukU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=QwlBA16h2D+ju7OlUihZ+T1QjkFLn7SmhlvkVp0UAszXqAXFqG6hOvTaMGyC8kEMv
         2Bwp8DReIQmyzNvzYLEMkZk6Of3WrGsdc6ekAFuiHv6Y+OE5NEIyfASD0M+XKnE7K1
         RRW59KqyDHfbZgc4xDXn7CQEMIa8qHcZU9VjN1dEBfI8H3IoAEwIe1gmO1cjg8tFYV
         7APrla5bTSEE76b0grIPPluxmWdv7avTTP+wXZaWnSDwQshqAKJfjoc3TW7pwyXZn1
         V7hrmPYdjTn+taq5vCRuDHRPjAn8uy/6zyWCqYE3XW1zD2tsaGoVeqUJtNfrBsi6c6
         fgLnMMOdhREeQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/20 12:01 AM, Michal Hocko wrote:
...
>  From 6c90b0a19a07c87d24ad576e69b33c6e19c2f9a2 Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Wed, 1 Apr 2020 14:00:56 +0200
> Subject: [PATCH] mm: clarify __GFP_MEMALLOC usage
> 
> It seems that the existing documentation is not explicit about the
> expected usage and potential risks enough. While it is calls out
> that users have to free memory when using this flag it is not really
> apparent that users have to careful to not deplete memory reserves
> and that they should implement some sort of throttling wrt. freeing
> process.
> 
> This is partly based on Neil's explanation [1].
> 
> Let's also call out that a pre allocated pool allocator should be
> considered.
> 
> [1] http://lkml.kernel.org/r/877dz0yxoa.fsf@notabene.neil.brown.name
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>   include/linux/gfp.h | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index e5b817cb86e7..9cacef1a3ee0 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -110,6 +110,11 @@ struct vm_area_struct;
>    * the caller guarantees the allocation will allow more memory to be freed
>    * very shortly e.g. process exiting or swapping. Users either should
>    * be the MM or co-ordinating closely with the VM (e.g. swap over NFS).
> + * Users of this flag have to be extremely careful to not deplete the reserve
> + * completely and implement a throttling mechanism which controls the consumption
> + * of the reserve based on the amount of freed memory.
> + * Usage of a pre-allocated pool (e.g. mempool) should be always considered before
> + * using this flag.
>    *
>    * %__GFP_NOMEMALLOC is used to explicitly forbid access to emergency reserves.
>    * This takes precedence over the %__GFP_MEMALLOC flag if both are set.
> 

Hi Michal and all,

How about using approximately this wording instead? I found Neil's wording to be
especially helpful so I mixed it in. (Also fixed a couple of slight 80-col overruns.)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index be2754841369..c247a911d8c7 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -111,6 +111,15 @@ struct vm_area_struct;
   * very shortly e.g. process exiting or swapping. Users either should
   * be the MM or co-ordinating closely with the VM (e.g. swap over NFS).
   *
+ * To be extra clear: users of __GFP_MEMALLOC must be working to free other
+ * memory, and that other memory needs to be freed "soon"; specifically, before
+ * the reserve is exhausted. This generally implies a throttling mechanism that
+ * balances the amount of __GFP_MEMALLOC memory used against the amount that the
+ * caller is about to free.
+ *
+ * Usage of a pre-allocated pool (e.g. mempool) should be always considered
+ * before using this flag.
+ *
   * %__GFP_NOMEMALLOC is used to explicitly forbid access to emergency reserves.
   * This takes precedence over the %__GFP_MEMALLOC flag if both are set.
   */


thanks,
-- 
John Hubbard
NVIDIA
