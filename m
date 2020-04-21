Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E15C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CC68206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587489644;
	bh=GyFjRzvYxdD4ZwLuuOBRPWTOr25c6+hKcxBTYD9OxxE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Y/PXUs42sQdkYIl9BgxL2Zy7+pqYnz8IEhMIDM4lcwhTpyJ05BVMl45NQkLhcagiP
	 BARHcbARBjmw6hDBO7Ot1wzd/EMBt44c0zENUc8sqZpXHJdKfJhvWZuVqki2sNIDcl
	 WOPgUUT8S0LMfyfMdIQrpQLE96ap67IhlfnoyDzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgDURUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 13:20:43 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:52159 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbgDURUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 13:20:42 -0400
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 03LHKKav006129;
        Wed, 22 Apr 2020 02:20:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 03LHKKav006129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587489621;
        bh=IZDOvI93ZiEs2ySqKJLK+IJjqkugZDH4i3dH/lP0Wc4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q2K4Eqxi9WkQpZ3H5GI7/C4lPlhj2ZZypnj8V9O0Os1uoHtk3MCM0FTER80sakIrd
         yhjrj6YT2WTtjLkQS/d7zLkS1Yjnrl48KxS7d7gyoOlhPj0/gM9AU8JqbLBsrYhqFh
         qiv11uvOjDvqqEE+KA70xzQehp1qF3f9x3rAsa2/ohO77MEq/QN/A1ENP9mnkv5Qf9
         PXNS4mLqUVQnvahdpjL/LswA0AAF6i8JINZgPhjjysC2zf8SBdDCzh82bViVRec3f+
         qtNxZQLavYu84XNtN9HgRwTFMILUhAoS6JNq97mTYPyb5U/eI1w2h0T+DzGFddm15r
         wQZ+KgbJVB9zw==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id y185so8937041vsy.8;
        Tue, 21 Apr 2020 10:20:21 -0700 (PDT)
X-Gm-Message-State: AGi0PuaFsLgAMF87UnfQlPLX9xee6H1KRfgi17MjRRy7BG0EGVR4kF9k
        zwsXBIRSYbv34Ww+4vi4fvLBLc22P+BT1If6oLE=
X-Google-Smtp-Source: APiQypIO/mg952cAkpo/UKnpWumkr9bju/j1AcYRzLPShWlvdpVvTkp2+164266qYKziJBhb5oWiFReVc6rLVQIOvng=
X-Received: by 2002:a67:6e07:: with SMTP id j7mr10361884vsc.181.1587489620053;
 Tue, 21 Apr 2020 10:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200421151537.19241-1-will@kernel.org> <20200421151537.19241-12-will@kernel.org>
In-Reply-To: <20200421151537.19241-12-will@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 22 Apr 2020 02:19:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNATuvjY=SKuc-otRg0zPoJZeKOoTFzdyuyY_9X78p+twxQ@mail.gmail.com>
Message-ID: <CAK7LNATuvjY=SKuc-otRg0zPoJZeKOoTFzdyuyY_9X78p+twxQ@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] gcov: Remove old GCC 3.4 support
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 12:16 AM Will Deacon <will@kernel.org> wrote:
>
> The kernel requires at least GCC 4.8 in order to build, and so there is
> no need to cater for the pre-4.7 gcov format.
>
> Remove the obsolete code.
>
> Acked-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>


Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks!


-- 
Best Regards
Masahiro Yamada
