Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F05BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35A6F20768
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L1U+NfdD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgGQTfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 15:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbgGQTfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 15:35:39 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A421FC0619D2;
        Fri, 17 Jul 2020 12:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=+7K33yKZaDpcs1a6aU/iG+xEj5hfIYdYbsqOb7b8p9k=; b=L1U+NfdDPoCFJeNEySglBTVD/G
        KYz8nlDZMxLJnHYvwOirVGcXwfmiiearQYBdYetrK7E4iK3Wb/LWVkI2Ca134wvl87d0R2JvRnenp
        /GC4DSaqbygdvQYCtnaa1IOWBnaqYj8qgr9IG9KE4kON5vRa923bP5LRJt9iI3s5HzhSe3yiZyeb9
        5VjF3baddsU4xpRmu9GQIe42Dq9XpK0l81PtSTeW89FsyiQlKLv6m4rh4fofFdklannoj4iOHdmaf
        kkTPDdgbTKsTGQkWZtV159Cfx0AsHBCtfonYzve7yxKcJBJuo9ICNpgrRgxFhvKSWpnc/izouxzO4
        5J5qDxFw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwW8v-0002Ho-12; Fri, 17 Jul 2020 19:35:37 +0000
Subject: Re: [PATCH 05/25] Documentation: serial_core.c: uart_get_rs485_mode:
 Fix sphinx warnings
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>, corbet@lwn.net,
        mchehab@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
 <20200717185624.2009393-5-dwlsalmeida@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <55e0ed96-74c1-df16-e3ef-9e43176413c1@infradead.org>
Date:   Fri, 17 Jul 2020 12:35:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200717185624.2009393-5-dwlsalmeida@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/20 11:56 AM, Daniel W. S. Almeida wrote:
> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> 
> Fix the following warnings:
> 
> warning: Excess function parameter 'dev' description in
> 'uart_get_rs485_mode'
> 
> warning: Excess function parameter 'rs485conf' description in
> 'uart_get_rs485_mode'
> 
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>

I have already fixed this one and it has been merged.

> ---
>  drivers/tty/serial/serial_core.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 57840cf903881..97df0c0e30e9b 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3289,8 +3289,6 @@ EXPORT_SYMBOL(uart_remove_one_port);
>  
>  /**
>   * uart_get_rs485_mode() - retrieve rs485 properties for given uart
> - * @dev: uart device
> - * @rs485conf: output parameter
>   *
>   * This function implements the device tree binding described in
>   * Documentation/devicetree/bindings/serial/rs485.txt.
> 


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
