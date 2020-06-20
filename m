Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA9DC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 01:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49D2022D07
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 01:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592617496;
	bh=dlM11YL6n9RlDcOzhIHrZM9jsOceBXP57p6f1JNaSrw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YlRq7KUl/fjU0deg5ZbfnNBN/qV1PYp7P6zM+dvcU6uipsAsdc/fjU6yyrGtjWNSY
	 OrVLZEHeKCnsBP4mEjQnVAHZnqXe9Pd/1hT/u6rvVQGbrWVvD897qiYzioCY5tR4Yg
	 87F6UR1r/g6Wz2A093yMF1RfLk19uVO4OvDIx9QI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731499AbgFTBoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 21:44:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731480AbgFTBox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 21:44:53 -0400
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F17122D05;
        Sat, 20 Jun 2020 01:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592617492;
        bh=dlM11YL6n9RlDcOzhIHrZM9jsOceBXP57p6f1JNaSrw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aPMnOjSJgY5+/s7lTP00m/u2/uooEn2dghxG8T7DoPfKtVwSZ3ljJSVYWk6i3QShd
         FPtNZjknvtiuSWKlNRsqfu+fV/kaRVA3hw7MptjiCd2rRERUzppwcoldRIA+6YnCWy
         DklCbVMS8p8bpoKq32v4+CAys/q0IzzHXzYKUfyA=
Received: by mail-lj1-f177.google.com with SMTP id e4so13536906ljn.4;
        Fri, 19 Jun 2020 18:44:52 -0700 (PDT)
X-Gm-Message-State: AOAM533Y4HB5JPbkq9P/tgFglCGNcEe+4U2lEZpoOff/koP5CNLdKJ32
        unQgb0sjepcPYkt3fDUqSasIr3Fpci3g94YToOc=
X-Google-Smtp-Source: ABdhPJwyLXmFCCSeJMm9cfxXMHbfwE3locG8r1u3EvNL3/y/qlko5EFrUKzllfhIQF+0IYCsFwt+iV/XtbmqndS3RNM=
X-Received: by 2002:a2e:a58a:: with SMTP id m10mr3075924ljp.346.1592617490547;
 Fri, 19 Jun 2020 18:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200619160538.8641-1-peterx@redhat.com> <20200619160538.8641-7-peterx@redhat.com>
In-Reply-To: <20200619160538.8641-7-peterx@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 20 Jun 2020 09:44:31 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS+6UwSAbHk9236g2FOhyYniKZ-W3DcKJuSYMF13qHZxQ@mail.gmail.com>
Message-ID: <CAJF2gTS+6UwSAbHk9236g2FOhyYniKZ-W3DcKJuSYMF13qHZxQ@mail.gmail.com>
Subject: Re: [PATCH 06/26] mm/csky: Use general page fault accounting
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 20, 2020 at 12:05 AM Peter Xu <peterx@redhat.com> wrote:
>
> Use the general page fault accounting by passing regs into handle_mm_faul=
t().
> It naturally solve the issue of multiple page fault accounting when page =
fault
> retry happened.
>
> CC: Guo Ren <guoren@kernel.org>
> CC: linux-csky@vger.kernel.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/csky/mm/fault.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
> index b14f97d3cb15..a3e0aa3ebb79 100644
> --- a/arch/csky/mm/fault.c
> +++ b/arch/csky/mm/fault.c
> @@ -151,7 +151,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, u=
nsigned long write,
>          * the fault.
>          */
>         fault =3D handle_mm_fault(vma, address, write ? FAULT_FLAG_WRITE =
: 0,
> -                               NULL);
> +                               regs);
what's your kernel version ? =EF=BC=884th arg exsist ?=EF=BC=89
        /*
         * If for any reason at all we couldn't handle the fault,
         * make sure we exit gracefully rather than endlessly redo
         * the fault.
         */
        fault =3D handle_mm_fault(vma, address, write ? FAULT_FLAG_WRITE : =
0);
        if (unlikely(fault & VM_FAULT_ERROR)) {



--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
