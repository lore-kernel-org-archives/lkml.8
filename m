Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D9AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9FED2070A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="VQCiiUvT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgAYKaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:30:22 -0500
Received: from ozlabs.org ([203.11.71.1]:60995 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgAYKaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:30:22 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 484XMZ4NFjz9sRf;
        Sat, 25 Jan 2020 21:30:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1579948220;
        bh=MKJ3akkqBDpIwlA/rrWKKg4vSQxjH3r2oaJx94GTDh4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VQCiiUvT6tJus8SFX4OLVdFgDxBSXyc6DVARZN8SVHjhs4czKyRXPHm5K72mH2yVA
         78wOtakQP0g4CsDJjkUmkA4hywWwQzsTGcCBk98zK6eU7Y48/Ld60VLu83408gG2PY
         7Ps2SZ1pn8aUakCbYQJ9Pa1NRW5iPAIMLPM9tlyV7YLBE+MZDGnMbz5LlpSxeHa0sf
         0BKCg+DsBrB7jvKLI6S8Hbq+xHcK7Y15LuT70ksyC/gM9xBoKPCY5JhPko2Gx8QYid
         iQ3cNdEKg6f7ktIziSNjpDUD7a/4uHAPGYGvx9dU6nZt3B+Kfdvi181qeTu5nf0+Xw
         udA4tJI2UaoPw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/32: Add missing context synchronisation with CONFIG_VMAP_STACK
In-Reply-To: <872477f7c7552d3bb7baf0b302398fcd42c5fcfd.1579885334.git.christophe.leroy@c-s.fr>
References: <872477f7c7552d3bb7baf0b302398fcd42c5fcfd.1579885334.git.christophe.leroy@c-s.fr>
Date:   Sat, 25 Jan 2020 21:30:14 +1100
Message-ID: <87wo9fhlqh.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> After reactivation of data translation by modifying MSR[DR], a isync
> is required to ensure the translation is effective.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
> Rebased on powerpc/merge-test
>
> @mpe: If not too late:
> - change to head_32.h should be squashed into "powerpc/32: prepare for CONFIG_VMAP_STACK"
> - change to head_32.S should be squashed into "powerpc/32s: Enable CONFIG_VMAP_STACK"

Done. Thanks.

cheers
