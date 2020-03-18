Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0911CC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 03:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B720020753
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 03:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="cnW+GuZA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="cnW+GuZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgCRD7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 23:59:07 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:33180 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726250AbgCRD7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 23:59:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7CBF68EE232;
        Tue, 17 Mar 2020 20:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1584503946;
        bh=ydIbcdjee5XcxlB6Ithv1fKp8IIXYWSS41zaq3y/uGQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cnW+GuZABznG2AR8ki1R9fva9LdyBqzQvbz8LYh4spdU0QS+c1aE/JvJKTEel3y+A
         1i5UfqnbQ/82rzYgYa5+vH8KrKjoTUxbbKE3joHkrxc+rYe99Lpp+KkjtmrV8SWmw3
         6wc3MMuVsq+BnlzrB9deygQkgWHTL+Qi7WHvyJRU=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5Spx7cTSMh_9; Tue, 17 Mar 2020 20:59:06 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1750A8EE109;
        Tue, 17 Mar 2020 20:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1584503946;
        bh=ydIbcdjee5XcxlB6Ithv1fKp8IIXYWSS41zaq3y/uGQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cnW+GuZABznG2AR8ki1R9fva9LdyBqzQvbz8LYh4spdU0QS+c1aE/JvJKTEel3y+A
         1i5UfqnbQ/82rzYgYa5+vH8KrKjoTUxbbKE3joHkrxc+rYe99Lpp+KkjtmrV8SWmw3
         6wc3MMuVsq+BnlzrB9deygQkgWHTL+Qi7WHvyJRU=
Message-ID: <1584503945.15565.23.camel@HansenPartnership.com>
Subject: Re: [PATCH] mm: Fix a comment typo
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     brookxu <brookxu.cn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Tue, 17 Mar 2020 20:59:05 -0700
In-Reply-To: <0783042a-244c-0c2e-091d-e7002718d73f@gmail.com>
References: <0783042a-244c-0c2e-091d-e7002718d73f@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-18 at 11:42 +0800, brookxu wrote:
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> 
> ---
>  mm/page-writeback.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 2caf780..2acf754 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -1271,7 +1271,7 @@ static void wb_update_dirty_ratelimit(struct
> dirty_throttle_control *dtc,
>       */
>  
>      /*
> -     * dirty_ratelimit will follow balanced_dirty_ratelimit iff
> +     * dirty_ratelimit will follow balanced_dirty_ratelimit if

Are you sure it's a mistake? iff means if and only if which would be
reasonable unless the condition is only implies.
 
James

