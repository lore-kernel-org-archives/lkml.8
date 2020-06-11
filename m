Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA62C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66032206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KDmaFm8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgFKWin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 18:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgFKWim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 18:38:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BB8C03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 15:38:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s7so3743065ybg.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 15:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:message-id:date:subject:from:to;
        bh=vH1Jdl9UovulKp0PaaP+MmxVuSnD40skakQX91jUExE=;
        b=KDmaFm8vzCYT3oKJnfCXZq3hPMg+faO19e1YoSYNlIHIs0esE/+dqXfaTifXdemE9k
         KfEgE7d3yEidopuhWYozLHpqzOizTKa1yLAuvNmGlcgkArMpOkmQnrDD1Yh69iSLqdra
         JXf2ByohY57OdyYbHcvGLM7nOAG3jk1VOd4sejlGvSpGbzCXunaq/ZtaAqT8NsfzoZED
         3BcHVr3Np069USL5mYahnaNkgl1Za/wgaSC3iGYYD92VTwFMnYU10aeyPb/qjByW+aKs
         HU+jkn41kb+Q07j8pPxB0QiuGRG0umFJYERp4iZwEeDiQqJv4pJyjGMHe6lwKbsBQ5pZ
         qB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:message-id:date:subject:from:to;
        bh=vH1Jdl9UovulKp0PaaP+MmxVuSnD40skakQX91jUExE=;
        b=H0XhRX6WYAcEU/IH/f7NGo4LVPCzxlTT8dwR34blXdsVL0s8DN6I6j14LajyYP4aVF
         tn3VVshQnkwZ+xSat/T/eop3hnAcSJnmE3MsSx8S0HZzya7PojwgLNiB78Ume3lTQ7mg
         0i+XYerjonRo3nsUbAgkfw4wsxchy/lAHjZiFoL2FxPNJon6uh8SpvNiBhaeuBt8Igk8
         Lf27Y/RP7O7sove6D1GjpwwrKEBK/CBPKsOmetE6v4rX2GDK66+YHF3Qp/2uJnF9C4p9
         MffPlwo6uTNjdkKHj4YWySS4WgOB+aZyW3jsa9QD5/LMbHEQ+nUIxhb1aXm3x6a/JqyH
         jauQ==
X-Gm-Message-State: AOAM531AyjxfhIqrn2pMRONwV9rWRzvGbZssJtltKL+ZGmYjnHiUd0tH
        VkJI91pk1zSUSPU5UMnIlsBwXJgoyEbPSNViSaQ=
X-Google-Smtp-Source: ABdhPJyGVqLpmgZRZWU1edJu5iII4R7xxKzufvO+ZIrC8263xKyKyVQ90aQe9dJ4fcLE+PoPNsWq0TD8mfL77U0sFB4=
MIME-Version: 1.0
X-Received: by 2002:a25:d110:: with SMTP id i16mr15548576ybg.155.1591915120701;
 Thu, 11 Jun 2020 15:38:40 -0700 (PDT)
Message-ID: <00000000000048bfef05a7d69f21@google.com>
Date:   Thu, 11 Jun 2020 22:38:40 +0000
Subject: 
From:   <ndesaulniers@google.com>
To:     patch-notifications@ellerman.id.au, christophe.leroy@c-s.fr,
        segher@kernel.crashing.org, benh@kernel.crashing.org,
        paulus@samba.org, npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Date: Thu, 11 Jun 2020 15:38:38 -0700
From: Nick Desaulniers <ndesaulniers@google.com>
To: Michael Ellerman <patch-notifications@ellerman.id.au>,
	christophe.leroy@c-s.fr, segher@kernel.crashing.org
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, npiggin@gmail.com,
	segher@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH v4 1/2] powerpc/uaccess: Implement unsafe_put_user()
  using 'asm goto'
Message-ID: <20200611223838.GA60089@google.com>
References:  
<23e680624680a9a5405f4b88740d2596d4b17c26.1587143308.git.christophe.leroy@c-s.fr>
  <49YBKY13Szz9sT4@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49YBKY13Szz9sT4@ozlabs.org>

On Fri, May 29, 2020 at 02:24:16PM +1000, Michael Ellerman wrote:
> On Fri, 2020-04-17 at 17:08:51 UTC, Christophe Leroy wrote:
> > unsafe_put_user() is designed to take benefit of 'asm goto'.
> >
> > Instead of using the standard __put_user() approach and branch
> > based on the returned error, use 'asm goto' and make the
> > exception code branch directly to the error label. There is
> > no code anymore in the fixup section.
> >
> > This change significantly simplifies functions using
> > unsafe_put_user()
> ...
> >
> > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>

> Applied to powerpc topic/uaccess-ppc, thanks.

> https://git.kernel.org/powerpc/c/334710b1496af8a0960e70121f850e209c20958f

> cheers

Hello!  It seems this patch broke our ppc32 builds, and we had to
disable them [0]. :(

 From what I can tell, though Michael mentioned this was merged on May
29, but our CI of -next was green for ppc32 until June 4, then mainline
went red June 6.  So this patch only got 2 days of soak time before the
merge window opened.

A general issue with the -next workflow seems to be that patches get
different amounts of soak time.  For higher risk patches like this one,
can I please ask that they be help back a release if close to the merge
window?

Segher, Cristophe, I suspect Clang is missing support for the %L and %U
output templates [1]. I've implemented support for some of these before
in Clang via the documentation at [2], but these seem to be machine
specific? Can you please point me to documentation/unit tests/source for
these so that I can figure out what they should be doing, and look into
implementing them in Clang?

(Apologies for the tone off this email; I had typed up a nice fuller
report with links, but it seemed that mutt wrote out an empty postponed
file, and I kind of just want to put my laptop in the garbage right now.
I suspect our internal SMTP tool will also mess up some headers, but
lets see (Also, too lazy+angry right now to solve).)

[0] https://github.com/ClangBuiltLinux/continuous-integration/pull/279
[1] https://bugs.llvm.org/show_bug.cgi?id=46186
[2]  
https://gcc.gnu.org/onlinedocs/gccint/Output-Template.html#Output-Template
