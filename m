Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872EBC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 06:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6093E208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 06:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tuO7I7Zg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgH1Glb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 02:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgH1Gla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 02:41:30 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBB6C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 23:41:30 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id w186so114044qkd.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 23:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=47u249WoOKvff2fyHs9WmY21fPfIUlTwd8Bs+zLxxKI=;
        b=tuO7I7ZgDLcZwUJYIM2xzStVY+afv0vrDAHi6sEz04TSFDyMBc9uFs85rX+9cMIhKu
         8u8t8LtXLFpWlHC70zrSj7U7+md0izdi3IiyEBGFZHDTgtYqoq+oJtaMMeqZ08ECBOOQ
         YD+65gNfZJd+t+8tNCCxPt+xRkOLFFnNP+3k8H/WSup0QIc+ecPk5v3MuzUtNYYi5HX4
         hE22DIhVGHxmapYftouW5rz0DZqGO5BRQafgmx2m3ww2+/TNJ0ql4gdplpxYyfnFCvr0
         Hbw9iRQ7kAVYUBioqGb8uyyziq4GKYGFEN6u8lWdGhqV0HzT6bJYgOODleytFbbSr6Bp
         44Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=47u249WoOKvff2fyHs9WmY21fPfIUlTwd8Bs+zLxxKI=;
        b=tNvh/zXdqUZpS/82Xo30GSektag48YvpSo7iEFZWWIShyZKHqZF8CE9oVOTrlPtpaY
         x6UB5mTcj+rYdziSr56sN6UxjwfZfW/tLQrG3ymYA4EduqwcD/S7X/l3roNEVie+EWzx
         nFY8gpQsVukLeKK3IeBqsmizDwfSmU2VxXutkf3gNYEdqjcBVQmwnrOLqog9/TaIz16i
         fv9Ss49VbV/PIToLTGYrL3B5tGRdOhyM+O6ePp0JnKpgyU24bGJiPfDNbYOTV6781/iG
         /1oG1x8ElekNjg+5TuQDA5AAV/rWczTFkX+wsSfxK/qE9lcSvVh3kQFuJwLcWTIhuguB
         vjrg==
X-Gm-Message-State: AOAM532yZMSfCbbNlzsA0Xs0KzhaYYy1GluZ3wVkEAz6YYDFhTBGw4sF
        LGdkTi6ldxwOs5c/wvBZCi4bLO3nA5CVy1VhlRA=
X-Google-Smtp-Source: ABdhPJwmTgQ9pZiwVAfemzWED7EnbtiuBJGQrE5kt0Kpnd/acZC/136IB/IJ07cdSPyrMiBF+7Y8/tyBj3+GDRe2eQY=
X-Received: by 2002:a37:6653:: with SMTP id a80mr12682735qkc.127.1598596889266;
 Thu, 27 Aug 2020 23:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200827180904.96399-1-ubizjak@gmail.com> <20200827201423.GD1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200827201423.GD1236603@ZenIV.linux.org.uk>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Fri, 28 Aug 2020 08:41:18 +0200
Message-ID: <CAFULd4ai5mWTSB_9-G+brpJJ6_3VFtqdcFm-4YtoNbhskXNctA@mail.gmail.com>
Subject: Re: [PATCH v2] x86: Use xorl %0,%0 in __get_user_asm
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 10:14 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Aug 27, 2020 at 08:09:04PM +0200, Uros Bizjak wrote:
> > xorl %0,%0 is equivalent to xorq %0,%0 as both will zero the
> > entire register.  Use xorl %0,%0 for all operand sizes to avoid
> > REX prefix byte when legacy registers are used and to avoid size
> > prefix byte when 16bit registers are used.
> >
> > Zeroing the full register is OK in this use case.  xorl %0,%0 also
> > breaks register dependency chains, avoiding potential partial
> > register stalls with 8 and 16bit operands.
>
> No objections, but talking about stalls is more than slightly
> ridiculous - we'd just taken a #PF, failed there, flipped
> pt_regs %rip to fixup section, returned from fault and are
> about to fail whatever syscall that had been; a stall here
> is really not an issue...

Should I submit a v3 with the offending sentence removed, or could I
just ask a committer to remove it on the fly?

Uros.
