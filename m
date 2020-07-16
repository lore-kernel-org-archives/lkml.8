Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC12C433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 18:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96522207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 18:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="q5Zcz/RP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbgGPSrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 14:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbgGPSrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 14:47:47 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC185C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 11:47:47 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q74so7158867iod.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 11:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JE7Pen46inwZxO9tkaTJDy3WUDLZxNVQfxoIMcr/BoM=;
        b=q5Zcz/RPeQzCQ7zvA09TOSlqV6ksWSUtVb781iASamVNpGleTcjxA/JExhU+rexFaK
         hApORWXALbZ9CxyXvvHFTeNcOjxzkfe7d2tGfr0j4shRPSbk+ommynMq1fsA+9gtRuuD
         SghO4Ch7ivHSta+51v4KvYEJsVg37tVVpTT1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JE7Pen46inwZxO9tkaTJDy3WUDLZxNVQfxoIMcr/BoM=;
        b=mq1WCSkIGRzo1kltM+S5rqBuHl3h0xSHkcA2WNODD2tEjt5Um3pizgahMmdV1812So
         IhR2eQQG89ZkyKYOd34+96kqvqhz+gz53ZmvYUDnQ2ijDlsVw7M0MSEresOmxMD6n27a
         lSbz1aqxnUPYAxvEDJ2MG5KIlKCDF6ZM5MY8rzkqVYI82bAoYV4EC579LC15AFxVqC1H
         jQKrO8AFmuC4UQlSMu5N5mPEdG1ED3CTcOQCX2VMeJP4hYI7ETc9jxty15olmaR+fJbl
         3stFnfpWQHrGTzrXob5FTb5V6mORoo41wuBmhGUYsli3rIBJRkEdbup5FsazdWHizEwq
         LQFg==
X-Gm-Message-State: AOAM531xPBTUZJVSRLCBd4LQLxePfKqrXN7Zv+KSHONvlyYnIozZqjje
        4nVpfaqmBohT3hfPMsH2cOodtcQV5dOaf5QVqzf/Qg==
X-Google-Smtp-Source: ABdhPJwajtXehTH2xCamwP/Z0zea0M1DJ8xsJRZ40e52TLDCiQieV6T9sHH/g0K/InHRuIK3CfDMNY9XQQMriZOOz6o=
X-Received: by 2002:a05:6638:1450:: with SMTP id l16mr6872872jad.74.1594925267035;
 Thu, 16 Jul 2020 11:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200715135011.42743-1-kirill.shutemov@linux.intel.com>
 <CAHk-=wh4pB-jRngOjcGxpc8=NPds3jWqJwDMUWC3-OEo4dRiKg@mail.gmail.com>
 <20200715205428.GA201569@google.com> <CAHk-=wg-_Oof43pKUHMk4ySdLwpYi7+shFg+aeV18UP2Akiv8g@mail.gmail.com>
 <CAHk-=wg+iVwK7MDXB+BPbhTmP-1eBa-y4vxRNr_G8ETnzv5pZg@mail.gmail.com>
 <20200715222228.jf2pv5u2wyhtc5o5@box> <CAHk-=wgp-ZJ+J250DMaJFBDU2hnhUUqXcUnVnZZ1iFQEK6O-jg@mail.gmail.com>
 <CAHk-=wh3jD4dwXWWFors9OnYp-YCzYN2bCGs9HDxrtZ=TiFyDQ@mail.gmail.com>
 <CAHk-=wjw2yuQjP1rqB=ocr9W3=ak+6h4XygoFTAgM5meiM1Q0A@mail.gmail.com>
 <20200716131612.b7ottczdgnxwdvrp@box> <CAHk-=wi1PKGsk-Nr_Jd1vHGqg5AjTUtJkeh9R-a9SN-H=i2-1A@mail.gmail.com>
In-Reply-To: <CAHk-=wi1PKGsk-Nr_Jd1vHGqg5AjTUtJkeh9R-a9SN-H=i2-1A@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 16 Jul 2020 14:47:35 -0400
Message-ID: <CAEXW_YRWDwUVrvedLtoMssFcrwAnWHAQ0CWNbR4UF=GS18B3wA@mail.gmail.com>
Subject: Re: [PATCHv2] mm: Fix warning in move_normal_pmd()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        William Kucharski <william.kucharski@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 1:55 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Jul 16, 2020 at 6:16 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > It can also lead to performance regression: for small mremap() if only one
> > side of the range got aligned and there's no PMD_SIZE range to move,
> > kernel will still iterate over PTEs, but it would need to handle more
> > pte_none()s than without the patch.
>
> Ack, I've dropped the patch from my queue of experiments, because it
> doesn't work for the case I wanted to do, and the other cases could
> regress, as you say.
>
> Plus considering how many problems that patch had, I decided it wasn't
> as simple as I initially thought it would be anyway ;)
>
> Joel - while it's gone from my mind, if you're still interested in
> this, maybe you can do something _similar_ that patch, except perhaps
> also start out checking that the initial size is large enough for this
> to make sense even when one of the sides doesn't align, for example.
>
> (It might be as simple as checking that the initial 'len' is at least
> PMD_SIZE - then you're guaranteed that whichever side gets aligned,
> it's not doing extra work because the other side didn't).

Hi Linus,
Yes I'm quite interested in doing a similar patch and also adding some
test cases to make sure it always works properly. Probably I can add
some kselftest cases doing mremap on various ranges.

I think it will be a great optimization to trigger the PMD move more
often. I'll work on it and get back hopefully soon on this, Thanks!

 - Joel
