Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13926C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0E0920787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NuIYTIiK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbgGVSP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgGVSP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:15:27 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D3BC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:15:27 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a1so2344797edt.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+SReuFYVGjLRX5r5xj5YpIfyUC4xzq9ishSeECc8oc0=;
        b=NuIYTIiKaQc1CsD0KXBC5Yhe7GX8yMqprWzzn8wTzzFy0PzxzGczcaGqdeb4YKryxx
         gDGjWE4EW1L+rsFD2ozcBAmUlUjqvHcfmeZTjicgfj/G2zjx+4h3skQn3dcUWxhf/HGA
         34blS1DVtvnecxc1FIU189JqspE7/zPXYiT+P+DU7dpREkeZiHpbse3hobDGVMvtNzbD
         KrJtaaqMOlcqXc8kDvP2uFSCHPNCwCqMldtmcSw2My/VgU3ZZIe/FRFIcNJ7iFkbw6cy
         utbf98JYdXdwWcsEetVbf/K56+HhaYsRX5rkPaO+4MJKlgRMduJzLaAbfn7bk7LRFtsA
         Fi8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+SReuFYVGjLRX5r5xj5YpIfyUC4xzq9ishSeECc8oc0=;
        b=glUuiAqfrjO8mvqv0N2vF7J20xaOadXxBEKmhG2DifPp7kZil1e9lmC/+Ns+9ubi8l
         q0YBB2pjBzGIqwiI5k7A4xUGbdOJzucsnQLLrE08dMctgdlaPE6heI8LI0bPHHWuYDXc
         rS1FNzHEIN4AMCzphphv3+1UTQ4v0JwZVdJQ87jwGJRcBx4076bdeWd8TfYVdyL4LL1C
         IeHvInKrxeDwVIMwyzQZvK2nkEa6XsASTB9NKLp8Wp8usOZJYsL8mg25UwDEtDobGszu
         D7qB+3lnSWWyscwJAIHm3TNPtWtRdqBXQ3B+nxPqHCfr6J2RR7DsSMbPLObfeBentDUD
         3g4g==
X-Gm-Message-State: AOAM533yEvl4fqXZvP9B/YpqkxsIWPwg6FrGOYvRzFcpPQellDozNTeE
        O6Nz0w5Nn/t9V6TBQlje9BgsYKJ1QCPk7+3+k0Umdg==
X-Google-Smtp-Source: ABdhPJxrA+hjx0Q1mNxWSy2JCrzqouCMw/jbe01R8hqj3aXOsgJE0QWv/Xu+8L2SG1RhOKQ8MRvH9R8RbRpmUUnfeh4=
X-Received: by 2002:a50:931e:: with SMTP id m30mr677030eda.341.1595441726019;
 Wed, 22 Jul 2020 11:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-12-samitolvanen@google.com> <20200717202620.GA768846@bjorn-Precision-5520>
In-Reply-To: <20200717202620.GA768846@bjorn-Precision-5520>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 22 Jul 2020 11:15:14 -0700
Message-ID: <CABCJKudTCwt3J19u8Em493a3Z9J2SD+imtVZTpz5cPv7Wza5iQ@mail.gmail.com>
Subject: Re: [PATCH 11/22] pci: lto: fix PREL32 relocations
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Fri, Jul 17, 2020 at 1:26 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> OK by me, but please update the subject to match convention:
>
>   PCI: Fix PREL32 relocations for LTO
>
> and include a hint in the commit log about what LTO is.  At least
> expand the initialism once.  Googling for "LTO" isn't very useful.
>
>   With Clang's Link Time Optimization (LTO), the compiler ... ?

Sure, I'll change this in the next version. Thanks for taking a look!

Sami
