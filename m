Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC18C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A5020CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586519824;
	bh=Cex4VVlCM9vChwj5c3jghHXQ2q6XTHD7MCIxTt6g2eE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tjeR+t/TGPfBwTfo8QPVFUroAorYnG4l85mynQM7lHd3K+dIFbb0KM9tMIOpcd53x
	 ZAP+lFcC4Kdc8fcYd7HifIvFo+4fGCz21itXRgIGcWVBgOP1cO8M8WabfByjDGRAHP
	 rpnBYjftOS21BekO6EH/KT1+2WyFPqBzY9gq2Njs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgDJL5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 07:57:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbgDJL5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 07:57:02 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D3742084D;
        Fri, 10 Apr 2020 11:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586519823;
        bh=Cex4VVlCM9vChwj5c3jghHXQ2q6XTHD7MCIxTt6g2eE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EF5CuvK3MzwsYRoxcD6UMscywJqx5dtOFrtb664x5QYEcprEsJAJA1kbjqBE0FjLB
         TOT82oM48mYDk+ElDkBFk42phTbg+H4ir8EaouPOHdIGBhUE9N2LAwo6cvB8YiOGjK
         uRK6ZcZ2HlcyLfsakLHU7OLLAYXH88gtno4he1gA=
Date:   Fri, 10 Apr 2020 12:56:58 +0100
From:   Will Deacon <will@kernel.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seqlock: Use while instead of if+goto in
 __read_seqcount_begin
Message-ID: <20200410115658.GB24814@willie-the-truck>
References: <20200409134558.90863-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409134558.90863-1-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 09:45:58PM +0800, Muchun Song wrote:
> The creators of the C language gave us the while keyword. Let's use
> that instead of synthesizing it from if+goto.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/seqlock.h | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index 8b97204f35a77..7bdea019814ce 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -125,12 +125,8 @@ static inline unsigned __read_seqcount_begin(const seqcount_t *s)
>  {
>  	unsigned ret;
>  
> -repeat:
> -	ret = READ_ONCE(s->sequence);
> -	if (unlikely(ret & 1)) {
> +	while (unlikely((ret = READ_ONCE(s->sequence)) & 1))
>  		cpu_relax();
> -		goto repeat;
> -	}
>  	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
>  	return ret;

Patch looks fine to me, but I'll leave it to Peter as I don't have a
preference either way.

Will
