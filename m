Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98C3C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 06:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899FF2073E
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 06:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585465124;
	bh=Uu32Q+MjxUf6CbeBofPpkKX0B6iZrkU+Ax5m98gSnWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X0m1iRoAa1/D76kub/WyuOum5jzXpl3chCy5tXEbQOv4SrMSao2cPeoqxpBYoCZ0E
	 3h4NRhnWndSmRwIWAzv+iIQ5/6X08HM8LwNM195LSuirkUT0r2EY4QF57TGqRwN+h7
	 ETdkrueyhRxdJG+4CitZbMyy96XHm0NdrjpT8tCk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgC2G6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 02:58:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbgC2G6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 02:58:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3980E2073B;
        Sun, 29 Mar 2020 06:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585465122;
        bh=Uu32Q+MjxUf6CbeBofPpkKX0B6iZrkU+Ax5m98gSnWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gw50aLQ4OVyDxx1nueiDxERXNoLhWTk8eyAeFjKPgTmJKGe+UrZnmbxfmPArp2P/m
         8lI/gEnF9pDP+299Hhd/cx9b31x0FxnfeiFdjEuMIMAlIwQqR+cFjG9un6qLaDtm7y
         Mfd/JWh6YdlNtLtivQ/t0GB8mGfWhvFFyyKdpEpw=
Date:   Sun, 29 Mar 2020 08:58:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     SandeshKenjanaAshok <sandeshkenjanaashok@gmail.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: android: ashmem: Declared file operation with
 const keyword
Message-ID: <20200329065837.GA3907627@kroah.com>
References: <20200328151523.17516-1-sandeshkenjanaashok@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328151523.17516-1-sandeshkenjanaashok@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 04:15:23PM +0100, SandeshKenjanaAshok wrote:
> Warning found by checkpatch.pl script.
> 
> Signed-off-by: SandeshKenjanaAshok <sandeshkenjanaashok@gmail.com>
> ---
>  drivers/staging/android/ashmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> index 8044510d8ec6..fbb6ac9ba1ab 100644
> --- a/drivers/staging/android/ashmem.c
> +++ b/drivers/staging/android/ashmem.c
> @@ -367,7 +367,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
>  
>  static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>  {
> -	static struct file_operations vmfile_fops;
> +	static const struct file_operations vmfile_fops;
>  	struct ashmem_area *asma = file->private_data;
>  	int ret = 0;
>  
> -- 
> 2.17.1
> 

Did you try to build this change?  Please do so.
