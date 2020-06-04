Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08CEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 05:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDEC0206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 05:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oUoVxbUb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgFDF6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 01:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgFDF6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 01:58:09 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F69C05BD43
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 22:58:08 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id a80so2354722ybg.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 22:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TcecXJ2daa6cGmqdWJMR2w52jweMjWun9RPg5Xx26Sk=;
        b=oUoVxbUbbUwX+jqVje0MeoTNtiMgmXyOEt0P55vjxGaDiUwdB5boSWMXC5qxiHIr6n
         oH5tN5NQ8tlFDYaELXdiDSxZYA94TuAPFZymobINhFfNM9Rt64x3UGOlY3ny2Y/n0Tt4
         upTqerbGn+z4FLDl4CpH9+tTEVmRXJWX+ai7XYwEFJMVei6Uuwn5GM38SMuSJGmHLD+d
         bm9z1lZ4n0hjrjzSQ9D/2zeGuVBlZMzvzZ+/eQ3DI9VVjRbGY4Jn/UIUqwyLWkRyKMUV
         FGQk7qAf85qHNcGVkIovlPenvMYIKb6vyR4ieMxUAZnuNgqIZDnNx7CfX3WhoYYEiLJu
         MlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TcecXJ2daa6cGmqdWJMR2w52jweMjWun9RPg5Xx26Sk=;
        b=EFv9bnCpWtTegb24HEfCSnqA/qSe3sX6fETf5y+R8cdsoMafLRTckY+nojk/rWc7R7
         NPJjUjylSEZNfX5FV+cZJJ6Ngmern6PiQZNTosdAk+lVmuMRa+ztKdnEJMiEbL2It1Gk
         N8sCSLgfSutuq81YmISYgFc/t/xF++6n7zf+SffXj9sTjTEVuEwAheb/vDMHx7zLPjU6
         QOhlI+s/9YIS2+GAW+O6wfl7rut2AAPkv2YQ0YtOxKKaSQVDPeK1KgGgWAybxGTN5on5
         kLQiyQU9a+K7AiCYoCSl6GihW5E8XYlglQP/xElLYui3/500n5jxfrRawxBG2gkg8lgI
         b/jw==
X-Gm-Message-State: AOAM530Nc6aDLXWodJUv5duLy0V/tOGCx0mZ314jjdPzYoZGlCN2DrsF
        QzVZSd9nhsK+EuIWLceVGEIN33r64tBSctL+bMCt6A==
X-Google-Smtp-Source: ABdhPJz/qUrBneza/kk1XNsMraG+yR1nVfzjN8vISQMME/8LCOncoIqe5jfJOCcLFgu1zEUfo01cpPMgqx4ebSdFjvM=
X-Received: by 2002:a25:bcc2:: with SMTP id l2mr5137096ybm.298.1591250287067;
 Wed, 03 Jun 2020 22:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAOzgRdZQjuDfA1wa9AGYjRa-mNWbTNQNCOS60eHzDLeW9WCXpg@mail.gmail.com>
In-Reply-To: <CAOzgRdZQjuDfA1wa9AGYjRa-mNWbTNQNCOS60eHzDLeW9WCXpg@mail.gmail.com>
From:   Michel Lespinasse <walken@google.com>
Date:   Wed, 3 Jun 2020 22:57:53 -0700
Message-ID: <CANN689Gy2aUgF7oE2UE3miHf7fah=9zM3KZ512Mj6kJTiRz3Xg@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 3, 2020 at 9:35 PM youling 257 <youling257@gmail.com> wrote:
> I have build error about kernel/sys.c,
>
> kernel/sys.c: In function =E2=80=98prctl_set_vma=E2=80=99:
> kernel/sys.c:2392:18: error:
> =E2=80=98struct mm_struct=E2=80=99 has no member named =E2=80=98mmap_sem=
=E2=80=99; did you mean
> =E2=80=98mmap_base=E2=80=99?
>   2392 |  down_write(&mm->mmap_sem);
>        |                  ^~~~~~~~
>        |                  mmap_base
> kernel/sys.c:2402:16: error:
> =E2=80=98struct mm_struct=E2=80=99 has no member named =E2=80=98mmap_sem=
=E2=80=99; did you mean
> =E2=80=98mmap_base=E2=80=99?
>   2402 |  up_write(&mm->mmap_sem);
>        |                ^~~~~~~~
>        |                mmap_base
>
> why not rename kernel/sys.c mmap_sem to mmap_lock?

The proper fix would be to use the mmap locking apis defined in
include/linux/mmap_lock.h instead.

However I would like more information about your report. Did you apply
the series yourself ? If so, what base tree did you apply it onto ? If
not, what tree did you use that already included the series ?

Thanks,

--=20
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
