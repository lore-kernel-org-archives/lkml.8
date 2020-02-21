Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFC1C11D00
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 01:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729742465D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 01:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="IcfdLuIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbgBUBxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 20:53:47 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6695 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729676AbgBUBxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 20:53:45 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4f38060000>; Thu, 20 Feb 2020 17:53:10 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 20 Feb 2020 17:53:43 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 20 Feb 2020 17:53:43 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 21 Feb
 2020 01:53:43 +0000
Subject: Re: [PATCH] mm/page_alloc: increase default min_free_kbytes bound
To:     Joel Savitz <jsavitz@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Rafael Aquini <aquini@redhat.com>, <linux-mm@kvack.org>
References: <20200220150103.5183-1-jsavitz@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <4778f04b-7ff0-0648-1ff9-dd02c79f45ea@nvidia.com>
Date:   Thu, 20 Feb 2020 17:53:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200220150103.5183-1-jsavitz@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582249990; bh=ZgqXP5uwpGcW0RceBT61zrwGEA5iC5CnbKuv9h2cRIU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=IcfdLuIyghaknA70cfsOuxsWbfNUyaGVDOj3dFHpp+X7LvYA46mp7IKBegdJ0kAFj
         m105kyXVSvq1qyACSdc8vA2Ucq+k4SAEYvDRLqnScKUNpRGHAwgwaADoYaB3xuK/LR
         weEtSggSSo5i/xZC7EmcivrIwwAT/tgwiQnIyFmHK3m35RN61TLkDpmku6lY5BecYf
         vSYpzkW0huWld4MgPZq5bt7V2kKI8OgAaM5aLoUr6YYgmYynatnsbeeRvjCdv2agHd
         2JZ5DFAG/f3DM3bZmAaO32LOpifLnGQitjo8oxI+DI6sa/KYVPjWCGnXI2ee2qZ0Zp
         0Sh0njGNLEUdQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/20 7:01 AM, Joel Savitz wrote:
> 
> Currently, the vm.min_free_kbytes sysctl value is capped at a hardcoded
> 64M in init_per_zone_wmark_min (unless it is overridden by khugepaged
> initialization).
> 
> This value has not been modified since 2005, and enterprise-grade
> systems now frequently have hundreds of GB of RAM and multiple 10, 40,
> or even 100 GB NICs. We have seen page allocation failures on heavily
> loaded systems related to NIC drivers. These issues were resolved by an
> increase to vm.min_free_kbytes.
> 
> This patch increases the hardcoded value by a factor of 4 as a temporary
> solution.
> 
> Further work to make the calculation of vm.min_free_kbytes more
> consistent throughout the kernel would be desirable.
> 
> As an example of the inconsistency of the current method, this value is
> recalculated by init_per_zone_wmark_min() in the case of memory hotplug
> which will override the value set by set_recommended_min_free_kbytes()
> called during khugepaged initialization even if khugepaged remains
> enabled, however an on/off toggle of khugepaged will then recalculate
> and set the value via set_recommended_min_free_kbytes().
> 
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> ---
>  mm/page_alloc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3c4eb750a199..32cbfb13e958 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7867,8 +7867,8 @@ int __meminit init_per_zone_wmark_min(void)
>  		min_free_kbytes = new_min_free_kbytes;
>  		if (min_free_kbytes < 128)
>  			min_free_kbytes = 128;
> -		if (min_free_kbytes > 65536)
> -			min_free_kbytes = 65536;
> +		if (min_free_kbytes > 262144)
> +			min_free_kbytes = 262144;


Would it be any better to at least use symbols, instead of numbers, in the
routine? Like this:

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3c4eb750a199..e705636bb644 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -149,6 +149,9 @@ DEFINE_STATIC_KEY_FALSE(init_on_free);
 #endif
 EXPORT_SYMBOL(init_on_free);
 
+static const int MIN_FREE_KBYTES_LOWER_LIMIT = 128;
+static const int MIN_FREE_KBYTES_UPPER_LIMIT = 262144;
+
 static int __init early_init_on_alloc(char *buf)
 {
        int ret;
@@ -7865,10 +7868,10 @@ int __meminit init_per_zone_wmark_min(void)
 
        if (new_min_free_kbytes > user_min_free_kbytes) {
                min_free_kbytes = new_min_free_kbytes;
-               if (min_free_kbytes < 128)
-                       min_free_kbytes = 128;
-               if (min_free_kbytes > 65536)
-                       min_free_kbytes = 65536;
+               if (min_free_kbytes < MIN_FREE_KBYTES_LOWER_LIMIT)
+                       min_free_kbytes = MIN_FREE_KBYTES_LOWER_LIMIT;
+               if (min_free_kbytes > MIN_FREE_KBYTES_UPPER_LIMIT)
+                       min_free_kbytes = MIN_FREE_KBYTES_UPPER_LIMIT;
        } else {
                pr_warn("min_free_kbytes is not updated to %d because user defined value %d is preferred\n",
                                new_min_free_kbytes, user_min_free_kbytes);


thanks,
-- 
John Hubbard
NVIDIA


>  	} else {
>  		pr_warn("min_free_kbytes is not updated to %d because user defined value %d is preferred\n",
>  				new_min_free_kbytes, user_min_free_kbytes);
> 
