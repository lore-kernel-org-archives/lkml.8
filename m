Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D00AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E788204EA
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595933907;
	bh=61VcW7S4tJ9mcZBT0Ceel00V92s2J2sgrA221ViKFRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rIbU4bIamEO+fcrtpLCT0wZZfG+QHFdHaCLtMv+uHqrrUESgPuwTYlzvvcyH+huGf
	 0C4J3X+q1+hzRjhfEUhK4L85pVZySplGtdXfqTNxaMDIqlKqSK1y5W5Xsm6kjpozGA
	 MEjcE+Cl6UU1RCJlBwjtjkZFtNRINDdhvWjbZ/10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgG1K6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbgG1K6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:58:25 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA886C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:58:24 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id n2so14463655edr.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0MkGALgLU1/JNMURw97YOk+hpUfJEVXG0OVfPqsaaPE=;
        b=Yit+hdsaOSOSnirfAFneLmpBb4D2icJuJdHVCP9d5CaSFlaYrl3hkRvNer7945VNKc
         piH1pioLdR1v3dy/31QsQ7EMviZcRVwY39CJ0gCTIGsDBXVdcQGg523KMlYBNBmadbNz
         7Kj8T/6L40y26RFf1qOiDVpqJqbZ/Q6d4WNOZRhgj+0OG3+DhrfJh6yz4k4INZ85nvcF
         +i1RijV4G7Sbe/oKogoRaEHMCee/8E1jjspuYuUVfNF0UCVhDOngEHLwFupxWmYxX6qd
         uQWMsfw/+mWlA4FCLKi2Yf7V1PpAekKoVr97wcAuL3lj3/ZDJEDfizpQiA+B92WRJiGz
         bOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0MkGALgLU1/JNMURw97YOk+hpUfJEVXG0OVfPqsaaPE=;
        b=mmA1+wOKFBiUQaVtcGo08bZ248+3E/Su6tq/FKztUfFiFlfAOMut9LQUJmS8wN4aq8
         j30JfQlMV3WmZ9peBMznzjEB9K8DHK/jPPdf73vCKSye/7lm2IJlYn7JwLbejGsbo+Lg
         vxqXzxzWmLwgL8Qxk4JyXhCG1URDm+rOKIHgF6nBECl8aq5vZqcNXb6NVQF7O05coYSP
         DYeA8typ21QmP1Ekcy0DpOmEFdL/jJrfW55ZuIvKAL0kkKieydYJt5TnO4TyGz3yInaN
         mTvlkBajAdYXq3TstT51wcpDpfQBZajmJePahCvHix1ezCuimlwVOCKzbPqPVx/mrtqH
         1CGg==
X-Gm-Message-State: AOAM532FHgygqA5aA7FqnhPlMjBGwYi+//4/S1b43ilxln2YLgERz4AC
        D00BhLRYRPfdXIDnokcu140=
X-Google-Smtp-Source: ABdhPJwUF7JnEpFSsgUOu8UV2yrcWkgSET6TilztrI2zLG1qL+55CUAQglAht13LnDkVmy026wmUOQ==
X-Received: by 2002:a50:fd8d:: with SMTP id o13mr6029394edt.313.1595933903716;
        Tue, 28 Jul 2020 03:58:23 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id yj16sm9056649ejb.122.2020.07.28.03.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 03:58:22 -0700 (PDT)
Date:   Tue, 28 Jul 2020 12:58:21 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] x86/kaslr: Simplify process_gb_huge_pages
Message-ID: <20200728105821.GC222284@gmail.com>
References: <20200727215047.3341098-1-nivedita@alum.mit.edu>
 <20200727215047.3341098-7-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727215047.3341098-7-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arvind Sankar <nivedita@alum.mit.edu> wrote:

> Short-circuit the whole function on 32-bit.
> 
> Replace the loop to determine the number of 1Gb pages with arithmetic.
> 
> Fix one minor bug: if the end of the region is aligned on a 1Gb
> boundary, the current code will not use the last available 1Gb page due
> to an off-by-one error.

Please split this up into two patches: first the minor bugfix, and 
then the cleanup which will then be an invariant patch, in principle.

Thanks,

	Ingo
