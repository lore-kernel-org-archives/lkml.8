Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BF9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8701A20897
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ayFVSc4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404372AbgE1Pa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404312AbgE1Pa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:30:57 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9039BC08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 08:30:57 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id c3so2634054otr.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 08:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7zLzuBtkzzrfMI0aeJbgJ3mTynJAFHTEFBcwCOtpGB4=;
        b=ayFVSc4tknZaBb6kjVfuGoESqr8Xq6dcYEdaJ9EYB/CHDo1cRre8XtlVTe5Ac6PRjC
         bhiDLe1e23kYgPJgdCrpwN0W+110RYPe8+i7gPm242HiX69t4jlbF3hmMSPNWcToc6xT
         u3IgBxt/ZqJ9Xwe9XRpNtuaCzKx2bio+h5xssFgjiEeY5EfGfon589ZzpEmNMeQOeJYH
         5FY+lpQ22iRZUGCHey4q5F2Z+e0mvk1HL+HN4t4XQgj53TRZFqCv9WBowMLI3Yk2ETU1
         cY+JCeibtRIKFhk7HxBJz2BeJG4+w9/Ydhbqzp7eYwcSdj07sskhs7sSrkP4leBEEQhC
         IxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7zLzuBtkzzrfMI0aeJbgJ3mTynJAFHTEFBcwCOtpGB4=;
        b=XohXORmf2+d2DG3yL6cyhbDqoOLxW2l8B8DB93rAejy3xSOWFzuMk4XADCWCRqNMdr
         7vGrAPeYvQTJGa21sNbYcqqi3lbrVYkuDV8bcwXXMKZ0cYheY3so9GMjP2bQmsnFZFMv
         +z+yYp/h8Y1YYDdtEkkqzELayAf8G0IsUQln8iSjf3EqjGTyes/h3qNE5Dsm9ozwk3gQ
         87FOypiaDuZ0PSV70rokExo+P8rK6j17M723Mn7tJbMh8bzniWyDLrDFXU8nGGPsAFpy
         Vg60PfuN3gdD779JgaCbv26wG3Xusy9PsN8o1phTqf0+0DKCPZ1P3N12JxHdPS6VzPMZ
         +1iQ==
X-Gm-Message-State: AOAM531iMxJ4MpZoxC4r0p7hpUvYWoGLagJcO+rT4pq6cwSzp7FML1Yy
        1PIFGyzqvJCeypLy2mGpIccBLlC8nAXaMz8R++Qcyw==
X-Google-Smtp-Source: ABdhPJwjkzjon9XN9rYyLq693qHtAT1Y3xZql7tY5iWA/hIbOjBzUeAegR1TfYFKYdPnKTi/sCLSK//GO3XFncPdzgM=
X-Received: by 2002:a9d:27a3:: with SMTP id c32mr2828481otb.233.1590679855941;
 Thu, 28 May 2020 08:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <202005280727.lXn1VnTw%lkp@intel.com> <20200527235442.GC1805@zn.tnic>
 <20200528075900.GA236442@google.com> <20200528152218.npq53zode7hh7qh4@ltop.local>
In-Reply-To: <20200528152218.npq53zode7hh7qh4@ltop.local>
From:   Marco Elver <elver@google.com>
Date:   Thu, 28 May 2020 17:30:44 +0200
Message-ID: <CANpmjNPOu2rduGN-jbpMi77vsfz2J5q-EPfkvHqr48K9DEcmSQ@mail.gmail.com>
Subject: Re: [tip:locking/kcsan 12/12] /bin/bash: line 1: 61526 Segmentation
 fault sparse ...
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Borislav Petkov <bp@suse.de>, kbuild test robot <lkp@intel.com>,
        kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-sparse@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 at 17:22, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> On Thu, May 28, 2020 at 09:59:00AM +0200, Marco Elver wrote:
> >
> > Ouch. The below should be all we need, assuming it's the best we can do
> > for sparse right now.
>
> Upstream sparse should be OK with it now.

Very good, thank you! For 5.8 we probably still want the ifdef
__CHECKER__, otherwise we might break too many existing workflows. But
hopefully we can remove it again at some point. At the latest when the
kernel deprecates GCC 4.8 support, because then we can just remove the
whole unoptimized __unqual_scalar_typeof() definition.

Thanks,
-- Marco
