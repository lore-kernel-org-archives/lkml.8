Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0BEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 20:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7829520720
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 20:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591907072;
	bh=MbvvXf5DvA0ndJUObjFNhO/TomgyPoqA4X8iXUUgwdU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tQQyZnT5IYDqWqTSZtlnKH/vTQ/30UqL0O1rLxaM/u/KJzyR7Wz8NedRx7GnKBkDH
	 vvWPc0Nya6Q9FyK8Wh9hneJR7cRiq98R5iTZ5MxPkmFUPp2yOS3WOyqNxDGXeimbtb
	 3k9p18EG0Tw7Hl81qXa+HPl6nvIMv660G12kSrcM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgFKUYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 16:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgFKUYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 16:24:30 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E276C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 13:24:30 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id w15so4222944lfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 13:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SU42uuKkpw7Wg4B+gvlczxL4S03WcT64CjVoCVe2bF4=;
        b=Firmk9LVm6P6e6YLRWTl70bUsXYuvkgK+48h3rcLpqNy4WtC4kTbhTjP5JtZQd1fbK
         3lLIJa9Ql3mSx8Bpne6JovMquWZwDezfotl4yyBmk24lzqAhPR5T9l7ui2c2YXrq7usV
         wPFCe4jLoEqnY/wc+ONVqdKMY8jiYR7l8H0xE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SU42uuKkpw7Wg4B+gvlczxL4S03WcT64CjVoCVe2bF4=;
        b=Q5/q01MLU6SxDPXn9HnVE2lhesVoeypZ4Z3DyNb1ugul/AtEKJmK5Tnt9j+IAZtoDD
         yMLVd582RcPzWNzzRNtpL6DUs8l5bl5hBc7QKbtAQwg6LHG9Equ1FylxzdzPbgmbRS8P
         6L5Btl+sx1f/Tb0ijWpildXsBykFbU9sCpzJ94yZ88Iu0MBuoqnGzoHg2HFEwk2K2slq
         m5cXyxzd2ftEgBn6JQ4LY6QmXEcoZq7bZVlnQmlBwQR6F9NYu6VaGj4YSZljPIHXJLCW
         o+k1/eSNYj2JBiXPJf+qYnKVOiC/dNJuk4HYe5+6HzGNUgi841Fa+YIAyv5hIKdjcbSs
         JGVg==
X-Gm-Message-State: AOAM533XJiwyCVVsdUPUXnI3YZwjVeOq8toLm8v/cydVWDFPUOo7H+H0
        OoIezDKuvjyTHtNMgAEX/ipcTEmCHHI=
X-Google-Smtp-Source: ABdhPJycJAygeU0nCdCfpm5ScLUPVt6T2+22pr4OUPKQzEXKILnEZ666lVhZKGeQysnDVBbpUaaSpQ==
X-Received: by 2002:ac2:5dc8:: with SMTP id x8mr502504lfq.71.1591907067394;
        Thu, 11 Jun 2020 13:24:27 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id o4sm1079565lfb.75.2020.06.11.13.24.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 13:24:26 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id i3so3967940ljg.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 13:24:26 -0700 (PDT)
X-Received: by 2002:a2e:b5d9:: with SMTP id g25mr5502290ljn.285.1591907065781;
 Thu, 11 Jun 2020 13:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200611040453.GK12456@shao2-debian>
In-Reply-To: <20200611040453.GK12456@shao2-debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 11 Jun 2020 13:24:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whCjhBgJv0z6JoOKMyfnBp0WhH6oa=ayuRRLtgJxOkd5Q@mail.gmail.com>
Message-ID: <CAHk-=whCjhBgJv0z6JoOKMyfnBp0WhH6oa=ayuRRLtgJxOkd5Q@mail.gmail.com>
Subject: Re: [gup] 17839856fd: stress-ng.vm-splice.ops_per_sec 2158.6% improvement
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 9:05 PM kernel test robot <rong.a.chen@intel.com> wrote:
>
> FYI, we noticed a 2158.6% improvement of stress-ng.vm-splice.ops_per_sec due to commit:
>
> commit: 17839856fd588f4ab6b789f482ed3ffd7c403e1f ("gup: document and work around "COW can break either way" issue")

Well, that is amusing, and seeing improvements is always nice, but
somehow I think the test is broken.

I can't see why you'd ever see an improvement from that commit, and if
you do see one, not one by a factor of 20x.

> In addition to that, the commit also has significant impact on the following tests:
>
> | testcase: change | stress-ng: stress-ng.vm-splice.ops_per_sec 372.8% improvement        |
> | testcase: change | stress-ng: stress-ng.vm-splice.ops_per_sec 2052.7% improvement       |

Ok, so it's affecting other runs of the same test, and the smaller
("only" 378%) improvement seems to be just from using fewer threads.

So maybe forcing the COW ends up avoiding some very specific cache
thrashing case.

> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml

Is there some place where you'd actually _see_ what
"stress-ng.vm-splice.ops_per_sec" actually means and does?

Yeah, I can go and find the actual stress-ng git repo, and take a
look. I kind of did. But the step from your "to reproduce" to actually
figuring out what is going on is pretty big.

It would be nice to know what it actually does - do you have a
database of descriptions for the different tests and how to run them
individually or anything like that?

IOW, rather than the above "just run all fo the lkp scripts",
something like how to run the actual individual test would be good.

IOW how do those yaml files translate into _actually_ running the
'stress-ng' program?

                Linus
