Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6314C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C02C420707
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WS9AnGmH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbgFSHWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 03:22:10 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6882 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgFSHWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 03:22:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eec673c0001>; Fri, 19 Jun 2020 00:20:28 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 19 Jun 2020 00:22:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 19 Jun 2020 00:22:09 -0700
Received: from [10.2.62.75] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 19 Jun
 2020 07:22:06 +0000
Subject: Re: [PATCH] docs: mm/gup: Minor documentation update
To:     Souptick Joarder <jrdr.linux@gmail.com>, <corbet@lwn.net>,
        <akpm@linux-foundation.org>, <jack@suse.cz>,
        <kirill.shutemov@linux.intel.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1592422023-7401-1-git-send-email-jrdr.linux@gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <79febf94-8c04-dd41-90a7-19f4060fea38@nvidia.com>
Date:   Fri, 19 Jun 2020 00:22:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592422023-7401-1-git-send-email-jrdr.linux@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592551228; bh=EL/459CEMaLaR/s1LjSbQdMlm1+MQ+IuZaLoXAFw+Ps=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=WS9AnGmHYzAORjufc3RyrBZYp62LeCBP8PF22t8JI82aXDKrOLgbw6zBo8b2gP/iE
         /56+GA9bX/pUms9LW6JajUObpfYncLNKPFU9bUUei5BeLq2Dasj8ATm17tHQyiFqtg
         kaochTbtJwLeKtkIxUdYlxKS9WbqY1HOXBgoALpURoAoF/8mYBQn2GvoA3a5feR6Fz
         7aRZ4h1hIOavS1jWoTLR9Y2s6yeGZAAAEU6dTd+srOEul0sSsMBYmYdtVKCpKp4HRA
         lBE4xMMjpDGiUUJZtG+j4E8QydLVgwqmUTb9ZXtnjKDhRNFCqHL3RIbeMap102GS3s
         0JobRbl/Dwv5A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-17 12:27, Souptick Joarder wrote:
> Now there are 5 cases. Updated the same.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> ---
>   Documentation/core-api/pin_user_pages.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/core-api/pin_user_pages.rst b/Documentation/core-api/pin_user_pages.rst
> index 6068266..7ca8c7b 100644
> --- a/Documentation/core-api/pin_user_pages.rst
> +++ b/Documentation/core-api/pin_user_pages.rst
> @@ -33,7 +33,7 @@ all combinations of get*(), pin*(), FOLL_LONGTERM, and more. Also, the
>   pin_user_pages*() APIs are clearly distinct from the get_user_pages*() APIs, so
>   that's a natural dividing line, and a good point to make separate wrapper calls.
>   In other words, use pin_user_pages*() for DMA-pinned pages, and
> -get_user_pages*() for other cases. There are four cases described later on in
> +get_user_pages*() for other cases. There are five cases described later on in


Probably better to just say "several" instead of "five", but either way is fine.

     Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA
