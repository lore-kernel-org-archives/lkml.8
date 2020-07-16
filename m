Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821B6C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60C812064C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eTIG4nqj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgGPIcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 04:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgGPIck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:32:40 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F19FC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 01:32:40 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f5so6153160ljj.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 01:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m13HjL6iO3fK1NRmtO6Jr3kBjditGEqJt09JegOvvrY=;
        b=eTIG4nqjVsO98qZmSOJ+yhdJ/V1wFHISz7DLn80VfOS8MexHv+PCzNha9wKPfA7XOu
         ePGZslMvvoXZMP1dwsQE8w0hhlpslJvAr3QNzp9NfK98aQ8m88Jpct2O0JcUgBoMKq7o
         7pvTQeBYcGGJxc5COhhLO2VycQDmEs5dOoo+WSkKkd7UBs2zKfvkAFt8dindvYQYk102
         p1W1pgjR193Pv1CDR4UTrxZgsEsfacQOReBPKlICptYiIE5wOosr0GkMNSNpdZnFMlsp
         o9mlfS7lOJAtChtXV6umK3LdRMAyxK+eoikfGTEgJbpU3u1B+W7UuNAZZX2C8FFIAIBI
         tPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m13HjL6iO3fK1NRmtO6Jr3kBjditGEqJt09JegOvvrY=;
        b=fXrE9pu5F1N1wc3J0lWSSAWg4BmAmTx/j7bMk5ZJ5WkzKrVwHJJVLt9EKPNr3nogz+
         Yy6uW+4WX9NI1fb5RIkHHzouRbje4f48Thk6fwn9ODyRTQWBQzI+Tn3SpWQrhIjObPhc
         yxPTwmkv/XhJxfZenVQj5ur6pNjwU1kLbKyA0Car4hY+0joBrc9mi/4bBpxmhTBsuGao
         gSnopxxxRTCafa2sWzc4R98eqLBYi74UiuK6aB4v6vsoYqJz+cE4Ac6283dbI4m6rLs3
         S7FOV+UFUNOB24HogX6VOcAuvQTKybHHiDmr9SAFAEmRUaDZPLzQm91PG4C24+MU6vdG
         5F2A==
X-Gm-Message-State: AOAM532q65NeSm3wwSDAeRvjS/mnnfEsslgljbXhOdPtnrSXm1WeDUzG
        heyOzN2xjtIkyqwISTiaiAO2EMgd4uNhgOz+xsxFkw==
X-Google-Smtp-Source: ABdhPJzTpySGYJra+BXvTq6iSyad4XDiq+DupsOPlgYKnrXUooOYd6+ozHss6nzbKgV0pRvRbwKXGlxdocZbciGAZg0=
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr1408833ljj.102.1594888358789;
 Thu, 16 Jul 2020 01:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200715135011.42743-1-kirill.shutemov@linux.intel.com>
 <CAHk-=wh4pB-jRngOjcGxpc8=NPds3jWqJwDMUWC3-OEo4dRiKg@mail.gmail.com>
 <20200715205428.GA201569@google.com> <CAHk-=wg-_Oof43pKUHMk4ySdLwpYi7+shFg+aeV18UP2Akiv8g@mail.gmail.com>
 <CAHk-=wg+iVwK7MDXB+BPbhTmP-1eBa-y4vxRNr_G8ETnzv5pZg@mail.gmail.com>
 <20200715222228.jf2pv5u2wyhtc5o5@box> <CAHk-=wgp-ZJ+J250DMaJFBDU2hnhUUqXcUnVnZZ1iFQEK6O-jg@mail.gmail.com>
 <CAHk-=wh3jD4dwXWWFors9OnYp-YCzYN2bCGs9HDxrtZ=TiFyDQ@mail.gmail.com> <CAHk-=wjw2yuQjP1rqB=ocr9W3=ak+6h4XygoFTAgM5meiM1Q0A@mail.gmail.com>
In-Reply-To: <CAHk-=wjw2yuQjP1rqB=ocr9W3=ak+6h4XygoFTAgM5meiM1Q0A@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 16 Jul 2020 14:02:27 +0530
Message-ID: <CA+G9fYuQ2Jm6TAF_jiQQdCxDhEkCLs+EjT_KDzmYjSfz8p7+Gg@mail.gmail.com>
Subject: Re: [PATCHv2] mm: Fix warning in move_normal_pmd()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        William Kucharski <william.kucharski@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jul 2020 at 04:49, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Jul 15, 2020 at 4:04 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > It *might* be as simple as this incremental thing on top
>
> No, it needs to be
>
> +       if (*old_addr + *len < old->vm_end)
> +               return;
>
> in try_to_align_end(), of course.

I have modified the patch with the above change.
Sorry the proposed patch [1] did not solve the reported problem.

Link to warning on i386,
https://lkft.validation.linaro.org/scheduler/job/1574295#L2055

Link to the patch which applied on top of Linus master and tested.
[1] https://pastebin.com/2gTxi3pj

I am happy to test the next version patch.

- Naresh
