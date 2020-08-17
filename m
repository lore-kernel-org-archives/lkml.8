Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E26C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A764206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bbpxlsh4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgHQFoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 01:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgHQFoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 01:44:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84D3C061388;
        Sun, 16 Aug 2020 22:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=0XUKgy/JKgmlVLlCjIDd80V/8Du4ToG9mq9nXg/KjlE=; b=Bbpxlsh47CxT6l6eRIL9lsPdLU
        n2/0/4VxdrREXW1hW+iPSk4SCh/vjtFF9fKKsAuVpbD35Z1HGzsaS1nUqkaWvL7KOotDrhidFAERF
        A9Fp9JAErzhcIWaubYrgfxQDG5hZ9g9wVb1FP3YX1kY7aGtprcPIKm/ymuQNuifGxVgEbFYKn2Yo0
        SL+KYeS55/Mg50KLVyiFXpfdckepNwCaDtp0tbAh3Kj0KaPB6dHoRDrIwfKi1RPNIW/WT8oYLbPXd
        GUWRDRyXWajIn/o/ltnXw5h+KC8TkpDmfy+xLOL+N0Z+fXRP4PnwhxgGCTdGy6JDFmg9RMFLqlGzK
        /eSjWGxw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7Xw6-0002qJ-61; Mon, 17 Aug 2020 05:43:58 +0000
Subject: Re: [PATCH] phylink: <linux/phylink.h>: fix function prototype
 kernel-doc warning
To:     David Miller <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        netdev@vger.kernel.org
References: <20200816222549.379-1-rdunlap@infradead.org>
 <20200816.211451.1874573780407600816.davem@davemloft.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f99bacca-0868-dff0-ff72-ebe8b8749270@infradead.org>
Date:   Sun, 16 Aug 2020 22:43:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200816.211451.1874573780407600816.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/20 9:14 PM, David Miller wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> Date: Sun, 16 Aug 2020 15:25:49 -0700
> 
>> Fix a kernel-doc warning for the pcs_config() function prototype:
>>
>> ../include/linux/phylink.h:406: warning: Excess function parameter 'permit_pause_to_mac' description in 'pcs_config'
>>
>> Fixes: 7137e18f6f88 ("net: phylink: add struct phylink_pcs")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> 
> There's no definition of this function anywhere.  Maybe just remove all of
> this?
> 

It's for documentation purposes...

It's a "method" (callback) function.

-- 
~Randy

