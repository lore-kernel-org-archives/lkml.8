Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA0BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B492207ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ktcWbf9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730792AbgFIP0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbgFIP0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 11:26:52 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D733BC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 08:26:51 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a45so1121837pje.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 08:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hKBdXhBbxeMf1zZAIRmQnlSS5hyl8vycpJfOHJIsl1k=;
        b=ktcWbf9t7CDVfIXrfLk9AgvDPAXHpqFQ4QBEiHl6S2vu1grCxrFdPeVekSbrSKwbGP
         xlv8Lg59G/jY5g/vYCYdXUnmzbylO2T9OXfLtQDXIIhs3gMJJIrp5b0trGXwz5HYQlO3
         XehqsbNL38yybzY3TMy6ET07KOFSeJk5fnv3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hKBdXhBbxeMf1zZAIRmQnlSS5hyl8vycpJfOHJIsl1k=;
        b=e5iwrgCZxffJtvQp4Oy0FXbTBTCasgksMmooHXxAEtTZj4+p5uHjskzQ1Dbj/mgHHt
         PO/LEyvPsIVz2pBtrEz/DxgV1filZi5FNOXT9hpUXy5VBXVep7B3YW3pmWr8uIFLRz+z
         T7Cmn4mAiW6rST5gsVJ1pQs+ueuJqgOjN1bRQWpFHD2ChBzjO/OyX21lep1JDurPBmGS
         RPvpy0mvtdBQ9Frybae1oQpO0bgec2D8mf6kuj+FxzejnjDC0Pfp8gy9f3lRfCNRB3CL
         6v64eH/oCs12PTpjWm6yLZsowXfBFtOWjeSJNeMQqSy3bVTLCbmDojzReGNCg62P8z7L
         J70w==
X-Gm-Message-State: AOAM533NpF3j9vwzCzHY7mTHMQfRAsmHRqILI5vExnldH/P60dqhEi/c
        gVSvcUV7ZMsmdVmvukspgpL01w==
X-Google-Smtp-Source: ABdhPJzLg5xQN9yd4fV/saz0u7mM7/y6wZHLk3nkpgPyBS4/K761pAeAPhSeD4infqlRQO7+L22WmQ==
X-Received: by 2002:a17:90b:2391:: with SMTP id mr17mr5139549pjb.220.1591716411431;
        Tue, 09 Jun 2020 08:26:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x14sm10401151pfq.80.2020.06.09.08.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 08:26:50 -0700 (PDT)
Date:   Tue, 9 Jun 2020 08:26:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] overflow.h: Add flex_array_size() helper
Message-ID: <202006090819.92840D81@keescook>
References: <20200608221723.GA23644@embeddedor>
 <05ab102b936ce922c4fae67bf5dd3e323aff0b93.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05ab102b936ce922c4fae67bf5dd3e323aff0b93.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 03:34:52PM -0700, Joe Perches wrote:
> On Mon, 2020-06-08 at 17:17 -0500, Gustavo A. R. Silva wrote:
> > Add flex_array_size() helper for the calculation of the size, in bytes,
> > of a flexible array member contained within an enclosing structure.
> > 
> > Example of usage:
> > foo
> > struct something {
> > 	size_t count;
> > 	struct foo items[];
> > };
> > 
> > struct something *instance;
> []
> > diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> []
> > +/**
> > + * flex_array_size() - Calculate size of a flexible array member within
> > + * an enclosing structure.
> 
> These comment descriptions do not match
> 
> > + * Calculates size of memory needed for flexible array @member of @count
> > + * elements within structure @p.
>
> The first comment shows the size of an array member.

Ah, I see what you mean. I was parsing it as "flexible-array structure member"
but it does say "a" and "array member". Perhaps:

Calculate size needed for entire flexible array contents within an
enclosing structure.

?

-- 
Kees Cook
