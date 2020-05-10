Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553C2C35280
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 06:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26F0F208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 06:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589091268;
	bh=dhSX1koUXR01QNflrqzyeDk0HZwGZnOuulR+owPUVxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tiNZpaUy5h9aAIw0mWMtXNGiopCco3rAqN5sCnB/OkVYzdHgKIaM5S10X08A8SSVs
	 egOaKFjALnYD+Pv4urd7k88IBkMt0yNVKyPnrzLXIb4IGKsWlnPYJn7KLMOPYGeTOa
	 4kPQE1vslJNSdfo7zXjQl9oWtz5PGKWN80O1BWkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgEJGO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 02:14:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbgEJGOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 02:14:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6ACE2082E;
        Sun, 10 May 2020 06:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589091265;
        bh=dhSX1koUXR01QNflrqzyeDk0HZwGZnOuulR+owPUVxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ucm/1umG+61KjNyTKq2IX2ZBYcRg+6v/Mx/iyTwnFn9ufXLQC8aqrYWQiFPYuy7ap
         eUeKYsnKisIPlDOWh3qlbQuhDe39DkIeXMbpEWrZDcYHefB7xrrtgGL45LM5DaAhto
         tJN5JUcFYWgXPbSBWeJ9TDusCbJSFEB0MeuNI9FM=
Date:   Sun, 10 May 2020 08:14:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     linux@armlinux.org.uk, alexios.zavras@intel.com,
        tglx@linutronix.de, allison@lohutok.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] arch/arm: use scnprintf() in l2x0_pmu_event_show()
Message-ID: <20200510061422.GA3375088@kroah.com>
References: <20200509083539.113156-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509083539.113156-1-chenzhou10@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 04:35:39PM +0800, Chen Zhou wrote:
> snprintf() returns the number of bytes that would be written,
> which may be greater than the the actual length to be written.
> 
> show() methods should return the number of bytes printed into the
> buffer. This is the return value of scnprintf().
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  arch/arm/mm/cache-l2x0-pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/cache-l2x0-pmu.c b/arch/arm/mm/cache-l2x0-pmu.c
> index 993fefdc167a..d20626451a2e 100644
> --- a/arch/arm/mm/cache-l2x0-pmu.c
> +++ b/arch/arm/mm/cache-l2x0-pmu.c
> @@ -343,7 +343,7 @@ static ssize_t l2x0_pmu_event_show(struct device *dev,
>  	struct l2x0_event_attribute *lattr;
>  
>  	lattr = container_of(attr, typeof(*lattr), attr);
> -	return snprintf(buf, PAGE_SIZE, "config=0x%x\n", lattr->config);
> +	return scnprintf(buf, PAGE_SIZE, "config=0x%x\n", lattr->config);

This should just be replaced with sprintf() as there's no way such a
string can go beyond PAGE_SIZE.

And the "config=" part could be dropped as well, but now userspace
probably requires it, that is sad.

thanks,

greg k-h
