Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09A2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0D28206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYN/dONK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgGCHri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgGCHrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:47:37 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4284C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 00:47:37 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id z2so23289580qts.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 00:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VZtEbxIRBIRflU8UoImAzW+G0W3pp330LtWYjBLtamo=;
        b=CYN/dONKSTsQV87cq5Eo5dQPmZVv8CWLnGtm4ZW52KJn3xC4A5nW2YY0Hp4mlCqN7u
         yO1ELrSz0iegM6ob4cAYP1U5nRYnEKAL9vVq4ge+cX3DTlNTNFBgfqgJuz92jp0rxL3G
         zlc0lUp0pPRwP1Niz0sEOAzhznIJ0ubPEIUmuKnNhyxS+idAKaEfnYB78RPZFvvRGTtk
         pb5HVmZxtasLTOLJ4nDwL5RxBgEF6JTTd7BboDuTI9MXvio+eLi/lbo8HD0479Fwi3Uu
         c9RHGfAa00mcoHXp64XRfm2x8PbIlcimuELzz2awBXBhArCa9sjya5EEJXtX3LoqNDoG
         T38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VZtEbxIRBIRflU8UoImAzW+G0W3pp330LtWYjBLtamo=;
        b=Ap5g3GnDqaOY8aOaE0cq50h9RCgUWduvcKyynL78qMRxnLIiJ0Rw2mn9Zm48EZHi3X
         1FufxuW6upjICvguJ5/7gwnYC06mOHdwBC+6t8MpB55W44lxrIdsLR5lv1Jg/I+42Lmq
         eDF2rj6YaipIKIzkAUNEWrxY89VvN9BpN3c3N37hrSEsL7iAnAsPqi7chIIDzAobvq3F
         jNFhb505f0t+8270wrzNHC5rIjfNDWbsbOn0gLpaeoole7IrVpNkayHGz2tCvQaNiC5w
         0XwJouzDcEHaajpDcWp70LeRjQHEK/d0DdyJ8MsLJPVDbmzbXBQ4iGz+qjUx+x7OSz/a
         IUCA==
X-Gm-Message-State: AOAM533eylNmPliRPLFZuQECTzaHG13hODdvWGI9WYjXnzM1IPoUhNcf
        wre9kDjcQhA9i1LovMahmkpqSYpq3fZNLkqAieg=
X-Google-Smtp-Source: ABdhPJxms9b7K2WE/47/589yQkiyABa4IQDRfwhFipGDfReyghivC9nYx7vhdgupgU+2xz/mgO/WrW08PLYs6g5wCHY=
X-Received: by 2002:ac8:66d1:: with SMTP id m17mr35232055qtp.88.1593762456982;
 Fri, 03 Jul 2020 00:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200703061350.94474-1-songmuchun@bytedance.com>
 <CAOJsxLGc-o1Os7HAoQmhd1DNxGWVrfbw2R8NroTQg0wHNyWX1w@mail.gmail.com> <fe891223-9f83-d112-b185-643d6121712d@redhat.com>
In-Reply-To: <fe891223-9f83-d112-b185-643d6121712d@redhat.com>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Fri, 3 Jul 2020 10:47:20 +0300
Message-ID: <CAOJsxLFpj1iZ8BVPwoSQJjBBtWnREQ=dVLNRV5fm4_Gvyn_DTw@mail.gmail.com>
Subject: Re: [PATCH RESEND] mm/page_alloc: skip setting nodemask when we are
 in interrupt
To:     David Hildenbrand <david@redhat.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.07.20 08:34, Pekka Enberg wrote:
> >         if (cpusets_enabled()) {
> >                 *alloc_mask |= __GFP_HARDWALL;
> >                 if (!in_interrupt() && !ac->nodemask)
> >                         ac->nodemask = &cpuset_current_mems_allowed;
> >                 else
> >                         *alloc_flags |= ALLOC_CPUSET;
> >         }

On Fri, Jul 3, 2020 at 10:20 AM David Hildenbrand <david@redhat.com> wrote:
> ^ looks much cleaner as well. Do we want to add a summarizing comment?

I see no harm in adding one. I'm sure the next person starting a
journey in the maze some call the page allocator will appreciate it.

- Pekka
