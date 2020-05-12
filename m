Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5AFCA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 19:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2321B20731
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 19:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eAi54b7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731041AbgELTlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 15:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbgELTlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 15:41:00 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5712C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 12:41:00 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id b12so3917125plz.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 12:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7D7Hp2GHNstyMCh5/XTJVjifd1carg86uB7RWlRtVlk=;
        b=eAi54b7sSwZ/ceWB/pyFmHuU9A6POh5j1MeBzE62jl0QdYxK30WtVdS7xnYkks0AZC
         5DiGpqVxN8FSMTdmAOz613qHVonGKpeU99UX5OlJRWpbO/Z95dNEVD6dLyNS2bvfChTt
         s+NKxPBc5j1gvCxYMmBes/J5zxuTGia5axYko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7D7Hp2GHNstyMCh5/XTJVjifd1carg86uB7RWlRtVlk=;
        b=K5HqwKt9Z0Guo7j4eLNcf6WDDXzqzIu2i6faJ39AdLX44vOCLN+r3SMtgwCTvqsKKY
         nbvWVZe5p8i7Prh4rkPu4OoAh3TFf4u+12+oQw9fEU/vaXZDqr29a1bZPyrmI1fl/tAW
         efkEdHssGWyArm+gItanqCGmT1N1uiJJ1Ngn3o86qv+njDRWmqM+MMEH+/J4X3GGtQkb
         WeOvMIWT8REjJeAGXzNlkCrNstDbkEHR2bjxmyLm2MzVHBeVbrx0cN8kiP2amO9eyNOC
         yt8udTYDt1/PwooZmXTf1qkvIVHm4So6wFyUnvO7xTg3/yPxiqWPkiYynhf0mMsLyNXM
         5HjA==
X-Gm-Message-State: AGi0Puaa2rqdr4PHZf2cqmHUKIC8NjcY5zj6Wx8h8FUcOlNVQNROumRr
        KRrA/RsrF3xIKlLebItwv4QCSA==
X-Google-Smtp-Source: APiQypJFl6pnbq/6iz9o/q8NodQpt4ZAxP/h9BeLDm25JvtCQXuKGkQ1+6UchXzPAdhaBpsn0jK7+A==
X-Received: by 2002:a17:902:6b01:: with SMTP id o1mr22072464plk.64.1589312460110;
        Tue, 12 May 2020 12:41:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c2sm8737915pgj.93.2020.05.12.12.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 12:40:59 -0700 (PDT)
Date:   Tue, 12 May 2020 12:40:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] pstore/zone: remove redundant initializations to
 variable ret
Message-ID: <202005121240.1C306861D@keescook>
References: <20200512173801.222666-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512173801.222666-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 06:38:01PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable rc is being initialized with a value that is never read and it
> is being updated later with a new value.  The initialization is redundant
> and can be removed.  In one of the cases, ret can also be moved inside a
> for-loop to reduce the scope.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks!

> ---
>  fs/pstore/zone.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
> index 3cf7d6762c76..419de481c69c 100644
> --- a/fs/pstore/zone.c
> +++ b/fs/pstore/zone.c
> @@ -600,7 +600,7 @@ static int psz_recover_zones(struct psz_context *cxt,
>   */
>  static inline int psz_recovery(struct psz_context *cxt)
>  {
> -	int ret = -EBUSY;
> +	int ret;
>  
>  	if (atomic_read(&cxt->recovered))
>  		return 0;

I've refactored this code.

> @@ -746,13 +746,13 @@ static void psz_write_kmsg_hdr(struct pstore_zone *zone,
>  static inline int notrace psz_kmsg_write_record(struct psz_context *cxt,
>  		struct pstore_record *record)
>  {
> -	int ret = -EBUSY;
>  	size_t size, hlen;
>  	struct pstore_zone *zone;
>  	unsigned int i;
>  
>  	for (i = 0; i < cxt->kmsg_max_cnt; i++) {
>  		unsigned int zonenum, len;
> +		int ret;
>  
>  		zonenum = (cxt->kmsg_write_cnt + i) % cxt->kmsg_max_cnt;
>  		zone = cxt->kpszs[zonenum];

And I've applied this hunk. Thanks!

-- 
Kees Cook
