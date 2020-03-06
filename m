Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63054C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 08:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3920B2072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 08:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCFIv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 03:51:29 -0500
Received: from smtprelay0205.hostedemail.com ([216.40.44.205]:38779 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726107AbgCFIv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 03:51:29 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id BFF21837F24C;
        Fri,  6 Mar 2020 08:51:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: can51_63e0f7d79f449
X-Filterd-Recvd-Size: 1688
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Fri,  6 Mar 2020 08:51:26 +0000 (UTC)
Message-ID: <58c6e6dafabea52e5b030d18b83c13e4f43ab8e3.camel@perches.com>
Subject: Re: [PATCH v2 1/4] kernfs: kvmalloc xattr value instead of kmalloc
From:   Joe Perches <joe@perches.com>
To:     Daniel Xu <dxu@dxuuu.xyz>, cgroups@vger.kernel.org, tj@kernel.org,
        lizefan@huawei.com, hannes@cmpxchg.org
Cc:     shakeelb@google.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, kernel-team@fb.com
Date:   Fri, 06 Mar 2020 00:49:51 -0800
In-Reply-To: <20200305211632.15369-2-dxu@dxuuu.xyz>
References: <20200305211632.15369-1-dxu@dxuuu.xyz>
         <20200305211632.15369-2-dxu@dxuuu.xyz>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-03-05 at 13:16 -0800, Daniel Xu wrote:
> It's not really necessary to have contiguous physical memory for xattr
> values. We no longer need to worry about higher order allocations
> failing with kvmalloc, especially because the xattr size limit is at
> 64K.

So why use vmalloc memory at all?

> diff --git a/fs/xattr.c b/fs/xattr.c
']
> @@ -817,7 +817,7 @@ struct simple_xattr *simple_xattr_alloc(const void *value, size_t size)
>  	if (len < sizeof(*new_xattr))
>  		return NULL;
>  
> -	new_xattr = kmalloc(len, GFP_KERNEL);
> +	new_xattr = kvmalloc(len, GFP_KERNEL);

Why is this sensible?
vmalloc memory is a much more limited resource.

Also, it seems as if the function should set
new_xattr->name to NULL before the return.


