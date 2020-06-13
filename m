Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432C2C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 12:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 205C02078A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 12:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CU6y3HBb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgFMMEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 08:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgFMMEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 08:04:37 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAE5C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 05:04:36 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 64so5578632pfv.11
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 05:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LBrsfxO25w2eu+lrtvfG2KxIdSA+88lYE5tWiAEH8qM=;
        b=CU6y3HBbj/n8jNq32wKmlGbKqblgo+cnqIRVSSA2jz7Qn3+T+ejYaQtqm4xEFmL6/t
         7doJiv+0cF/A5BVpe3f6BdSc1JNyzs2vtcAU2MdYBNU0z1Z4K6pnnB0OqimD0U9szNeU
         Y0OGDGOny5I3deJZfLq2iQYSPI6TuvDm35tjCMgWUMDTc7aeUsrQPrVjW0RZJ95djrgM
         fkOzUadFV2+ZCwOOLy9YPEAaO93mgN37StRybZlo/Gzt53gP7b/6k6Y2+2FIy+KU66uM
         8zCY5yan04lXaJw2BW8w52YzWseMaG5U1yaxcdwWAO4LI7vlFWGlp6txNonl2MiiS09l
         aXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LBrsfxO25w2eu+lrtvfG2KxIdSA+88lYE5tWiAEH8qM=;
        b=ac4KVPLccg0CX/VxNi1EnYiBLhuAmE0YuOinGWfZ+PD/NAXiQctxzz0Yl2cRhRNRR2
         6+mMdh2QDTLD1nKXMEZ4u/j80j72/WqeVlZdMlrAfjzighYI9Rw0NBu55vtjsBF/iLPT
         m5HvFq7Sp4Fy5/t7+dW2CQc/TFGeHf8Y0TkdG10Pw7BEWgk7QoeCcBKEicSvJfxdH3b1
         rwiZn2FokYIWmVxD3rczFUREJl1ubDJTo7/NPX4xOz+GQsYiB/9E0dju7D2pruwrwR4M
         ojF06AtWm4/CgQmdiY1cSNbWRx7YV91fRg8cXVyWX8SwJdI/TKClLPATE9JbGwFAkl+l
         gV0g==
X-Gm-Message-State: AOAM533qPfuk4U0T1IG1sbTqPZxRmlTyZqvu+iuFaqSdzKs5AiZEZ0lq
        x8l4fPnLFSS+t9vu3M7A0vo=
X-Google-Smtp-Source: ABdhPJwmpmABGRrQm+OFl+czCBJy5iA0MDun8zYJpfbPLnNUBn63dzGlclRFHTHT74RVa9NQlqsc9Q==
X-Received: by 2002:a63:e34a:: with SMTP id o10mr14362568pgj.258.1592049875852;
        Sat, 13 Jun 2020 05:04:35 -0700 (PDT)
Received: from localhost ([49.207.210.132])
        by smtp.gmail.com with ESMTPSA id k12sm8778184pfk.219.2020.06.13.05.04.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Jun 2020 05:04:35 -0700 (PDT)
Date:   Sat, 13 Jun 2020 17:34:32 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC 1/3] lib: copy_{from,to}_user using gup & kmap_atomic()
Message-ID: <20200613120432.GA5319@afzalpc>
References: <cover.1591885760.git.afzal.mohd.ma@gmail.com>
 <9e1de19f35e2d5e1d115c9ec3b7c3284b4a4e077.1591885760.git.afzal.mohd.ma@gmail.com>
 <CAK8P3a1XUJHC0kG_Qwh4D4AoxTgCL5ggHd=45yNSmzaYWLUWXw@mail.gmail.com>
 <20200612135538.GA13399@afzalpc>
 <CAK8P3a25ffh_2Y1xKDbkL2xU9nLpGbEq7j6xHdODEwUtavgdwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a25ffh_2Y1xKDbkL2xU9nLpGbEq7j6xHdODEwUtavgdwA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 12, 2020 at 10:07:28PM +0200, Arnd Bergmann wrote:

> I think a lot
> of usercopy calls are only for a few bytes, though this is of course
> highly workload dependent and you might only care about the large
> ones.

Observation is that max. pages reaching copy_{from,to}_user() is 2,
observed maximum of n (number of bytes) being 1 page size. i think C
library cuts any size read, write to page size (if it exceeds) &
invokes the system call. Max. pages reaching 2, happens when 'n'
crosses page boundary, this has been observed w/ small size request
as well w/ ones of exact page size (but not page aligned).

Even w/ dd of various size >4K, never is the number of pages required
to be mapped going greater than 2 (even w/ 'dd' 'bs=1M')

i have a worry (don't know whether it is an unnecessary one): even
if we improve performance w/ large copy sizes, it might end up in a
sluggishness w.r.t user experience due to most (hence a high amount)
of user copy calls being few bytes & there the penalty being higher.
And benchmark would not be able to detect anything abnormal since
usercopy are being tested on large sizes.

Quickly comparing boot-time on Beagle Bone White, boot time increases
by only 4%, perhaps this worry is irrelevant, but just thought will
put it across.

> There is also still hope of optimizing small aligned copies like
> 
> set_ttbr0(user_ttbr);
> ldm();
> set_ttbr0(kernel_ttbr);
> stm();

Hmm, more needs to be done to be in a position to test it.

Regards
afzal
