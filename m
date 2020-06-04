Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D813C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23C8B20738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j/CCKyyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgFDIie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgFDIid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:38:33 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FBAC05BD1E
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 01:38:33 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id j202so1311447ybg.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 01:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=552FTsyBPmP0dIys2XvU7DaT4X8pVqCWxWc8Zz4SjJ8=;
        b=j/CCKyyi12hJt4X4YJ5jPUjnYgUqmF75Nt4hRNt6YKnV/taKrFZImPQ5T8ws5DSVXR
         xCPRqMYM7HINlDNEpVvc28tTSzUW+2Y7YE1prSQ/hE56w0dtP3r9imiZXen55WykmhKd
         8pCJBy/O90/8I5D6Ifw0fLvfwSZTfwSXdqOJEDr6p7BpXasbsv7g29Bg23XhD78DCXK2
         CRKAdkluo80uS7NhDRhrRGZdF99zAYbaI1OflgYRIlshnUCI6qy4xMuIZn0zAQp9t1lw
         FpjMMYIHGMwKolJfnmgzASHcdjPBNrk60LyHTUrQJ+ROAdGJF53opWizVK8QKz1iDbmF
         JlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=552FTsyBPmP0dIys2XvU7DaT4X8pVqCWxWc8Zz4SjJ8=;
        b=tZ2esO3cUTjrlxF8pvRkw/d4IGXIplgb59KTqFFLqMADKYzUJqEcwqeocHxLG50e+M
         1JbpxOOQr+z7vy2ra6LbSK1r0phuc2VAqJ+SwfYvuGZhNyzs9k02bTJpp+oaMQ3bb1uD
         ytboiTCR2EvTqYd3wsxFOlKcsd8Bs4rax6SuFz/0BrR9DQOUWoPupiEd53Qmmpy9ZrKn
         v075a/tLOa2WQMCIM2hHeGsh+rPcA8i0Ln2sNyPt4iTvxfMZH5ZPwTBS7+nO+m4maQaQ
         gF9S2x75VmQ0R8Gd7XTPZRGzp7CgsvnxdgqC1kneS3ErpxLTUpgbtoyiMobAIF9TsM8C
         vIvw==
X-Gm-Message-State: AOAM532rYMp415OW58g6ojnLwZX+KmXFXFTwHh0Fqc0fGXiERoM1ckoj
        c3mE5E36KDoxUbnVLS4RH9UZ0hZ6Q8SZ082Afn4JjQ==
X-Google-Smtp-Source: ABdhPJzcrcXUi2Ku7FkWmVcLSZg8uMvygPWDYZKbc+j99+tLrqn4nTF+cuVE1ZzCTbDTRUp80rvyLFJMRMCOpZXDqZ4=
X-Received: by 2002:a25:ef07:: with SMTP id g7mr6125577ybd.516.1591259912263;
 Thu, 04 Jun 2020 01:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAOzgRdZQjuDfA1wa9AGYjRa-mNWbTNQNCOS60eHzDLeW9WCXpg@mail.gmail.com>
 <CANN689Gy2aUgF7oE2UE3miHf7fah=9zM3KZ512Mj6kJTiRz3Xg@mail.gmail.com> <CAOzgRdZejnB+ruxhZhKBBw9rgnfNbiLSensa-2+20FTkSxrwwA@mail.gmail.com>
In-Reply-To: <CAOzgRdZejnB+ruxhZhKBBw9rgnfNbiLSensa-2+20FTkSxrwwA@mail.gmail.com>
From:   Michel Lespinasse <walken@google.com>
Date:   Thu, 4 Jun 2020 01:38:18 -0700
Message-ID: <CANN689GvTF75Knsc82PGrwA44J+yx2ORP-i3fp36avMuxRPwdg@mail.gmail.com>
Subject: Re: [PATCH v6 10/12] mmap locking API: rename mmap_sem to mmap_lock
To:     youling 257 <youling257@gmail.com>
Cc:     "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Ying Han <yinghan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 4, 2020 at 1:16 AM youling 257 <youling257@gmail.com> wrote:
> 2020-06-04 13:57 GMT+08:00, Michel Lespinasse <walken@google.com>:
> > However I would like more information about your report. Did you apply
> > the series yourself ? If so, what base tree did you apply it onto ? If
> > not, what tree did you use that already included the series ?
>
> I build linux next-20200603 tree have the kernel/sys.c error.

Thanks for the info.

The proper fix is to replace down_write(&mm->mmap_sem) with
mmap_write_lock(mm) and up_write(&mm->mmap_sem) with
mmap_write_unlock(mm)

If you just needed a quick fix to get the tree to build, what you did
(replacing mmap_sem with mmap_lock) is also fine.

Thanks again !

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
