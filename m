Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0E8C35250
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 05:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC692051A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 05:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="E4Fhbwnp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgBJFPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 00:15:04 -0500
Received: from ozlabs.org ([203.11.71.1]:53503 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbgBJFPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 00:15:04 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48GDcQ0QD1z9sRh;
        Mon, 10 Feb 2020 16:15:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1581311702;
        bh=yzhpv6cmYCssx98FCBFW0NRxmjLDSaHLcTLAs/tkAiw=;
        h=From:To:Cc:Subject:Date:From;
        b=E4Fhbwnpy8Je0T0muvYIi74Ntr5CJ40lNmhsZmH8iYN6/ySF8IncCnbO4oDwNsH7b
         6pOG5iXd4pxacmh7I6cHkPI1rWeH3Ox8jrYkHOePL434X/HLn/lkM3T9SfCWNFxdGp
         aqHxTjO3hV6TcKUZdZRnYmcbv3D87xcfEHfVJYe8+/B412FUO4m8ar8wFdSzqK6duE
         XP+lfE+15rCNh24XvNIvdRJWAI2fMEoI6HVq5w3YxUWzmUvD/lpYngWWK/MHGsM1oc
         zAoAFcqoo+3qGgfb1nRNZO1RpvS4kY8e0ElH99T4UNZSW+DDLLOVk0QKPljb1bDGQm
         qA5TNMsMN9wfw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: install is no longer PHONY?
Date:   Mon, 10 Feb 2020 16:14:58 +1100
Message-ID: <874kvz10rx.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

I noticed that "install" seems to be no longer PHONY, or at least if I
have a file/directory called install then the build doesn't run.

eg:
  $ touch install
  $ make install
  make: 'install' is up to date.
  $ rm install
  $ make install
    LDS     arch/powerpc/boot/zImage.lds
    WRAP    arch/powerpc/boot/zImage.pseries
    WRAP    arch/powerpc/boot/zImage.epapr

In the past the presence of an install file/directory didn't have any
affect.

It seems this changed in:
  d79424137a73 ("kbuild: do not update config when running install targets")

Was that expected?

cheers
