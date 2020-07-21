Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19E7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 20:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9C642068F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 20:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595364937;
	bh=fWXpAajixoXQzkZAorBdMDMnISyjWes+GVbai7Tzj5w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=O+ETin8MvzuJQcYeOG0+r+KyPqyipsFF+ay7bHG074U/K3IPLuiELDxK2EgOCoPd0
	 eONVFXenhvl/2tdoAxqM059sidWNHqOzhGocx/G+m262NoM289MBCU3qyBD5sOQsiB
	 MzLDIZyb3hnCpllwQQqV/Xl4Fh11cNAM9OlZu4Ls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbgGUUzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 16:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGUUzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 16:55:35 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429D4C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 13:55:35 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id d17so180655ljl.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 13:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5KRiHv2XxTSwjqo2aYpnWdG35oO+7c1dy//AB5MhpN4=;
        b=Jj2v8BbF9aFwfyh4SlEc5xGD2Jkm85ro0pkQAN9Qh5SCte9chsHa0MTDGlrlrYOUnr
         qsrB/WGMv4QRtcmrjfHqV3qnwuFkg3bs24FSnkJ2Dr12TO2e4spYOc6bZ7QujxB0peZ5
         dJEib7JFK1g/8C0P5RZ8tSVuMh3jQsph/s/dM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5KRiHv2XxTSwjqo2aYpnWdG35oO+7c1dy//AB5MhpN4=;
        b=pfyjZLuHmR8PDixU8e7hSXQCvS1oyFMbVCrYBGCs0FU6XsIL/7CYd9FGDfrn2+9+p0
         UMZ2RqahauLm2m7Wd6unicAktEcY9ix59vPrZVIzbsWiBzyG4IpsXzmWjiKl7ksao7Xu
         9EtsSMeqHP2AVdL6rueccsA0Xfq10c59aag+ZvtIaDGSm8d7C9xe3siBULrCSjvPTMLm
         pQo/qiPr9c7M/R0QqSEXi1S5dLCh+mJB53FV19y6AUKYjhn6BVBprmEL3jBLMloXoILg
         JMPSXWOgPjRnzUOKMynJzfpyu1L4T3qazI6EXjWbuY2hS8AYtUUzMtaws/zyO38mg4f1
         WkfA==
X-Gm-Message-State: AOAM530IbwNkPJP9nPpfvm2uKsUmcBzKxhVyn/OrnV+28sX4x+H10HLj
        h7M6slaLWEYFbL/j1BZBjBY9S33/s/s=
X-Google-Smtp-Source: ABdhPJx6Duk/tw/gpG5hm7Ll0HwNdoDS+W7WWO7A28YcToNCeXo+Hm1Jir000oHGmZvErwKxfgN7Vg==
X-Received: by 2002:a2e:9254:: with SMTP id v20mr14526665ljg.282.1595364933496;
        Tue, 21 Jul 2020 13:55:33 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id z186sm3836131lfa.6.2020.07.21.13.55.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 13:55:32 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id k13so104086lfo.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 13:55:32 -0700 (PDT)
X-Received: by 2002:ac2:58d5:: with SMTP id u21mr4244433lfo.31.1595364932160;
 Tue, 21 Jul 2020 13:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200721202425.GA2786714@ZenIV.linux.org.uk> <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
 <20200721202549.4150745-4-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200721202549.4150745-4-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Jul 2020 13:55:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiYS3sHp9bvRn3KmkFKnK-Pb0ksL+-gRRHLK_ZjJqQf=w@mail.gmail.com>
Message-ID: <CAHk-=wiYS3sHp9bvRn3KmkFKnK-Pb0ksL+-gRRHLK_ZjJqQf=w@mail.gmail.com>
Subject: Re: [PATCH 04/18] csum_and_copy_..._user(): pass 0xffffffff instead
 of 0 as initial sum
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 1:25 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Preparation for the change of calling conventions; right now all
> callers pass 0 as initial sum.  Passing 0xffffffff instead yields
> the values comparable mod 0xffff and guarantees that 0 will not
> be returned on success.

This seems dangerous to me.

Maybe some implementation depends on the fact that they actually do
the csum 16 bits at a time, and never see an overflow in "int",
because they keep folding things.

You now break that assumption, and give it an initial value that the
csum code itself would never generate, and wouldn't handle right.

But I didn't check. Maybe we don't have anything that stupid in the kernel.

              Linus
