Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20D1C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 10:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D06B2074D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 10:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="BFq6fOLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgFMKqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 06:46:48 -0400
Received: from ozlabs.org ([203.11.71.1]:39719 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgFMKqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 06:46:47 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49kZ5w30F3z9sRK;
        Sat, 13 Jun 2020 20:46:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1592045205;
        bh=C+TXIauZrJrUOan6WNfQuTL+WR9gkJUGFPXh/uGrLlw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=BFq6fOLlZD1bp+UeJIgWj7V6rrZOCFN5xO4KmX/K6nK5DHLGWYo6yc0/TXebp10pH
         haRlfxxiGBjbjt1KyQBdZfXC5633q24KvmQv9W65PlYHeyzk7ZAFTH1ry4XdQ4fU+F
         jJf0LneOpxTqNH1sz0J0P8UtapPt7oFpo/TvZ5w5xAOVDCnIcKYJAYGHAU1RzUdOAp
         q9dPbdIO689+8ZuyCjTntkjTvjfg1P2YWXwr4LUu9Plz/f+oWYnn53s3Fn5+MnSbhf
         mtaEIkof+H5iuZL1Fy2igpddeaV9ro/qD8ZRof0jB7vctPZjLfkWI8syL8jKC2+6O/
         AIXbAhH7SrVtA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Michael Ellerman <patch-notifications@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v4 1/2] powerpc/uaccess: Implement unsafe_put_user() using 'asm goto'
In-Reply-To: <CAKwvOdkKywb1KZ-SDwwuvQEmbsaAzJj9mEPqVG=qw1F5Ogv8rw@mail.gmail.com>
References: <49YBKY13Szz9sT4@ozlabs.org> <20200611224355.71174-1-ndesaulniers@google.com> <20200611235256.GL31009@gate.crashing.org> <CAKwvOdkKywb1KZ-SDwwuvQEmbsaAzJj9mEPqVG=qw1F5Ogv8rw@mail.gmail.com>
Date:   Sat, 13 Jun 2020 20:47:11 +1000
Message-ID: <87366zfdjk.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Desaulniers <ndesaulniers@google.com> writes:

> On Thu, Jun 11, 2020 at 4:53 PM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
>>
>> On Thu, Jun 11, 2020 at 03:43:55PM -0700, Nick Desaulniers wrote:
>> > Segher, Cristophe, I suspect Clang is missing support for the %L and %U
>> > output templates [1].
...
>
> IIUC the bug report correctly, it looks like LLVM is failing for the
> __put_user_asm2_goto case for -m32.  A simple reproducer:
> https://godbolt.org/z/jBBF9b

If you add `-mregnames` you get register names:

https://godbolt.org/z/MxLjhF

foo:
        stw %r3, 0(%r5)
        stw %r4, 4(%r5)
        blr


cheers
