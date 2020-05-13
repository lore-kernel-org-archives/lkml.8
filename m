Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2988C2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 05:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9321820659
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 05:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgEMFqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 01:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728131AbgEMFqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 01:46:18 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD9FC061A0C;
        Tue, 12 May 2020 22:46:18 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYkDZ-007EO7-Jb; Wed, 13 May 2020 05:46:09 +0000
Date:   Wed, 13 May 2020 06:46:09 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     axboe@kernel.dk, zohar@linux.vnet.ibm.com, mcgrof@kernel.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] fs: avoid fdput() after failed fdget() in
 ksys_sync_file_range()
Message-ID: <20200513054609.GS23230@ZenIV.linux.org.uk>
References: <cover.1589311577.git.skhan@linuxfoundation.org>
 <71cc3966f60f884924f9dff8875ed478e858dca1.1589311577.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71cc3966f60f884924f9dff8875ed478e858dca1.1589311577.git.skhan@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 01:43:04PM -0600, Shuah Khan wrote:

> @@ -364,15 +364,15 @@ int sync_file_range(struct file *file, loff_t offset, loff_t nbytes,
>  int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
>  			 unsigned int flags)
>  {
> -	int ret;
> -	struct fd f;
> +	int ret = -EBADF;
> +	struct fd f = fdget(fd);
>  
> -	ret = -EBADF;
> -	f = fdget(fd);
> -	if (f.file)
> -		ret = sync_file_range(f.file, offset, nbytes, flags);
> +	if (!f.file)
> +		goto out;
>  
> +	ret = sync_file_range(f.file, offset, nbytes, flags);
>  	fdput(f);
> +out:
>  	return ret;

IDGI...  What's the point of that goto out, when it leads straight to return?
