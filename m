Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AF7C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 07:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D48D20714
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 07:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JL8LzWsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgH3H35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 03:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgH3H34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 03:29:56 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9FEC061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 00:29:55 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l17so1284291edq.12
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 00:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pvLwOF27u2HMyFoAOh2OBgXTpYXjzE8rGPa+77xJpBc=;
        b=JL8LzWsJsirEeaoKaU30Dg0fcGAZgIGhHvcS0+J54+OtgE8m8Y55hpR0hxL2fIeIq3
         ehREgGizEd7Hk1GhEwRw3gPQ3abRlIsn47Z75DQOugxwKThyLU2BPUgTF/S3AOFipPim
         Ki1m+Lit/0NGdV2+LWFN44Bd8T6ym2tNGx6RcUWcViyJAml4CGrx6UOc60+rTVrBpeXB
         p8Tn4FN7Oy+QP5jqSH0KtDVzKPhdZeOOWbO4fofybQjfhsrqmXEiXqp1aA/29cLO6pEV
         PwQjXZ8Qcizs6QgpD34I05Cn3shWSNjjYFBm6TPlxqsDFgbrLygOCbNLHcYOvG0UFqfJ
         XbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pvLwOF27u2HMyFoAOh2OBgXTpYXjzE8rGPa+77xJpBc=;
        b=GpIL0XANF9XtbylpvqR0MnvsOwFnFE4EaZb9OzKokQyfs1nmw8nEw/qKQFm0rE+6x8
         bxri59Xa4tfP+Qfs+HBANd0pXB5wJLq5n5THKvNYLqIhzwMyXhOydT5udi2nsSR60xZp
         QKjLwY0LC+b3uDFK4Fceee0TKgzjQ3nusUmYLkfBsJRWmB4HhDFYav64Yd5gcBeyQzDE
         YJgFiEzJEqsoFRMZ5EHeTc76Nj4pv6CZZPy4nB1YQVSoW8mKvACLrysL8G+Vk/wo75Rc
         UdBGWY3nVwgkYe9j+NMylf0RVoB1Z7BcWZJWawHm8EvtFxg34KFOvBXvXsZ8Xu8+u2c4
         zjNA==
X-Gm-Message-State: AOAM531rlwES2WiO7JaZ4ZITJgXMwg8A/JkNL1/nkYh4YHnPxIBafj75
        MmL5jbeyBuwzVahtyjENjki6O9t7MDfACqhrv24=
X-Google-Smtp-Source: ABdhPJzpjX/dvRAjzpvW+yv60CtJiWvJMVSrjPnUTdFXEodPoY1oZJcne4hW0niFp5o6pAXGQQ7YH9JxgEw82A8Lbqs=
X-Received: by 2002:a05:6402:1210:: with SMTP id c16mr6354034edw.71.1598772593486;
 Sun, 30 Aug 2020 00:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <b91f2285-48b1-67bd-69b2-85fd9decafcf@infradead.org>
In-Reply-To: <b91f2285-48b1-67bd-69b2-85fd9decafcf@infradead.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Sun, 30 Aug 2020 00:29:43 -0700
Message-ID: <CAMo8BfLNFQ+kzK8JN=5mLAMFCMB722nWQ2qVbsei0oCrgT7=Fg@mail.gmail.com>
Subject: Re: [PATCH trivial] xtensa: fix Kconfig typo
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 10:57 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Correct trivial typo (ful -> full).
>
> Fixes: 76743c0e0915 ("xtensa: move kernel memory layout to platform options")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-xtensa@linux-xtensa.org
> Cc: Jiri Kosina <trivial@kernel.org>
> ---
>  arch/xtensa/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
