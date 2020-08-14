Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EE3C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 07:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5090320708
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 07:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597389056;
	bh=aA2tctgNqJZ+gGYDUoglLWuMG8wP1124c1EoGgts/VY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iGjtd5FbU+iaa/JLyMun6I6LplaryVI2GkHR4QV1NUTeTB0z68AhT8vvSwsHWMKuE
	 PHHwiKiltDaA0Om8lP3LuxzvyM0A+gBA0cjSlKfFN+ntEh65/uzIOxQZBs3J9bADJU
	 jzFDZilirssT3nLPCvr3vF9LNTH7m5huh8RFa0go=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgHNHKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 03:10:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgHNHKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 03:10:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BF2720708;
        Fri, 14 Aug 2020 07:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597389053;
        bh=aA2tctgNqJZ+gGYDUoglLWuMG8wP1124c1EoGgts/VY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PcaBo7UpITrqd3MAhh076zEARQvXxm2WuDf6bDGpH12yJTCaqA2GFK8UPaM4jQCFR
         cOyAt1rQuOA45Lo8/+PlAsj/O8h++JmeDWsaPmHAdITnX3sjhXy8N04SmT+zBUa+E4
         3QbcvM6spKXZlqdvZd+yaTxzT6Q7XDT3vH48MBKM=
Date:   Fri, 14 Aug 2020 09:11:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] exec: Restore EACCES of S_ISDIR execve()
Message-ID: <20200814071102.GA4062560@kroah.com>
References: <20200813231723.2725102-1-keescook@chromium.org>
 <20200813231723.2725102-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813231723.2725102-2-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 04:17:22PM -0700, Kees Cook wrote:
> The return code for attempting to execute a directory has always been
> EACCES. Adjust the S_ISDIR exec test to reflect the old errno instead
> of the general EISDIR for other kinds of "open" attempts on directories.
> 
> Reported-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/lkml/20200813151305.6191993b@why
> Fixes: 633fb6ac3980 ("exec: move S_ISREG() check earlier")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/namei.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 2112e578dccc..e99e2a9da0f7 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2849,8 +2849,10 @@ static int may_open(const struct path *path, int acc_mode, int flag)
>  	case S_IFLNK:
>  		return -ELOOP;
>  	case S_IFDIR:
> -		if (acc_mode & (MAY_WRITE | MAY_EXEC))
> +		if (acc_mode & MAY_WRITE)
>  			return -EISDIR;
> +		if (acc_mode & MAY_EXEC)
> +			return -EACCES;
>  		break;
>  	case S_IFBLK:
>  	case S_IFCHR:


Reviewed-by: Greg Kroah-Hartman <gregkh@google.com>
