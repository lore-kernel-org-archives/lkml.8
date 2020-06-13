Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09262C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 04:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB8ED207D8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 04:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lh03iQ9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgFMEow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 00:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgFMEov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 00:44:51 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E385C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 21:44:51 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id x18so10702915ilp.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 21:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Cx2PDT4tTqeir+6bsWnKiVj//PIMKhOoR8f76t54cLM=;
        b=Lh03iQ9SAV6KYubI78RQKIFOTDE1FU3IAJ0dYQuP7q88IDiF/oe3MemPn9utySVmhx
         Wts5Z8K1vIlvqd1B2q8DSfo5p393zIPQgVpsIm9USwI1EJ1JUFHXor4NxjaGaoAHqun1
         KE3mBwFyVhnXddH5okxKo4rMGtlRvGIXpu/uBzkbpDHEuAxMEnhltmSQ+7RurIKVXhGz
         VzwaRewUWZh7HPrmH91dbZ+69egx2gKv8RvJ3QTX6QTdXIeMwLfi9JTCU7HC1RR7a3wV
         Okj8vS1W8WxMTbwosmVRkh8FaMPo2+MhJJLKOz+hzAUSlqHtPIbmLJwKnzgce9jLbwfo
         y0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Cx2PDT4tTqeir+6bsWnKiVj//PIMKhOoR8f76t54cLM=;
        b=FhQrGxS8RFHFCDMZW/rkcNF5JwKEE47J8QZ+PBtotLqJgTGTx0+vkQfgUkR+GYdbt7
         PpzoV9uRN0+2Vn5JV4IiJ7Si7vWzEhwAcp3+LojY0NYQZzUDlmj+zebwLxvpplc78kMO
         9vJW3+sIS3zrch9NauYGPrbTBGn6wOcL+BZD8ehJkV9MehvfNR97wo5d2s/4pRH4kOKA
         K3Qh+9Mwp2YPenoGle1/xloXLDTOvXEBN7qgHkUO5il3U6f+1RAE60zqmMGj1cXuSqhw
         FJ62tzbzzB4YcQCEjyrX5/4dCEJHW8wMeE3o6Tb5hnnEXPQNATIG7q0SUiaFLbgNOg0Q
         Uo+A==
X-Gm-Message-State: AOAM532t44z6Tb7RXNX6PKaetjdlNzJ0j+/qncBq+xj6PIsoYKlcz9f6
        rF6X4V4vz28FYvcNomCd+LT/lCxArg3egqfDIMR8tMxrcYc=
X-Google-Smtp-Source: ABdhPJzI4T4eSQMWpvx7OTzHdnAfKgH2WKNsN8xKJ+7TEAT0GR/60aVBUxhkosxWrXdRv3/fqPdvQzlQjzirTfwpwqQ=
X-Received: by 2002:a92:c941:: with SMTP id i1mr14927825ilq.94.1592023490745;
 Fri, 12 Jun 2020 21:44:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:d54a:0:0:0:0:0 with HTTP; Fri, 12 Jun 2020 21:44:50
 -0700 (PDT)
In-Reply-To: <CANN689GvTF75Knsc82PGrwA44J+yx2ORP-i3fp36avMuxRPwdg@mail.gmail.com>
References: <CAOzgRdZQjuDfA1wa9AGYjRa-mNWbTNQNCOS60eHzDLeW9WCXpg@mail.gmail.com>
 <CANN689Gy2aUgF7oE2UE3miHf7fah=9zM3KZ512Mj6kJTiRz3Xg@mail.gmail.com>
 <CAOzgRdZejnB+ruxhZhKBBw9rgnfNbiLSensa-2+20FTkSxrwwA@mail.gmail.com> <CANN689GvTF75Knsc82PGrwA44J+yx2ORP-i3fp36avMuxRPwdg@mail.gmail.com>
From:   youling 257 <youling257@gmail.com>
Date:   Sat, 13 Jun 2020 12:44:50 +0800
Message-ID: <CAOzgRdbtN2LsPHXsEOLJXvXgA6rQgXfqBCsN_DXB8YCGZQmMAQ@mail.gmail.com>
Subject: Re: [PATCH v6 10/12] mmap locking API: rename mmap_sem to mmap_lock
To:     Michel Lespinasse <walken@google.com>
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

today test linux kernel master branch, I have kernel/sys.c build error.
can you make a fix patch and push to linus?

2020-06-04 16:38 GMT+08:00, Michel Lespinasse <walken@google.com>:
> On Thu, Jun 4, 2020 at 1:16 AM youling 257 <youling257@gmail.com> wrote:
>> 2020-06-04 13:57 GMT+08:00, Michel Lespinasse <walken@google.com>:
>> > However I would like more information about your report. Did you apply
>> > the series yourself ? If so, what base tree did you apply it onto ? If
>> > not, what tree did you use that already included the series ?
>>
>> I build linux next-20200603 tree have the kernel/sys.c error.
>
> Thanks for the info.
>
> The proper fix is to replace down_write(&mm->mmap_sem) with
> mmap_write_lock(mm) and up_write(&mm->mmap_sem) with
> mmap_write_unlock(mm)
>
> If you just needed a quick fix to get the tree to build, what you did
> (replacing mmap_sem with mmap_lock) is also fine.
>
> Thanks again !
>
> --
> Michel "Walken" Lespinasse
> A program is never fully debugged until the last user dies.
>
