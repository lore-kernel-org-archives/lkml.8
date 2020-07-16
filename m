Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C173C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 17:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EAAD2070E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 17:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594922114;
	bh=lLJldrxIoCk4M8C+GINWVcU4GYYV6tS/oFagogB61Z8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=T2yOiFA3E4MlMjGZPOraJLrXVJl000BastN5ZRF4K30Rydkkke0iEeYZIs/HhvuIw
	 RJv/AheoDK+TB2ZqFAsRf/OyTqVQ13GNK8aMQ+4thO9YUWqNGyDCErh9vs9F1AxLn+
	 wjCvu+vh6HKEfm7qV6XUlfLnZsxMpwRuucqMWU6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgGPRzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 13:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbgGPRzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 13:55:12 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC5BC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 10:55:12 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u25so4309809lfm.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 10:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xq2JH4o8fhssULM8OxiE+8BVwjY6u3DAco48q1luJAA=;
        b=ObQzTlhrDJzFPiBqNrDCENTQ8eDuKme5lbe0pge63Qy9tUEn0lpb9Ibc70CsMa5rJp
         w8lsRsux3WCKeRWxpK6T76ywqmXf6GOGmCHC3Y9Ch4w0CY3EGTy5ho0T+peufUbLOykN
         oxttWek9XqXN20xjMRBA6JbA31+SDZptabSZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xq2JH4o8fhssULM8OxiE+8BVwjY6u3DAco48q1luJAA=;
        b=Kdi0kXE/zjyvxz7sG/s4rPXIXm+0xeKBogzjVyUodMaUgk4v/ILTVhxg3ZIMy6mplo
         wHP7/fPXaq92pJkmZG1kEiB/FZPYW2hBM/EI8GMKx6+QQuRSRNyCtoBdgpC2nA2JDmvl
         cnrWhip7gX6tKju4XYVarmqLh0A/lNqS7nAOYCGSkXQij4uoxKbRzN53XBbuZu7kzDAY
         VbFBL7wF7ehZt0EqD900iYahfnO7bvlJg7sEx8hCgiKla+3YGz3pJC96fLZbLxhkaA1S
         mz8RpsU4EZMe8Z+X2a+vzecHM2Vzz9kalXoml6BI/CZtiYmsQvtf7aBEIINyWHlzgQkR
         IEfg==
X-Gm-Message-State: AOAM5336TWqnrm7aZrD0F5MgzjRQLR4BPvNM+MK2I4BcPFwe84JYCHTe
        9GyTz7pf3JEbp2HldnZOL0zmfS/tMwY=
X-Google-Smtp-Source: ABdhPJwevqIpaIkLvhtVIuX7Rz4Zynanw1ielf8XiloMHasx1yRbLe4l74qBd5vq4A5+DvQuJ3KA0A==
X-Received: by 2002:a19:ca48:: with SMTP id h8mr2745889lfj.161.1594922110206;
        Thu, 16 Jul 2020 10:55:10 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id l4sm1176259ljc.83.2020.07.16.10.55.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 10:55:08 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id x9so9114754ljc.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 10:55:08 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr2516849ljj.102.1594922108423;
 Thu, 16 Jul 2020 10:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200715135011.42743-1-kirill.shutemov@linux.intel.com>
 <CAHk-=wh4pB-jRngOjcGxpc8=NPds3jWqJwDMUWC3-OEo4dRiKg@mail.gmail.com>
 <20200715205428.GA201569@google.com> <CAHk-=wg-_Oof43pKUHMk4ySdLwpYi7+shFg+aeV18UP2Akiv8g@mail.gmail.com>
 <CAHk-=wg+iVwK7MDXB+BPbhTmP-1eBa-y4vxRNr_G8ETnzv5pZg@mail.gmail.com>
 <20200715222228.jf2pv5u2wyhtc5o5@box> <CAHk-=wgp-ZJ+J250DMaJFBDU2hnhUUqXcUnVnZZ1iFQEK6O-jg@mail.gmail.com>
 <CAHk-=wh3jD4dwXWWFors9OnYp-YCzYN2bCGs9HDxrtZ=TiFyDQ@mail.gmail.com>
 <CAHk-=wjw2yuQjP1rqB=ocr9W3=ak+6h4XygoFTAgM5meiM1Q0A@mail.gmail.com> <20200716131612.b7ottczdgnxwdvrp@box>
In-Reply-To: <20200716131612.b7ottczdgnxwdvrp@box>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Jul 2020 10:54:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1PKGsk-Nr_Jd1vHGqg5AjTUtJkeh9R-a9SN-H=i2-1A@mail.gmail.com>
Message-ID: <CAHk-=wi1PKGsk-Nr_Jd1vHGqg5AjTUtJkeh9R-a9SN-H=i2-1A@mail.gmail.com>
Subject: Re: [PATCHv2] mm: Fix warning in move_normal_pmd()
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
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

On Thu, Jul 16, 2020 at 6:16 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> It can also lead to performance regression: for small mremap() if only one
> side of the range got aligned and there's no PMD_SIZE range to move,
> kernel will still iterate over PTEs, but it would need to handle more
> pte_none()s than without the patch.

Ack, I've dropped the patch from my queue of experiments, because it
doesn't work for the case I wanted to do, and the other cases could
regress, as you say.

Plus considering how many problems that patch had, I decided it wasn't
as simple as I initially thought it would be anyway ;)

Joel - while it's gone from my mind, if you're still interested in
this, maybe you can do something _similar_ that patch, except perhaps
also start out checking that the initial size is large enough for this
to make sense even when one of the sides doesn't align, for example.

(It might be as simple as checking that the initial 'len' is at least
PMD_SIZE - then you're guaranteed that whichever side gets aligned,
it's not doing extra work because the other side didn't).

               Linus
