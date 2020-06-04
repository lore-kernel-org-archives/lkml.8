Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E078C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C8552074B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nabm25sR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgFDIQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgFDIQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:16:09 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8849C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 01:16:09 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t8so5203239ilm.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 01:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kjjlTnSa7zCVTFiJJ897/S5uuNv1Eo5hAY1pnGGn8sA=;
        b=Nabm25sR4PLNEV7zV1UPUPkYNimXTKjp+dGu60tvTZNRb8dv2u/4hl78eSIISghSTr
         vtY7oYkZ5I3LZUZcTi048QdGyKiPWLnSlqSR6RADlgtzYpRgolVWIzrzV0bVt5k4YZCS
         53+UAJDwhqvzBfflpoYV0nwjk+8UNIKfXuEOTzr1Cco8JmTXyp4RZcFm+7i4uzt5Vtq0
         e5FixZ94ygf+D02QbGyKss+tFI9np7MOCWckaDPPR7+fF6tvK4FjfoqKwy8jH+Vfwhkd
         MAjMvcQuPfBER+beuccuav9azQVIEvlzrdAqlUDUTuF5XLUC/uRkqSHZ35EKT1ImeO4Q
         S/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kjjlTnSa7zCVTFiJJ897/S5uuNv1Eo5hAY1pnGGn8sA=;
        b=ffIcuurWHNp1+XmzydWcOuXswKmYBhNtGE390ihhZCnq5HkXaX5udY3c7LcvJJfxbj
         0LCxzUfmIy+iLbrg/z1/SLh5RdzleXIygEXduDPqQHGtSXoTocfaJ892N79yoCtQhNdr
         BpfzRptbgjHbo8i9SdXeffIDBAvXXRkG6ujm5q1869N2VDTNqvHcLUTXSWqNhzBfRDV3
         GvKas7oD03C2ZDyvSzyT3iF1A0MbE1TMYZgYYB18imlBl05q4G0rW5/IZP7RnC0yR+21
         miO3MKxKcNtQegNyKKBqEIUFjhcwQNgUVDA1+fOvf+pPXUBb3iA0drdmSJDK0j+AXyCh
         njAg==
X-Gm-Message-State: AOAM532eqMfz1qU3Y6kj24tRBMrwpT2UyGXElKnUpdJ3cG9RXCX2crdC
        qQ7I4GcHjEXMiwUJpq8NoSX/iqe9rvg5y5n9z1E=
X-Google-Smtp-Source: ABdhPJyUX1Zz3KIvZHOPxX4jKyUlPdBfNXICoRiSq7Z7LJrDNOWGSIROXUEGzNsj6q49kVhWXqdAiAdtH6davA6o2H4=
X-Received: by 2002:a92:9a5c:: with SMTP id t89mr2939515ili.280.1591258569224;
 Thu, 04 Jun 2020 01:16:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:d54a:0:0:0:0:0 with HTTP; Thu, 4 Jun 2020 01:16:08 -0700 (PDT)
In-Reply-To: <CANN689Gy2aUgF7oE2UE3miHf7fah=9zM3KZ512Mj6kJTiRz3Xg@mail.gmail.com>
References: <CAOzgRdZQjuDfA1wa9AGYjRa-mNWbTNQNCOS60eHzDLeW9WCXpg@mail.gmail.com>
 <CANN689Gy2aUgF7oE2UE3miHf7fah=9zM3KZ512Mj6kJTiRz3Xg@mail.gmail.com>
From:   youling 257 <youling257@gmail.com>
Date:   Thu, 4 Jun 2020 16:16:08 +0800
Message-ID: <CAOzgRdZejnB+ruxhZhKBBw9rgnfNbiLSensa-2+20FTkSxrwwA@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020-06-04 13:57 GMT+08:00, Michel Lespinasse <walken@google.com>:
> On Wed, Jun 3, 2020 at 9:35 PM youling 257 <youling257@gmail.com> wrote:
>> I have build error about kernel/sys.c,
>>
>> kernel/sys.c: In function =E2=80=98prctl_set_vma=E2=80=99:
>> kernel/sys.c:2392:18: error:
>> =E2=80=98struct mm_struct=E2=80=99 has no member named =E2=80=98mmap_sem=
=E2=80=99; did you mean
>> =E2=80=98mmap_base=E2=80=99?
>>   2392 |  down_write(&mm->mmap_sem);
>>        |                  ^~~~~~~~
>>        |                  mmap_base
>> kernel/sys.c:2402:16: error:
>> =E2=80=98struct mm_struct=E2=80=99 has no member named =E2=80=98mmap_sem=
=E2=80=99; did you mean
>> =E2=80=98mmap_base=E2=80=99?
>>   2402 |  up_write(&mm->mmap_sem);
>>        |                ^~~~~~~~
>>        |                mmap_base
>>
>> why not rename kernel/sys.c mmap_sem to mmap_lock?
>
> The proper fix would be to use the mmap locking apis defined in
> include/linux/mmap_lock.h instead.
>
> However I would like more information about your report. Did you apply
> the series yourself ? If so, what base tree did you apply it onto ? If
> not, what tree did you use that already included the series ?

I build linux next-20200603 tree have the kernel/sys.c error.

> Thanks,
>
> --
> Michel "Walken" Lespinasse
> A program is never fully debugged until the last user dies.
>
