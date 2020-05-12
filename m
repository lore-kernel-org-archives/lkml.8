Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1ACDCA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73985207BC
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eLyBmK4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbgELS60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 14:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgELS60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 14:58:26 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10529C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 11:58:26 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f15so5774920plr.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 11:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tqJqrkQlOeeaa2aC/rVtq+THzafBAmOFZekSr7YovNs=;
        b=eLyBmK4uD/tLsZFaAduNimk2uSZAxJNelury6EMqIFUQrr2AMLinYxuRkH80L3/JGR
         aPPa5Q9Jbr6bEBVbQSb/il5yV0dKhB0WRlFXSFwPWc4kr7vi268YZRqn5XzW09HVGaGd
         zo2MKLH7p2S7BgWltW5tjh71VDFCco2cfZUtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tqJqrkQlOeeaa2aC/rVtq+THzafBAmOFZekSr7YovNs=;
        b=ao4p/RkpNxWRE5G4Mg7/hCcHr2eeMm3t6b3BO6p7zSNPXPszwhY7WbZZ/EOkarFzhN
         vrHtk8BCj2mkh5epj89KdEz3prPka+cMEH9D8Js6qJZHDIxmJrx1L4fyfp71GGYKf/X5
         8ozDbAtrHC4uDAy53J5CTMnMRXYW4Hu+N4wMK/ewe3c4OJEpKxsBkasNUl38nWamDzG4
         IRzqkVXJoALlrRaV3TsZ8Kn9ICTpLdQOVvGnENP8RkUcPoAGuo1QbBqf4q0DkMihc0r/
         P2STmuSrGAT7iC2owFOi8SQeY1aIh5QOjh47+WTMhoixasTnx2jvXVcipg+8/Su6fkmf
         QsVg==
X-Gm-Message-State: AGi0PuZFHYFyPui66BeDTY9VgOQBoP95+MR0XsNpPQZV+fNGCJtQV3RX
        T0uGn8BrPONSxWrr+i4iCvOVFQ==
X-Google-Smtp-Source: APiQypJBsVPRcjsL5leeuDbu+zRxGc76UfPGelH8aCgq0TZhTTiI4rvumMkjBky9sZVHEILQV+LE/w==
X-Received: by 2002:a17:90a:290f:: with SMTP id g15mr29587956pjd.93.1589309905462;
        Tue, 12 May 2020 11:58:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s199sm12809112pfs.124.2020.05.12.11.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 11:58:24 -0700 (PDT)
Date:   Tue, 12 May 2020 11:58:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] pstore/zone,blk: fix dereference of pointer before
 it has been null checked
Message-ID: <202005121158.4D49A98839@keescook>
References: <20200512170719.221514-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512170719.221514-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 06:07:19PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the assignment of ctx dereferences pointer 'record' before
> the pointer has been null checked. Fix this by only making this
> dereference after it has been null checked close to the point ctx
> is to be used.
> 
> Addresses-Coverity: ("Dereference before null check")
> Fixes: bb4ccd1e6f56 ("pstore/zone,blk: Add ftrace frontend support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks; applied.

-Kees

> ---
>  fs/pstore/zone.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
> index bd8e194110fc..c5bf3b9f644f 100644
> --- a/fs/pstore/zone.c
> +++ b/fs/pstore/zone.c
> @@ -998,7 +998,7 @@ static ssize_t psz_kmsg_read(struct pstore_zone *zone,
>  static ssize_t psz_ftrace_read(struct pstore_zone *zone,
>  		struct pstore_record *record)
>  {
> -	struct psz_context *cxt = record->psi->data;
> +	struct psz_context *cxt;
>  	struct psz_buffer *buf;
>  	int ret;
>  
> @@ -1018,6 +1018,7 @@ static ssize_t psz_ftrace_read(struct pstore_zone *zone,
>  		return ret;
>  
>  out:
> +	cxt = record->psi->data;
>  	if (cxt->ftrace_read_cnt < cxt->ftrace_max_cnt)
>  		/* then, read next ftrace zone */
>  		return -ENOMSG;
> -- 
> 2.25.1
> 

-- 
Kees Cook
