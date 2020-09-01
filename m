Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D73DC433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D1EA2071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FLR6I8WI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgIAR56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIAR55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 13:57:57 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA41C061244;
        Tue,  1 Sep 2020 10:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ECi/VFKmiJ5jFuXfjKUGGhvREFSibVftDvvpyMdFwl4=; b=FLR6I8WI0ui7zFJRWoPE4kXZhC
        8zv3DGTJUPgrAqRB6eUcZfoWBbFIbMbMuJvc7Xku2R8v1oiZULNJmJMhKshcpKoXJIcGJUUQ8aJoy
        cLomqynmzseiga8HWqZRXT9MCTBJ2ZcNK8fmyKAoLS6Qx8vSM0XZ0PJzEzJwOwRNWMZ6e1/CRtGR/
        b/xsJ6sAbTFD7QQxYSFLh13Oh6hDVd+P0//n14R3yHqDjtbUI8pJiDRQM01pI/hWs8CbPFC3LV/Ep
        eakxIJjgl43nEkWXJX33i2A0kPCQydChOEV2GfuYrdpdBNQw50dqLeNUR2rM3gPYzvTsrZhLIy24D
        5F7qJORQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDAXY-0003SQ-2g; Tue, 01 Sep 2020 17:57:53 +0000
Subject: Re: [PATCH] Documentation: process: step 2: Link to email list fixed.
To:     Javier Garcia <javier@beren.dev>, corbet@lwn.net
Cc:     grandmaster@al2klimov.de, billy_wilson@byu.edu,
        tony.fischetti@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200901090949.14514-1-javier@beren.dev>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <960ef827-bb99-87af-3923-d33a2a81b3e7@infradead.org>
Date:   Tue, 1 Sep 2020 10:57:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200901090949.14514-1-javier@beren.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/20 2:09 AM, Javier Garcia wrote:
> In the past, these email lists where located at lists.redhat.com. This
> is not longer the case and they are now at redhat.com/mailman/listinfo
> 
> Signed-off-by: Javier Garcia <javier@beren.dev>
> ---
>  Documentation/process/2.Process.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/process/2.Process.rst b/Documentation/process/2.Process.rst
> index 4ae1e0f600c1..e05fb1b8f8b6 100644
> --- a/Documentation/process/2.Process.rst
> +++ b/Documentation/process/2.Process.rst
> @@ -405,7 +405,7 @@ be found at:
>  	http://vger.kernel.org/vger-lists.html
>  
>  There are lists hosted elsewhere, though; a number of them are at
> -lists.redhat.com.
> +redhat.com/mailman/listinfo.
>  

preferably
  https://www.redhat.com/mailman/listinfo

>  The core mailing list for kernel development is, of course, linux-kernel.
>  This list is an intimidating place to be; volume can reach 500 messages per
> 

thanks.
-- 
~Randy

