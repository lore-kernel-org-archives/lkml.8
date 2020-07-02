Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE854C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB9C1207D4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uaN2/f9u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgGBP6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgGBP6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:58:18 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4288AC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 08:58:18 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id m26so16529944lfo.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 08:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X1RTSp5CrRapQnypmSWSxe/qopyJZ+immsPrPXeTLek=;
        b=uaN2/f9uUUo5KuYlYHl1tl6tsXQDBysYqwwMd4Z9/ExaKKI7wGKeANxWlxbwKw5FR3
         E9RqrzIQwGWMIkWZXq+wQ3h54Xk41S+ikq3JT6/jhx204AmO6EutELdpxZ05SEnVzWTa
         cvUcmMAyQ0RHzpyBVCkyd0GwbGiym+be7CwCY+pXJ1T/vqHrJK/HTm3j+GmV2p8qQcXA
         CFc0rdWvqKMFvNV68ETdp1vQ7BvZhenuNYuP46oOK5dTOHtBBBOeJTsAh0yQQUh3wuZ0
         qQ+ZWZPmu7gtAFLVWzcQrOCFUzZLiqo0OWPw5nSnshjAFxcJcYELgzykcRy4sh5tCdrF
         Nt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1RTSp5CrRapQnypmSWSxe/qopyJZ+immsPrPXeTLek=;
        b=NrfxcH9RyXfYrovZFU8/Ezfh2cNNfBA1Qz8JB2aSS8wWoOrmo0qhZzeH6AJvxUVaZ3
         61z3O1Ggv8xe1TceyalQk8AVbi9iHsmR7Yn6vdPcNFHZuwqMJYgcIS2MS8G8C+ggcBvi
         RbpXM/ZAMKR9X50NkbqSx2ldqBfHaHqEQSS411QXJhgDHs1xIUd0qAafo3nG5oI+qVPf
         4VzSaJCksaRFMq+UVSLgqgO74ZvI4Kx3U5/XNAZuTssowY40KlBf4DLyI2CIRia/V6s0
         eR+sIN0T9YP7INr2nCB9mk6uYj04vJrcpz0zs7E7zmKzGhhSsBfjci++pcCxYsFquFvO
         lz6Q==
X-Gm-Message-State: AOAM530mrEkhWgX82/awoa7eVB7TmWUwOtqQpyMAR06hpVE1qff7Ivuk
        4GZYbfig4Y2F5joQ6lpxB+eDjbHn1KGX+QnGDz9P2A==
X-Google-Smtp-Source: ABdhPJxW9QCybVBEiIBzLHYaoVi83qJhwdUiujZa1suq4MYmE6SR6DDHtMcqZ7sV8yDrxcI39R9rkQED5X1gELJzwEc=
X-Received: by 2002:a19:4285:: with SMTP id p127mr17850250lfa.74.1593705496697;
 Thu, 02 Jul 2020 08:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtrgF_EZHi0vi+HyWiXT5LGggDhVXtNspc=OzzFhL=xRQ@mail.gmail.com>
 <20200701081951.GL2369@dhcp22.suse.cz>
In-Reply-To: <20200701081951.GL2369@dhcp22.suse.cz>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 2 Jul 2020 21:28:05 +0530
Message-ID: <CA+G9fYsTRmtD=wUwS1X6wrUcVKEfvcLfmAc3uUJGVcx-Oqyykw@mail.gmail.com>
Subject: Re: PANIC: mm: memcg/slab: percpu_ref_put_many - Unable to handle
 kernel paging request at virtual address ffff80096d78f000
To:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        linux-mm <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        open list <linux-kernel@vger.kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jul 2020 at 13:49, Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 01-07-20 13:24:54, Naresh Kamboju wrote:
> > While running LTP mm test suite on arm64 Juno device the kernel panic
> > noticed on linux-next 20200630 tag.
>
> Can you try to bisect? The new memcg slab allocator series sounds like a
> potential candidate. One of the patches has changed the memcg reference
> counting which is showing up on the stack. This might be a side effect
> of something else of course but bisection would tell us more.

The reported problem is fixed by a patch proposed in this email thread.
https://lore.kernel.org/linux-mm/20200701184552.GA61684@carbon.DHCP.thefacebook.com/

- Naresh

>
> Thanks
>
> --
> Michal Hocko
> SUSE Labs
