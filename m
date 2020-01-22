Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3142AC2D0CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 01:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEED621835
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 01:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mmry9Gvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAVBKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 20:10:22 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38245 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbgAVBKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 20:10:21 -0500
Received: by mail-qk1-f193.google.com with SMTP id k6so4840472qki.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 17:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xJlf2/Q3PLDs4Iy9IzlLnbg2vHNS9/Vku/zAI8tTziE=;
        b=Mmry9GvlhlntsQSvbDZVmMoDG5lU4GJCc27XfWAYDZ/lnobx+nIJQdYLgCeXEqaBeK
         n9AgklRW3wFgJHxEfqWog3HzCCIRaDivo9P8iwuIdJgdVr/9wg7FlFou32oR2JRqpAQN
         fwNJruI1shHUR2WGX0HBtVrdp+SFEZ9FKZV8o3pKm97Ky9mrIZ7lNme5Qi+JNOc35HkQ
         zauDJ+tPUhwToTJI5Sn5xncV/jm3vS7vfe+9F+yFvmopvVjVOaUD09i4xoCUq4DK4I+9
         D2j+GfKtuJik1hCrc54L7OxYwGSlei30wQ2WraU4m/2uIQMQm/jSatE0nnk5Ik3loLBA
         NewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xJlf2/Q3PLDs4Iy9IzlLnbg2vHNS9/Vku/zAI8tTziE=;
        b=Ngq62qpkjNudIN0ew9K9NUYJ6UXXUutjKEhQdJw44nOsYfp9E4MYG1oaBCwwp0TL0R
         xPeeCd1AwZguqYXGvnDRdbPMUFT1AdL7fLCu6V3fzRLpHwaOVAr4ntGC2SFpBXIWccpo
         ERML1bml6dIs1dIXfekKRZFMKzu+Cziu3hCIXQ0FCK9b4MgeKNTg4SJWfQDxlZCxa3ON
         OHiAwrn1Un4WmvMVwTKrG9VoT/npQCHc0wmoB69jrAk7RGOhHrGFEZUAzzFJf9cMHJ30
         thhA0hKey++fnKgN2ZVf3YLi1EIP9cZnCPyNFSOg10VfYSoWD1L9alcE4qAbnwJuZaDO
         7vrA==
X-Gm-Message-State: APjAAAUsVnlBiCy0G8XVeQrDF4rG4gckBFXkOHPiRDuUn3jjYqjzDwsK
        5pxcecbc2TvhVkcUXSscGXV8AQgb
X-Google-Smtp-Source: APXvYqzr/MJ68zm1cKuACrXdA98dWLtk0o/JCWnXKRkiyoQbk92Xuo9MQCdvm8jr/fRt6Jus9+lh8g==
X-Received: by 2002:a37:4d10:: with SMTP id a16mr7533403qkb.325.1579655420606;
        Tue, 21 Jan 2020 17:10:20 -0800 (PST)
Received: from localhost (198-0-15-102-static.hfc.comcastbusiness.net. [198.0.15.102])
        by smtp.gmail.com with ESMTPSA id h13sm973846qtu.23.2020.01.21.17.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 17:10:20 -0800 (PST)
Date:   Tue, 21 Jan 2020 17:10:18 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        "Tobin C. Harding" <tobin@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/bitmap: remove expect_eq_u32_array
Message-ID: <20200122011018.GA14737@yury-thinkpad>
References: <1579595625-250942-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200121132050.GT32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121132050.GT32742@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 03:20:50PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 21, 2020 at 04:33:45PM +0800, Alex Shi wrote:
> > expect_eq_u32_array isn't used from commit 3aa56885e516 ("bitmap:
> > replace bitmap_{from,to}_u32array").
> > And EXP2_IN_BITS are never used. so better to remove them.
> 
> I think better "fix" will be to add test cases.
> See the commit message in the
> 
> commit 3aa56885e51683a19c8aa71739fd279b3f501cd7
> Author: Yury Norov <ynorov@caviumnetworks.com>
> Date:   Tue Feb 6 15:38:06 2018 -0800
> 
>     bitmap: replace bitmap_{from,to}_u32array
> 
> -- 
> With Best Regards,
> Andy Shevchenko
 
On the other hand, it's almost 2 years gone since the commit you
mentioned, and nobody used the check_eq_u32_array(). So I think
it's long enough to consider the function useless.

This function is the last example of 2 lengths in input, so I'd
prefer to remove it. However, removing check_eq_u32_array() should
be synchronized with underlying __check_eq_u32_array().

Yury
