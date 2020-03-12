Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59551C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F45A2067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VEbK4Zom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgCLTUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 15:20:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47879 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726788AbgCLTUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 15:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584040815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zztdbDWxyXPT8TNxPiyAdSdtvIMmW1j3jVA5YEcZtvI=;
        b=VEbK4Zom1dgJwurIz+dDPyDJfNpap4rqIN8Hlq4rMAWgdpdL7xc2eHfmTCiIxSkwM328y1
        tRbfqxAns8jB2fwktkDBvsUZtIatlLVuiGm8XOxOSc96mFsy1ljOaMHv0dOnk62VWYwbzE
        89jikr4Crn580kBe5pxV17IdnDM69rI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-1NF4AupJPFyuGrwAEQ07hA-1; Thu, 12 Mar 2020 15:20:11 -0400
X-MC-Unique: 1NF4AupJPFyuGrwAEQ07hA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 664DCDB20;
        Thu, 12 Mar 2020 19:20:09 +0000 (UTC)
Received: from treble (ovpn-122-137.rdu2.redhat.com [10.10.122.137])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F3E019C6A;
        Thu, 12 Mar 2020 19:20:07 +0000 (UTC)
Date:   Thu, 12 Mar 2020 14:20:05 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Miroslav Benes <mbenes@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 13/14] x86/unwind/orc: Add more unwinder warnings
Message-ID: <20200312192005.cv56gzdwwjzttzzy@treble>
References: <cover.1584033751.git.jpoimboe@redhat.com>
 <45505e1a05d93f0b80a50868dc8d2c1570f92241.1584033751.git.jpoimboe@redhat.com>
 <CAG48ez2L5eBfU57_bFnSPSN7DUrocJB56wBLR6cE0e_5DdkURg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez2L5eBfU57_bFnSPSN7DUrocJB56wBLR6cE0e_5DdkURg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 08:12:16PM +0100, Jann Horn wrote:
> On Thu, Mar 12, 2020 at 6:31 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > Make sure warnings are displayed for all error scenarios (except when
> > encountering an empty unwind hint).
> [...]
> >         /* End-of-stack check for kernel threads: */
> >         if (orc->sp_reg == ORC_REG_UNDEFINED) {
> > -               if (!orc->end)
> > +               if (!orc->end) {
> > +                       /*
> > +                        * This is reported as an error for the caller, but
> > +                        * otherwise it isn't worth warning about.  In theory
> > +                        * it can only happen when hitting UNWIND_HINT_EMPTY in
> > +                        * entry code, close to a kernel exit point.
> > +                        */
> >                         goto err;
> 
> But UNWIND_HINT_EMPTY sets end=1, right? And this is the branch for
> end==0. What am I missing?

You're right.  I need to revisit that comment...

-- 
Josh

