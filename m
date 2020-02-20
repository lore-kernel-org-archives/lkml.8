Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED40C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5A524681
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t/iabB7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgBTSqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:46:13 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37694 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgBTSqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 13:46:12 -0500
Received: by mail-ed1-f65.google.com with SMTP id t7so23310186edr.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 10:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3pzTOf6vYrNpBzwrv5P8vGUEMGl4yTghrNTGfR5M7Oc=;
        b=t/iabB7zJkaoluyOjIOJfc2zOAmtCMc0F/y/TF2fj7jW83AkZqMCidXI1cWAbd1seh
         NrPIkCTa7wgPP3M5+5W4Nd8wCviO86LJDU/66mUTKdZUNRZSGcNC+WNlPLabRaKp4SR+
         orsRRi/sfSaMIAGI3SoDi7MDtWF06zukVhMxyMS8/yfYakd+jGja2CyT12U5oXkmI8sN
         z5jMtx62wuJh4j4W5bIO2P70wW6bBQ278/BBWp++v1TyluKJlkdg9fCLT1VNOntUyF2q
         Dp4wBg6EPgY/049JRWKGl3hU5FeH12hRn285BsTec8q28s4O1DhJH6apj0UVzQYbrXgZ
         AeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3pzTOf6vYrNpBzwrv5P8vGUEMGl4yTghrNTGfR5M7Oc=;
        b=Yc3zVj9adW96Bg4Qr0s202qSM2F376FODoPQ4on7EawK6yY28XUOurYM9f8XTywMdp
         bGoYEHt1RCqF+yp98IYIlHuKQG/Jt0swZJBvlnqVG9x4iD8ofTaybCpgqSV8hDjllB1R
         KatsyYqiCRYwlatQ/m/2wv+wFsvYnu0R/5ipbchRJ6pEkg8AIxoikZ1HAZBN2jEXBogX
         lFsaz0ZMPFUy+6A5mRUakwVnzf+rcqqSgMa+JBA1ZTzWNIvVuULvxGZEKw08Tpct740f
         t6hEcP0Iumqjchy6EolOqduWuNkS/RoqZzXewsY2dwrfWwK4C9tCP4EMClF5F4VwSytV
         tkYQ==
X-Gm-Message-State: APjAAAW008hs5bTJJ7Z++gH4JCttcn+3Wke+UcCnWAEQwkJjEDdUU0Nq
        w4lRcJE44bR7DD0f78LUT9ADWt2Bh5XvjaaLS/tmcA==
X-Google-Smtp-Source: APXvYqxLLjMlzm9n1gTBdsGBP2Dd4mIMoNz+RxUJ/scsjYrcKm8cv5eKltlsAg/aIqFp91+eAChxVZYEb3UQBPTKYf4=
X-Received: by 2002:a17:906:1e48:: with SMTP id i8mr28875694ejj.189.1582224370598;
 Thu, 20 Feb 2020 10:46:10 -0800 (PST)
MIME-Version: 1.0
References: <20200218173221.237674-1-bgeffon@google.com> <20200220171554.GA44866@google.com>
 <CADyq12zUEq9kcyuR_Qm9MrU1ii-+9n8T2hK6QNzj=kH5zn0VrA@mail.gmail.com>
In-Reply-To: <CADyq12zUEq9kcyuR_Qm9MrU1ii-+9n8T2hK6QNzj=kH5zn0VrA@mail.gmail.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Thu, 20 Feb 2020 10:45:44 -0800
Message-ID: <CADyq12xz-g1geCBE5ie+Uffvp1YAgdsVq1yjQGydu=AZH-FxGA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] mm: Add MREMAP_DONTUNMAP to mremap().
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry I should clarify that this is the behavior with MREMAP_FIXED is
used, and to expand on that, it would potentially even have unmapped
the region at the destination address and then fail in vma_to_resize
too, so I hope that explains why that check landed there. But should
these situations be considered a bug?

Brian

On Thu, Feb 20, 2020 at 10:36 AM Brian Geffon <bgeffon@google.com> wrote:
>
> Hi Minchan,
>
> > And here we got error if the addr is in non-anonymous-private vma so the
> > syscall will fail but old vma is gone? I guess it's not your intention?
>
> This is exactly what happens today in several situations, because
> vma_to_resize is called unconditionally. For example if the old vma
> has VM_HUGETLB and old_len < new_len it would have unmapped a portion
> and then in vma_to_resize returned -EINVAL, similarly when old_len = 0
> with a non-sharable mapping it will have called do_munmap only to fail
> in vma_to_resize, if the vma has VM_DONTEXPAND set and you shrink the
> size with old_len < new_len it would return -EFAULT after having done
> the unmap on the decreased portion. So I followed the pattern to keep
> the change simple and maintain consistency with existing behavior.
>
> But with that being said, Kirill made the point that resizing a VMA
> while also using MREMAP_DONTUNMAP doesn't have any clear use case and
> I agree with that, I'm unable to think of a situation where you'd want
> to resize a VMA and use MREMAP_DONTUNMAP. So I'm tempted to mail a new
> version which returns -EINVAL if old_len != new_len that would resolve
> this concern here as nothing would be unmapped ever at the old
> position add it would clean up the change to very few lines of code.
>
> What do you think?
>
> Thank you for taking the time to review.
>
> Brian
