Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF082C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D7C120748
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593628796;
	bh=BzgN9CdkNj8KsNJpO6Dp3dgk25B6SZxEFrbbFo9+dlk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LOqCTLkldKxA1ff7thxhKQWm89vasdLeUmyeZrd47tSAFJMDTOUyb60hs3/YN/lth
	 7qxBO6jdHcqdA+r5Ct90gI+GT8jEZokwwtuczMvueOy4Scv8CYUX4CPD5dG6K+uGUM
	 HxFj17QnOitYN4hgr0MAOZ9I1ewrs6j3EUrQmWr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgGASjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 14:39:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbgGASjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 14:39:54 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A36A0208D5
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 18:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593628793;
        bh=BzgN9CdkNj8KsNJpO6Dp3dgk25B6SZxEFrbbFo9+dlk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EekpatgCfXAY5PVIXJOXKjXre1Wyt5kLnk69xj79naKsliUjFBna4Am1jKxDJ1RUB
         YwgGo3BT2S3Rx2ybuQVvOdWWxVpkyGDwgeTCGh2QZeVh0VyaK5E3Db8ddZOCtW/e4V
         jqfSmiN8gcKG4aikDeyjscuKc7uS8UTF14Y94hyM=
Received: by mail-wr1-f53.google.com with SMTP id j4so22725448wrp.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 11:39:53 -0700 (PDT)
X-Gm-Message-State: AOAM533QH2hxR//37kO+f8WPrD3lBPK78r+0FcAW8ozFRxfPq1H++aF+
        GCVXt2lM/TdmiyQ80atWbxs1W6Q5X4vKGpeVvJIQJA==
X-Google-Smtp-Source: ABdhPJxL9r2ocTMGAnClzir8rROoW17dgBhZ2sKyXqCKyH9ofutXZA7VisI5aNG7X5iBtvuS5HHHhEDpobjJAmSLQgA=
X-Received: by 2002:a5d:458a:: with SMTP id p10mr27429972wrq.184.1593628792155;
 Wed, 01 Jul 2020 11:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593191971.git.luto@kernel.org> <947880c41ade688ff4836f665d0c9fcaa9bd1201.1593191971.git.luto@kernel.org>
 <CAMzpN2iW4XD1Gsgq0ZeeH2eewLO+9Mk6eyk0LnbF-kP3v=smLg@mail.gmail.com>
In-Reply-To: <CAMzpN2iW4XD1Gsgq0ZeeH2eewLO+9Mk6eyk0LnbF-kP3v=smLg@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 1 Jul 2020 11:39:40 -0700
X-Gmail-Original-Message-ID: <CALCETrVy-Q4K04wmEPe5VeU=at2BL4b-bSFkoSU-BPbTaTB2Yg@mail.gmail.com>
Message-ID: <CALCETrVy-Q4K04wmEPe5VeU=at2BL4b-bSFkoSU-BPbTaTB2Yg@mail.gmail.com>
Subject: Re: [PATCH 3/6] x86/entry/64/compat: Fix Xen PV SYSENTER frame setup
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 8:42 AM Brian Gerst <brgerst@gmail.com> wrote:
>
> On Fri, Jun 26, 2020 at 1:30 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > The SYSENTER frame setup was nonsense.  It worked by accident
> > because the normal code into which the Xen asm jumped
> > (entry_SYSENTER_32/compat) threw away SP without touching the stack.
> > entry_SYSENTER_compat was recently modified such that it relied on
> > having a valid stack pointer, so now the Xen asm needs to invoke it
> > with a valid stack.
> >
> > Fix it up like SYSCALL: use the Xen-provided frame and skip the bare
> > metal prologue.
> >
> > Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > Cc: Juergen Gross <jgross@suse.com>
> > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > Cc: xen-devel@lists.xenproject.org
> > Fixes: 1c3e5d3f60e2 ("x86/entry: Make entry_64_compat.S objtool clean")
> > Signed-off-by: Andy Lutomirski <luto@kernel.org>
> > ---
> >  arch/x86/entry/entry_64_compat.S |  1 +
> >  arch/x86/xen/xen-asm_64.S        | 20 ++++++++++++++++----
> >  2 files changed, 17 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
> > index 7b9d8150f652..381a6de7de9c 100644
> > --- a/arch/x86/entry/entry_64_compat.S
> > +++ b/arch/x86/entry/entry_64_compat.S
> > @@ -79,6 +79,7 @@ SYM_CODE_START(entry_SYSENTER_compat)
> >         pushfq                          /* pt_regs->flags (except IF = 0) */
> >         pushq   $__USER32_CS            /* pt_regs->cs */
> >         pushq   $0                      /* pt_regs->ip = 0 (placeholder) */
> > +SYM_INNER_LABEL(entry_SYSENTER_compat_after_hwframe, SYM_L_GLOBAL)
>
> This skips over the section that truncates the syscall number to
> 32-bits.  The comments present some doubt that it is actually
> necessary, but the Xen path shouldn't differ from native.  That code
> should be moved after this new label.

Whoops.  I thought I caught that myself, but apparently not.  I'll fix it.

>
> --
> Brian Gerst
