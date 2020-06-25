Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762E9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 01:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B5AF20706
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 01:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X0Kcl4JB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389143AbgFYBTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 21:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388928AbgFYBTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 21:19:32 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9537C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 18:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:Subject:From:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=neCjOc11qing147Knuno5Zs0TZ7UJ5WPV8cnPuKXZ2w=; b=X0Kcl4JBpdGaR57L7a7o8m2MVK
        9CPsfhd4l47obbP5kxoUqUzw0qhHOMnMrXFgG/vrYcyLnfTiGUgQ4vBztg+LhsFwU1mRMjmFCcRdU
        /k27HIRXI9nxUk1q6tPYuY1Wxr3cKhC47UYWDpqxAsoVQ48BMT1H++wcf0o2LxIkOXco7MQsRhX1/
        EDKlPewtAhbsHzGZeTSgrNjrRrUmNs+2ZyUYiotfST5X11j0q8Xl0SdXjOiImVqWzAlvNCDmey62d
        4SlzdAh2PF+Ti5Y+Jbe5NqJ6z5miCgGLFypocEd1X1HodXffQ0+cgwvs8pm/G7owZUnPlf7i3rXim
        IMcSU+Mg==;
Received: from [2602:306:37b0:7840:f887:89b1:c866:efda]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1joGXo-0007QV-Kg; Thu, 25 Jun 2020 01:19:13 +0000
From:   Geoff Levand <geoff@infradead.org>
Subject: Re: [PATCH] powerpc/boot: Use address-of operator on section symbols
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, Joel Stanley <joel@jms.id.au>
References: <20200624035920.835571-1-natechancellor@gmail.com>
Message-ID: <1bbb6956-d9de-e0c8-5b45-20b6fecc2189@infradead.org>
Date:   Wed, 24 Jun 2020 18:18:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624035920.835571-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On 6/23/20 8:59 PM, Nathan Chancellor wrote:
> These are not true arrays, they are linker defined symbols, which are
> just addresses.  Using the address of operator silences the warning
> and does not change the resulting assembly with either clang/ld.lld
> or gcc/ld (tested with diff + objdump -Dr).

Thanks for your patch.  I tested this patch applied to v5.8-rc2 on a
PS3 and it seems OK.

Tested-by: Geoff Levand <geoff@infradead.org>


