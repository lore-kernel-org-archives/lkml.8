Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4FAC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 07:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53A572072D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 07:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QUXLlaMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgHaHOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 03:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgHaHOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 03:14:05 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FD3C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 00:14:04 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g96so1918354otb.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 00:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qgZs/VQ839tlF6XpObbQqftfbwRMB7KiDGtBHT54oHg=;
        b=QUXLlaMc9s08DIBhu191N5Ae8DUOsNN8mICoLuHBPp3oYNEoAyLVx1gXf+f+wA9ed7
         UDs7As+bafJ+GUkrnwRBLQeHU5QJWVw4ri3qFdqx4YdTjgYINeC2s1+k+0ooA7BgAcBK
         ghzbXDB/94LMiSb5tWXUtPEIxuTFQF+af1ZILYaNHTxmoSUNQR4G4/Q7kzp/jat1tKYW
         C7gupKoqYuu0U4WAwb9+W/bbaSCRjU+CjGl9al+2ECglSXTJWY3I0Vs07daizg7hBuh0
         EH3fN0V7JXGZ1cTLgDfedRS0vY/+JlMJ4VnJycreqVckM8W1kMJ2pJ5gSQJgx9yXxCTc
         XkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qgZs/VQ839tlF6XpObbQqftfbwRMB7KiDGtBHT54oHg=;
        b=ieTNrQavxly3TSFnovaJIm8G+AXE1Xv1no2cupaUnunegTe6pdNljuDOPShURHvJLA
         LBvdQySGoDdS3e6v9h/qStIrdd5jOpfGR1icgM7EhWJhXqpdoXks3OMheORhU3ia12ud
         9tr4cPTq59eWGKhHg2HVhvmGunNMW2ffNoEjqeBIDWkBGx4Y4z1uGBr1+kD7NhGvFE+F
         uLRSopwbxK3en/YrosBjp6OJnqeSQ1Lh+cs5iEZ6ALFCjZuaxibpSrMhiG2hlIgpOWxb
         V9bJkJTibsKRyCwQFUo4HVjIqtyLZW4cerUxb8llbI+2NeT/VYe8fwtEvl0BRv6gQLAa
         86RQ==
X-Gm-Message-State: AOAM530FZaNhviV7B/6VTLCdmzUjgmPPgeJ7fEsMkgKyhUY6nVAuZAdr
        LpSqaoSyFCIHUcWFFz6aMJVgZazsNE3KmT9bs9m4hQ==
X-Google-Smtp-Source: ABdhPJzVUckTNcf+6/d/nfahPDWR6MmytqqhwXTbzxbat1nN6EGh4BMb6quz/swi6Zscp+w9ambqJD/4E9JkJmeWaTc=
X-Received: by 2002:a9d:522:: with SMTP id 31mr188244otw.33.1598858043090;
 Mon, 31 Aug 2020 00:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1598598459.git.zong.li@sifive.com> <3f1f693147f0b62f19f4a44b8e8ef3d5bde23352.1598598459.git.zong.li@sifive.com>
 <CAOJsxLHOvvt8WGQUynGkLxZCA4OQQ+KgxxJJD7s_iP8Pxf-Omg@mail.gmail.com>
 <CANXhq0r2jg_fVZJE0shquGc25QNgenL+Qq6HRUBXEYPSf=QcFQ@mail.gmail.com> <CAOJsxLF_+0eg6zU=CFwnN+pc75jF4aqvUqog5z18wfG4WOKoDQ@mail.gmail.com>
In-Reply-To: <CAOJsxLF_+0eg6zU=CFwnN+pc75jF4aqvUqog5z18wfG4WOKoDQ@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 31 Aug 2020 15:13:52 +0800
Message-ID: <CANXhq0pEEaHirF6N7J7KDcnrqyyp0pZR75uxqSs0UN7tvosz8g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] riscv: Set more data to cacheinfo
To:     Pekka Enberg <penberg@gmail.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 3:00 PM Pekka Enberg <penberg@gmail.com> wrote:
>
> Hi,
>
> On Mon, Aug 31, 2020 at 9:15 AM Zong Li <zong.li@sifive.com> wrote:
> > If the sets is one, it means that the cache is fully associative, then
> > we don't need to fill the ways number, just keep way number as zero,
> > so here we want to find the fully associative case first and make the
> > if expression fail at the beginning. We might also rewrite it as
> > follow:
>
> [snip]
>
> Thanks for the explanation! The rewritten version is much easier to
> read, at least to me.
>

Let me change it for readability in the next version, thanks.

> - Pekka
