Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6ABCC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A207823B24
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lPClLCvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgHOVkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgHOVkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:40:42 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B9EC03D1D0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 14:30:43 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u128so6242998pfb.6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 14:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ORZYHt9ecrzKMNgyspN1PBptpkMsBZp4x/btzZwFfNw=;
        b=lPClLCvyiXS+vZ3mRzNc/FiH6L8tgYs8RLI0q7i9kt/AQhBBuFvmlo2fEvNv5K3srP
         YXqsA1qkuHGCHSCTZTVpyl4W/0I6/x2DLlEQkLiHpDxEyzCI4WS38s0ByD4HYRHKq0Qv
         h4EX4r9WqELVLy5edF4ih81aLPRAzfGHeLYdo/UZfAvGc+8CyLMEnq4gppocQSECcCin
         2IfwO8e/wWEkm0p2gbrrhY/hcZFRTxQWGLfXZodUg589SIB7cWku1A6MC4HgOyM3l1Tf
         kUF+HQkAySqNq7taW1zeVhsajkdS/56zDKpo9YtfcRXd2SenkPtqZEgddkJmKT+/LycJ
         Db6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ORZYHt9ecrzKMNgyspN1PBptpkMsBZp4x/btzZwFfNw=;
        b=avkCV5kYBljKylBR7Wun+L6vVeFGmE2ChqevHGVtmbpEIUWKYNJx4UpgkmqfKra7/Y
         vXe/HmuRwyLkXb03s5q474Z59hvTT0jhuFweRZI346R1YQ8gXUw+5ecPG7FxWvWxK3I1
         96bUX3M+IEZkvi9wQWpaRoUj0CB1ib5aNYaLeC+ic0KAzJdAMK2ok+MtAR5WuBOH028V
         zuY17L4L9Ae1HtcdiH/9yegBo4hN1rD6tgOg6TCRTG47VffeGp3srDMJSOjdkZGEg04r
         +QWUUIAHm35fX8l9eACZYxJTe3s0T5Id6bf8ytOQt+OUwYvSUr+E2Ob3DiQDIMy57DQ9
         2FSw==
X-Gm-Message-State: AOAM5325COErMY2NjXaOa6hKCpKtJkWw1rl51y7AJDMSYj7jrxjoz8Zq
        UcLuv63u5jAl+gAL4TbTQlaw9OzX9198mnS5VQYEhg==
X-Google-Smtp-Source: ABdhPJyGVBSih5D1rMueRL34SkoQOVR4ObJ9OADrWJVIdsuwnDu2rdBGdvxWHpmI4b+0XZD1iry4j74RRH8Y8sT/Uxo=
X-Received: by 2002:aa7:96e5:: with SMTP id i5mr3350792pfq.108.1597527043233;
 Sat, 15 Aug 2020 14:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <15f52e9b0e50296aba35871bc1575a684c4a258a.camel@perches.com>
 <CAKwvOd=8C94K-9VCqdCn9FXiyfDhKxMu=4AGem1bGgp8m6z0fw@mail.gmail.com> <CAHk-=wjjHN32BXdqu1iP8WSZoqdGPDDiqVLUbBgYG+=JO3MJCw@mail.gmail.com>
In-Reply-To: <CAHk-=wjjHN32BXdqu1iP8WSZoqdGPDDiqVLUbBgYG+=JO3MJCw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Sat, 15 Aug 2020 14:30:32 -0700
Message-ID: <CAKwvOdm4NfdtVs-g7CTfHJcViXpeoF80B1j1weced4T+gfKN9w@mail.gmail.com>
Subject: Re: [PATCH] genksyms: keywords: Use __restrict not _restrict
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joe Perches <joe@perches.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 8:06 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It goes back to 2003 and the original keywords.gperf file, see
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=46bd1da672d66ccd8a639d3c1f8a166048cca608

Interesting, I was wondering why upstream development on genksyms had
stopped a long time ago.  That commit provides more context.
-- 
Thanks,
~Nick Desaulniers
