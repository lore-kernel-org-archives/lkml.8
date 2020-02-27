Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88FFC3F2C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0CD5246A4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582846778;
	bh=fQciLqB49DiuqFxaJ8U7Wyw+hn2oXk1NpstgqjpjGMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mN9+Jfe+eP5kabC8s5QKOQORFFkDm5UouBuscDu01qSnLP1OLMWLeWRgxnkOhzVFg
	 pRsMDbblGbrN2oypnpmOpEHQOQl8qXJdRKXpi5WPhlYp3AbLC7CimxgyynQvhW3aOV
	 ZhdiNUEvuCz8pvuHG+3FrPrKCQ9yJ+EA89HMwbYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbgB0Xjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 18:39:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:43748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729750AbgB0Xjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 18:39:37 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F5DC2469B;
        Thu, 27 Feb 2020 23:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582846776;
        bh=fQciLqB49DiuqFxaJ8U7Wyw+hn2oXk1NpstgqjpjGMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T8QyLuNvjo55oRiRkjaifrrjclB0W/W8631zfgLa0tUN364HYs4v9d6R7N1RU81jw
         zv4aZxGWI277yTQPRTnoGj3mxKuoXSslOPb3hm3JEzl0s/Y7Eq5BHLsGd0RxMlHbH8
         TK1tbDiMKzxiLaF5shcp4PyPlh+vw4x7r+wGxS4w=
Date:   Thu, 27 Feb 2020 15:39:35 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH] exec: remove comparision of variable i_size of type
 loff_t against SIZE_MAX
Message-ID: <20200227233935.GA176371@gmail.com>
References: <20200227233133.10383-1-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227233133.10383-1-scott.branden@broadcom.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 03:31:33PM -0800, Scott Branden wrote:
> Remove comparision of (i_size > SIZE_MAX).
> i_size is of type loff_t and can not be great than SIZE_MAX (~(size_t)0).
> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  fs/exec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index db17be51b112..16c229752f74 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -919,7 +919,7 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
>  		ret = -EINVAL;
>  		goto out;
>  	}
> -	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
> +	if (max_size > 0 && i_size > max_size) {
>  		ret = -EFBIG;
>  		goto out;
>  	}

Nope, loff_t is 64-bit while size_t can be 32-bit.  And this check is
intentional, see https://git.kernel.org/torvalds/c/691115c3513ec83e

- Eric
