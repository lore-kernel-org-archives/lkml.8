Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97FDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83FE9206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1ULfBB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgFDIGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgFDIGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:06:50 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B669BC05BD1E
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 01:06:47 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id j8so5290873iog.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 01:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=30zbvCSiUNFC/4JC6r6s08hU1h5yZMzf9vYI5wggAUk=;
        b=X1ULfBB6m9lNFEUzzxvnEzyoXzk+e9lxy25yEd0WsJ3q60vDpYJVIdXq2FaaLXmQvM
         sayG59JEagjzc2FRuRVVh1IhEOqCytQlvMyB44xHizQOnuaKAZdWjT9q1tAz9BnWL9tb
         LLRtATBme2H8jMWw3PeDk309pUT2zvOOCq46f5GYJdhNX8xyOLkIBZoL6eBTtCTcBPc1
         wHkOYwMacy8xX6OdYGPWuAS+WMo0b64pwKAqpMj81cwNE2IRkHvFk7XNFlD2PYZ0UOM+
         UI6W7R4vbH68xHT4VHiuCb8x537MhsSnDQuajblLnQsnMEatwZJNkDnaEC7WerA6sTaJ
         +fWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=30zbvCSiUNFC/4JC6r6s08hU1h5yZMzf9vYI5wggAUk=;
        b=C4tXFMLY1a/3/6CNCgNaYuIu6CYF6a3cbhK+Tx+KLY7MiEkvxAairU2c1VIASI3kpf
         by4xo4H4t+kcl+GuO+wouy89xl4uuGIJN3x+39Ew0ERvna3f5yK9E4A1VZridLULMUwn
         l6p4Ly7SESJrFRhJb+jq2XS9UpbByau2idkiVK6tCw+kThUlxl54Bt7k3BY6WTFj+dPA
         dnCO2ovG6FDHIrIgAO8MK+TEiYpJo4JBma1LjAj2FW0A2ecvTd0tDI/n4mIQRZGRa6Ur
         YYtNTRrab+x6QjIzOGrYERIMYo8wRJA+CQ5KGFkBKMO16zPc0aZl+ggm/iqIcM16In7V
         M+3g==
X-Gm-Message-State: AOAM531y3WyR5qSK61MH/0q2HhOIYJjGTMJ3F/rgr7hKQlGG1p26gNwc
        lA3kKu638NGFWj1ljQNQluNIKTOnMOteNjh4TZc=
X-Google-Smtp-Source: ABdhPJw6c7hVXevkuShijLGTZaMQmky6RMLqAb2BAYsD62NN4HlxtQ6cABWQZMFm2BAthP7aWGqt9A6D1gKBOEXJs6g=
X-Received: by 2002:a6b:5915:: with SMTP id n21mr3050044iob.103.1591258007026;
 Thu, 04 Jun 2020 01:06:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:d54a:0:0:0:0:0 with HTTP; Thu, 4 Jun 2020 01:06:46 -0700 (PDT)
In-Reply-To: <CANN689Gy2aUgF7oE2UE3miHf7fah=9zM3KZ512Mj6kJTiRz3Xg@mail.gmail.com>
References: <CAOzgRdZQjuDfA1wa9AGYjRa-mNWbTNQNCOS60eHzDLeW9WCXpg@mail.gmail.com>
 <CANN689Gy2aUgF7oE2UE3miHf7fah=9zM3KZ512Mj6kJTiRz3Xg@mail.gmail.com>
From:   youling 257 <youling257@gmail.com>
Date:   Thu, 4 Jun 2020 16:06:46 +0800
Message-ID: <CAOzgRdaDkYNGNgfNbEnANUiRLnR7s+-He1H0jABGOAe6h4YSaQ@mail.gmail.com>
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

i build linux next kernel have the kernel/sys.c error.

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
>
> Thanks,
>
> --
> Michel "Walken" Lespinasse
> A program is never fully debugged until the last user dies.
>
