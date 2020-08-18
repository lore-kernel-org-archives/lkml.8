Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB00C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08CE920786
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BntgZ1r7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgHRO3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbgHRO3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:29:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB92C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 07:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=VZDYV+ciZiiGk6QTWs9Cp9XFnW9zNuBEfYzoE+JwROc=; b=BntgZ1r7vQGNVtI9n4W/8TiXi8
        efkW53rJGrZnaXAT2K3r/3yGyypLaMP0r4Tnvwsscc3UirzQJ9b1iwVBfdaBc1aG7ZNd7iMwtT+cx
        8hPTAVY5hcvQnXQbBZVaw9VW1Y+rvev/z1g1FFlxEYLWQ7WQRSWMvRBQvKkhYFxHw1VWuYBJFKhnV
        pj3dpUHU7b0wGBH7nY0lC+8eiaLiNsDO0zQA+DHuHNawkR+aeTt7WDQqIse/a1lQpKYEEiGU/36sX
        kKtc7n8kds0LXQ49WBDf/TmodmPVO3iQCkCQLHU8wu7ve7h40MOJ48qNu8GY7sverTumL73r82W70
        2nXij/PQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k82bp-0007nI-Km; Tue, 18 Aug 2020 14:29:06 +0000
Subject: Re: [PATCH] staging: emxx_udc: Use standard BIT() macro
To:     Alex Dewar <alex.dewar90@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saiyam Doshi <saiyamdoshi.in@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20200818134922.409195-1-alex.dewar90@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <baecb36e-1f82-1e0e-6460-d6759a9193c1@infradead.org>
Date:   Tue, 18 Aug 2020 07:29:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818134922.409195-1-alex.dewar90@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/20 6:49 AM, Alex Dewar wrote:
> Currently emxx_udc.h defines bit values using local macros. Use the
> standard one instead.
> 
> Also, combine bit values with bitwise-or rather than addition, as
> suggested by Coccinelle.
> 
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>

Hi,

Does this build?  Just checking.

Looks like it would need this:

#include <linux/bits.h>

since it (indirectly) provides definition of the BIT() macro.

> ---
>  drivers/staging/emxx_udc/emxx_udc.h | 456 +++++++++++++---------------
>  1 file changed, 211 insertions(+), 245 deletions(-)


thanks.
-- 
~Randy

