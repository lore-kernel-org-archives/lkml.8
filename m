Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA339C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DDEF2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ewi80sWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgFRXeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 19:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgFRXeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 19:34:04 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B50C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 16:34:02 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d4so3664713pgk.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 16:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vzMoTDgws5PlJ9TvYEmWHyaZ7Qpk9jmHSWqWqw0ANTA=;
        b=Ewi80sWV0n+/DP/17c63Vb7jKadOV6GgvQKsky4OaGKjTCttb5aZmXV/DCO2N6Yg0I
         rUCGjVS7EuVlN5R12i7QA/VSKcv+O59aYhF2d3schmJmPZa0jzjhVAekNFxSIfqSNnIN
         35U8t1kWy7RnLJMTKWOtvvLRzLtyRm4dOLhJNK7V6o3tSFCJo9uo8qRmlCcvHXpNC+Lk
         X4+oMy9blcsGQ+Ft5/1GDNWFR2h4anquYBU3tqvS4sL73LwkNeNV/gGRWRREPpix7yGk
         CAvEYZK4bggM4XJLHThuSWxUmxzwU5zt9uiQRHADkqAthYcnS5ZWfV+cqMkBNyR8BgEi
         5mKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vzMoTDgws5PlJ9TvYEmWHyaZ7Qpk9jmHSWqWqw0ANTA=;
        b=KeQ/Q1eN5wKCU1lYzOjm6nimGmwQ2AfvcPvp0pGvF7TzEQD+Bdu7PWqBOgEahj9UiG
         jIgvf+QcVvooMVHQNjTcEaZIfRq3rZQSWUTzllvceveBmxllF2BGB5odSh44sT659fUJ
         Le46JeTcrqGdMmgZeXQ0dP0hXSA8yGPiLaVS1+N8VYs0c3ces2R2x+VFNoEOa/dwxoqk
         G8X+MxBQGaLN02skyXSyKaB+AKVR4Qu1h9lDk/5JHrJkbKcsfLZd9h2oaulAeCY9SPOY
         74UoFFsYFgwTSR0oWHPStMHLHDSVRTjqRcuqF8WPXVxTI4LsGcO87gJocSxHU0aNbYw9
         tCWg==
X-Gm-Message-State: AOAM530ezEU+U9a6OOgtEvqC18hpdXkoiQdCma0RvIawqMRh10XUL771
        wgumrehrS2QEiKJz8eEPDNHOXdxwTUu/MEQq9VxA1xZ4
X-Google-Smtp-Source: ABdhPJylpCbzSialaLk8pB9ppDsJx1vLI57MrnJmVY8Ehtzn3RslDcnj32ZNhbjYtsX0HvPbYrYBOCZ1vsdRWTR/ZpE=
X-Received: by 2002:a63:a119:: with SMTP id b25mr772906pgf.10.1592523242019;
 Thu, 18 Jun 2020 16:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590079968.git.christophe.leroy@csgroup.eu>
 <8c593895e2cb57d232d85ce4d8c3a1aa7f0869cc.1590079968.git.christophe.leroy@csgroup.eu>
 <20200616002720.GA1307277@ubuntu-n2-xlarge-x86> <68503e5e-7456-b81c-e43d-27cb331a4b72@xilinx.com>
 <20200616181630.GA3403678@ubuntu-n2-xlarge-x86> <50fb2dd6-4e8f-a550-6eda-073beb86f2ff@xilinx.com>
 <87bllidmk4.fsf@mpe.ellerman.id.au> <878sgmdmcv.fsf@mpe.ellerman.id.au>
 <CAKwvOdnkcjLGay0jdQ77kHTmKhE56F9jvzh01XWwEE8rjbhLAA@mail.gmail.com>
 <87tuz9ci7e.fsf@mpe.ellerman.id.au> <20200618031622.GA195@Ryzen-9-3900X.localdomain>
In-Reply-To: <20200618031622.GA195@Ryzen-9-3900X.localdomain>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 18 Jun 2020 16:33:50 -0700
Message-ID: <CAKwvOdnGPFndupGj0dZq8xfepYahVvsASGGbS10Ki19YmbqZHQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/13] powerpc: Remove Xilinx PPC405/PPC440 support
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <michal.simek@xilinx.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Greg Thelen <gthelen@google.com>,
        Robert Lippert <rlippert@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 8:16 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Admittedly, we really do not have many PowerPC experts in our
> organization

Not with that attitude. :P /s
https://www.youtube.com/watch?v=Kck_upSlx60

> so we are supporting it on a "best effort" basis, which
> often involves using whatever knowledge is floating around or can be
> gained from interactions such as this :) so thank you for that!

That said, Google does have a significant amount of POWER machines in
the fleet used by our "prodkernel" teams.  Anecdotally, I've been
getting cc'ed on more and more internal bugs regarding ppc+clang+linux
kernels.  "prodkernel" is still in the process of moving a massive
fleet over to clang built kernels, but ppc is very important to
Google.  ppc32...I'm not so sure...let me ask some of our ppc folks
more about which uarch's and word sizes they really care about...

--
Thanks,
~Nick Desaulniers
