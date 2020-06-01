Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51663C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D1DB2074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591002003;
	bh=WgAfPuFYBjN7FHru2gW4qab9TJ5NnQOwxcj2jx65e30=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QshMfIV22PPj+OeNC0QPN3IpdvCEkD5teNR/raleYdB6wsd51upzk5ZIDbD4LrnQW
	 Yde6Xix/GeRuF0HQzIrDgqt+h7OqkLWAJKRXVTfy/s6SHNC7kfgwiW6feNv9dgfCpX
	 v7EJYmjEjFYMj6/uEoMGnDaRqBYJnjs4cXNTbxBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgFAJAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:00:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgFAJAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:00:01 -0400
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FE84207D0
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 09:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591002000;
        bh=WgAfPuFYBjN7FHru2gW4qab9TJ5NnQOwxcj2jx65e30=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DNBAKb8FYEmA547roJCmUEHeJi/9p01W106l8Mj6KF2DIuThf0DPO9tsIZ+xI5OSa
         Qb5NaPzCxpLz4T6+ILlQSjGx+v7ngJEnBvsyaym53GD4oebU3RYnPyPpSyeXfEyNGa
         NSN25oWZZbfy3gNSsxJMj90baVe5yL+hMNaEDVog=
Received: by mail-lj1-f181.google.com with SMTP id z18so7113228lji.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 02:00:00 -0700 (PDT)
X-Gm-Message-State: AOAM533fHm0vby9Ahd9GKx6FHfOCs1hZriYLIcg/tWjYjWlEqBYu/r12
        giuCxT6klHeVXHEpNWPIZzkl4Y0mVXsoVMYdtio=
X-Google-Smtp-Source: ABdhPJwGtg0X8mVAjFPLBTQ5dBxDhXXDDNXX89zqKO/9BIIxLL1WvuFWwpDj6JtSJBzC41WwT07o3G9sDZFcl0KOqsc=
X-Received: by 2002:a2e:a58a:: with SMTP id m10mr9871173ljp.346.1591001998792;
 Mon, 01 Jun 2020 01:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590474856.git.greentime.hu@sifive.com> <fe966314eae51a5089033f7186ac86c39719e0a0.1590474856.git.greentime.hu@sifive.com>
 <CAJF2gTTnLNmNUvDwRSsmD9auaOGuqYXjuucKSyXZQKoEWEq4Ow@mail.gmail.com> <CAHCEeh+d+ya6+Xrh8hdWVSGo2kk_rZ8PV2eMM-2LLaOojAaBtQ@mail.gmail.com>
In-Reply-To: <CAHCEeh+d+ya6+Xrh8hdWVSGo2kk_rZ8PV2eMM-2LLaOojAaBtQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 1 Jun 2020 16:59:47 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRk3hUmqOb4dhCWhLZq6tznwVLWGe5M4jY4D+DS+P6vNQ@mail.gmail.com>
Message-ID: <CAJF2gTRk3hUmqOb4dhCWhLZq6tznwVLWGe5M4jY4D+DS+P6vNQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 05/13] riscv: Add new csr defines related to vector extension
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     Guo Ren <guoren@linux.alibaba.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 4:15 PM Greentime Hu <greentime.hu@sifive.com> wrote=
:
>
> Guo Ren <guoren@kernel.org> =E6=96=BC 2020=E5=B9=B45=E6=9C=8831=E6=97=A5 =
=E9=80=B1=E6=97=A5 =E4=B8=8A=E5=8D=889:56=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > Hi Greentime,
> >
> > Why remove vxrm and xstat ?
> >
> > > Appendix B: Calling Convention
> > > In the RISC-V psABI, the vector registers v0-v31 are all caller-saved=
. The vstart, vl, and vtype CSRs are also caller-saved.
> > > The vxrm and vxsat fields have thread storage duration.
> >
> Hi Guo,
>
> https://github.com/riscv/riscv-v-spec/blob/master/v-spec.adoc#vector-cont=
rol-and-status-register-vcsr
> "The vxrm and vxsat separate CSRs can also be accessed via fields in
> the vector control and status CSR, vcsr."
>
> Since vcsr will save all these information, I think it should be ok to
> save vcsr only.

Got it, it's similar with fcsr & frm & fflags.

Acked-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
