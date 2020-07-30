Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0056C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 00:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFC1C2075D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 00:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596067819;
	bh=xaKQTiZQWTdE32MF04CatRnNTJi7jF1R2i2KEXicRJ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WA2/UtdZgbqTGCjw/WhyF2CPU0vKGT3p2v4lPDXLoXX0MRdFKfrhExkZBwnQB6DWt
	 JAZkRnhKEByxKs4VGz+17CyeKnVLDm7zLf1YOtPWzmshjXNPw9CbtwtEPeRK3m+L88
	 xmEAyUaAXNYPcbl1uAR2ty/1LZ4kCeuyWRZ+aP14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgG3AKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 20:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgG3AKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 20:10:18 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B837CC0619D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 17:10:17 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v4so17293771ljd.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 17:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5uaGB2xOYWa+jACqPIzmH4++Yk2MzFSBiFLA11OUW2E=;
        b=hEZFWlE7wFcKYKOakFk0ARR5rq45yVm7myS+H/aFfLygPk2/HtvTay9IOs8X986Au0
         ysId+nihcBhqm06rqs/so9xUnDDA9GxF8oz88kgI3tVsdQf2m5jR8R6WiMH0ND1+jRFf
         q0p1S8kKPPF01m/AsRNu6iCyH2Apvz8S+SYjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5uaGB2xOYWa+jACqPIzmH4++Yk2MzFSBiFLA11OUW2E=;
        b=dve4/0JGOMKt2ItdOHse4hqr35fJez0es7RoCQW0lYD/lpejmqjEzM+9HuZ0ElgU/a
         b+ZfxPImsGzTVcMIuI6DkAPja3aNJdpy4FG28YqGPIZJRR+n/fWYPlmEaaYoCe8Ppipu
         eny/DyJPwM+xhww8Fu+dMQ3YsHFFmESA52yUMjpE4WJRgKAcA2n5oEr/V9/8EduO3lME
         MHu9aKGQpfwYN2mXEKrWqM1Nlm0mQcIdVbNQBbkEDtdUJpuOyriKjIgovN8wos7SZkgt
         ol7p7JhXNbL9p885LxIlagYXoiJiFKRGSYaq3vrLGzFmtv5IY+NhuVXV6jVtRwZLqMnw
         GnhA==
X-Gm-Message-State: AOAM532EBWcL+3sLDXBZLIwWw7fK5675HO7lIBsNhBEZuJK/BWAKXxFd
        kpGZA0Wz3IOiO3Dm/7rRSCPFVPdcFQE=
X-Google-Smtp-Source: ABdhPJy94Btv8IURsQzzGPRu2rd9MXMqMVXz3+vjB1l+7SSu9IBrXmSohBJvbIMXXIFYxuryQIFN7g==
X-Received: by 2002:a2e:b0f0:: with SMTP id h16mr172148ljl.167.1596067815813;
        Wed, 29 Jul 2020 17:10:15 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id l15sm674706ljh.94.2020.07.29.17.10.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 17:10:14 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id j22so8105698lfm.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 17:10:14 -0700 (PDT)
X-Received: by 2002:a05:6512:3b7:: with SMTP id v23mr238005lfp.10.1596067814139;
 Wed, 29 Jul 2020 17:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200730090828.2349e159@canb.auug.org.au> <CAHk-=wjK8+12i8iDC41LXfZBcMjGsF+WyW_+ncPFmrexRT0yxw@mail.gmail.com>
In-Reply-To: <CAHk-=wjK8+12i8iDC41LXfZBcMjGsF+WyW_+ncPFmrexRT0yxw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Jul 2020 17:09:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whA7d4ug8-=TQWq_uR04+MqbfZemz+meFhfu_bCyGzvpw@mail.gmail.com>
Message-ID: <CAHk-=whA7d4ug8-=TQWq_uR04+MqbfZemz+meFhfu_bCyGzvpw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the origin tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Emese Revfy <re.emese@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 4:43 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ok, this shows a limitation of my allmodconfig testing (and all my
> normal builds) - no plugins. So that problem wasn't as obvious as it
> should have been.

Ok, that was easy to install and get the coverage, and now I see the error.

Except I still don't know the gcc plugins well enough to fix it at the
plugin level. And the gcc docs only talk about TREE_STATIC() for
functions, not for variables. Apparently variables should use
DECL_THIS_EXTERN or DECL_THIS_STATIC according to the docs I find, but
..

Removing the __latent_entropy marker obviously fixes things.

               Linus
