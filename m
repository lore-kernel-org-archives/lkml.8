Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6351C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 701A820773
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WRXCxz8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgIBPJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbgIBPIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:08:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF13C061246
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 08:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=XD2Pbkht1TP+bkfwkdAAR9D4au0gw0hidG3GmkiAzhs=; b=WRXCxz8t5I24XFrC3hXjClgbzS
        vGrIZ57FYbavTXPtpZ5n56/6gBdzEUxMxZAEhHGPdQYeL1aOtBYa6IZM1NqTbpsQDuJr2kUCyVYZ2
        2NczeL1B9i29spRmoU4tcxaUu8xy9xKz56R95AIKcCz9ZHcpbUYM3aa14SBJTsJ7K9koDVF1VqOb2
        uzUTYR1Xf/cDa8zGPPcvf+NeFdN0f9twKglZUgpNbKpZ7dMJEmEPw1m3XUC44qhbCR2somJpR06mt
        iPxHM8KbdFHo79e33MJjBdgs8jFyYRec2PG783gdw4LE0Yxnhr09aY/Xd7aS5DK8+ttXx8py9jpnX
        /X0yx1Rg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDUMm-00012t-MI; Wed, 02 Sep 2020 15:08:04 +0000
Subject: Re: [PATCH] trivial: docs: Section number should be "8.2"
To:     Michael Witten <mfwitten@gmail.com>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <19f80e640076482fac86f57b41211faa@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c0366b17-94bc-0935-971e-fb079ba578f1@infradead.org>
Date:   Wed, 2 Sep 2020 08:08:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <19f80e640076482fac86f57b41211faa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/20 7:45 AM, Michael Witten wrote:
> Signed-off-by: Michael Witten <mfwitten@gmail.com>
> ---
>  Documentation/kbuild/makefiles.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
> index b81b8913a5a3..da6a708164c4 100644
> --- a/Documentation/kbuild/makefiles.rst
> +++ b/Documentation/kbuild/makefiles.rst
> @@ -1411,7 +1411,7 @@ When kbuild executes, the following steps are followed (roughly):
>  	that may be shared between individual architectures.
>  	The recommended approach how to use a generic header file is
>  	to list the file in the Kbuild file.
> -	See "7.2 generic-y" for further info on syntax etc.
> +	See "8.2 generic-y" for further info on syntax etc.
>  
>  7.11 Post-link pass
>  -------------------
> 

Already fixed and merged:

from Masahiro Yamada <masahiroy@kernel.org>:
Applied to linux-kbuild/fixes.
Thanks.

-- 
~Randy

