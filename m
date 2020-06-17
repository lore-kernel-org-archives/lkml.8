Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8937AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 01:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6864C2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 01:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZxeQax/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgFQBGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 21:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgFQBF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 21:05:58 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD52C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 18:05:57 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id d12so283133qvn.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 18:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UAhdUIBFcfxLt9sFJzxhprSyP67JedmRd0Onm3q0FHk=;
        b=ZZxeQax/SaJoxCo6pUZJ33in8L39CXCkt0eDR5tj5YdXUYTVCFaeeZFF4i5fXcnhwe
         hDV/8mWW/UVovdxmsdo7GvgBDTOkbCVqRxGngQkeO/jcFpjXNjJFawYmDdlL9DpfFizQ
         AAP2hvZxZdDTE6SN7tgEZnwMWmw8mYMpsGeisELFhxC77Nuo+lWkBmdNqau9rb7dghBb
         7f/vbDTSLyOsZ40O2KAZF/UP1RzF7CtdHxs2Cg5wPnJqCgqCrt7kbkvaw855f5NgIj1P
         PIkiujuNB1oW2p2iwHC5BGZ9hEIBLBV+3gdbesU961asE5YzWeBvwZ0/sr4qzflTa0nq
         4qRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UAhdUIBFcfxLt9sFJzxhprSyP67JedmRd0Onm3q0FHk=;
        b=Js8MbXGueb2HeZ3UuJjikHUqqjIKqfRFGeF8IuJAuMXSt+kjTtetvPLJRoUzNTKelj
         XeQchtFBYKO97/9g4a+CB7vXndG7DlvPb+gbHSH/7/Nhk7CL6qz2EJKvWuGUrHQ610vl
         aOhx8s4byTu/nC6qDsMJsRIqrYZeXmM7/uO59cGGYjIeeZjkzPBkse/8pW4XtgOtMeXU
         yPm59CMuTZkJ7tER+peR5UYqZKS0nQQXXg23pohEZt3GfV7GdoXzELsafbP6gBsMnvM9
         PqjUfW1zyHG8j/bJW5B1g1G9Gf81jW4wifba1glA9EP4d+POYqxcD1IqWv6OVIhGiuIT
         YOTw==
X-Gm-Message-State: AOAM530GRG9bU8vP/jwY80TX9kes7h0sny0XnW7GZJ8iPhZjpQHWx8i+
        SGb8Exmym6Qe74fsB9nAE4L5+gYv7PCNXrfI5kA=
X-Google-Smtp-Source: ABdhPJyAQrNTTPuae73r/tERJMjeuuTm8yNA3iMU2sH9EHBSRerAqeexk2fyVh6XPYSZbkEtf3CXKot+cWDL4G+FzbQ=
X-Received: by 2002:a05:6214:1842:: with SMTP id d2mr5108616qvy.197.1592355956258;
 Tue, 16 Jun 2020 18:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200615221607.7764-1-peterx@redhat.com> <20200615221607.7764-14-peterx@redhat.com>
In-Reply-To: <20200615221607.7764-14-peterx@redhat.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Wed, 17 Jun 2020 09:05:18 +0800
Message-ID: <CAEbi=3e7t+=q5x3Wogr+EuejFxxmyuQTHE7jpDW++2n6MB2OWQ@mail.gmail.com>
Subject: Re: [PATCH 13/25] mm/nds32: Use mm_fault_accounting()
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nick Hu <nickhu@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> =E6=96=BC 2020=E5=B9=B46=E6=9C=8816=E6=97=A5 =
=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=886:16=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Use the new mm_fault_accounting() helper for page fault accounting.
>
> Avoid doing page fault accounting multiple times if the page fault is ret=
ried.
> Since at it, move the accounting after releasing mmap_sem.
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
> index f331e533edc2..11537c03ab1d 100644
> --- a/arch/nds32/mm/fault.c
> +++ b/arch/nds32/mm/fault.c
> @@ -78,7 +78,7 @@ void do_page_fault(unsigned long entry, unsigned long a=
ddr,
>         struct mm_struct *mm;
>         struct vm_area_struct *vma;
>         int si_code;
> -       vm_fault_t fault;
> +       vm_fault_t fault, major =3D 0;
>         unsigned int mask =3D VM_ACCESS_FLAGS;
>         unsigned int flags =3D FAULT_FLAG_DEFAULT;
>
> @@ -208,6 +208,7 @@ void do_page_fault(unsigned long entry, unsigned long=
 addr,
>          */
>
>         fault =3D handle_mm_fault(vma, addr, flags);
> +       major |=3D fault & VM_FAULT_MAJOR;
>
>         /*
>          * If we need to retry but a fatal signal is pending, handle the
> @@ -229,22 +230,7 @@ void do_page_fault(unsigned long entry, unsigned lon=
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
> @@ -257,6 +243,7 @@ void do_page_fault(unsigned long entry, unsigned long=
 addr,
>         }
>
>         up_read(&mm->mmap_sem);
> +       mm_fault_accounting(tsk, regs, addr, major);
>         return;
>
>         /*
> --
Hi Peter,

Thank you. :)
Acked-by: Greentime Hu <green.hu@gmail.com>
