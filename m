Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47697C3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25BCB222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgBMSdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:33:47 -0500
Received: from ms.lwn.net ([45.79.88.28]:46922 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgBMSdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:33:47 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 554F3740;
        Thu, 13 Feb 2020 18:33:46 +0000 (UTC)
Date:   Thu, 13 Feb 2020 11:33:45 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] Documentation: zram: fix the description about
 orig_data_size of mm_stat
Message-ID: <20200213113345.187b1424@lwn.net>
In-Reply-To: <20200206111031.9524-1-zbestahu@gmail.com>
References: <20200206111031.9524-1-zbestahu@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Feb 2020 19:10:31 +0800
Yue Hu <zbestahu@gmail.com> wrote:

> From: Yue Hu <zbestahu@163.com>
> 
> orig_data_size counted the same_pages by commit 51f9f82c855d ("zram:
> count same page write as page_stored"), so let's fix it.
> 
> Signed-off-by: Yue Hu <zbestahu@163.com>
> ---
>  Documentation/admin-guide/blockdev/zram.rst | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
> index 27c77d853028..a6fd1f9b5faf 100644
> --- a/Documentation/admin-guide/blockdev/zram.rst
> +++ b/Documentation/admin-guide/blockdev/zram.rst
> @@ -251,8 +251,6 @@ line of text and contains the following stats separated by whitespace:
>  
>   ================ =============================================================
>   orig_data_size   uncompressed size of data stored in this disk.
> -		  This excludes same-element-filled pages (same_pages) since
> -		  no memory is allocated for them.
>                    Unit: bytes
>   compr_data_size  compressed size of data stored in this disk
>   mem_used_total   the amount of memory allocated for this disk. This

Applied, thanks.

jon
