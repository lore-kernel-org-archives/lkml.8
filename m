Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD58AC35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD90F21775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QUs2WGWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgBFT3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:29:19 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37606 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgBFT3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 14:29:18 -0500
Received: by mail-oi1-f193.google.com with SMTP id q84so5805963oic.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 11:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tcB2zArJfdWlSRiKMp1mRpBElv371E5kpDFKOpb7uOc=;
        b=QUs2WGWIBcgWpxLJxUTlfgR+XHfKQU7AzLgtV7p3BcQjryYCPdEhYUEoEAcqUhoDtH
         BZ8imRgJEqcRxyr/JjmTfQMIX7k+0dT2IUnZA4T0Dchi2Otqw/LSoHOYzlv7Mqk/4Ewv
         n57rU51HPLpRWqMU82HBkqj7A5gFroJxoHDFJoqJSYMKltE7FGiJIbzU42EJNcOxfGA5
         Zl87hCDzBSrYKIejSgeYtAKtBHJs2sfw4hdJ5Kpzi2+UIUBjSF51Tw7xd6NasmEDv0Co
         oM6V/L5d85c4PaywIzx1o9W3zHfZB7PtDdJZSXx4es8NLbNtviw+xATSezr2VjmaITso
         FsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tcB2zArJfdWlSRiKMp1mRpBElv371E5kpDFKOpb7uOc=;
        b=gvZ6m65pK18GdwlokQI059DPIC5csbIp05moB0+sLnFY8ijcAbEZ8c0V3JmgHj5C9T
         Wo0HANnOItKRV52bc3cTVo999Cn3yiw5Ht1K4jWJ530CvaAv6Q9UsgIJPfyq0fE8t7Dv
         CJ9bhHVSTp/iDN6iAXHIlL+QOIfL7MEL73CsDk9UtKuKodi0yB4Hdu3ldJtUM0dRwlJL
         4KW+xXKxKwFP18HhmiVvF2Ty61lUlCPBWy+qwo1gHERzRQIZpEmIp5cg7Q+ddghzbg7Q
         BL3v+iIA6HX+8tIogerqIaTAJxCsslnIjaeSFRBeJvkrQEhM1iCdzSpm8gUXFzvJIeWW
         qE8w==
X-Gm-Message-State: APjAAAVHGHaZJ6bA9VF1HbGL7AtbVx1+F97wUM1pfgMU8pmAS2hu+Bav
        KKJcnvdUBE5bweRvO8D4na7TYm9f6Ph63yG+1eYK0Q==
X-Google-Smtp-Source: APXvYqzxY3H9VHQKLy6SJmotxutYI23y4WupdYn0HSY2/MEQpO0LDJtyyatl8tdeEgj/cxrHEmgx/t4ORU/ia4trtmY=
X-Received: by 2002:aca:c7ca:: with SMTP id x193mr8059395oif.70.1581017357296;
 Thu, 06 Feb 2020 11:29:17 -0800 (PST)
MIME-Version: 1.0
References: <1580841629-7102-1-git-send-email-cai@lca.pw> <20200206163844.GA432041@zx2c4.com>
 <453212cf-8987-9f05-ceae-42a4fc3b0876@gmail.com> <CAHmME9pGhQoY8MjR8uvEZpF66Y_DvReAjKBx8L4SRiqbL_9itw@mail.gmail.com>
 <495f79f5-ae27-478a-2a1d-6d3fba2d4334@gmail.com> <20200206184340.GA494766@zx2c4.com>
In-Reply-To: <20200206184340.GA494766@zx2c4.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 6 Feb 2020 20:29:06 +0100
Message-ID: <CANpmjNN9xsxuPo4oc4CwDDbQS3bWBn0c_m++pLo61EOap=UOow@mail.gmail.com>
Subject: Re: [PATCH v3] skbuff: fix a data race in skb_queue_len()
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>, Qian Cai <cai@lca.pw>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Feb 2020 at 19:43, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Thu, Feb 06, 2020 at 10:22:02AM -0800, Eric Dumazet wrote:
> > On 2/6/20 10:12 AM, Jason A. Donenfeld wrote:
> > > On Thu, Feb 6, 2020 at 6:10 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
> > >> Unfortunately we do not have ADD_ONCE() or something like that.
> > >
> > > I guess normally this is called "atomic_add", unless you're thinking
> > > instead about something like this, which generates the same
> > > inefficient code as WRITE_ONCE:
> > >
> > > #define ADD_ONCE(d, s) *(volatile typeof(d) *)&(d) += (s)
> > >
> >
> > Dmitry Vyukov had a nice suggestion few months back how to implement this.
> >
> > https://lkml.org/lkml/2019/10/5/6
>
> That trick appears to work well in clang but not gcc:
>
> #define ADD_ONCE(d, i) ({ \
>        typeof(d) *__p = &(d); \
>        __atomic_store_n(__p, (i) + __atomic_load_n(__p, __ATOMIC_RELAXED), __ATOMIC_RELAXED); \
> })
>
> gcc 9.2 gives:
>
>   0:   8b 47 10                mov    0x10(%rdi),%eax
>   3:   83 e8 01                sub    $0x1,%eax
>   6:   89 47 10                mov    %eax,0x10(%rdi)
>
> clang 9.0.1 gives:
>
>    0:   81 47 10 ff ff ff ff    addl   $0xffffffff,0x10(%rdi)
>
> But actually, clang does equally as well with:
>
> #define ADD_ONCE(d, i) *(volatile typeof(d) *)&(d) += (i)

I feel that ADD_ONCE conveys that it adds actually once (atomically),
that is, if there are concurrent ADD_ONCE, all of them will succeed.
This is not the case with the above variants and the 'ONCE' can turn
into a 'MAYBE', and since we probably want to avoid making this more
expensive on e.g. x86 that would need a LOCK-prefix.

In the case here, what we actually want is something that safely
increments/decrements if there are only concurrent readers (concurrent
writers disallowed). So 'add_exclusive(var, val)' (all-caps or not)
might be more appropriate. [As an aside, recent changes to KCSAN would
also allow us to assert for something like 'add_exclusive()' that
there are in fact no other writers but only concurrent readers, even
if all accesses are marked.]

If the single-writer constraint isn't wanted, but should still not be
atomic, maybe 'add_lossy()'?

Thanks,
-- Marco


> And testing further back, it generates the same code with your original
> WRITE_ONCE.
>
> If clang's optimization here is technically correct, maybe we should go
> talk to the gcc people about catching this case?
