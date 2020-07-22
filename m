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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0973CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 04:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D82CA207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 04:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7qkkZzB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbgGVEAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 00:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgGVEAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 00:00:48 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C22BC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 21:00:48 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 8so470976pjj.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 21:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xa3ZZYGnoP85/3zV1lZZil7QKFpmT3uyhbiDkzmb3pw=;
        b=d7qkkZzBvWH2EGTJl6d/xeU0OZVDjSrLJ0nJ9h+STGVXGF2EOVqbTk7CSjMjiON26V
         M0LwvjihL4Vm/tB7kntykC0gcYIEyVe4rJ+F4xJN7YKkmJ9pIZQ6WV8ABzM0AjYgNMSu
         /pSoTz+NB+wDP/hvAhMUfF3f+yh5RPf6Q6z3NYGDWAa/ruh7OkmiToFTCAcxl3AdZ2AR
         V7lBXEDYIeMkNe6eTzGsTfWP+LEgeSuFVXA4wr2BO40XXyyQgK8ZsILcysIJePJCb7Wq
         PA3492XWoXkhab/RVxAyvIcbXxc1NezI07/4N5tVAah3lUxgpE9pNLJuVwBG12azvHfi
         nqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xa3ZZYGnoP85/3zV1lZZil7QKFpmT3uyhbiDkzmb3pw=;
        b=QeqX36b47wRQTdvmT1Cszs7LnvZZnw2vdq4wDOAbRlsmMgdxlsoFCywGegSWO9uMMZ
         rGDCeGm0PfsYVi8j08AnqCMNxlSMG49R++4RNiCvs/JJh1dWLKarmzA0JHJb5TI/G4cp
         ZYB1QJH6rx4NgLlG5q7Wcz6Vb+A5avF+a7ejYHHgiNsg52VxQxV2JbVK05wQ9Xbfn1a6
         wISkololdkFMWdJHNTeszXXai3RrDWGB6bDjV0k8Ct++tL1iGtG6ZjwEVR6dgIvjpKqz
         aas71FPeMIz7Z/O/6+wPk7V0UfelxM2Pr+EHCFhEPc8J610w9cypIw2rNAghLTfptd/w
         vFrA==
X-Gm-Message-State: AOAM531Q8jZHzx/EjpCpyOvpGIt8ov5eqIPN9uw/uG3rpb8Q5+T0HCc0
        NgCm89uyqbLhCWJz0VzNqU5f1II2YC1uLiKbm3c=
X-Google-Smtp-Source: ABdhPJxMnoMbokZoyYXBiE1wvxWIhZnR0lnPeJYdNlzCOuI35DjncY/cX4KxwfkPDilk9thENiU4THsQoZzGthKL3D4=
X-Received: by 2002:a17:90a:20e9:: with SMTP id f96mr8129677pjg.13.1595390448025;
 Tue, 21 Jul 2020 21:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200721093748.26627-1-jcmvbkbc@gmail.com> <CAK7LNARtTZD5x3CYLVj48dwC9n7Z4kMx1gCLq3aD2_OfQKuXnA@mail.gmail.com>
In-Reply-To: <CAK7LNARtTZD5x3CYLVj48dwC9n7Z4kMx1gCLq3aD2_OfQKuXnA@mail.gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 21 Jul 2020 21:00:37 -0700
Message-ID: <CAMo8BfKS=nJi_BdOCYTzRutKBSHwZ8ZNOuk=+ZGD_mi6zwJ=Bw@mail.gmail.com>
Subject: Re: [PATCH v2] xtensa: add boot subdirectories targets to extra-y
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 5:53 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> On Tue, Jul 21, 2020 at 6:37 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
> > The commit 8fe87a92f262 ("kbuild: always create directories of targets")
> > exposed an issue in the xtensa makefiles that results in the following
> > build error in a clean directory:
>
> But, we need to fix this in the kbuild tree
> to retain the bisectability.
>
> I will insert the following before the offending commit.
> https://patchwork.kernel.org/patch/11676883/
>
> I used 'targets' instead of 'extra-y'
> because they are built on demand
> while building the final boot image.

Sure, please go ahead with your version.
Thank you for taking care of it.

-- Max
