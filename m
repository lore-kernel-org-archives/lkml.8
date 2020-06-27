Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14466C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 02:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF7372073E
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 02:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ufQpLcBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgF0C7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 22:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgF0C7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 22:59:43 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BB5C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 19:59:43 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id r22so10638878qke.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 19:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=65nkEV4leipLRUprG00qYP0LfKYS+2u1CjazML/VYvs=;
        b=ufQpLcBLgFqdO+GimqdCABK9pOWK9i4Ib8qTHV77sfsYlKEJXcSDODaUQAcCDSG7Ta
         MUqQWVVL3bH0WFi857oMIlxcYVEB8WBhPfk8TyTjEGyTxjb4dqUl+mvy2K+dCSd4Y8iA
         MtcNkL70P7x8C13GrXPG0heECwv5YgU4iVzhGCoDGhoglraN1CiZzzRh6yZWozOxntOK
         RH41BM+5WetO+ED72Oev4atcEB0I82fftxewxnNdSPn2BztSErF7K0H8oiwDjlnAvSFp
         wV09feEvRC6Sd0REIkDP+bp5NPKtCcefYfcyqyiFUIdqiIml+Vhb1R9wBv2Wse5ARPl5
         WnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=65nkEV4leipLRUprG00qYP0LfKYS+2u1CjazML/VYvs=;
        b=PPk7mHCxBcN9/I6D6TwsgIPjH2POnAsjOLSC+uax8d+VndC814b97xGeLBG4KjkYfP
         crBqo7Rfh6Kgl8RDnPuTxVP58pKR0+/kON1n4/zl4RKK8WA4HgkLg6VphqwlNi/83pxi
         ZBUv0cPtUwKnKfq6uZH143MxzAP+x0nTj+D63U1l50s9MsiVFYG6WlnIFFarPObl4I8v
         aYnjJyFkG4EA9CeZOK6hdYZ7GESRBP8IfDd8IQQ5xJFSyvnuSIw1ebBoZ2HRO8mLn59+
         GnF3x6JVhaW51wlkilLMH9FYRnG8yXzQ6E0UCocoCrFPVlkyXhb6JFMKBC+ZmSnktDrt
         ULXA==
X-Gm-Message-State: AOAM532/Fedw+RTnqb1Rs5nsyuxNwZj+vdgVhwqw/IrYpKZGHH5dGCgr
        uOmEV5KNvOmvd90nA5MKBsl4QFqhaWGyoJTqSkw=
X-Google-Smtp-Source: ABdhPJy9s9iyS7PvG+U3dwvh2O1j5oqQuJV+dK9C3Q8IzwYDrF1PJlB9LT2P7uLc/ysVzweAw2ya9l0OSOJsYfly69k=
X-Received: by 2002:a37:48cc:: with SMTP id v195mr5884992qka.232.1593226782596;
 Fri, 26 Jun 2020 19:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200626223130.199227-1-peterx@redhat.com> <20200626223130.199227-13-peterx@redhat.com>
In-Reply-To: <20200626223130.199227-13-peterx@redhat.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Sat, 27 Jun 2020 10:59:03 +0800
Message-ID: <CAEbi=3eMG5R9dC+xZvFrzMSjvwber1YOa6-Aa3Ww0ksbeeCUfQ@mail.gmail.com>
Subject: Re: [PATCH 12/26] mm/nds32: Use general page fault accounting
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Hu <nickhu@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> =E6=96=BC 2020=E5=B9=B46=E6=9C=8827=E6=97=A5 =
=E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=886:31=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Use the general page fault accounting by passing regs into handle_mm_faul=
t().
> It naturally solve the issue of multiple page fault accounting when page =
fault
> retry happened.
>
> Fix PERF_COUNT_SW_PAGE_FAULTS perf event manually for page fault retries,=
 by
> moving it before taking mmap_sem.
>
> CC: Nick Hu <nickhu@andestech.com>
> CC: Greentime Hu <green.hu@gmail.com>
> CC: Vincent Chen <deanbo422@gmail.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/nds32/mm/fault.c | 19 +++----------------
>  1 file changed, 3 insertions(+), 16 deletions(-)
>
> diff --git a/arch/nds32/mm/fault.c b/arch/nds32/mm/fault.c
> index 22527129025c..e7344440623c 100644
> --- a/arch/nds32/mm/fault.c
> +++ b/arch/nds32/mm/fault.c
> @@ -122,6 +122,8 @@ void do_page_fault(unsigned long entry, unsigned long=
 addr,
>         if (unlikely(faulthandler_disabled() || !mm))
>                 goto no_context;
>
> +       perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
> +
>         /*
>          * As per x86, we may deadlock here. However, since the kernel on=
ly
>          * validly references user space from well defined areas of the c=
ode,
> @@ -207,7 +209,7 @@ void do_page_fault(unsigned long entry, unsigned long=
 addr,
>          * the fault.
>          */
>
> -       fault =3D handle_mm_fault(vma, addr, flags, NULL);
> +       fault =3D handle_mm_fault(vma, addr, flags, regs);
>
>         /*
>          * If we need to retry but a fatal signal is pending, handle the
> @@ -229,22 +231,7 @@ void do_page_fault(unsigned long entry, unsigned lon=
g addr,
>                         goto bad_area;
>         }
>
> -       /*
> -        * Major/minor page fault accounting is only done on the initial
> -        * attempt. If we go through a retry, it is extremely likely that=
 the
> -        * page will be found in page cache at that point.
> -        */
> -       perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
>         if (flags & FAULT_FLAG_ALLOW_RETRY) {
> -               if (fault & VM_FAULT_MAJOR) {
> -                       tsk->maj_flt++;
> -                       perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ,
> -                                     1, regs, addr);
> -               } else {
> -                       tsk->min_flt++;
> -                       perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN,
> -                                     1, regs, addr);
> -               }
>                 if (fault & VM_FAULT_RETRY) {
>                         flags |=3D FAULT_FLAG_TRIED;
>

Hi Peter,

Thank you.
Acked-by: Greentime Hu <green.hu@gmail.com>
