Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B3FC43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 02:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC3B720757
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 02:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lLRkcmnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgIFCmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 22:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbgIFCmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 22:42:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961DDC061573
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 19:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=2gMKPZVWIUwmT51x+r/AeRACq9RuPkARxL63mWYi8T8=; b=lLRkcmnrvou1mhZruAFXvw7dek
        B0b+dNxm3xACc8QlNYbD9du3WFDY8cmJfmNk8rqElpYFB95HKMTAr+8ZSmxN0bdI4NHD2qHcrboSH
        y19x8bHZ6bVs/OedKw6zFxaygVTZ+temK9ECQvOq0F6PQvMeBEh3T806NrmLQ3n+d5UTEHVAPDPb/
        NccMeITymbfQdJX9mYfWb9nAnHCwJrHuuhbqxljFvAPkhe0j5RL8M8FM4XfAl7CNGwsm+2zwikSGK
        3L6KWY99F0f/IXirok3RhHUJcqIfn8KUXHAIeSPwOsrXA7OW25KDMzhJ8lKJrwLCr2HazT4stySDE
        epEo/PaQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEkd3-00046a-AI; Sun, 06 Sep 2020 02:42:05 +0000
Subject: Re: [PATCH] kcsan: kconfig: Move to menu 'Generic Kernel Debugging
 Instruments'
To:     Changbin Du <changbin.du@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rd.dunlab@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20200904152224.5570-1-changbin.du@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5ba0224c-8f8a-c89e-8b98-1b49a76e1f33@infradead.org>
Date:   Sat, 5 Sep 2020 19:42:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904152224.5570-1-changbin.du@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/20 8:22 AM, Changbin Du wrote:
> This moves the KCSAN kconfig items under menu 'Generic Kernel Debugging
> Instruments' where UBSAN resides.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

LGTM. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  lib/Kconfig.debug | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index e068c3c7189a..0c781f912f9f 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -520,8 +520,8 @@ config DEBUG_FS_ALLOW_NONE
>  endchoice
>  
>  source "lib/Kconfig.kgdb"
> -
>  source "lib/Kconfig.ubsan"
> +source "lib/Kconfig.kcsan"
>  
>  endmenu
>  
> @@ -1620,8 +1620,6 @@ config PROVIDE_OHCI1394_DMA_INIT
>  
>  source "samples/Kconfig"
>  
> -source "lib/Kconfig.kcsan"
> -
>  config ARCH_HAS_DEVMEM_IS_ALLOWED
>  	bool
>  
> 

-- 
~Randy
