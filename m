Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449D3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 153F7206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pog6G4Xw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbgFSJvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 05:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729195AbgFSJvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 05:51:14 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D4CC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 02:51:13 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u26so8452390wmn.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 02:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7FAIWmvRcbpZijvAS3kLAgH9Col/vMn+YzYXrUPtI8o=;
        b=Pog6G4XwSK2TysGz0pOdPvS5S4S1fNZmUJIUdByk+2NZZkT/CKOWpsgzx0NIilJCfM
         VBXrwgPhre/oMEV0bDiBuXrb91iSnY1m9de4u6nLkDJhBvRae8RFEfuXZx+3/HKw3iOM
         qSu4CtsyOqunnvTY1u9+0uVlH+NTB03IXHd7km+pIzun4YexxiKu3JmRiLdcPl14GkZD
         Ad/3G8qe9s8htKyrmGkXL5YuyLd22tXmPIXZgV0cKp+bYMUYjiSTB47zIKZq4xcIIQKb
         BSSdr+bXJyn7tyqRZnWCfOOeQ9I3NdnzGTeRMBafqMCBTPOIpfg7lunD0Fjf9sYU3njm
         dYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7FAIWmvRcbpZijvAS3kLAgH9Col/vMn+YzYXrUPtI8o=;
        b=iRuppwCEyDzyRLURSRl77+NYE++3jT5WTX1B/ffB48c05PE7oGEEkgu6w716jCOtbD
         cnj0PGZXpe1Klf4LEIbC7mKEr2mla6ShUUalbOCjRxyAfMt5aK3PupQt1wbZ4JLbO4Eh
         UfJt2FBoMgafJk4mxtUxyMh+iz3IKnvGlACK0nMrD2bJQVKJY39OFoc70NtW0j0Q0FzL
         xVqrf1RqNXj0UzH6uDp3DqFNxXAzKX3PK9tfb5iY4+heht2VbXrMx5Ar4GNKcLZD6OJP
         s005PHWvJ4wVB1ZWOTvAIydYLJZcTjsOCXPEVx3A7UHj8+2knBXpBnXB7FIeRoJJmMs/
         S8Ow==
X-Gm-Message-State: AOAM530kEGatq8+ZJXzQDfhulastBVignwFEQ5VZ2bPxL4OP7wnc9u1T
        So/piLNZYvGeRO5vZl6HLHXlQwnfZzY=
X-Google-Smtp-Source: ABdhPJwypCCeE0TN1hcug7CU1oSgHLQ5aaTekBniUlUpDm4skYm23QX5Aao76s6MBC2D/U4B2SCmRA==
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr2800931wmk.171.1592560271978;
        Fri, 19 Jun 2020 02:51:11 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id a81sm6736338wmd.25.2020.06.19.02.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 02:51:11 -0700 (PDT)
Date:   Fri, 19 Jun 2020 11:51:05 +0200
From:   Marco Elver <elver@google.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] sparse: use the _Generic() version of
 __unqual_scalar_typeof()
Message-ID: <20200619095105.GA222848@elver.google.com>
References: <20200618222620.5069-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618222620.5069-1-luc.vanoostenryck@gmail.com>
User-Agent: Mutt/1.13.2 (2019-12-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 12:26AM +0200, Luc Van Oostenryck wrote:
> If the file is being checked with sparse, use the version of
> __unqual_scalar_typeof() using _Generic(), leaving the unoptimized
> version only for the oldest versions of GCC.
> 
> This reverts commit
>   b398ace5d2ea ("compiler_types.h: Use unoptimized __unqual_scalar_typeof for sparse")
> 
> Note: a recent version of sparse will be needed (minimum v0.6.2-rc2
>        or later than 2020-05-28).
> 
> Cc: Marco Elver <elver@google.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Will Deacon <will@kernel.org>
> Link: https://marc.info/?l=linux-sparse&m=159233481816454
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Definitely support this change, so in principle:

	Acked-by: Marco Elver <elver@google.com>

But, I think sparse still isn't entirely happy with all legal uses of
_Generic. Running latest sparse on:

	void test_Generic_conversion(void)
	{
	#define TEST_WITH_QUALIFIER(type, selection_type)			\
		do {								\
			type var = 0;						\
			_Generic(var, selection_type: (void (*)(type))0)(var);	\
		} while (0)
		/* Expect no errors. */
		TEST_WITH_QUALIFIER(const int, int);
		TEST_WITH_QUALIFIER(volatile int, int);
		TEST_WITH_QUALIFIER(_Atomic int, int);
		TEST_WITH_QUALIFIER(register int, int);
	}

results in

	generic-test.c:9:9: error: no generic selection for 'int const var'
	generic-test.c:10:9: error: no generic selection for 'int volatile var'
	generic-test.c:11:9: error: no generic selection for 'int [atomic] var'

Whereas GCC or Clang accept this as expected. I can't find the
standardese right now, but in [1] we have:

	"[...] The conversion is performed in type domain only: it
	discards the top-level cvr-qualifiers and atomicity and applies
	array-to-pointer/function-to-pointer transformations to the type
	of the controlling expression [...]"

[1] https://en.cppreference.com/w/c/language/generic

Thanks,
-- Marco
