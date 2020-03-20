Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F713C43333
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25EC820752
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgCTXY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 19:24:29 -0400
Received: from ms.lwn.net ([45.79.88.28]:44132 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgCTXY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 19:24:28 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7B4522D6;
        Fri, 20 Mar 2020 23:24:27 +0000 (UTC)
Date:   Fri, 20 Mar 2020 17:24:26 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Wang Wenhu <wenhu.wang@vivo.com>
Cc:     Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@vivo.com
Subject: Re: [PATCH v2,RESEND] doc: zh_CN: fix style problems for
 io_ordering.txt
Message-ID: <20200320172426.121d881d@lwn.net>
In-Reply-To: <20200315060857.82880-1-wenhu.wang@vivo.com>
References: <20200315060857.82880-1-wenhu.wang@vivo.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Mar 2020 23:08:55 -0700
Wang Wenhu <wenhu.wang@vivo.com> wrote:

> Problems exist in the Chinese translation of io_ordering.txt.
> Partly for the difference between Chinese and English character
> encoding format, and the others are of the failure to comply
> with the ReST markups.

So I feel like I'm missing something here...

> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
> ---
> v2: resend for the failure of delivering.
> 
>  .../translations/zh_CN/io_ordering.txt        | 72 ++++++++++++-------
>  1 file changed, 46 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/translations/zh_CN/io_ordering.txt b/Documentation/translations/zh_CN/io_ordering.txt
> index 1f8127bdd415..080ed2911db0 100644
> --- a/Documentation/translations/zh_CN/io_ordering.txt
> +++ b/Documentation/translations/zh_CN/io_ordering.txt
> @@ -29,39 +29,59 @@ Documentation/io_ordering.txt 的中文翻译
>  这也可以保证后面的写操作只在前面的写操作之后到达设备（这非常类似于内存
>  屏障操作，mb()，不过仅适用于I/O）。
>  
> +A more concrete example from a hypothetical device driver::
> +
> +		...
> +	CPU A:  spin_lock_irqsave(&dev_lock, flags)
> +	CPU A:  val = readl(my_status);
> +	CPU A:  ...
> +	CPU A:  writel(newval, ring_ptr);
> +	CPU A:  spin_unlock_irqrestore(&dev_lock, flags)
> +		...
> +	CPU B:  spin_lock_irqsave(&dev_lock, flags)
> +	CPU B:  val = readl(my_status);
> +	CPU B:  ...
> +	CPU B:  writel(newval2, ring_ptr);
> +	CPU B:  spin_unlock_irqrestore(&dev_lock, flags)
> +		...
> +
> +
>  假设一个设备驱动程的具体例子：
> +::
>  
> +		...
> +	CPU A:  spin_lock_irqsave(&dev_lock, flags)
> +	CPU A:  val = readl(my_status);
> +	CPU A:  ...
> +	CPU A:  writel(newval, ring_ptr);
> +	CPU A:  spin_unlock_irqrestore(&dev_lock, flags)
> +		...
> +	CPU B:  spin_lock_irqsave(&dev_lock, flags)
> +	CPU B:  val = readl(my_status);
> +	CPU B:  ...
> +	CPU B:  writel(newval2, ring_ptr);
> +	CPU B:  spin_unlock_irqrestore(&dev_lock, flags)

It sure looks like you're adding the same text twice here...?

Thanks,

jon

