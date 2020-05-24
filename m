Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDC7C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 23:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD8B52076C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 23:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388235AbgEXXpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 19:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388039AbgEXXpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 19:45:44 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355BDC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 16:45:44 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jd0JD-00EuEH-AT; Sun, 24 May 2020 23:45:35 +0000
Date:   Mon, 25 May 2020 00:45:35 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Alexander Potapenko <glider@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, sunhaoyl@outlook.com,
        x86@kernel.org
Subject: Re: [PATCH] fs/binfmt_elf.c: allocate initialized memory in
 fill_thread_core_info()
Message-ID: <20200524234535.GA23230@ZenIV.linux.org.uk>
References: <20200419100848.63472-1-glider@google.com>
 <20200420153352.6682533e794f591dae7aafbc@linux-foundation.org>
 <202004201540.01C8F82B@keescook>
 <20200421034249.GB23230@ZenIV.linux.org.uk>
 <CAG_fn=VZZ7yUxtOGzuTLkr7wmfXWtKK9BHHYawj=rt9XWnCYvg@mail.gmail.com>
 <20200512010901.GQ23230@ZenIV.linux.org.uk>
 <20200512034400.GA1537486@ZenIV.linux.org.uk>
 <CAG_fn=Xopqwu8qpdH2xDHmGSy1utp7uyPn7s6btm0hdaV7JVRg@mail.gmail.com>
 <20200513033349.GR23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513033349.GR23230@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 04:33:49AM +0100, Al Viro wrote:

> FWIW, what I'm going to do is
> 	* make all callers of copy_regset_to_user() pass 0 as pos
> (there are very few exceptions - one on arm64, three on sparc32
> and five on sparc64; I hadn't dealt with arm64 one yet, but all
> cases on sparc are handled)

[snip]

Any of that would be easy to backport, though.  Several questions
regaring XSAVE and friends:

* do we ever run on XSAVE/XSAVES-capable hardware with XFEATURE_FP
turned off?

* is it possible for x86 to have gaps between the state components
area as reported by CPUID 0x0d?  IOW, can area for feature 2
(XFEATURE_YMM) to start *not* at 0x200 and can area for N start
not right after the end of area for N-1 for some N > 2?

I think I have an easy-to-backport solution, but I'm really confused
about XFEATURE_FP situation...
