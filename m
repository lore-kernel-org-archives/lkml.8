Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9021BC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B792465A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgCITbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:31:51 -0400
Received: from smtprelay0221.hostedemail.com ([216.40.44.221]:48014 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726106AbgCITbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:31:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id D9FB01025604F;
        Mon,  9 Mar 2020 19:31:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: desk11_2ce8ed604532a
X-Filterd-Recvd-Size: 1434
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Mon,  9 Mar 2020 19:31:48 +0000 (UTC)
Message-ID: <19abedb11fae1b96aa052090e7a0d5bbea416824.camel@perches.com>
Subject: Re: [PATCH] xattr: NULL initialize name in simple_xattr_alloc
From:   Joe Perches <joe@perches.com>
To:     Daniel Xu <dxu@dxuuu.xyz>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com
Date:   Mon, 09 Mar 2020 12:30:07 -0700
In-Reply-To: <20200309183719.3451-1-dxu@dxuuu.xyz>
References: <20200309183719.3451-1-dxu@dxuuu.xyz>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-09 at 11:37 -0700, Daniel Xu wrote:
> It's preferable to initialize structs to a deterministic state.

Thanks Daniel.

> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  fs/xattr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 90dd78f0eb27..92b324c265d2 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -821,6 +821,7 @@ struct simple_xattr *simple_xattr_alloc(const void *value, size_t size)
>  	if (!new_xattr)
>  		return NULL;
>  
> +	new_xattr->name = NULL;
>  	new_xattr->size = size;
>  	memcpy(new_xattr->value, value, size);
>  	return new_xattr;

