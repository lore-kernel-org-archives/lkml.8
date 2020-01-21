Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D12EC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 19:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7AB21734
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 19:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QnkelPvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgAUTCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 14:02:48 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41281 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbgAUTCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 14:02:48 -0500
Received: by mail-pg1-f196.google.com with SMTP id x8so1988313pgk.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 11:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bNyNTjqh9Xf964gmgRKYgFMexU7pALAJvxvUiv7FDAM=;
        b=QnkelPvoyCek/r3fVqWEWqRt2VWTazFJ35gDQ3rIydzcJf8VYUEEgydphXGlar9B9B
         L/nbv+r3Nt8yiEZn7HXvAqbQZ8jDBzjsziJs2KaZPknA6gwzaqJ/U3u70sjPypk1Qxye
         iE3iVONYSJdZaaTynfmlZRAPNoFeTzU2KolmhDfhHdSCHBk9mIzloYXtzr4mTuAnAfYN
         532TyXVUZIIw4BIa2xoOCZnfrgKZcJF2/C8s5zc6UBDJwSKYPbaKGSobvA8SJoh1cO4l
         9pJutOqYAGV20YN9JVeI+8ZOv2Mict70bsy66uQC5hxEIoCk+vbc5DMmDwFLfKlDUYYO
         5IfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bNyNTjqh9Xf964gmgRKYgFMexU7pALAJvxvUiv7FDAM=;
        b=NMwp1ZUoduf8lRzeubz8VGPblir2E9uuswNDV+0de1ET6Ma5RYH0EkQRlWiHT1fGer
         vUx/4h240UTj94TtEbNLqtXvvadYLP3uXTFrEo0UT4zbbFU7ClHQKvrQ+++pcn//6uj1
         v98fAqAnIXeF0EVy6Y9Lyb9UErrAJz7s+uSEqR62JVEd2VuJsq8HEhR6R3n7xD2/Avms
         UUEqo6A6Xp0XjDkxSPsXPZSPk67VVr1GhLDbqw7EqA53OKFx2iZMa06lZRPb1AQ0syoD
         XgoZjj5UjrPN+/Bd5BR7MnKXtbrO70NaP7dzTVmayzm+uB+cq0AkowsPELNrfKZfhrGn
         8Nxg==
X-Gm-Message-State: APjAAAUiSLKWme7GnfL3KDzi6oy/ZTHmVw0BC4syx/r83qj1IIYWGRZR
        vB5dP4X7yigY6C25qfdYieH8nRXeT1QeKDO74dbwrA==
X-Google-Smtp-Source: APXvYqz+kwhVtEFOOWgrHq5khPjnSYd1iPUmGwSt6xL/jKXDQF+zvcWVb6HOt2Te5svw2+maZGEdiKzjFbchDLVy6So=
X-Received: by 2002:a63:d249:: with SMTP id t9mr7155939pgi.263.1579633367158;
 Tue, 21 Jan 2020 11:02:47 -0800 (PST)
MIME-Version: 1.0
References: <20200120190021.26460-1-natechancellor@gmail.com>
 <CAKwvOd=30bpBXqrT6LfwDb+YrTcGtTg5NL34dpc3Vkfe11KvFQ@mail.gmail.com> <20200121185834.GA3941@ubuntu-x2-xlarge-x86>
In-Reply-To: <20200121185834.GA3941@ubuntu-x2-xlarge-x86>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 21 Jan 2020 11:02:36 -0800
Message-ID: <CAKwvOd=ZjbN+3ObaOXYcQBa6e_2UqzALeOikruR=9Sn1Rb65Uw@mail.gmail.com>
Subject: Re: [PATCH] scsi: qla1280: Fix a use of QLA_64BIT_PTR
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Michael Reed <mdr@sgi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 10:58 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Tue, Jan 21, 2020 at 10:43:06AM -0800, Nick Desaulniers wrote:
> > On Mon, Jan 20, 2020 at 11:00 AM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > > -#if QLA_64BIT_PTR
> > > +#ifdef QLA_64BIT_PTR
> >
> > Thomas should test this, as it implies the previous patch was NEVER
> > using the "true case" values, making it in effect a
> > no-functional-change (NFC).
>
> QLA_64BIT_PTR is defined to 1 when CONFIG_ARCH_DMA_ADDR_T_64BIT is set
> so the true should have always worked, unless I am misunderstanding what
> you are saying. The false case should have also worked because it is
> still evaluated to 0 but it throws the warning to make sure that was
> intended (again, as I understand it).
>
> > >  #define LOAD_CMD       MBC_LOAD_RAM_A64_ROM
> > >  #define DUMP_CMD       MBC_DUMP_RAM_A64_ROM
> > >  #define CMD_ARGS       (BIT_7 | BIT_6 | BIT_4 | BIT_3 | BIT_2 | BIT_1 | BIT_0)

Ah, right, so either QLA_64BIT_PTR is defined with a value of 1, or
not defined at all.  My bad.
-- 
Thanks,
~Nick Desaulniers
