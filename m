Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D20C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED7E222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581611067;
	bh=vNy+M5T5esradAFa6CisEsvfvCDB35E7jpx/Ta5uOhw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=iAdsK8/BTpoUAGzV0NlJ9+oieN5yaXN6a0RKLG9EzNW+XZAvF6cTGyAVqGnRn5pZo
	 WOTSDVPhDWgHGgdI6pb1UmM37DmQkMieuf7LDWdMC5RjRlNuKTYVMIR9Sfap0JretW
	 KOapCbh0ENf2bjBXG5nTms0tz16snf/wNQMTANBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgBMQY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:24:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:34620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728434AbgBMQYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 11:24:25 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D651217F4;
        Thu, 13 Feb 2020 16:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581611064;
        bh=vNy+M5T5esradAFa6CisEsvfvCDB35E7jpx/Ta5uOhw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JiXTxnOvaI+Ex9taESWBKXQEEqY+L5jZGn/Weoi/Na/NjcqcStGAfM8MgnVRDUHAa
         isFjMY7TjALLLLlbJwiHAh5Py5yFV65k1h9O/48rhD/cI5kxtmCZmCNBvK7If95w64
         8XkXqhQ9ZSRQx0a4o2paQleNUsVBgGtmlHIphhG0=
Message-ID: <85db1f27d661fb24bd825b241f9d5ca3a94a1efa.camel@kernel.org>
Subject: Re: [PATCH] ceph: cache: Replace zero-length array with
 flexible-array member
From:   Jeff Layton <jlayton@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 13 Feb 2020 11:24:23 -0500
In-Reply-To: <20200213160004.GA4334@embeddedor>
References: <20200213160004.GA4334@embeddedor>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-02-13 at 10:00 -0600, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  fs/ceph/cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
> index 270b769607a2..2f5cb6bc78e1 100644
> --- a/fs/ceph/cache.c
> +++ b/fs/ceph/cache.c
> @@ -32,7 +32,7 @@ struct ceph_fscache_entry {
>  	size_t uniq_len;
>  	/* The following members must be last */
>  	struct ceph_fsid fsid;
> -	char uniquifier[0];
> +	char uniquifier[];
>  };
>  
>  static const struct fscache_cookie_def ceph_fscache_fsid_object_def = {

Meh, ok. Merged into the ceph-client/testing branch. Should make v5.7
barring unforseen issues.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

