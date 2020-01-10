Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C722C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 08:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D409206ED
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 08:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSLQC4z2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgAJIgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 03:36:40 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41335 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgAJIgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 03:36:40 -0500
Received: by mail-lf1-f67.google.com with SMTP id m30so814931lfp.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 00:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ub36zKVh3A5wkEC7mjnfOzyg3ZRyIUoEtBmwTMIWVKc=;
        b=YSLQC4z281Xf443p8nJgPFImjnFlLrbAjvdx3+qBBP1qtEHRW4A8jOy3AEcjeVhUUy
         u1Z8BVvszMy6ha0d0hVVLlWhjtu2sELf9yaO9rzcaL2YsP6NsYGtAZXABB9cNawuGoaW
         LGDzWHbFV3eiqyDj0UD49akMtzvCpNAr+hyZ459tDJNaW1hEHdyrCQ7x4gYWiXpFppqS
         3sQ86Lb332gJvsITGXsfC6m97uqEFPY6UTC3plivt/97yYaX/o/D/Wt5jHx3CUBgQMg8
         BcwToCicg6f9lHlKXhDj7dZhR3PBBuAptD85ZCcqb7dToerAWP0vOacKecchzSPgc2pJ
         yFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ub36zKVh3A5wkEC7mjnfOzyg3ZRyIUoEtBmwTMIWVKc=;
        b=ckFp8miuCmxCtBU22anfULWyZxo/1hLa7Ad6j6IJ/gqNkXnaJN31LxXix4hcPrb5gn
         KM/JtGP/CSOAhy80GoMVuniDhQDn8N7TrC0PHJy8iqrmDesQIOiMKpgUu9YTgEP7n9Hk
         +crdLmh65x1ChEs9SXfhagq0Vx0/L1eYQonzURgo6ejVlY+Vih9Ukc5l11UkGDw0H3Nk
         bmBejPjqiNtiMgZnkSv8EXtjaxnEfCwCIDP9jc0a9pKVwUUy7RPAbu4LuNbw35MoRQlt
         wjCkSFAXh2wAtXkGgr3bedPIm31W4dxMwRyaBMiGa5A7pizCRSk3pK3Ac6HiyOOd/lkI
         C5OQ==
X-Gm-Message-State: APjAAAXtid8h6vIYbmbxAa2ZkteKp99keg+inmx5mOYRL7EYGtwyGatO
        tVOQfGSlHRINY6vKOeNywV/cxra5hPWsQ5xerak=
X-Google-Smtp-Source: APXvYqx/5RhXsJ41HLnixP8eBOafOIu4YzjqRn5u4BbIf4GXGeqH/zk0kXNZIWaV0+R8KGwlU4k7jPM8o+Hhphn9lVg=
X-Received: by 2002:ac2:599c:: with SMTP id w28mr1551748lfn.78.1578645398353;
 Fri, 10 Jan 2020 00:36:38 -0800 (PST)
MIME-Version: 1.0
References: <20200103033929.4956-1-zhenzhong.duan@gmail.com>
 <20200109184055.GI5603@zn.tnic> <20200109204638.GA523773@rani.riverdale.lan>
 <20200109205041.GJ5603@zn.tnic> <CAFH1YnNdmHD9rnriTVx-se-Z5MHsgUZ0jYWMrg6OYVjr4Ap+JQ@mail.gmail.com>
 <20200110082700.GA19453@zn.tnic>
In-Reply-To: <20200110082700.GA19453@zn.tnic>
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
Date:   Fri, 10 Jan 2020 16:36:26 +0800
Message-ID: <CAFH1YnOpuv3MOvJnkSoyhwgmTP_9uGyh0BzyscanRzhXrPbALg@mail.gmail.com>
Subject: Re: [PATCH v2] x86/boot/KASLR: Fix unused variable warning
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 4:27 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Jan 10, 2020 at 10:09:38AM +0800, Zhenzhong Duan wrote:
> > I indeed used additional parameters as below for daily build.
> > # make O=/build/kernel/ -j4 EXTRA_CFLAGS=-Wall binrpm-pkg
>
> And in no point in time it did occur to you that you should mention this
> important piece of information in your commit message so that a person
> looking at the patch knows how you triggered it?!?

I'm sorry on that. Will do next time!

Regards
Zhenzhong
