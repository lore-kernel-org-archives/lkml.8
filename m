Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCF5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 03:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2703920792
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 03:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="teU76l4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbgGVDyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 23:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731793AbgGVDyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 23:54:09 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53D9C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 20:54:09 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id p1so305979pls.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 20:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kv16/ZtjvsqzwhA67RXGlNKlymdPTZgYcbB4t9a+XQQ=;
        b=teU76l4onNGxGGAkHnfmRlYyyoNjrAl9sepXE+/Q09UB3kodYSezX/yBSJS+QYvmNa
         rveHjIAqpceNwjoChgvGHRZc/hnLc9EB7NI7dtGueridPlvY10dO856x0XkjS7tWECEE
         tVH7ySR5EdkQQtKFM62MYFe0IgX4VMKj2lpFGVI9keCTmxOTfV65woEDPjrsPLkvR5LJ
         x+FvkLyBB9D4Mw03wpJH6B+05Otq8WappntG5IUU2LIcCjclzqC8nJsEtGJkxPMhjFkG
         VoEhVcA/8PfcbbNxQYhyg0EcdY/nqDwa2oOpkh6w16ESpfoybMuLkNtPcJK5rM9EclS1
         yMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kv16/ZtjvsqzwhA67RXGlNKlymdPTZgYcbB4t9a+XQQ=;
        b=mNIgvyJcv3dmQV7NLE1Q7uI+wgtWC8PH1uPCveFDrR3ZoWs0/d2fX2HOF7o1BFBc0t
         v2huT6i20+fdinlmcLtGpeQkdpjjEHDYSGUaDrahxR1aRKGFPYXfVbR4GFtIJDEXvbY3
         ShkvXsQEw7K0apDqLEKfYbSDKVOR6HgB2QAtnljlwtnnyHdzbcNdc9cfS559+xeohv+3
         HIQ7ZLnDAKaXqpNVPecXojFWFm99sv8dtKx0VyS6BTUSqN/orQ9+LvFvUhbRgjc6nAOu
         W57ADDdFmMOng6G/IG0ko+4pTGkXflD9/7fvbpY/33cy5swjC2HP8eeGiNuDniqHxl01
         2IXw==
X-Gm-Message-State: AOAM5315QXBrlX9SSoN4ZnT3LF1bxuTx5rzV43rwlFlRSc2bu6v3x0Oz
        QIswX/3KBI/rO8OwmLuylAObcin0ph4XJ3r/CaA=
X-Google-Smtp-Source: ABdhPJwLXKXlBkbUAozr7t276aXIY29yYGr0q6JEskKQGLgYu10nsGdUytlaq69xIjhcH2qrdUFm/wzJ96H8ikmYiS4=
X-Received: by 2002:a17:90b:1045:: with SMTP id gq5mr8043357pjb.30.1595390049137;
 Tue, 21 Jul 2020 20:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200721220035.32584-1-jcmvbkbc@gmail.com> <20200721230426.GC2786714@ZenIV.linux.org.uk>
In-Reply-To: <20200721230426.GC2786714@ZenIV.linux.org.uk>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 21 Jul 2020 20:53:57 -0700
Message-ID: <CAMo8BfJeM0_MHcZWc4aZs0XVv9XH3vXwpiU0xjmU1G24fXV4tw@mail.gmail.com>
Subject: Re: [PATCH] xtensa: fix access check in csum_and_copy_from_user
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 4:04 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Jul 21, 2020 at 03:00:35PM -0700, Max Filippov wrote:
> > Commit d341659f470b ("xtensa: switch to providing
> > csum_and_copy_from_user()") introduced access check, but incorrectly
> > tested dst instead of src.
> > Fix access_ok argument in csum_and_copy_from_user.
>
> Applied, with apologies...  Which tree do you want it to go through?
> I'm dropping it into vfs.git#fixes, will send to Linus unless you
> prefer it to go some other way...

NP. Anything that will go into 5.8 is good.

-- 
Thanks.
-- Max
