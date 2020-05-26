Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBFFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 23:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB95B206F1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 23:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JauNAD2t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgEZX1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 19:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgEZX1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 19:27:31 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1A9C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 16:27:31 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ci23so515139pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 16:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BDU5QxHKfnniQjXMdNd8leB2OBRpea7hzh8IAFTe8mU=;
        b=JauNAD2t8UpfMd0AfJM6AP+1DoGowd7xydgMPaSmjV+fLvAy9vodadIFD7PfYMESGS
         43shPgE6gcLYWiC+Yqur4CdnHGtq9zSnYu6Uc5C9S1C0+feG2ccRpr7QXTaprCPMF/ku
         wqXWHDvfsGYQ/8qD/83YfNFBXkRosntbpscIyJg6upEH0L3wk/kbN3H/orwZeRHXr7eQ
         sLaB/gZUuhH1qd14FW9p8u2MjP3d8f++qtdHhK5lecoNGcHCtL3u+mFN4U4mh4c1t+JN
         H8jFLSnK8QGB3kE6GeerKBoSP4cHbf/0wlbrPqkRmt7E9gb/Ejrr3uUN11gLzQqcLPUd
         lrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BDU5QxHKfnniQjXMdNd8leB2OBRpea7hzh8IAFTe8mU=;
        b=PzN3BpbyOlSHMlWf3LpZxUKLRgh4SI58FbE0bGaIt9U19qkFTRpH8T0EViKfSV6jB8
         FCoZJBul2bFshp/Gu5lmgkKFfnk3cu8pvRDIlca12EXthww7P5LyHRKt5MgJoQlU5lfx
         yGwoRh0C6sOdXXF7/xsPbRCC1frTq/S7XoZdVOyW622mqZC+oXLxVjE1N1oEbUASj3MF
         tm4hdaOIO2t+Q91OOXbiWgTXrfUZuqPmLzjEGy6b2U1YBujPLyVyxwRTqR51JRpnzhr1
         gL1X3xtWL+XsbEdD+MGjV/WF5BTay4Lgca9oTRdqdBpwUKQK6FyXYd/JLVTMpUg+FzTc
         pqOw==
X-Gm-Message-State: AOAM532wmXvARdEkC7v6T3zd/++o+6LVf5X0wVhvmmRoWkYQXG47hlGj
        LbjuvWqHnxWRIMX61+HK3duj4g==
X-Google-Smtp-Source: ABdhPJzh/Y4lO8y3LbQ4vMbMOwF9wg80Ql+Tf/HfqKoSCDQt7lQYN6Fx9BcM4qcFibWghFVP7jsykg==
X-Received: by 2002:a17:90a:2e08:: with SMTP id q8mr1736397pjd.153.1590535650405;
        Tue, 26 May 2020 16:27:30 -0700 (PDT)
Received: from google.com (240.242.82.34.bc.googleusercontent.com. [34.82.242.240])
        by smtp.gmail.com with ESMTPSA id h7sm586267pgg.17.2020.05.26.16.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 16:27:29 -0700 (PDT)
Date:   Tue, 26 May 2020 23:27:25 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] block: blk-crypto-fallback: remove redundant
 initialization of variable err'
Message-ID: <20200526232725.GA41114@google.com>
References: <20200526224902.63975-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526224902.63975-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 11:49:02PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable err is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  block/blk-crypto-fallback.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
> index 74ab137ae3ba..6e49688a2d80 100644
> --- a/block/blk-crypto-fallback.c
> +++ b/block/blk-crypto-fallback.c
> @@ -529,7 +529,7 @@ static bool blk_crypto_fallback_inited;
>  static int blk_crypto_fallback_init(void)
>  {
>  	int i;
> -	int err = -ENOMEM;
> +	int err;
>  
>  	if (blk_crypto_fallback_inited)
>  		return 0;
> -- 
Looks good to me - you can add:

Reviewed-by: Satya Tangirala <satyat@google.com>

Thanks!
> 2.25.1
> 
