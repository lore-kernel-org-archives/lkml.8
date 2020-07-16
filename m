Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69F3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABF162065F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="TTVQzQQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgGPPxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728894AbgGPPxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:53:42 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D92C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 08:53:42 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a21so7067782ejj.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 08:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8WXG2PIfyvvmPCMZWK/gVmBE6W6BlBqBnmsVmBGJnAE=;
        b=TTVQzQQ8ViT26pmUNnI4AiNVW2VzNBVbcYWM3Gl8mx7rT/pIssKnqsignxE0w8FuXi
         3eYXIYONhvl9O6WN+MFAA1B5qMhqm6imyFymvH5wjKTSVktzWmzxkQJTh3fH6AFIWsGU
         5nUncZclPPs0cTOIBXHbRadP5rWrTInxmdohCU6TZNwEJ6/COZsIjEV3HNQXbC0R86XM
         bGDSspfH/2WT3M7Rj4sGmYXfU7wzz3uKyM7DsC5iNURYzvxWpIXNMQtWQZEc4zGy2CfH
         msueYSKFjXIQBwzUnweSezPrtfjSXzLbN8fiImPnjktGXVBRrPy4jup5lOuplPJOgG0F
         DMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8WXG2PIfyvvmPCMZWK/gVmBE6W6BlBqBnmsVmBGJnAE=;
        b=iiBWJhA7G8H3zVZaJn6sTnRLZL8bflUETgkZq+ZjRg7RXN0SB2Uvuakic7PfjZYohl
         Elp7ND5gt7YRSjJ6qVsjX8f0m84xlpp79RyijQzR6we3R/aFuBuPL/1N5rIPER77J0pf
         c2LsEwYKHtKM1f7CQI7Ndvn8zJmxknCVsYrVyjhznlKF8oUprVWSu1Rlz1ftF0KzWn9r
         bvPtKJ2bGcTxGNEcY99v/bjKU7GO85P5OdZtbhFTj9OlACdVWobAQLqE1SPtB+pwVAXg
         e1V3QtZ2kTNEY7jAGo6LXOzlzJKSOq/aadCquTJNjY2ASX7cp486VIf+jwrFubHbltLJ
         WifQ==
X-Gm-Message-State: AOAM530ISLQzNL9VzzJkKRvw20WT5l5HmI/fanmtWvJmPdQDG1Q3Z6Q9
        oCtR2BFlbP2yXZdRDSC4RigjJ9yNBv5+hP4kGy1gnQ==
X-Google-Smtp-Source: ABdhPJyC/kYBgU3IOAczrEfawy9HqiaBTF+01y7Bb6pDO746HsQJM5cE84Bpja/aFZhr/N9Gx94sJ9OFb9TOk4ri9JA=
X-Received: by 2002:a17:906:6d56:: with SMTP id a22mr4555135ejt.440.1594914821045;
 Thu, 16 Jul 2020 08:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200716060553.24618-1-ebiggers@kernel.org>
In-Reply-To: <20200716060553.24618-1-ebiggers@kernel.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 16 Jul 2020 08:53:30 -0700
Message-ID: <CAPcyv4g94hK7j7hknSmtt11hgq+5N-Yf-fwLdS4VrARyqKwJLw@mail.gmail.com>
Subject: Re: [PATCH] /dev/mem: Add missing memory barriers for devmem_inode
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Russell King <linux@arm.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 11:07 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> WRITE_ONCE() isn't the correct way to publish a pointer to a data
> structure, since it doesn't include a write memory barrier.  Therefore
> other tasks may see that the pointer has been set but not see that the
> pointed-to memory has finished being initialized yet.  Instead a
> primitive with "release" semantics is needed.
>
> Use smp_store_release() for this.
>
> The use of READ_ONCE() on the read side is still potentially correct if
> there's no control dependency, i.e. if all memory being "published" is
> transitively reachable via the pointer itself.  But this pairing is
> somewhat confusing and error-prone.  So just upgrade the read side to
> smp_load_acquire() so that it clearly pairs with smp_store_release().
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Fixes: 3234ac664a87 ("/dev/mem: Revoke mappings when a driver claims the region")
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Makes sense:

Acked-by: Dan Williams <dan.j.williams@intel.com>
