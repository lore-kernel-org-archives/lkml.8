Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE8DC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A31FA204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VHDocVcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgHOVwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbgHOVwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:13 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE0DC00868E
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 10:11:15 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id x6so5989763pgx.12
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 10:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BAVB1g/G59WljuvEwZfLgQcZGsyMrz+xF+J2CpCEONs=;
        b=VHDocVcgp3i5hnK3JOC5n1xwowOu3PG/vmHdB2FTQmrkQIk9Vq4xClNNXpQX9xq0XU
         SZ5C9UytWUiDuV74J9uvKS+lrRzMumsUcYw8LPFYKXG6BE40hAPeBdzFoXLVqk3X9L9+
         dR0mb1S0fCgzBmx3RNiHRjErZue/3+FGTXB50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BAVB1g/G59WljuvEwZfLgQcZGsyMrz+xF+J2CpCEONs=;
        b=BsTU9VSOGdJrMmSKmgL5/sY5xkNsnqh7uQ4GFRw72xk44kR0xC0YdnYvealE+gulJs
         rlr9YTlQ4oqphhsPDBlrMb4hkItTM0P/CJLtOqq5XoA22ohgd7qZNU8B9E037m6uiHVg
         rX5L6hIwfB3vKTVbeqNepCNpjULKHae8a8gWJGL8nKEH/DFnn3RRhPuvsGb4hpFhm13P
         8sZBjrxvYS3wLTnlVf/dKL20lx1KGA/f7KbRSgXEL0TRUpiZbIfkgflDtX6cD29qj9pc
         vVv0gyLrHWv4g9OsbDrJQ19lIKBktFAs7fmjaTf7D+WSj1y+/yg/MjsOXqbSu++jRXcs
         /PpQ==
X-Gm-Message-State: AOAM533JsKxuOwolmNe/OWaAwvmW2xHSeWHR+LYmRvlg+/J61Bx9XuBc
        tJ03hs7bDhURLXqLqwNwoWEqlg==
X-Google-Smtp-Source: ABdhPJyVSgnrgPrYWyXJv2wtFzi9lR01OEh1e48ygJ0aU1juIKmiqcLNGCA17IPGnewHz9ccm0/ehA==
X-Received: by 2002:a62:8387:: with SMTP id h129mr5505019pfe.142.1597511474893;
        Sat, 15 Aug 2020 10:11:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w3sm12829718pff.56.2020.08.15.10.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 10:11:14 -0700 (PDT)
Date:   Sat, 15 Aug 2020 10:11:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH] overflow: Add __must_check attribute to check_*() helpers
Message-ID: <202008151009.5709750A@keescook>
References: <202008121450.405E4A3@keescook>
 <f7b6ad2f-4b35-1ca8-0137-05b27a0eb574@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7b6ad2f-4b35-1ca8-0137-05b27a0eb574@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 08:39:44AM +0200, Rasmus Villemoes wrote:
> On 12/08/2020 23.51, Kees Cook wrote:
> > Since the destination variable of the check_*_overflow() helpers will
> > contain a wrapped value on failure, it would be best to make sure callers
> > really did check the return result of the helper. Adjust the macros to use
> > a bool-wrapping static inline that is marked with __must_check. This means
> > the macros can continue to have their type-agnostic behavior while gaining
> > the function attribute (that cannot be applied directly to macros).
> > 
> > Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/linux/overflow.h | 51 +++++++++++++++++++++++-----------------
> >  1 file changed, 30 insertions(+), 21 deletions(-)
> > 
> > diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> > index 93fcef105061..ef7d538c2d08 100644
> > --- a/include/linux/overflow.h
> > +++ b/include/linux/overflow.h
> > @@ -43,6 +43,16 @@
> >  #define is_non_negative(a) ((a) > 0 || (a) == 0)
> >  #define is_negative(a) (!(is_non_negative(a)))
> >  
> > +/*
> > + * Allows to effectively us apply __must_check to a macro so we can have
> 
> word ordering?

This and the __must_check-bool() renaming now done and sent in v2.
Thanks!

> Sorry, I meant to send this before your cooking was done but forgot
> about it again. Not a big deal, but it occurred to me it might be better
> to rename the existing check_*_overflow to __check_*_overflow (in both
> branches of the COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW), and then
> 
> #define check_*_overflow(a, b, d)
> __must_check_bool(__check_*_overflow(a, b, d))

At the end of the day, I'd rather not have a way to ignore the overflow
in this way -- I'd rather have a set of wrap_mul_overflow() helpers
instead. Then we've got proper annotation of the expectation (and a
place for function attributes to be added to tell sanitizers to ignore
overflow).

-- 
Kees Cook
