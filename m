Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9629BC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 05:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C147206C9
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 05:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qT/uDgXW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgIDFmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 01:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgIDFmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 01:42:32 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027B4C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 22:42:32 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id d2so3233073lfj.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 22:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xWE10/K9CdFjBv2+wzy4YEN9T1BSrnV8vM6ktgt0toM=;
        b=qT/uDgXWPcQsd24EQCgcu4CWbwJIAUTNgfme8/lkOFA42DoVWt1PbhTKdJAeq+lLYh
         t3br+09SgcUwwvnFrR3qvf3CLAl2mRGkSHYS3Pr6pvhid2+AFFTfqbHiwovz8u+I3fj5
         pb4I2pOBtRqpnuNAhG47SGVDkdrESBRMo3Y8npnZ14sYI/pSL7Zh3k95HjYfVSCLnbC2
         VG+NdoOnziBzWvtu3Kgwo1B7x0etM+Bw1Ipzmo7xWiLEac7f9UGsB/X2bJpMBlEfR0fe
         JSL8+DgFhkWYr+/0eEheK16utPiKIzEBDwc9fFp90jIwewySB+deOe6TKVKPO6e2HR+v
         693Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xWE10/K9CdFjBv2+wzy4YEN9T1BSrnV8vM6ktgt0toM=;
        b=Ut/BX0Ts3Ibe0XpVWy8IrLG+G2XjyVPTOU0SwLdG7ylIXQfY3sHf537DKEq/Hr2EP1
         jDS7gG9DCYGBiEAC1OkAOozpuaDo/SJt20nC7bFXBRxNknZDmoJOUnB4hcLOntSIbHyO
         7j8OumpQDLCk0ATrJLzl/NJQCn01WJeJsGf8iuHRBJSQMDcUI+Sex7qeW9Gc3SgMGTI5
         yAYUpXF4jGDDy/JrkKabaC/t7IyF+n5czwMgE+lbQg6K3t29o9pGXLkSUtASrQFsJLNo
         9XTmC+tsLqutmIZeCSnoQlRYG7KGjopnPT7IwWusyWqsNJFWFyxFqpJ9pdXz3pVP07/V
         HqyA==
X-Gm-Message-State: AOAM531faUJ9qkP/SZzLz3LDpfTxx8AhAQv6JFbi8EIcCWW3HL9p5hTu
        UkkelWaNmEDc2j+TZsJ78O9VQ9cc3EoJ5ouXJ/I=
X-Google-Smtp-Source: ABdhPJzD7zGzQHYFJeDWLorqEQq4ojs3xApgUz5COGWUj77dfYdgIGVzPuxgohSjOE0S2prMRS2X6XSProsry3Km0UI=
X-Received: by 2002:ac2:44b7:: with SMTP id c23mr3019396lfm.128.1599198150454;
 Thu, 03 Sep 2020 22:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200902225911.209899-1-ndesaulniers@google.com>
 <CA+icZUXCLyGmYCnHSBJ+8s5QdbPRr+fsfpW43M7pYFEDFOOdJA@mail.gmail.com> <20200903172847.GA1928336@ubuntu-n2-xlarge-x86>
In-Reply-To: <20200903172847.GA1928336@ubuntu-n2-xlarge-x86>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 4 Sep 2020 07:42:19 +0200
Message-ID: <CANiq72nmm=pcaL1Vn+G3v3+Q8M=EcRNvvsFM9TG5soCpWzJ9sg@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] set clang minimum version to 10.0.1
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 3, 2020 at 7:28 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> I would say this should go through either Andrew or Masahiro. We do not
> have a formal git tree plus I believe there are other things that need
> to happen before we can push stuff to Linus.

Note that a git.kernel.org repo/account isn't required to send PRs.
The hard requirement is getting your keys signed. Putting stuff into
-next is also important.

> Given that this is not a regression or a bug fix, it should go into 5.10
> in my opinion.

It is a bit late, yeah.

Cheers,
Miguel
