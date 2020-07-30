Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064DAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 02:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1F7821744
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 02:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596075199;
	bh=M7nWPQXiWh4LOvNhh3KyS6XtidW7bcB54FsRrjSOsFA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=f/tiJOQLaHHk/TXsXEpGOvAM7277Y9wHFSg/exRMssEfdBaCHo4SPKfMbrnlb6ArU
	 Yo5+4MzhGxGWP01Bn6nZ869OFhmaCX7w/6VLpqkNvkHqPWIOhgQie+tZXgRj/Ohznr
	 XBYmib6do0xbmzyXWY+yK21mHE+gVrm6Wu4lSCN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgG3CNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 22:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgG3CNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 22:13:18 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FA4C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 19:13:17 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b25so27191094ljp.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 19:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cbyxg+vBVnUwNhF6wHPJRbrQKhEXP4EDZkqjL33ulC8=;
        b=bzgFXToNOzcaLAmgIt+T0m4TY8UlRWwL9ZmbMxXoi7Js+hwyr/1u527NYpJ0AzFfwp
         hR5A96iyL6BVxwjsCMm8WMG0KOXib7CoqXeQdc3Qq3gFRDaIBI1zPPUF4i1SRUCaa3+7
         C2+L1V+r5jNUWwAbW4hfwvrpdKEpd+3mzaOtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cbyxg+vBVnUwNhF6wHPJRbrQKhEXP4EDZkqjL33ulC8=;
        b=U7DXfcCm+AJWUbepYtEsn6jw1B0k8nNC5zqkxzuOkOkDuAV2wsMpp9SZqbFajS7PU0
         z6HyWoQPwJzx4hmDaEdLFd7VrUy0YfQGMbl3j85I+NCycV6Fo0uDAD/PM4ntTaR1ZUWV
         lequ7FyxteG5thso1vgexS7dahvhbezPlyIxNKOLW4oI8eR3Ba4ZwpTebMa5czLahESd
         whW4QqzSDmagF4cqtxNzYMGTl+7pweI4EjQf7oyDjjFVlPtpc8i19IqZW9f062D+8hs0
         x8oOtuWZgHGp0jyhjfza7GCKY/yWuWuFum5LQAwBkxD7yyhgyI6PCOkdy9EjVxCGqo8k
         LZOw==
X-Gm-Message-State: AOAM530xXDNn1oWp0ncc40fNPuNzcdm+4gS/4PzbYVl1cBzw49lxQIoL
        5el7raLdWmU6//po0Yp5upEajYPDTjc=
X-Google-Smtp-Source: ABdhPJxKPhERjeiRW3ouwNEpqNF6X7ERNPlE2+OjCNCjFJZ+VQTMZswPVcJ2VzkmSsVOzqEqSESl7g==
X-Received: by 2002:a2e:9943:: with SMTP id r3mr322967ljj.280.1596075195846;
        Wed, 29 Jul 2020 19:13:15 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id y26sm717818ljm.132.2020.07.29.19.13.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 19:13:14 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id c3so6945059lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 19:13:14 -0700 (PDT)
X-Received: by 2002:ac2:46d0:: with SMTP id p16mr223536lfo.142.1596075194006;
 Wed, 29 Jul 2020 19:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200730090828.2349e159@canb.auug.org.au> <CAHk-=wjK8+12i8iDC41LXfZBcMjGsF+WyW_+ncPFmrexRT0yxw@mail.gmail.com>
 <CAHk-=whA7d4ug8-=TQWq_uR04+MqbfZemz+meFhfu_bCyGzvpw@mail.gmail.com>
In-Reply-To: <CAHk-=whA7d4ug8-=TQWq_uR04+MqbfZemz+meFhfu_bCyGzvpw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Jul 2020 19:12:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiFLA=TeG903JHPvRHSoMd=mE=7EC0OMajs+bo014A4Lw@mail.gmail.com>
Message-ID: <CAHk-=wiFLA=TeG903JHPvRHSoMd=mE=7EC0OMajs+bo014A4Lw@mail.gmail.com>
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

On Wed, Jul 29, 2020 at 5:09 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Removing the __latent_entropy marker obviously fixes things.

Ok, I did that for now. I spent a few minutes looking at the gcc
plugin in case I'd be hit by some sudden stroke of genius, but that
didn't happen, so let's avoid the issue until somebody who knows the
gcc plugins better can come up with what the right solution is.

            Linus
