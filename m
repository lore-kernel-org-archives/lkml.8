Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36155C4BA06
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF47D2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="fqd1L+eQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbgBYXlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:41:15 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:47655 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbgBYXlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:41:14 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48RwRq5Q7nz9sQx;
        Wed, 26 Feb 2020 10:41:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1582674071;
        bh=FNsJBHl6ehugWV1NmfKNd76Gi1uO6/w3RsA7ndAYlDg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fqd1L+eQi+c4CTAhtBIXDKBCdPC4PD29juG3AG4RdkM5xlAe/kHjqJJ5PJZ9gzuMl
         WDe/xeYeS1OODxlnjW14ZX8Zn6+7/xWyDyhhfwYmzh074eenZi5V+QgwulPPXb5M44
         +iuBJ8q1EadLbLeztAiAisZ0DNqRwQkYZj2z+8b+t3xqg0ub7qg+hpO35ngvT3cxJP
         9CHslWTlnefkYuTqSang52yEttIpwJtw5AN4IT1FPdzCHltal2ceLtmlhUQViWlJ7g
         SjsGf+gEk5qp7RnBS25WVXn/occYVomOjIfgCShDeqtgh+ySFGkB+6b9L28EKp9MY4
         Rr+SagImefekw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: error when fetching the kasan-bitops tree
In-Reply-To: <20200226080344.609a0bf8@canb.auug.org.au>
References: <20200226080344.609a0bf8@canb.auug.org.au>
Date:   Wed, 26 Feb 2020 10:41:07 +1100
Message-ID: <87o8tmz14c.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:
> Hi all,
>
> Fetching the kasan-bitops tree
> (git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git#topic/kasan-bitops)
> produces this error:
>
> fatal: couldn't find remote ref refs/heads/topic/kasan-bitops
>
> Should I just remove it?

Yes please.

It was merged a while back. Sorry I forgot you had it in linux-next.

cheers
